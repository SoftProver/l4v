(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchVSpaceDecls_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Retyping Objects"

theory ArchVSpaceDecls_H
imports ArchRetypeDecls_H InvocationLabels_H
begin

context Arch begin global_naming RISCV64_H

consts'
ipcBufferSizeBits :: "nat"

consts'
copyGlobalMappings :: "machine_word \<Rightarrow> unit kernel"

consts'
lookupIPCBuffer :: "bool \<Rightarrow> machine_word \<Rightarrow> ((machine_word) option) kernel"

consts'
findVSpaceForASID :: "asid \<Rightarrow> ( lookup_failure , (machine_word) ) kernel_f"

consts'
maybeVSpaceForASID :: "asid \<Rightarrow> ((machine_word) option) kernel"

consts'
checkPTAt :: "machine_word \<Rightarrow> unit kernel"

consts'
isPageTablePTE :: "pte \<Rightarrow> bool"

consts'
getPPtrFromHWPTE :: "pte \<Rightarrow> machine_word"

consts'
ptBitsLeft :: "nat \<Rightarrow> nat"

consts'
ptIndex :: "nat \<Rightarrow> vptr \<Rightarrow> machine_word"

consts'
ptSlotIndex :: "nat \<Rightarrow> machine_word \<Rightarrow> vptr \<Rightarrow> machine_word"

consts'
pteAtIndex :: "nat \<Rightarrow> machine_word \<Rightarrow> vptr \<Rightarrow> pte kernel"

consts'
lookupPTSlot :: "machine_word \<Rightarrow> vptr \<Rightarrow> (nat * machine_word) kernel"

consts'
handleVMFault :: "machine_word \<Rightarrow> vmfault_type \<Rightarrow> ( fault , unit ) kernel_f"

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
setVMRoot :: "machine_word \<Rightarrow> unit kernel"

consts'
checkValidIPCBuffer :: "vptr \<Rightarrow> capability \<Rightarrow> ( syscall_error , unit ) kernel_f"

consts'
isValidVTableRoot :: "capability \<Rightarrow> bool"

consts'
maskVMRights :: "vmrights \<Rightarrow> cap_rights \<Rightarrow> vmrights"

consts'
attribsFromWord :: "machine_word \<Rightarrow> vmattributes"

consts'
makeUserPTE :: "paddr \<Rightarrow> bool \<Rightarrow> vmrights \<Rightarrow> pte"

consts'
checkVPAlignment :: "vmpage_size \<Rightarrow> vptr \<Rightarrow> ( syscall_error , unit ) kernel_f"

consts'
checkSlot :: "machine_word \<Rightarrow> (pte \<Rightarrow> bool) \<Rightarrow> ( syscall_error , unit ) kernel_f"

consts'
decodeRISCVFrameInvocationMap :: "machine_word \<Rightarrow> arch_capability \<Rightarrow> vptr \<Rightarrow> machine_word \<Rightarrow> machine_word \<Rightarrow> capability \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeRISCVFrameInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeRISCVPageTableInvocationMap :: "machine_word \<Rightarrow> arch_capability \<Rightarrow> vptr \<Rightarrow> machine_word \<Rightarrow> capability \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeRISCVPageTableInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeRISCVASIDControlInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeRISCVASIDPoolInvocation :: "machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
decodeRISCVMMUInvocation :: "machine_word \<Rightarrow> machine_word list \<Rightarrow> cptr \<Rightarrow> machine_word \<Rightarrow> arch_capability \<Rightarrow> (capability * machine_word) list \<Rightarrow> ( syscall_error , invocation ) kernel_f"

consts'
performPageTableInvocation :: "page_table_invocation \<Rightarrow> unit kernel"

consts'
performPageInvocation :: "page_invocation \<Rightarrow> machine_word list kernel"

consts'
performASIDControlInvocation :: "asidcontrol_invocation \<Rightarrow> unit kernel"

consts'
performASIDPoolInvocation :: "asidpool_invocation \<Rightarrow> unit kernel"

consts'
performRISCVMMUInvocation :: "invocation \<Rightarrow> machine_word list kernel_p"

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


end (* context RISCV64 *)

end
