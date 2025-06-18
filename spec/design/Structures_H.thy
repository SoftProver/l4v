(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file Structures_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
   datatypes/records for the various kernel data structures.
*)

chapter "Kernel Data Structures"

theory Structures_H
imports
  Config_H
  State_H
  Fault_H
  Types_H
  ArchStructures_H
begin

context begin interpretation Arch .

requalify_types
  irq
  arch_capability
  user_context
  arch_kernel_object
  asid
  arch_tcb

requalify_consts
  archObjSize
  pageBits
  nullPointer
  newArchTCB
  fromPPtr
  PPtr
  atcbContextGet
  atcbContextSet

end

datatype zombie_type =
    ZombieTCB
  | ZombieCNode (zombieCTEBits : nat)

primrec
  zombieCTEBits_update :: "(nat \<Rightarrow> nat) \<Rightarrow> zombie_type \<Rightarrow> zombie_type"
where
  "zombieCTEBits_update f (ZombieCNode v0) = ZombieCNode (f v0)"

abbreviation (input)
  ZombieCNode_trans :: "(nat) \<Rightarrow> zombie_type" ("ZombieCNode'_ \<lparr> zombieCTEBits= _ \<rparr>")
where
  "ZombieCNode_ \<lparr> zombieCTEBits= v0 \<rparr> == ZombieCNode v0"

definition
  isZombieTCB :: "zombie_type \<Rightarrow> bool"
where
 "isZombieTCB v \<equiv> case v of
    ZombieTCB \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isZombieCNode :: "zombie_type \<Rightarrow> bool"
where
 "isZombieCNode v \<equiv> case v of
    ZombieCNode v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype capability =
    ThreadCap (capTCBPtr : machine_word)
  | NullCap
  | NotificationCap (capNtfnPtr : machine_word) (capNtfnBadge : machine_word) (capNtfnCanSend : bool) (capNtfnCanReceive : bool)
  | IRQHandlerCap (capIRQ : irq)
  | EndpointCap (capEPPtr : machine_word) (capEPBadge : machine_word) (capEPCanSend : bool) (capEPCanReceive : bool) (capEPCanGrant : bool) (capEPCanGrantReply : bool)
  | DomainCap
  | Zombie (capZombiePtr : machine_word) (capZombieType : zombie_type) (capZombieNumber : nat)
  | ArchObjectCap (capCap : arch_capability)
  | ReplyCap (capTCBPtr : machine_word) (capReplyMaster : bool) (capReplyCanGrant : bool)
  | UntypedCap (capIsDevice : bool) (capPtr : machine_word) (capBlockSize : nat) (capFreeIndex : nat)
  | CNodeCap (capCNodePtr : machine_word) (capCNodeBits : nat) (capCNodeGuard : machine_word) (capCNodeGuardSize : nat)
  | IRQControlCap

primrec
  capTCBPtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capTCBPtr_update f (ThreadCap v0) = ThreadCap (f v0)"
| "capTCBPtr_update f (ReplyCap v0 v1 v2) = ReplyCap (f v0) v1 v2"

primrec
  capNtfnPtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capNtfnPtr_update f (NotificationCap v0 v1 v2 v3) = NotificationCap (f v0) v1 v2 v3"

primrec
  capNtfnBadge_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capNtfnBadge_update f (NotificationCap v0 v1 v2 v3) = NotificationCap v0 (f v1) v2 v3"

primrec
  capNtfnCanSend_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capNtfnCanSend_update f (NotificationCap v0 v1 v2 v3) = NotificationCap v0 v1 (f v2) v3"

primrec
  capNtfnCanReceive_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capNtfnCanReceive_update f (NotificationCap v0 v1 v2 v3) = NotificationCap v0 v1 v2 (f v3)"

primrec
  capIRQ_update :: "(irq \<Rightarrow> irq) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capIRQ_update f (IRQHandlerCap v0) = IRQHandlerCap (f v0)"

primrec
  capEPPtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capEPPtr_update f (EndpointCap v0 v1 v2 v3 v4 v5) = EndpointCap (f v0) v1 v2 v3 v4 v5"

primrec
  capEPBadge_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capEPBadge_update f (EndpointCap v0 v1 v2 v3 v4 v5) = EndpointCap v0 (f v1) v2 v3 v4 v5"

primrec
  capEPCanSend_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capEPCanSend_update f (EndpointCap v0 v1 v2 v3 v4 v5) = EndpointCap v0 v1 (f v2) v3 v4 v5"

primrec
  capEPCanReceive_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capEPCanReceive_update f (EndpointCap v0 v1 v2 v3 v4 v5) = EndpointCap v0 v1 v2 (f v3) v4 v5"

primrec
  capEPCanGrant_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capEPCanGrant_update f (EndpointCap v0 v1 v2 v3 v4 v5) = EndpointCap v0 v1 v2 v3 (f v4) v5"

primrec
  capEPCanGrantReply_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capEPCanGrantReply_update f (EndpointCap v0 v1 v2 v3 v4 v5) = EndpointCap v0 v1 v2 v3 v4 (f v5)"

primrec
  capZombiePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capZombiePtr_update f (Zombie v0 v1 v2) = Zombie (f v0) v1 v2"

primrec
  capZombieType_update :: "(zombie_type \<Rightarrow> zombie_type) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capZombieType_update f (Zombie v0 v1 v2) = Zombie v0 (f v1) v2"

primrec
  capZombieNumber_update :: "(nat \<Rightarrow> nat) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capZombieNumber_update f (Zombie v0 v1 v2) = Zombie v0 v1 (f v2)"

primrec
  capCap_update :: "(arch_capability \<Rightarrow> arch_capability) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capCap_update f (ArchObjectCap v0) = ArchObjectCap (f v0)"

primrec
  capReplyMaster_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capReplyMaster_update f (ReplyCap v0 v1 v2) = ReplyCap v0 (f v1) v2"

primrec
  capReplyCanGrant_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capReplyCanGrant_update f (ReplyCap v0 v1 v2) = ReplyCap v0 v1 (f v2)"

primrec
  capIsDevice_update :: "(bool \<Rightarrow> bool) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capIsDevice_update f (UntypedCap v0 v1 v2 v3) = UntypedCap (f v0) v1 v2 v3"

primrec
  capPtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capPtr_update f (UntypedCap v0 v1 v2 v3) = UntypedCap v0 (f v1) v2 v3"

primrec
  capBlockSize_update :: "(nat \<Rightarrow> nat) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capBlockSize_update f (UntypedCap v0 v1 v2 v3) = UntypedCap v0 v1 (f v2) v3"

primrec
  capFreeIndex_update :: "(nat \<Rightarrow> nat) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capFreeIndex_update f (UntypedCap v0 v1 v2 v3) = UntypedCap v0 v1 v2 (f v3)"

primrec
  capCNodePtr_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capCNodePtr_update f (CNodeCap v0 v1 v2 v3) = CNodeCap (f v0) v1 v2 v3"

primrec
  capCNodeBits_update :: "(nat \<Rightarrow> nat) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capCNodeBits_update f (CNodeCap v0 v1 v2 v3) = CNodeCap v0 (f v1) v2 v3"

primrec
  capCNodeGuard_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capCNodeGuard_update f (CNodeCap v0 v1 v2 v3) = CNodeCap v0 v1 (f v2) v3"

primrec
  capCNodeGuardSize_update :: "(nat \<Rightarrow> nat) \<Rightarrow> capability \<Rightarrow> capability"
where
  "capCNodeGuardSize_update f (CNodeCap v0 v1 v2 v3) = CNodeCap v0 v1 v2 (f v3)"

abbreviation (input)
  ThreadCap_trans :: "(machine_word) \<Rightarrow> capability" ("ThreadCap'_ \<lparr> capTCBPtr= _ \<rparr>")
where
  "ThreadCap_ \<lparr> capTCBPtr= v0 \<rparr> == ThreadCap v0"

abbreviation (input)
  NotificationCap_trans :: "(machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> capability" ("NotificationCap'_ \<lparr> capNtfnPtr= _, capNtfnBadge= _, capNtfnCanSend= _, capNtfnCanReceive= _ \<rparr>")
where
  "NotificationCap_ \<lparr> capNtfnPtr= v0, capNtfnBadge= v1, capNtfnCanSend= v2, capNtfnCanReceive= v3 \<rparr> == NotificationCap v0 v1 v2 v3"

abbreviation (input)
  IRQHandlerCap_trans :: "(irq) \<Rightarrow> capability" ("IRQHandlerCap'_ \<lparr> capIRQ= _ \<rparr>")
where
  "IRQHandlerCap_ \<lparr> capIRQ= v0 \<rparr> == IRQHandlerCap v0"

abbreviation (input)
  EndpointCap_trans :: "(machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> capability" ("EndpointCap'_ \<lparr> capEPPtr= _, capEPBadge= _, capEPCanSend= _, capEPCanReceive= _, capEPCanGrant= _, capEPCanGrantReply= _ \<rparr>")
where
  "EndpointCap_ \<lparr> capEPPtr= v0, capEPBadge= v1, capEPCanSend= v2, capEPCanReceive= v3, capEPCanGrant= v4, capEPCanGrantReply= v5 \<rparr> == EndpointCap v0 v1 v2 v3 v4 v5"

