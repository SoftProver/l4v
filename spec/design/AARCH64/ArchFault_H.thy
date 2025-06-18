(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchFault_H.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
  VSpace lookup code.
*)

theory ArchFault_H
imports Types_H
begin

context Arch begin global_naming AARCH64_H

datatype arch_fault =
    VMFault (vmFaultAddress : vptr) (vmFaultArchData : "machine_word list")
  | VCPUFault (vcpuHSR : machine_word)
  | VPPIEvent (vppiIRQ : irq)
  | VGICMaintenance (vgicMaintenanceData : "machine_word option")

primrec
  vmFaultAddress_update :: "(vptr \<Rightarrow> vptr) \<Rightarrow> arch_fault \<Rightarrow> arch_fault"
where
  "vmFaultAddress_update f (VMFault v0 v1) = VMFault (f v0) v1"

primrec
  vmFaultArchData_update :: "((machine_word list) \<Rightarrow> (machine_word list)) \<Rightarrow> arch_fault \<Rightarrow> arch_fault"
where
  "vmFaultArchData_update f (VMFault v0 v1) = VMFault v0 (f v1)"

primrec
  vcpuHSR_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_fault \<Rightarrow> arch_fault"
where
  "vcpuHSR_update f (VCPUFault v0) = VCPUFault (f v0)"

primrec
  vppiIRQ_update :: "(irq \<Rightarrow> irq) \<Rightarrow> arch_fault \<Rightarrow> arch_fault"
where
  "vppiIRQ_update f (VPPIEvent v0) = VPPIEvent (f v0)"

primrec
  vgicMaintenanceData_update :: "((machine_word option) \<Rightarrow> (machine_word option)) \<Rightarrow> arch_fault \<Rightarrow> arch_fault"
where
  "vgicMaintenanceData_update f (VGICMaintenance v0) = VGICMaintenance (f v0)"

abbreviation (input)
  VMFault_trans :: "(vptr) \<Rightarrow> (machine_word list) \<Rightarrow> arch_fault" ("VMFault'_ \<lparr> vmFaultAddress= _, vmFaultArchData= _ \<rparr>")
where
  "VMFault_ \<lparr> vmFaultAddress= v0, vmFaultArchData= v1 \<rparr> == VMFault v0 v1"

abbreviation (input)
  VCPUFault_trans :: "(machine_word) \<Rightarrow> arch_fault" ("VCPUFault'_ \<lparr> vcpuHSR= _ \<rparr>")
where
  "VCPUFault_ \<lparr> vcpuHSR= v0 \<rparr> == VCPUFault v0"

abbreviation (input)
  VPPIEvent_trans :: "(irq) \<Rightarrow> arch_fault" ("VPPIEvent'_ \<lparr> vppiIRQ= _ \<rparr>")
where
  "VPPIEvent_ \<lparr> vppiIRQ= v0 \<rparr> == VPPIEvent v0"

abbreviation (input)
  VGICMaintenance_trans :: "(machine_word option) \<Rightarrow> arch_fault" ("VGICMaintenance'_ \<lparr> vgicMaintenanceData= _ \<rparr>")
where
  "VGICMaintenance_ \<lparr> vgicMaintenanceData= v0 \<rparr> == VGICMaintenance v0"

definition
  isVMFault :: "arch_fault \<Rightarrow> bool"
where
 "isVMFault v \<equiv> case v of
    VMFault v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isVCPUFault :: "arch_fault \<Rightarrow> bool"
where
 "isVCPUFault v \<equiv> case v of
    VCPUFault v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isVPPIEvent :: "arch_fault \<Rightarrow> bool"
where
 "isVPPIEvent v \<equiv> case v of
    VPPIEvent v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isVGICMaintenance :: "arch_fault \<Rightarrow> bool"
where
 "isVGICMaintenance v \<equiv> case v of
    VGICMaintenance v0 \<Rightarrow> True
  | _ \<Rightarrow> False"


end
end
