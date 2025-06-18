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
  RegisterSet_H
begin
context Arch begin global_naming X64_H

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


context Arch begin global_naming X64_H

type_synonym register = "X64.register"

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
"msgInfoRegister \<equiv> Register X64.msgInfoRegister"

definition
msgRegisters :: "register list"
where
"msgRegisters \<equiv> map Register X64.msgRegisters"

definition
capRegister :: "register"
where
"capRegister \<equiv> Register X64.capRegister"

definition
badgeRegister :: "register"
where
"badgeRegister \<equiv> Register X64.badgeRegister"

definition
frameRegisters :: "register list"
where
"frameRegisters \<equiv> map Register X64.frameRegisters"

definition
gpRegisters :: "register list"
where
"gpRegisters \<equiv> map Register X64.gpRegisters"

definition
exceptionMessage :: "register list"
where
"exceptionMessage \<equiv> map Register X64.exceptionMessage"

definition
syscallMessage :: "register list"
where
"syscallMessage \<equiv> map Register X64.syscallMessage"

definition
tlsBaseRegister :: "register"
where
"tlsBaseRegister \<equiv> Register X64.tlsBaseRegister"

definition
faultRegister :: "register"
where
"faultRegister \<equiv> Register X64.faultRegister"

definition
nextInstructionRegister :: "register"
where
"nextInstructionRegister \<equiv> Register X64.nextInstructionRegister"


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