abbreviation (input)
  Zombie_trans :: "(machine_word) \<Rightarrow> (zombie_type) \<Rightarrow> (nat) \<Rightarrow> capability" ("Zombie'_ \<lparr> capZombiePtr= _, capZombieType= _, capZombieNumber= _ \<rparr>")
where
  "Zombie_ \<lparr> capZombiePtr= v0, capZombieType= v1, capZombieNumber= v2 \<rparr> == Zombie v0 v1 v2"

abbreviation (input)
  ArchObjectCap_trans :: "(arch_capability) \<Rightarrow> capability" ("ArchObjectCap'_ \<lparr> capCap= _ \<rparr>")
where
  "ArchObjectCap_ \<lparr> capCap= v0 \<rparr> == ArchObjectCap v0"

abbreviation (input)
  ReplyCap_trans :: "(machine_word) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> capability" ("ReplyCap'_ \<lparr> capTCBPtr= _, capReplyMaster= _, capReplyCanGrant= _ \<rparr>")
where
  "ReplyCap_ \<lparr> capTCBPtr= v0, capReplyMaster= v1, capReplyCanGrant= v2 \<rparr> == ReplyCap v0 v1 v2"

abbreviation (input)
  UntypedCap_trans :: "(bool) \<Rightarrow> (machine_word) \<Rightarrow> (nat) \<Rightarrow> (nat) \<Rightarrow> capability" ("UntypedCap'_ \<lparr> capIsDevice= _, capPtr= _, capBlockSize= _, capFreeIndex= _ \<rparr>")
where
  "UntypedCap_ \<lparr> capIsDevice= v0, capPtr= v1, capBlockSize= v2, capFreeIndex= v3 \<rparr> == UntypedCap v0 v1 v2 v3"

abbreviation (input)
  CNodeCap_trans :: "(machine_word) \<Rightarrow> (nat) \<Rightarrow> (machine_word) \<Rightarrow> (nat) \<Rightarrow> capability" ("CNodeCap'_ \<lparr> capCNodePtr= _, capCNodeBits= _, capCNodeGuard= _, capCNodeGuardSize= _ \<rparr>")
where
  "CNodeCap_ \<lparr> capCNodePtr= v0, capCNodeBits= v1, capCNodeGuard= v2, capCNodeGuardSize= v3 \<rparr> == CNodeCap v0 v1 v2 v3"

definition
  isThreadCap :: "capability \<Rightarrow> bool"
where
 "isThreadCap v \<equiv> case v of
    ThreadCap v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isNullCap :: "capability \<Rightarrow> bool"
where
 "isNullCap v \<equiv> case v of
    NullCap \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isNotificationCap :: "capability \<Rightarrow> bool"
where
 "isNotificationCap v \<equiv> case v of
    NotificationCap v0 v1 v2 v3 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isIRQHandlerCap :: "capability \<Rightarrow> bool"
where
 "isIRQHandlerCap v \<equiv> case v of
    IRQHandlerCap v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isEndpointCap :: "capability \<Rightarrow> bool"
where
 "isEndpointCap v \<equiv> case v of
    EndpointCap v0 v1 v2 v3 v4 v5 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isDomainCap :: "capability \<Rightarrow> bool"
where
 "isDomainCap v \<equiv> case v of
    DomainCap \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isZombie :: "capability \<Rightarrow> bool"
where
 "isZombie v \<equiv> case v of
    Zombie v0 v1 v2 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isArchObjectCap :: "capability \<Rightarrow> bool"
where
 "isArchObjectCap v \<equiv> case v of
    ArchObjectCap v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isReplyCap :: "capability \<Rightarrow> bool"
where
 "isReplyCap v \<equiv> case v of
    ReplyCap v0 v1 v2 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isUntypedCap :: "capability \<Rightarrow> bool"
where
 "isUntypedCap v \<equiv> case v of
    UntypedCap v0 v1 v2 v3 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isCNodeCap :: "capability \<Rightarrow> bool"
where
 "isCNodeCap v \<equiv> case v of
    CNodeCap v0 v1 v2 v3 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isIRQControlCap :: "capability \<Rightarrow> bool"
where
 "isIRQControlCap v \<equiv> case v of
    IRQControlCap \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype endpoint =
    RecvEP (epQueue : "machine_word list")
  | IdleEP
  | SendEP (epQueue : "machine_word list")

primrec
  epQueue_update :: "((machine_word list) \<Rightarrow> (machine_word list)) \<Rightarrow> endpoint \<Rightarrow> endpoint"
where
  "epQueue_update f (RecvEP v0) = RecvEP (f v0)"
| "epQueue_update f (SendEP v0) = SendEP (f v0)"

abbreviation (input)
  RecvEP_trans :: "(machine_word list) \<Rightarrow> endpoint" ("RecvEP'_ \<lparr> epQueue= _ \<rparr>")
where
  "RecvEP_ \<lparr> epQueue= v0 \<rparr> == RecvEP v0"

abbreviation (input)
  SendEP_trans :: "(machine_word list) \<Rightarrow> endpoint" ("SendEP'_ \<lparr> epQueue= _ \<rparr>")
where
  "SendEP_ \<lparr> epQueue= v0 \<rparr> == SendEP v0"

definition
  isRecvEP :: "endpoint \<Rightarrow> bool"
where
 "isRecvEP v \<equiv> case v of
    RecvEP v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isIdleEP :: "endpoint \<Rightarrow> bool"
where
 "isIdleEP v \<equiv> case v of
    IdleEP \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isSendEP :: "endpoint \<Rightarrow> bool"
where
 "isSendEP v \<equiv> case v of
    SendEP v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype ntfn =
    IdleNtfn
  | ActiveNtfn (ntfnMsgIdentifier : machine_word)
  | WaitingNtfn (ntfnQueue : "machine_word list")

primrec
  ntfnMsgIdentifier_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> ntfn \<Rightarrow> ntfn"
where
  "ntfnMsgIdentifier_update f (ActiveNtfn v0) = ActiveNtfn (f v0)"

primrec
  ntfnQueue_update :: "((machine_word list) \<Rightarrow> (machine_word list)) \<Rightarrow> ntfn \<Rightarrow> ntfn"
where
  "ntfnQueue_update f (WaitingNtfn v0) = WaitingNtfn (f v0)"

abbreviation (input)
  ActiveNtfn_trans :: "(machine_word) \<Rightarrow> ntfn" ("ActiveNtfn'_ \<lparr> ntfnMsgIdentifier= _ \<rparr>")
where
  "ActiveNtfn_ \<lparr> ntfnMsgIdentifier= v0 \<rparr> == ActiveNtfn v0"

abbreviation (input)
  WaitingNtfn_trans :: "(machine_word list) \<Rightarrow> ntfn" ("WaitingNtfn'_ \<lparr> ntfnQueue= _ \<rparr>")
where
  "WaitingNtfn_ \<lparr> ntfnQueue= v0 \<rparr> == WaitingNtfn v0"

definition
  isIdleNtfn :: "ntfn \<Rightarrow> bool"
where
 "isIdleNtfn v \<equiv> case v of
    IdleNtfn \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isActiveNtfn :: "ntfn \<Rightarrow> bool"
where
 "isActiveNtfn v \<equiv> case v of
    ActiveNtfn v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isWaitingNtfn :: "ntfn \<Rightarrow> bool"
where
 "isWaitingNtfn v \<equiv> case v of
    WaitingNtfn v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype notification =
    NTFN (ntfnObj : ntfn) (ntfnBoundTCB : "(machine_word) option")

primrec
  ntfnObj_update :: "(ntfn \<Rightarrow> ntfn) \<Rightarrow> notification \<Rightarrow> notification"
where
  "ntfnObj_update f (NTFN v0 v1) = NTFN (f v0) v1"

primrec
  ntfnBoundTCB_update :: "(((machine_word) option) \<Rightarrow> ((machine_word) option)) \<Rightarrow> notification \<Rightarrow> notification"
where
  "ntfnBoundTCB_update f (NTFN v0 v1) = NTFN v0 (f v1)"

abbreviation (input)
  NTFN_trans :: "(ntfn) \<Rightarrow> ((machine_word) option) \<Rightarrow> notification" ("NTFN'_ \<lparr> ntfnObj= _, ntfnBoundTCB= _ \<rparr>")
where
  "NTFN_ \<lparr> ntfnObj= v0, ntfnBoundTCB= v1 \<rparr> == NTFN v0 v1"

lemma ntfnObj_ntfnObj_update [simp]:
  "ntfnObj (ntfnObj_update f v) = f (ntfnObj v)"
  by (cases v) simp

lemma ntfnObj_ntfnBoundTCB_update [simp]:
  "ntfnObj (ntfnBoundTCB_update f v) = ntfnObj v"
  by (cases v) simp

lemma ntfnBoundTCB_ntfnObj_update [simp]:
  "ntfnBoundTCB (ntfnObj_update f v) = ntfnBoundTCB v"
  by (cases v) simp

lemma ntfnBoundTCB_ntfnBoundTCB_update [simp]:
  "ntfnBoundTCB (ntfnBoundTCB_update f v) = f (ntfnBoundTCB v)"
  by (cases v) simp

