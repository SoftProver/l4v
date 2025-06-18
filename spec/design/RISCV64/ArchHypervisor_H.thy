(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchHypervisor_H.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
  Hypervisor stub for RISCV64
*)

theory ArchHypervisor_H
imports
  CNode_H
  KI_Decls_H
  InterruptDecls_H
begin
context Arch begin global_naming RISCV64_H


consts'
handleHypervisorFault :: "machine_word \<Rightarrow> hyp_fault_type \<Rightarrow> unit kernel"

defs handleHypervisorFault_def:
"handleHypervisorFault x0 x1\<equiv> (case x1 of
    (RISCVNoHypFaults) \<Rightarrow>    return ()
  )"


end
end
