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
  ArchHypervisor_H
begin
context Arch begin global_naming ARM_HYP_H

defs switchToThread_def:
"switchToThread tcb\<equiv> (do
    tcbobj \<leftarrow> getObject tcb;
    vcpuSwitch (atcbVCPUPtr $ tcbArch tcbobj);
    setVMRoot tcb;
    doMachineOp $ ARM_HYP.clearExMonitor
od)"

defs configureIdleThread_def:
"configureIdleThread tcb\<equiv> (
    doKernelOp $ asUser tcb $ (do
        setRegister (Register CPSR) 0x1f;
        setRegister (Register NextIP) $ fromVPtr idleThreadStart
    od)
)"

defs switchToIdleThread_def:
"switchToIdleThread\<equiv> (do
   vcpuSwitch Nothing;
   t \<leftarrow> getIdleThread;
   setVMRoot t
od)"

defs activateIdleThread_def:
"activateIdleThread arg1 \<equiv> return ()"


end
end