datatype mdbnode =
    MDB (mdbNext : machine_word) (mdbPrev : machine_word) (mdbRevocable : bool) (mdbFirstBadged : bool)

primrec
  mdbNext_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> mdbnode \<Rightarrow> mdbnode"
where
  "mdbNext_update f (MDB v0 v1 v2 v3) = MDB (f v0) v1 v2 v3"

primrec
  mdbPrev_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> mdbnode \<Rightarrow> mdbnode"
where
  "mdbPrev_update f (MDB v0 v1 v2 v3) = MDB v0 (f v1) v2 v3"

primrec
  mdbRevocable_update :: "(bool \<Rightarrow> bool) \<Rightarrow> mdbnode \<Rightarrow> mdbnode"
where
  "mdbRevocable_update f (MDB v0 v1 v2 v3) = MDB v0 v1 (f v2) v3"

primrec
  mdbFirstBadged_update :: "(bool \<Rightarrow> bool) \<Rightarrow> mdbnode \<Rightarrow> mdbnode"
where
  "mdbFirstBadged_update f (MDB v0 v1 v2 v3) = MDB v0 v1 v2 (f v3)"

abbreviation (input)
  MDB_trans :: "(machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> mdbnode" ("MDB'_ \<lparr> mdbNext= _, mdbPrev= _, mdbRevocable= _, mdbFirstBadged= _ \<rparr>")
where
  "MDB_ \<lparr> mdbNext= v0, mdbPrev= v1, mdbRevocable= v2, mdbFirstBadged= v3 \<rparr> == MDB v0 v1 v2 v3"

lemma mdbNext_mdbNext_update [simp]:
  "mdbNext (mdbNext_update f v) = f (mdbNext v)"
  by (cases v) simp

lemma mdbNext_mdbPrev_update [simp]:
  "mdbNext (mdbPrev_update f v) = mdbNext v"
  by (cases v) simp

lemma mdbNext_mdbRevocable_update [simp]:
  "mdbNext (mdbRevocable_update f v) = mdbNext v"
  by (cases v) simp

lemma mdbNext_mdbFirstBadged_update [simp]:
  "mdbNext (mdbFirstBadged_update f v) = mdbNext v"
  by (cases v) simp

lemma mdbPrev_mdbNext_update [simp]:
  "mdbPrev (mdbNext_update f v) = mdbPrev v"
  by (cases v) simp

lemma mdbPrev_mdbPrev_update [simp]:
  "mdbPrev (mdbPrev_update f v) = f (mdbPrev v)"
  by (cases v) simp

lemma mdbPrev_mdbRevocable_update [simp]:
  "mdbPrev (mdbRevocable_update f v) = mdbPrev v"
  by (cases v) simp

lemma mdbPrev_mdbFirstBadged_update [simp]:
  "mdbPrev (mdbFirstBadged_update f v) = mdbPrev v"
  by (cases v) simp

lemma mdbRevocable_mdbNext_update [simp]:
  "mdbRevocable (mdbNext_update f v) = mdbRevocable v"
  by (cases v) simp

lemma mdbRevocable_mdbPrev_update [simp]:
  "mdbRevocable (mdbPrev_update f v) = mdbRevocable v"
  by (cases v) simp

lemma mdbRevocable_mdbRevocable_update [simp]:
  "mdbRevocable (mdbRevocable_update f v) = f (mdbRevocable v)"
  by (cases v) simp

lemma mdbRevocable_mdbFirstBadged_update [simp]:
  "mdbRevocable (mdbFirstBadged_update f v) = mdbRevocable v"
  by (cases v) simp

lemma mdbFirstBadged_mdbNext_update [simp]:
  "mdbFirstBadged (mdbNext_update f v) = mdbFirstBadged v"
  by (cases v) simp

lemma mdbFirstBadged_mdbPrev_update [simp]:
  "mdbFirstBadged (mdbPrev_update f v) = mdbFirstBadged v"
  by (cases v) simp

lemma mdbFirstBadged_mdbRevocable_update [simp]:
  "mdbFirstBadged (mdbRevocable_update f v) = mdbFirstBadged v"
  by (cases v) simp

lemma mdbFirstBadged_mdbFirstBadged_update [simp]:
  "mdbFirstBadged (mdbFirstBadged_update f v) = f (mdbFirstBadged v)"
  by (cases v) simp

datatype cte =
    CTE (cteCap : capability) (cteMDBNode : mdbnode)

primrec
  cteCap_update :: "(capability \<Rightarrow> capability) \<Rightarrow> cte \<Rightarrow> cte"
where
  "cteCap_update f (CTE v0 v1) = CTE (f v0) v1"

primrec
  cteMDBNode_update :: "(mdbnode \<Rightarrow> mdbnode) \<Rightarrow> cte \<Rightarrow> cte"
where
  "cteMDBNode_update f (CTE v0 v1) = CTE v0 (f v1)"

abbreviation (input)
  CTE_trans :: "(capability) \<Rightarrow> (mdbnode) \<Rightarrow> cte" ("CTE'_ \<lparr> cteCap= _, cteMDBNode= _ \<rparr>")
where
  "CTE_ \<lparr> cteCap= v0, cteMDBNode= v1 \<rparr> == CTE v0 v1"

lemma cteCap_cteCap_update [simp]:
  "cteCap (cteCap_update f v) = f (cteCap v)"
  by (cases v) simp

lemma cteCap_cteMDBNode_update [simp]:
  "cteCap (cteMDBNode_update f v) = cteCap v"
  by (cases v) simp

lemma cteMDBNode_cteCap_update [simp]:
  "cteMDBNode (cteCap_update f v) = cteMDBNode v"
  by (cases v) simp

lemma cteMDBNode_cteMDBNode_update [simp]:
  "cteMDBNode (cteMDBNode_update f v) = f (cteMDBNode v)"
  by (cases v) simp

datatype thread_state =
    BlockedOnReceive (blockingObject : machine_word) (blockingIPCCanGrant : bool)
  | BlockedOnReply
  | BlockedOnNotification (waitingOnNotification : machine_word)
  | Running
  | Inactive
  | IdleThreadState
  | BlockedOnSend (blockingObject : machine_word) (blockingIPCBadge : machine_word) (blockingIPCCanGrant : bool) (blockingIPCCanGrantReply : bool) (blockingIPCIsCall : bool)
  | Restart

primrec
  blockingObject_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> thread_state \<Rightarrow> thread_state"
where
  "blockingObject_update f (BlockedOnReceive v0 v1) = BlockedOnReceive (f v0) v1"
| "blockingObject_update f (BlockedOnSend v0 v1 v2 v3 v4) = BlockedOnSend (f v0) v1 v2 v3 v4"

primrec
  blockingIPCCanGrant_update :: "(bool \<Rightarrow> bool) \<Rightarrow> thread_state \<Rightarrow> thread_state"
where
  "blockingIPCCanGrant_update f (BlockedOnReceive v0 v1) = BlockedOnReceive v0 (f v1)"
| "blockingIPCCanGrant_update f (BlockedOnSend v0 v1 v2 v3 v4) = BlockedOnSend v0 v1 (f v2) v3 v4"

primrec
  waitingOnNotification_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> thread_state \<Rightarrow> thread_state"
where
  "waitingOnNotification_update f (BlockedOnNotification v0) = BlockedOnNotification (f v0)"

primrec
  blockingIPCBadge_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> thread_state \<Rightarrow> thread_state"
where
  "blockingIPCBadge_update f (BlockedOnSend v0 v1 v2 v3 v4) = BlockedOnSend v0 (f v1) v2 v3 v4"

primrec
  blockingIPCCanGrantReply_update :: "(bool \<Rightarrow> bool) \<Rightarrow> thread_state \<Rightarrow> thread_state"
where
  "blockingIPCCanGrantReply_update f (BlockedOnSend v0 v1 v2 v3 v4) = BlockedOnSend v0 v1 v2 (f v3) v4"

primrec
  blockingIPCIsCall_update :: "(bool \<Rightarrow> bool) \<Rightarrow> thread_state \<Rightarrow> thread_state"
where
  "blockingIPCIsCall_update f (BlockedOnSend v0 v1 v2 v3 v4) = BlockedOnSend v0 v1 v2 v3 (f v4)"

abbreviation (input)
  BlockedOnReceive_trans :: "(machine_word) \<Rightarrow> (bool) \<Rightarrow> thread_state" ("BlockedOnReceive'_ \<lparr> blockingObject= _, blockingIPCCanGrant= _ \<rparr>")
where
  "BlockedOnReceive_ \<lparr> blockingObject= v0, blockingIPCCanGrant= v1 \<rparr> == BlockedOnReceive v0 v1"

abbreviation (input)
  BlockedOnNotification_trans :: "(machine_word) \<Rightarrow> thread_state" ("BlockedOnNotification'_ \<lparr> waitingOnNotification= _ \<rparr>")
where
  "BlockedOnNotification_ \<lparr> waitingOnNotification= v0 \<rparr> == BlockedOnNotification v0"

abbreviation (input)
  BlockedOnSend_trans :: "(machine_word) \<Rightarrow> (machine_word) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> (bool) \<Rightarrow> thread_state" ("BlockedOnSend'_ \<lparr> blockingObject= _, blockingIPCBadge= _, blockingIPCCanGrant= _, blockingIPCCanGrantReply= _, blockingIPCIsCall= _ \<rparr>")
