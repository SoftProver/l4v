(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file State_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
    Machine and kernel state.
*)

chapter "Machine State"

theory State_H
imports
  "Lib.HaskellLib_H"
  RegisterSet_H
  MachineOps
begin
context Arch begin global_naming ARM_HYP_H

definition
  Word :: "machine_word \<Rightarrow> machine_word"
where
  Word_def[simp]:
 "Word \<equiv> id"

definition
wordBits :: "nat"
where
"wordBits\<equiv> finiteBitSize (undefined::machine_word)"


end

context begin interpretation Arch .

requalify_consts
  wordBits

end

definition
wordSize :: "nat"
where
"wordSize \<equiv> wordBits div 8"

definition
wordSizeCase :: "'a \<Rightarrow> 'a \<Rightarrow> 'a"
where
"wordSizeCase a b\<equiv> (if wordBits = 32
        then  a
        else if wordBits = 64
        then  b
        else  error []
        )"

definition
wordRadix :: "nat"
where
"wordRadix \<equiv> wordSizeCase 5 6"

definition
countTrailingZeros :: "('b :: {HS_bit, finiteBit}) \<Rightarrow> nat"
where
"countTrailingZeros w \<equiv>
   length \<circ> takeWhile Not \<circ> map (testBit w) $ [0  .e.  finiteBitSize w - 1]"


context Arch begin global_naming ARM_HYP_H


type_synonym register = "ARM_HYP.register"

definition
  Register :: "register \<Rightarrow> register"
where Register_def[simp]:
 "Register \<equiv> id"

type_synonym vptr = "machine_word"

definition
  VPtr :: "vptr \<Rightarrow> vptr"
where VPtr_def[simp]:
 "VPtr \<equiv> id"

definition
  fromVPtr :: "vptr \<Rightarrow> vptr"
where
  fromVPtr_def[simp]:
 "fromVPtr \<equiv> id"

definition  fromVPtr_update :: "(vptr \<Rightarrow> vptr) \<Rightarrow> vptr \<Rightarrow> vptr"
where
  fromVPtr_update_def[simp]:
 "fromVPtr_update f y \<equiv> f y"

abbreviation (input)
  VPtr_trans :: "(machine_word) \<Rightarrow> vptr" ("VPtr'_ \<lparr> fromVPtr= _ \<rparr>")
where
  "VPtr_ \<lparr> fromVPtr= v0 \<rparr> == VPtr v0"

definition
msgInfoRegister :: "register"
where
"msgInfoRegister \<equiv> Register ARM_HYP.msgInfoRegister"

definition
msgRegisters :: "register list"
where
"msgRegisters \<equiv> map Register ARM_HYP.msgRegisters"

definition
capRegister :: "register"
where
"capRegister \<equiv> Register ARM_HYP.capRegister"

definition
badgeRegister :: "register"
where
"badgeRegister \<equiv> Register ARM_HYP.badgeRegister"

definition
frameRegisters :: "register list"
where
"frameRegisters \<equiv> map Register ARM_HYP.frameRegisters"

definition
gpRegisters :: "register list"
where
"gpRegisters \<equiv> map Register ARM_HYP.gpRegisters"

definition
exceptionMessage :: "register list"
where
"exceptionMessage \<equiv> map Register ARM_HYP.exceptionMessage"

definition
syscallMessage :: "register list"
where
"syscallMessage \<equiv> map Register ARM_HYP.syscallMessage"

definition
tlsBaseRegister :: "register"
where
"tlsBaseRegister \<equiv> Register ARM_HYP.tlsBaseRegister"

definition
faultRegister :: "register"
where
"faultRegister \<equiv> Register ARM_HYP.faultRegister"

definition
nextInstructionRegister :: "register"
where
"nextInstructionRegister \<equiv> Register ARM_HYP.nextInstructionRegister"


definition
  PPtr :: "machine_word \<Rightarrow> machine_word"
where
  PPtr_def[simp]:
 "PPtr \<equiv> id"

definition
  fromPPtr :: "machine_word \<Rightarrow> machine_word"
where
  fromPPtr_def[simp]:
 "fromPPtr \<equiv> id"

definition
  nullPointer :: machine_word
where
 "nullPointer \<equiv> 0"

end
end
