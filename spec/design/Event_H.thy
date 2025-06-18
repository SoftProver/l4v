(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file Event_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Kernel Events"

theory Event_H
imports MachineExports
begin

text \<open>
  \label{sec:Event_H}

  These are the user-level and machine generated events the kernel reacts to.
\<close>

datatype syscall =
    SysCall
  | SysReplyRecv
  | SysSend
  | SysNBSend
  | SysRecv
  | SysReply
  | SysYield
  | SysNBRecv

datatype event =
    SyscallEvent syscall
  | UnknownSyscall nat
  | UserLevelFault machine_word machine_word
  | Interrupt
  | VMFaultEvent vmfault_type
  | HypervisorEvent hyp_fault_type


end
