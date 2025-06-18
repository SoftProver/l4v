(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file MachineTypes.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "RISCV 64bit Machine Types"

theory MachineTypes
imports
  Word_Lib.WordSetup
  Monads.Nondet_Empty_Fail
  Monads.Nondet_Reader_Option
  Lib.HaskellLib_H
  Platform
begin

context Arch begin global_naming RISCV64

text \<open>
  An implementation of the machine's types, defining register set
  and some observable machine state.
\<close>

section "Types"

datatype register =
    LR
  | SP
  | GP
  | S0
  | S1
  | S2
  | S3
  | S4
  | S5
  | S6
  | S7
  | S8
  | S9
  | S10
  | S11
  | A0
  | A1
  | A2
  | A3
  | A4
  | A5
  | A6
  | A7
  | T0
  | T1
  | T2
  | T3
  | T4
  | T5
  | T6
  | TP
  | SCAUSE
  | SSTATUS
  | FaultIP
  | NextIP

consts'
capRegister :: "register"

consts'
msgInfoRegister :: "register"

consts'
msgRegisters :: "register list"

consts'
badgeRegister :: "register"

consts'
frameRegisters :: "register list"

consts'
gpRegisters :: "register list"

consts'
exceptionMessage :: "register list"

consts'
syscallMessage :: "register list"

consts'
tlsBaseRegister :: "register"

consts'
sstatusSPIE :: "machine_word"

consts'
initContext :: "(register * machine_word) list"

consts'
faultRegister :: "register"

consts'
nextInstructionRegister :: "register"

(*<*)

end

context begin interpretation Arch .
requalify_types register
end

context Arch begin global_naming RISCV64

end
qualify RISCV64 (in Arch) 
(* register instance proofs *)
(*<*)
instantiation register :: enum begin
interpretation Arch .
definition
  enum_register: "enum_class.enum \<equiv> 
    [ 
      LR,
      SP,
      GP,
      S0,
      S1,
      S2,
      S3,
      S4,
      S5,
      S6,
      S7,
      S8,
      S9,
      S10,
      S11,
      A0,
      A1,
      A2,
      A3,
      A4,
      A5,
      A6,
      A7,
      T0,
      T1,
      T2,
      T3,
      T4,
      T5,
      T6,
      TP,
      SCAUSE,
      SSTATUS,
      FaultIP,
      NextIP
    ]"


definition
  "enum_class.enum_all (P :: register \<Rightarrow> bool) \<longleftrightarrow> Ball UNIV P"

definition
  "enum_class.enum_ex (P :: register \<Rightarrow> bool) \<longleftrightarrow> Bex UNIV P"

  instance
  apply intro_classes
   apply (safe, simp)
   apply (case_tac x)
  apply (simp_all add: enum_register enum_all_register_def enum_ex_register_def)
  by fast+
end

instantiation register :: enum_alt
begin
interpretation Arch .
definition
  enum_alt_register: "enum_alt \<equiv> 
    alt_from_ord (enum :: register list)"
instance ..
end

instantiation register :: enumeration_both
begin
interpretation Arch .
instance by (intro_classes, simp add: enum_alt_register)
end

(*>*)
end_qualify
context Arch begin global_naming RISCV64

(*>*)
defs capRegister_def:
"capRegister \<equiv> A0"

defs msgInfoRegister_def:
"msgInfoRegister \<equiv> A1"

defs msgRegisters_def:
"msgRegisters \<equiv> [A2  .e.  A5]"

defs badgeRegister_def:
"badgeRegister \<equiv> A0"

defs frameRegisters_def:
"frameRegisters \<equiv> FaultIP # LR # SP # GP # [S0  .e.  S11]"

defs gpRegisters_def:
"gpRegisters \<equiv> [A0  .e.  A7] @ [T0  .e.  T6] @ [TP]"

defs exceptionMessage_def:
"exceptionMessage \<equiv> [FaultIP, SP]"

defs syscallMessage_def:
"syscallMessage \<equiv> FaultIP # SP # LR # [A0  .e.  A6]"

defs tlsBaseRegister_def:
"tlsBaseRegister \<equiv> TP"

defs sstatusSPIE_def:
"sstatusSPIE \<equiv> 0x20"

defs initContext_def:
"initContext\<equiv> [ (SSTATUS , sstatusSPIE) ]"

defs faultRegister_def:
"faultRegister \<equiv> FaultIP"

defs nextInstructionRegister_def:
"nextInstructionRegister \<equiv> NextIP"


section "Machine State"

text \<open>
  Most of the machine state is left underspecified at this level.
  We know it exists, we will declare some interface functions, but
  at this level we do not have access to how this state is transformed
  or what effect it has on the machine.
\<close>
typedecl machine_state_rest

end

qualify RISCV64 (in Arch)

record
  machine_state =
  irq_masks :: "RISCV64.irq \<Rightarrow> bool"
  irq_state :: nat
  underlying_memory :: "machine_word \<Rightarrow> word8"
  device_state :: "machine_word \<Rightarrow> word8 option"
  machine_state_rest :: RISCV64.machine_state_rest

axiomatization
  irq_oracle :: "nat \<Rightarrow> RISCV64.irq"
where
  irq_oracle_max_irq: "\<forall>n. irq_oracle n <= RISCV64.maxIRQ"

end_qualify

context Arch begin global_naming RISCV64

text \<open>
  The machine monad is used for operations on the state defined above.
\<close>
type_synonym 'a machine_monad = "(machine_state, 'a) nondet_monad"

