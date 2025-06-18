(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file VSpace_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
    VSpace lookup code.
*)

theory VSpace_H
imports
  CNode_H
  ArchVSpace_H
  KernelInitMonad_H
begin

context begin interpretation Arch .
requalify_consts
  mapKernelWindow
  activateGlobalVSpace
  configureTimer
  initL2Cache
  initIRQController

  createIPCBufferFrame
  createBIFrame
  createFramesOfRegion
  createITPDPTs
  writeITPDPTs
  createITASIDPool
  writeITASIDPool
  createDeviceFrames
  handleVMFault
  isValidVTableRoot
  checkValidIPCBuffer
  lookupIPCBuffer
  vptrFromPPtr
end

definition
initKernelVM :: "unit kernel"
where
"initKernelVM \<equiv> mapKernelWindow"

definition
initPlatform :: "unit kernel"
where
"initPlatform\<equiv> (do
  doMachineOp $ initIRQController;
  doMachineOp $ configureTimer;
  doMachineOp $ initL2Cache
od)"

definition
initCPU :: "unit kernel"
where
"initCPU \<equiv> activateGlobalVSpace"


end
