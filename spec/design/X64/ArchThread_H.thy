(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchThread_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Threads"

theory ArchThread_H
imports
  ArchThreadDecls_H
  TCBDecls_H
  ArchVSpaceDecls_H
begin


context Arch begin global_naming X64_H

defs switchToThread_def:
"switchToThread tcb \<equiv> setVMRoot tcb"

defs configureIdleThread_def:
"configureIdleThread arg1 \<equiv> error []"

defs switchToIdleThread_def:
"switchToIdleThread\<equiv> (do
    t \<leftarrow> getIdleThread;
    setVMRoot t
od)"

defs activateIdleThread_def:
"activateIdleThread arg1 \<equiv> return ()"


end (* context X64 *)

end
