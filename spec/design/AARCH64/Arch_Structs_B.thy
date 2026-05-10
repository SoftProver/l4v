(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file Arch_Structs_B.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(* Architecture-specific data types shared by spec and abstract. *)

chapter "Common, Architecture-Specific Data Types"

theory Arch_Structs_B
imports Setup_Locale
begin

context Arch begin global_naming AARCH64_H

datatype arm_vspace_region_use =
    ArmVSpaceUserRegion
  | ArmVSpaceInvalidRegion
  | ArmVSpaceKernelWindow
  | ArmVSpaceDeviceWindow


datatype flush_type =
    Clean
  | Invalidate
  | CleanInvalidate
  | Unify


end

end
