(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchStateData_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
    Kernel state and kernel monads, imports everything that SEL4.Model needs.
*)

chapter "Architecture Specific Kernel State and Monads"

theory ArchStateData_H
imports
  Arch_Structs_B
  ArchTypes_H
  ArchStructures_H
begin

context Arch begin global_naming AARCH64_H

datatype kernel_state =
    ARMKernelState (armKSASIDTable : "asid \<Rightarrow> ((machine_word) option)") (armKSKernelVSpace : "machine_word \<Rightarrow> arm_vspace_region_use") (armKSVMIDTable : "vmid \<Rightarrow> (asid option)") (armKSNextVMID : vmid) (armKSGlobalUserVSpace : machine_word) (armHSCurVCPU : "(machine_word * bool) option") (armKSGICVCPUNumListRegs : nat) (gsPTTypes : "machine_word \<Rightarrow> pt_type option")

primrec
  armKSASIDTable_update :: "((asid \<Rightarrow> ((machine_word) option)) \<Rightarrow> (asid \<Rightarrow> ((machine_word) option))) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "armKSASIDTable_update f (ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7) = ARMKernelState (f v0) v1 v2 v3 v4 v5 v6 v7"

primrec
  armKSKernelVSpace_update :: "((machine_word \<Rightarrow> arm_vspace_region_use) \<Rightarrow> (machine_word \<Rightarrow> arm_vspace_region_use)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "armKSKernelVSpace_update f (ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7) = ARMKernelState v0 (f v1) v2 v3 v4 v5 v6 v7"

primrec
  armKSVMIDTable_update :: "((vmid \<Rightarrow> (asid option)) \<Rightarrow> (vmid \<Rightarrow> (asid option))) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "armKSVMIDTable_update f (ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7) = ARMKernelState v0 v1 (f v2) v3 v4 v5 v6 v7"

primrec
  armKSNextVMID_update :: "(vmid \<Rightarrow> vmid) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "armKSNextVMID_update f (ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7) = ARMKernelState v0 v1 v2 (f v3) v4 v5 v6 v7"

primrec
  armKSGlobalUserVSpace_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "armKSGlobalUserVSpace_update f (ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7) = ARMKernelState v0 v1 v2 v3 (f v4) v5 v6 v7"

primrec
  armHSCurVCPU_update :: "(((machine_word * bool) option) \<Rightarrow> ((machine_word * bool) option)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "armHSCurVCPU_update f (ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7) = ARMKernelState v0 v1 v2 v3 v4 (f v5) v6 v7"

primrec
  armKSGICVCPUNumListRegs_update :: "(nat \<Rightarrow> nat) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "armKSGICVCPUNumListRegs_update f (ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7) = ARMKernelState v0 v1 v2 v3 v4 v5 (f v6) v7"

primrec
  gsPTTypes_update :: "((machine_word \<Rightarrow> pt_type option) \<Rightarrow> (machine_word \<Rightarrow> pt_type option)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "gsPTTypes_update f (ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7) = ARMKernelState v0 v1 v2 v3 v4 v5 v6 (f v7)"

abbreviation (input)
  ARMKernelState_trans :: "(asid \<Rightarrow> ((machine_word) option)) \<Rightarrow> (machine_word \<Rightarrow> arm_vspace_region_use) \<Rightarrow> (vmid \<Rightarrow> (asid option)) \<Rightarrow> (vmid) \<Rightarrow> (machine_word) \<Rightarrow> ((machine_word * bool) option) \<Rightarrow> (nat) \<Rightarrow> (machine_word \<Rightarrow> pt_type option) \<Rightarrow> kernel_state" ("ARMKernelState'_ \<lparr> armKSASIDTable= _, armKSKernelVSpace= _, armKSVMIDTable= _, armKSNextVMID= _, armKSGlobalUserVSpace= _, armHSCurVCPU= _, armKSGICVCPUNumListRegs= _, gsPTTypes= _ \<rparr>")
where
  "ARMKernelState_ \<lparr> armKSASIDTable= v0, armKSKernelVSpace= v1, armKSVMIDTable= v2, armKSNextVMID= v3, armKSGlobalUserVSpace= v4, armHSCurVCPU= v5, armKSGICVCPUNumListRegs= v6, gsPTTypes= v7 \<rparr> == ARMKernelState v0 v1 v2 v3 v4 v5 v6 v7"

lemma armKSASIDTable_armKSASIDTable_update [simp]:
  "armKSASIDTable (armKSASIDTable_update f v) = f (armKSASIDTable v)"
  by (cases v) simp

