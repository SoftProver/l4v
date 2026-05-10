(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchLabelFuns_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Architecture-specific Invocation Label Functions"

theory ArchLabelFuns_H
imports InvocationLabels_H
begin
context Arch begin global_naming ARM_HYP_H
text \<open>
  Arch-specific functions on invocation labels
\<close>

definition
isPDFlushLabel :: "invocation_label \<Rightarrow> bool"
where
"isPDFlushLabel x\<equiv> (case x of
        ArchInvocationLabel ARMPDClean_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMPDInvalidate_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMPDCleanInvalidate_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMPDUnify_Instruction \<Rightarrow>   True
      | _ \<Rightarrow>   False
      )"

definition
isPageFlushLabel :: "invocation_label \<Rightarrow> bool"
where
"isPageFlushLabel x\<equiv> (case x of
        ArchInvocationLabel ARMPageClean_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMPageInvalidate_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMPageCleanInvalidate_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMPageUnify_Instruction \<Rightarrow>   True
      | _ \<Rightarrow>   False
      )"


end
end
