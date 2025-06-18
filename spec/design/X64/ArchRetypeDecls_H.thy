(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchRetypeDecls_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
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

context Arch begin global_naming X64_H

datatype pdptinvocation =
    PDPTUnmap (pdptUnmapCap : arch_capability) (pdptUnmapCapSlot : machine_word)
  | PDPTMap (pdptMapCap : capability) (pdptMapCTSlot : machine_word) (pdptMapPML4E : pml4e) (pdptMapPML4Slot : machine_word) (pdptMapVSpace : machine_word)

primrec
  pdptUnmapCap_update :: "(arch_capability \<Rightarrow> arch_capability) \<Rightarrow> pdptinvocation \<Rightarrow> pdptinvocation"
where
  "pdptUnmapCap_update f (PDPTUnmap v0 v1) = PDPTUnmap (f v0) v1"

primrec
  pdptUnmapCapSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> pdptinvocation \<Rightarrow> pdptinvocation"
where
  "pdptUnmapCapSlot_update f (PDPTUnmap v0 v1) = PDPTUnmap v0 (f v1)"

primrec
  pdptMapCap_update :: "(capability \<Rightarrow> capability) \<Rightarrow> pdptinvocation \<Rightarrow> pdptinvocation"
where
  "pdptMapCap_update f (PDPTMap v0 v1 v2 v3 v4) = PDPTMap (f v0) v1 v2 v3 v4"

primrec
  pdptMapCTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> pdptinvocation \<Rightarrow> pdptinvocation"
where
  "pdptMapCTSlot_update f (PDPTMap v0 v1 v2 v3 v4) = PDPTMap v0 (f v1) v2 v3 v4"

primrec
  pdptMapPML4E_update :: "(pml4e \<Rightarrow> pml4e) \<Rightarrow> pdptinvocation \<Rightarrow> pdptinvocation"
where
  "pdptMapPML4E_update f (PDPTMap v0 v1 v2 v3 v4) = PDPTMap v0 v1 (f v2) v3 v4"

primrec
  pdptMapPML4Slot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> pdptinvocation \<Rightarrow> pdptinvocation"
where
  "pdptMapPML4Slot_update f (PDPTMap v0 v1 v2 v3 v4) = PDPTMap v0 v1 v2 (f v3) v4"

primrec
  pdptMapVSpace_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> pdptinvocation \<Rightarrow> pdptinvocation"
where
  "pdptMapVSpace_update f (PDPTMap v0 v1 v2 v3 v4) = PDPTMap v0 v1 v2 v3 (f v4)"

abbreviation (input)
  PDPTUnmap_trans :: "(arch_capability) \<Rightarrow> (machine_word) \<Rightarrow> pdptinvocation" ("PDPTUnmap'_ \<lparr> pdptUnmapCap= _, pdptUnmapCapSlot= _ \<rparr>")
where
  "PDPTUnmap_ \<lparr> pdptUnmapCap= v0, pdptUnmapCapSlot= v1 \<rparr> == PDPTUnmap v0 v1"

abbreviation (input)
  PDPTMap_trans :: "(capability) \<Rightarrow> (machine_word) \<Rightarrow> (pml4e) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> pdptinvocation" ("PDPTMap'_ \<lparr> pdptMapCap= _, pdptMapCTSlot= _, pdptMapPML4E= _, pdptMapPML4Slot= _, pdptMapVSpace= _ \<rparr>")
where
  "PDPTMap_ \<lparr> pdptMapCap= v0, pdptMapCTSlot= v1, pdptMapPML4E= v2, pdptMapPML4Slot= v3, pdptMapVSpace= v4 \<rparr> == PDPTMap v0 v1 v2 v3 v4"

definition
  isPDPTUnmap :: "pdptinvocation \<Rightarrow> bool"
where
 "isPDPTUnmap v \<equiv> case v of
    PDPTUnmap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPDPTMap :: "pdptinvocation \<Rightarrow> bool"
where
 "isPDPTMap v \<equiv> case v of
    PDPTMap v0 v1 v2 v3 v4 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype page_directory_invocation =
    PageDirectoryUnmap (pdUnmapCap : arch_capability) (pdUnmapCapSlot : machine_word)
  | PageDirectoryMap (pdMapCap : capability) (pdMapCTSlot : machine_word) (pdMapPDPTE : pdpte) (pdMapPDPTSlot : machine_word) (pdMapVSpace : machine_word)

primrec
  pdUnmapCap_update :: "(arch_capability \<Rightarrow> arch_capability) \<Rightarrow> page_directory_invocation \<Rightarrow> page_directory_invocation"
where
  "pdUnmapCap_update f (PageDirectoryUnmap v0 v1) = PageDirectoryUnmap (f v0) v1"

primrec
  pdUnmapCapSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_directory_invocation \<Rightarrow> page_directory_invocation"
where
  "pdUnmapCapSlot_update f (PageDirectoryUnmap v0 v1) = PageDirectoryUnmap v0 (f v1)"

primrec
  pdMapCap_update :: "(capability \<Rightarrow> capability) \<Rightarrow> page_directory_invocation \<Rightarrow> page_directory_invocation"
where
  "pdMapCap_update f (PageDirectoryMap v0 v1 v2 v3 v4) = PageDirectoryMap (f v0) v1 v2 v3 v4"

primrec
  pdMapCTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_directory_invocation \<Rightarrow> page_directory_invocation"
where
  "pdMapCTSlot_update f (PageDirectoryMap v0 v1 v2 v3 v4) = PageDirectoryMap v0 (f v1) v2 v3 v4"

primrec
  pdMapPDPTE_update :: "(pdpte \<Rightarrow> pdpte) \<Rightarrow> page_directory_invocation \<Rightarrow> page_directory_invocation"
where
  "pdMapPDPTE_update f (PageDirectoryMap v0 v1 v2 v3 v4) = PageDirectoryMap v0 v1 (f v2) v3 v4"

primrec
  pdMapPDPTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_directory_invocation \<Rightarrow> page_directory_invocation"
where
  "pdMapPDPTSlot_update f (PageDirectoryMap v0 v1 v2 v3 v4) = PageDirectoryMap v0 v1 v2 (f v3) v4"

primrec
  pdMapVSpace_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_directory_invocation \<Rightarrow> page_directory_invocation"
where
  "pdMapVSpace_update f (PageDirectoryMap v0 v1 v2 v3 v4) = PageDirectoryMap v0 v1 v2 v3 (f v4)"

abbreviation (input)
  PageDirectoryUnmap_trans :: "(arch_capability) \<Rightarrow> (machine_word) \<Rightarrow> page_directory_invocation" ("PageDirectoryUnmap'_ \<lparr> pdUnmapCap= _, pdUnmapCapSlot= _ \<rparr>")
where
  "PageDirectoryUnmap_ \<lparr> pdUnmapCap= v0, pdUnmapCapSlot= v1 \<rparr> == PageDirectoryUnmap v0 v1"

abbreviation (input)
  PageDirectoryMap_trans :: "(capability) \<Rightarrow> (machine_word) \<Rightarrow> (pdpte) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> page_directory_invocation" ("PageDirectoryMap'_ \<lparr> pdMapCap= _, pdMapCTSlot= _, pdMapPDPTE= _, pdMapPDPTSlot= _, pdMapVSpace= _ \<rparr>")
where
  "PageDirectoryMap_ \<lparr> pdMapCap= v0, pdMapCTSlot= v1, pdMapPDPTE= v2, pdMapPDPTSlot= v3, pdMapVSpace= v4 \<rparr> == PageDirectoryMap v0 v1 v2 v3 v4"

definition
  isPageDirectoryUnmap :: "page_directory_invocation \<Rightarrow> bool"
where
 "isPageDirectoryUnmap v \<equiv> case v of
    PageDirectoryUnmap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageDirectoryMap :: "page_directory_invocation \<Rightarrow> bool"
where
 "isPageDirectoryMap v \<equiv> case v of
    PageDirectoryMap v0 v1 v2 v3 v4 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype page_table_invocation =
    PageTableUnmap (ptUnmapCap : arch_capability) (ptUnmapCapSlot : machine_word)
  | PageTableMap (ptMapCap : capability) (ptMapCTSlot : machine_word) (ptMapPDE : pde) (ptMapPDSlot : machine_word) (ptMapVSpace : machine_word)

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
  "ptMapCap_update f (PageTableMap v0 v1 v2 v3 v4) = PageTableMap (f v0) v1 v2 v3 v4"

primrec
  ptMapCTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptMapCTSlot_update f (PageTableMap v0 v1 v2 v3 v4) = PageTableMap v0 (f v1) v2 v3 v4"

primrec
  ptMapPDE_update :: "(pde \<Rightarrow> pde) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptMapPDE_update f (PageTableMap v0 v1 v2 v3 v4) = PageTableMap v0 v1 (f v2) v3 v4"

primrec
  ptMapPDSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptMapPDSlot_update f (PageTableMap v0 v1 v2 v3 v4) = PageTableMap v0 v1 v2 (f v3) v4"

primrec
  ptMapVSpace_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_table_invocation \<Rightarrow> page_table_invocation"
where
  "ptMapVSpace_update f (PageTableMap v0 v1 v2 v3 v4) = PageTableMap v0 v1 v2 v3 (f v4)"

abbreviation (input)
  PageTableUnmap_trans :: "(arch_capability) \<Rightarrow> (machine_word) \<Rightarrow> page_table_invocation" ("PageTableUnmap'_ \<lparr> ptUnmapCap= _, ptUnmapCapSlot= _ \<rparr>")
where
  "PageTableUnmap_ \<lparr> ptUnmapCap= v0, ptUnmapCapSlot= v1 \<rparr> == PageTableUnmap v0 v1"

abbreviation (input)
  PageTableMap_trans :: "(capability) \<Rightarrow> (machine_word) \<Rightarrow> (pde) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> page_table_invocation" ("PageTableMap'_ \<lparr> ptMapCap= _, ptMapCTSlot= _, ptMapPDE= _, ptMapPDSlot= _, ptMapVSpace= _ \<rparr>")
where
  "PageTableMap_ \<lparr> ptMapCap= v0, ptMapCTSlot= v1, ptMapPDE= v2, ptMapPDSlot= v3, ptMapVSpace= v4 \<rparr> == PageTableMap v0 v1 v2 v3 v4"

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
    PageTableMap v0 v1 v2 v3 v4 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype page_invocation =
    PageGetAddr (pageGetBasePtr : machine_word)
  | PageMap (pageMapCap : capability) (pageMapCTSlot : machine_word) (pageMapEntries : "(vmpage_entry * vmpage_entry_ptr)") (pageMapVSpace : machine_word)
  | PageUnmap (pageUnmapCap : arch_capability) (pageUnmapCapSlot : machine_word)

primrec
  pageGetBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageGetBasePtr_update f (PageGetAddr v0) = PageGetAddr (f v0)"

primrec
  pageMapCap_update :: "(capability \<Rightarrow> capability) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageMapCap_update f (PageMap v0 v1 v2 v3) = PageMap (f v0) v1 v2 v3"

primrec
  pageMapCTSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageMapCTSlot_update f (PageMap v0 v1 v2 v3) = PageMap v0 (f v1) v2 v3"

primrec
  pageMapEntries_update :: "(((vmpage_entry * vmpage_entry_ptr)) \<Rightarrow> ((vmpage_entry * vmpage_entry_ptr))) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageMapEntries_update f (PageMap v0 v1 v2 v3) = PageMap v0 v1 (f v2) v3"

primrec
  pageMapVSpace_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageMapVSpace_update f (PageMap v0 v1 v2 v3) = PageMap v0 v1 v2 (f v3)"

primrec
  pageUnmapCap_update :: "(arch_capability \<Rightarrow> arch_capability) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageUnmapCap_update f (PageUnmap v0 v1) = PageUnmap (f v0) v1"

primrec
  pageUnmapCapSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> page_invocation \<Rightarrow> page_invocation"
where
  "pageUnmapCapSlot_update f (PageUnmap v0 v1) = PageUnmap v0 (f v1)"

abbreviation (input)
  PageGetAddr_trans :: "(machine_word) \<Rightarrow> page_invocation" ("PageGetAddr'_ \<lparr> pageGetBasePtr= _ \<rparr>")
where
  "PageGetAddr_ \<lparr> pageGetBasePtr= v0 \<rparr> == PageGetAddr v0"

abbreviation (input)
  PageMap_trans :: "(capability) \<Rightarrow> (machine_word) \<Rightarrow> ((vmpage_entry * vmpage_entry_ptr)) \<Rightarrow> (machine_word) \<Rightarrow> page_invocation" ("PageMap'_ \<lparr> pageMapCap= _, pageMapCTSlot= _, pageMapEntries= _, pageMapVSpace= _ \<rparr>")
where
  "PageMap_ \<lparr> pageMapCap= v0, pageMapCTSlot= v1, pageMapEntries= v2, pageMapVSpace= v3 \<rparr> == PageMap v0 v1 v2 v3"

abbreviation (input)
  PageUnmap_trans :: "(arch_capability) \<Rightarrow> (machine_word) \<Rightarrow> page_invocation" ("PageUnmap'_ \<lparr> pageUnmapCap= _, pageUnmapCapSlot= _ \<rparr>")
where
  "PageUnmap_ \<lparr> pageUnmapCap= v0, pageUnmapCapSlot= v1 \<rparr> == PageUnmap v0 v1"

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
    PageMap v0 v1 v2 v3 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageUnmap :: "page_invocation \<Rightarrow> bool"
where
 "isPageUnmap v \<equiv> case v of
    PageUnmap v0 v1 \<Rightarrow> True
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

datatype ioport_invocation_data =
    IOPortIn8
  | IOPortIn16
  | IOPortIn32
  | IOPortOut8 word8
  | IOPortOut16 word16
  | IOPortOut32 word32

datatype ioport_invocation =
    IOPortInvocation ioport ioport_invocation_data

datatype ioport_control_invocation =
    IOPortControlIssue (issueFirst : ioport) (issueLast : ioport) (issueDestSlot : machine_word) (issueControlSlot : machine_word)

primrec
  issueFirst_update :: "(ioport \<Rightarrow> ioport) \<Rightarrow> ioport_control_invocation \<Rightarrow> ioport_control_invocation"
where
  "issueFirst_update f (IOPortControlIssue v0 v1 v2 v3) = IOPortControlIssue (f v0) v1 v2 v3"

primrec
  issueLast_update :: "(ioport \<Rightarrow> ioport) \<Rightarrow> ioport_control_invocation \<Rightarrow> ioport_control_invocation"
where
  "issueLast_update f (IOPortControlIssue v0 v1 v2 v3) = IOPortControlIssue v0 (f v1) v2 v3"

primrec
  issueDestSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> ioport_control_invocation \<Rightarrow> ioport_control_invocation"
where
  "issueDestSlot_update f (IOPortControlIssue v0 v1 v2 v3) = IOPortControlIssue v0 v1 (f v2) v3"

primrec
  issueControlSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> ioport_control_invocation \<Rightarrow> ioport_control_invocation"
where
  "issueControlSlot_update f (IOPortControlIssue v0 v1 v2 v3) = IOPortControlIssue v0 v1 v2 (f v3)"

abbreviation (input)
  IOPortControlIssue_trans :: "(ioport) \<Rightarrow> (ioport) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> ioport_control_invocation" ("IOPortControlIssue'_ \<lparr> issueFirst= _, issueLast= _, issueDestSlot= _, issueControlSlot= _ \<rparr>")
where
  "IOPortControlIssue_ \<lparr> issueFirst= v0, issueLast= v1, issueDestSlot= v2, issueControlSlot= v3 \<rparr> == IOPortControlIssue v0 v1 v2 v3"

lemma issueFirst_issueFirst_update [simp]:
  "issueFirst (issueFirst_update f v) = f (issueFirst v)"
  by (cases v) simp

lemma issueFirst_issueLast_update [simp]:
  "issueFirst (issueLast_update f v) = issueFirst v"
  by (cases v) simp

lemma issueFirst_issueDestSlot_update [simp]:
  "issueFirst (issueDestSlot_update f v) = issueFirst v"
  by (cases v) simp

lemma issueFirst_issueControlSlot_update [simp]:
  "issueFirst (issueControlSlot_update f v) = issueFirst v"
  by (cases v) simp

lemma issueLast_issueFirst_update [simp]:
  "issueLast (issueFirst_update f v) = issueLast v"
  by (cases v) simp

lemma issueLast_issueLast_update [simp]:
  "issueLast (issueLast_update f v) = f (issueLast v)"
  by (cases v) simp

lemma issueLast_issueDestSlot_update [simp]:
  "issueLast (issueDestSlot_update f v) = issueLast v"
  by (cases v) simp

lemma issueLast_issueControlSlot_update [simp]:
  "issueLast (issueControlSlot_update f v) = issueLast v"
  by (cases v) simp

lemma issueDestSlot_issueFirst_update [simp]:
  "issueDestSlot (issueFirst_update f v) = issueDestSlot v"
  by (cases v) simp

lemma issueDestSlot_issueLast_update [simp]:
  "issueDestSlot (issueLast_update f v) = issueDestSlot v"
  by (cases v) simp

lemma issueDestSlot_issueDestSlot_update [simp]:
  "issueDestSlot (issueDestSlot_update f v) = f (issueDestSlot v)"
  by (cases v) simp

lemma issueDestSlot_issueControlSlot_update [simp]:
  "issueDestSlot (issueControlSlot_update f v) = issueDestSlot v"
  by (cases v) simp

lemma issueControlSlot_issueFirst_update [simp]:
  "issueControlSlot (issueFirst_update f v) = issueControlSlot v"
  by (cases v) simp

lemma issueControlSlot_issueLast_update [simp]:
  "issueControlSlot (issueLast_update f v) = issueControlSlot v"
  by (cases v) simp

lemma issueControlSlot_issueDestSlot_update [simp]:
  "issueControlSlot (issueDestSlot_update f v) = issueControlSlot v"
  by (cases v) simp

lemma issueControlSlot_issueControlSlot_update [simp]:
  "issueControlSlot (issueControlSlot_update f v) = f (issueControlSlot v)"
  by (cases v) simp

datatype copy_register_sets =
    X64NoExtraRegisters


datatype invocation =
    InvokePDPT pdptinvocation
  | InvokePageDirectory page_directory_invocation
  | InvokePageTable page_table_invocation
  | InvokePage page_invocation
  | InvokeASIDControl asidcontrol_invocation
  | InvokeASIDPool asidpool_invocation
  | InvokeIOPort ioport_invocation
  | InvokeIOPortControl ioport_control_invocation

datatype irqcontrol_invocation =
    IssueIRQHandlerIOAPIC (issueHandlerIOAPICIRQ : irq) (issueHandlerIOAPICSlot : machine_word) (issueHandlerIOAPICControllerSlot : machine_word) (issueHandlerIOAPICIOAPIC : machine_word) (issueHandlerIOAPICPin : machine_word) (issueHandlerIOAPICLevel : machine_word) (issueHandlerIOAPICPolarity : machine_word) (issueHandlerIOAPICVector : machine_word)
  | IssueIRQHandlerMSI (issueHandlerMSIIRQ : irq) (issueHandlerMSISlot : machine_word) (issueHandlerMSIControllerSlot : machine_word) (issueHandlerMSIPCIBus : machine_word) (issueHandlerMSIPCIDev : machine_word) (issueHandlerMSIPCIFunc : machine_word) (issueHandlerMSIHandle : machine_word)

primrec
  issueHandlerIOAPICIRQ_update :: "(irq \<Rightarrow> irq) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIOAPICIRQ_update f (IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7) = IssueIRQHandlerIOAPIC (f v0) v1 v2 v3 v4 v5 v6 v7"

primrec
  issueHandlerIOAPICSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIOAPICSlot_update f (IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7) = IssueIRQHandlerIOAPIC v0 (f v1) v2 v3 v4 v5 v6 v7"

primrec
  issueHandlerIOAPICControllerSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIOAPICControllerSlot_update f (IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7) = IssueIRQHandlerIOAPIC v0 v1 (f v2) v3 v4 v5 v6 v7"

primrec
  issueHandlerIOAPICIOAPIC_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIOAPICIOAPIC_update f (IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7) = IssueIRQHandlerIOAPIC v0 v1 v2 (f v3) v4 v5 v6 v7"

primrec
  issueHandlerIOAPICPin_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIOAPICPin_update f (IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7) = IssueIRQHandlerIOAPIC v0 v1 v2 v3 (f v4) v5 v6 v7"

primrec
  issueHandlerIOAPICLevel_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIOAPICLevel_update f (IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7) = IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 (f v5) v6 v7"

primrec
  issueHandlerIOAPICPolarity_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIOAPICPolarity_update f (IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7) = IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 (f v6) v7"

primrec
  issueHandlerIOAPICVector_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerIOAPICVector_update f (IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7) = IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 (f v7)"

primrec
  issueHandlerMSIIRQ_update :: "(irq \<Rightarrow> irq) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerMSIIRQ_update f (IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6) = IssueIRQHandlerMSI (f v0) v1 v2 v3 v4 v5 v6"

primrec
  issueHandlerMSISlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerMSISlot_update f (IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6) = IssueIRQHandlerMSI v0 (f v1) v2 v3 v4 v5 v6"

primrec
  issueHandlerMSIControllerSlot_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerMSIControllerSlot_update f (IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6) = IssueIRQHandlerMSI v0 v1 (f v2) v3 v4 v5 v6"

primrec
  issueHandlerMSIPCIBus_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerMSIPCIBus_update f (IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6) = IssueIRQHandlerMSI v0 v1 v2 (f v3) v4 v5 v6"

primrec
  issueHandlerMSIPCIDev_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerMSIPCIDev_update f (IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6) = IssueIRQHandlerMSI v0 v1 v2 v3 (f v4) v5 v6"

primrec
  issueHandlerMSIPCIFunc_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerMSIPCIFunc_update f (IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6) = IssueIRQHandlerMSI v0 v1 v2 v3 v4 (f v5) v6"

primrec
  issueHandlerMSIHandle_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> irqcontrol_invocation \<Rightarrow> irqcontrol_invocation"
where
  "issueHandlerMSIHandle_update f (IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6) = IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 (f v6)"

abbreviation (input)
  IssueIRQHandlerIOAPIC_trans :: "(irq) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> irqcontrol_invocation" ("IssueIRQHandlerIOAPIC'_ \<lparr> issueHandlerIOAPICIRQ= _, issueHandlerIOAPICSlot= _, issueHandlerIOAPICControllerSlot= _, issueHandlerIOAPICIOAPIC= _, issueHandlerIOAPICPin= _, issueHandlerIOAPICLevel= _, issueHandlerIOAPICPolarity= _, issueHandlerIOAPICVector= _ \<rparr>")
where
  "IssueIRQHandlerIOAPIC_ \<lparr> issueHandlerIOAPICIRQ= v0, issueHandlerIOAPICSlot= v1, issueHandlerIOAPICControllerSlot= v2, issueHandlerIOAPICIOAPIC= v3, issueHandlerIOAPICPin= v4, issueHandlerIOAPICLevel= v5, issueHandlerIOAPICPolarity= v6, issueHandlerIOAPICVector= v7 \<rparr> == IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7"

abbreviation (input)
  IssueIRQHandlerMSI_trans :: "(irq) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> irqcontrol_invocation" ("IssueIRQHandlerMSI'_ \<lparr> issueHandlerMSIIRQ= _, issueHandlerMSISlot= _, issueHandlerMSIControllerSlot= _, issueHandlerMSIPCIBus= _, issueHandlerMSIPCIDev= _, issueHandlerMSIPCIFunc= _, issueHandlerMSIHandle= _ \<rparr>")
where
  "IssueIRQHandlerMSI_ \<lparr> issueHandlerMSIIRQ= v0, issueHandlerMSISlot= v1, issueHandlerMSIControllerSlot= v2, issueHandlerMSIPCIBus= v3, issueHandlerMSIPCIDev= v4, issueHandlerMSIPCIFunc= v5, issueHandlerMSIHandle= v6 \<rparr> == IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6"

definition
  isIssueIRQHandlerIOAPIC :: "irqcontrol_invocation \<Rightarrow> bool"
where
 "isIssueIRQHandlerIOAPIC v \<equiv> case v of
    IssueIRQHandlerIOAPIC v0 v1 v2 v3 v4 v5 v6 v7 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isIssueIRQHandlerMSI :: "irqcontrol_invocation \<Rightarrow> bool"
where
 "isIssueIRQHandlerMSI v \<equiv> case v of
    IssueIRQHandlerMSI v0 v1 v2 v3 v4 v5 v6 \<Rightarrow> True
  | _ \<Rightarrow> False"


consts'
deriveCap :: "machine_word \<Rightarrow> arch_capability \<Rightarrow> ( syscall_error , capability ) kernel_f"

consts'
isIOPortControlCap' :: "capability \<Rightarrow> bool"

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
setIOPortMask :: "ioport \<Rightarrow> ioport \<Rightarrow> bool \<Rightarrow> unit kernel"

consts'
freeIOPortRange :: "ioport \<Rightarrow> ioport \<Rightarrow> unit kernel"

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
createObject :: "object_type \<Rightarrow> machine_word \<Rightarrow> nat \<Rightarrow> bool \<Rightarrow> arch_capability kernel"

consts'
isIOCap :: "arch_capability \<Rightarrow> bool"

consts'
decodeInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> cptr \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
performInvocation :: "invocation \<Rightarrow> machine_word list kernel_p"

consts'
capUntypedPtr :: "arch_capability \<Rightarrow> machine_word"

consts'
capUntypedSize :: "arch_capability \<Rightarrow> machine_word"

consts'
prepareThreadDelete :: "machine_word \<Rightarrow> unit kernel"

consts'
fpuThreadDelete :: "machine_word \<Rightarrow> unit kernel"


end (*context X64*)

(* Defined differently and/or delayed on different architectures *)
definition
  canonicalAddressAssert :: "machine_word => bool" where
  canonicalAddressAssert_def[simp]:
  "canonicalAddressAssert p = True"

end