where
  "BlockedOnSend_ \<lparr> blockingObject= v0, blockingIPCBadge= v1, blockingIPCCanGrant= v2, blockingIPCCanGrantReply= v3, blockingIPCIsCall= v4 \<rparr> == BlockedOnSend v0 v1 v2 v3 v4"

definition
  isBlockedOnReceive :: "thread_state \<Rightarrow> bool"
where
 "isBlockedOnReceive v \<equiv> case v of
    BlockedOnReceive v0 v1 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isBlockedOnReply :: "thread_state \<Rightarrow> bool"
where
 "isBlockedOnReply v \<equiv> case v of
    BlockedOnReply \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isBlockedOnNotification :: "thread_state \<Rightarrow> bool"
where
 "isBlockedOnNotification v \<equiv> case v of
    BlockedOnNotification v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isRunning :: "thread_state \<Rightarrow> bool"
where
 "isRunning v \<equiv> case v of
    Running \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isInactive :: "thread_state \<Rightarrow> bool"
where
 "isInactive v \<equiv> case v of
    Inactive \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isIdleThreadState :: "thread_state \<Rightarrow> bool"
where
 "isIdleThreadState v \<equiv> case v of
    IdleThreadState \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isBlockedOnSend :: "thread_state \<Rightarrow> bool"
where
 "isBlockedOnSend v \<equiv> case v of
    BlockedOnSend v0 v1 v2 v3 v4 \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isRestart :: "thread_state \<Rightarrow> bool"
where
 "isRestart v \<equiv> case v of
    Restart \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype tcb =
    Thread (tcbCTable : cte) (tcbVTable : cte) (tcbReply : cte) (tcbCaller : cte) (tcbIPCBufferFrame : cte) (tcbDomain : domain) (tcbState : thread_state) (tcbMCP : priority) (tcbPriority : priority) (tcbQueued : bool) (tcbFault : "fault option") (tcbTimeSlice : nat) (tcbFaultHandler : cptr) (tcbIPCBuffer : vptr) (tcbBoundNotification : "(machine_word) option") (tcbSchedPrev : "(machine_word) option") (tcbSchedNext : "(machine_word) option") (tcbArch : arch_tcb)

primrec
  tcbCTable_update :: "(cte \<Rightarrow> cte) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbCTable_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread (f v0) v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbVTable_update :: "(cte \<Rightarrow> cte) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbVTable_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 (f v1) v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbReply_update :: "(cte \<Rightarrow> cte) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbReply_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 (f v2) v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbCaller_update :: "(cte \<Rightarrow> cte) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbCaller_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 (f v3) v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbIPCBufferFrame_update :: "(cte \<Rightarrow> cte) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbIPCBufferFrame_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 (f v4) v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbDomain_update :: "(domain \<Rightarrow> domain) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbDomain_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 (f v5) v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbState_update :: "(thread_state \<Rightarrow> thread_state) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbState_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 (f v6) v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbMCP_update :: "(priority \<Rightarrow> priority) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbMCP_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 (f v7) v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbPriority_update :: "(priority \<Rightarrow> priority) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbPriority_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 (f v8) v9 v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbQueued_update :: "(bool \<Rightarrow> bool) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbQueued_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 (f v9) v10 v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbFault_update :: "((fault option) \<Rightarrow> (fault option)) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbFault_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 (f v10) v11 v12 v13 v14 v15 v16 v17"

primrec
  tcbTimeSlice_update :: "(nat \<Rightarrow> nat) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbTimeSlice_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 (f v11) v12 v13 v14 v15 v16 v17"

primrec
  tcbFaultHandler_update :: "(cptr \<Rightarrow> cptr) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbFaultHandler_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 (f v12) v13 v14 v15 v16 v17"

primrec
  tcbIPCBuffer_update :: "(vptr \<Rightarrow> vptr) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbIPCBuffer_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 (f v13) v14 v15 v16 v17"

primrec
  tcbBoundNotification_update :: "(((machine_word) option) \<Rightarrow> ((machine_word) option)) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbBoundNotification_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 (f v14) v15 v16 v17"

primrec
  tcbSchedPrev_update :: "(((machine_word) option) \<Rightarrow> ((machine_word) option)) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbSchedPrev_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 (f v15) v16 v17"

primrec
  tcbSchedNext_update :: "(((machine_word) option) \<Rightarrow> ((machine_word) option)) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbSchedNext_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 (f v16) v17"

primrec
  tcbArch_update :: "(arch_tcb \<Rightarrow> arch_tcb) \<Rightarrow> tcb \<Rightarrow> tcb"
where
  "tcbArch_update f (Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17) = Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 (f v17)"

abbreviation (input)
  Thread_trans :: "(cte) \<Rightarrow> (cte) \<Rightarrow> (cte) \<Rightarrow> (cte) \<Rightarrow> (cte) \<Rightarrow> (domain) \<Rightarrow> (thread_state) \<Rightarrow> (priority) \<Rightarrow> (priority) \<Rightarrow> (bool) \<Rightarrow> (fault option) \<Rightarrow> (nat) \<Rightarrow> (cptr) \<Rightarrow> (vptr) \<Rightarrow> ((machine_word) option) \<Rightarrow> ((machine_word) option) \<Rightarrow> ((machine_word) option) \<Rightarrow> (arch_tcb) \<Rightarrow> tcb" ("Thread'_ \<lparr> tcbCTable= _, tcbVTable= _, tcbReply= _, tcbCaller= _, tcbIPCBufferFrame= _, tcbDomain= _, tcbState= _, tcbMCP= _, tcbPriority= _, tcbQueued= _, tcbFault= _, tcbTimeSlice= _, tcbFaultHandler= _, tcbIPCBuffer= _, tcbBoundNotification= _, tcbSchedPrev= _, tcbSchedNext= _, tcbArch= _ \<rparr>")
where
  "Thread_ \<lparr> tcbCTable= v0, tcbVTable= v1, tcbReply= v2, tcbCaller= v3, tcbIPCBufferFrame= v4, tcbDomain= v5, tcbState= v6, tcbMCP= v7, tcbPriority= v8, tcbQueued= v9, tcbFault= v10, tcbTimeSlice= v11, tcbFaultHandler= v12, tcbIPCBuffer= v13, tcbBoundNotification= v14, tcbSchedPrev= v15, tcbSchedNext= v16, tcbArch= v17 \<rparr> == Thread v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"

lemma tcbCTable_tcbCTable_update [simp]:
  "tcbCTable (tcbCTable_update f v) = f (tcbCTable v)"
  by (cases v) simp

lemma tcbCTable_tcbVTable_update [simp]:
  "tcbCTable (tcbVTable_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbReply_update [simp]:
  "tcbCTable (tcbReply_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbCaller_update [simp]:
  "tcbCTable (tcbCaller_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbIPCBufferFrame_update [simp]:
  "tcbCTable (tcbIPCBufferFrame_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbDomain_update [simp]:
  "tcbCTable (tcbDomain_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbState_update [simp]:
  "tcbCTable (tcbState_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbMCP_update [simp]:
  "tcbCTable (tcbMCP_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbPriority_update [simp]:
  "tcbCTable (tcbPriority_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbQueued_update [simp]:
  "tcbCTable (tcbQueued_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbFault_update [simp]:
  "tcbCTable (tcbFault_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbTimeSlice_update [simp]:
  "tcbCTable (tcbTimeSlice_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbFaultHandler_update [simp]:
  "tcbCTable (tcbFaultHandler_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbIPCBuffer_update [simp]:
  "tcbCTable (tcbIPCBuffer_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbBoundNotification_update [simp]:
  "tcbCTable (tcbBoundNotification_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbSchedPrev_update [simp]:
  "tcbCTable (tcbSchedPrev_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbSchedNext_update [simp]:
  "tcbCTable (tcbSchedNext_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbCTable_tcbArch_update [simp]:
  "tcbCTable (tcbArch_update f v) = tcbCTable v"
  by (cases v) simp

lemma tcbVTable_tcbCTable_update [simp]:
  "tcbVTable (tcbCTable_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbVTable_update [simp]:
  "tcbVTable (tcbVTable_update f v) = f (tcbVTable v)"
  by (cases v) simp

lemma tcbVTable_tcbReply_update [simp]:
  "tcbVTable (tcbReply_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbCaller_update [simp]:
  "tcbVTable (tcbCaller_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbIPCBufferFrame_update [simp]:
  "tcbVTable (tcbIPCBufferFrame_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbDomain_update [simp]:
  "tcbVTable (tcbDomain_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbState_update [simp]:
  "tcbVTable (tcbState_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbMCP_update [simp]:
  "tcbVTable (tcbMCP_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbPriority_update [simp]:
  "tcbVTable (tcbPriority_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbQueued_update [simp]:
  "tcbVTable (tcbQueued_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbFault_update [simp]:
  "tcbVTable (tcbFault_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbTimeSlice_update [simp]:
  "tcbVTable (tcbTimeSlice_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbFaultHandler_update [simp]:
  "tcbVTable (tcbFaultHandler_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbIPCBuffer_update [simp]:
  "tcbVTable (tcbIPCBuffer_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbBoundNotification_update [simp]:
  "tcbVTable (tcbBoundNotification_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbSchedPrev_update [simp]:
  "tcbVTable (tcbSchedPrev_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbSchedNext_update [simp]:
  "tcbVTable (tcbSchedNext_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbVTable_tcbArch_update [simp]:
  "tcbVTable (tcbArch_update f v) = tcbVTable v"
  by (cases v) simp

