(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchStateData_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
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

context Arch begin global_naming RISCV64_H

datatype kernel_state =
    RISCVKernelState (riscvKSASIDTable : "asid \<Rightarrow> ((machine_word) option)") (riscvKSGlobalPTs : "nat \<Rightarrow> machine_word list") (riscvKSKernelVSpace : "machine_word \<Rightarrow> riscvvspace_region_use")

primrec
  riscvKSASIDTable_update :: "((asid \<Rightarrow> ((machine_word) option)) \<Rightarrow> (asid \<Rightarrow> ((machine_word) option))) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "riscvKSASIDTable_update f (RISCVKernelState v0 v1 v2) = RISCVKernelState (f v0) v1 v2"

primrec
  riscvKSGlobalPTs_update :: "((nat \<Rightarrow> machine_word list) \<Rightarrow> (nat \<Rightarrow> machine_word list)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "riscvKSGlobalPTs_update f (RISCVKernelState v0 v1 v2) = RISCVKernelState v0 (f v1) v2"

primrec
  riscvKSKernelVSpace_update :: "((machine_word \<Rightarrow> riscvvspace_region_use) \<Rightarrow> (machine_word \<Rightarrow> riscvvspace_region_use)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "riscvKSKernelVSpace_update f (RISCVKernelState v0 v1 v2) = RISCVKernelState v0 v1 (f v2)"

abbreviation (input)
  RISCVKernelState_trans :: "(asid \<Rightarrow> ((machine_word) option)) \<Rightarrow> (nat \<Rightarrow> machine_word list) \<Rightarrow> (machine_word \<Rightarrow> riscvvspace_region_use) \<Rightarrow> kernel_state" ("RISCVKernelState'_ \<lparr> riscvKSASIDTable= _, riscvKSGlobalPTs= _, riscvKSKernelVSpace= _ \<rparr>")
where
  "RISCVKernelState_ \<lparr> riscvKSASIDTable= v0, riscvKSGlobalPTs= v1, riscvKSKernelVSpace= v2 \<rparr> == RISCVKernelState v0 v1 v2"

lemma riscvKSASIDTable_riscvKSASIDTable_update [simp]:
  "riscvKSASIDTable (riscvKSASIDTable_update f v) = f (riscvKSASIDTable v)"
  by (cases v) simp

lemma riscvKSASIDTable_riscvKSGlobalPTs_update [simp]:
  "riscvKSASIDTable (riscvKSGlobalPTs_update f v) = riscvKSASIDTable v"
  by (cases v) simp

lemma riscvKSASIDTable_riscvKSKernelVSpace_update [simp]:
  "riscvKSASIDTable (riscvKSKernelVSpace_update f v) = riscvKSASIDTable v"
  by (cases v) simp

lemma riscvKSGlobalPTs_riscvKSASIDTable_update [simp]:
  "riscvKSGlobalPTs (riscvKSASIDTable_update f v) = riscvKSGlobalPTs v"
  by (cases v) simp

lemma riscvKSGlobalPTs_riscvKSGlobalPTs_update [simp]:
  "riscvKSGlobalPTs (riscvKSGlobalPTs_update f v) = f (riscvKSGlobalPTs v)"
  by (cases v) simp

lemma riscvKSGlobalPTs_riscvKSKernelVSpace_update [simp]:
  "riscvKSGlobalPTs (riscvKSKernelVSpace_update f v) = riscvKSGlobalPTs v"
  by (cases v) simp

lemma riscvKSKernelVSpace_riscvKSASIDTable_update [simp]:
  "riscvKSKernelVSpace (riscvKSASIDTable_update f v) = riscvKSKernelVSpace v"
  by (cases v) simp

lemma riscvKSKernelVSpace_riscvKSGlobalPTs_update [simp]:
  "riscvKSKernelVSpace (riscvKSGlobalPTs_update f v) = riscvKSKernelVSpace v"
  by (cases v) simp

lemma riscvKSKernelVSpace_riscvKSKernelVSpace_update [simp]:
  "riscvKSKernelVSpace (riscvKSKernelVSpace_update f v) = f (riscvKSKernelVSpace v)"
  by (cases v) simp

definition
maxPTLevel :: "nat"
where
"maxPTLevel \<equiv> 2"

definition
riscvKSGlobalPT :: "kernel_state \<Rightarrow> machine_word"
where
"riscvKSGlobalPT s\<equiv> head (riscvKSGlobalPTs s maxPTLevel)"

definition
newKernelState :: "paddr \<Rightarrow> (kernel_state * paddr list)"
where
"newKernelState arg1 \<equiv> error []"


end
end
