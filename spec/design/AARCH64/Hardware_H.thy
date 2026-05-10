(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file Hardware_H.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

theory Hardware_H
imports
  MachineOps
  State_H
begin

context Arch begin global_naming AARCH64_H

type_synonym irq = "Platform.AARCH64.irq"

type_synonym paddr = "Platform.AARCH64.paddr"

datatype vmattributes =
    VMAttributes (armExecuteNever : bool) (armPageCacheable : bool)

primrec
  armExecuteNever_update :: "(bool \<Rightarrow> bool) \<Rightarrow> vmattributes \<Rightarrow> vmattributes"
where
  "armExecuteNever_update f (VMAttributes v0 v1) = VMAttributes (f v0) v1"

primrec
  armPageCacheable_update :: "(bool \<Rightarrow> bool) \<Rightarrow> vmattributes \<Rightarrow> vmattributes"
where
  "armPageCacheable_update f (VMAttributes v0 v1) = VMAttributes v0 (f v1)"

abbreviation (input)
  VMAttributes_trans :: "(bool) \<Rightarrow> (bool) \<Rightarrow> vmattributes" ("VMAttributes'_ \<lparr> armExecuteNever= _, armPageCacheable= _ \<rparr>")
where
  "VMAttributes_ \<lparr> armExecuteNever= v0, armPageCacheable= v1 \<rparr> == VMAttributes v0 v1"

lemma armExecuteNever_armExecuteNever_update [simp]:
  "armExecuteNever (armExecuteNever_update f v) = f (armExecuteNever v)"
  by (cases v) simp

lemma armExecuteNever_armPageCacheable_update [simp]:
  "armExecuteNever (armPageCacheable_update f v) = armExecuteNever v"
  by (cases v) simp

lemma armPageCacheable_armExecuteNever_update [simp]:
  "armPageCacheable (armExecuteNever_update f v) = armPageCacheable v"
  by (cases v) simp

lemma armPageCacheable_armPageCacheable_update [simp]:
  "armPageCacheable (armPageCacheable_update f v) = f (armPageCacheable v)"
  by (cases v) simp

datatype vmrights =
    VMKernelOnly
  | VMReadOnly
  | VMReadWrite

datatype pte =
    InvalidPTE
  | PagePTE (pteBaseAddress : paddr) (pteSmallPage : bool) (pteGlobal : bool) (pteExecuteNever : bool) (pteDevice : bool) (pteRights : vmrights)
  | PageTablePTE (ptePPN : paddr)

primrec
  pteBaseAddress_update :: "(paddr \<Rightarrow> paddr) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteBaseAddress_update f (PagePTE v0 v1 v2 v3 v4 v5) = PagePTE (f v0) v1 v2 v3 v4 v5"

primrec
  pteSmallPage_update :: "(bool \<Rightarrow> bool) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteSmallPage_update f (PagePTE v0 v1 v2 v3 v4 v5) = PagePTE v0 (f v1) v2 v3 v4 v5"

primrec
  pteGlobal_update :: "(bool \<Rightarrow> bool) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteGlobal_update f (PagePTE v0 v1 v2 v3 v4 v5) = PagePTE v0 v1 (f v2) v3 v4 v5"

primrec
  pteExecuteNever_update :: "(bool \<Rightarrow> bool) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteExecuteNever_update f (PagePTE v0 v1 v2 v3 v4 v5) = PagePTE v0 v1 v2 (f v3) v4 v5"

primrec
  pteDevice_update :: "(bool \<Rightarrow> bool) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteDevice_update f (PagePTE v0 v1 v2 v3 v4 v5) = PagePTE v0 v1 v2 v3 (f v4) v5"

primrec
  pteRights_update :: "(vmrights \<Rightarrow> vmrights) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteRights_update f (PagePTE v0 v1 v2 v3 v4 v5) = PagePTE v0 v1 v2 v3 v4 (f v5)"

primrec
  ptePPN_update :: "(paddr \<Rightarrow> paddr) \<Rightarrow> pte \<Rightarrow> pte"
where
  "ptePPN_update f (PageTablePTE v0) = PageTablePTE (f v0)"

abbreviation (input)
  PagePTE_trans :: "(paddr) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> (vmrights) \<Rightarrow> pte" ("PagePTE'_ \<lparr> pteBaseAddress= _, pteSmallPage= _, pteGlobal= _, pteExecuteNever= _, pteDevice= _, pteRights= _ \<rparr>")
where
  "PagePTE_ \<lparr> pteBaseAddress= v0, pteSmallPage= v1, pteGlobal= v2, pteExecuteNever= v3, pteDevice= v4, pteRights= v5 \<rparr> == PagePTE v0 v1 v2 v3 v4 v5"

abbreviation (input)
  PageTablePTE_trans :: "(paddr) \<Rightarrow> pte" ("PageTablePTE'_ \<lparr> ptePPN= _ \<rparr>")
where
  "PageTablePTE_ \<lparr> ptePPN= v0 \<rparr> == PageTablePTE v0"

definition
  isInvalidPTE :: "pte \<Rightarrow> bool"
where
 "isInvalidPTE v \<equiv> case v of
    InvalidPTE \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPagePTE :: "pte \<Rightarrow> bool"
where
 "isPagePTE v \<equiv> case v of
    PagePTE v0 v1 v2 v3 v4 v5 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageTablePTE :: "pte \<Rightarrow> bool"
where
 "isPageTablePTE v \<equiv> case v of
    PageTablePTE v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
fromPAddr :: "paddr \<Rightarrow> machine_word"
where
"fromPAddr \<equiv> Platform.AARCH64.fromPAddr"

definition
pptrTop :: "vptr"
where
"pptrTop \<equiv> VPtr 0x000000FFC0000000"

definition
paddrTop :: "paddr"
where
"paddrTop\<equiv> toPAddr $ (fromVPtr pptrTop - pptrBaseOffset)"

definition
pteBits :: "nat"
where
"pteBits \<equiv> 3"

definition
ptBits :: "pt_type \<Rightarrow> nat"
where
"ptBits pt_t \<equiv> ptTranslationBits pt_t + pteBits"

definition
initIRQController :: "unit machine_monad"
where
"initIRQController \<equiv> error []"

definition
vmRightsToBits :: "vmrights \<Rightarrow> machine_word"
where
"vmRightsToBits x0\<equiv> (case x0 of
    VMKernelOnly \<Rightarrow>    1
  | VMReadOnly \<Rightarrow>    2
  | VMReadWrite \<Rightarrow>    3
  )"

