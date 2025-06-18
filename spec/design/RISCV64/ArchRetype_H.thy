(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchRetype_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
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
begin

context Arch begin global_naming RISCV64_H

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
  | ((PageTableCap pte (Some (asid, vptr))), True) \<Rightarrow>    (do
    catchFailure
        ((doE
            vroot \<leftarrow> findVSpaceForASID asid;
            if vroot = pte
                then withoutFailure $ deleteASID asid pte
                else throw InvalidRoot
        odE)
                                      )
        (\<lambda> _. unmapPageTable asid vptr pte);
    return (NullCap, NullCap)
  od)
  | ((FrameCap ptr _ s _ (Some (asid, v))), _) \<Rightarrow>    (do
    unmapPage s asid v ptr;
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
    capPTBasePtr a = capPTBasePtr b
  else if a = ASIDControlCap \<and> b = ASIDControlCap
  then   True
  else if isASIDPoolCap a \<and> isASIDPoolCap b
  then  
    capASIDPool a = capASIDPool b
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

defs createObject_def:
"createObject t regionBase arg3 isDevice \<equiv>
    let funupd = (\<lambda> f x v y. if y = x then v else f y) in
    let pointerCast = PPtr \<circ> fromPPtr
    in (let t = t in
        case t of
        APIObjectType _ => 
            haskell_fail []
        | SmallPageObject =>  (do
            placeNewDataObject regionBase 0 isDevice;
            modify (\<lambda> ks. ks \<lparr> gsUserPages :=
              funupd (gsUserPages ks)
                     (fromPPtr regionBase) (Just RISCVSmallPage)\<rparr>);
            return $ FrameCap (pointerCast regionBase)
                  VMReadWrite RISCVSmallPage isDevice Nothing
        od)
        | LargePageObject =>  (do
            placeNewDataObject regionBase ptTranslationBits isDevice;
            modify (\<lambda> ks. ks \<lparr> gsUserPages :=
              funupd (gsUserPages ks)
                     (fromPPtr regionBase) (Just RISCVLargePage)\<rparr>);
            return $ FrameCap (pointerCast regionBase)
                  VMReadWrite RISCVLargePage isDevice Nothing
        od)
        | HugePageObject =>  (do
            placeNewDataObject regionBase (ptTranslationBits+ptTranslationBits) isDevice;
            modify (\<lambda> ks. ks \<lparr> gsUserPages :=
              funupd (gsUserPages ks)
                     (fromPPtr regionBase) (Just RISCVHugePage)\<rparr>);
            return $ FrameCap (pointerCast regionBase)
                  VMReadWrite RISCVHugePage isDevice Nothing
        od)
        | PageTableObject =>  (do
            ptSize \<leftarrow> return ( ptBits - objBits (makeObject ::pte));
            placeNewObject regionBase (makeObject ::pte) ptSize;
            return $ PageTableCap (pointerCast regionBase) Nothing
        od)
        )"

defs decodeInvocation_def:
"decodeInvocation \<equiv> decodeRISCVMMUInvocation"

defs performInvocation_def:
"performInvocation \<equiv> performRISCVMMUInvocation"

defs capUntypedPtr_def:
"capUntypedPtr x0\<equiv> (case x0 of
    (FrameCap (\<comment> \<open>PPtr\<close> p) _ _ _ _) \<Rightarrow>    PPtr p
  | (PageTableCap (\<comment> \<open>PPtr\<close> p) _) \<Rightarrow>    PPtr p
  | ASIDControlCap \<Rightarrow>    error []
  | (ASIDPoolCap (\<comment> \<open>PPtr\<close> p) _) \<Rightarrow>    PPtr p
  )"

defs asidPoolBits_def:
"asidPoolBits \<equiv> 12"

defs capUntypedSize_def:
"capUntypedSize x0\<equiv> (case x0 of
    (FrameCap _ _ sz _ _) \<Rightarrow>    bit $ pageBitsForSize sz
  | (PageTableCap _ _) \<Rightarrow>    bit ptBits
  | (ASIDControlCap ) \<Rightarrow>    0
  | (ASIDPoolCap _ _) \<Rightarrow>    bit asidPoolBits
  )"

defs prepareThreadDelete_def:
"prepareThreadDelete arg1 \<equiv> return ()"


end (* context RISCV64 *)
end
