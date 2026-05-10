(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchInterrupt_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

theory ArchInterrupt_H
imports
  RetypeDecls_H
  CNode_H
  InterruptDecls_H
  ArchInterruptDecls_H
  ArchHypervisor_H
begin

context Arch begin global_naming X64_H

defs decodeIRQControlInvocation_def:
"decodeIRQControlInvocation label args srcSlot extraCaps \<equiv>
    (let (label, args, extraCaps) = (invocationType label, args, extraCaps) in
        case (label, args, extraCaps) of
        (ArchInvocationLabel X64IRQIssueIRQHandlerIOAPIC,
        index#depth#ioapic#pin#level#polarity#irqW#_, cnode#_) =>  (doE
            rangeCheck irqW 0 (fromEnum maxUserIRQ - fromEnum minUserIRQ);
            preIrq \<leftarrow> returnOk ( fromIntegral irqW ::word8);
            irq \<leftarrow> returnOk ( toEnum (fromEnum minUserIRQ + fromIntegral preIrq) ::irq);
            irqActive \<leftarrow> withoutFailure $ isIRQActive irq;
            whenE irqActive $ throw RevokeFirst;
            destSlot \<leftarrow> lookupTargetSlot cnode (CPtr index)
                (fromIntegral depth);
            ensureEmptySlot destSlot;
            numIOAPICs \<leftarrow> withoutFailure $ gets (x64KSNumIOAPICs \<circ> ksArchState);
            whenE (numIOAPICs = 0) $ throw IllegalOperation;
            rangeCheck ioapic 0 (numIOAPICs - 1);
            rangeCheck pin 0 (ioapicIRQLines - 1);
            rangeCheck level (0::machine_word) 1;
            rangeCheck polarity (0::machine_word) 1;
            vector \<leftarrow> returnOk ( (fromIntegral $ fromEnum irq) + irqIntOffset);
            returnOk $ IssueIRQHandlerIOAPIC irq destSlot srcSlot ioapic
                pin level polarity vector
        odE)
        | (ArchInvocationLabel X64IRQIssueIRQHandlerIOAPIC, _, _) =>  throw TruncatedMessage
        | (ArchInvocationLabel X64IRQIssueIRQHandlerMSI,
        index#depth#pciBus#pciDev#pciFunc#handle#irqW#_, cnode#_) =>  (doE
            rangeCheck irqW 0 (fromEnum maxUserIRQ - fromEnum minUserIRQ);
            preIrq \<leftarrow> returnOk ( fromIntegral irqW ::word8);
            irq \<leftarrow> returnOk ( toEnum (fromEnum minUserIRQ + fromIntegral preIrq) ::irq);
            irqActive \<leftarrow> withoutFailure $ isIRQActive irq;
            whenE irqActive $ throw RevokeFirst;
            destSlot \<leftarrow> lookupTargetSlot cnode (CPtr index)
                (fromIntegral depth);
            ensureEmptySlot destSlot;
            rangeCheck pciBus 0 maxPCIBus;
            rangeCheck pciDev 0 maxPCIDev;
            rangeCheck pciFunc 0 maxPCIFunc;
            returnOk $ IssueIRQHandlerMSI irq destSlot srcSlot pciBus
                pciDev pciFunc handle
        odE)
        | (ArchInvocationLabel X64IRQIssueIRQHandlerMSI, _, _) =>  throw TruncatedMessage
        | _ =>  throw IllegalOperation
        )"

defs updateIRQState_def:
"updateIRQState irq irqState\<equiv> (do
    irqStates \<leftarrow> gets (x64KSIRQState \<circ> ksArchState);
    modify (\<lambda> s. s \<lparr> ksArchState := (ksArchState s) \<lparr> x64KSIRQState := irqStates  aLU  [(irq, irqState)]\<rparr> \<rparr>)
od)"

defs performIRQControl_def:
"performIRQControl x0\<equiv> (let inv = x0 in
  case inv of
  (IssueIRQHandlerIOAPIC irq destSlot srcSlot ioapic pin level polarity vector) =>   withoutPreemption $ (do
    doMachineOp $ ioapicMapPinToVector ioapic pin level polarity vector;
    irqState \<leftarrow> return $ X64IRQIOAPIC (ioapic && mask 5) (pin && mask 5) (level && 1) (polarity && 1) True;
    updateIRQState (IRQ irq) irqState;
    setIRQState IRQSignal (IRQ irq);
    cteInsert (IRQHandlerCap (IRQ irq)) srcSlot destSlot;
    return ()
  od)
  | (IssueIRQHandlerMSI irq destSlot srcSlot pciBus pciDev pciFunc handle) =>   withoutPreemption $ (do
    irqState \<leftarrow> return $ X64IRQMSI (pciBus && mask 8) (pciDev && mask 5) (pciFunc && mask 3) (handle && mask 32);
    updateIRQState (IRQ irq) irqState;
    setIRQState IRQSignal (IRQ irq);
    cteInsert (IRQHandlerCap (IRQ irq)) srcSlot destSlot;
    return ()
  od)
  )"

defs invokeIRQHandler_def:
"invokeIRQHandler x0\<equiv> (case x0 of
    (AckIRQ irq) \<Rightarrow>    doMachineOp $ maskInterrupt False irq
  | _ \<Rightarrow>    return ()
  )"

defs maskIrqSignal_def:
"maskIrqSignal irq \<equiv> doMachineOp $ maskInterrupt True irq"

defs checkIRQ_def:
"checkIRQ irq \<equiv> throw IllegalOperation"

defs handleReservedIRQ_def:
"handleReservedIRQ arg1 \<equiv> return ()"

defs initInterruptController_def:
"initInterruptController\<equiv> return ()"


end

end
