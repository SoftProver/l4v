(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchInvocationLabels_H.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Architecture-specific Invocation Labels"

theory ArchInvocationLabels_H
imports
  "Word_Lib.Enumeration"
  Setup_Locale
begin
context Arch begin global_naming RISCV64_H

text \<open>
  An enumeration of arch-specific system call labels.
\<close>

datatype arch_invocation_label =
    RISCVPageTableMap
  | RISCVPageTableUnmap
  | RISCVPageMap
  | RISCVPageUnmap
  | RISCVPageGetAddress
  | RISCVASIDControlMakePool
  | RISCVASIDPoolAssign
  | RISCVIRQIssueIRQHandler


end

context begin interpretation Arch .
requalify_types arch_invocation_label
end

context Arch begin global_naming RISCV64_H

end
qualify RISCV64_H (in Arch) 
(* arch_invocation_label instance proofs *)
(*<*)
instantiation arch_invocation_label :: enum begin
interpretation Arch .
definition
  enum_arch_invocation_label: "enum_class.enum \<equiv> 
    [ 
      RISCVPageTableMap,
      RISCVPageTableUnmap,
      RISCVPageMap,
      RISCVPageUnmap,
      RISCVPageGetAddress,
      RISCVASIDControlMakePool,
      RISCVASIDPoolAssign,
      RISCVIRQIssueIRQHandler
    ]"


definition
  "enum_class.enum_all (P :: arch_invocation_label \<Rightarrow> bool) \<longleftrightarrow> Ball UNIV P"

definition
  "enum_class.enum_ex (P :: arch_invocation_label \<Rightarrow> bool) \<longleftrightarrow> Bex UNIV P"

  instance
  apply intro_classes
   apply (safe, simp)
   apply (case_tac x)
  apply (simp_all add: enum_arch_invocation_label enum_all_arch_invocation_label_def enum_ex_arch_invocation_label_def)
  by fast+
end

instantiation arch_invocation_label :: enum_alt
begin
interpretation Arch .
definition
  enum_alt_arch_invocation_label: "enum_alt \<equiv> 
    alt_from_ord (enum :: arch_invocation_label list)"
instance ..
end

instantiation arch_invocation_label :: enumeration_both
begin
interpretation Arch .
instance by (intro_classes, simp add: enum_alt_arch_invocation_label)
end

(*>*)
end_qualify
context Arch begin global_naming RISCV64_H


end
end
