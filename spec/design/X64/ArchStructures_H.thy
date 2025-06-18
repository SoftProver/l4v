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

context Arch begin global_naming X64_H


type_synonym asid = "word64"

definition
  ASID :: "asid \<Rightarrow> asid"
where ASID_def[simp]:
 "ASID \<equiv> id"

definition
  fromASID :: "asid \<Rightarrow> asid"
where
  fromASID_def[simp]:
 "fromASID \<equiv> id"

definition  fromASID_update :: "(asid \<Rightarrow> asid) \<Rightarrow> asid \<Rightarrow> asid"
where
  fromASID_update_def[simp]:
 "fromASID_update f y \<equiv> f y"

abbreviation (input)
  ASID_trans :: "(word64) \<Rightarrow> asid" ("ASID'_ \<lparr> fromASID= _ \<rparr>")
where
  "ASID_ \<lparr> fromASID= v0 \<rparr> == ASID v0"

datatype arch_capability =
    ASIDPoolCap (capASIDPool : machine_word) (capASIDBase : asid)
  | ASIDControlCap
  | IOPortCap (capIOPortFirstPort : ioport) (capIOPortLastPort : ioport)
  | IOPortControlCap
  | PageCap (capVPBasePtr : machine_word) (capVPRights : vmrights) (capVPMapType : vmmap_type) (capVPSize : vmpage_size) (capVPIsDevice : bool) (capVPMappedAddress : "(asid * vptr) option")
  | PageTableCap (capPTBasePtr : machine_word) (capPTMappedAddress : "(asid * vptr) option")
  | PageDirectoryCap (capPDBasePtr : machine_word) (capPDMappedAddress : "(asid * vptr) option")
  | PDPointerTableCap (capPDPTBasePtr : machine_word) (capPDPTMappedAddress : "(asid * vptr) option")
  | PML4Cap (capPML4BasePtr : machine_word) (capPML4MappedASID : "asid option")

primrec
  capASIDPool_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capASIDPool_update f (ASIDPoolCap v0 v1) = ASIDPoolCap (f v0) v1"

primrec
  capASIDBase_update :: "(asid \<Rightarrow> asid) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capASIDBase_update f (ASIDPoolCap v0 v1) = ASIDPoolCap v0 (f v1)"

primrec
  capIOPortFirstPort_update :: "(ioport \<Rightarrow> ioport) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capIOPortFirstPort_update f (IOPortCap v0 v1) = IOPortCap (f v0) v1"

primrec
  capIOPortLastPort_update :: "(ioport \<Rightarrow> ioport) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capIOPortLastPort_update f (IOPortCap v0 v1) = IOPortCap v0 (f v1)"

primrec
  capVPBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPBasePtr_update f (PageCap v0 v1 v2 v3 v4 v5) = PageCap (f v0) v1 v2 v3 v4 v5"

primrec
  capVPRights_update :: "(vmrights \<Rightarrow> vmrights) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPRights_update f (PageCap v0 v1 v2 v3 v4 v5) = PageCap v0 (f v1) v2 v3 v4 v5"

primrec
  capVPMapType_update :: "(vmmap_type \<Rightarrow> vmmap_type) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPMapType_update f (PageCap v0 v1 v2 v3 v4 v5) = PageCap v0 v1 (f v2) v3 v4 v5"

primrec
  capVPSize_update :: "(vmpage_size \<Rightarrow> vmpage_size) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPSize_update f (PageCap v0 v1 v2 v3 v4 v5) = PageCap v0 v1 v2 (f v3) v4 v5"

primrec
  capVPIsDevice_update :: "(bool \<Rightarrow> bool) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPIsDevice_update f (PageCap v0 v1 v2 v3 v4 v5) = PageCap v0 v1 v2 v3 (f v4) v5"

primrec
  capVPMappedAddress_update :: "(((asid * vptr) option) \<Rightarrow> ((asid * vptr) option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVPMappedAddress_update f (PageCap v0 v1 v2 v3 v4 v5) = PageCap v0 v1 v2 v3 v4 (f v5)"

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
  capPDMappedAddress_update :: "(((asid * vptr) option) \<Rightarrow> ((asid * vptr) option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPDMappedAddress_update f (PageDirectoryCap v0 v1) = PageDirectoryCap v0 (f v1)"

primrec
  capPDPTBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPDPTBasePtr_update f (PDPointerTableCap v0 v1) = PDPointerTableCap (f v0) v1"

