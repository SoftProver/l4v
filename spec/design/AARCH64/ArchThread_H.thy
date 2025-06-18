(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchThread_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Threads"

theory ArchThread_H
imports
  ArchThreadDecls_H
  TCBDecls_H
  ArchVSpaceDecls_H
  ArchHypervisor_H
begin

context Arch begin global_naming AARCH64_H

defs switchToThread_def:
"switchToThread tcb\<equiv> (do
    tcbobj \<leftarrow> getObject tcb;
    vcpuSwitch (atcbVCPUPtr $ tcbArch tcbobj);
    setVMRoot tcb
od)"

defs configureIdleThread_def:
"configureIdleThread arg1 \<equiv> error []"

defs switchToIdleThread_def:
"switchToIdleThread\<equiv> (do
    vcpuSwitch Nothing;
    setGlobalUserVSpace
od)"

defs activateIdleThread_def:
"activateIdleThread arg1 \<equiv> return ()"


end (* context AARCH64 *)

end
