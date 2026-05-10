(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file RegisterSet_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Register Set"

theory RegisterSet_H
imports
  "Lib.HaskellLib_H"
  MachineTypes
begin
context Arch begin global_naming ARM_H

definition
  newContext :: "register => machine_word"
where
 "newContext \<equiv> (K 0) aLU initContext"

end
end
