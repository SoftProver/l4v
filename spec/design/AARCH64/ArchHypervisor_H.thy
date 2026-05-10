(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchHypervisor_H.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
  Hypervisor function definitions for AARCH64
*)

theory ArchHypervisor_H
imports
  CNode_H
  FaultHandlerDecls_H
  InterruptDecls_H
begin
context Arch begin global_naming AARCH64_H

consts'
irqVPPIEventIndex :: "irq \<Rightarrow> vppievent_irq option"

defs irqVPPIEventIndex_def:
"irqVPPIEventIndex irq \<equiv>
    if irq = IRQ irqVTimerEvent then Just VPPIEventIRQ_VTimer
                                 else Nothing"

definition
curVCPUActive :: "bool kernel"
where
"curVCPUActive\<equiv> (do
    vcpu \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    return $ isJust vcpu \<and> snd (fromJust vcpu)
od)"

definition
vcpuUpdate :: "machine_word \<Rightarrow> (vcpu \<Rightarrow> vcpu) \<Rightarrow> unit kernel"
where
"vcpuUpdate vcpuPtr f\<equiv> (do
    vcpu \<leftarrow> getObject vcpuPtr;
    setObject vcpuPtr (f vcpu)
od)"

definition
vgicUpdate :: "machine_word \<Rightarrow> (gicvcpuinterface \<Rightarrow> gicvcpuinterface) \<Rightarrow> unit kernel"
where
"vgicUpdate vcpuPtr f\<equiv> vcpuUpdate vcpuPtr (\<lambda> vcpu. vcpu \<lparr> vcpuVGIC := f (vcpuVGIC vcpu) \<rparr>)"

definition
vgicUpdateLR :: "machine_word \<Rightarrow> nat \<Rightarrow> virq \<Rightarrow> unit kernel"
where
"vgicUpdateLR vcpuPtr irq_idx virq \<equiv>
    vgicUpdate vcpuPtr (\<lambda> vgic. vgic \<lparr> vgicLR := (vgicLR vgic)  aLU  [(irq_idx, virq)] \<rparr>)"

definition
vcpuSaveReg :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> unit kernel"
where
"vcpuSaveReg vcpuPtr reg\<equiv> (do
    haskell_assert (vcpuPtr \<noteq> 0) [];
    val \<leftarrow> doMachineOp $ readVCPUHardwareReg reg;
    vcpuUpdate vcpuPtr (\<lambda> vcpu. vcpu \<lparr> vcpuRegs :=  vcpuRegs vcpu  aLU  [(reg, val)] \<rparr>)
od)"

definition
vcpuSaveRegRange :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> hyper_reg \<Rightarrow> unit kernel"
where
"vcpuSaveRegRange vcpuPtr regStart regEnd \<equiv>
    mapM_x (\<lambda> reg. vcpuSaveReg vcpuPtr reg) [regStart  .e.  regEnd]"

definition
vcpuRestoreReg :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> unit kernel"
where
"vcpuRestoreReg vcpuPtr reg\<equiv> (do
    haskell_assert (vcpuPtr \<noteq> 0) [];
    vcpu \<leftarrow> getObject vcpuPtr;
    doMachineOp $ writeVCPUHardwareReg reg (vcpuRegs vcpu reg)
od)"

definition
vcpuRestoreRegRange :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> hyper_reg \<Rightarrow> unit kernel"
where
"vcpuRestoreRegRange vcpuPtr regStart regEnd \<equiv>
    mapM_x (\<lambda> reg. vcpuRestoreReg vcpuPtr reg) [regStart  .e.  regEnd]"

definition
vcpuReadReg :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> hyper_reg_val kernel"
where
"vcpuReadReg vcpuPtr reg\<equiv> (do
    haskell_assert (vcpuPtr \<noteq> 0) [];
    vcpu \<leftarrow> getObject vcpuPtr;
    return $ vcpuRegs vcpu reg
od)"

definition
vcpuWriteReg :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> hyper_reg_val \<Rightarrow> unit kernel"
where
"vcpuWriteReg vcpuPtr reg val\<equiv> (do
    haskell_assert (vcpuPtr \<noteq> 0) [];
    vcpuUpdate vcpuPtr (\<lambda> vcpu. vcpu \<lparr> vcpuRegs := vcpuRegs vcpu  aLU  [(reg, val)] \<rparr>)
od)"