end

translations
  (type) "'c RISCV64.machine_monad" <= (type) "(RISCV64.machine_state, 'c) nondet_monad"

context Arch begin global_naming RISCV64

text \<open>
  After kernel initialisation all IRQs are masked.
\<close>
definition
  "init_irq_masks \<equiv> \<lambda>_. True"

text \<open>
  The initial contents of the user-visible memory is 0.
\<close>
definition
  init_underlying_memory :: "machine_word \<Rightarrow> word8"
  where
  "init_underlying_memory \<equiv> \<lambda>_. 0"

text \<open>
  We leave open the underspecified rest of the machine state in
  the initial state.
\<close>
definition
  init_machine_state :: machine_state where
 "init_machine_state \<equiv> \<lparr> irq_masks = init_irq_masks,
                         irq_state = 0,
                         underlying_memory = init_underlying_memory,
                         device_state = Map.empty,
                         machine_state_rest = undefined \<rparr>"

datatype vmpage_size =
    RISCVSmallPage
  | RISCVLargePage
  | RISCVHugePage

datatype vmfault_type =
    RISCVInstructionAccessFault
  | RISCVLoadAccessFault
  | RISCVStoreAccessFault
  | RISCVInstructionPageFault
  | RISCVLoadPageFault
  | RISCVStorePageFault

datatype hyp_fault_type =
    RISCVNoHypFaults

definition
vmFaultTypeFSR :: "vmfault_type \<Rightarrow> machine_word"
where
"vmFaultTypeFSR f \<equiv>
    (case f of
          RISCVInstructionAccessFault \<Rightarrow>   1
        | RISCVLoadAccessFault \<Rightarrow>   5
        | RISCVStoreAccessFault \<Rightarrow>   7
        | RISCVInstructionPageFault \<Rightarrow>   12
        | RISCVLoadPageFault \<Rightarrow>   13
        | RISCVStorePageFault \<Rightarrow>   15
        )"

definition
pageBits :: "nat"
where
"pageBits \<equiv> 12"

definition
ptTranslationBits :: "nat"
where
"ptTranslationBits \<equiv> 9"

definition
pageBitsForSize :: "vmpage_size \<Rightarrow> nat"
where
"pageBitsForSize x0\<equiv> (case x0 of
    RISCVSmallPage \<Rightarrow>    pageBits
  | RISCVLargePage \<Rightarrow>    pageBits + ptTranslationBits
  | RISCVHugePage \<Rightarrow>    pageBits + ptTranslationBits + ptTranslationBits
  )"


end

context begin interpretation Arch .
requalify_types vmpage_size
end

context Arch begin global_naming RISCV64

end
qualify RISCV64 (in Arch) 
(* vmpage_size instance proofs *)
(*<*)
instantiation vmpage_size :: enum begin
interpretation Arch .
definition
  enum_vmpage_size: "enum_class.enum \<equiv> 
    [ 
      RISCVSmallPage,
      RISCVLargePage,
      RISCVHugePage
    ]"


definition
  "enum_class.enum_all (P :: vmpage_size \<Rightarrow> bool) \<longleftrightarrow> Ball UNIV P"

definition
  "enum_class.enum_ex (P :: vmpage_size \<Rightarrow> bool) \<longleftrightarrow> Bex UNIV P"

  instance
  apply intro_classes
   apply (safe, simp)
   apply (case_tac x)
  apply (simp_all add: enum_vmpage_size enum_all_vmpage_size_def enum_ex_vmpage_size_def)
  by fast+
end

instantiation vmpage_size :: enum_alt
begin
interpretation Arch .
definition
  enum_alt_vmpage_size: "enum_alt \<equiv> 
    alt_from_ord (enum :: vmpage_size list)"
instance ..
end

instantiation vmpage_size :: enumeration_both
begin
interpretation Arch .
instance by (intro_classes, simp add: enum_alt_vmpage_size)
end

(*>*)
end_qualify
context Arch begin global_naming RISCV64


end
end