lemma armKSASIDTable_armKSKernelVSpace_update [simp]:
  "armKSASIDTable (armKSKernelVSpace_update f v) = armKSASIDTable v"
  by (cases v) simp

lemma armKSASIDTable_armKSVMIDTable_update [simp]:
  "armKSASIDTable (armKSVMIDTable_update f v) = armKSASIDTable v"
  by (cases v) simp

lemma armKSASIDTable_armKSNextVMID_update [simp]:
  "armKSASIDTable (armKSNextVMID_update f v) = armKSASIDTable v"
  by (cases v) simp

lemma armKSASIDTable_armKSGlobalUserVSpace_update [simp]:
  "armKSASIDTable (armKSGlobalUserVSpace_update f v) = armKSASIDTable v"
  by (cases v) simp

lemma armKSASIDTable_armHSCurVCPU_update [simp]:
  "armKSASIDTable (armHSCurVCPU_update f v) = armKSASIDTable v"
  by (cases v) simp

lemma armKSASIDTable_armKSGICVCPUNumListRegs_update [simp]:
  "armKSASIDTable (armKSGICVCPUNumListRegs_update f v) = armKSASIDTable v"
  by (cases v) simp

lemma armKSASIDTable_gsPTTypes_update [simp]:
  "armKSASIDTable (gsPTTypes_update f v) = armKSASIDTable v"
  by (cases v) simp

lemma armKSKernelVSpace_armKSASIDTable_update [simp]:
  "armKSKernelVSpace (armKSASIDTable_update f v) = armKSKernelVSpace v"
  by (cases v) simp

lemma armKSKernelVSpace_armKSKernelVSpace_update [simp]:
  "armKSKernelVSpace (armKSKernelVSpace_update f v) = f (armKSKernelVSpace v)"
  by (cases v) simp

lemma armKSKernelVSpace_armKSVMIDTable_update [simp]:
  "armKSKernelVSpace (armKSVMIDTable_update f v) = armKSKernelVSpace v"
  by (cases v) simp

lemma armKSKernelVSpace_armKSNextVMID_update [simp]:
  "armKSKernelVSpace (armKSNextVMID_update f v) = armKSKernelVSpace v"
  by (cases v) simp

lemma armKSKernelVSpace_armKSGlobalUserVSpace_update [simp]:
  "armKSKernelVSpace (armKSGlobalUserVSpace_update f v) = armKSKernelVSpace v"
  by (cases v) simp

lemma armKSKernelVSpace_armHSCurVCPU_update [simp]:
  "armKSKernelVSpace (armHSCurVCPU_update f v) = armKSKernelVSpace v"
  by (cases v) simp

lemma armKSKernelVSpace_armKSGICVCPUNumListRegs_update [simp]:
  "armKSKernelVSpace (armKSGICVCPUNumListRegs_update f v) = armKSKernelVSpace v"
  by (cases v) simp

lemma armKSKernelVSpace_gsPTTypes_update [simp]:
  "armKSKernelVSpace (gsPTTypes_update f v) = armKSKernelVSpace v"
  by (cases v) simp

lemma armKSVMIDTable_armKSASIDTable_update [simp]:
  "armKSVMIDTable (armKSASIDTable_update f v) = armKSVMIDTable v"
  by (cases v) simp

lemma armKSVMIDTable_armKSKernelVSpace_update [simp]:
  "armKSVMIDTable (armKSKernelVSpace_update f v) = armKSVMIDTable v"
  by (cases v) simp

lemma armKSVMIDTable_armKSVMIDTable_update [simp]:
  "armKSVMIDTable (armKSVMIDTable_update f v) = f (armKSVMIDTable v)"
  by (cases v) simp

lemma armKSVMIDTable_armKSNextVMID_update [simp]:
  "armKSVMIDTable (armKSNextVMID_update f v) = armKSVMIDTable v"
  by (cases v) simp

lemma armKSVMIDTable_armKSGlobalUserVSpace_update [simp]:
  "armKSVMIDTable (armKSGlobalUserVSpace_update f v) = armKSVMIDTable v"
  by (cases v) simp

lemma armKSVMIDTable_armHSCurVCPU_update [simp]:
  "armKSVMIDTable (armHSCurVCPU_update f v) = armKSVMIDTable v"
  by (cases v) simp

lemma armKSVMIDTable_armKSGICVCPUNumListRegs_update [simp]:
  "armKSVMIDTable (armKSGICVCPUNumListRegs_update f v) = armKSVMIDTable v"
  by (cases v) simp

