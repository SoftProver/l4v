(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchRetypeDecls_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Retyping Objects"

theory ArchRetypeDecls_H
imports
  FaultMonad_H
  EndpointDecls_H
  KernelInitMonad_H
  PSpaceFuns_H
  ArchObjInsts_H
begin

context Arch begin global_naming AARCH64_H


datatype vspace_invocation =
    VSpaceNothing
  | VSpaceFlush (vsFlushType : flush_type) (vsFlushStart : vptr) (vsFlushEnd : vptr) (vsFlushPStart : paddr) (vsFlushSpace : machine_word) (vsFlushASID : asid)

primrec
  vsFlushType_update :: "(flush_type \<Rightarrow> flush_type) \<Rightarrow> vspace_invocation \<Rightarrow> vspace_invocation"
where
  "vsFlushType_update f (VSpaceFlush v0 v1 v2 v3 v4 v5) = VSpaceFlush (f v0) v1 v2 v3 v4 v5"

primrec
  vsFlushStart_update :: "(vptr \<Rightarrow> vptr) \<Rightarrow> vspace_invocation \<Rightarrow> vspace_invocation"
where
  "vsFlushStart_update f (VSpaceFlush v0 v1 v2 v3 v4 v5) = VSpaceFlush v0 (f v1) v2 v3 v4 v5"

primrec
  vsFlushEnd_update :: "(vptr \<Rightarrow> vptr) \<Rightarrow> vspace_invocation \<Rightarrow> vspace_invocation"
where
  "vsFlushEnd_update f (VSpaceFlush v0 v1 v2 v3 v4 v5) = VSpaceFlush v0 v1 (f v2) v3 v4 v5"

primrec
  vsFlushPStart_update :: "(paddr \<Rightarrow> paddr) \<Rightarrow> vspace_invocation \<Rightarrow> vspace_invocation"
where
  "vsFlushPStart_update f (VSpaceFlush v0 v1 v2 v3 v4 v5) = VSpaceFlush v0 v1 v2 (f v3) v4 v5"

primrec
  vsFlushSpace_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> vspace_invocation \<Rightarrow> vspace_invocation"
where
  "vsFlushSpace_update f (VSpaceFlush v0 v1 v2 v3 v4 v5) = VSpaceFlush v0 v1 v2 v3 (f v4) v5"

primrec
  vsFlushASID_update :: "(asid \<Rightarrow> asid) \<Rightarrow> vspace_invocation \<Rightarrow> vspace_invocation"
where
  "vsFlushASID_update f (VSpaceFlush v0 v1 v2 v3 v4 v5) = VSpaceFlush v0 v1 v2 v3 v4 (f v5)"

abbreviation (input)
  VSpaceFlush_trans :: "(flush_type) \<Rightarrow> (vptr) \<Rightarrow> (vptr) \<Rightarrow> (paddr) \<Rightarrow> (machine_word) \<Rightarrow> (asid) \<Rightarrow> vspace_invocation" ("VSpaceFlush'_ \<lparr> vsFlushType= _, vsFlushStart= _, vsFlushEnd= _, vsFlushPStart= _, vsFlushSpace= _, vsFlushASID= _ \<rparr>")
where
  "VSpaceFlush_ \<lparr> vsFlushType= v0, vsFlushStart= v1, vsFlushEnd= v2, vsFlushPStart= v3, vsFlushSpace= v4, vsFlushASID= v5 \<rparr> == VSpaceFlush v0 v1 v2 v3 v4 v5"

definition
  isVSpaceNothing :: "vspace_invocation \<Rightarrow> bool"
where
 "isVSpaceNothing v \<equiv> case v of
    VSpaceNothing \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isVSpaceFlush :: "vspace_invocation \<Rightarrow> bool"
where
 "isVSpaceFlush v \<equiv> case v of
    VSpaceFlush v0 v1 v2 v3 v4 v5 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype page_table_invocation =
    PageTableUnmap (ptUnmapCap : arch_capability) (ptUnmapCapSlot : machine_word)
  | PageTableMap (ptMapCap : capability) (ptMapCTSlot : machine_word) (ptMapPTE : pte) (ptMapPTSlot : machine_word)

primrec
  ptUnmapCap_update :: "(arch_capability \<Rightarrow> arch_capability) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptUnmapCap_update f (PageTableUnmap v0 v1) = PageTableUnmap (f v0) v1"

primrec
  ptUnmapCapSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptUnmapCapSlot_update f (PageTableUnmap v0 v1) = PageTableUnmap v0 (f v1)"

primrec
  ptMapCap_update :: "(capability \<Rightarrow> capability) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptMapCap_update f (PageTableMap v0 v1 v2 v3) = PageTableMap (f v0) v1 v2 v3"

primrec
  ptMapCTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptMapCTSlot_update f (PageTableMap v0 v1 v2 v3) = PageTableMap v0 (f v1) v2 v3"

primrec
  ptMapPTE_update :: "(pte \<Rightarrow> pte) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptMapPTE_update f (PageTableMap v0 v1 v2 v3) = PageTableMap v0 v1 (f v2) v3"

primrec
  ptMapPTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptMapPTSlot_update f (PageTableMap v0 v1 v2 v3) = PageTableMap v0 v1 v2 (f v3)"

abbreviation (input)
  PageTableUnmap_trans :: "(arch_capability) \<Rightarrow> (machine_word) \<Rightarrow> page_table_invocation" ("PageTableUnmap'_ \<lparr> ptUnmapCap= _, ptUnmapCapSlot= _ \<rparr>")
where
  "PageTableUnmap_ \<lparr> ptUnmapCap= v0, ptUnmapCapSlot= v1 \<rparr> == PageTableUnmap v0 v1"

abbreviation (input)
  PageTableMap_trans :: "(capability) \<Rightarrow> (machine_word) \<Rightarrow> (pte) \<Rightarrow> (machine_word) \<Rightarrow> page_table_invocation" ("PageTableMap'_ \<lparr> ptMapCap= _, ptMapCTSlot= _, ptMapPTE= _, ptMapPTSlot= _ \<rparr>")
where
  "PageTableMap_ \<lparr> ptMapCap= v0, ptMapCTSlot= v1, ptMapPTE= v2, ptMapPTSlot= v3 \<rparr> == PageTableMap v0 v1 v2 v3"

definition
  isPageTableUnmap :: "page_table_invocation \<Rightarrow> bool"
where
 "isPageTableUnmap v \<equiv> case v of
    PageTableUnmap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageTableMap :: "page_table_invocation \<Rightarrow> bool"
where
 "isPageTableMap v \<equiv> case v of
    PageTableMap v0 v1 v2 v3 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype page_invocation =
    PageGetAddr (pageGetBasePtr : machine_word)
  | PageMap (pageMapCap : arch_capability) (pageMapCTSlot : machine_word) (pageMapEntries : "(pte * machine_word)")
  | PageUnmap (pageUnmapCap : arch_capability) (pageUnmapCapSlot : machine_word)
  | PageFlush (pageFlushType : flush_type) (pageFlushStart : vptr) (pageFlushEnd : vptr) (pageFlushPStart : paddr) (pageFlushSpace : machine_word) (pageFlushASID : asid)

primrec
  pageGetBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageGetBasePtr_update f (PageGetAddr v0) = PageGetAddr (f v0)"

primrec
  pageMapCap_update :: "(arch_capability \<Rightarrow> arch_capability) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageMapCap_update f (PageMap v0 v1 v2) = PageMap (f v0) v1 v2"

primrec
  pageMapCTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageMapCTSlot_update f (PageMap v0 v1 v2) = PageMap v0 (f v1) v2"

primrec
  pageMapEntries_update :: "(((pte * machine_word)) \<Rightarrow> ((pte * machine_word))) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageMapEntries_update f (PageMap v0 v1 v2) = PageMap v0 v1 (f v2)"

primrec
  pageUnmapCap_update :: "(arch_capability \<Rightarrow> arch_capability) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageUnmapCap_update f (PageUnmap v0 v1) = PageUnmap (f v0) v1"

primrec
  pageUnmapCapSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageUnmapCapSlot_update f (PageUnmap v0 v1) = PageUnmap v0 (f v1)"

primrec
  pageFlushType_update :: "(flush_type \<Rightarrow> flush_type) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageFlushType_update f (PageFlush v0 v1 v2 v3 v4 v5) = PageFlush (f v0) v1 v2 v3 v4 v5"

primrec
  pageFlushStart_update :: "(vptr \<Rightarrow> vptr) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageFlushStart_update f (PageFlush v0 v1 v2 v3 v4 v5) = PageFlush v0 (f v1) v2 v3 v4 v5"

primrec
  pageFlushEnd_update :: "(vptr \<Rightarrow> vptr) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageFlushEnd_update f (PageFlush v0 v1 v2 v3 v4 v5) = PageFlush v0 v1 (f v2) v3 v4 v5"

primrec
  pageFlushPStart_update :: "(paddr \<Rightarrow> paddr) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageFlushPStart_update f (PageFlush v0 v1 v2 v3 v4 v5) = PageFlush v0 v1 v2 (f v3) v4 v5"

primrec
  pageFlushSpace_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageFlushSpace_update f (PageFlush v0 v1 v2 v3 v4 v5) = PageFlush v0 v1 v2 v3 (f v4) v5"

primrec
  pageFlushASID_update :: "(asid \<Rightarrow> asid) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageFlushASID_update f (PageFlush v0 v1 v2 v3 v4 v5) = PageFlush v0 v1 v2 v3 v4 (f v5)"

abbreviation (input)
  PageGetAddr_trans :: "(machine_word) \<Rightarrow> page_invocation" ("PageGetAddr'_ \<lparr> pageGetBasePtr= _ \<rparr>")
where
  "PageGetAddr_ \<lparr> pageGetBasePtr= v0 \<rparr> == PageGetAddr v0"

abbreviation (input)
  PageMap_trans :: "(arch_capability) \<Rightarrow> (machine_word) \<Rightarrow> ((pte * machine_word)) \<Rightarrow> page_invocation" ("PageMap'_ \<lparr> pageMapCap= _, pageMapCTSlot= _, pageMapEntries= _ \<rparr>")
where
  "PageMap_ \<lparr> pageMapCap= v0, pageMapCTSlot= v1, pageMapEntries= v2 \<rparr> == PageMap v0 v1 v2"

abbreviation (input)
  PageUnmap_trans :: "(arch_capability) \<Rightarrow> (machine_word) \<Rightarrow> page_invocation" ("PageUnmap'_ \<lparr> pageUnmapCap= _, pageUnmapCapSlot= _ \<rparr>")
where
  "PageUnmap_ \<lparr> pageUnmapCap= v0, pageUnmapCapSlot= v1 \<rparr> == PageUnmap v0 v1"

abbreviation (input)
  PageFlush_trans :: "(flush_type) \<Rightarrow> (vptr) \<Rightarrow> (vptr) \<Rightarrow> (paddr) \<Rightarrow> (machine_word) \<Rightarrow> (asid) \<Rightarrow> page_invocation" ("PageFlush'_ \<lparr> pageFlushType= _, pageFlushStart= _, pageFlushEnd= _, pageFlushPStart= _, pageFlushSpace= _, pageFlushASID= _ \<rparr>")
where
  "PageFlush_ \<lparr> pageFlushType= v0, pageFlushStart= v1, pageFlushEnd= v2, pageFlushPStart= v3, pageFlushSpace= v4, pageFlushASID= v5 \<rparr> == PageFlush v0 v1 v2 v3 v4 v5"

definition
  isPageGetAddr :: "page_invocation \<Rightarrow> bool"
where
 "isPageGetAddr v \<equiv> case v of
    PageGetAddr v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageMap :: "page_invocation \<Rightarrow> bool"
where
 "isPageMap v \<equiv> case v of
    PageMap v0 v1 v2 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageUnmap :: "page_invocation \<Rightarrow> bool"
where
 "isPageUnmap v \<equiv> case v of
    PageUnmap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageFlush :: "page_invocation \<Rightarrow> bool"
where
 "isPageFlush v \<equiv> case v of
    PageFlush v0 v1 v2 v3 v4 v5 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype asidcontrol_invocation =
    MakePool (makePoolFrame : machine_word) (makePoolSlot : machine_word) (makePoolParent : machine_word) (makePoolBase : asid)

primrec
  makePoolFrame_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> asidcontrol_invocation \<Rightarrow> asidcontrol_invocation"
where
  "makePoolFrame_update f (MakePool v0 v1 v2 v3) = MakePool (f v0) v1 v2 v3"

primrec
  makePoolSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> asidcontrol_invocation \<Rightarrow> asidcontrol_invocation"
where
  "makePoolSlot_update f (MakePool v0 v1 v2 v3) = MakePool v0 (f v1) v2 v3"

primrec
  makePoolParent_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> asidcontrol_invocation \<Rightarrow> asidcontrol_invocation"
where
  "makePoolParent_update f (MakePool v0 v1 v2 v3) = MakePool v0 v1 (f v2) v3"

primrec
  makePoolBase_update :: "(asid \<Rightarrow> asid) \<Rightarrow> asidcontrol_invocation \<Rightarrow> asidcontrol_invocation"
where
  "makePoolBase_update f (MakePool v0 v1 v2 v3) = MakePool v0 v1 v2 (f v3)"

abbreviation (input)
  MakePool_trans :: "(machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (asid) \<Rightarrow> asidcontrol_invocation" ("MakePool'_ \<lparr> makePoolFrame= _, makePoolSlot= _, makePoolParent= _, makePoolBase= _ \<rparr>")
where
  "MakePool_ \<lparr> makePoolFrame= v0, makePoolSlot= v1, makePoolParent= v2, makePoolBase= v3 \<rparr> == MakePool v0 v1 v2 v3"

lemma makePoolFrame_makePoolFrame_update [simp]:
  "makePoolFrame (makePoolFrame_update f v) = f (makePoolFrame v)"
  by (cases v) simp

lemma makePoolFrame_makePoolSlot_update [simp]:
  "makePoolFrame (makePoolSlot_update f v) = makePoolFrame v"
  by (cases v) simp

lemma makePoolFrame_makePoolParent_update [simp]:
  "makePoolFrame (makePoolParent_update f v) = makePoolFrame v"
  by (cases v) simp

lemma makePoolFrame_makePoolBase_update [simp]:
  "makePoolFrame (makePoolBase_update f v) = makePoolFrame v"
  by (cases v) simp

lemma makePoolSlot_makePoolFrame_update [simp]:
  "makePoolSlot (makePoolFrame_update f v) = makePoolSlot v"
  by (cases v) simp

lemma makePoolSlot_makePoolSlot_update [simp]:
  "makePoolSlot (makePoolSlot_update f v) = f (makePoolSlot v)"
  by (cases v) simp

lemma makePoolSlot_makePoolParent_update [simp]:
  "makePoolSlot (makePoolParent_update f v) = makePoolSlot v"
  by (cases v) simp

lemma makePoolSlot_makePoolBase_update [simp]:
  "makePoolSlot (makePoolBase_update f v) = makePoolSlot v"
  by (cases v) simp

lemma makePoolParent_makePoolFrame_update [simp]:
  "makePoolParent (makePoolFrame_update f v) = makePoolParent v"
  by (cases v) simp

lemma makePoolParent_makePoolSlot_update [simp]:
  "makePoolParent (makePoolSlot_update f v) = makePoolParent v"
  by (cases v) simp

lemma makePoolParent_makePoolParent_update [simp]:
  "makePoolParent (makePoolParent_update f v) = f (makePoolParent v)"
  by (cases v) simp

lemma makePoolParent_makePoolBase_update [simp]:
  "makePoolParent (makePoolBase_update f v) = makePoolParent v"
  by (cases v) simp

lemma makePoolBase_makePoolFrame_update [simp]:
  "makePoolBase (makePoolFrame_update f v) = makePoolBase v"
  by (cases v) simp

lemma makePoolBase_makePoolSlot_update [simp]:
  "makePoolBase (makePoolSlot_update f v) = makePoolBase v"
  by (cases v) simp

lemma makePoolBase_makePoolParent_update [simp]:
  "makePoolBase (makePoolParent_update f v) = makePoolBase v"
  by (cases v) simp

lemma makePoolBase_makePoolBase_update [simp]:
  "makePoolBase (makePoolBase_update f v) = f (makePoolBase v)"
  by (cases v) simp

datatype asidpool_invocation =
    Assign (assignASID : asid) (assignASIDPool : machine_word) (assignASIDCTSlot : machine_word)

primrec
  assignASID_update :: "(asid \<Rightarrow> asid) \<Rightarrow> asidpool_invocation \<Rightarrow> asidpool_invocation"
where
  "assignASID_update f (Assign v0 v1 v2) = Assign (f v0) v1 v2"

primrec
  assignASIDPool_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> asidpool_invocation \<Rightarrow> asidpool_invocation"
where
  "assignASIDPool_update f (Assign v0 v1 v2) = Assign v0 (f v1) v2"

primrec
  assignASIDCTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> asidpool_invocation \<Rightarrow> asidpool_invocation"
where
  "assignASIDCTSlot_update f (Assign v0 v1 v2) = Assign v0 v1 (f v2)"

abbreviation (input)
  Assign_trans :: "(asid) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> asidpool_invocation" ("Assign'_ \<lparr> assignASID= _, assignASIDPool= _, assignASIDCTSlot= _ \<rparr>")
where
  "Assign_ \<lparr> assignASID= v0, assignASIDPool= v1, assignASIDCTSlot= v2 \<rparr> == Assign v0 v1 v2"

lemma assignASID_assignASID_update [simp]:
  "assignASID (assignASID_update f v) = f (assignASID v)"
  by (cases v) simp

lemma assignASID_assignASIDPool_update [simp]:
  "assignASID (assignASIDPool_update f v) = assignASID v"
  by (cases v) simp

lemma assignASID_assignASIDCTSlot_update [simp]:
  "assignASID (assignASIDCTSlot_update f v) = assignASID v"
  by (cases v) simp

lemma assignASIDPool_assignASID_update [simp]:
  "assignASIDPool (assignASID_update f v) = assignASIDPool v"
  by (cases v) simp

lemma assignASIDPool_assignASIDPool_update [simp]:
  "assignASIDPool (assignASIDPool_update f v) = f (assignASIDPool v)"
  by (cases v) simp

lemma assignASIDPool_assignASIDCTSlot_update [simp]:
  "assignASIDPool (assignASIDCTSlot_update f v) = assignASIDPool v"
  by (cases v) simp

lemma assignASIDCTSlot_assignASID_update [simp]:
  "assignASIDCTSlot (assignASID_update f v) = assignASIDCTSlot v"
  by (cases v) simp

lemma assignASIDCTSlot_assignASIDPool_update [simp]:
  "assignASIDCTSlot (assignASIDPool_update f v) = assignASIDCTSlot v"
  by (cases v) simp

lemma assignASIDCTSlot_assignASIDCTSlot_update [simp]:
  "assignASIDCTSlot (assignASIDCTSlot_update f v) = f (assignASIDCTSlot v)"
  by (cases v) simp

type_synonym hyper_reg = "vcpureg"

type_synonym hyper_reg_val = "machine_word"

datatype vcpuinvocation =
    VCPUSetTCB machine_word machine_word
  | VCPUInjectIRQ machine_word nat virq
  | VCPUReadRegister machine_word hyper_reg
  | VCPUWriteRegister machine_word hyper_reg hyper_reg_val
  | VCPUAckVPPI machine_word vppievent_irq

datatype copy_register_sets =
    ARMNoExtraRegisters


datatype invocation =
    InvokeVSpace vspace_invocation
  | InvokePageTable page_table_invocation
  | InvokePage page_invocation
  | InvokeASIDControl asidcontrol_invocation
  | InvokeASIDPool asidpool_invocation
  | InvokeVCPU vcpuinvocation

datatype irqcontrol_invocation =
    IssueIRQHandler (issueHandlerIRQ : irq) (issueHandlerSlot : machine_word) (issueHandlerControllerSlot : machine_word) (issueHandlerTrigger : bool)

primrec
  issueHandlerIRQ_update :: "(irq \<Rightarrow> irq) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIRQ_update f (IssueIRQHandler v0 v1 v2 v3) = IssueIRQHandler (f v0) v1 v2 v3"

primrec
  issueHandlerSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerSlot_update f (IssueIRQHandler v0 v1 v2 v3) = IssueIRQHandler v0 (f v1) v2 v3"

primrec
  issueHandlerControllerSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerControllerSlot_update f (IssueIRQHandler v0 v1 v2 v3) = IssueIRQHandler v0 v1 (f v2) v3"

primrec
  issueHandlerTrigger_update :: "(bool \<Rightarrow> bool) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerTrigger_update f (IssueIRQHandler v0 v1 v2 v3) = IssueIRQHandler v0 v1 v2 (f v3)"

abbreviation (input)
  IssueIRQHandler_trans :: "(irq) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (bool) \<Rightarrow> irqcontrol_invocation" ("IssueIRQHandler'_ \<lparr> issueHandlerIRQ= _, issueHandlerSlot= _, issueHandlerControllerSlot= _, issueHandlerTrigger= _ \<rparr>")
where
  "IssueIRQHandler_ \<lparr> issueHandlerIRQ= v0, issueHandlerSlot= v1, issueHandlerControllerSlot= v2, issueHandlerTrigger= v3 \<rparr> == IssueIRQHandler v0 v1 v2 v3"

lemma issueHandlerIRQ_issueHandlerIRQ_update [simp]:
  "issueHandlerIRQ (issueHandlerIRQ_update f v) = f (issueHandlerIRQ v)"
  by (cases v) simp

lemma issueHandlerIRQ_issueHandlerSlot_update [simp]:
  "issueHandlerIRQ (issueHandlerSlot_update f v) = issueHandlerIRQ v"
  by (cases v) simp

lemma issueHandlerIRQ_issueHandlerControllerSlot_update [simp]:
  "issueHandlerIRQ (issueHandlerControllerSlot_update f v) = issueHandlerIRQ v"
  by (cases v) simp

lemma issueHandlerIRQ_issueHandlerTrigger_update [simp]:
  "issueHandlerIRQ (issueHandlerTrigger_update f v) = issueHandlerIRQ v"
  by (cases v) simp

lemma issueHandlerSlot_issueHandlerIRQ_update [simp]:
  "issueHandlerSlot (issueHandlerIRQ_update f v) = issueHandlerSlot v"
  by (cases v) simp

lemma issueHandlerSlot_issueHandlerSlot_update [simp]:
  "issueHandlerSlot (issueHandlerSlot_update f v) = f (issueHandlerSlot v)"
  by (cases v) simp

lemma issueHandlerSlot_issueHandlerControllerSlot_update [simp]:
  "issueHandlerSlot (issueHandlerControllerSlot_update f v) = issueHandlerSlot v"
  by (cases v) simp

lemma issueHandlerSlot_issueHandlerTrigger_update [simp]:
  "issueHandlerSlot (issueHandlerTrigger_update f v) = issueHandlerSlot v"
  by (cases v) simp

lemma issueHandlerControllerSlot_issueHandlerIRQ_update [simp]:
  "issueHandlerControllerSlot (issueHandlerIRQ_update f v) = issueHandlerControllerSlot v"
  by (cases v) simp

lemma issueHandlerControllerSlot_issueHandlerSlot_update [simp]:
  "issueHandlerControllerSlot (issueHandlerSlot_update f v) = issueHandlerControllerSlot v"
  by (cases v) simp

lemma issueHandlerControllerSlot_issueHandlerControllerSlot_update [simp]:
  "issueHandlerControllerSlot (issueHandlerControllerSlot_update f v) = f (issueHandlerControllerSlot v)"
  by (cases v) simp

lemma issueHandlerControllerSlot_issueHandlerTrigger_update [simp]:
  "issueHandlerControllerSlot (issueHandlerTrigger_update f v) = issueHandlerControllerSlot v"
  by (cases v) simp

lemma issueHandlerTrigger_issueHandlerIRQ_update [simp]:
  "issueHandlerTrigger (issueHandlerIRQ_update f v) = issueHandlerTrigger v"
  by (cases v) simp

lemma issueHandlerTrigger_issueHandlerSlot_update [simp]:
  "issueHandlerTrigger (issueHandlerSlot_update f v) = issueHandlerTrigger v"
  by (cases v) simp

lemma issueHandlerTrigger_issueHandlerControllerSlot_update [simp]:
  "issueHandlerTrigger (issueHandlerControllerSlot_update f v) = issueHandlerTrigger v"
  by (cases v) simp

lemma issueHandlerTrigger_issueHandlerTrigger_update [simp]:
  "issueHandlerTrigger (issueHandlerTrigger_update f v) = f (issueHandlerTrigger v)"
  by (cases v) simp


consts'
deriveCap :: "machine_word \<Rightarrow> arch_capability \<Rightarrow> ( syscall_error , capability ) kernel_f"

consts'
isCapRevocable :: "capability \<Rightarrow> capability \<Rightarrow> bool"

consts'
updateCapData :: "bool \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> capability"

consts'
cteRightsBits :: "nat"

consts'
cteGuardBits :: "nat"

consts'
maskCapRights :: "cap_rights \<Rightarrow> arch_capability \<Rightarrow> capability"

consts'
postCapDeletion :: "arch_capability \<Rightarrow> unit kernel"

consts'
finaliseCap :: "arch_capability \<Rightarrow> bool \<Rightarrow> (capability * capability) kernel"

consts'
sameRegionAs :: "arch_capability \<Rightarrow> arch_capability \<Rightarrow> bool"

consts'
isPhysicalCap :: "arch_capability \<Rightarrow> bool"

consts'
sameObjectAs :: "arch_capability \<Rightarrow> arch_capability \<Rightarrow> bool"

consts'
placeNewDataObject :: "machine_word \<Rightarrow> nat \<Rightarrow> bool \<Rightarrow> unit kernel"

consts'
updatePTType :: "machine_word \<Rightarrow> pt_type \<Rightarrow> unit kernel"

consts'
createObject :: "object_type \<Rightarrow> machine_word \<Rightarrow> nat \<Rightarrow> bool \<Rightarrow> arch_capability kernel"

consts'
decodeInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> cptr \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
performInvocation :: "invocation \<Rightarrow> machine_word list kernel_p"

consts'
capUntypedPtr :: "arch_capability \<Rightarrow> machine_word"

consts'
asidPoolBits :: "nat"

consts'
capUntypedSize :: "arch_capability \<Rightarrow> machine_word"

consts'
fpuThreadDelete :: "machine_word \<Rightarrow> unit kernel"

consts'
prepareThreadDelete :: "machine_word \<Rightarrow> unit kernel"


end (*context AARCH64*)

(* Defined differently and/or delayed on different architectures *)
consts canonicalAddressAssert :: "machine_word => bool"

end