lemma tcbReply_tcbCTable_update [simp]:
  "tcbReply (tcbCTable_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbVTable_update [simp]:
  "tcbReply (tcbVTable_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbReply_update [simp]:
  "tcbReply (tcbReply_update f v) = f (tcbReply v)"
  by (cases v) simp

lemma tcbReply_tcbCaller_update [simp]:
  "tcbReply (tcbCaller_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbIPCBufferFrame_update [simp]:
  "tcbReply (tcbIPCBufferFrame_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbDomain_update [simp]:
  "tcbReply (tcbDomain_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbState_update [simp]:
  "tcbReply (tcbState_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbMCP_update [simp]:
  "tcbReply (tcbMCP_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbPriority_update [simp]:
  "tcbReply (tcbPriority_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbQueued_update [simp]:
  "tcbReply (tcbQueued_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbFault_update [simp]:
  "tcbReply (tcbFault_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbTimeSlice_update [simp]:
  "tcbReply (tcbTimeSlice_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbFaultHandler_update [simp]:
  "tcbReply (tcbFaultHandler_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbIPCBuffer_update [simp]:
  "tcbReply (tcbIPCBuffer_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbBoundNotification_update [simp]:
  "tcbReply (tcbBoundNotification_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbSchedPrev_update [simp]:
  "tcbReply (tcbSchedPrev_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbSchedNext_update [simp]:
  "tcbReply (tcbSchedNext_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbReply_tcbArch_update [simp]:
  "tcbReply (tcbArch_update f v) = tcbReply v"
  by (cases v) simp

lemma tcbCaller_tcbCTable_update [simp]:
  "tcbCaller (tcbCTable_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbVTable_update [simp]:
  "tcbCaller (tcbVTable_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbReply_update [simp]:
  "tcbCaller (tcbReply_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbCaller_update [simp]:
  "tcbCaller (tcbCaller_update f v) = f (tcbCaller v)"
  by (cases v) simp

lemma tcbCaller_tcbIPCBufferFrame_update [simp]:
  "tcbCaller (tcbIPCBufferFrame_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbDomain_update [simp]:
  "tcbCaller (tcbDomain_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbState_update [simp]:
  "tcbCaller (tcbState_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbMCP_update [simp]:
  "tcbCaller (tcbMCP_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbPriority_update [simp]:
  "tcbCaller (tcbPriority_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbQueued_update [simp]:
  "tcbCaller (tcbQueued_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbFault_update [simp]:
  "tcbCaller (tcbFault_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbTimeSlice_update [simp]:
  "tcbCaller (tcbTimeSlice_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbFaultHandler_update [simp]:
  "tcbCaller (tcbFaultHandler_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbIPCBuffer_update [simp]:
  "tcbCaller (tcbIPCBuffer_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbBoundNotification_update [simp]:
  "tcbCaller (tcbBoundNotification_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbSchedPrev_update [simp]:
  "tcbCaller (tcbSchedPrev_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbSchedNext_update [simp]:
  "tcbCaller (tcbSchedNext_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbCaller_tcbArch_update [simp]:
  "tcbCaller (tcbArch_update f v) = tcbCaller v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbCTable_update [simp]:
  "tcbIPCBufferFrame (tcbCTable_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbVTable_update [simp]:
  "tcbIPCBufferFrame (tcbVTable_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbReply_update [simp]:
  "tcbIPCBufferFrame (tcbReply_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbCaller_update [simp]:
  "tcbIPCBufferFrame (tcbCaller_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbIPCBufferFrame_update [simp]:
  "tcbIPCBufferFrame (tcbIPCBufferFrame_update f v) = f (tcbIPCBufferFrame v)"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbDomain_update [simp]:
  "tcbIPCBufferFrame (tcbDomain_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbState_update [simp]:
  "tcbIPCBufferFrame (tcbState_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbMCP_update [simp]:
  "tcbIPCBufferFrame (tcbMCP_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbPriority_update [simp]:
  "tcbIPCBufferFrame (tcbPriority_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbQueued_update [simp]:
  "tcbIPCBufferFrame (tcbQueued_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbFault_update [simp]:
  "tcbIPCBufferFrame (tcbFault_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbTimeSlice_update [simp]:
  "tcbIPCBufferFrame (tcbTimeSlice_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbFaultHandler_update [simp]:
  "tcbIPCBufferFrame (tcbFaultHandler_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbIPCBuffer_update [simp]:
  "tcbIPCBufferFrame (tcbIPCBuffer_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbBoundNotification_update [simp]:
  "tcbIPCBufferFrame (tcbBoundNotification_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbSchedPrev_update [simp]:
  "tcbIPCBufferFrame (tcbSchedPrev_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbSchedNext_update [simp]:
  "tcbIPCBufferFrame (tcbSchedNext_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbIPCBufferFrame_tcbArch_update [simp]:
  "tcbIPCBufferFrame (tcbArch_update f v) = tcbIPCBufferFrame v"
  by (cases v) simp

lemma tcbDomain_tcbCTable_update [simp]:
  "tcbDomain (tcbCTable_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbVTable_update [simp]:
  "tcbDomain (tcbVTable_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbReply_update [simp]:
  "tcbDomain (tcbReply_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbCaller_update [simp]:
  "tcbDomain (tcbCaller_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbIPCBufferFrame_update [simp]:
  "tcbDomain (tcbIPCBufferFrame_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbDomain_update [simp]:
  "tcbDomain (tcbDomain_update f v) = f (tcbDomain v)"
  by (cases v) simp

lemma tcbDomain_tcbState_update [simp]:
  "tcbDomain (tcbState_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbMCP_update [simp]:
  "tcbDomain (tcbMCP_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbPriority_update [simp]:
  "tcbDomain (tcbPriority_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbQueued_update [simp]:
  "tcbDomain (tcbQueued_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbFault_update [simp]:
  "tcbDomain (tcbFault_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbTimeSlice_update [simp]:
  "tcbDomain (tcbTimeSlice_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbFaultHandler_update [simp]:
  "tcbDomain (tcbFaultHandler_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbIPCBuffer_update [simp]:
  "tcbDomain (tcbIPCBuffer_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbBoundNotification_update [simp]:
  "tcbDomain (tcbBoundNotification_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbSchedPrev_update [simp]:
  "tcbDomain (tcbSchedPrev_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbSchedNext_update [simp]:
  "tcbDomain (tcbSchedNext_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbDomain_tcbArch_update [simp]:
  "tcbDomain (tcbArch_update f v) = tcbDomain v"
  by (cases v) simp

lemma tcbState_tcbCTable_update [simp]:
  "tcbState (tcbCTable_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbVTable_update [simp]:
  "tcbState (tcbVTable_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbReply_update [simp]:
  "tcbState (tcbReply_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbCaller_update [simp]:
  "tcbState (tcbCaller_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbIPCBufferFrame_update [simp]:
  "tcbState (tcbIPCBufferFrame_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbDomain_update [simp]:
  "tcbState (tcbDomain_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbState_update [simp]:
  "tcbState (tcbState_update f v) = f (tcbState v)"
  by (cases v) simp

lemma tcbState_tcbMCP_update [simp]:
  "tcbState (tcbMCP_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbPriority_update [simp]:
  "tcbState (tcbPriority_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbQueued_update [simp]:
  "tcbState (tcbQueued_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbFault_update [simp]:
  "tcbState (tcbFault_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbTimeSlice_update [simp]:
  "tcbState (tcbTimeSlice_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbFaultHandler_update [simp]:
  "tcbState (tcbFaultHandler_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbIPCBuffer_update [simp]:
  "tcbState (tcbIPCBuffer_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbBoundNotification_update [simp]:
  "tcbState (tcbBoundNotification_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbSchedPrev_update [simp]:
  "tcbState (tcbSchedPrev_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbSchedNext_update [simp]:
  "tcbState (tcbSchedNext_update f v) = tcbState v"
  by (cases v) simp

lemma tcbState_tcbArch_update [simp]:
  "tcbState (tcbArch_update f v) = tcbState v"
  by (cases v) simp

lemma tcbMCP_tcbCTable_update [simp]:
  "tcbMCP (tcbCTable_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbVTable_update [simp]:
  "tcbMCP (tcbVTable_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbReply_update [simp]:
  "tcbMCP (tcbReply_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbCaller_update [simp]:
  "tcbMCP (tcbCaller_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbIPCBufferFrame_update [simp]:
  "tcbMCP (tcbIPCBufferFrame_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbDomain_update [simp]:
  "tcbMCP (tcbDomain_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbState_update [simp]:
  "tcbMCP (tcbState_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbMCP_update [simp]:
  "tcbMCP (tcbMCP_update f v) = f (tcbMCP v)"
  by (cases v) simp

