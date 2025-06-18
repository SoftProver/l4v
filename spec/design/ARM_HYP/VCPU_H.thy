(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file VCPU_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "VCPU"

theory VCPU_H
imports
  Hardware_H
  Structures_H
  Invocations_H
  TCB_H
begin
context Arch begin global_naming ARM_HYP_H

definition
decodeVCPUSetTCB :: "arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , Arch.invocation ) kernel_f"
where
"decodeVCPUSetTCB x0 extraCaps\<equiv> (let cap = x0 in
  if isVCPUCap cap then   (doE
    whenE (null extraCaps) $ throw TruncatedMessage;
    tcbPtr \<leftarrow> (case fst (head extraCaps) of
          ThreadCap tcbPtr \<Rightarrow>   returnOk tcbPtr
        | _ \<Rightarrow>   throw IllegalOperation
        );
    returnOk $ InvokeVCPU $ VCPUSetTCB (capVCPUPtr cap) tcbPtr
  odE)
  else   throw IllegalOperation
  )"

definition
dissociateVCPUTCB :: "machine_word \<Rightarrow> machine_word \<Rightarrow> unit kernel"
where
"dissociateVCPUTCB vcpuPtr tcbPtr\<equiv> (do
    tcbVCPU \<leftarrow> archThreadGet atcbVCPUPtr tcbPtr;
    vcpu \<leftarrow> getObject vcpuPtr;
    vcpuTCB \<leftarrow> return ( vcpuTCBPtr vcpu);
    when (tcbVCPU \<noteq> Just vcpuPtr \<or> vcpuTCB \<noteq> Just tcbPtr) $
        haskell_fail [];
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    (case hsCurVCPU of
          Some (curVCPU, _) \<Rightarrow>   when (curVCPU = vcpuPtr) vcpuInvalidateActive
        | _ \<Rightarrow>   return ()
        );
    archThreadSet (\<lambda> atcb. atcb \<lparr> atcbVCPUPtr := Nothing \<rparr>) tcbPtr;
    setObject vcpuPtr $ vcpu \<lparr> vcpuTCBPtr := Nothing \<rparr>;
    asUser tcbPtr $ ((do
        cpsr \<leftarrow> getRegister (Register CPSR);
        setRegister (Register CPSR) $ sanitiseRegister False (Register CPSR) cpsr
    od)
        )
od)"

definition
associateVCPUTCB :: "machine_word \<Rightarrow> machine_word \<Rightarrow> machine_word list kernel"
where
"associateVCPUTCB vcpuPtr tcbPtr\<equiv> (do
    tcbVCPU \<leftarrow> archThreadGet atcbVCPUPtr tcbPtr;
    (case tcbVCPU of
        Some ptr \<Rightarrow>   dissociateVCPUTCB ptr tcbPtr
      | _ \<Rightarrow>   return ()
      );
    vcpu \<leftarrow> getObject vcpuPtr;
    (case (vcpuTCBPtr vcpu) of
          Some ptr \<Rightarrow>   dissociateVCPUTCB vcpuPtr ptr
        | _ \<Rightarrow>   return ()
        );
    archThreadSet (\<lambda> atcb. atcb \<lparr> atcbVCPUPtr := Just vcpuPtr \<rparr>) tcbPtr;
    setObject vcpuPtr $ vcpu \<lparr> vcpuTCBPtr := Just tcbPtr \<rparr>;
    ct \<leftarrow> getCurThread;
    when (tcbPtr = ct) $ vcpuSwitch (Just vcpuPtr);
    return []
od)"

definition
decodeVCPUReadReg :: "machine_word list \<Rightarrow> arch_capability \<Rightarrow> ( syscall_error , Arch.invocation ) kernel_f"
where
"decodeVCPUReadReg x0 x1\<equiv> (let (ls, cap) = (x0, x1) in
  if isVCPUCap cap \<and> length ls > 0
  then let field = ls ! 0 in   (doE
    reg \<leftarrow> returnOk ( fromIntegral field);
    whenE (reg > (fromEnum (maxBound ::vcpureg))) $ throw (InvalidArgument 1);
    returnOk $ InvokeVCPU $
        VCPUReadRegister (capVCPUPtr cap) (toEnum reg)
  odE)
  else   throw TruncatedMessage
  )"

definition
decodeVCPUWriteReg :: "machine_word list \<Rightarrow> arch_capability \<Rightarrow> ( syscall_error , Arch.invocation ) kernel_f"
where
"decodeVCPUWriteReg x0 x1\<equiv> (let (ls, cap) = (x0, x1) in
  if isVCPUCap cap \<and> length ls > 1
  then let field = ls ! 0; val = ls ! 1
  in   (doE
    reg \<leftarrow> returnOk ( fromIntegral field);
    whenE (reg > (fromEnum (maxBound ::vcpureg))) $ throw (InvalidArgument 1);
    returnOk $ InvokeVCPU $ VCPUWriteRegister (capVCPUPtr cap)
                (toEnum reg) (fromIntegral val)
  odE)
  else   throw TruncatedMessage
  )"

