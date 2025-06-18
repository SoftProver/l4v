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

context Arch begin global_naming AARCH64_H

definition
decodeTransfer :: "word8 \<Rightarrow> ( syscall_error , copy_register_sets ) kernel_f"
where
"decodeTransfer arg1 \<equiv> returnOk ARMNoExtraRegisters"

definition
performTransfer :: "copy_register_sets \<Rightarrow> machine_word \<Rightarrow> machine_word \<Rightarrow> unit kernel"
where
"performTransfer arg1 arg2 arg3 \<equiv> return ()"

definition
sanitiseRegister :: "bool \<Rightarrow> register \<Rightarrow> machine_word \<Rightarrow> machine_word"
where
"sanitiseRegister b x1 v\<equiv> (case x1 of
    SPSR_EL1 \<Rightarrow>  
  let
   v' = (v && 0xf0000000) || 0x140;
        modes = [0, 4, 5]
  in
  
  if (b \<and> ((v && 0x1f) `~elem~` modes))
      then v
      else v'
  | _ \<Rightarrow>    v
  )"

definition
getSanitiseRegisterInfo :: "machine_word \<Rightarrow> bool kernel"
where
"getSanitiseRegisterInfo t\<equiv> (do
   v \<leftarrow> liftM (atcbVCPUPtr \<circ> tcbArch) $ getObject t;
   return $ isJust v
od)"

definition
postModifyRegisters :: "machine_word \<Rightarrow> machine_word \<Rightarrow> unit user_monad"
where
"postModifyRegisters arg1 arg2 \<equiv> return ()"


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