lemma tcbMCP_tcbPriority_update [simp]:
  "tcbMCP (tcbPriority_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbQueued_update [simp]:
  "tcbMCP (tcbQueued_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbFault_update [simp]:
  "tcbMCP (tcbFault_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbTimeSlice_update [simp]:
  "tcbMCP (tcbTimeSlice_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbFaultHandler_update [simp]:
  "tcbMCP (tcbFaultHandler_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbIPCBuffer_update [simp]:
  "tcbMCP (tcbIPCBuffer_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbBoundNotification_update [simp]:
  "tcbMCP (tcbBoundNotification_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbSchedPrev_update [simp]:
  "tcbMCP (tcbSchedPrev_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbSchedNext_update [simp]:
  "tcbMCP (tcbSchedNext_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbMCP_tcbArch_update [simp]:
  "tcbMCP (tcbArch_update f v) = tcbMCP v"
  by (cases v) simp

lemma tcbPriority_tcbCTable_update [simp]:
  "tcbPriority (tcbCTable_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbVTable_update [simp]:
  "tcbPriority (tcbVTable_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbReply_update [simp]:
  "tcbPriority (tcbReply_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbCaller_update [simp]:
  "tcbPriority (tcbCaller_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbIPCBufferFrame_update [simp]:
  "tcbPriority (tcbIPCBufferFrame_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbDomain_update [simp]:
  "tcbPriority (tcbDomain_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbState_update [simp]:
  "tcbPriority (tcbState_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbMCP_update [simp]:
  "tcbPriority (tcbMCP_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbPriority_update [simp]:
  "tcbPriority (tcbPriority_update f v) = f (tcbPriority v)"
  by (cases v) simp

lemma tcbPriority_tcbQueued_update [simp]:
  "tcbPriority (tcbQueued_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbFault_update [simp]:
  "tcbPriority (tcbFault_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbTimeSlice_update [simp]:
  "tcbPriority (tcbTimeSlice_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbFaultHandler_update [simp]:
  "tcbPriority (tcbFaultHandler_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbIPCBuffer_update [simp]:
  "tcbPriority (tcbIPCBuffer_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbBoundNotification_update [simp]:
  "tcbPriority (tcbBoundNotification_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbSchedPrev_update [simp]:
  "tcbPriority (tcbSchedPrev_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbSchedNext_update [simp]:
  "tcbPriority (tcbSchedNext_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbPriority_tcbArch_update [simp]:
  "tcbPriority (tcbArch_update f v) = tcbPriority v"
  by (cases v) simp

lemma tcbQueued_tcbCTable_update [simp]:
  "tcbQueued (tcbCTable_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbVTable_update [simp]:
  "tcbQueued (tcbVTable_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbReply_update [simp]:
  "tcbQueued (tcbReply_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbCaller_update [simp]:
  "tcbQueued (tcbCaller_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbIPCBufferFrame_update [simp]:
  "tcbQueued (tcbIPCBufferFrame_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbDomain_update [simp]:
  "tcbQueued (tcbDomain_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbState_update [simp]:
  "tcbQueued (tcbState_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbMCP_update [simp]:
  "tcbQueued (tcbMCP_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbPriority_update [simp]:
  "tcbQueued (tcbPriority_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbQueued_update [simp]:
  "tcbQueued (tcbQueued_update f v) = f (tcbQueued v)"
  by (cases v) simp

lemma tcbQueued_tcbFault_update [simp]:
  "tcbQueued (tcbFault_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbTimeSlice_update [simp]:
  "tcbQueued (tcbTimeSlice_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbFaultHandler_update [simp]:
  "tcbQueued (tcbFaultHandler_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbIPCBuffer_update [simp]:
  "tcbQueued (tcbIPCBuffer_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbBoundNotification_update [simp]:
  "tcbQueued (tcbBoundNotification_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbSchedPrev_update [simp]:
  "tcbQueued (tcbSchedPrev_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbSchedNext_update [simp]:
  "tcbQueued (tcbSchedNext_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbQueued_tcbArch_update [simp]:
  "tcbQueued (tcbArch_update f v) = tcbQueued v"
  by (cases v) simp

lemma tcbFault_tcbCTable_update [simp]:
  "tcbFault (tcbCTable_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbVTable_update [simp]:
  "tcbFault (tcbVTable_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbReply_update [simp]:
  "tcbFault (tcbReply_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbCaller_update [simp]:
  "tcbFault (tcbCaller_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbIPCBufferFrame_update [simp]:
  "tcbFault (tcbIPCBufferFrame_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbDomain_update [simp]:
  "tcbFault (tcbDomain_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbState_update [simp]:
  "tcbFault (tcbState_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbMCP_update [simp]:
  "tcbFault (tcbMCP_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbPriority_update [simp]:
  "tcbFault (tcbPriority_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbQueued_update [simp]:
  "tcbFault (tcbQueued_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbFault_update [simp]:
  "tcbFault (tcbFault_update f v) = f (tcbFault v)"
  by (cases v) simp

lemma tcbFault_tcbTimeSlice_update [simp]:
  "tcbFault (tcbTimeSlice_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbFaultHandler_update [simp]:
  "tcbFault (tcbFaultHandler_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbIPCBuffer_update [simp]:
  "tcbFault (tcbIPCBuffer_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbBoundNotification_update [simp]:
  "tcbFault (tcbBoundNotification_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbSchedPrev_update [simp]:
  "tcbFault (tcbSchedPrev_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbSchedNext_update [simp]:
  "tcbFault (tcbSchedNext_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbFault_tcbArch_update [simp]:
  "tcbFault (tcbArch_update f v) = tcbFault v"
  by (cases v) simp

lemma tcbTimeSlice_tcbCTable_update [simp]:
  "tcbTimeSlice (tcbCTable_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbVTable_update [simp]:
  "tcbTimeSlice (tcbVTable_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbReply_update [simp]:
  "tcbTimeSlice (tcbReply_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbCaller_update [simp]:
  "tcbTimeSlice (tcbCaller_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbIPCBufferFrame_update [simp]:
  "tcbTimeSlice (tcbIPCBufferFrame_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbDomain_update [simp]:
  "tcbTimeSlice (tcbDomain_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbState_update [simp]:
  "tcbTimeSlice (tcbState_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbMCP_update [simp]:
  "tcbTimeSlice (tcbMCP_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbPriority_update [simp]:
  "tcbTimeSlice (tcbPriority_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbQueued_update [simp]:
  "tcbTimeSlice (tcbQueued_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbFault_update [simp]:
  "tcbTimeSlice (tcbFault_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbTimeSlice_update [simp]:
  "tcbTimeSlice (tcbTimeSlice_update f v) = f (tcbTimeSlice v)"
  by (cases v) simp

lemma tcbTimeSlice_tcbFaultHandler_update [simp]:
  "tcbTimeSlice (tcbFaultHandler_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbIPCBuffer_update [simp]:
  "tcbTimeSlice (tcbIPCBuffer_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbBoundNotification_update [simp]:
  "tcbTimeSlice (tcbBoundNotification_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbSchedPrev_update [simp]:
  "tcbTimeSlice (tcbSchedPrev_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbSchedNext_update [simp]:
  "tcbTimeSlice (tcbSchedNext_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbTimeSlice_tcbArch_update [simp]:
  "tcbTimeSlice (tcbArch_update f v) = tcbTimeSlice v"
  by (cases v) simp

lemma tcbFaultHandler_tcbCTable_update [simp]:
  "tcbFaultHandler (tcbCTable_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbVTable_update [simp]:
  "tcbFaultHandler (tcbVTable_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbReply_update [simp]:
  "tcbFaultHandler (tcbReply_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbCaller_update [simp]:
  "tcbFaultHandler (tcbCaller_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbIPCBufferFrame_update [simp]:
  "tcbFaultHandler (tcbIPCBufferFrame_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbDomain_update [simp]:
  "tcbFaultHandler (tcbDomain_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbState_update [simp]:
  "tcbFaultHandler (tcbState_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbMCP_update [simp]:
  "tcbFaultHandler (tcbMCP_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbPriority_update [simp]:
  "tcbFaultHandler (tcbPriority_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbQueued_update [simp]:
  "tcbFaultHandler (tcbQueued_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbFault_update [simp]:
  "tcbFaultHandler (tcbFault_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbTimeSlice_update [simp]:
  "tcbFaultHandler (tcbTimeSlice_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbFaultHandler_update [simp]:
  "tcbFaultHandler (tcbFaultHandler_update f v) = f (tcbFaultHandler v)"
  by (cases v) simp

