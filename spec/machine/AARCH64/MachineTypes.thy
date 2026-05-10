(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file MachineTypes.thy *)
(*
 * Copyright 2022, Proofcraft Pty Ltd
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "AARCH64 Machine Types"

theory MachineTypes
imports
  Word_Lib.WordSetup
  Monads.Nondet_Empty_Fail
  Monads.Nondet_No_Fail
  Monads.Reader_Option_ND
  Lib.HaskellLib_H
  Platform
begin

context Arch begin global_naming AARCH64


text \<open>
  An implementation of the machine's types, defining register set
  and some observable machine state.
\<close>

section "Types"

datatype register =
    X0
  | X1
  | X2
  | X3
  | X4
  | X5
  | X6
  | X7
  | X8
  | X9
  | X10
  | X11
  | X12
  | X13
  | X14
  | X15
  | X16
  | X17
  | X18
  | X19
  | X20
  | X21
  | X22
  | X23
  | X24
  | X25
  | X26
  | X27
  | X28
  | X29
  | X30
  | SP_EL0
  | NextIP
  | SPSR_EL1
  | FaultIP
  | TPIDR_EL0
  | TPIDRRO_EL0

datatype vcpureg =
    VCPURegSCTLR
  | VCPURegTTBR0
  | VCPURegTTBR1
  | VCPURegTCR
  | VCPURegMAIR
  | VCPURegAMAIR
  | VCPURegCIDR
  | VCPURegACTLR
  | VCPURegCPACR
  | VCPURegAFSR0
  | VCPURegAFSR1
  | VCPURegESR
  | VCPURegFAR
  | VCPURegISR
  | VCPURegVBAR
  | VCPURegTPIDR_EL1
  | VCPURegSP_EL1
  | VCPURegELR_EL1
  | VCPURegSPSR_EL1
  | VCPURegCNTV_CTL
  | VCPURegCNTV_CVAL
  | VCPURegCNTVOFF
  | VCPURegCNTKCTL_EL1

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
pstateUser :: "machine_word"

consts'
initContext :: "(register * machine_word) list"

consts'
faultRegister :: "register"

consts'
nextInstructionRegister :: "register"

consts'
vcpuRegNum :: "nat"

consts'
vcpuRegSavedWhenDisabled :: "vcpureg \<Rightarrow> bool"


datatype virt_timer =
    VirtTimer (vtimerLastPCount : word64)

primrec
  vtimerLastPCount_update :: "(word64 \<Rightarrow> word64) \<Rightarrow> virt_timer \<Rightarrow> virt_timer"
where
  "vtimerLastPCount_update f (VirtTimer v0) = VirtTimer (f v0)"

abbreviation (input)
  VirtTimer_trans :: "(word64) \<Rightarrow> virt_timer" ("VirtTimer'_ \<lparr> vtimerLastPCount= _ \<rparr>")
where
  "VirtTimer_ \<lparr> vtimerLastPCount= v0 \<rparr> == VirtTimer v0"

lemma vtimerLastPCount_vtimerLastPCount_update [simp]:
  "vtimerLastPCount (vtimerLastPCount_update f v) = f (vtimerLastPCount v)"
  by (cases v) simp

datatype vppievent_irq =
    VPPIEventIRQ_VTimer

(*<*)

end

context begin interpretation Arch .
requalify_types register vcpureg vppievent_irq virt_timer
end

context Arch begin global_naming AARCH64

end
qualify AARCH64 (in Arch) 
(* register instance proofs *)
(*<*)
instantiation register :: enum begin
interpretation Arch .
definition
  enum_register: "enum_class.enum \<equiv> 
    [ 
      X0,
      X1,
      X2,
      X3,
      X4,
      X5,
      X6,
      X7,
      X8,
      X9,
      X10,
      X11,
      X12,
      X13,
      X14,
      X15,
      X16,
      X17,
      X18,
      X19,
      X20,
      X21,
      X22,
      X23,
      X24,
      X25,
      X26,
      X27,
      X28,
      X29,
      X30,
      SP_EL0,
      NextIP,
      SPSR_EL1,
      FaultIP,
      TPIDR_EL0,
      TPIDRRO_EL0
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
context Arch begin global_naming AARCH64

end
qualify AARCH64 (in Arch) 
(* vcpureg instance proofs *)
(*<*)
instantiation vcpureg :: enum begin
interpretation Arch .
definition
  enum_vcpureg: "enum_class.enum \<equiv> 
    [ 
      VCPURegSCTLR,
      VCPURegTTBR0,
      VCPURegTTBR1,
      VCPURegTCR,
      VCPURegMAIR,
      VCPURegAMAIR,
      VCPURegCIDR,
      VCPURegACTLR,
      VCPURegCPACR,
      VCPURegAFSR0,
      VCPURegAFSR1,
      VCPURegESR,
      VCPURegFAR,
      VCPURegISR,
      VCPURegVBAR,
      VCPURegTPIDR_EL1,
      VCPURegSP_EL1,
      VCPURegELR_EL1,
      VCPURegSPSR_EL1,
      VCPURegCNTV_CTL,
      VCPURegCNTV_CVAL,
      VCPURegCNTVOFF,
      VCPURegCNTKCTL_EL1
    ]"


definition
  "enum_class.enum_all (P :: vcpureg \<Rightarrow> bool) \<longleftrightarrow> Ball UNIV P"

definition
  "enum_class.enum_ex (P :: vcpureg \<Rightarrow> bool) \<longleftrightarrow> Bex UNIV P"

  instance
  apply intro_classes
   apply (safe, simp)
   apply (case_tac x)
  apply (simp_all add: enum_vcpureg enum_all_vcpureg_def enum_ex_vcpureg_def)
  by fast+
end

instantiation vcpureg :: enum_alt
begin
interpretation Arch .
definition
  enum_alt_vcpureg: "enum_alt \<equiv> 
    alt_from_ord (enum :: vcpureg list)"
instance ..
end

instantiation vcpureg :: enumeration_both
begin
interpretation Arch .
instance by (intro_classes, simp add: enum_alt_vcpureg)
end

(*>*)
end_qualify
context Arch begin global_naming AARCH64

end
qualify AARCH64 (in Arch) 
(* vppievent_irq instance proofs *)
(*<*)
instantiation vppievent_irq :: enum begin
interpretation Arch .
definition
  enum_vppievent_irq: "enum_class.enum \<equiv> 
    [ 
      VPPIEventIRQ_VTimer
    ]"


definition
  "enum_class.enum_all (P :: vppievent_irq \<Rightarrow> bool) \<longleftrightarrow> Ball UNIV P"

definition
  "enum_class.enum_ex (P :: vppievent_irq \<Rightarrow> bool) \<longleftrightarrow> Bex UNIV P"

  instance
  apply intro_classes
   apply (safe, simp)
   apply (case_tac x)
  apply (auto simp: enum_vppievent_irq enum_all_vppievent_irq_def enum_ex_vppievent_irq_def
    distinct_map_enum)
  done
end

instantiation vppievent_irq :: enum_alt
begin
interpretation Arch .
definition
  enum_alt_vppievent_irq: "enum_alt \<equiv> 
    alt_from_ord (enum :: vppievent_irq list)"
instance ..
end

instantiation vppievent_irq :: enumeration_both
begin
interpretation Arch .
instance by (intro_classes, simp add: enum_alt_vppievent_irq)
end

(*>*)
end_qualify
context Arch begin global_naming AARCH64

(*>*)
defs capRegister_def:
"capRegister \<equiv> X0"

defs msgInfoRegister_def:
"msgInfoRegister \<equiv> X1"

defs msgRegisters_def:
"msgRegisters \<equiv> [X2  .e.  X5]"

defs badgeRegister_def:
"badgeRegister \<equiv> X0"

defs frameRegisters_def:
"frameRegisters \<equiv> FaultIP # SP_EL0 # SPSR_EL1 # [X0  .e.  X8] @ [X16, X17, X18, X29, X30]"

defs gpRegisters_def:
"gpRegisters \<equiv> [X9  .e.  X15] @ [X19  .e.  X28] @ [TPIDR_EL0, TPIDRRO_EL0]"

defs exceptionMessage_def:
"exceptionMessage \<equiv> [FaultIP, SP_EL0, SPSR_EL1]"

defs syscallMessage_def:
"syscallMessage \<equiv> [X0  .e.  X7] @ [FaultIP, SP_EL0, NextIP, SPSR_EL1]"

defs tlsBaseRegister_def:
"tlsBaseRegister \<equiv> TPIDR_EL0"

defs pstateUser_def:
"pstateUser \<equiv>  0x140"

defs initContext_def:
"initContext \<equiv> [ (SPSR_EL1 , pstateUser) ]"

defs faultRegister_def:
"faultRegister \<equiv> FaultIP"

defs nextInstructionRegister_def:
"nextInstructionRegister \<equiv> NextIP"

defs vcpuRegNum_def:
"vcpuRegNum\<equiv> fromEnum (maxBound ::vcpureg)"

defs vcpuRegSavedWhenDisabled_def:
"vcpuRegSavedWhenDisabled x0\<equiv> (case x0 of
    VCPURegSCTLR \<Rightarrow>    True
  | VCPURegCNTV_CTL \<Rightarrow>    True
  | VCPURegCPACR \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"


section "Machine State"

text \<open>
  Most of the machine state is left underspecified at this level.
  We know it exists, we will declare some interface functions, but
  at this level we do not have access to how this state is transformed
  or what effect it has on the machine.
\<close>
typedecl machine_state_rest

end

qualify AARCH64 (in Arch)

record
  machine_state =
  irq_masks :: "AARCH64.irq \<Rightarrow> bool"
  irq_state :: nat
  underlying_memory :: "machine_word \<Rightarrow> word8"
  device_state :: "machine_word \<Rightarrow> word8 option"
  machine_state_rest :: AARCH64.machine_state_rest

axiomatization
  irq_oracle :: "nat \<Rightarrow> AARCH64.irq"
where
  irq_oracle_max_irq: "\<forall>n. irq_oracle n <= AARCH64.maxIRQ"

end_qualify

context Arch begin global_naming AARCH64

text \<open>
  The machine monad is used for operations on the state defined above.
\<close>
type_synonym 'a machine_monad = "(machine_state, 'a) nondet_monad"

end

translations
  (type) "'c AARCH64.machine_monad" <= (type) "(AARCH64.machine_state, 'c) nondet_monad"

context Arch begin global_naming AARCH64

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
    ARMSmallPage
  | ARMLargePage
  | ARMHugePage

datatype pt_type =
    VSRootPT_T
  | NormalPT_T

datatype vmfault_type =
    ARMDataAbort
  | ARMPrefetchAbort

datatype hyp_fault_type =
    ARMVCPUFault word32

definition
pageBits :: "nat"
where
"pageBits \<equiv> 12"

definition
ptTranslationBits :: "pt_type \<Rightarrow> nat"
where
"ptTranslationBits pt_t \<equiv>
    if pt_t = VSRootPT_T \<and> config_ARM_PA_SIZE_BITS_40 then 10 else 9"

definition
pageBitsForSize :: "vmpage_size \<Rightarrow> nat"
where
"pageBitsForSize x0\<equiv> (case x0 of
    ARMSmallPage \<Rightarrow>    pageBits
  | ARMLargePage \<Rightarrow>    pageBits + ptTranslationBits NormalPT_T
  | ARMHugePage \<Rightarrow>    pageBits + ptTranslationBits NormalPT_T + ptTranslationBits NormalPT_T
  )"

definition
vcpuBits :: "nat"
where
"vcpuBits \<equiv> 12"

definition
"hcrVCPU\<equiv>  (0x80086039 ::machine_word)"

definition
"hcrNative\<equiv> (0x8e28703b ::machine_word)"

definition
"sctlrEL1VM\<equiv> (0x34d58820 ::machine_word)"

definition
"sctlrDefault\<equiv> (0x34d59824 ::machine_word)"

definition
"vgicHCREN\<equiv> (0x1 ::word32)"

definition
"gicVCPUMaxNumLR\<equiv> (64 ::nat)"


end

context begin interpretation Arch .
requalify_types vmpage_size
end

context Arch begin global_naming AARCH64

end
qualify AARCH64 (in Arch) 
(* vmpage_size instance proofs *)
(*<*)
instantiation vmpage_size :: enum begin
interpretation Arch .
definition
  enum_vmpage_size: "enum_class.enum \<equiv> 
    [ 
      ARMSmallPage,
      ARMLargePage,
      ARMHugePage
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
context Arch begin global_naming AARCH64


end
end
