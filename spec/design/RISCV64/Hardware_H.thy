(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file Hardware_H.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

theory Hardware_H
imports
  MachineOps
  State_H
begin

context Arch begin global_naming RISCV64_H

type_synonym irq = "Platform.RISCV64.irq"

type_synonym paddr = "Platform.RISCV64.paddr"

type_synonym vmattributes = "bool"

definition
  VMAttributes :: "vmattributes \<Rightarrow> vmattributes"
where VMAttributes_def[simp]:
 "VMAttributes \<equiv> id"

definition
  riscvExecuteNever :: "vmattributes \<Rightarrow> vmattributes"
where
  riscvExecuteNever_def[simp]:
 "riscvExecuteNever \<equiv> id"

definition  riscvExecuteNever_update :: "(vmattributes \<Rightarrow> vmattributes) \<Rightarrow> vmattributes \<Rightarrow> vmattributes"
where
  riscvExecuteNever_update_def[simp]:
 "riscvExecuteNever_update f y \<equiv> f y"

abbreviation (input)
  VMAttributes_trans :: "(bool) \<Rightarrow> vmattributes" ("VMAttributes'_ \<lparr> riscvExecuteNever= _ \<rparr>")
where
  "VMAttributes_ \<lparr> riscvExecuteNever= v0 \<rparr> == VMAttributes v0"

datatype vmrights =
    VMKernelOnly
  | VMReadOnly
  | VMReadWrite

datatype pte =
    InvalidPTE
  | PagePTE (ptePPN : paddr) (pteGlobal : bool) (pteUser : bool) (pteExecute : bool) (pteRights : vmrights)
  | PageTablePTE (ptePPN : paddr) (pteGlobal : bool)

primrec
  ptePPN_update :: "(paddr \<Rightarrow> paddr) \<Rightarrow> pte \<Rightarrow> pte"
where
  "ptePPN_update f (PagePTE v0 v1 v2 v3 v4) = PagePTE (f v0) v1 v2 v3 v4"
| "ptePPN_update f (PageTablePTE v0 v1) = PageTablePTE (f v0) v1"

primrec
  pteGlobal_update :: "(bool \<Rightarrow> bool) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteGlobal_update f (PagePTE v0 v1 v2 v3 v4) = PagePTE v0 (f v1) v2 v3 v4"
| "pteGlobal_update f (PageTablePTE v0 v1) = PageTablePTE v0 (f v1)"

primrec
  pteUser_update :: "(bool \<Rightarrow> bool) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteUser_update f (PagePTE v0 v1 v2 v3 v4) = PagePTE v0 v1 (f v2) v3 v4"

primrec
  pteExecute_update :: "(bool \<Rightarrow> bool) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteExecute_update f (PagePTE v0 v1 v2 v3 v4) = PagePTE v0 v1 v2 (f v3) v4"

primrec
  pteRights_update :: "(vmrights \<Rightarrow> vmrights) \<Rightarrow> pte \<Rightarrow> pte"
where
  "pteRights_update f (PagePTE v0 v1 v2 v3 v4) = PagePTE v0 v1 v2 v3 (f v4)"

abbreviation (input)
  PagePTE_trans :: "(paddr) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> (vmrights) \<Rightarrow> pte" ("PagePTE'_ \<lparr> ptePPN= _, pteGlobal= _, pteUser= _, pteExecute= _, pteRights= _ \<rparr>")
where
  "PagePTE_ \<lparr> ptePPN= v0, pteGlobal= v1, pteUser= v2, pteExecute= v3, pteRights= v4 \<rparr> == PagePTE v0 v1 v2 v3 v4"

abbreviation (input)
  PageTablePTE_trans :: "(paddr) \<Rightarrow> (bool) \<Rightarrow> pte" ("PageTablePTE'_ \<lparr> ptePPN= _, pteGlobal= _ \<rparr>")
where
  "PageTablePTE_ \<lparr> ptePPN= v0, pteGlobal= v1 \<rparr> == PageTablePTE v0 v1"

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
    PagePTE v0 v1 v2 v3 v4 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isPageTablePTE :: "pte \<Rightarrow> bool"
where
 "isPageTablePTE v \<equiv> case v of
    PageTablePTE v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
fromPAddr :: "paddr \<Rightarrow> machine_word"
where
"fromPAddr \<equiv> Platform.RISCV64.fromPAddr"

definition
pteBits :: "nat"
where
"pteBits \<equiv> 3"

definition
ptBits :: "nat"
where
"ptBits \<equiv> ptTranslationBits + pteBits"

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
"pageColourBits \<equiv> Platform.RISCV64.pageColourBits"


end

context begin interpretation Arch .
requalify_types vmrights
end

context Arch begin global_naming RISCV64_H



end (* context RISCV64 *)

end
