(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchInterruptDecls_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

theory ArchInterruptDecls_H
imports RetypeDecls_H CNode_H
begin

context Arch begin global_naming X64_H

consts'
decodeIRQControlInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> machine_word \<Rightarrow> capability list \<Rightarrow> ( syscall_error , irqcontrol_invocation ) kernel_f"

consts'
updateIRQState :: "irq \<Rightarrow> x64irqstate \<Rightarrow> unit kernel"

consts'
performIRQControl :: "irqcontrol_invocation \<Rightarrow> unit kernel_p"

consts'
invokeIRQHandler :: "irqhandler_invocation \<Rightarrow> unit kernel"

consts'
maskIrqSignal :: "irq \<Rightarrow> unit kernel"

consts'
checkIRQ :: "machine_word \<Rightarrow> ( syscall_error , unit ) kernel_f"

consts'
handleReservedIRQ :: "irq \<Rightarrow> unit kernel"

consts'
initInterruptController :: "unit kernel"


end (* context X64 *)

end
