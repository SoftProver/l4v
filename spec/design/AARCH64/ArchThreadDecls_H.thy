(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchThreadDecls_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
    Declarations from SEL4.Kernel.Thread.
*)

chapter "Function Declarations for Threads"

theory ArchThreadDecls_H
imports
  Structures_H
  FaultMonad_H
  KernelInitMonad_H
begin

context Arch begin global_naming AARCH64_H

consts'
switchToThread :: "machine_word \<Rightarrow> unit kernel"

consts'
configureIdleThread :: "machine_word \<Rightarrow> unit kernel_init"

consts'
switchToIdleThread :: "unit kernel"

consts'
activateIdleThread :: "machine_word \<Rightarrow> unit kernel"


end (* context AARCH64 *)

end