definition
virqType :: "machine_word \<Rightarrow> nat"
where
"virqType virq\<equiv> fromIntegral $ (virq `~shiftR~` 28) && 3"

definition
virqSetEOIIRQEN :: "virq \<Rightarrow> machine_word \<Rightarrow> virq"
where
"virqSetEOIIRQEN virq v \<equiv>
    if virqType virq = 3
    then virq
    else (virq && complement 0x80000) || ((v `~shiftL~` 19) && 0x80000)"

definition
saveVirtTimer :: "machine_word \<Rightarrow> unit kernel"
where
"saveVirtTimer vcpuPtr\<equiv> (do
    vcpuSaveReg vcpuPtr VCPURegCNTV_CTL;
    doMachineOp $ writeVCPUHardwareReg VCPURegCNTV_CTL 0;
    vcpuSaveReg vcpuPtr VCPURegCNTV_CVAL;
    vcpuSaveReg vcpuPtr VCPURegCNTVOFF;
    vcpuSaveReg vcpuPtr VCPURegCNTKCTL_EL1;
    doMachineOp check_export_arch_timer;
    cntpct \<leftarrow> doMachineOp read_cntpct;
    vcpuUpdate vcpuPtr (\<lambda> vcpu. vcpu \<lparr> vcpuVTimer := VirtTimer cntpct \<rparr>)
od)"

definition
restoreVirtTimer :: "machine_word \<Rightarrow> unit kernel"
where
"restoreVirtTimer vcpuPtr\<equiv> (do
    vcpuRestoreReg vcpuPtr VCPURegCNTV_CVAL;
    vcpuRestoreReg vcpuPtr VCPURegCNTKCTL_EL1;
    current_cntpct \<leftarrow> doMachineOp read_cntpct;
    vcpu \<leftarrow> getObject vcpuPtr;
    lastPCount \<leftarrow> return (  vtimerLastPCount (vcpuVTimer vcpu));
    pcountDelta \<leftarrow> return ( current_cntpct - lastPCount);
    cntvoff \<leftarrow> vcpuReadReg vcpuPtr VCPURegCNTVOFF;
    offset \<leftarrow> return ( cntvoff + fromIntegral pcountDelta);
    vcpuWriteReg vcpuPtr VCPURegCNTVOFF offset;
    vcpuRestoreReg vcpuPtr VCPURegCNTVOFF;
    vppi \<leftarrow> return ( fromJust $ irqVPPIEventIndex (IRQ irqVTimerEvent));
    masked \<leftarrow> return ( (vcpuVPPIMasked vcpu) vppi);
    safeToUnmask \<leftarrow> isIRQActive (IRQ irqVTimerEvent);
    when safeToUnmask $ doMachineOp $ maskInterrupt masked (IRQ irqVTimerEvent);
    vcpuRestoreReg vcpuPtr VCPURegCNTV_CTL
od)"

definition
vcpuEnable :: "machine_word \<Rightarrow> unit kernel"
where
"vcpuEnable vcpuPtr\<equiv> (do
    vcpuRestoreReg vcpuPtr VCPURegSCTLR;
    vcpu \<leftarrow> getObject vcpuPtr;
    doMachineOp $ (do
        setHCR hcrVCPU;
        isb;
        set_gic_vcpu_ctrl_hcr (vgicHCR \<circ> vcpuVGIC $ vcpu)
    od);
    vcpuRestoreReg vcpuPtr VCPURegCPACR;
    restoreVirtTimer vcpuPtr
od)"

definition
vcpuDisable :: "(machine_word) option \<Rightarrow> unit kernel"
where
"vcpuDisable vcpuPtrOpt\<equiv> (do
    doMachineOp dsb;
    (case vcpuPtrOpt of
          Some vcpuPtr \<Rightarrow>   (do
           hcr \<leftarrow> doMachineOp get_gic_vcpu_ctrl_hcr;
           vgicUpdate vcpuPtr (\<lambda> vgic. vgic \<lparr> vgicHCR := hcr \<rparr>);
           vcpuSaveReg vcpuPtr VCPURegSCTLR;
           vcpuSaveReg vcpuPtr VCPURegCPACR;
           doMachineOp isb
          od)
        | None \<Rightarrow>   return ()
        );
    doMachineOp $ (do
        set_gic_vcpu_ctrl_hcr 0;
        isb;
        setSCTLR sctlrDefault;
        isb;
        setHCR hcrNative;
        isb;
        enableFpuEL01
    od);
    (case vcpuPtrOpt of
          Some vcpuPtr \<Rightarrow>   (do
            saveVirtTimer vcpuPtr;
            doMachineOp $ maskInterrupt True (IRQ irqVTimerEvent)
          od)
        | None \<Rightarrow>   return ()
        )