primrec
  capPDPTMappedAddress_update :: "(((asid * vptr) option) \<Rightarrow> ((asid * vptr) option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPDPTMappedAddress_update f (PDPointerTableCap v0 v1) = PDPointerTableCap v0 (f v1)"

primrec
  capPML4BasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPML4BasePtr_update f (PML4Cap v0 v1) = PML4Cap (f v0) v1"

primrec
  capPML4MappedASID_update :: "((asid option) \<Rightarrow> (asid option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPML4MappedASID_update f (PML4Cap v0 v1) = PML4Cap v0 (f v1)"

abbreviation (input)
  ASIDPoolCap_trans :: "(machine_word) \<Rightarrow> (asid) \<Rightarrow> arch_capability" ("ASIDPoolCap'_ \<lparr> capASIDPool= _, capASIDBase= _ \<rparr>")
where
  "ASIDPoolCap_ \<lparr> capASIDPool= v0, capASIDBase= v1 \<rparr> == ASIDPoolCap v0 v1"

abbreviation (input)
  IOPortCap_trans :: "(ioport) \<Rightarrow> (ioport) \<Rightarrow> arch_capability" ("IOPortCap'_ \<lparr> capIOPortFirstPort= _, capIOPortLastPort= _ \<rparr>")
where
  "IOPortCap_ \<lparr> capIOPortFirstPort= v0, capIOPortLastPort= v1 \<rparr> == IOPortCap v0 v1"

abbreviation (input)
  PageCap_trans :: "(machine_word) \<Rightarrow> (vmrights) \<Rightarrow> (vmmap_type) \<Rightarrow> (vmpage_size) \<Rightarrow> (bool) \<Rightarrow> ((asid * vptr) option) \<Rightarrow> arch_capability" ("PageCap'_ \<lparr> capVPBasePtr= _, capVPRights= _, capVPMapType= _, capVPSize= _, capVPIsDevice= _, capVPMappedAddress= _ \<rparr>")
where
  "PageCap_ \<lparr> capVPBasePtr= v0, capVPRights= v1, capVPMapType= v2, capVPSize= v3, capVPIsDevice= v4, capVPMappedAddress= v5 \<rparr> == PageCap v0 v1 v2 v3 v4 v5"

abbreviation (input)
  PageTableCap_trans :: "(machine_word) \<Rightarrow> ((asid * vptr) option) \<Rightarrow> arch_capability" ("PageTableCap'_ \<lparr> capPTBasePtr= _, capPTMappedAddress= _ \<rparr>")
where
  "PageTableCap_ \<lparr> capPTBasePtr= v0, capPTMappedAddress= v1 \<rparr> == PageTableCap v0 v1"

abbreviation (input)
  PageDirectoryCap_trans :: "(machine_word) \<Rightarrow> ((asid * vptr) option) \<Rightarrow> arch_capability" ("PageDirectoryCap'_ \<lparr> capPDBasePtr= _, capPDMappedAddress= _ \<rparr>")
where
  "PageDirectoryCap_ \<lparr> capPDBasePtr= v0, capPDMappedAddress= v1 \<rparr> == PageDirectoryCap v0 v1"

abbreviation (input)
  PDPointerTableCap_trans :: "(machine_word) \<Rightarrow> ((asid * vptr) option) \<Rightarrow> arch_capability" ("PDPointerTableCap'_ \<lparr> capPDPTBasePtr= _, capPDPTMappedAddress= _ \<rparr>")
where
  "PDPointerTableCap_ \<lparr> capPDPTBasePtr= v0, capPDPTMappedAddress= v1 \<rparr> == PDPointerTableCap v0 v1"

abbreviation (input)
  PML4Cap_trans :: "(machine_word) \<Rightarrow> (asid option) \<Rightarrow> arch_capability" ("PML4Cap'_ \<lparr> capPML4BasePtr= _, capPML4MappedASID= _ \<rparr>")
where
  "PML4Cap_ \<lparr> capPML4BasePtr= v0, capPML4MappedASID= v1 \<rparr> == PML4Cap v0 v1"

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
  isIOPortCap :: "arch_capability \<Rightarrow> bool"
where
 "isIOPortCap v \<equiv> case v of
    IOPortCap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isIOPortControlCap :: "arch_capability \<Rightarrow> bool"
where
 "isIOPortControlCap v \<equiv> case v of
    IOPortControlCap \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageCap :: "arch_capability \<Rightarrow> bool"
where
 "isPageCap v \<equiv> case v of
    PageCap v0 v1 v2 v3 v4 v5 \<Rightarrow> True
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

