(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ThreadDecls_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Function Declarations for Threads"

theory ThreadDecls_H
imports
  Structures_H
  FaultMonad_H
  KernelInitMonad_H
  ArchThreadDecls_H
begin

consts'
configureIdleThread :: "machine_word \<Rightarrow> unit kernel_init"

consts'
activateInitialThread :: "machine_word \<Rightarrow> vptr \<Rightarrow> vptr \<Rightarrow> unit kernel"

consts'
activateThread :: "unit kernel"

consts'
isStopped :: "machine_word \<Rightarrow> bool kernel"

consts'
isRunnable :: "machine_word \<Rightarrow> bool kernel"

consts'
updateRestartPC :: "machine_word \<Rightarrow> unit kernel"

consts'
suspend :: "machine_word \<Rightarrow> unit kernel"

consts'
restart :: "machine_word \<Rightarrow> unit kernel"

consts'
doIPCTransfer :: "machine_word \<Rightarrow> (machine_word) option \<Rightarrow> machine_word \<Rightarrow> bool \<Rightarrow> machine_word \<Rightarrow> unit kernel"

consts'
doReplyTransfer :: "machine_word \<Rightarrow> machine_word \<Rightarrow> machine_word \<Rightarrow> bool \<Rightarrow> unit kernel"

consts'
doNormalTransfer :: "machine_word \<Rightarrow> (machine_word) option \<Rightarrow> (machine_word) option \<Rightarrow> machine_word \<Rightarrow> bool \<Rightarrow> machine_word \<Rightarrow> (machine_word) option \<Rightarrow> unit kernel"

consts'
doFaultTransfer :: "machine_word \<Rightarrow> machine_word \<Rightarrow> machine_word \<Rightarrow> (machine_word) option \<Rightarrow> unit kernel"

consts'
transferCaps :: "message_info \<Rightarrow> (capability * machine_word) list \<Rightarrow> (machine_word) option \<Rightarrow> machine_word \<Rightarrow> (machine_word) option \<Rightarrow> message_info kernel"

consts'
scheduleChooseNewThread :: "unit kernel"

consts'
scheduleSwitchThreadFastfail :: "machine_word \<Rightarrow> machine_word \<Rightarrow> priority \<Rightarrow> priority \<Rightarrow> (bool) kernel"

consts'
schedule :: "unit kernel"

consts'
countLeadingZeros :: "('b :: {HS_bit, finiteBit}) \<Rightarrow> nat"

consts'
wordLog2 :: "('b :: {HS_bit, finiteBit}) \<Rightarrow> nat"

consts'
invertL1Index :: "nat \<Rightarrow> nat"

consts'
getHighestPrio :: "domain \<Rightarrow> (priority) kernel"

consts'
isHighestPrio :: "domain \<Rightarrow> priority \<Rightarrow> (bool) kernel"

consts'
chooseThread :: "unit kernel"

consts'
switchToThread :: "machine_word \<Rightarrow> unit kernel"

consts'
switchToIdleThread :: "unit kernel"

consts'
setDomain :: "machine_word \<Rightarrow> domain \<Rightarrow> unit kernel"

consts'
setMCPriority :: "machine_word \<Rightarrow> priority \<Rightarrow> unit kernel"

consts'
setPriority :: "machine_word \<Rightarrow> priority \<Rightarrow> unit kernel"

consts'
possibleSwitchTo :: "machine_word \<Rightarrow> unit kernel"

consts'
rescheduleRequired :: "unit kernel"

consts'
getThreadState :: "machine_word \<Rightarrow> thread_state kernel"

consts'
setThreadState :: "thread_state \<Rightarrow> machine_word \<Rightarrow> unit kernel"

consts'
getBoundNotification :: "machine_word \<Rightarrow> ((machine_word) option) kernel"

consts'
setBoundNotification :: "(machine_word) option \<Rightarrow> machine_word \<Rightarrow> unit kernel"

consts'
prioToL1Index :: "priority \<Rightarrow> nat"

consts'
l1IndexToPrio :: "nat \<Rightarrow> priority"

consts'
getReadyQueuesL1Bitmap :: "domain \<Rightarrow> (machine_word) kernel"

consts'
modifyReadyQueuesL1Bitmap :: "domain \<Rightarrow> (machine_word \<Rightarrow> machine_word) \<Rightarrow> unit kernel"

consts'
getReadyQueuesL2Bitmap :: "domain \<Rightarrow> nat \<Rightarrow> (machine_word) kernel"

consts'
modifyReadyQueuesL2Bitmap :: "domain \<Rightarrow> nat \<Rightarrow> (machine_word \<Rightarrow> machine_word) \<Rightarrow> unit kernel"

consts'
addToBitmap :: "domain \<Rightarrow> priority \<Rightarrow> unit kernel"

consts'
removeFromBitmap :: "domain \<Rightarrow> priority \<Rightarrow> unit kernel"

consts'
tcbQueueEmpty :: "tcb_queue \<Rightarrow> bool"

consts'
tcbQueuePrepend :: "tcb_queue \<Rightarrow> machine_word \<Rightarrow> tcb_queue kernel"

consts'
tcbQueueAppend :: "tcb_queue \<Rightarrow> machine_word \<Rightarrow> tcb_queue kernel"

consts'
tcbQueueInsert :: "machine_word \<Rightarrow> machine_word \<Rightarrow> unit kernel"

consts'
tcbQueueRemove :: "tcb_queue \<Rightarrow> machine_word \<Rightarrow> tcb_queue kernel"

consts'
tcbSchedEnqueue :: "machine_word \<Rightarrow> unit kernel"

consts'
tcbSchedAppend :: "machine_word \<Rightarrow> unit kernel"

consts'
tcbSchedDequeue :: "machine_word \<Rightarrow> unit kernel"

consts'
timerTick :: "unit kernel"


end
