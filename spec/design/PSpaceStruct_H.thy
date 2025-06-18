(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file PSpaceStruct_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Physical Memory Structure"

theory PSpaceStruct_H
imports
  Structures_H
  "Lib.DataMap"
begin

text \<open>Helper Functions\<close>

definition
  ptrBits_def[simp]:
 "ptrBits \<equiv> to_bl"


text \<open>Physical Memory Structures\<close>

type_synonym pspace = "( machine_word , kernel_object ) DataMap.map"

definition
  PSpace :: "pspace \<Rightarrow> pspace"
where PSpace_def[simp]:
 "PSpace \<equiv> id"

definition
  psMap :: "pspace \<Rightarrow> pspace"
where
  psMap_def[simp]:
 "psMap \<equiv> id"

definition  psMap_update :: "(pspace \<Rightarrow> pspace) \<Rightarrow> pspace \<Rightarrow> pspace"
where
  psMap_update_def[simp]:
 "psMap_update f y \<equiv> f y"

abbreviation (input)
  PSpace_trans :: "(( machine_word , kernel_object ) DataMap.map) \<Rightarrow> pspace" ("PSpace'_ \<lparr> psMap= _ \<rparr>")
where
  "PSpace_ \<lparr> psMap= v0 \<rparr> == PSpace v0"


end