lemma tcbFaultHandler_tcbIPCBuffer_update [simp]:
  "tcbFaultHandler (tcbIPCBuffer_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbBoundNotification_update [simp]:
  "tcbFaultHandler (tcbBoundNotification_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbSchedPrev_update [simp]:
  "tcbFaultHandler (tcbSchedPrev_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbSchedNext_update [simp]:
  "tcbFaultHandler (tcbSchedNext_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbFaultHandler_tcbArch_update [simp]:
  "tcbFaultHandler (tcbArch_update f v) = tcbFaultHandler v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbCTable_update [simp]:
  "tcbIPCBuffer (tcbCTable_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbVTable_update [simp]:
  "tcbIPCBuffer (tcbVTable_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbReply_update [simp]:
  "tcbIPCBuffer (tcbReply_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbCaller_update [simp]:
  "tcbIPCBuffer (tcbCaller_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbIPCBufferFrame_update [simp]:
  "tcbIPCBuffer (tcbIPCBufferFrame_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbDomain_update [simp]:
  "tcbIPCBuffer (tcbDomain_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbState_update [simp]:
  "tcbIPCBuffer (tcbState_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbMCP_update [simp]:
  "tcbIPCBuffer (tcbMCP_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbPriority_update [simp]:
  "tcbIPCBuffer (tcbPriority_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbQueued_update [simp]:
  "tcbIPCBuffer (tcbQueued_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbFault_update [simp]:
  "tcbIPCBuffer (tcbFault_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbTimeSlice_update [simp]:
  "tcbIPCBuffer (tcbTimeSlice_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbFaultHandler_update [simp]:
  "tcbIPCBuffer (tcbFaultHandler_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbIPCBuffer_update [simp]:
  "tcbIPCBuffer (tcbIPCBuffer_update f v) = f (tcbIPCBuffer v)"
  by (cases v) simp

lemma tcbIPCBuffer_tcbBoundNotification_update [simp]:
  "tcbIPCBuffer (tcbBoundNotification_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbSchedPrev_update [simp]:
  "tcbIPCBuffer (tcbSchedPrev_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbSchedNext_update [simp]:
  "tcbIPCBuffer (tcbSchedNext_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbIPCBuffer_tcbArch_update [simp]:
  "tcbIPCBuffer (tcbArch_update f v) = tcbIPCBuffer v"
  by (cases v) simp

lemma tcbBoundNotification_tcbCTable_update [simp]:
  "tcbBoundNotification (tcbCTable_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbVTable_update [simp]:
  "tcbBoundNotification (tcbVTable_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbReply_update [simp]:
  "tcbBoundNotification (tcbReply_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbCaller_update [simp]:
  "tcbBoundNotification (tcbCaller_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbIPCBufferFrame_update [simp]:
  "tcbBoundNotification (tcbIPCBufferFrame_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbDomain_update [simp]:
  "tcbBoundNotification (tcbDomain_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbState_update [simp]:
  "tcbBoundNotification (tcbState_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbMCP_update [simp]:
  "tcbBoundNotification (tcbMCP_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbPriority_update [simp]:
  "tcbBoundNotification (tcbPriority_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbQueued_update [simp]:
  "tcbBoundNotification (tcbQueued_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbFault_update [simp]:
  "tcbBoundNotification (tcbFault_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbTimeSlice_update [simp]:
  "tcbBoundNotification (tcbTimeSlice_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbFaultHandler_update [simp]:
  "tcbBoundNotification (tcbFaultHandler_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbIPCBuffer_update [simp]:
  "tcbBoundNotification (tcbIPCBuffer_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbBoundNotification_update [simp]:
  "tcbBoundNotification (tcbBoundNotification_update f v) = f (tcbBoundNotification v)"
  by (cases v) simp

lemma tcbBoundNotification_tcbSchedPrev_update [simp]:
  "tcbBoundNotification (tcbSchedPrev_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbSchedNext_update [simp]:
  "tcbBoundNotification (tcbSchedNext_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbBoundNotification_tcbArch_update [simp]:
  "tcbBoundNotification (tcbArch_update f v) = tcbBoundNotification v"
  by (cases v) simp

lemma tcbSchedPrev_tcbCTable_update [simp]:
  "tcbSchedPrev (tcbCTable_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbVTable_update [simp]:
  "tcbSchedPrev (tcbVTable_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbReply_update [simp]:
  "tcbSchedPrev (tcbReply_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbCaller_update [simp]:
  "tcbSchedPrev (tcbCaller_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbIPCBufferFrame_update [simp]:
  "tcbSchedPrev (tcbIPCBufferFrame_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbDomain_update [simp]:
  "tcbSchedPrev (tcbDomain_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbState_update [simp]:
  "tcbSchedPrev (tcbState_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbMCP_update [simp]:
  "tcbSchedPrev (tcbMCP_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbPriority_update [simp]:
  "tcbSchedPrev (tcbPriority_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbQueued_update [simp]:
  "tcbSchedPrev (tcbQueued_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbFault_update [simp]:
  "tcbSchedPrev (tcbFault_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbTimeSlice_update [simp]:
  "tcbSchedPrev (tcbTimeSlice_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbFaultHandler_update [simp]:
  "tcbSchedPrev (tcbFaultHandler_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbIPCBuffer_update [simp]:
  "tcbSchedPrev (tcbIPCBuffer_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbBoundNotification_update [simp]:
  "tcbSchedPrev (tcbBoundNotification_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbSchedPrev_update [simp]:
  "tcbSchedPrev (tcbSchedPrev_update f v) = f (tcbSchedPrev v)"
  by (cases v) simp

lemma tcbSchedPrev_tcbSchedNext_update [simp]:
  "tcbSchedPrev (tcbSchedNext_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedPrev_tcbArch_update [simp]:
  "tcbSchedPrev (tcbArch_update f v) = tcbSchedPrev v"
  by (cases v) simp

lemma tcbSchedNext_tcbCTable_update [simp]:
  "tcbSchedNext (tcbCTable_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbVTable_update [simp]:
  "tcbSchedNext (tcbVTable_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbReply_update [simp]:
  "tcbSchedNext (tcbReply_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbCaller_update [simp]:
  "tcbSchedNext (tcbCaller_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbIPCBufferFrame_update [simp]:
  "tcbSchedNext (tcbIPCBufferFrame_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbDomain_update [simp]:
  "tcbSchedNext (tcbDomain_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbState_update [simp]:
  "tcbSchedNext (tcbState_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbMCP_update [simp]:
  "tcbSchedNext (tcbMCP_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbPriority_update [simp]:
  "tcbSchedNext (tcbPriority_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbQueued_update [simp]:
  "tcbSchedNext (tcbQueued_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbFault_update [simp]:
  "tcbSchedNext (tcbFault_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbTimeSlice_update [simp]:
  "tcbSchedNext (tcbTimeSlice_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbFaultHandler_update [simp]:
  "tcbSchedNext (tcbFaultHandler_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbIPCBuffer_update [simp]:
  "tcbSchedNext (tcbIPCBuffer_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbBoundNotification_update [simp]:
  "tcbSchedNext (tcbBoundNotification_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbSchedPrev_update [simp]:
  "tcbSchedNext (tcbSchedPrev_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbSchedNext_tcbSchedNext_update [simp]:
  "tcbSchedNext (tcbSchedNext_update f v) = f (tcbSchedNext v)"
  by (cases v) simp

lemma tcbSchedNext_tcbArch_update [simp]:
  "tcbSchedNext (tcbArch_update f v) = tcbSchedNext v"
  by (cases v) simp

lemma tcbArch_tcbCTable_update [simp]:
  "tcbArch (tcbCTable_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbVTable_update [simp]:
  "tcbArch (tcbVTable_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbReply_update [simp]:
  "tcbArch (tcbReply_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbCaller_update [simp]:
  "tcbArch (tcbCaller_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbIPCBufferFrame_update [simp]:
  "tcbArch (tcbIPCBufferFrame_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbDomain_update [simp]:
  "tcbArch (tcbDomain_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbState_update [simp]:
  "tcbArch (tcbState_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbMCP_update [simp]:
  "tcbArch (tcbMCP_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbPriority_update [simp]:
  "tcbArch (tcbPriority_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbQueued_update [simp]:
  "tcbArch (tcbQueued_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbFault_update [simp]:
  "tcbArch (tcbFault_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbTimeSlice_update [simp]:
  "tcbArch (tcbTimeSlice_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbFaultHandler_update [simp]:
  "tcbArch (tcbFaultHandler_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbIPCBuffer_update [simp]:
  "tcbArch (tcbIPCBuffer_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbBoundNotification_update [simp]:
  "tcbArch (tcbBoundNotification_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbSchedPrev_update [simp]:
  "tcbArch (tcbSchedPrev_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbSchedNext_update [simp]:
  "tcbArch (tcbSchedNext_update f v) = tcbArch v"
  by (cases v) simp

lemma tcbArch_tcbArch_update [simp]:
  "tcbArch (tcbArch_update f v) = f (tcbArch v)"
  by (cases v) simp

datatype kernel_object =
    KOEndpoint endpoint
  | KONotification notification
  | KOKernelData
  | KOUserData
  | KOUserDataDevice
  | KOTCB tcb
  | KOCTE cte
  | KOArch arch_kernel_object

datatype scheduler_action =
    ResumeCurrentThread
  | ChooseNewThread
  | SwitchToThread (schActTarget : machine_word)

primrec
  schActTarget_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> scheduler_action \<Rightarrow> scheduler_action"
where
  "schActTarget_update f (SwitchToThread v0) = SwitchToThread (f v0)"

abbreviation (input)
  SwitchToThread_trans :: "(machine_word) \<Rightarrow> scheduler_action" ("SwitchToThread'_ \<lparr> schActTarget= _ \<rparr>")
where
  "SwitchToThread_ \<lparr> schActTarget= v0 \<rparr> == SwitchToThread v0"