definition
  isPDPointerTableCap :: "arch_capability \<Rightarrow> bool"
where
 "isPDPointerTableCap v \<equiv> case v of
    PDPointerTableCap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPML4Cap :: "arch_capability \<Rightarrow> bool"
where
 "isPML4Cap v \<equiv> case v of
    PML4Cap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype asidpool =
    ASIDPool "asid \<Rightarrow> ((machine_word) option)"

datatype arch_kernel_object =
    KOASIDPool asidpool
  | KOPTE pte
  | KOPDE pde
  | KOPDPTE pdpte
  | KOPML4E pml4e

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

datatype cr3 =
    CR3 (cr3BaseAddress : paddr) (cr3pcid : asid)

primrec
  cr3BaseAddress_update :: "(paddr \<Rightarrow> paddr) \<Rightarrow> cr3 \<Rightarrow> cr3"
where
  "cr3BaseAddress_update f (CR3 v0 v1) = CR3 (f v0) v1"

primrec
  cr3pcid_update :: "(asid \<Rightarrow> asid) \<Rightarrow> cr3 \<Rightarrow> cr3"
where
  "cr3pcid_update f (CR3 v0 v1) = CR3 v0 (f v1)"

abbreviation (input)
  CR3_trans :: "(paddr) \<Rightarrow> (asid) \<Rightarrow> cr3" ("CR3'_ \<lparr> cr3BaseAddress= _, cr3pcid= _ \<rparr>")
where
  "CR3_ \<lparr> cr3BaseAddress= v0, cr3pcid= v1 \<rparr> == CR3 v0 v1"

lemma cr3BaseAddress_cr3BaseAddress_update [simp]:
  "cr3BaseAddress (cr3BaseAddress_update f v) = f (cr3BaseAddress v)"
  by (cases v) simp

lemma cr3BaseAddress_cr3pcid_update [simp]:
  "cr3BaseAddress (cr3pcid_update f v) = cr3BaseAddress v"
  by (cases v) simp

lemma cr3pcid_cr3BaseAddress_update [simp]:
  "cr3pcid (cr3BaseAddress_update f v) = cr3pcid v"
  by (cases v) simp

lemma cr3pcid_cr3pcid_update [simp]:
  "cr3pcid (cr3pcid_update f v) = f (cr3pcid v)"
  by (cases v) simp

datatype x64irqstate =
    X64IRQFree
  | X64IRQReserved
  | X64IRQMSI (msiBus : machine_word) (msiDev : machine_word) (msiFunc : machine_word) (msiHandle : machine_word)
  | X64IRQIOAPIC (irqIOAPIC : machine_word) (irqPin : machine_word) (irqLevel : machine_word) (irqPolarity : machine_word) (irqMasked : bool)

primrec
  msiBus_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "msiBus_update f (X64IRQMSI v0 v1 v2 v3) = X64IRQMSI (f v0) v1 v2 v3"

primrec
  msiDev_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "msiDev_update f (X64IRQMSI v0 v1 v2 v3) = X64IRQMSI v0 (f v1) v2 v3"

primrec
  msiFunc_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "msiFunc_update f (X64IRQMSI v0 v1 v2 v3) = X64IRQMSI v0 v1 (f v2) v3"

primrec
  msiHandle_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "msiHandle_update f (X64IRQMSI v0 v1 v2 v3) = X64IRQMSI v0 v1 v2 (f v3)"

primrec
  irqIOAPIC_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "irqIOAPIC_update f (X64IRQIOAPIC v0 v1 v2 v3 v4) = X64IRQIOAPIC (f v0) v1 v2 v3 v4"

primrec
  irqPin_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "irqPin_update f (X64IRQIOAPIC v0 v1 v2 v3 v4) = X64IRQIOAPIC v0 (f v1) v2 v3 v4"

primrec
  irqLevel_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "irqLevel_update f (X64IRQIOAPIC v0 v1 v2 v3 v4) = X64IRQIOAPIC v0 v1 (f v2) v3 v4"

primrec
  irqPolarity_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "irqPolarity_update f (X64IRQIOAPIC v0 v1 v2 v3 v4) = X64IRQIOAPIC v0 v1 v2 (f v3) v4"

primrec
  irqMasked_update :: "(bool \<Rightarrow> bool) \<Rightarrow> x64irqstate \<Rightarrow> x64irqstate"
