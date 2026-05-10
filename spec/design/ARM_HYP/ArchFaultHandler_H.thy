(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchFaultHandler_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Fault Handlers"

theory ArchFaultHandler_H
imports TCB_H Structures_H
begin

context Arch begin global_naming ARM_HYP_H



consts'
makeArchFaultMessage :: "arch_fault \<Rightarrow> machine_word \<Rightarrow> (machine_word * machine_word list) kernel"

consts'
handleArchFaultReply :: "arch_fault \<Rightarrow> machine_word \<Rightarrow> machine_word \<Rightarrow> machine_word list \<Rightarrow> bool kernel"

defs makeArchFaultMessage_def:
"makeArchFaultMessage x0 thread\<equiv> (case x0 of
    (VMFault vptr archData) \<Rightarrow>    (do
    pc \<leftarrow> asUser thread getRestartPC;
    return (5, pc#fromVPtr vptr#archData)
    od)
  | (VCPUFault hsr) \<Rightarrow>    return (7, [hsr])
  | (VPPIEvent irq) \<Rightarrow>    return (8, [fromIntegral $ fromEnum $ irq])
  | (VGICMaintenance archData) \<Rightarrow>    (do
    msg \<leftarrow> return ( ((case archData of
                     None \<Rightarrow>   [- 1]
                   | Some idx \<Rightarrow>   [idx])
                   ));
    return (6, msg)
  od)
  )"

defs handleArchFaultReply_def:
"handleArchFaultReply x0 x1 x2 x3\<equiv> (case x0 of
    (VMFault _ _) \<Rightarrow>    return True
  | (VCPUFault _) \<Rightarrow>    return True
  | (VPPIEvent _) \<Rightarrow>    return True
  | (VGICMaintenance _) \<Rightarrow>    return True
  )"


end


end
