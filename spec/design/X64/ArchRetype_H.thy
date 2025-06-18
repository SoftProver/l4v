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

context Arch begin global_naming X64_H

defs deriveCap_def:
"deriveCap x0 x1\<equiv> (let c = x1 in
  if isPageTableCap c \<and> capPTMappedAddress c \<noteq> None
  then   returnOk $ ArchObjectCap c
  else if isPageTableCap c \<and> capPTMappedAddress c = None
  then   throw IllegalOperation
  else if isPageDirectoryCap c \<and> capPDMappedAddress c \<noteq> None
  then   returnOk $ ArchObjectCap c
  else if isPageDirectoryCap c \<and> capPDMappedAddress c = None
  then   throw IllegalOperation
  else if isPDPointerTableCap c \<and> capPDPTMappedAddress c \<noteq> None
  then   returnOk $ ArchObjectCap c
  else if isPDPointerTableCap c \<and> capPDPTMappedAddress c = None
  then   throw IllegalOperation
  else if isPML4Cap c \<and> capPML4MappedASID c \<noteq> None
  then   returnOk $ ArchObjectCap c
  else if isPML4Cap c \<and> capPML4MappedASID c = None
  then   throw IllegalOperation
  else if isPageCap c
  then   returnOk $ ArchObjectCap $ c \<lparr> capVPMappedAddress := Nothing, capVPMapType := VMNoMap \<rparr>
  else if isASIDControlCap c
  then   returnOk $ ArchObjectCap c
  else if isASIDPoolCap c
  then   returnOk $ ArchObjectCap c
  else if isIOPortCap c
  then   returnOk $ ArchObjectCap c
  else if isIOPortControlCap c
  then   returnOk NullCap
  else undefined
  )"

defs isIOPortControlCap'_def:
"isIOPortControlCap' x0\<equiv> (case x0 of
    (ArchObjectCap IOPortControlCap) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs isCapRevocable_def:
"isCapRevocable newCap srcCap\<equiv> (case newCap of
      ArchObjectCap (IOPortCap _ _) \<Rightarrow>   isIOPortControlCap' srcCap
    | _ \<Rightarrow>   False
    )"

defs updateCapData_def:
"updateCapData arg1 arg2 c \<equiv> ArchObjectCap c"

defs cteRightsBits_def:
"cteRightsBits \<equiv> 0"

defs cteGuardBits_def:
"cteGuardBits \<equiv> 58"

defs maskCapRights_def:
"maskCapRights r x1\<equiv> (let c = x1 in
  if isPageCap c
  then   ArchObjectCap $ c \<lparr>
    capVPRights := maskVMRights (capVPRights c) r \<rparr>
  else   ArchObjectCap c
  )"

defs setIOPortMask_def:
"setIOPortMask f l val\<equiv> (do
    ports \<leftarrow> gets (x64KSAllocatedIOPorts \<circ> ksArchState);
    ports' \<leftarrow> return $ ports aLU [(i,val) | i \<leftarrow> [f .e. l]];
    modify (\<lambda> s. s \<lparr>
        ksArchState := (ksArchState s) \<lparr> x64KSAllocatedIOPorts := ports' \<rparr>\<rparr>)
od)"

defs freeIOPortRange_def:
"freeIOPortRange f l \<equiv> setIOPortMask f l False"

defs postCapDeletion_def:
"postCapDeletion c\<equiv> (case c of
      IOPortCap f l \<Rightarrow>   freeIOPortRange f l
    | _ \<Rightarrow>   return ()
    )"

defs finaliseCap_def:
"finaliseCap x0 x1\<equiv> (case (x0, x1) of
    ((ASIDPoolCap ptr b), True) \<Rightarrow>    (do
    deleteASIDPool b ptr;
    return (NullCap, NullCap)
    od)
  | ((PML4Cap ptr (Some a)), True) \<Rightarrow>    (do
    deleteASID a ptr;
    return (NullCap, NullCap)
  od)
  | ((PDPointerTableCap ptr (Some (a, v))), True) \<Rightarrow>    (do
    unmapPDPT a v ptr;
    return (NullCap, NullCap)
  od)
  | ((PageDirectoryCap ptr (Some (a, v))), True) \<Rightarrow>    (do
    unmapPageDirectory a v ptr;
    return (NullCap, NullCap)
  od)
  | ((PageTableCap ptr (Some (a, v))), True) \<Rightarrow>    (do
    unmapPageTable a v ptr;
    return (NullCap, NullCap)
  od)
  | ((PageCap ptr _ _ s _ (Some (a, v))), _) \<Rightarrow>    (do
    unmapPage s a v ptr;
    return (NullCap, NullCap)
  od)
  | ((IOPortCap f l), True) \<Rightarrow>    return (NullCap, (ArchObjectCap (IOPortCap f l)))
  | (_, _) \<Rightarrow>    return (NullCap, NullCap)
  )"

