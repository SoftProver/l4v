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

context Arch begin global_naming X64_H

datatype kernel_state =
    X64KernelState (x64KSASIDTable : "asid \<Rightarrow> ((machine_word) option)") (x64KSSKIMPML4 : machine_word) (x64KSSKIMPDPTs : "machine_word list") (x64KSSKIMPDs : "machine_word list") (x64KSSKIMPTs : "machine_word list") (x64KSCurrentUserCR3 : cr3) (x64KSKernelVSpace : "machine_word \<Rightarrow> x64vspace_region_use") (x64KSAllocatedIOPorts : "ioport \<Rightarrow> bool") (x64KSNumIOAPICs : machine_word) (x64KSIRQState : "irq \<Rightarrow> x64irqstate")

primrec
  x64KSASIDTable_update :: "((asid \<Rightarrow> ((machine_word) option)) \<Rightarrow> (asid \<Rightarrow> ((machine_word) option))) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSASIDTable_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState (f v0) v1 v2 v3 v4 v5 v6 v7 v8 v9"

primrec
  x64KSSKIMPML4_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSSKIMPML4_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 (f v1) v2 v3 v4 v5 v6 v7 v8 v9"

primrec
  x64KSSKIMPDPTs_update :: "((machine_word list) \<Rightarrow> (machine_word list)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSSKIMPDPTs_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 v1 (f v2) v3 v4 v5 v6 v7 v8 v9"

primrec
  x64KSSKIMPDs_update :: "((machine_word list) \<Rightarrow> (machine_word list)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSSKIMPDs_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 v1 v2 (f v3) v4 v5 v6 v7 v8 v9"

primrec
  x64KSSKIMPTs_update :: "((machine_word list) \<Rightarrow> (machine_word list)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSSKIMPTs_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 v1 v2 v3 (f v4) v5 v6 v7 v8 v9"

primrec
  x64KSCurrentUserCR3_update :: "(cr3 \<Rightarrow> cr3) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSCurrentUserCR3_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 v1 v2 v3 v4 (f v5) v6 v7 v8 v9"

primrec
  x64KSKernelVSpace_update :: "((machine_word \<Rightarrow> x64vspace_region_use) \<Rightarrow> (machine_word \<Rightarrow> x64vspace_region_use)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSKernelVSpace_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 v1 v2 v3 v4 v5 (f v6) v7 v8 v9"

primrec
  x64KSAllocatedIOPorts_update :: "((ioport \<Rightarrow> bool) \<Rightarrow> (ioport \<Rightarrow> bool)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSAllocatedIOPorts_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 v1 v2 v3 v4 v5 v6 (f v7) v8 v9"

primrec
  x64KSNumIOAPICs_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSNumIOAPICs_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 (f v8) v9"

primrec
  x64KSIRQState_update :: "((irq \<Rightarrow> x64irqstate) \<Rightarrow> (irq \<Rightarrow> x64irqstate)) \<Rightarrow> kernel_state \<Rightarrow> kernel_state"
where
  "x64KSIRQState_update f (X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) = X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 (f v9)"

abbreviation (input)
  X64KernelState_trans :: "(asid \<Rightarrow> ((machine_word) option)) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word list) \<Rightarrow> (machine_word list) \<Rightarrow> (machine_word list) \<Rightarrow> (cr3) \<Rightarrow> (machine_word \<Rightarrow> x64vspace_region_use) \<Rightarrow> (ioport \<Rightarrow> bool) \<Rightarrow> (machine_word) \<Rightarrow> (irq \<Rightarrow> x64irqstate) \<Rightarrow> kernel_state" ("X64KernelState'_ \<lparr> x64KSASIDTable= _, x64KSSKIMPML4= _, x64KSSKIMPDPTs= _, x64KSSKIMPDs= _, x64KSSKIMPTs= _, x64KSCurrentUserCR3= _, x64KSKernelVSpace= _, x64KSAllocatedIOPorts= _, x64KSNumIOAPICs= _, x64KSIRQState= _ \<rparr>")
where
  "X64KernelState_ \<lparr> x64KSASIDTable= v0, x64KSSKIMPML4= v1, x64KSSKIMPDPTs= v2, x64KSSKIMPDs= v3, x64KSSKIMPTs= v4, x64KSCurrentUserCR3= v5, x64KSKernelVSpace= v6, x64KSAllocatedIOPorts= v7, x64KSNumIOAPICs= v8, x64KSIRQState= v9 \<rparr> == X64KernelState v0 v1 v2 v3 v4 v5 v6 v7 v8 v9"

