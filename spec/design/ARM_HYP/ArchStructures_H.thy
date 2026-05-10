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
context Arch begin global_naming ARM_HYP_H


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
  | VCPUCap (capVCPUPtr : machine_word)

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

primrec
  capVCPUPtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVCPUPtr_update f (VCPUCap v0) = VCPUCap (f v0)"

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

abbreviation (input)
  VCPUCap_trans :: "(machine_word) \<Rightarrow> arch_capability" ("VCPUCap'_ \<lparr> capVCPUPtr= _ \<rparr>")
where
  "VCPUCap_ \<lparr> capVCPUPtr= v0 \<rparr> == VCPUCap v0"

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

definition
  isVCPUCap :: "arch_capability \<Rightarrow> bool"
where
 "isVCPUCap v \<equiv> case v of
    VCPUCap v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype asidpool =
    ASIDPool "asid \<Rightarrow> ((machine_word) option)"

type_synonym virq = "machine_word"

datatype gicvcpuinterface =
    VGICInterface (vgicHCR : machine_word) (vgicVMCR : machine_word) (vgicAPR : machine_word) (vgicLR : "nat \<Rightarrow> virq")

primrec
  vgicHCR_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> gicvcpuinterface \<Rightarrow> gicvcpuinterface"
where
  "vgicHCR_update f (VGICInterface v0 v1 v2 v3) = VGICInterface (f v0) v1 v2 v3"

primrec
  vgicVMCR_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> gicvcpuinterface \<Rightarrow> gicvcpuinterface"
where
  "vgicVMCR_update f (VGICInterface v0 v1 v2 v3) = VGICInterface v0 (f v1) v2 v3"

primrec
  vgicAPR_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> gicvcpuinterface \<Rightarrow> gicvcpuinterface"
where
  "vgicAPR_update f (VGICInterface v0 v1 v2 v3) = VGICInterface v0 v1 (f v2) v3"

primrec
  vgicLR_update :: "((nat \<Rightarrow> virq) \<Rightarrow> (nat \<Rightarrow> virq)) \<Rightarrow> gicvcpuinterface \<Rightarrow> gicvcpuinterface"
where
  "vgicLR_update f (VGICInterface v0 v1 v2 v3) = VGICInterface v0 v1 v2 (f v3)"

abbreviation (input)
  VGICInterface_trans :: "(machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (nat \<Rightarrow> virq) \<Rightarrow> gicvcpuinterface" ("VGICInterface'_ \<lparr> vgicHCR= _, vgicVMCR= _, vgicAPR= _, vgicLR= _ \<rparr>")
where
  "VGICInterface_ \<lparr> vgicHCR= v0, vgicVMCR= v1, vgicAPR= v2, vgicLR= v3 \<rparr> == VGICInterface v0 v1 v2 v3"

lemma vgicHCR_vgicHCR_update [simp]:
  "vgicHCR (vgicHCR_update f v) = f (vgicHCR v)"
  by (cases v) simp

lemma vgicHCR_vgicVMCR_update [simp]:
  "vgicHCR (vgicVMCR_update f v) = vgicHCR v"
  by (cases v) simp

lemma vgicHCR_vgicAPR_update [simp]:
  "vgicHCR (vgicAPR_update f v) = vgicHCR v"
  by (cases v) simp

lemma vgicHCR_vgicLR_update [simp]:
  "vgicHCR (vgicLR_update f v) = vgicHCR v"
  by (cases v) simp

lemma vgicVMCR_vgicHCR_update [simp]:
  "vgicVMCR (vgicHCR_update f v) = vgicVMCR v"
  by (cases v) simp

lemma vgicVMCR_vgicVMCR_update [simp]:
  "vgicVMCR (vgicVMCR_update f v) = f (vgicVMCR v)"
  by (cases v) simp

lemma vgicVMCR_vgicAPR_update [simp]:
  "vgicVMCR (vgicAPR_update f v) = vgicVMCR v"
  by (cases v) simp

lemma vgicVMCR_vgicLR_update [simp]:
  "vgicVMCR (vgicLR_update f v) = vgicVMCR v"
  by (cases v) simp

lemma vgicAPR_vgicHCR_update [simp]:
  "vgicAPR (vgicHCR_update f v) = vgicAPR v"
  by (cases v) simp

lemma vgicAPR_vgicVMCR_update [simp]:
  "vgicAPR (vgicVMCR_update f v) = vgicAPR v"
  by (cases v) simp