lemma armKSVMIDTable_gsPTTypes_update [simp]:
  "armKSVMIDTable (gsPTTypes_update f v) = armKSVMIDTable v"
  by (cases v) simp

lemma armKSNextVMID_armKSASIDTable_update [simp]:
  "armKSNextVMID (armKSASIDTable_update f v) = armKSNextVMID v"
  by (cases v) simp

lemma armKSNextVMID_armKSKernelVSpace_update [simp]:
  "armKSNextVMID (armKSKernelVSpace_update f v) = armKSNextVMID v"
  by (cases v) simp

lemma armKSNextVMID_armKSVMIDTable_update [simp]:
  "armKSNextVMID (armKSVMIDTable_update f v) = armKSNextVMID v"
  by (cases v) simp

lemma armKSNextVMID_armKSNextVMID_update [simp]:
  "armKSNextVMID (armKSNextVMID_update f v) = f (armKSNextVMID v)"
  by (cases v) simp

lemma armKSNextVMID_armKSGlobalUserVSpace_update [simp]:
  "armKSNextVMID (armKSGlobalUserVSpace_update f v) = armKSNextVMID v"
  by (cases v) simp

lemma armKSNextVMID_armHSCurVCPU_update [simp]:
  "armKSNextVMID (armHSCurVCPU_update f v) = armKSNextVMID v"
  by (cases v) simp

lemma armKSNextVMID_armKSGICVCPUNumListRegs_update [simp]:
  "armKSNextVMID (armKSGICVCPUNumListRegs_update f v) = armKSNextVMID v"
  by (cases v) simp

lemma armKSNextVMID_gsPTTypes_update [simp]:
  "armKSNextVMID (gsPTTypes_update f v) = armKSNextVMID v"
  by (cases v) simp

lemma armKSGlobalUserVSpace_armKSASIDTable_update [simp]:
  "armKSGlobalUserVSpace (armKSASIDTable_update f v) = armKSGlobalUserVSpace v"
  by (cases v) simp

lemma armKSGlobalUserVSpace_armKSKernelVSpace_update [simp]:
  "armKSGlobalUserVSpace (armKSKernelVSpace_update f v) = armKSGlobalUserVSpace v"
  by (cases v) simp

lemma armKSGlobalUserVSpace_armKSVMIDTable_update [simp]:
  "armKSGlobalUserVSpace (armKSVMIDTable_update f v) = armKSGlobalUserVSpace v"
  by (cases v) simp

lemma armKSGlobalUserVSpace_armKSNextVMID_update [simp]:
  "armKSGlobalUserVSpace (armKSNextVMID_update f v) = armKSGlobalUserVSpace v"
  by (cases v) simp

lemma armKSGlobalUserVSpace_armKSGlobalUserVSpace_update [simp]:
  "armKSGlobalUserVSpace (armKSGlobalUserVSpace_update f v) = f (armKSGlobalUserVSpace v)"
  by (cases v) simp

lemma armKSGlobalUserVSpace_armHSCurVCPU_update [simp]:
  "armKSGlobalUserVSpace (armHSCurVCPU_update f v) = armKSGlobalUserVSpace v"
  by (cases v) simp

lemma armKSGlobalUserVSpace_armKSGICVCPUNumListRegs_update [simp]:
  "armKSGlobalUserVSpace (armKSGICVCPUNumListRegs_update f v) = armKSGlobalUserVSpace v"
  by (cases v) simp

lemma armKSGlobalUserVSpace_gsPTTypes_update [simp]:
  "armKSGlobalUserVSpace (gsPTTypes_update f v) = armKSGlobalUserVSpace v"
  by (cases v) simp

lemma armHSCurVCPU_armKSASIDTable_update [simp]:
  "armHSCurVCPU (armKSASIDTable_update f v) = armHSCurVCPU v"
  by (cases v) simp

lemma armHSCurVCPU_armKSKernelVSpace_update [simp]:
  "armHSCurVCPU (armKSKernelVSpace_update f v) = armHSCurVCPU v"
  by (cases v) simp

lemma armHSCurVCPU_armKSVMIDTable_update [simp]:
  "armHSCurVCPU (armKSVMIDTable_update f v) = armHSCurVCPU v"
  by (cases v) simp

lemma armHSCurVCPU_armKSNextVMID_update [simp]:
  "armHSCurVCPU (armKSNextVMID_update f v) = armHSCurVCPU v"
  by (cases v) simp

lemma armHSCurVCPU_armKSGlobalUserVSpace_update [simp]:
  "armHSCurVCPU (armKSGlobalUserVSpace_update f v) = armHSCurVCPU v"
  by (cases v) simp