defs sameRegionAs_def:
"sameRegionAs x0 x1\<equiv> (let (a,b) = (x0, x1) in
  if isPageCap a \<and> isPageCap b
  then 
    let
        botA = capVPBasePtr a;
        botB = capVPBasePtr b;
        topA = botA + bit (pageBitsForSize $ capVPSize a) - 1;
        topB = botB + bit (pageBitsForSize $ capVPSize b) - 1
    in
    
    (botA \<le> botB) \<and> (topA \<ge> topB) \<and> (botB \<le> topB)
  else if isPageTableCap a \<and> isPageTableCap b
  then  
    capPTBasePtr a = capPTBasePtr b
  else if isPageDirectoryCap a \<and> isPageDirectoryCap b
  then  
    capPDBasePtr a = capPDBasePtr b
  else if isPDPointerTableCap a \<and> isPDPointerTableCap b
  then  
    capPDPTBasePtr a = capPDPTBasePtr b
  else if isPML4Cap a \<and> isPML4Cap b
  then  
    capPML4BasePtr a = capPML4BasePtr b
  else if isASIDControlCap a \<and> isASIDControlCap b
  then   True
  else if isASIDPoolCap a \<and> isASIDPoolCap b
  then  
    capASIDPool a = capASIDPool b
  else if isIOPortCap a \<and> isIOPortCap b
  then 
    let
        fA = capIOPortFirstPort a;
        fB = capIOPortFirstPort b;
        lA = capIOPortLastPort a;
        lB = capIOPortLastPort b
    in
    
    (fA = fB) \<and> (lB = lA)
  else if isIOPortControlCap a \<and> isIOPortControlCap b
  then   True
  else if isIOPortControlCap a \<and> isIOPortCap b
  then   True
  else   False
  )"

defs isPhysicalCap_def:
"isPhysicalCap x0\<equiv> (case x0 of
    ASIDControlCap \<Rightarrow>    False
  | (IOPortCap _ _) \<Rightarrow>    False
  | IOPortControlCap \<Rightarrow>    False
  | _ \<Rightarrow>    True
  )"

defs sameObjectAs_def:
"sameObjectAs x0 x1\<equiv> (let (a, b) = (x0, x1) in
  if isPageCap a \<and> isPageCap b
  then let ptrA = capVPBasePtr a
  in  
    (ptrA = capVPBasePtr b) \<and> (capVPSize a = capVPSize b)
        \<and> (ptrA \<le> ptrA + bit (pageBitsForSize $ capVPSize a) - 1)
        \<and> (capVPIsDevice a = capVPIsDevice b)
  else if isIOPortControlCap a \<and> isIOPortCap b
  then   False
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
                     (fromPPtr regionBase) (Just X64SmallPage)\<rparr>);
            return $ PageCap (pointerCast regionBase)
                  VMReadWrite VMNoMap X64SmallPage isDevice Nothing
        od)
        | LargePageObject =>  (do
            placeNewDataObject regionBase ptTranslationBits isDevice;
            modify (\<lambda> ks. ks \<lparr> gsUserPages :=
              funupd (gsUserPages ks)
                     (fromPPtr regionBase) (Just X64LargePage)\<rparr>);
            return $ PageCap (pointerCast regionBase)
                  VMReadWrite VMNoMap X64LargePage isDevice Nothing
        od)
        | HugePageObject =>  (do
            placeNewDataObject regionBase (ptTranslationBits + ptTranslationBits) isDevice;
            modify (\<lambda> ks. ks \<lparr> gsUserPages :=
              funupd (gsUserPages ks)
                     (fromPPtr regionBase) (Just X64HugePage)\<rparr>);
            return $ PageCap (pointerCast regionBase)
                  VMReadWrite VMNoMap X64HugePage isDevice Nothing
        od)
        | PageTableObject =>  (do
            ptSize \<leftarrow> return ( ptBits - objBits (makeObject ::pte));
            placeNewObject regionBase (makeObject ::pte) ptSize;
            return $ PageTableCap (pointerCast regionBase) Nothing
        od)
        | PageDirectoryObject =>  (do
            pdSize \<leftarrow> return ( pdBits - objBits (makeObject ::pde));
            placeNewObject regionBase (makeObject ::pde) pdSize;
            return $ PageDirectoryCap (pointerCast regionBase) Nothing
        od)
        | PDPointerTableObject =>  (do
            pdptSize \<leftarrow> return ( pdptBits - objBits (makeObject ::pdpte));
            placeNewObject regionBase (makeObject ::pdpte) pdptSize;
            return $ PDPointerTableCap (pointerCast regionBase) Nothing
        od)
        | PML4Object =>  (do
            pml4Size \<leftarrow> return ( pml4Bits - objBits (makeObject ::pml4e));
            placeNewObject regionBase (makeObject ::pml4e) pml4Size;
            copyGlobalMappings (pointerCast regionBase);
            return $ PML4Cap (pointerCast regionBase) Nothing
        od)
        )"