lemma vgicAPR_vgicAPR_update [simp]:
  "vgicAPR (vgicAPR_update f v) = f (vgicAPR v)"
  by (cases v) simp

lemma vgicAPR_vgicLR_update [simp]:
  "vgicAPR (vgicLR_update f v) = vgicAPR v"
  by (cases v) simp

lemma vgicLR_vgicHCR_update [simp]:
  "vgicLR (vgicHCR_update f v) = vgicLR v"
  by (cases v) simp

lemma vgicLR_vgicVMCR_update [simp]:
  "vgicLR (vgicVMCR_update f v) = vgicLR v"
  by (cases v) simp

lemma vgicLR_vgicAPR_update [simp]:
  "vgicLR (vgicAPR_update f v) = vgicLR v"
  by (cases v) simp

lemma vgicLR_vgicLR_update [simp]:
  "vgicLR (vgicLR_update f v) = f (vgicLR v)"
  by (cases v) simp

datatype vcpu =
    VCPUObj (vcpuTCBPtr : "(machine_word) option") (vcpuVGIC : gicvcpuinterface) (vcpuRegs : "vcpureg \<Rightarrow> machine_word") (vcpuVPPIMasked : "vppievent_irq \<Rightarrow> bool") (vcpuVTimer : virt_timer)

primrec
  vcpuTCBPtr_update :: "(((machine_word) option) \<Rightarrow> ((machine_word) option)) \<Rightarrow> vcpu \<Rightarrow> vcpu"
where
  "vcpuTCBPtr_update f (VCPUObj v0 v1 v2 v3 v4) = VCPUObj (f v0) v1 v2 v3 v4"

primrec
  vcpuVGIC_update :: "(gicvcpuinterface \<Rightarrow> gicvcpuinterface) \<Rightarrow> vcpu \<Rightarrow> vcpu"
where
  "vcpuVGIC_update f (VCPUObj v0 v1 v2 v3 v4) = VCPUObj v0 (f v1) v2 v3 v4"

primrec
  vcpuRegs_update :: "((vcpureg \<Rightarrow> machine_word) \<Rightarrow> (vcpureg \<Rightarrow> machine_word)) \<Rightarrow> vcpu \<Rightarrow> vcpu"
where
  "vcpuRegs_update f (VCPUObj v0 v1 v2 v3 v4) = VCPUObj v0 v1 (f v2) v3 v4"

primrec
  vcpuVPPIMasked_update :: "((vppievent_irq \<Rightarrow> bool) \<Rightarrow> (vppievent_irq \<Rightarrow> bool)) \<Rightarrow> vcpu \<Rightarrow> vcpu"
where
  "vcpuVPPIMasked_update f (VCPUObj v0 v1 v2 v3 v4) = VCPUObj v0 v1 v2 (f v3) v4"

primrec
  vcpuVTimer_update :: "(virt_timer \<Rightarrow> virt_timer) \<Rightarrow> vcpu \<Rightarrow> vcpu"
where
  "vcpuVTimer_update f (VCPUObj v0 v1 v2 v3 v4) = VCPUObj v0 v1 v2 v3 (f v4)"

abbreviation (input)
  VCPUObj_trans :: "((machine_word) option) \<Rightarrow> (gicvcpuinterface) \<Rightarrow> (vcpureg \<Rightarrow> machine_word) \<Rightarrow> (vppievent_irq \<Rightarrow> bool) \<Rightarrow> (virt_timer) \<Rightarrow> vcpu" ("VCPUObj'_ \<lparr> vcpuTCBPtr= _, vcpuVGIC= _, vcpuRegs= _, vcpuVPPIMasked= _, vcpuVTimer= _ \<rparr>")
where
  "VCPUObj_ \<lparr> vcpuTCBPtr= v0, vcpuVGIC= v1, vcpuRegs= v2, vcpuVPPIMasked= v3, vcpuVTimer= v4 \<rparr> == VCPUObj v0 v1 v2 v3 v4"

lemma vcpuTCBPtr_vcpuTCBPtr_update [simp]:
  "vcpuTCBPtr (vcpuTCBPtr_update f v) = f (vcpuTCBPtr v)"
  by (cases v) simp

lemma vcpuTCBPtr_vcpuVGIC_update [simp]:
  "vcpuTCBPtr (vcpuVGIC_update f v) = vcpuTCBPtr v"
  by (cases v) simp

