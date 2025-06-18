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

context Arch begin global_naming AARCH64_H

consts'
pTablePartialOverlap :: "(machine_word \<Rightarrow> pt_type option) \<Rightarrow> (machine_word \<Rightarrow> bool) \<Rightarrow> bool"

definition
deleteGhost :: "machine_word \<Rightarrow> nat \<Rightarrow> unit kernel"
where
"deleteGhost ptr bits\<equiv> (do
    inRange \<leftarrow> return ( (\<lambda> x. x && ((- mask bits) - 1) = fromPPtr ptr));
    ptTypes \<leftarrow> gets (gsPTTypes \<circ> ksArchState);
    ptTypes' \<leftarrow> return ( (\<lambda> x. if inRange x then Nothing else ptTypes x));
    stateAssert (\<lambda> ks. Not (pTablePartialOverlap ptTypes inRange))
        [];
    modify (\<lambda> ks. ks \<lparr> ksArchState := (ksArchState ks) \<lparr> gsPTTypes := ptTypes' \<rparr> \<rparr>)
od)"


end (* context Arch *)

end
