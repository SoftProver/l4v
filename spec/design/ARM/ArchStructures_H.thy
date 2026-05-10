(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchStructures_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

theory ArchStructures_H
imports
  "Lib.Lib"
  Types_H
  Hardware_H
begin
context Arch begin global_naming ARM_H


type_synonym asid = "word32"

definition
  ASID :: "asid \<Rightarrow> asid"
where ASID_def[simp]:
 "ASID \<equiv> id"

datatype arch_capability =
    ASIDPoolCap (capASIDPool : machine_word) (capASIDBase : asid)
  | ASIDControlCap
  | PageCap (capVPIsDevice : bool) (capVPBasePtr : machine_word) (capVPRights : vmrights) (capVPSize : vmpage_size) (capVPMappedAddress : "(asid * vptr) option")
  | PageTableCap (capPTBasePtr : machine_word) (capPTMappedAddress : "(asid * vptr) option")
  | PageDirectoryCap (capPDBasePtr : machine_word) (capPDMappedASID : "asid option")

primrec
  capASIDPool_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capASIDPool_update f (ASIDPoolCap v0 v1) = ASIDPoolCap (f v0) v1"

primrec
  capASIDBase_update :: "(asid \<Rightarrow> asid) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capASIDBase_update f (ASIDPoolCap v0 v1) = ASIDPoolCap v0 (f v1)"

primrec
  capVPIsDevice_update :: "(bool \<Rightarrow> bool) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPIsDevice_update f (PageCap v0 v1 v2 v3 v4) = PageCap (f v0) v1 v2 v3 v4"

primrec
  capVPBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPBasePtr_update f (PageCap v0 v1 v2 v3 v4) = PageCap v0 (f v1) v2 v3 v4"

primrec
  capVPRights_update :: "(vmrights \<Rightarrow> vmrights) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPRights_update f (PageCap v0 v1 v2 v3 v4) = PageCap v0 v1 (f v2) v3 v4"

primrec
  capVPSize_update :: "(vmpage_size \<Rightarrow> vmpage_size) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPSize_update f (PageCap v0 v1 v2 v3 v4) = PageCap v0 v1 v2 (f v3) v4"

primrec
  capVPMappedAddress_update :: "(((asid * vptr) option) \<Rightarrow> ((asid * vptr) option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPMappedAddress_update f (PageCap v0 v1 v2 v3 v4) = PageCap v0 v1 v2 v3 (f v4)"

primrec
  capPTBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPTBasePtr_update f (PageTableCap v0 v1) = PageTableCap (f v0) v1"

primrec
  capPTMappedAddress_update :: "(((asid * vptr) option) \<Rightarrow> ((asid * vptr) option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPTMappedAddress_update f (PageTableCap v0 v1) = PageTableCap v0 (f v1)"

primrec
  capPDBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPDBasePtr_update f (PageDirectoryCap v0 v1) = PageDirectoryCap (f v0) v1"

primrec
  capPDMappedASID_update :: "((asid option) \<Rightarrow> (asid option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPDMappedASID_update f (PageDirectoryCap v0 v1) = PageDirectoryCap v0 (f v1)"

abbreviation (input)
  ASIDPoolCap_trans :: "(machine_word) \<Rightarrow> (asid) \<Rightarrow> arch_capability" ("ASIDPoolCap'_ \<lparr> capASIDPool= _, capASIDBase= _ \<rparr>")
where
  "ASIDPoolCap_ \<lparr> capASIDPool= v0, capASIDBase= v1 \<rparr> == ASIDPoolCap v0 v1"

abbreviation (input)
  PageCap_trans :: "(bool) \<Rightarrow> (machine_word) \<Rightarrow> (vmrights) \<Rightarrow> (vmpage_size) \<Rightarrow> ((asid * vptr) option) \<Rightarrow> arch_capability" ("PageCap'_ \<lparr> capVPIsDevice= _, capVPBasePtr= _, capVPRights= _, capVPSize= _, capVPMappedAddress= _ \<rparr>")
where
  "PageCap_ \<lparr> capVPIsDevice= v0, capVPBasePtr= v1, capVPRights= v2, capVPSize= v3, capVPMappedAddress= v4 \<rparr> == PageCap v0 v1 v2 v3 v4"

abbreviation (input)
  PageTableCap_trans :: "(machine_word) \<Rightarrow> ((asid * vptr) option) \<Rightarrow> arch_capability" ("PageTableCap'_ \<lparr> capPTBasePtr= _, capPTMappedAddress= _ \<rparr>")
where
  "PageTableCap_ \<lparr> capPTBasePtr= v0, capPTMappedAddress= v1 \<rparr> == PageTableCap v0 v1"

abbreviation (input)
  PageDirectoryCap_trans :: "(machine_word) \<Rightarrow> (asid option) \<Rightarrow> arch_capability" ("PageDirectoryCap'_ \<lparr> capPDBasePtr= _, capPDMappedASID= _ \<rparr>")
where
  "PageDirectoryCap_ \<lparr> capPDBasePtr= v0, capPDMappedASID= v1 \<rparr> == PageDirectoryCap v0 v1"

definition
  isASIDPoolCap :: "arch_capability \<Rightarrow> bool"
where
 "isASIDPoolCap v \<equiv> case v of
    ASIDPoolCap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isASIDControlCap :: "arch_capability \<Rightarrow> bool"
where
 "isASIDControlCap v \<equiv> case v of
    ASIDControlCap \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageCap :: "arch_capability \<Rightarrow> bool"
where
 "isPageCap v \<equiv> case v of
    PageCap v0 v1 v2 v3 v4 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageTableCap :: "arch_capability \<Rightarrow> bool"
where
 "isPageTableCap v \<equiv> case v of
    PageTableCap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageDirectoryCap :: "arch_capability \<Rightarrow> bool"
where
 "isPageDirectoryCap v \<equiv> case v of
    PageDirectoryCap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype asidpool =
    ASIDPool "asid \<Rightarrow> ((machine_word) option)"

datatype arch_kernel_object =
    KOASIDPool asidpool
  | KOPTE pte
  | KOPDE pde

datatype arch_tcb =
    ArchThread (atcbContext : user_context)

primrec
  atcbContext_update :: "(user_context \<Rightarrow> user_context) \<Rightarrow> arch_tcb \<Rightarrow> arch_tcb"
where
  "atcbContext_update f (ArchThread v0) = ArchThread (f v0)"

abbreviation (input)
  ArchThread_trans :: "(user_context) \<Rightarrow> arch_tcb" ("ArchThread'_ \<lparr> atcbContext= _ \<rparr>")
where
  "ArchThread_ \<lparr> atcbContext= v0 \<rparr> == ArchThread v0"

lemma atcbContext_atcbContext_update [simp]:
  "atcbContext (atcbContext_update f v) = f (atcbContext v)"
  by (cases v) simp

consts'
minUntypedSizeBits :: "nat"

consts'
maxUntypedSizeBits :: "nat"

consts'
archObjSize :: "arch_kernel_object \<Rightarrow> nat"

consts'
atcbContextSet :: "user_context \<Rightarrow> arch_tcb \<Rightarrow> arch_tcb"

consts'
atcbContextGet :: "arch_tcb \<Rightarrow> user_context"

consts'
asidHighBits :: "nat"

consts'
asidLowBits :: "nat"

consts'
asidBits :: "nat"

consts'
asidRange :: "(asid * asid)"

consts'
asidHighBitsOf :: "asid \<Rightarrow> asid"

defs minUntypedSizeBits_def:
"minUntypedSizeBits \<equiv> 4"

defs maxUntypedSizeBits_def:
"maxUntypedSizeBits \<equiv> 29"

defs archObjSize_def:
"archObjSize a\<equiv> (case a of
                  KOASIDPool v10 \<Rightarrow>   pageBits
                | KOPTE v11 \<Rightarrow>   pteBits
                | KOPDE v12 \<Rightarrow>   pdeBits
                )"

definition
"newArchTCB \<equiv> ArchThread_ \<lparr>
    atcbContext= newContext
    \<rparr>"

defs atcbContextSet_def:
"atcbContextSet uc atcb \<equiv> atcb \<lparr> atcbContext := uc \<rparr>"

defs atcbContextGet_def:
"atcbContextGet \<equiv> atcbContext"

defs asidHighBits_def:
"asidHighBits \<equiv> 7"

defs asidLowBits_def:
"asidLowBits \<equiv> 10"

defs asidBits_def:
"asidBits \<equiv> asidHighBits + asidLowBits"

defs asidRange_def:
"asidRange\<equiv> (0, (1 `~shiftL~` asidBits) - 1)"

defs asidHighBitsOf_def:
"asidHighBitsOf asid\<equiv> (asid `~shiftR~` asidLowBits) && mask asidHighBits"


datatype arch_kernel_object_type =
    PDET
  | PTET
  | ASIDPoolT

primrec
  archTypeOf :: "arch_kernel_object \<Rightarrow> arch_kernel_object_type"
where
  "archTypeOf (KOPDE e) = PDET"
| "archTypeOf (KOPTE e) = PTET"
| "archTypeOf (KOASIDPool e) = ASIDPoolT"

end
end
