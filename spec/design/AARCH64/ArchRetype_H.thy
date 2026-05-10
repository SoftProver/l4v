(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchRetype_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Retyping Objects"

theory ArchRetype_H
imports
  ArchRetypeDecls_H
  ArchVSpaceDecls_H
  Hardware_H
  KI_Decls_H
  VCPU_H
begin

context Arch begin global_naming AARCH64_H

defs deriveCap_def:
"deriveCap x0 x1\<equiv> (let c = x1 in
  if isPageTableCap c \<and> capPTMappedAddress c \<noteq> None
  then   returnOk $ ArchObjectCap c
  else if isPageTableCap c \<and> capPTMappedAddress c = None
  then   throw IllegalOperation
  else if isFrameCap c
  then   returnOk $ ArchObjectCap $ c \<lparr> capFMappedAddress := Nothing \<rparr>
  else if c = ASIDControlCap
  then   returnOk $ ArchObjectCap c
  else if isASIDPoolCap c
  then   returnOk $ ArchObjectCap c
  else if isVCPUCap c
  then   returnOk $ ArchObjectCap c
  else undefined
  )"

defs isCapRevocable_def:
"isCapRevocable newCap srcCap \<equiv> False"

defs updateCapData_def:
"updateCapData arg1 arg2 c \<equiv> ArchObjectCap c"

defs cteRightsBits_def:
"cteRightsBits \<equiv> 0"

defs cteGuardBits_def:
"cteGuardBits \<equiv> 58"

defs maskCapRights_def:
"maskCapRights r x1\<equiv> (let c = x1 in
  if isFrameCap c
  then   ArchObjectCap $ c \<lparr>
    capFVMRights := maskVMRights (capFVMRights c) r \<rparr>
  else   ArchObjectCap c
  )"

defs postCapDeletion_def:
"postCapDeletion c\<equiv> return ()"

defs finaliseCap_def:
"finaliseCap x0 x1\<equiv> (case (x0, x1) of
    ((ASIDPoolCap ptr b), True) \<Rightarrow>    (do
    deleteASIDPool b ptr;
    return (NullCap, NullCap)
    od)
  | ((PageTableCap pte VSRootPT_T (Some (asid, vptr))), True) \<Rightarrow>    (do
    deleteASID asid pte;
    return (NullCap, NullCap)
  od)
  | ((PageTableCap pte NormalPT_T (Some (asid, vptr))), True) \<Rightarrow>    (do
    unmapPageTable asid vptr pte;
    return (NullCap, NullCap)
  od)
  | ((FrameCap ptr _ s _ (Some (asid, v))), _) \<Rightarrow>    (do
    unmapPage s asid v ptr;
    return (NullCap, NullCap)
  od)
  | ((VCPUCap vcpu), True) \<Rightarrow>    (do
    vcpuFinalise vcpu;
    return (NullCap, NullCap)
  od)
  | (_, _) \<Rightarrow>    return (NullCap, NullCap)
  )"

defs sameRegionAs_def:
"sameRegionAs x0 x1\<equiv> (let (a,b) = (x0, x1) in
  if isFrameCap a \<and> isFrameCap b
  then 
    let
        botA = capFBasePtr a;
        botB = capFBasePtr b;
        topA = botA + mask (pageBitsForSize $ capFSize a);
        topB = botB + mask (pageBitsForSize $ capFSize b)
    in
    
    (botA \<le> botB) \<and> (topA \<ge> topB) \<and> (botB \<le> topB)
  else if isPageTableCap a \<and> isPageTableCap b
  then  
    capPTBasePtr a = capPTBasePtr b \<and> capPTType a = capPTType b
  else if a = ASIDControlCap \<and> b = ASIDControlCap
  then   True
  else if isASIDPoolCap a \<and> isASIDPoolCap b
  then  
    capASIDPool a = capASIDPool b
  else if isVCPUCap a \<and> isVCPUCap b
  then   capVCPUPtr a = capVCPUPtr b
  else   False
  )"

defs isPhysicalCap_def:
"isPhysicalCap x0\<equiv> (case x0 of
    ASIDControlCap \<Rightarrow>    False
  | _ \<Rightarrow>    True
  )"

defs sameObjectAs_def:
"sameObjectAs x0 x1\<equiv> (let (a, b) = (x0, x1) in
  if isFrameCap a \<and> isFrameCap b
  then let ptrA = capFBasePtr a in  
    (ptrA = capFBasePtr b) \<and> (capFSize a = capFSize b)
        \<and> (ptrA \<le> ptrA + mask (pageBitsForSize $ capFSize a))
        \<and> (capFIsDevice a = capFIsDevice b)
  else   sameRegionAs a b
  )"

defs placeNewDataObject_def:
"placeNewDataObject regionBase sz isDevice \<equiv> if isDevice
    then placeNewObject regionBase UserDataDevice sz
    else placeNewObject regionBase UserData sz"

defs updatePTType_def:
"updatePTType p pt_t \<equiv> (do
    ptTypes \<leftarrow> gets (gsPTTypes \<circ> ksArchState);
    funupd \<leftarrow> return ( (\<lambda> f x v y. if y = x then v else f y));
    ptTypes' \<leftarrow> return ( funupd ptTypes (fromPPtr p) (Just pt_t));
    modify (\<lambda> ks. ks \<lparr> ksArchState := (ksArchState ks) \<lparr> gsPTTypes := ptTypes' \<rparr> \<rparr>)
od)"