od)"

definition
armvVCPUSave :: "machine_word \<Rightarrow> bool \<Rightarrow> unit kernel"
where
"armvVCPUSave vcpuPtr active\<equiv> (do
    vcpuSaveRegRange vcpuPtr VCPURegTTBR0 VCPURegSPSR_EL1;
    doMachineOp isb
od)"

definition
vcpuSave :: "(machine_word * bool) option \<Rightarrow> unit kernel"
where
"vcpuSave x0\<equiv> (case x0 of
    (Some (vcpuPtr, active)) \<Rightarrow>    (do
    doMachineOp dsb;
    when active $ (do
          vcpuSaveReg vcpuPtr VCPURegSCTLR;
          hcr \<leftarrow> doMachineOp get_gic_vcpu_ctrl_hcr;
          vgicUpdate vcpuPtr (\<lambda> vgic. vgic \<lparr> vgicHCR := hcr \<rparr>);
          saveVirtTimer vcpuPtr
    od);
    vmcr \<leftarrow> doMachineOp get_gic_vcpu_ctrl_vmcr;
    vgicUpdate vcpuPtr (\<lambda> vgic. vgic \<lparr> vgicVMCR := vmcr \<rparr>);
    apr \<leftarrow> doMachineOp get_gic_vcpu_ctrl_apr;
    vgicUpdate vcpuPtr (\<lambda> vgic. vgic \<lparr> vgicAPR := apr \<rparr>);
    numListRegs \<leftarrow> gets (armKSGICVCPUNumListRegs \<circ> ksArchState);
    gicIndices \<leftarrow> return ( init [0 .e. numListRegs]);
    mapM_x (\<lambda> vreg. (do
          val \<leftarrow> doMachineOp $ get_gic_vcpu_ctrl_lr (fromIntegral vreg);
          vgicUpdateLR vcpuPtr (fromIntegral vreg) (fromIntegral val)
    od)
                                                                     ) gicIndices;
    armvVCPUSave vcpuPtr active
    od)
  | _ \<Rightarrow>    haskell_fail []
  )"

definition
vcpuRestore :: "machine_word \<Rightarrow> unit kernel"
where
"vcpuRestore vcpuPtr\<equiv> (do
    doMachineOp $ set_gic_vcpu_ctrl_hcr 0;
    doMachineOp $ isb;
    vcpu \<leftarrow> getObject vcpuPtr;
    vgic \<leftarrow> return ( vcpuVGIC vcpu);
    numListRegs \<leftarrow> gets (armKSGICVCPUNumListRegs \<circ> ksArchState);
    gicIndices \<leftarrow> return ( init [0 .e. numListRegs]);
    doMachineOp $ (do
        set_gic_vcpu_ctrl_vmcr (vgicVMCR vgic);
        set_gic_vcpu_ctrl_apr (vgicAPR vgic);
        mapM_x (uncurry set_gic_vcpu_ctrl_lr) (map (\<lambda> i. (fromIntegral i, (vgicLR vgic) i)) gicIndices)
    od);
    vcpuRestoreRegRange vcpuPtr VCPURegTTBR0 VCPURegSPSR_EL1;
    vcpuEnable vcpuPtr
od)"

definition
vcpuInvalidateActive :: "unit kernel"
where
"vcpuInvalidateActive\<equiv> (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    (case hsCurVCPU of
          Some (vcpuPtr, True) \<Rightarrow>   vcpuDisable Nothing
        | _ \<Rightarrow>   return ()
        );
    modifyArchState (\<lambda> s. s \<lparr> armHSCurVCPU := Nothing \<rparr>)
od)"