definition
readVCPUReg :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> hyper_reg_val kernel"
where
"readVCPUReg vcpuPtr reg\<equiv> (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    (onCurVCPU, active) \<leftarrow> return $ (case hsCurVCPU of
          Some (curVCPU, a) \<Rightarrow>   (curVCPU = vcpuPtr, a)
        | _ \<Rightarrow>   (False, False)
        );
    if onCurVCPU
        then if vcpuRegSavedWhenDisabled reg \<and> Not active
                then vcpuReadReg vcpuPtr reg
                else doMachineOp $ readVCPUHardwareReg reg
        else vcpuReadReg vcpuPtr reg
od)"

definition
writeVCPUReg :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> hyper_reg_val \<Rightarrow> unit kernel"
where
"writeVCPUReg vcpuPtr reg val\<equiv> (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    (onCurVCPU, active) \<leftarrow> return $ (case hsCurVCPU of
          Some (curVCPU, a) \<Rightarrow>   (curVCPU = vcpuPtr, a)
        | _ \<Rightarrow>   (False, False)
        );
    if onCurVCPU
        then if vcpuRegSavedWhenDisabled reg \<and> Not active
                then vcpuWriteReg vcpuPtr reg val
                else doMachineOp $ writeVCPUHardwareReg reg val
        else vcpuWriteReg vcpuPtr reg val
od)"

definition
invokeVCPUReadReg :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> machine_word list kernel"
where
"invokeVCPUReadReg vcpuPtr reg\<equiv> (do
    ct \<leftarrow> getCurThread;
    val \<leftarrow> readVCPUReg vcpuPtr reg;
    return [val]
od)"

definition
invokeVCPUWriteReg :: "machine_word \<Rightarrow> hyper_reg \<Rightarrow> hyper_reg_val \<Rightarrow> machine_word list kernel"
where
"invokeVCPUWriteReg vcpuPtr reg val\<equiv> (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    writeVCPUReg vcpuPtr reg val;
    return []
od)"

definition
makeVIRQ :: "machine_word \<Rightarrow> machine_word \<Rightarrow> machine_word \<Rightarrow> virq"
where
"makeVIRQ grp prio irq \<equiv>
    let
     groupShift = 30;
          prioShift = 23;
          irqPending = bit 28;
          eoiirqen = bit 19
    in
    ((grp && 1) `~shiftL~` groupShift) || ((prio && 0x1F) `~shiftL~` prioShift) || (irq && 0x3FF) ||
        irqPending || eoiirqen"

definition
virqType :: "machine_word \<Rightarrow> nat"
where
"virqType virq\<equiv> fromIntegral $ (virq `~shiftR~` 28) && 3"

definition
decodeVCPUInjectIRQ :: "machine_word list \<Rightarrow> arch_capability \<Rightarrow> ( syscall_error , Arch.invocation ) kernel_f"
where
"decodeVCPUInjectIRQ x0 x1\<equiv> (let (ls, cap) = (x0, x1) in
  if isVCPUCap cap \<and> length ls > 1
  then let mr0 = ls ! 0; mr1 = ls ! 1
  in   (doE
    vcpuPtr \<leftarrow> returnOk ( capVCPUPtr cap);
    vid \<leftarrow> returnOk ( mr0 && 0xffff);
    priority \<leftarrow> returnOk ( (mr0 `~shiftR~` 16) && 0xff);
    grp \<leftarrow> returnOk ( (mr0 `~shiftR~` 24) && 0xff);
    index \<leftarrow> returnOk ( mr1 && 0xff);
    rangeCheck vid (0::nat) ((1 `~shiftL~` 10) - 1);
    rangeCheck priority (0::nat) 31;
    rangeCheck grp (0::nat) 1;
    gic_vcpu_num_list_regs \<leftarrow> withoutFailure $
        gets (armKSGICVCPUNumListRegs \<circ> ksArchState);
    whenE (index \<ge> fromIntegral gic_vcpu_num_list_regs) $
       (throw $ RangeError 0 (fromIntegral gic_vcpu_num_list_regs - 1));
    vcpuLR \<leftarrow> withoutFailure $ liftM (vgicLR \<circ> vcpuVGIC) $ getObject vcpuPtr;
    whenE (vcpuLR (fromIntegral index) && vgicIRQMask = vgicIRQActive) $
        throw DeleteFirst;
    virq \<leftarrow> returnOk ( makeVIRQ (fromIntegral grp) (fromIntegral priority) (fromIntegral vid));
    returnOk $ InvokeVCPU $ VCPUInjectIRQ vcpuPtr (fromIntegral index) virq
  odE)
  else   throw TruncatedMessage
  )"