definition
  isResumeCurrentThread :: "scheduler_action \<Rightarrow> bool"
where
 "isResumeCurrentThread v \<equiv> case v of
    ResumeCurrentThread \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isChooseNewThread :: "scheduler_action \<Rightarrow> bool"
where
 "isChooseNewThread v \<equiv> case v of
    ChooseNewThread \<Rightarrow> True
  | _ \<Rightarrow> False"

definition
  isSwitchToThread :: "scheduler_action \<Rightarrow> bool"
where
 "isSwitchToThread v \<equiv> case v of
    SwitchToThread v0 \<Rightarrow> True
  | _ \<Rightarrow> False"

datatype irqstate =
    IRQInactive
  | IRQSignal
  | IRQTimer
  | IRQReserved

datatype interrupt_state =
    InterruptState (intStateIRQNode : machine_word) (intStateIRQTable : "irq \<Rightarrow> irqstate")

primrec
  intStateIRQNode_update :: "(machine_word \<Rightarrow> machine_word) \<Rightarrow> interrupt_state \<Rightarrow> interrupt_state"
where
  "intStateIRQNode_update f (InterruptState v0 v1) = InterruptState (f v0) v1"

primrec
  intStateIRQTable_update :: "((irq \<Rightarrow> irqstate) \<Rightarrow> (irq \<Rightarrow> irqstate)) \<Rightarrow> interrupt_state \<Rightarrow> interrupt_state"
where
  "intStateIRQTable_update f (InterruptState v0 v1) = InterruptState v0 (f v1)"

abbreviation (input)
  InterruptState_trans :: "(machine_word) \<Rightarrow> (irq \<Rightarrow> irqstate) \<Rightarrow> interrupt_state" ("InterruptState'_ \<lparr> intStateIRQNode= _, intStateIRQTable= _ \<rparr>")
where
  "InterruptState_ \<lparr> intStateIRQNode= v0, intStateIRQTable= v1 \<rparr> == InterruptState v0 v1"

lemma intStateIRQNode_intStateIRQNode_update [simp]:
  "intStateIRQNode (intStateIRQNode_update f v) = f (intStateIRQNode v)"
  by (cases v) simp

lemma intStateIRQNode_intStateIRQTable_update [simp]:
  "intStateIRQNode (intStateIRQTable_update f v) = intStateIRQNode v"
  by (cases v) simp

lemma intStateIRQTable_intStateIRQNode_update [simp]:
  "intStateIRQTable (intStateIRQNode_update f v) = intStateIRQTable v"
  by (cases v) simp

lemma intStateIRQTable_intStateIRQTable_update [simp]:
  "intStateIRQTable (intStateIRQTable_update f v) = f (intStateIRQTable v)"
  by (cases v) simp

datatype user_data =
    UserData

datatype user_data_device =
    UserDataDevice

datatype tcb_queue =
    TcbQueue (tcbQueueHead : "(machine_word) option") (tcbQueueEnd : "(machine_word) option")

primrec
  tcbQueueHead_update :: "(((machine_word) option) \<Rightarrow> ((machine_word) option)) \<Rightarrow> tcb_queue \<Rightarrow> tcb_queue"
where
  "tcbQueueHead_update f (TcbQueue v0 v1) = TcbQueue (f v0) v1"

primrec
  tcbQueueEnd_update :: "(((machine_word) option) \<Rightarrow> ((machine_word) option)) \<Rightarrow> tcb_queue \<Rightarrow> tcb_queue"
where
  "tcbQueueEnd_update f (TcbQueue v0 v1) = TcbQueue v0 (f v1)"

abbreviation (input)
  TcbQueue_trans :: "((machine_word) option) \<Rightarrow> ((machine_word) option) \<Rightarrow> tcb_queue" ("TcbQueue'_ \<lparr> tcbQueueHead= _, tcbQueueEnd= _ \<rparr>")
where
  "TcbQueue_ \<lparr> tcbQueueHead= v0, tcbQueueEnd= v1 \<rparr> == TcbQueue v0 v1"

lemma tcbQueueHead_tcbQueueHead_update [simp]:
  "tcbQueueHead (tcbQueueHead_update f v) = f (tcbQueueHead v)"
  by (cases v) simp

lemma tcbQueueHead_tcbQueueEnd_update [simp]:
  "tcbQueueHead (tcbQueueEnd_update f v) = tcbQueueHead v"
  by (cases v) simp

lemma tcbQueueEnd_tcbQueueHead_update [simp]:
  "tcbQueueEnd (tcbQueueHead_update f v) = tcbQueueEnd v"
  by (cases v) simp

lemma tcbQueueEnd_tcbQueueEnd_update [simp]:
  "tcbQueueEnd (tcbQueueEnd_update f v) = f (tcbQueueEnd v)"
  by (cases v) simp

consts'
kernelObjectTypeName :: "kernel_object \<Rightarrow> unit list"

consts'
objBitsKO :: "kernel_object \<Rightarrow> nat"

consts'
tcbCTableSlot :: "machine_word"

consts'
tcbVTableSlot :: "machine_word"

consts'
tcbReplySlot :: "machine_word"

consts'
tcbCallerSlot :: "machine_word"

consts'
tcbIPCBufferSlot :: "machine_word"

consts'
minPriority :: "priority"

consts'
maxPriority :: "priority"

consts'
maxDomain :: "priority"

consts'
l2BitmapSize :: "nat"

consts'
nullMDBNode :: "mdbnode"

consts'
dschDomain :: "(domain * machine_word) \<Rightarrow> domain"

consts'
dschLength :: "(domain * machine_word) \<Rightarrow> machine_word"

consts'
isReceive :: "thread_state \<Rightarrow> bool"

consts'
isSend :: "thread_state \<Rightarrow> bool"

consts'
isReply :: "thread_state \<Rightarrow> bool"

consts'
maxFreeIndex :: "nat \<Rightarrow> nat"

consts'
getFreeRef :: "machine_word \<Rightarrow> nat \<Rightarrow> machine_word"

consts'
getFreeIndex :: "machine_word \<Rightarrow> machine_word \<Rightarrow> nat"

consts'
untypedZeroRange :: "capability \<Rightarrow> (machine_word * machine_word) option"

defs objBitsKO_def:
"objBitsKO x0\<equiv> (case x0 of
    (KOEndpoint _) \<Rightarrow>    epSizeBits
  | (KONotification _) \<Rightarrow>    ntfnSizeBits
  | (KOCTE _) \<Rightarrow>    cteSizeBits
  | (KOTCB _) \<Rightarrow>    tcbBlockSizeBits
  | (KOUserData) \<Rightarrow>    pageBits
  | (KOUserDataDevice) \<Rightarrow>    pageBits
  | (KOKernelData) \<Rightarrow>    pageBits
  | (KOArch a) \<Rightarrow>    archObjSize a
  )"

defs tcbCTableSlot_def:
"tcbCTableSlot \<equiv> 0"

defs tcbVTableSlot_def:
"tcbVTableSlot \<equiv> 1"

defs tcbReplySlot_def:
"tcbReplySlot \<equiv> 2"

defs tcbCallerSlot_def:
"tcbCallerSlot \<equiv> 3"

defs tcbIPCBufferSlot_def:
"tcbIPCBufferSlot \<equiv> 4"

defs minPriority_def:
"minPriority \<equiv> 0"

defs maxPriority_def:
"maxPriority\<equiv> fromIntegral (numPriorities - 1)"

defs maxDomain_def:
"maxDomain\<equiv> fromIntegral (numDomains - 1)"

defs l2BitmapSize_def:
"l2BitmapSize\<equiv> (numPriorities + wordBits - 1) div wordBits"

defs nullMDBNode_def:
"nullMDBNode \<equiv> MDB_ \<lparr>
    mdbNext= nullPointer,
    mdbPrev= nullPointer,
    mdbRevocable= False,
    mdbFirstBadged= False \<rparr>"

defs dschDomain_def:
"dschDomain \<equiv> fst"

defs dschLength_def:
"dschLength \<equiv> snd"

defs isReceive_def:
"isReceive x0\<equiv> (case x0 of
    (BlockedOnReceive _ _) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs isSend_def:
"isSend x0\<equiv> (case x0 of
    (BlockedOnSend _ _ _ _ _) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs isReply_def:
"isReply x0\<equiv> (case x0 of
    BlockedOnReply \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs maxFreeIndex_def:
"maxFreeIndex magnitudeBits \<equiv> bit magnitudeBits"

defs getFreeRef_def:
"getFreeRef base freeIndex\<equiv> base + (fromIntegral freeIndex)"

defs getFreeIndex_def:
"getFreeIndex base free\<equiv> fromIntegral $ fromPPtr (free - base)"

defs untypedZeroRange_def:
"untypedZeroRange x0\<equiv> (let cap = x0 in
  if isUntypedCap cap
  then 
    let
        empty = capFreeIndex cap = maxFreeIndex (capBlockSize cap);
        startPtr = getFreeRef (capPtr cap) (capFreeIndex cap);
        endPtr = capPtr cap + PPtr (2 ^ capBlockSize cap) - 1
    in
    if empty \<or> capIsDevice cap
        then Nothing
        else Just (fromPPtr startPtr, fromPPtr endPtr)
  else   Nothing
  )"



end