definition
vcpuSwitch :: "(machine_word) option \<Rightarrow> unit kernel"
where
"vcpuSwitch x0\<equiv> (case x0 of
    None \<Rightarrow>    (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    (case hsCurVCPU of
          None \<Rightarrow>   return ()
        | Some (vcpuPtr, active) \<Rightarrow>   (do
            when active $ (do
                vcpuDisable (Just vcpuPtr);
                modifyArchState (\<lambda> s. s \<lparr> armHSCurVCPU := Just (vcpuPtr, False) \<rparr>)
            od);
            return ()
        od)
        )
    od)
  | (Some new) \<Rightarrow>    (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    (case hsCurVCPU of
          None \<Rightarrow>   (do
            vcpuRestore new;
            modifyArchState (\<lambda> s. s \<lparr> armHSCurVCPU := Just (new, True) \<rparr>)
          od)
        | Some (vcpuPtr, active) \<Rightarrow>   (
            if vcpuPtr \<noteq> new
                then (do
                    vcpuSave hsCurVCPU;
                    vcpuRestore new;
                    modifyArchState (\<lambda> s. s \<lparr> armHSCurVCPU := Just (new, True) \<rparr>)
                od)
                else (
                    when (Not active) $ (do
                        doMachineOp isb;
                        vcpuEnable new;
                        modifyArchState (\<lambda> s. s \<lparr> armHSCurVCPU := Just (new, True) \<rparr>)
                    od)
                )
        )
        )
  od)
  )"

definition
vgicMaintenance :: "unit kernel"
where
"vgicMaintenance \<equiv>
    let
        irqIndex = (\<lambda>  eisr0 eisr1.
            if eisr0 \<noteq> 0 then countTrailingZeros eisr0
                          else (countTrailingZeros eisr1) + 32);
        setIndex = (\<lambda>  vcpuPtr irq_idx. ((do
                virq \<leftarrow> doMachineOp $ get_gic_vcpu_ctrl_lr (fromIntegral irq_idx);
                virqen \<leftarrow> return $ virqSetEOIIRQEN virq 0;
                doMachineOp $ set_gic_vcpu_ctrl_lr (fromIntegral irq_idx) virqen;
                vgicUpdateLR vcpuPtr irq_idx virqen
        od)
                ))
    in
                         (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    (case hsCurVCPU of
          Some (vcpuPtr, True) \<Rightarrow>   (do
            eisr0 \<leftarrow> doMachineOp $ get_gic_vcpu_ctrl_eisr0;
            eisr1 \<leftarrow> doMachineOp $ get_gic_vcpu_ctrl_eisr1;
            flags \<leftarrow> doMachineOp $ get_gic_vcpu_ctrl_misr;
            vgic_misr_eoi \<leftarrow> return ( vgicHCREN);
            irq_idx \<leftarrow> return ( irqIndex eisr0 eisr1);
            gic_vcpu_num_list_regs \<leftarrow> gets (armKSGICVCPUNumListRegs \<circ> ksArchState);
            fault \<leftarrow>
                if (flags && vgic_misr_eoi \<noteq> 0)
                then
                    if (eisr0 = 0 \<and> eisr1 = 0 \<or>
                        irq_idx \<ge> gic_vcpu_num_list_regs)
                        then return $ VGICMaintenance Nothing
                        else ((do
                            setIndex vcpuPtr irq_idx;
                            return $ VGICMaintenance $ Just $ fromIntegral irq_idx
                        od)
                            )
                else return $ VGICMaintenance Nothing;
            curThread \<leftarrow> getCurThread;
            runnable \<leftarrow> isRunnable curThread;
            when runnable $ handleFault curThread $ ArchFault fault
          od)
        | _ \<Rightarrow>   return ()
        )
                         od)"

definition
vppiEvent :: "irq \<Rightarrow> unit kernel"
where
"vppiEvent irq\<equiv> (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    (case hsCurVCPU of
          Some (vcpuPtr, True) \<Rightarrow>   (do
            doMachineOp $ maskInterrupt True irq;
            vppi \<leftarrow> return ( fromJust $ irqVPPIEventIndex irq);
            vcpuUpdate vcpuPtr
                       (\<lambda> vcpu. vcpu\<lparr> vcpuVPPIMasked := vcpuVPPIMasked vcpu  aLU  [(vppi, True)] \<rparr>);
            curThread \<leftarrow> getCurThread;
            runnable \<leftarrow> isRunnable curThread;
            when runnable $ handleFault curThread $ ArchFault $ VPPIEvent irq
          od)
        | _ \<Rightarrow>   return ()
        )
od)"


consts'
handleHypervisorFault :: "machine_word \<Rightarrow> hyp_fault_type \<Rightarrow> unit kernel"

defs handleHypervisorFault_def:
"handleHypervisorFault thread x1\<equiv> (case x1 of
    (ARMVCPUFault hsr) \<Rightarrow>    (
    handleFault thread (ArchFault $ VCPUFault $ fromIntegral hsr)
    )
  )"


end
end