defs createObject_def:
"createObject t regionBase arg3 isDevice \<equiv>
    let funupd = (\<lambda> f x v y. if y = x then v else f y) in
    let pointerCast = PPtr \<circ> fromPPtr
    in (case t of 
        APIObjectType v2 \<Rightarrow> 
            haskell_fail []
        | SmallPageObject \<Rightarrow>  (do
            placeNewDataObject regionBase 0 isDevice;
            modify (\<lambda> ks. ks \<lparr> gsUserPages :=
              funupd (gsUserPages ks)
                     (fromPPtr regionBase) (Just ARMSmallPage)\<rparr>);
            return $ FrameCap (pointerCast regionBase)
                  VMReadWrite ARMSmallPage isDevice Nothing
        od)
        | LargePageObject \<Rightarrow>  (do
            placeNewDataObject regionBase (ptTranslationBits NormalPT_T) isDevice;
            modify (\<lambda> ks. ks \<lparr> gsUserPages :=
              funupd (gsUserPages ks)
                     (fromPPtr regionBase) (Just ARMLargePage)\<rparr>);
            return $ FrameCap (pointerCast regionBase)
                  VMReadWrite ARMLargePage isDevice Nothing
        od)
        | HugePageObject \<Rightarrow>  (do
            placeNewDataObject regionBase (2*ptTranslationBits NormalPT_T) isDevice;
            modify (\<lambda> ks. ks \<lparr> gsUserPages :=
              funupd (gsUserPages ks)
                     (fromPPtr regionBase) (Just ARMHugePage)\<rparr>);
            return $ FrameCap (pointerCast regionBase)
                  VMReadWrite ARMHugePage isDevice Nothing
        od)
        | PageTableObject \<Rightarrow>  (do
            ptSize \<leftarrow> return ( ptBits NormalPT_T - objBits (makeObject ::pte));
            placeNewObject regionBase (makeObject ::pte) ptSize;
            updatePTType regionBase NormalPT_T;
            return $ PageTableCap (pointerCast regionBase) NormalPT_T Nothing
        od)
        | VSpaceObject \<Rightarrow>  (do
            ptSize \<leftarrow> return ( ptBits VSRootPT_T - objBits (makeObject ::pte));
            placeNewObject regionBase (makeObject ::pte) ptSize;
            updatePTType regionBase VSRootPT_T;
            return $ PageTableCap (pointerCast regionBase) VSRootPT_T Nothing
        od)
        | VCPUObject \<Rightarrow>  (do
            placeNewObject regionBase (makeObject ::vcpu) 0;
            return $ VCPUCap (PPtr $ fromPPtr regionBase)
        od)
        )"

defs decodeInvocation_def:
"decodeInvocation label args capIndex slot cap extraCaps \<equiv>
    (case cap of
         VCPUCap _ \<Rightarrow>   decodeARMVCPUInvocation label args capIndex slot cap extraCaps
       | _ \<Rightarrow>   decodeARMMMUInvocation label args capIndex slot cap extraCaps
       )"

defs performInvocation_def:
"performInvocation i \<equiv>
    (let inv = i
        in case inv of InvokeVCPU iv \<Rightarrow>  withoutPreemption $ performARMVCPUInvocation iv
        | _ \<Rightarrow>  performARMMMUInvocation i
        )"

defs capUntypedPtr_def:
"capUntypedPtr x0\<equiv> (case x0 of
    (FrameCap (\<comment> \<open>PPtr\<close> p) _ _ _ _) \<Rightarrow>    PPtr p
  | (PageTableCap (\<comment> \<open>PPtr\<close> p) _ _) \<Rightarrow>    PPtr p
  | ASIDControlCap \<Rightarrow>    error []
  | (ASIDPoolCap (\<comment> \<open>PPtr\<close> p) _) \<Rightarrow>    PPtr p
  | (VCPUCap (\<comment> \<open>PPtr\<close> p)) \<Rightarrow>    PPtr p
  )"

defs asidPoolBits_def:
"asidPoolBits \<equiv> 12"

defs capUntypedSize_def:
"capUntypedSize x0\<equiv> (case x0 of
    (FrameCap _ _ sz _ _) \<Rightarrow>    bit $ pageBitsForSize sz
  | (PageTableCap _ pt_t _) \<Rightarrow>    bit (ptBits pt_t)
  | (ASIDControlCap ) \<Rightarrow>    0
  | (ASIDPoolCap _ _) \<Rightarrow>    bit asidPoolBits
  | (VCPUCap _) \<Rightarrow>    bit vcpuBits
  )"

defs fpuThreadDelete_def:
"fpuThreadDelete threadPtr \<equiv>
    doMachineOp $ fpuThreadDeleteOp (fromPPtr threadPtr)"

defs prepareThreadDelete_def:
"prepareThreadDelete thread\<equiv> (do
    fpuThreadDelete thread;
    tcbVCPU \<leftarrow> archThreadGet atcbVCPUPtr thread;
    (case tcbVCPU of
        Some ptr \<Rightarrow>   dissociateVCPUTCB ptr thread
      | _ \<Rightarrow>   return ()
      )
od)"


end (* context AARCH64 *)
end