defs isIOCap_def:
"isIOCap c\<equiv> (case c of
           (IOPortCap _ _) \<Rightarrow>   True
         | IOPortControlCap \<Rightarrow>   True
         | _ \<Rightarrow>   False
         )"

defs decodeInvocation_def:
"decodeInvocation label args capIndex slot cap extraCaps \<equiv>
    if isIOCap cap
     then decodeX64PortInvocation label args slot cap $ map fst extraCaps
     else decodeX64MMUInvocation label args capIndex slot cap extraCaps"

defs performInvocation_def:
"performInvocation x0\<equiv> (let oper = x0 in
  case oper of
  InvokeIOPort _ =>   performX64PortInvocation oper
  | InvokeIOPortControl _ =>   performX64PortInvocation oper
  | _ =>   performX64MMUInvocation oper
  )"

defs capUntypedPtr_def:
"capUntypedPtr x0\<equiv> (case x0 of
    (PageCap (\<comment> \<open>PPtr\<close> p) _ _ _ _ _) \<Rightarrow>    PPtr p
  | (PageTableCap (\<comment> \<open>PPtr\<close> p) _) \<Rightarrow>    PPtr p
  | (PageDirectoryCap (\<comment> \<open>PPtr\<close> p) _) \<Rightarrow>    PPtr p
  | (PDPointerTableCap (\<comment> \<open>PPtr\<close> p) _) \<Rightarrow>    PPtr p
  | (PML4Cap (\<comment> \<open>PPtr\<close> p) _) \<Rightarrow>    PPtr p
  | ASIDControlCap \<Rightarrow>    error []
  | (ASIDPoolCap (\<comment> \<open>PPtr\<close> p) _) \<Rightarrow>    PPtr p
  | (IOPortCap _ _) \<Rightarrow>    error []
  | IOPortControlCap \<Rightarrow>    error []
  )"

defs capUntypedSize_def:
"capUntypedSize x0\<equiv> (case x0 of
    (PageCap _ _ _ sz _ _) \<Rightarrow>    1 `~shiftL~` pageBitsForSize sz
  | (PageTableCap _ _) \<Rightarrow>    1 `~shiftL~` 12
  | (PageDirectoryCap _ _) \<Rightarrow>    1 `~shiftL~` 12
  | (PDPointerTableCap _ _) \<Rightarrow>    1 `~shiftL~` 12
  | (PML4Cap _ _) \<Rightarrow>    1 `~shiftL~` 12
  | (ASIDControlCap ) \<Rightarrow>    0
  | (ASIDPoolCap _ _) \<Rightarrow>    1 `~shiftL~` (asidLowBits + 3)
  | (IOPortCap _ _) \<Rightarrow>    0
  | IOPortControlCap \<Rightarrow>    0
  )"

defs prepareThreadDelete_def:
"prepareThreadDelete threadPtr \<equiv> fpuThreadDelete threadPtr"

defs fpuThreadDelete_def:
"fpuThreadDelete threadPtr\<equiv> (do
    usingFpu \<leftarrow> doMachineOp $ nativeThreadUsingFPU (fromPPtr threadPtr);
    when usingFpu $ doMachineOp (switchFpuOwner 0 0)
od)"


end (* context X64 *)
end