lemma vcpuTCBPtr_vcpuRegs_update [simp]:
  "vcpuTCBPtr (vcpuRegs_update f v) = vcpuTCBPtr v"
  by (cases v) simp

lemma vcpuTCBPtr_vcpuVPPIMasked_update [simp]:
  "vcpuTCBPtr (vcpuVPPIMasked_update f v) = vcpuTCBPtr v"
  by (cases v) simp

lemma vcpuTCBPtr_vcpuVTimer_update [simp]:
  "vcpuTCBPtr (vcpuVTimer_update f v) = vcpuTCBPtr v"
  by (cases v) simp

lemma vcpuVGIC_vcpuTCBPtr_update [simp]:
  "vcpuVGIC (vcpuTCBPtr_update f v) = vcpuVGIC v"
  by (cases v) simp

lemma vcpuVGIC_vcpuVGIC_update [simp]:
  "vcpuVGIC (vcpuVGIC_update f v) = f (vcpuVGIC v)"
  by (cases v) simp

lemma vcpuVGIC_vcpuRegs_update [simp]:
  "vcpuVGIC (vcpuRegs_update f v) = vcpuVGIC v"
  by (cases v) simp

lemma vcpuVGIC_vcpuVPPIMasked_update [simp]:
  "vcpuVGIC (vcpuVPPIMasked_update f v) = vcpuVGIC v"
  by (cases v) simp

lemma vcpuVGIC_vcpuVTimer_update [simp]:
  "vcpuVGIC (vcpuVTimer_update f v) = vcpuVGIC v"
  by (cases v) simp

lemma vcpuRegs_vcpuTCBPtr_update [simp]:
  "vcpuRegs (vcpuTCBPtr_update f v) = vcpuRegs v"
  by (cases v) simp

lemma vcpuRegs_vcpuVGIC_update [simp]:
  "vcpuRegs (vcpuVGIC_update f v) = vcpuRegs v"
  by (cases v) simp

lemma vcpuRegs_vcpuRegs_update [simp]:
  "vcpuRegs (vcpuRegs_update f v) = f (vcpuRegs v)"
  by (cases v) simp

lemma vcpuRegs_vcpuVPPIMasked_update [simp]:
  "vcpuRegs (vcpuVPPIMasked_update f v) = vcpuRegs v"
  by (cases v) simp

lemma vcpuRegs_vcpuVTimer_update [simp]:
  "vcpuRegs (vcpuVTimer_update f v) = vcpuRegs v"
  by (cases v) simp

lemma vcpuVPPIMasked_vcpuTCBPtr_update [simp]:
  "vcpuVPPIMasked (vcpuTCBPtr_update f v) = vcpuVPPIMasked v"
  by (cases v) simp

lemma vcpuVPPIMasked_vcpuVGIC_update [simp]:
  "vcpuVPPIMasked (vcpuVGIC_update f v) = vcpuVPPIMasked v"
  by (cases v) simp

lemma vcpuVPPIMasked_vcpuRegs_update [simp]:
  "vcpuVPPIMasked (vcpuRegs_update f v) = vcpuVPPIMasked v"
  by (cases v) simp

lemma vcpuVPPIMasked_vcpuVPPIMasked_update [simp]:
  "vcpuVPPIMasked (vcpuVPPIMasked_update f v) = f (vcpuVPPIMasked v)"
  by (cases v) simp

lemma vcpuVPPIMasked_vcpuVTimer_update [simp]:
  "vcpuVPPIMasked (vcpuVTimer_update f v) = vcpuVPPIMasked v"
  by (cases v) simp

lemma vcpuVTimer_vcpuTCBPtr_update [simp]:
  "vcpuVTimer (vcpuTCBPtr_update f v) = vcpuVTimer v"
  by (cases v) simp

lemma vcpuVTimer_vcpuVGIC_update [simp]:
  "vcpuVTimer (vcpuVGIC_update f v) = vcpuVTimer v"
  by (cases v) simp

lemma vcpuVTimer_vcpuRegs_update [simp]:
  "vcpuVTimer (vcpuRegs_update f v) = vcpuVTimer v"
  by (cases v) simp

lemma vcpuVTimer_vcpuVPPIMasked_update [simp]:
  "vcpuVTimer (vcpuVPPIMasked_update f v) = vcpuVTimer v"
  by (cases v) simp

