(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchLabelFuns_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Architecture-specific Invocation Label Functions"

theory ArchLabelFuns_H
imports InvocationLabels_H
begin
context Arch begin global_naming AARCH64_H

text \<open>
  Arch-specific functions on invocation labels
\<close>

definition
isVSpaceFlushLabel :: "invocation_label \<Rightarrow> bool"
where
"isVSpaceFlushLabel x\<equiv> (case x of
        ArchInvocationLabel ARMVSpaceClean_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMVSpaceInvalidate_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMVSpaceCleanInvalidate_Data \<Rightarrow>   True
      | ArchInvocationLabel ARMVSpaceUnify_Instruction \<Rightarrow>   True
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
