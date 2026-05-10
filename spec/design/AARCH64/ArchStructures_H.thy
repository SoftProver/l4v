(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchStructures_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

theory ArchStructures_H
imports
  "Lib.Lib"
  Types_H
  Hardware_H
begin

context Arch begin global_naming AARCH64_H


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
    ASIDControlCap
  | ASIDPoolCap (capASIDPool : machine_word) (capASIDBase : asid)
  | FrameCap (capFBasePtr : machine_word) (capFVMRights : vmrights) (capFSize : vmpage_size) (capFIsDevice : bool) (capFMappedAddress : "(asid * vptr) option")
  | PageTableCap (capPTBasePtr : machine_word) (capPTType : pt_type) (capPTMappedAddress : "(asid * vptr) option")
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
  capFBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capFBasePtr_update f (FrameCap v0 v1 v2 v3 v4) = FrameCap (f v0) v1 v2 v3 v4"

primrec
  capFVMRights_update :: "(vmrights \<Rightarrow> vmrights) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capFVMRights_update f (FrameCap v0 v1 v2 v3 v4) = FrameCap v0 (f v1) v2 v3 v4"

primrec
  capFSize_update :: "(vmpage_size \<Rightarrow> vmpage_size) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capFSize_update f (FrameCap v0 v1 v2 v3 v4) = FrameCap v0 v1 (f v2) v3 v4"

primrec
  capFIsDevice_update :: "(bool \<Rightarrow> bool) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capFIsDevice_update f (FrameCap v0 v1 v2 v3 v4) = FrameCap v0 v1 v2 (f v3) v4"

primrec
  capFMappedAddress_update :: "(((asid * vptr) option) \<Rightarrow> ((asid * vptr) option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capFMappedAddress_update f (FrameCap v0 v1 v2 v3 v4) = FrameCap v0 v1 v2 v3 (f v4)"

primrec
  capPTBasePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPTBasePtr_update f (PageTableCap v0 v1 v2) = PageTableCap (f v0) v1 v2"

primrec
  capPTType_update :: "(pt_type \<Rightarrow> pt_type) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPTType_update f (PageTableCap v0 v1 v2) = PageTableCap v0 (f v1) v2"

primrec
  capPTMappedAddress_update :: "(((asid * vptr) option) \<Rightarrow> ((asid * vptr) option)) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capPTMappedAddress_update f (PageTableCap v0 v1 v2) = PageTableCap v0 v1 (f v2)"

primrec
  capVCPUPtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> arch_capability \<Rightarrow> arch_capability"
where
  "capVCPUPtr_update f (VCPUCap v0) = VCPUCap (f v0)"

abbreviation (input)
  ASIDPoolCap_trans :: "(machine_word) \<Rightarrow> (asid) \<Rightarrow> arch_capability" ("ASIDPoolCap'_ \<lparr> capASIDPool= _, capASIDBase= _ \<rparr>")
where
  "ASIDPoolCap_ \<lparr> capASIDPool= v0, capASIDBase= v1 \<rparr> == ASIDPoolCap v0 v1"

abbreviation (input)
  FrameCap_trans :: "(machine_word) \<Rightarrow> (vmrights) \<Rightarrow> (vmpage_size) \<Rightarrow> (bool) \<Rightarrow> ((asid * vptr) option) \<Rightarrow> arch_capability" ("FrameCap'_ \<lparr> capFBasePtr= _, capFVMRights= _, capFSize= _, capFIsDevice= _, capFMappedAddress= _ \<rparr>")
where
  "FrameCap_ \<lparr> capFBasePtr= v0, capFVMRights= v1, capFSize= v2, capFIsDevice= v3, capFMappedAddress= v4 \<rparr> == FrameCap v0 v1 v2 v3 v4"

abbreviation (input)
  PageTableCap_trans :: "(machine_word) \<Rightarrow> (pt_type) \<Rightarrow> ((asid * vptr) option) \<Rightarrow> arch_capability" ("PageTableCap'_ \<lparr> capPTBasePtr= _, capPTType= _, capPTMappedAddress= _ \<rparr>")
where
  "PageTableCap_ \<lparr> capPTBasePtr= v0, capPTType= v1, capPTMappedAddress= v2 \<rparr> == PageTableCap v0 v1 v2"

abbreviation (input)
  VCPUCap_trans :: "(machine_word) \<Rightarrow> arch_capability" ("VCPUCap'_ \<lparr> capVCPUPtr= _ \<rparr>")
where
  "VCPUCap_ \<lparr> capVCPUPtr= v0 \<rparr> == VCPUCap v0"

definition
  isASIDControlCap :: "arch_capability \<Rightarrow> bool"
where
 "isASIDControlCap v \<equiv> case v of
    ASIDControlCap \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isASIDPoolCap :: "arch_capability \<Rightarrow> bool"
where
 "isASIDPoolCap v \<equiv> case v of
    ASIDPoolCap v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isFrameCap :: "arch_capability \<Rightarrow> bool"
where
 "isFrameCap v \<equiv> case v of
    FrameCap v0 v1 v2 v3 v4 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageTableCap :: "arch_capability \<Rightarrow> bool"
where
 "isPageTableCap v \<equiv> case v of
    PageTableCap v0 v1 v2 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isVCPUCap :: "arch_capability \<Rightarrow> bool"
where
 "isVCPUCap v \<equiv> case v of
    VCPUCap v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

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

type_synonym vmid = "word8"

definition
  VMID :: "vmid \<Rightarrow> vmid"
where VMID_def[simp]:
 "VMID \<equiv> id"

datatype asidpool_entry =
    ASIDPoolVSpace (apVMID : "vmid option") (apVSpace : machine_word)

primrec
  apVMID_update :: "((vmid option) \<Rightarrow> (vmid option)) \<Rightarrow> asidpool_entry \<Rightarrow> asidpool_entry"
where
  "apVMID_update f (ASIDPoolVSpace v0 v1) = ASIDPoolVSpace (f v0) v1"

primrec
  apVSpace_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> asidpool_entry \<Rightarrow> asidpool_entry"
where
  "apVSpace_update f (ASIDPoolVSpace v0 v1) = ASIDPoolVSpace v0 (f v1)"

abbreviation (input)
  ASIDPoolVSpace_trans :: "(vmid option) \<Rightarrow> (machine_word) \<Rightarrow> asidpool_entry" ("ASIDPoolVSpace'_ \<lparr> apVMID= _, apVSpace= _ \<rparr>")
where
  "ASIDPoolVSpace_ \<lparr> apVMID= v0, apVSpace= v1 \<rparr> == ASIDPoolVSpace v0 v1"

lemma apVMID_apVMID_update [simp]:
  "apVMID (apVMID_update f v) = f (apVMID v)"
  by (cases v) simp

lemma apVMID_apVSpace_update [simp]:
  "apVMID (apVSpace_update f v) = apVMID v"
  by (cases v) simp

lemma apVSpace_apVMID_update [simp]:
  "apVSpace (apVMID_update f v) = apVSpace v"
  by (cases v) simp

lemma apVSpace_apVSpace_update [simp]:
  "apVSpace (apVSpace_update f v) = f (apVSpace v)"
  by (cases v) simp

datatype asidpool =
    ASIDPool "asid \<Rightarrow> (asidpool_entry option)"

type_synonym virq = "machine_word"

datatype gicvcpuinterface =
    VGICInterface (vgicHCR : word32) (vgicVMCR : word32) (vgicAPR : word32) (vgicLR : "nat \<Rightarrow> virq")

primrec
  vgicHCR_update :: "(word32 \<Rightarrow> word32) \<Rightarrow> gicvcpuinterface \<Rightarrow> gicvcpuinterface"
where
  "vgicHCR_update f (VGICInterface v0 v1 v2 v3) = VGICInterface (f v0) v1 v2 v3"

primrec
  vgicVMCR_update :: "(word32 \<Rightarrow> word32) \<Rightarrow> gicvcpuinterface \<Rightarrow> gicvcpuinterface"
where
  "vgicVMCR_update f (VGICInterface v0 v1 v2 v3) = VGICInterface v0 (f v1) v2 v3"

primrec
  vgicAPR_update :: "(word32 \<Rightarrow> word32) \<Rightarrow> gicvcpuinterface \<Rightarrow> gicvcpuinterface"
where
  "vgicAPR_update f (VGICInterface v0 v1 v2 v3) = VGICInterface v0 v1 (f v2) v3"

primrec
  vgicLR_update :: "((nat \<Rightarrow> virq) \<Rightarrow> (nat \<Rightarrow> virq)) \<Rightarrow> gicvcpuinterface \<Rightarrow> gicvcpuinterface"
where
  "vgicLR_update f (VGICInterface v0 v1 v2 v3) = VGICInterface v0 v1 v2 (f v3)"

abbreviation (input)
  VGICInterface_trans :: "(word32) \<Rightarrow> (word32) \<Rightarrow> (word32) \<Rightarrow> (nat \<Rightarrow> virq) \<Rightarrow> gicvcpuinterface" ("VGICInterface'_ \<lparr> vgicHCR= _, vgicVMCR= _, vgicAPR= _, vgicLR= _ \<rparr>")
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
  | KOVCPU vcpu

consts'
minUntypedSizeBits :: "nat"

consts'
maxUntypedSizeBits :: "nat"

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

consts'
archObjSize :: "arch_kernel_object \<Rightarrow> nat"

defs minUntypedSizeBits_def:
"minUntypedSizeBits \<equiv> 4"

defs maxUntypedSizeBits_def:
"maxUntypedSizeBits \<equiv> 47"

definition
"newArchTCB \<equiv> ArchThread_ \<lparr>
    atcbContext= newContext,
    atcbVCPUPtr= Nothing \<rparr>"

defs atcbContextSet_def:
"atcbContextSet uc atcb \<equiv> atcb \<lparr> atcbContext := uc \<rparr>"

defs atcbContextGet_def:
"atcbContextGet \<equiv> atcbContext"

defs asidHighBits_def:
"asidHighBits \<equiv> 7"

defs asidLowBits_def:
"asidLowBits \<equiv> 9"

defs asidBits_def:
"asidBits \<equiv> asidHighBits + asidLowBits"

defs asidRange_def:
"asidRange\<equiv> (0, (1 `~shiftL~` asidBits) - 1)"

defs asidHighBitsOf_def:
"asidHighBitsOf asid\<equiv> (asid `~shiftR~` asidLowBits) && mask asidHighBits"

definition
"vcpuSCTLR vcpu \<equiv> vcpuRegs vcpu VCPURegSCTLR"

defs archObjSize_def:
"archObjSize x0\<equiv> (case x0 of
    (KOASIDPool _) \<Rightarrow>    pageBits
  | (KOPTE _) \<Rightarrow>    pteBits
  | (KOVCPU _) \<Rightarrow>    vcpuBits
  )"


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
        , vcpuRegs= funArray (const 0)  aLU  [(VCPURegSCTLR, sctlrDefault)]
        , vcpuVPPIMasked= (\<lambda>_. False)
        , vcpuVTimer= VirtTimer 0
        \<rparr>"

datatype arch_kernel_object_type =
    PTET
  | VCPUT
  | ASIDPoolT

primrec
  archTypeOf :: "arch_kernel_object \<Rightarrow> arch_kernel_object_type"
where
  "archTypeOf (KOPTE e) = PTET"
| "archTypeOf (KOVCPU e) = VCPUT"
| "archTypeOf (KOASIDPool e) = ASIDPoolT"

end

context begin interpretation Arch .

requalify_types
  vcpu

end
end
