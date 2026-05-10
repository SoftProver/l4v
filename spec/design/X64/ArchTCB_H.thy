(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchTCB_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

theory ArchTCB_H
imports TCBDecls_H
begin

context Arch begin global_naming X64_H

definition
decodeTransfer :: "word8 \<Rightarrow> ( syscall_error , copy_register_sets ) kernel_f"
where
"decodeTransfer arg1 \<equiv> returnOk X64NoExtraRegisters"

definition
performTransfer :: "copy_register_sets \<Rightarrow> machine_word \<Rightarrow> machine_word \<Rightarrow> unit kernel"
where
"performTransfer arg1 arg2 arg3 \<equiv> return ()"

definition
sanitiseOrFlags :: "machine_word"
where
"sanitiseOrFlags \<equiv> (1 << 1) || bit 9"

definition
sanitiseAndFlags :: "machine_word"
where
"sanitiseAndFlags\<equiv> ((1 << 12) - 1) && (complement (bit 3)) && (complement (bit 5)) && (complement (bit 8))"

definition
sanitiseRegister :: "bool \<Rightarrow> register \<Rightarrow> machine_word \<Rightarrow> machine_word"
where
"sanitiseRegister arg1 r v \<equiv>
    let val = if r = FaultIP \<or> r = NextIP \<or> r = FS_BASE \<or> r = GS_BASE then
                 if v > 0x00007fffffffffff \<and> v < 0xffff800000000000 then 0 else v
              else v
    in
        if r = FLAGS then
            (val || sanitiseOrFlags) && sanitiseAndFlags
        else val"

definition
getSanitiseRegisterInfo :: "machine_word \<Rightarrow> bool kernel"
where
"getSanitiseRegisterInfo arg1 \<equiv> return False"

definition
postModifyRegisters :: "machine_word \<Rightarrow> machine_word \<Rightarrow> unit user_monad"
where
"postModifyRegisters cur dest \<equiv>
    when (dest \<noteq> cur) $ setRegister (Register ErrorRegister) 0"


definition
archThreadGet :: "(arch_tcb \<Rightarrow> 'a) \<Rightarrow> machine_word \<Rightarrow> 'a kernel"
where
"archThreadGet f tptr\<equiv> liftM (f \<circ> tcbArch) $ getObject tptr"

definition
archThreadSet :: "(arch_tcb \<Rightarrow> arch_tcb) \<Rightarrow> machine_word \<Rightarrow> unit kernel"
where
"archThreadSet f tptr\<equiv> (do
        tcb \<leftarrow> getObject tptr;
        setObject tptr $ tcb \<lparr> tcbArch := f (tcbArch tcb) \<rparr>
od)"


end
end
