(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchInvocationLabels_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Architecture-specific Invocation Labels"

theory ArchInvocationLabels_H
imports
    "Word_Lib.Enumeration"
    Setup_Locale
begin
context Arch begin global_naming ARM_H

text \<open>
  An enumeration of arch-specific system call labels.
\<close>

datatype arch_invocation_label =
    ARMPDClean_Data
  | ARMPDInvalidate_Data
  | ARMPDCleanInvalidate_Data
  | ARMPDUnify_Instruction
  | ARMPageTableMap
  | ARMPageTableUnmap
  | ARMPageMap
  | ARMPageUnmap
  | ARMPageClean_Data
  | ARMPageInvalidate_Data
  | ARMPageCleanInvalidate_Data
  | ARMPageUnify_Instruction
  | ARMPageGetAddress
  | ARMASIDControlMakePool
  | ARMASIDPoolAssign
  | ARMIRQIssueIRQHandler


end

context begin interpretation Arch .
requalify_types arch_invocation_label
end

context Arch begin global_naming ARM_H

end
qualify ARM_H (in Arch) 
(* arch_invocation_label instance proofs *)
(*<*)
instantiation arch_invocation_label :: enum begin
interpretation Arch .
definition
  enum_arch_invocation_label: "enum_class.enum \<equiv> 
    [ 
      ARMPDClean_Data,
      ARMPDInvalidate_Data,
      ARMPDCleanInvalidate_Data,
      ARMPDUnify_Instruction,
      ARMPageTableMap,
      ARMPageTableUnmap,
      ARMPageMap,
      ARMPageUnmap,
      ARMPageClean_Data,
      ARMPageInvalidate_Data,
      ARMPageCleanInvalidate_Data,
      ARMPageUnify_Instruction,
      ARMPageGetAddress,
      ARMASIDControlMakePool,
      ARMASIDPoolAssign,
      ARMIRQIssueIRQHandler
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
context Arch begin global_naming ARM_H


end
end
