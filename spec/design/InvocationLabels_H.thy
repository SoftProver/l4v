(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file InvocationLabels_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Kernel Invocation Labels"

theory InvocationLabels_H
imports ArchInvocationLabels_H
begin

context begin interpretation Arch .
requalify_types
  arch_invocation_label
end

text \<open>
  An enumeration of all system call labels.
\<close>

datatype gen_invocation_labels =
    InvalidInvocation
  | UntypedRetype
  | TCBReadRegisters
  | TCBWriteRegisters
  | TCBCopyRegisters
  | TCBConfigure
  | TCBSetPriority
  | TCBSetMCPriority
  | TCBSetSchedParams
  | TCBSetIPCBuffer
  | TCBSetSpace
  | TCBSuspend
  | TCBResume
  | TCBBindNotification
  | TCBUnbindNotification
  | TCBSetTLSBase
  | CNodeRevoke
  | CNodeDelete
  | CNodeCancelBadgedSends
  | CNodeCopy
  | CNodeMint
  | CNodeMove
  | CNodeMutate
  | CNodeRotate
  | CNodeSaveCaller
  | IRQIssueIRQHandler
  | IRQAckIRQ
  | IRQSetIRQHandler
  | IRQClearIRQHandler
  | DomainSetSet

datatype invocation_label =
    GenInvocationLabel gen_invocation_labels
  | ArchInvocationLabel arch_invocation_label

(* gen_invocation_labels instance proofs *)
(*<*)
instantiation gen_invocation_labels :: enum begin
definition
  enum_gen_invocation_labels: "enum_class.enum \<equiv> 
    [ 
      InvalidInvocation,
      UntypedRetype,
      TCBReadRegisters,
      TCBWriteRegisters,
      TCBCopyRegisters,
      TCBConfigure,
      TCBSetPriority,
      TCBSetMCPriority,
      TCBSetSchedParams,
      TCBSetIPCBuffer,
      TCBSetSpace,
      TCBSuspend,
      TCBResume,
      TCBBindNotification,
      TCBUnbindNotification,
      TCBSetTLSBase,
      CNodeRevoke,
      CNodeDelete,
      CNodeCancelBadgedSends,
      CNodeCopy,
      CNodeMint,
      CNodeMove,
      CNodeMutate,
      CNodeRotate,
      CNodeSaveCaller,
      IRQIssueIRQHandler,
      IRQAckIRQ,
      IRQSetIRQHandler,
      IRQClearIRQHandler,
      DomainSetSet
    ]"


definition
  "enum_class.enum_all (P :: gen_invocation_labels \<Rightarrow> bool) \<longleftrightarrow> Ball UNIV P"

definition
  "enum_class.enum_ex (P :: gen_invocation_labels \<Rightarrow> bool) \<longleftrightarrow> Bex UNIV P"

  instance
  apply intro_classes
   apply (safe, simp)
   apply (case_tac x)
  apply (simp_all add: enum_gen_invocation_labels enum_all_gen_invocation_labels_def enum_ex_gen_invocation_labels_def)
  by fast+
end

instantiation gen_invocation_labels :: enum_alt
begin
definition
  enum_alt_gen_invocation_labels: "enum_alt \<equiv> 
    alt_from_ord (enum :: gen_invocation_labels list)"
instance ..
end

instantiation gen_invocation_labels :: enumeration_both
begin
instance by (intro_classes, simp add: enum_alt_gen_invocation_labels)
end

(*>*)

(* invocation_label instance proofs *)
(*<*)
instantiation invocation_label :: enum begin
definition
  enum_invocation_label: "enum_class.enum \<equiv> 
    []
    @ (map GenInvocationLabel enum)
    @ (map ArchInvocationLabel enum)"

lemma GenInvocationLabel_map_distinct[simp]: "distinct (map GenInvocationLabel enum)"
  apply (simp add: distinct_map)
  by (meson injI invocation_label.inject)
lemma ArchInvocationLabel_map_distinct[simp]: "distinct (map ArchInvocationLabel enum)"
  apply (simp add: distinct_map)
  by (meson injI invocation_label.inject)

definition
  "enum_class.enum_all (P :: invocation_label \<Rightarrow> bool) \<longleftrightarrow> Ball UNIV P"

definition
  "enum_class.enum_ex (P :: invocation_label \<Rightarrow> bool) \<longleftrightarrow> Bex UNIV P"

  instance
  apply intro_classes
   apply (safe, simp)
   apply (case_tac x)
  apply (simp_all add: enum_invocation_label enum_all_invocation_label_def enum_ex_invocation_label_def)
  by fast+
end

instantiation invocation_label :: enum_alt
begin
definition
  enum_alt_invocation_label: "enum_alt \<equiv> 
    alt_from_ord (enum :: invocation_label list)"
instance ..
end

instantiation invocation_label :: enumeration_both
begin
instance by (intro_classes, simp add: enum_alt_invocation_label)
end

(*>*)


end
