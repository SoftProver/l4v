(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchPSpace_H.thy *)
(*
 * Copyright 2023, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(* Arch-specific ghost update functions for physical memory *)

theory ArchPSpace_H
imports
  ObjectInstances_H
begin

context Arch begin global_naming ARM_HYP_H

definition
deleteGhost :: "machine_word \<Rightarrow> nat \<Rightarrow> unit kernel"
where
"deleteGhost ptr bits\<equiv> return ()"


end (* context Arch *)

end
