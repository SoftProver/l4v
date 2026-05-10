(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file API_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "The API"

theory API_H
imports Syscall_H Delete_H
begin

text \<open>collects all API modules\<close>

consts'
kernelExitAssertions :: "kernel_state \<Rightarrow> bool"


definition
callKernel :: "event \<Rightarrow> unit kernel"
where
"callKernel ev\<equiv> (do
    runExceptT $ handleEvent ev
        `~catchError~` (\<lambda> _. withoutPreemption $ (do
                      irq \<leftarrow> doMachineOp (getActiveIRQ True);
                      when (isJust irq) $ handleInterrupt (fromJust irq)
        od)
                                                                        );
    schedule;
    activateThread;
    stateAssert kernelExitAssertions []
od)"


end
