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

context Arch begin global_naming AARCH64_H

defs decodeIRQControlInvocation_def:
"decodeIRQControlInvocation label args srcSlot extraCaps \<equiv>
    (let (label, args, extraCaps) = (invocationType label, args, extraCaps) in
        case (label, args, extraCaps) of
        (ArchInvocationLabel ARMIRQIssueIRQHandlerTrigger,
        irqW#triggerW#index#depth#_, cnode#_) =>  (doE
            checkIRQ irqW;
            irq \<leftarrow> returnOk ( toEnum (fromIntegral irqW) ::irq);
            irqActive \<leftarrow> withoutFailure $ isIRQActive irq;
            whenE irqActive $ throw RevokeFirst;
            destSlot \<leftarrow> lookupTargetSlot cnode
                (CPtr index) (fromIntegral depth);
            ensureEmptySlot destSlot;
            returnOk $
                IssueIRQHandler irq destSlot srcSlot (triggerW \<noteq> 0)
        odE)
        | (ArchInvocationLabel ARMIRQIssueIRQHandlerTrigger, _, _) => 
            throw TruncatedMessage
        | _ =>  throw IllegalOperation
        )"

defs performIRQControl_def:
"performIRQControl x0\<equiv> (case x0 of 
  IssueIRQHandler irq destSlot srcSlot trigger =>   withoutPreemption $ (do
    doMachineOp $ setIRQTrigger irq trigger;
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

defs handleReservedIRQ_def:
"handleReservedIRQ irq\<equiv> (do
    when (fromEnum irq = fromEnum irqVGICMaintenance) vgicMaintenance;
    when (irqVPPIEventIndex irq \<noteq> Nothing) $ vppiEvent irq;
    return ()
od)"

defs maskIrqSignal_def:
"maskIrqSignal irq \<equiv> doMachineOp $ maskInterrupt True irq"

defs initInterruptController_def:
"initInterruptController \<equiv> error []"

defs checkIRQ_def:
"checkIRQ irq\<equiv> rangeCheck irq (fromEnum minIRQ) (fromEnum maxIRQ)"


end

end
