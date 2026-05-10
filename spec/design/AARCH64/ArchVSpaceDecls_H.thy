(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchVSpaceDecls_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Retyping Objects"

theory ArchVSpaceDecls_H
imports ArchRetypeDecls_H InvocationLabels_H
begin

context Arch begin global_naming AARCH64_H

consts'
ipcBufferSizeBits :: "nat"

consts'
lookupIPCBuffer :: "bool \<Rightarrow> machine_word \<Rightarrow> ((machine_word) option) kernel"

consts'
getPoolPtr :: "asid \<Rightarrow> ((machine_word) option) kernel"

consts'
getASIDPoolEntry :: "asid \<Rightarrow> (asidpool_entry option) kernel"

consts'
updateASIDPoolEntry :: "(asidpool_entry \<Rightarrow> asidpool_entry option) \<Rightarrow> asid \<Rightarrow> unit kernel"

consts'
findVSpaceForASID :: "asid \<Rightarrow> ( lookup_failure , (machine_word) ) kernel_f"

consts'
maybeVSpaceForASID :: "asid \<Rightarrow> ((machine_word) option) kernel"

consts'
checkPTAt :: "machine_word \<Rightarrow> unit kernel"

consts'
isPageTablePTE :: "pte \<Rightarrow> bool"

consts'
isPagePTE :: "pte \<Rightarrow> bool"

consts'
getPPtrFromPTE :: "pte \<Rightarrow> machine_word"

consts'
ptBitsLeft :: "nat \<Rightarrow> nat"

consts'
levelType :: "nat \<Rightarrow> pt_type"

consts'
ptIndex :: "nat \<Rightarrow> vptr \<Rightarrow> machine_word"

consts'
ptSlotIndex :: "nat \<Rightarrow> machine_word \<Rightarrow> vptr \<Rightarrow> machine_word"

consts'
pteAtIndex :: "nat \<Rightarrow> machine_word \<Rightarrow> vptr \<Rightarrow> pte kernel"

consts'
lookupPTSlot :: "machine_word \<Rightarrow> vptr \<Rightarrow> (nat * machine_word) kernel"

consts'
lookupFrame :: "machine_word \<Rightarrow> vptr \<Rightarrow> ((nat * paddr) option) kernel"

consts'
handleVMFault :: "machine_word \<Rightarrow> vmfault_type \<Rightarrow> ( fault , unit ) kernel_f"

consts'
invalidateTLBByASID :: "asid \<Rightarrow> unit kernel"

consts'
invalidateTLBByASIDVA :: "asid \<Rightarrow> vptr \<Rightarrow> unit kernel"

consts'
doFlush :: "flush_type \<Rightarrow> vptr \<Rightarrow> vptr \<Rightarrow> paddr \<Rightarrow> unit machine_monad"

consts'
deleteASIDPool :: "asid \<Rightarrow> machine_word \<Rightarrow> unit kernel"

consts'
deleteASID :: "asid \<Rightarrow> machine_word \<Rightarrow> unit kernel"

consts'
unmapPageTable :: "asid \<Rightarrow> vptr \<Rightarrow> machine_word \<Rightarrow> unit kernel"

consts'
checkMappingPPtr :: "machine_word \<Rightarrow> pte \<Rightarrow> ( lookup_failure , unit ) kernel_f"

consts'
unmapPage :: "vmpage_size \<Rightarrow> asid \<Rightarrow> vptr \<Rightarrow> machine_word \<Rightarrow> unit kernel"

consts'
armContextSwitch :: "machine_word \<Rightarrow> asid \<Rightarrow> unit kernel"

consts'
setGlobalUserVSpace :: "unit kernel"

consts'
setVMRoot :: "machine_word \<Rightarrow> unit kernel"

consts'
storeVMID :: "asid \<Rightarrow> vmid \<Rightarrow> unit kernel"

consts'
loadVMID :: "asid \<Rightarrow> (vmid option) kernel"

consts'
invalidateASID :: "asid \<Rightarrow> unit kernel"

consts'
invalidateVMIDEntry :: "vmid \<Rightarrow> unit kernel"

consts'
invalidateASIDEntry :: "asid \<Rightarrow> unit kernel"

consts'
findFreeVMID :: "vmid kernel"

consts'
getVMID :: "asid \<Rightarrow> vmid kernel"

consts'
isVTableRoot :: "capability \<Rightarrow> bool"

consts'
isValidVTableRoot :: "capability \<Rightarrow> bool"

consts'
checkVSpaceRoot :: "capability \<Rightarrow> nat \<Rightarrow> ( syscall_error , (machine_word * asid) ) kernel_f"

consts'
checkValidIPCBuffer :: "vptr \<Rightarrow> capability \<Rightarrow> ( syscall_error , unit ) kernel_f"

consts'
maskVMRights :: "vmrights \<Rightarrow> cap_rights \<Rightarrow> vmrights"

consts'
attribsFromWord :: "machine_word \<Rightarrow> vmattributes"

consts'
makeUserPTE :: "paddr \<Rightarrow> vmrights \<Rightarrow> vmattributes \<Rightarrow> vmpage_size \<Rightarrow> pte"

consts'
checkVPAlignment :: "vmpage_size \<Rightarrow> vptr \<Rightarrow> ( syscall_error , unit ) kernel_f"

consts'
labelToFlushType :: "machine_word \<Rightarrow> flush_type"

consts'
checkValidMappingSize :: "nat \<Rightarrow> unit kernel"

consts'
decodeARMFrameInvocationMap :: "machine_word \<Rightarrow> arch_capability \<Rightarrow> vptr \<Rightarrow> machine_word \<Rightarrow> machine_word \<Rightarrow> capability \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeARMFrameInvocationFlush :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> arch_capability \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeARMFrameInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeARMPageTableInvocationMap :: "machine_word \<Rightarrow> arch_capability \<Rightarrow> vptr \<Rightarrow> machine_word \<Rightarrow> capability \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeARMPageTableInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeARMVSpaceInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> arch_capability \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeARMASIDControlInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeARMASIDPoolInvocation :: "machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeARMMMUInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> cptr \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
performVSpaceInvocation :: "vspace_invocation \<Rightarrow> unit kernel"

consts'
performPageTableInvocation :: "page_table_invocation \<Rightarrow> unit kernel"

consts'
performPageInvocation :: "page_invocation \<Rightarrow> unit kernel"

consts'
performASIDControlInvocation :: "asidcontrol_invocation \<Rightarrow> unit kernel"

consts'
performASIDPoolInvocation :: "asidpool_invocation \<Rightarrow> unit kernel"

consts'
performARMMMUInvocation :: "invocation \<Rightarrow> machine_word list kernel_p"

consts'
storePTE :: "machine_word \<Rightarrow> pte \<Rightarrow> unit kernel"

consts'
mapKernelWindow  :: "unit kernel"

consts'
activateGlobalVSpace :: "unit kernel"

consts'
createIPCBufferFrame :: "capability \<Rightarrow> vptr \<Rightarrow> capability kernel_init"

consts'
createBIFrame :: "capability \<Rightarrow> vptr \<Rightarrow> word32 \<Rightarrow> word32 \<Rightarrow> capability kernel_init"

consts'
createFramesOfRegion :: "capability \<Rightarrow> region \<Rightarrow> bool \<Rightarrow> unit kernel_init"

consts'
createITPDPTs :: "capability \<Rightarrow> vptr \<Rightarrow> vptr \<Rightarrow> capability kernel_init"

consts'
writeITPDPTs :: "capability \<Rightarrow> capability \<Rightarrow> unit kernel_init"

consts'
createITASIDPool :: "capability \<Rightarrow> capability kernel_init"

consts'
writeITASIDPool :: "capability \<Rightarrow> capability \<Rightarrow> unit kernel"

consts'
createDeviceFrames :: "capability \<Rightarrow> unit kernel_init"

consts'
vptrFromPPtr :: "machine_word \<Rightarrow> vptr kernel_init"


(* no "wordlike" class with a direct translation available, use more constrained spec *)
consts'
pageBase :: "('a :: len word) \<Rightarrow> nat \<Rightarrow> 'a word"

end (* context AARCH64 *)

end