where
  "irqMasked_update f (X64IRQIOAPIC v0 v1 v2 v3 v4) = X64IRQIOAPIC v0 v1 v2 v3 (f v4)"

abbreviation (input)
  X64IRQMSI_trans :: "(machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> x64irqstate" ("X64IRQMSI'_ \<lparr> msiBus= _, msiDev= _, msiFunc= _, msiHandle= _ \<rparr>")
where
  "X64IRQMSI_ \<lparr> msiBus= v0, msiDev= v1, msiFunc= v2, msiHandle= v3 \<rparr> == X64IRQMSI v0 v1 v2 v3"

abbreviation (input)
  X64IRQIOAPIC_trans :: "(machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (bool) \<Rightarrow> x64irqstate" ("X64IRQIOAPIC'_ \<lparr> irqIOAPIC= _, irqPin= _, irqLevel= _, irqPolarity= _, irqMasked= _ \<rparr>")
where
  "X64IRQIOAPIC_ \<lparr> irqIOAPIC= v0, irqPin= v1, irqLevel= v2, irqPolarity= v3, irqMasked= v4 \<rparr> == X64IRQIOAPIC v0 v1 v2 v3 v4"

definition
  isX64IRQFree :: "x64irqstate \<Rightarrow> bool"
where
 "isX64IRQFree v \<equiv> case v of
    X64IRQFree \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isX64IRQReserved :: "x64irqstate \<Rightarrow> bool"
where
 "isX64IRQReserved v \<equiv> case v of
    X64IRQReserved \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isX64IRQMSI :: "x64irqstate \<Rightarrow> bool"
where
 "isX64IRQMSI v \<equiv> case v of
    X64IRQMSI v0 v1 v2 v3 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isX64IRQIOAPIC :: "x64irqstate \<Rightarrow> bool"
where
 "isX64IRQIOAPIC v \<equiv> case v of
    X64IRQIOAPIC v0 v1 v2 v3 v4 \<Rightarrow> True
  | _ \<Rightarrow> False"

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

consts'
asidLowBitsOf :: "asid \<Rightarrow> asid"

consts'
makeCR3 :: "paddr \<Rightarrow> asid \<Rightarrow> cr3"

defs minUntypedSizeBits_def:
"minUntypedSizeBits \<equiv> 4"

defs maxUntypedSizeBits_def:
"maxUntypedSizeBits \<equiv> 47"

defs archObjSize_def:
"archObjSize a\<equiv> (case a of
                  KOASIDPool v16 \<Rightarrow>   pageBits
                | KOPTE v17 \<Rightarrow>   3
                | KOPDE v18 \<Rightarrow>   3
                | KOPDPTE v19 \<Rightarrow>   3
                | KOPML4E v20 \<Rightarrow>   3
                )"

definition
"newArchTCB \<equiv> ArchThread_ \<lparr>
    atcbContext= newContext \<rparr>"

defs atcbContextSet_def:
"atcbContextSet uc atcb \<equiv> atcb \<lparr> atcbContext := uc \<rparr>"

defs atcbContextGet_def:
"atcbContextGet \<equiv> atcbContext"

defs asidHighBits_def:
"asidHighBits \<equiv> 3"

defs asidLowBits_def:
"asidLowBits \<equiv> 9"

defs asidBits_def:
"asidBits \<equiv> asidHighBits + asidLowBits"

defs asidRange_def:
"asidRange\<equiv> (0, (1 `~shiftL~` asidBits) - 1)"

defs asidHighBitsOf_def:
"asidHighBitsOf asid\<equiv> (asid `~shiftR~` asidLowBits) && mask asidHighBits"

defs asidLowBitsOf_def:
"asidLowBitsOf asid \<equiv> asid && mask asidLowBits"

defs makeCR3_def:
"makeCR3 vspace asid \<equiv>
    let
        vspace' = vspace && (mask pml4ShiftBits `~shiftL~` asidBits)
    in
                             CR3 vspace' asid"


datatype arch_kernel_object_type =
    PDET
  | PTET
  | PDPTET
  | PML4ET
  | ASIDPoolT

primrec
  archTypeOf :: "arch_kernel_object \<Rightarrow> arch_kernel_object_type"
where
  "archTypeOf (KOPDE e) = PDET"
| "archTypeOf (KOPTE e) = PTET"
| "archTypeOf (KOPDPTE e) = PDPTET"
| "archTypeOf (KOPML4E e) = PML4ET"
| "archTypeOf (KOASIDPool e) = ASIDPoolT"

end
end