lemma armHSCurVCPU_armHSCurVCPU_update [simp]:
  "armHSCurVCPU (armHSCurVCPU_update f v) = f (armHSCurVCPU v)"
  by (cases v) simp

lemma armHSCurVCPU_armKSGICVCPUNumListRegs_update [simp]:
  "armHSCurVCPU (armKSGICVCPUNumListRegs_update f v) = armHSCurVCPU v"
  by (cases v) simp

lemma armHSCurVCPU_gsPTTypes_update [simp]:
  "armHSCurVCPU (gsPTTypes_update f v) = armHSCurVCPU v"
  by (cases v) simp

lemma armKSGICVCPUNumListRegs_armKSASIDTable_update [simp]:
  "armKSGICVCPUNumListRegs (armKSASIDTable_update f v) = armKSGICVCPUNumListRegs v"
  by (cases v) simp

lemma armKSGICVCPUNumListRegs_armKSKernelVSpace_update [simp]:
  "armKSGICVCPUNumListRegs (armKSKernelVSpace_update f v) = armKSGICVCPUNumListRegs v"
  by (cases v) simp

lemma armKSGICVCPUNumListRegs_armKSVMIDTable_update [simp]:
  "armKSGICVCPUNumListRegs (armKSVMIDTable_update f v) = armKSGICVCPUNumListRegs v"
  by (cases v) simp

lemma armKSGICVCPUNumListRegs_armKSNextVMID_update [simp]:
  "armKSGICVCPUNumListRegs (armKSNextVMID_update f v) = armKSGICVCPUNumListRegs v"
  by (cases v) simp

lemma armKSGICVCPUNumListRegs_armKSGlobalUserVSpace_update [simp]:
  "armKSGICVCPUNumListRegs (armKSGlobalUserVSpace_update f v) = armKSGICVCPUNumListRegs v"
  by (cases v) simp

lemma armKSGICVCPUNumListRegs_armHSCurVCPU_update [simp]:
  "armKSGICVCPUNumListRegs (armHSCurVCPU_update f v) = armKSGICVCPUNumListRegs v"
  by (cases v) simp

lemma armKSGICVCPUNumListRegs_armKSGICVCPUNumListRegs_update [simp]:
  "armKSGICVCPUNumListRegs (armKSGICVCPUNumListRegs_update f v) = f (armKSGICVCPUNumListRegs v)"
  by (cases v) simp

lemma armKSGICVCPUNumListRegs_gsPTTypes_update [simp]:
  "armKSGICVCPUNumListRegs (gsPTTypes_update f v) = armKSGICVCPUNumListRegs v"
  by (cases v) simp

lemma gsPTTypes_armKSASIDTable_update [simp]:
  "gsPTTypes (armKSASIDTable_update f v) = gsPTTypes v"
  by (cases v) simp

lemma gsPTTypes_armKSKernelVSpace_update [simp]:
  "gsPTTypes (armKSKernelVSpace_update f v) = gsPTTypes v"
  by (cases v) simp

lemma gsPTTypes_armKSVMIDTable_update [simp]:
  "gsPTTypes (armKSVMIDTable_update f v) = gsPTTypes v"
  by (cases v) simp

lemma gsPTTypes_armKSNextVMID_update [simp]:
  "gsPTTypes (armKSNextVMID_update f v) = gsPTTypes v"
  by (cases v) simp

lemma gsPTTypes_armKSGlobalUserVSpace_update [simp]:
  "gsPTTypes (armKSGlobalUserVSpace_update f v) = gsPTTypes v"
  by (cases v) simp

lemma gsPTTypes_armHSCurVCPU_update [simp]:
  "gsPTTypes (armHSCurVCPU_update f v) = gsPTTypes v"
  by (cases v) simp

lemma gsPTTypes_armKSGICVCPUNumListRegs_update [simp]:
  "gsPTTypes (armKSGICVCPUNumListRegs_update f v) = gsPTTypes v"
  by (cases v) simp

lemma gsPTTypes_gsPTTypes_update [simp]:
  "gsPTTypes (gsPTTypes_update f v) = f (gsPTTypes v)"
  by (cases v) simp

definition
maxPTLevel :: "nat"
where
"maxPTLevel \<equiv> if config_ARM_PA_SIZE_BITS_40 then 2 else 3"

definition
newKernelState :: "paddr \<Rightarrow> (kernel_state * paddr list)"
where
"newKernelState arg1 \<equiv> error []"


end
end