lemma x64KSASIDTable_x64KSASIDTable_update [simp]:
  "x64KSASIDTable (x64KSASIDTable_update f v) = f (x64KSASIDTable v)"
  by (cases v) simp

lemma x64KSASIDTable_x64KSSKIMPML4_update [simp]:
  "x64KSASIDTable (x64KSSKIMPML4_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSASIDTable_x64KSSKIMPDPTs_update [simp]:
  "x64KSASIDTable (x64KSSKIMPDPTs_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSASIDTable_x64KSSKIMPDs_update [simp]:
  "x64KSASIDTable (x64KSSKIMPDs_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSASIDTable_x64KSSKIMPTs_update [simp]:
  "x64KSASIDTable (x64KSSKIMPTs_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSASIDTable_x64KSCurrentUserCR3_update [simp]:
  "x64KSASIDTable (x64KSCurrentUserCR3_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSASIDTable_x64KSKernelVSpace_update [simp]:
  "x64KSASIDTable (x64KSKernelVSpace_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSASIDTable_x64KSAllocatedIOPorts_update [simp]:
  "x64KSASIDTable (x64KSAllocatedIOPorts_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSASIDTable_x64KSNumIOAPICs_update [simp]:
  "x64KSASIDTable (x64KSNumIOAPICs_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSASIDTable_x64KSIRQState_update [simp]:
  "x64KSASIDTable (x64KSIRQState_update f v) = x64KSASIDTable v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSASIDTable_update [simp]:
  "x64KSSKIMPML4 (x64KSASIDTable_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSSKIMPML4_update [simp]:
  "x64KSSKIMPML4 (x64KSSKIMPML4_update f v) = f (x64KSSKIMPML4 v)"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSSKIMPDPTs_update [simp]:
  "x64KSSKIMPML4 (x64KSSKIMPDPTs_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSSKIMPDs_update [simp]:
  "x64KSSKIMPML4 (x64KSSKIMPDs_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSSKIMPTs_update [simp]:
  "x64KSSKIMPML4 (x64KSSKIMPTs_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSCurrentUserCR3_update [simp]:
  "x64KSSKIMPML4 (x64KSCurrentUserCR3_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSKernelVSpace_update [simp]:
  "x64KSSKIMPML4 (x64KSKernelVSpace_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSAllocatedIOPorts_update [simp]:
  "x64KSSKIMPML4 (x64KSAllocatedIOPorts_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSNumIOAPICs_update [simp]:
  "x64KSSKIMPML4 (x64KSNumIOAPICs_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPML4_x64KSIRQState_update [simp]:
  "x64KSSKIMPML4 (x64KSIRQState_update f v) = x64KSSKIMPML4 v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSASIDTable_update [simp]:
  "x64KSSKIMPDPTs (x64KSASIDTable_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSSKIMPML4_update [simp]:
  "x64KSSKIMPDPTs (x64KSSKIMPML4_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSSKIMPDPTs_update [simp]:
  "x64KSSKIMPDPTs (x64KSSKIMPDPTs_update f v) = f (x64KSSKIMPDPTs v)"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSSKIMPDs_update [simp]:
  "x64KSSKIMPDPTs (x64KSSKIMPDs_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSSKIMPTs_update [simp]:
  "x64KSSKIMPDPTs (x64KSSKIMPTs_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSCurrentUserCR3_update [simp]:
  "x64KSSKIMPDPTs (x64KSCurrentUserCR3_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSKernelVSpace_update [simp]:
  "x64KSSKIMPDPTs (x64KSKernelVSpace_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSAllocatedIOPorts_update [simp]:
  "x64KSSKIMPDPTs (x64KSAllocatedIOPorts_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSNumIOAPICs_update [simp]:
  "x64KSSKIMPDPTs (x64KSNumIOAPICs_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDPTs_x64KSIRQState_update [simp]:
  "x64KSSKIMPDPTs (x64KSIRQState_update f v) = x64KSSKIMPDPTs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSASIDTable_update [simp]:
  "x64KSSKIMPDs (x64KSASIDTable_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSSKIMPML4_update [simp]:
  "x64KSSKIMPDs (x64KSSKIMPML4_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSSKIMPDPTs_update [simp]:
  "x64KSSKIMPDs (x64KSSKIMPDPTs_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSSKIMPDs_update [simp]:
  "x64KSSKIMPDs (x64KSSKIMPDs_update f v) = f (x64KSSKIMPDs v)"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSSKIMPTs_update [simp]:
  "x64KSSKIMPDs (x64KSSKIMPTs_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSCurrentUserCR3_update [simp]:
  "x64KSSKIMPDs (x64KSCurrentUserCR3_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSKernelVSpace_update [simp]:
  "x64KSSKIMPDs (x64KSKernelVSpace_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSAllocatedIOPorts_update [simp]:
  "x64KSSKIMPDs (x64KSAllocatedIOPorts_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSNumIOAPICs_update [simp]:
  "x64KSSKIMPDs (x64KSNumIOAPICs_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPDs_x64KSIRQState_update [simp]:
  "x64KSSKIMPDs (x64KSIRQState_update f v) = x64KSSKIMPDs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSASIDTable_update [simp]:
  "x64KSSKIMPTs (x64KSASIDTable_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSSKIMPML4_update [simp]:
  "x64KSSKIMPTs (x64KSSKIMPML4_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSSKIMPDPTs_update [simp]:
  "x64KSSKIMPTs (x64KSSKIMPDPTs_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSSKIMPDs_update [simp]:
  "x64KSSKIMPTs (x64KSSKIMPDs_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSSKIMPTs_update [simp]:
  "x64KSSKIMPTs (x64KSSKIMPTs_update f v) = f (x64KSSKIMPTs v)"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSCurrentUserCR3_update [simp]:
  "x64KSSKIMPTs (x64KSCurrentUserCR3_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSKernelVSpace_update [simp]:
  "x64KSSKIMPTs (x64KSKernelVSpace_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSAllocatedIOPorts_update [simp]:
  "x64KSSKIMPTs (x64KSAllocatedIOPorts_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSNumIOAPICs_update [simp]:
  "x64KSSKIMPTs (x64KSNumIOAPICs_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSSKIMPTs_x64KSIRQState_update [simp]:
  "x64KSSKIMPTs (x64KSIRQState_update f v) = x64KSSKIMPTs v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSASIDTable_update [simp]:
  "x64KSCurrentUserCR3 (x64KSASIDTable_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSSKIMPML4_update [simp]:
  "x64KSCurrentUserCR3 (x64KSSKIMPML4_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSSKIMPDPTs_update [simp]:
  "x64KSCurrentUserCR3 (x64KSSKIMPDPTs_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSSKIMPDs_update [simp]:
  "x64KSCurrentUserCR3 (x64KSSKIMPDs_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSSKIMPTs_update [simp]:
  "x64KSCurrentUserCR3 (x64KSSKIMPTs_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSCurrentUserCR3_update [simp]:
  "x64KSCurrentUserCR3 (x64KSCurrentUserCR3_update f v) = f (x64KSCurrentUserCR3 v)"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSKernelVSpace_update [simp]:
  "x64KSCurrentUserCR3 (x64KSKernelVSpace_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSAllocatedIOPorts_update [simp]:
  "x64KSCurrentUserCR3 (x64KSAllocatedIOPorts_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSNumIOAPICs_update [simp]:
  "x64KSCurrentUserCR3 (x64KSNumIOAPICs_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSCurrentUserCR3_x64KSIRQState_update [simp]:
  "x64KSCurrentUserCR3 (x64KSIRQState_update f v) = x64KSCurrentUserCR3 v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSASIDTable_update [simp]:
  "x64KSKernelVSpace (x64KSASIDTable_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSSKIMPML4_update [simp]:
  "x64KSKernelVSpace (x64KSSKIMPML4_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSSKIMPDPTs_update [simp]:
  "x64KSKernelVSpace (x64KSSKIMPDPTs_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSSKIMPDs_update [simp]:
  "x64KSKernelVSpace (x64KSSKIMPDs_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSSKIMPTs_update [simp]:
  "x64KSKernelVSpace (x64KSSKIMPTs_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSCurrentUserCR3_update [simp]:
  "x64KSKernelVSpace (x64KSCurrentUserCR3_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSKernelVSpace_update [simp]:
  "x64KSKernelVSpace (x64KSKernelVSpace_update f v) = f (x64KSKernelVSpace v)"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSAllocatedIOPorts_update [simp]:
  "x64KSKernelVSpace (x64KSAllocatedIOPorts_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSNumIOAPICs_update [simp]:
  "x64KSKernelVSpace (x64KSNumIOAPICs_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSKernelVSpace_x64KSIRQState_update [simp]:
  "x64KSKernelVSpace (x64KSIRQState_update f v) = x64KSKernelVSpace v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSASIDTable_update [simp]:
  "x64KSAllocatedIOPorts (x64KSASIDTable_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSSKIMPML4_update [simp]:
  "x64KSAllocatedIOPorts (x64KSSKIMPML4_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSSKIMPDPTs_update [simp]:
  "x64KSAllocatedIOPorts (x64KSSKIMPDPTs_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSSKIMPDs_update [simp]:
  "x64KSAllocatedIOPorts (x64KSSKIMPDs_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSSKIMPTs_update [simp]:
  "x64KSAllocatedIOPorts (x64KSSKIMPTs_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSCurrentUserCR3_update [simp]:
  "x64KSAllocatedIOPorts (x64KSCurrentUserCR3_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSKernelVSpace_update [simp]:
  "x64KSAllocatedIOPorts (x64KSKernelVSpace_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSAllocatedIOPorts_update [simp]:
  "x64KSAllocatedIOPorts (x64KSAllocatedIOPorts_update f v) = f (x64KSAllocatedIOPorts v)"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSNumIOAPICs_update [simp]:
  "x64KSAllocatedIOPorts (x64KSNumIOAPICs_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSAllocatedIOPorts_x64KSIRQState_update [simp]:
  "x64KSAllocatedIOPorts (x64KSIRQState_update f v) = x64KSAllocatedIOPorts v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSASIDTable_update [simp]:
  "x64KSNumIOAPICs (x64KSASIDTable_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSSKIMPML4_update [simp]:
  "x64KSNumIOAPICs (x64KSSKIMPML4_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSSKIMPDPTs_update [simp]:
  "x64KSNumIOAPICs (x64KSSKIMPDPTs_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSSKIMPDs_update [simp]:
  "x64KSNumIOAPICs (x64KSSKIMPDs_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSSKIMPTs_update [simp]:
  "x64KSNumIOAPICs (x64KSSKIMPTs_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSCurrentUserCR3_update [simp]:
  "x64KSNumIOAPICs (x64KSCurrentUserCR3_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSKernelVSpace_update [simp]:
  "x64KSNumIOAPICs (x64KSKernelVSpace_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSAllocatedIOPorts_update [simp]:
  "x64KSNumIOAPICs (x64KSAllocatedIOPorts_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSNumIOAPICs_update [simp]:
  "x64KSNumIOAPICs (x64KSNumIOAPICs_update f v) = f (x64KSNumIOAPICs v)"
  by (cases v) simp