lemma vcpuVTimer_vcpuVTimer_update [simp]:
  "vcpuVTimer (vcpuVTimer_update f v) = f (vcpuVTimer v)"
  by (cases v) simp

datatype arch_kernel_object =
    KOASIDPool asidpool
  | KOPTE pte
  | KOPDE pde
  | KOVCPU vcpu

datatype arch_tcb =
    ArchThread (atcbContext : user_context) (atcbVCPUPtr : "(machine_word) option")

primrec
  atcbContext_update :: "(user_context \<Rightarrow> user_context) \<Rightarrow> arch_tcb \<Rightarrow> arch_tcb"
where
  "atcbContext_update f (ArchThread v0 v1) = ArchThread (f v0) v1"

primrec
  atcbVCPUPtr_update :: "(((machine_word) option) \<Rightarrow> ((machine_word) option)) \<Rightarrow> arch_tcb \<Rightarrow> arch_tcb"
where
  "atcbVCPUPtr_update f (ArchThread v0 v1) = ArchThread v0 (f v1)"

abbreviation (input)
  ArchThread_trans :: "(user_context) \<Rightarrow> ((machine_word) option) \<Rightarrow> arch_tcb" ("ArchThread'_ \<lparr> atcbContext= _, atcbVCPUPtr= _ \<rparr>")
where
  "ArchThread_ \<lparr> atcbContext= v0, atcbVCPUPtr= v1 \<rparr> == ArchThread v0 v1"

lemma atcbContext_atcbContext_update [simp]:
  "atcbContext (atcbContext_update f v) = f (atcbContext v)"
  by (cases v) simp

lemma atcbContext_atcbVCPUPtr_update [simp]:
  "atcbContext (atcbVCPUPtr_update f v) = atcbContext v"
  by (cases v) simp

lemma atcbVCPUPtr_atcbContext_update [simp]:
  "atcbVCPUPtr (atcbContext_update f v) = atcbVCPUPtr v"
  by (cases v) simp

lemma atcbVCPUPtr_atcbVCPUPtr_update [simp]:
  "atcbVCPUPtr (atcbVCPUPtr_update f v) = f (atcbVCPUPtr v)"
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

consts'
makeVCPUObject :: "vcpu"

defs minUntypedSizeBits_def:
"minUntypedSizeBits \<equiv> 4"

defs maxUntypedSizeBits_def:
"maxUntypedSizeBits \<equiv> 29"

defs archObjSize_def:
"archObjSize a\<equiv> (case a of
                  KOASIDPool v21 \<Rightarrow>   pageBits
                | KOPTE v22 \<Rightarrow>   pteBits
                | KOPDE v23 \<Rightarrow>   pdeBits
                | KOVCPU v24 \<Rightarrow>   vcpuBits
                )"

definition
"newArchTCB \<equiv> ArchThread_ \<lparr>
    atcbContext= newContext
    ,atcbVCPUPtr= Nothing
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

definition
"vcpuSCTLR vcpu \<equiv> vcpuRegs vcpu VCPURegSCTLR"


(* we define makeVCPUObject_def manually because we want a total function vgicLR *)
defs makeVCPUObject_def:
"makeVCPUObject \<equiv>
    VCPUObj_ \<lparr>
          vcpuTCBPtr= Nothing
        , vcpuVGIC= VGICInterface_ \<lparr>
                          vgicHCR= vgicHCREN
                        , vgicVMCR= 0
                        , vgicAPR= 0
                        , vgicLR= (\<lambda>_. 0)
                        \<rparr>
        , vcpuRegs= funArray (const 0)  aLU  [(VCPURegSCTLR, sctlrDefault)
                                             ,(VCPURegACTLR, actlrDefault)]
        , vcpuVPPIMasked= (\<lambda>_. False)
        , vcpuVTimer= VirtTimer 0
        \<rparr>"

datatype arch_kernel_object_type =
    PDET
  | PTET
  | VCPUT
  | ASIDPoolT

primrec
  archTypeOf :: "arch_kernel_object \<Rightarrow> arch_kernel_object_type"
where
  "archTypeOf (KOPDE e) = PDET"
| "archTypeOf (KOPTE e) = PTET"
| "archTypeOf (KOVCPU e) = VCPUT"
| "archTypeOf (KOASIDPool e) = ASIDPoolT"

end

context begin interpretation Arch .

requalify_types
  vcpu

end
end
