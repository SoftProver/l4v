(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file Config_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

theory Config_H
imports Types_H
begin

definition
minFreeSlots :: "nat"
where
"minFreeSlots \<equiv> 128"

definition
minSmallBlocks :: "nat"
where
"minSmallBlocks \<equiv> 16"

definition
rootCNodeSize :: "nat"
where
"rootCNodeSize \<equiv> 12"

definition
numPriorities :: "nat"
where
"numPriorities \<equiv> 256"


end