lemma x64KSNumIOAPICs_x64KSIRQState_update [simp]:
  "x64KSNumIOAPICs (x64KSIRQState_update f v) = x64KSNumIOAPICs v"
  by (cases v) simp

lemma x64KSIRQState_x64KSASIDTable_update [simp]:
  "x64KSIRQState (x64KSASIDTable_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSSKIMPML4_update [simp]:
  "x64KSIRQState (x64KSSKIMPML4_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSSKIMPDPTs_update [simp]:
  "x64KSIRQState (x64KSSKIMPDPTs_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSSKIMPDs_update [simp]:
  "x64KSIRQState (x64KSSKIMPDs_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSSKIMPTs_update [simp]:
  "x64KSIRQState (x64KSSKIMPTs_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSCurrentUserCR3_update [simp]:
  "x64KSIRQState (x64KSCurrentUserCR3_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSKernelVSpace_update [simp]:
  "x64KSIRQState (x64KSKernelVSpace_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSAllocatedIOPorts_update [simp]:
  "x64KSIRQState (x64KSAllocatedIOPorts_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSNumIOAPICs_update [simp]:
  "x64KSIRQState (x64KSNumIOAPICs_update f v) = x64KSIRQState v"
  by (cases v) simp

lemma x64KSIRQState_x64KSIRQState_update [simp]:
  "x64KSIRQState (x64KSIRQState_update f v) = f (x64KSIRQState v)"
  by (cases v) simp

definition
gdteBits :: "nat"
where
"gdteBits \<equiv> 3"

definition
newKernelState :: "paddr \<Rightarrow> (kernel_state * paddr list)"
where
"newKernelState arg1 \<equiv> error []"


end
end