definition
allowWrite :: "vmrights \<Rightarrow> bool"
where
"allowWrite x0\<equiv> (case x0 of
    VMKernelOnly \<Rightarrow>    False
  | VMReadOnly \<Rightarrow>    False
  | VMReadWrite \<Rightarrow>    True
  )"

definition
allowRead :: "vmrights \<Rightarrow> bool"
where
"allowRead x0\<equiv> (case x0 of
    VMKernelOnly \<Rightarrow>    False
  | VMReadOnly \<Rightarrow>    True
  | VMReadWrite \<Rightarrow>    True
  )"

definition
getVMRights :: "bool \<Rightarrow> bool \<Rightarrow> vmrights"
where
"getVMRights x0 x1\<equiv> (case (x0, x1) of
    (True, True) \<Rightarrow>    VMReadWrite
  | (False, True) \<Rightarrow>    VMReadOnly
  | (_, _) \<Rightarrow>    VMKernelOnly
  )"

definition
vmRightsFromBits :: "machine_word \<Rightarrow> vmrights"
where
"vmRightsFromBits rw\<equiv> getVMRights (testBit rw 1) (testBit rw 0)"

definition
pageColourBits :: "nat"
where
"pageColourBits \<equiv> Platform.AARCH64.pageColourBits"


end

context begin interpretation Arch .
requalify_types vmrights
end

context Arch begin global_naming AARCH64_H



end (* context AARCH64 *)

end