definition
invokeVCPUInjectIRQ :: "machine_word \<Rightarrow> nat \<Rightarrow> virq \<Rightarrow> machine_word list kernel"
where
"invokeVCPUInjectIRQ vcpuPtr index virq\<equiv> (do
    hsCurVCPU \<leftarrow> gets (armHSCurVCPU \<circ> ksArchState);
    if (isJust hsCurVCPU \<and> fst (fromJust hsCurVCPU) = vcpuPtr)
      then doMachineOp $ set_gic_vcpu_ctrl_lr (fromIntegral index) virq
      else vgicUpdateLR vcpuPtr index virq;
    return []
od)"

definition
decodeVCPUAckVPPI :: "machine_word list \<Rightarrow> arch_capability \<Rightarrow> ( syscall_error , Arch.invocation ) kernel_f"
where
"decodeVCPUAckVPPI x0 x1\<equiv> (let (ls, cap) = (x0, x1) in
  if isVCPUCap cap \<and> length ls > 0
  then let mr0 = ls ! 0
  in   (doE
    vcpuPtr \<leftarrow> returnOk ( capVCPUPtr cap);
    rangeCheck mr0 (fromEnum minIRQ) (fromEnum maxIRQ);
    irq \<leftarrow> returnOk ( toEnum (fromIntegral mr0) ::irq);
    (case irqVPPIEventIndex irq of
          None \<Rightarrow>   throw $ InvalidArgument 0
        | Some vppi \<Rightarrow>   returnOk $ InvokeVCPU $ VCPUAckVPPI vcpuPtr vppi
        )
  odE)
  else   throw TruncatedMessage
  )"

definition
invokeVCPUAckVPPI :: "machine_word \<Rightarrow> vppievent_irq \<Rightarrow> machine_word list kernel"
where
"invokeVCPUAckVPPI vcpuPtr vppi \<equiv>
    let
     f = (\<lambda> masked. masked  aLU  [(vppi, False)])
    in
                                        (do
    vcpuUpdate vcpuPtr (\<lambda> vcpu. vcpu \<lparr> vcpuVPPIMasked := f (vcpuVPPIMasked vcpu) \<rparr>);
    return []
                                        od)"

definition
performARMVCPUInvocation :: "vcpuinvocation \<Rightarrow> machine_word list kernel"
where
"performARMVCPUInvocation x0\<equiv> (case x0 of
    (VCPUSetTCB vcpuPtr tcbPtr) \<Rightarrow>   
    associateVCPUTCB vcpuPtr tcbPtr
  | (VCPUReadRegister vcpuPtr reg) \<Rightarrow>   
    invokeVCPUReadReg vcpuPtr reg
  | (VCPUWriteRegister vcpuPtr reg val) \<Rightarrow>   
    invokeVCPUWriteReg vcpuPtr reg val
  | (VCPUInjectIRQ vcpuPtr index virq) \<Rightarrow>   
    invokeVCPUInjectIRQ vcpuPtr index virq
  | (VCPUAckVPPI vcpuPtr vppi) \<Rightarrow>   
    invokeVCPUAckVPPI vcpuPtr vppi
  )"

definition
decodeARMVCPUInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> cptr \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , Arch.invocation ) kernel_f"
where
"decodeARMVCPUInvocation label args capIndex slot x4 extraCaps\<equiv> (let cap = x4 in
  if isVCPUCap cap then  
    (case invocationType label of
          ArchInvocationLabel ARMVCPUSetTCB \<Rightarrow>  
            decodeVCPUSetTCB cap extraCaps
        | ArchInvocationLabel ARMVCPUReadReg \<Rightarrow>  
            decodeVCPUReadReg args cap
        | ArchInvocationLabel ARMVCPUWriteReg \<Rightarrow>  
            decodeVCPUWriteReg args cap
        | ArchInvocationLabel ARMVCPUInjectIRQ \<Rightarrow>  
            decodeVCPUInjectIRQ args cap
        | ArchInvocationLabel ARMVCPUAckVPPI \<Rightarrow>  
            decodeVCPUAckVPPI args cap
        | _ \<Rightarrow>   throw IllegalOperation
        )
  else   throw IllegalOperation
  )"

definition
vcpuFinalise :: "machine_word \<Rightarrow> unit kernel"
where
"vcpuFinalise vcpuPtr\<equiv> (do
    vcpu \<leftarrow> getObject vcpuPtr;
    (case vcpuTCBPtr vcpu of
          Some tcbPtr \<Rightarrow>   dissociateVCPUTCB vcpuPtr tcbPtr
        | None \<Rightarrow>   return ()
        )
od)"


end
end
