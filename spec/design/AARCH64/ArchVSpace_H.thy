(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchVSpace_H.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 * Copyright 2022, Proofcraft Pty Ltd
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
  VSpace lookup code.
*)

theory ArchVSpace_H
imports
  CNode_H
  KI_Decls_H
  ArchVSpaceDecls_H
  ArchHypervisor_H
begin

context Arch begin global_naming AARCH64_H

defs isPageTablePTE_def:
"isPageTablePTE x0\<equiv> (case x0 of
    (PageTablePTE _) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs ptBitsLeft_def:
"ptBitsLeft level \<equiv>
  (if level \<le> maxPTLevel
   then ptTranslationBits NormalPT_T * level
   else ptTranslationBits VSRootPT_T + ptTranslationBits NormalPT_T * maxPTLevel) + pageBits"

defs pteAtIndex_def:
"pteAtIndex level ptPtr vPtr\<equiv> getObject (ptSlotIndex level ptPtr vPtr)"


fun
  lookupPTSlotFromLevel :: "nat => machine_word => machine_word => (nat * machine_word) kernel"
where
  "lookupPTSlotFromLevel 0 ptPtr vPtr =
     return (ptBitsLeft 0, ptSlotIndex 0 ptPtr vPtr)"
| "lookupPTSlotFromLevel level ptPtr vPtr = do
     pte <- pteAtIndex level ptPtr vPtr;
     if isPageTablePTE pte
     then do
       checkPTAt (getPPtrFromPTE pte);
       lookupPTSlotFromLevel (level - 1) (getPPtrFromPTE pte) vPtr
     od
     else return (ptBitsLeft level, ptSlotIndex level ptPtr vPtr)
   od"

fun
  lookupPTFromLevel :: "nat => machine_word => machine_word => machine_word =>
    (lookup_failure, machine_word) kernel_f"
where
  "lookupPTFromLevel level ptPtr vPtr targetPtPtr = doE
    assertE (ptPtr \<noteq> targetPtPtr);
    unlessE (0 < level) $ throw InvalidRoot;
    slot <- returnOk $ ptSlotIndex level ptPtr vPtr;
    pte <- withoutFailure $ getObject slot;
    unlessE (isPageTablePTE pte) $ throw InvalidRoot;
    ptr <- returnOk (getPPtrFromPTE pte);
    if ptr = targetPtPtr
        then returnOk slot
        else doE
          liftE $ checkPTAt ptr;
          lookupPTFromLevel (level - 1) ptr vPtr targetPtPtr
        odE
  odE"

defs ipcBufferSizeBits_def:
"ipcBufferSizeBits \<equiv> 10"

defs lookupIPCBuffer_def:
"lookupIPCBuffer isReceiver thread\<equiv> (do
    bufferPtr \<leftarrow> threadGet tcbIPCBuffer thread;
    bufferFrameSlot \<leftarrow> getThreadBufferSlot thread;
    bufferCap \<leftarrow> getSlotCap bufferFrameSlot;
    (case bufferCap of
          ArchObjectCap (FrameCap basePtr rights sz False _) \<Rightarrow>   (do
            pBits \<leftarrow> return ( pageBitsForSize sz);
            if (rights = VMReadWrite \<or> Not isReceiver \<and> rights = VMReadOnly)
                then (do
                    ptr \<leftarrow> return ( basePtr + PPtr (fromVPtr bufferPtr && mask pBits));
                    haskell_assert (ptr \<noteq> 0) [];
                    return $ Just ptr
                od)
                else return Nothing
          od)
        | _ \<Rightarrow>   return Nothing
        )
od)"

defs getPoolPtr_def:
"getPoolPtr asid\<equiv> (do
    haskell_assert (asid > 0) [];
    haskell_assert (asid \<le> snd asidRange) [];
    asidTable \<leftarrow> gets (armKSASIDTable \<circ> ksArchState);
    return $ asidTable (asidHighBitsOf asid)
od)"

defs getASIDPoolEntry_def:
"getASIDPoolEntry asid\<equiv> (do
    poolPtr \<leftarrow> getPoolPtr asid;
    maybePool \<leftarrow> (case poolPtr of
          Some ptr \<Rightarrow>   liftM Just $ getObject ptr
        | None \<Rightarrow>   return Nothing
        );
    (case maybePool of
          Some (ASIDPool pool) \<Rightarrow>   return $ pool (asid && mask asidLowBits)
        | None \<Rightarrow>   return Nothing
        )
od)"

defs updateASIDPoolEntry_def:
"updateASIDPoolEntry f asid\<equiv> (do
    maybePoolPtr \<leftarrow> getPoolPtr asid;
    haskell_assert (isJust maybePoolPtr) [];
    poolPtr \<leftarrow> return ( fromJust maybePoolPtr);
 pool \<leftarrow> liftM (inv ASIDPool) $  getObject poolPtr;
    maybeEntry \<leftarrow> return ( pool (asid && mask asidLowBits));
    haskell_assert (isJust maybeEntry) [];
    pool' \<leftarrow> return ( pool aLU [(asid && mask asidLowBits, f $ fromJust maybeEntry)]);
    setObject poolPtr $ ASIDPool pool'
od)"

defs findVSpaceForASID_def:
"findVSpaceForASID asid\<equiv> (doE
    maybeEntry \<leftarrow> withoutFailure $ getASIDPoolEntry asid;
    (case maybeEntry of
          Some (ASIDPoolVSpace vmID ptr) \<Rightarrow>   (doE
            haskell_assertE (ptr \<noteq> 0) [];
            withoutFailure $ checkPTAt ptr;
            returnOk ptr
          odE)
        | _ \<Rightarrow>   throw $ InvalidRoot
        )
odE)"

defs maybeVSpaceForASID_def:
"maybeVSpaceForASID asid \<equiv>
    liftME Just (findVSpaceForASID asid) `~catchFailure~` const (return Nothing)"

defs isPagePTE_def:
"isPagePTE x0\<equiv> (case x0 of
    (PagePTE _ _ _ _ _ _) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs getPPtrFromPTE_def:
"getPPtrFromPTE pte \<equiv>
    ptrFromPAddr (if isPagePTE pte then pteBaseAddress pte else ptePPN pte `~shiftL~` pageBits)"

defs levelType_def:
"levelType level \<equiv> if level = maxPTLevel then VSRootPT_T else NormalPT_T"

defs ptIndex_def:
"ptIndex level vPtr \<equiv>
    (fromVPtr vPtr `~shiftR~` ptBitsLeft level) && mask (ptTranslationBits (levelType level))"

defs ptSlotIndex_def:
"ptSlotIndex level ptPtr vPtr \<equiv>
    ptPtr + PPtr (ptIndex level vPtr `~shiftL~` pteBits)"

defs lookupPTSlot_def:
"lookupPTSlot \<equiv> lookupPTSlotFromLevel maxPTLevel"

defs lookupFrame_def:
"lookupFrame vspaceRoot vPtr\<equiv> (do
    (bitsLeft, ptePtr) \<leftarrow> lookupPTSlot vspaceRoot vPtr;
    pte \<leftarrow> getObject ptePtr;
    if isPagePTE pte
        then return $ Just (bitsLeft, pteBaseAddress pte)
        else return Nothing
od)"

defs handleVMFault_def:
"handleVMFault thread x1\<equiv> (case x1 of
    ARMDataAbort \<Rightarrow>    (doE
    addr \<leftarrow> withoutFailure $ doMachineOp getFAR;
    fault \<leftarrow> withoutFailure $ doMachineOp getDFSR;
    active \<leftarrow> withoutFailure $ curVCPUActive;
    addr \<leftarrow> if active
            then (doE
                parEL1Mask \<leftarrow> returnOk ( 0xfffffffff000);
                addr' \<leftarrow> withoutFailure $ doMachineOp $ addressTranslateS1 addr;
                returnOk $ (addr' && parEL1Mask) || (addr && mask pageBits)
            odE)
            else
                returnOk addr;
    throw $ ArchFault $ VMFault addr [0, fault && mask 32]
    odE)
  | ARMPrefetchAbort \<Rightarrow>    (doE
    pc \<leftarrow> withoutFailure $ asUser thread $ getRestartPC;
    fault \<leftarrow> withoutFailure $ doMachineOp getIFSR;
    active \<leftarrow> withoutFailure $ curVCPUActive;
    pc \<leftarrow> if active
          then (doE
              parEL1Mask \<leftarrow> returnOk ( 0xfffffffff000);
              pc' \<leftarrow> withoutFailure $ doMachineOp $ addressTranslateS1 (VPtr pc);
              returnOk $ (pc' && parEL1Mask) || (VPtr pc && mask pageBits)
          odE)
          else
              returnOk $ VPtr pc;
    throw $ ArchFault $ VMFault pc [1, fault && mask 32]
  odE)
  )"

defs invalidateTLBByASID_def:
"invalidateTLBByASID asid\<equiv> (do
    maybeVMID \<leftarrow> loadVMID asid;
    when (isJust maybeVMID) $
        doMachineOp $ invalidateTranslationASID $ fromIntegral $ fromJust maybeVMID
od)"

defs invalidateTLBByASIDVA_def:
"invalidateTLBByASIDVA asid vaddr\<equiv> (do
    maybeVMID \<leftarrow> loadVMID asid;
    when (isJust maybeVMID) $ (do
        vmID \<leftarrow> return ( fromJust maybeVMID);
        shift \<leftarrow> return ( wordBits - asidBits);
        vpn \<leftarrow> return ( fromIntegral vmID `~shiftL~` shift || fromVPtr vaddr `~shiftR~` pageBits);
        doMachineOp $ invalidateTranslationSingle vpn
    od)
od)"

defs doFlush_def:
"doFlush flushType vstart vend pstart \<equiv>
    (case flushType of
          Clean \<Rightarrow>   cleanCacheRange_RAM vstart vend pstart
        | Invalidate \<Rightarrow>   invalidateCacheRange_RAM vstart vend pstart
        | CleanInvalidate \<Rightarrow>   cleanInvalidateCacheRange_RAM vstart vend pstart
        | Unify \<Rightarrow>   (do
                               cleanCacheRange_PoU vstart vend pstart;
                               dsb;
                               invalidateCacheRange_I vstart vend pstart;
                               branchFlushRange vstart vend pstart;
                               isb
        od)
        )"

defs deleteASIDPool_def:
"deleteASIDPool base ptr\<equiv> (do
    haskell_assert (base && mask asidLowBits = 0)
        [];
    asidTable \<leftarrow> gets (armKSASIDTable \<circ> ksArchState);
    when (asidTable (asidHighBitsOf base) = Just ptr) $ (do
 pool \<leftarrow> liftM (inv ASIDPool) $  getObject ptr;
        forM [0  .e.  bit asidLowBits - 1] (\<lambda> offset. (
            when (isJust $ pool offset) $ (do
                invalidateTLBByASID $ base + offset;
                invalidateASIDEntry $ base + offset
            od)
        ));
        asidTable' \<leftarrow> return ( asidTable aLU [(asidHighBitsOf base, Nothing)]);
        modify (\<lambda> s. s \<lparr>
            ksArchState := (ksArchState s) \<lparr> armKSASIDTable := asidTable' \<rparr>\<rparr>);
        tcb \<leftarrow> getCurThread;
        setVMRoot tcb
    od)
od)"

defs deleteASID_def:
"deleteASID asid pt\<equiv> (do
    maybePoolPtr \<leftarrow> getPoolPtr asid;
    (case maybePoolPtr of
          None \<Rightarrow>   return ()
        | Some poolPtr \<Rightarrow>   (do
 pool \<leftarrow> liftM (inv ASIDPool) $  getObject poolPtr;
            maybeEntry \<leftarrow> return ( pool (asid && mask asidLowBits));
            maybeRoot \<leftarrow> return ( maybe Nothing (Just \<circ> apVSpace) maybeEntry);
            when (maybeRoot = Just pt) $ (do
                invalidateTLBByASID asid;
                invalidateASIDEntry asid;
 pool \<leftarrow> liftM (inv ASIDPool) $  getObject poolPtr;
                pool' \<leftarrow> return ( pool aLU [(asid && mask asidLowBits, Nothing)]);
                setObject poolPtr $ ASIDPool pool';
                tcb \<leftarrow> getCurThread;
                setVMRoot tcb
            od)
        od)
        )
od)"

defs unmapPageTable_def:
"unmapPageTable asid vaddr pt\<equiv> ignoreFailure $ (doE
    topLevelPT \<leftarrow> findVSpaceForASID asid;
    ptSlot \<leftarrow> lookupPTFromLevel maxPTLevel topLevelPT vaddr pt;
    withoutFailure $ storePTE ptSlot InvalidPTE;
    withoutFailure $ doMachineOp $ cleanByVA_PoU (VPtr $ fromPPtr ptSlot) (addrFromPPtr ptSlot);
    withoutFailure $ invalidateTLBByASID asid
odE)"

defs checkMappingPPtr_def:
"checkMappingPPtr pptr pte \<equiv>
    (case pte of
          PagePTE addr _ _ _ _ _ \<Rightarrow>  
            unlessE (addr = addrFromPPtr pptr) $ throw InvalidRoot
        | _ \<Rightarrow>   throw InvalidRoot
        )"

defs unmapPage_def:
"unmapPage magnitude asid vptr pptr\<equiv> ignoreFailure $ (doE
    vspace \<leftarrow> findVSpaceForASID asid;
    (bitsLeft, slot) \<leftarrow> withoutFailure $ lookupPTSlot vspace vptr;
    unlessE (bitsLeft = pageBitsForSize magnitude) $ throw InvalidRoot;
    pte \<leftarrow> withoutFailure $ getObject slot;
    checkMappingPPtr pptr pte;
    withoutFailure $ storePTE slot InvalidPTE;
    withoutFailure $ doMachineOp $ cleanByVA_PoU (VPtr $ fromPPtr slot) (addrFromPPtr slot);
    withoutFailure $ invalidateTLBByASIDVA asid vptr
odE)"

defs armContextSwitch_def:
"armContextSwitch vspace asid\<equiv> (do
    vmID \<leftarrow> getVMID asid;
    doMachineOp $ setVSpaceRoot (addrFromPPtr vspace) (fromIntegral vmID)
od)"

defs setGlobalUserVSpace_def:
"setGlobalUserVSpace\<equiv> (do
    globalUserVSpace \<leftarrow> gets (armKSGlobalUserVSpace \<circ> ksArchState);
    doMachineOp $ setVSpaceRoot (addrFromKPPtr globalUserVSpace) 0
od)"

defs setVMRoot_def:
"setVMRoot tcb\<equiv> (do
    threadRootSlot \<leftarrow> getThreadVSpaceRoot tcb;
    threadRoot \<leftarrow> getSlotCap threadRootSlot;
    haskell_assert (isValidVTableRoot threadRoot \<or> threadRoot = NullCap)
           [];
    catchFailure
        ((case threadRoot of
              ArchObjectCap (PageTableCap vspaceRoot VSRootPT_T (Some (asid, _))) \<Rightarrow>   (doE
                vspaceRoot' \<leftarrow> findVSpaceForASID asid;
                whenE (vspaceRoot \<noteq> vspaceRoot') $ throw InvalidRoot;
                withoutFailure $ armContextSwitch vspaceRoot asid
              odE)
            | _ \<Rightarrow>   throw InvalidRoot)
            )
        (\<lambda> _. setGlobalUserVSpace)
od)"

defs storeVMID_def:
"storeVMID asid vmid\<equiv> (do
    updateASIDPoolEntry (\<lambda> entry. Just $ entry \<lparr> apVMID := Just vmid \<rparr>) asid;
    vmidTable \<leftarrow> gets (armKSVMIDTable \<circ> ksArchState);
    vmidTable' \<leftarrow> return ( vmidTable aLU [(vmid, Just asid)]);
    modify (\<lambda> s. s \<lparr>
        ksArchState := (ksArchState s)
        \<lparr> armKSVMIDTable := vmidTable' \<rparr>\<rparr>)
od)"

defs loadVMID_def:
"loadVMID asid\<equiv> (do
    maybeEntry \<leftarrow> getASIDPoolEntry asid;
    (case maybeEntry of
          Some (ASIDPoolVSpace vmID ptr) \<Rightarrow>   return vmID
        | _ \<Rightarrow>   haskell_fail []
        )
od)"

defs invalidateASID_def:
"invalidateASID\<equiv> updateASIDPoolEntry (\<lambda> entry. Just $ entry \<lparr> apVMID := Nothing \<rparr>)"

defs invalidateVMIDEntry_def:
"invalidateVMIDEntry vmid\<equiv> (do
    vmidTable \<leftarrow> gets (armKSVMIDTable \<circ> ksArchState);
    vmidTable' \<leftarrow> return ( vmidTable aLU [(vmid, Nothing)]);
    modify (\<lambda> s. s \<lparr>
        ksArchState := (ksArchState s)
        \<lparr> armKSVMIDTable := vmidTable' \<rparr>\<rparr>)
od)"

defs invalidateASIDEntry_def:
"invalidateASIDEntry asid\<equiv> (do
    maybeVMID \<leftarrow> loadVMID asid;
    when (isJust maybeVMID) $ invalidateVMIDEntry (fromJust maybeVMID);
    invalidateASID asid
od)"

defs findFreeVMID_def:
"findFreeVMID\<equiv> (do
    vmidTable \<leftarrow> gets (armKSVMIDTable \<circ> ksArchState);
    nextVMID \<leftarrow> gets (armKSNextVMID \<circ> ksArchState);
    maybeVMID \<leftarrow> return ( find (\<lambda> a. isNothing (vmidTable a))
                    ([nextVMID  .e.  maxBound] @ init [minBound  .e.  nextVMID]));
    (case maybeVMID of
          Some vmid \<Rightarrow>   return vmid
        | None \<Rightarrow>   (do
            invalidateASID $ fromJust $ vmidTable nextVMID;
            doMachineOp $ invalidateTranslationASID $ fromIntegral nextVMID;
            invalidateVMIDEntry nextVMID;
            new_nextVMID \<leftarrow> return ( if nextVMID = maxBound then minBound else nextVMID + 1);
            modify (\<lambda> s. s \<lparr> ksArchState := (ksArchState s) \<lparr> armKSNextVMID := new_nextVMID \<rparr>\<rparr>);
            return nextVMID
        od)
        )
od)"

defs getVMID_def:
"getVMID asid\<equiv> (do
    maybeVMID \<leftarrow> loadVMID asid;
    (case maybeVMID of
          Some vmid \<Rightarrow>  
            return vmid
        | None \<Rightarrow>   (do
            newVMID \<leftarrow> findFreeVMID;
            storeVMID asid newVMID;
            return newVMID
        od)
        )
od)"

defs isVTableRoot_def:
"isVTableRoot x0\<equiv> (case x0 of
    (ArchObjectCap (PageTableCap _ VSRootPT_T _)) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs isValidVTableRoot_def:
"isValidVTableRoot cap\<equiv> isVTableRoot cap \<and> isJust (capPTMappedAddress (capCap cap))"

defs checkVSpaceRoot_def:
"checkVSpaceRoot vspaceCap argNo \<equiv>
    (case vspaceCap of
          ArchObjectCap (PageTableCap vspace _ (Some (asid, _))) \<Rightarrow>   returnOk (vspace, asid)
        | _ \<Rightarrow>   throw $ InvalidCapability argNo
        )"

defs checkValidIPCBuffer_def:
"checkValidIPCBuffer vptr x1\<equiv> (case x1 of
    (ArchObjectCap (FrameCap _ _ _ False _)) \<Rightarrow>    (doE
    whenE (vptr && mask ipcBufferSizeBits \<noteq> 0) $ throw AlignmentError;
    returnOk ()
    odE)
  | _ \<Rightarrow>    throw IllegalOperation
  )"

defs maskVMRights_def:
"maskVMRights r m\<equiv> (case (r, capAllowRead m, capAllowWrite m) of
      (VMReadOnly, True, _) \<Rightarrow>   VMReadOnly
    | (VMReadWrite, True, False) \<Rightarrow>   VMReadOnly
    | (VMReadWrite, True, True) \<Rightarrow>   VMReadWrite
    | _ \<Rightarrow>   VMKernelOnly
    )"

defs attribsFromWord_def:
"attribsFromWord w \<equiv> VMAttributes_ \<lparr>
    armExecuteNever= w !! 2,
    armPageCacheable= w !! 0 \<rparr>"

defs makeUserPTE_def:
"makeUserPTE baseAddr rights attrs vmSize \<equiv>
    PagePTE_ \<lparr>
        pteBaseAddress= baseAddr,
        pteSmallPage= vmSize= ARMSmallPage,
        pteGlobal= False,
        pteExecuteNever= armExecuteNever attrs,
        pteDevice= Not (armPageCacheable attrs),
        pteRights= rights \<rparr>"

defs checkVPAlignment_def:
"checkVPAlignment sz w \<equiv>
    unlessE (w && mask (pageBitsForSize sz) = 0) $ throw AlignmentError"

defs labelToFlushType_def:
"labelToFlushType label\<equiv> (case invocationType label of
        ArchInvocationLabel ARMVSpaceClean_Data \<Rightarrow>   Clean
      | ArchInvocationLabel ARMPageClean_Data \<Rightarrow>   Clean
      | ArchInvocationLabel ARMVSpaceInvalidate_Data \<Rightarrow>   Invalidate
      | ArchInvocationLabel ARMPageInvalidate_Data \<Rightarrow>   Invalidate
      | ArchInvocationLabel ARMVSpaceCleanInvalidate_Data \<Rightarrow>   CleanInvalidate
      | ArchInvocationLabel ARMPageCleanInvalidate_Data \<Rightarrow>   CleanInvalidate
      | ArchInvocationLabel ARMVSpaceUnify_Instruction \<Rightarrow>   Unify
      | ArchInvocationLabel ARMPageUnify_Instruction \<Rightarrow>   Unify
      | _ \<Rightarrow>   error []
      )"

defs pageBase_def:
"pageBase vaddr magnitude\<equiv> vaddr && (complement $ mask magnitude)"

defs checkValidMappingSize_def:
"checkValidMappingSize arg1 \<equiv> return ()"

defs decodeARMFrameInvocationMap_def:
"decodeARMFrameInvocationMap cte cap vptr rightsMask attr vspaceCap\<equiv> (doE
    attributes \<leftarrow> returnOk ( attribsFromWord attr);
    frameSize \<leftarrow> returnOk ( capFSize cap);
    vmRights \<leftarrow> returnOk ( maskVMRights (capFVMRights cap) $ rightsFromWord rightsMask);
    (vspace,asid) \<leftarrow> checkVSpaceRoot vspaceCap 1;
    vspaceCheck \<leftarrow> lookupErrorOnFailure False $ findVSpaceForASID asid;
    whenE (vspaceCheck \<noteq> vspace) $ throw $ InvalidCapability 1;
    checkVPAlignment frameSize vptr;
    pgBits \<leftarrow> returnOk ( pageBitsForSize frameSize);
    (case capFMappedAddress cap of
          Some (asid', vaddr') \<Rightarrow>   (doE
            whenE (asid' \<noteq> asid) $ throw $ InvalidCapability 0;
            whenE (vaddr' \<noteq> vptr) $ throw $ InvalidArgument 2
          odE)
        | None \<Rightarrow>   (doE
            vtop \<leftarrow> returnOk ( vptr + (bit pgBits - 1));
            whenE (vtop > pptrUserTop) $ throw $ InvalidArgument 0
        odE)
        );
    (bitsLeft, slot) \<leftarrow> withoutFailure $ lookupPTSlot vspace vptr;
    unlessE (bitsLeft = pgBits) $ throw $ FailedLookup False $ MissingCapability bitsLeft;
    base \<leftarrow> returnOk ( addrFromPPtr (capFBasePtr cap));
    returnOk $ InvokePage $ PageMap_ \<lparr>
        pageMapCap= cap \<lparr> capFMappedAddress:= Just (asid,vptr) \<rparr>,
        pageMapCTSlot= cte,
        pageMapEntries= (makeUserPTE base vmRights attributes frameSize, slot) \<rparr>
odE)"

defs decodeARMFrameInvocationFlush_def:
"decodeARMFrameInvocationFlush label args cap\<equiv> (case (args, capFMappedAddress cap) of
      (start#end#_, Some (asid, vaddr)) \<Rightarrow>   (doE
        vspaceRoot \<leftarrow> lookupErrorOnFailure False $ findVSpaceForASID asid;
        whenE (end \<le> start) $ throw $ InvalidArgument 1;
        pageSize \<leftarrow> returnOk ( bit (pageBitsForSize (capFSize cap)));
        whenE (start \<ge> pageSize \<or> end > pageSize) $ throw $ InvalidArgument 0;
        pageBase \<leftarrow> returnOk ( addrFromPPtr $ capFBasePtr cap);
        pstart \<leftarrow> returnOk ( pageBase + toPAddr start);
        whenE (pstart < paddrBase \<or> ((end - start) + fromPAddr pstart > fromPAddr paddrTop)) $
            throw IllegalOperation;
        returnOk $ InvokePage $ PageFlush_ \<lparr>
              pageFlushType= labelToFlushType label,
              pageFlushStart= VPtr $ fromVPtr vaddr + start,
              pageFlushEnd= VPtr $ fromVPtr vaddr + end - 1,
              pageFlushPStart= pstart,
              pageFlushSpace= vspaceRoot,
              pageFlushASID= asid \<rparr>
      odE)
    | (_#_#_, None) \<Rightarrow>   throw IllegalOperation
    | _ \<Rightarrow>   throw TruncatedMessage
    )"

defs decodeARMFrameInvocation_def:
"decodeARMFrameInvocation label args cte x3 extraCaps\<equiv> (let cap = x3 in
  if isFrameCap cap
  then  
    (case (invocationType label, args, extraCaps) of
          (ArchInvocationLabel ARMPageMap, vaddr#rightsMask#attr#_, (vspaceCap,_)#_) \<Rightarrow>   (
            decodeARMFrameInvocationMap cte cap (VPtr vaddr) rightsMask attr vspaceCap
          )
        | (ArchInvocationLabel ARMPageMap, _, _) \<Rightarrow>   throw TruncatedMessage
        | (ArchInvocationLabel ARMPageUnmap, _, _) \<Rightarrow>  
            returnOk $ InvokePage $ PageUnmap_ \<lparr>
                pageUnmapCap= cap,
                pageUnmapCapSlot= cte \<rparr>
        | (ArchInvocationLabel ARMPageGetAddress, _, _) \<Rightarrow>  
            returnOk $ InvokePage $ PageGetAddr (capFBasePtr cap)
        | (ArchInvocationLabel ARMPageClean_Data, _, _) \<Rightarrow>  
            decodeARMFrameInvocationFlush label args cap
        | (ArchInvocationLabel ARMPageInvalidate_Data, _, _) \<Rightarrow>  
            decodeARMFrameInvocationFlush label args cap
        | (ArchInvocationLabel ARMPageCleanInvalidate_Data, _, _) \<Rightarrow>  
            decodeARMFrameInvocationFlush label args cap
        | (ArchInvocationLabel ARMPageUnify_Instruction, _, _) \<Rightarrow>  
            decodeARMFrameInvocationFlush label args cap
        | _ \<Rightarrow>   throw IllegalOperation
        )
  else   haskell_fail []
  )"

defs decodeARMPageTableInvocationMap_def:
"decodeARMPageTableInvocationMap cte cap vptr attr vspaceCap\<equiv> (doE
    whenE (isJust $ capPTMappedAddress cap) $ throw $ InvalidCapability 0;
    (vspace,asid) \<leftarrow> checkVSpaceRoot vspaceCap 1;
    whenE (vptr > pptrUserTop) $ throw $ InvalidArgument 0;
    vspaceCheck \<leftarrow> lookupErrorOnFailure False $ findVSpaceForASID asid;
    whenE (vspaceCheck \<noteq> vspace) $ throw $ InvalidCapability 1;
    (bitsLeft, slot) \<leftarrow> withoutFailure $ lookupPTSlot vspace vptr;
    oldPTE \<leftarrow> withoutFailure $ getObject slot;
    whenE (bitsLeft = pageBits \<or> oldPTE \<noteq> InvalidPTE) $ throw DeleteFirst;
    pte \<leftarrow> returnOk ( PageTablePTE_ \<lparr>
            ptePPN= addrFromPPtr (capPTBasePtr cap) `~shiftR~` pageBits \<rparr>);
    vptr \<leftarrow> returnOk ( vptr && complement (mask bitsLeft));
    returnOk $ InvokePageTable $ PageTableMap_ \<lparr>
        ptMapCap= ArchObjectCap $ cap \<lparr> capPTMappedAddress:= Just (asid, vptr) \<rparr>,
        ptMapCTSlot= cte,
        ptMapPTE= pte,
        ptMapPTSlot= slot \<rparr>
odE)"

defs decodeARMPageTableInvocation_def:
"decodeARMPageTableInvocation label args cte x3 extraCaps\<equiv> (let cap = x3 in
  if isPageTableCap cap
  then  
   (case (invocationType label, args, extraCaps) of
          (ArchInvocationLabel ARMPageTableMap, vaddr#attr#_, (vspaceCap,_)#_) \<Rightarrow>   (
            decodeARMPageTableInvocationMap cte cap (VPtr vaddr) attr vspaceCap
          )
        | (ArchInvocationLabel ARMPageTableMap, _, _) \<Rightarrow>   throw TruncatedMessage
        | (ArchInvocationLabel ARMPageTableUnmap, _, _) \<Rightarrow>   (doE
            cteVal \<leftarrow> withoutFailure $ getCTE cte;
            final \<leftarrow> withoutFailure $ isFinalCapability cteVal;
            unlessE final $ throw RevokeFirst;
            returnOk $ InvokePageTable $ PageTableUnmap_ \<lparr>
                ptUnmapCap= cap,
                ptUnmapCapSlot= cte \<rparr>
        odE)
        | _ \<Rightarrow>   throw IllegalOperation
        )
  else   haskell_fail []
  )"

defs decodeARMVSpaceInvocation_def:
"decodeARMVSpaceInvocation label args x2\<equiv> (let cap = x2 in
  if isPageTableCap cap \<and> capPTType cap = VSRootPT_T
  then  
    (case (isVSpaceFlushLabel (invocationType label), args) of
          (True, start#end#_) \<Rightarrow>   (doE
            whenE (end \<le> start) $ throw $ InvalidArgument 1;
            whenE (VPtr end > pptrUserTop) $ throw IllegalOperation;
            (vspaceRoot, asid) \<leftarrow> checkVSpaceRoot (ArchObjectCap cap) 0;
            ptCheck \<leftarrow> lookupErrorOnFailure False $ findVSpaceForASID asid;
            whenE (ptCheck \<noteq> vspaceRoot) $ throw $ InvalidCapability 0;
            frameInfo \<leftarrow> withoutFailure $ lookupFrame (capPTBasePtr cap) (VPtr start);
            (case frameInfo of
                  None \<Rightarrow>   returnOk $ InvokeVSpace VSpaceNothing
                | Some (bitsLeft, pAddr) \<Rightarrow>   (doE
                    withoutFailure $ checkValidMappingSize bitsLeft;
                    baseStart \<leftarrow> returnOk ( pageBase (VPtr start) bitsLeft);
                    baseEnd \<leftarrow> returnOk ( pageBase (VPtr end - 1) bitsLeft);
                    whenE (baseStart \<noteq> baseEnd) $
                        throw $ RangeError start $ fromVPtr $ baseStart + mask bitsLeft;
                    offset \<leftarrow> returnOk ( start && mask bitsLeft);
                    pStart \<leftarrow> returnOk ( pAddr + toPAddr offset);
                    returnOk $ InvokeVSpace $ VSpaceFlush_ \<lparr>
                         vsFlushType= labelToFlushType label,
                         vsFlushStart= VPtr start,
                         vsFlushEnd= VPtr end - 1,
                         vsFlushPStart= pStart,
                         vsFlushSpace= vspaceRoot,
                         vsFlushASID= asid \<rparr>
                odE)
                )
          odE)
        | (True, _) \<Rightarrow>   throw TruncatedMessage
        | _ \<Rightarrow>   throw IllegalOperation
        )
  else   haskell_fail []
  )"

defs decodeARMASIDControlInvocation_def:
"decodeARMASIDControlInvocation label args x2 extraCaps\<equiv> (case x2 of
    ASIDControlCap \<Rightarrow>   
    (case (invocationType label, args, extraCaps) of
          (ArchInvocationLabel ARMASIDControlMakePool, index#depth#_, (untyped,parentSlot)#(croot,_)#_) \<Rightarrow>   (doE
            asidTable \<leftarrow> withoutFailure $ gets (armKSASIDTable \<circ> ksArchState);
            free \<leftarrow> returnOk ( filter (\<lambda> (x,y). x \<le> (1 `~shiftL~` asidHighBits) - 1 \<and> isNothing y) $ assocs asidTable);
            whenE (null free) $ throw DeleteFirst;
            base \<leftarrow> returnOk ( (fst $ head free) `~shiftL~` asidLowBits);
            pool \<leftarrow> returnOk ( makeObject ::asidpool);
            frame \<leftarrow> (let v46 = untyped in
                if isUntypedCap v46 \<and> capBlockSize v46 = objBits pool \<and> \<not> capIsDevice v46
                then  (doE
                    ensureNoChildren parentSlot;
                    returnOk $ capPtr untyped
                odE)
                else  throw $ InvalidCapability 1
                );
            destSlot \<leftarrow> lookupTargetSlot croot (CPtr index) (fromIntegral depth);
            ensureEmptySlot destSlot;
            returnOk $ InvokeASIDControl $ MakePool_ \<lparr>
                makePoolFrame= frame,
                makePoolSlot= destSlot,
                makePoolParent= parentSlot,
                makePoolBase= base \<rparr>
          odE)
        | (ArchInvocationLabel ARMASIDControlMakePool, _, _) \<Rightarrow>   throw TruncatedMessage
        | _ \<Rightarrow>   throw IllegalOperation
        )
  | _ \<Rightarrow>    haskell_fail []
  )"

defs decodeARMASIDPoolInvocation_def:
"decodeARMASIDPoolInvocation label x1 extraCaps\<equiv> (let cap = x1 in
  if isASIDPoolCap cap
  then  
    (case (invocationType label, extraCaps) of
          (ArchInvocationLabel ARMASIDPoolAssign, (vspaceCap,vspaceCapSlot)#_) \<Rightarrow>  
            (case vspaceCap of
                  ArchObjectCap (PageTableCap _ _ None) \<Rightarrow>   (doE
                    whenE (Not (isVTableRoot vspaceCap)) $
                        throw $ InvalidCapability 1;
                    asidTable \<leftarrow> withoutFailure $ gets (armKSASIDTable \<circ> ksArchState);
                    base \<leftarrow> returnOk ( capASIDBase cap);
                    poolPtr \<leftarrow> returnOk ( asidTable (asidHighBitsOf base));
                    whenE (isNothing poolPtr) $ throw $ FailedLookup False InvalidRoot;
 p \<leftarrow> liftME the $  returnOk ( poolPtr);
                    whenE (p \<noteq> capASIDPool cap) $ throw $ InvalidCapability 0;
 pool \<leftarrow> liftME (inv ASIDPool) $  withoutFailure $ getObject $ p;
                    free \<leftarrow> returnOk ( filter (\<lambda> (x,y). x \<le>  (1 `~shiftL~` asidLowBits) - 1
                                                 \<and> x + base \<noteq> 0 \<and> isNothing y) $ assocs pool);
                    whenE (null free) $ throw DeleteFirst;
                    asid \<leftarrow> returnOk ( fst $ head free);
                    returnOk $ InvokeASIDPool $ Assign_ \<lparr>
                        assignASID= asid + base,
                        assignASIDPool= capASIDPool cap,
                        assignASIDCTSlot= vspaceCapSlot \<rparr>
                  odE)
                | _ \<Rightarrow>   throw $ InvalidCapability 1
                )
        | (ArchInvocationLabel ARMASIDPoolAssign, _) \<Rightarrow>   throw TruncatedMessage
        | _ \<Rightarrow>   throw IllegalOperation
        )
  else   haskell_fail []
  )"

defs decodeARMMMUInvocation_def:
"decodeARMMMUInvocation label args x2 cte x4 extraCaps\<equiv> (let cap = x4 in
  if isFrameCap cap
  then  
    decodeARMFrameInvocation label args cte cap extraCaps
  else if isPageTableCap cap \<and> capPTType cap = NormalPT_T
  then  
    decodeARMPageTableInvocation label args cte cap extraCaps
  else if isPageTableCap cap \<and> capPTType cap = VSRootPT_T
  then  
    decodeARMVSpaceInvocation label args cap
  else if isASIDControlCap cap
  then  
    decodeARMASIDControlInvocation label args cap extraCaps
  else if isASIDPoolCap cap
  then  
    decodeARMASIDPoolInvocation label cap extraCaps
  else if isVCPUCap cap
  then   haskell_fail []
  else undefined
  )"

defs performVSpaceInvocation_def:
"performVSpaceInvocation x0\<equiv> (case x0 of
    VSpaceNothing \<Rightarrow>    return ()
  | (VSpaceFlush flushType vstart vend pstart space asid) \<Rightarrow>    (do
    start \<leftarrow> return ( VPtr $ fromPPtr $ ptrFromPAddr pstart);
    end \<leftarrow> return ( start + (vend - vstart));
    when (start < end) $ (
        doMachineOp $ doFlush flushType start end pstart
    )
  od)
  )"

defs performPageTableInvocation_def:
"performPageTableInvocation x0\<equiv> (case x0 of
    (PageTableMap cap ctSlot pte ptSlot) \<Rightarrow>    (do
    updateCap ctSlot cap;
    storePTE ptSlot pte;
    doMachineOp $ cleanByVA_PoU (VPtr $ fromPPtr ptSlot) (addrFromPPtr ptSlot)
    od)
  | (PageTableUnmap cap slot) \<Rightarrow>    (do
    (case capPTMappedAddress cap of
          Some (asid, vaddr) \<Rightarrow>   (do
            ptr \<leftarrow> return ( capPTBasePtr cap);
            unmapPageTable asid vaddr ptr;
            slots \<leftarrow> return ( [ptr, ptr + bit pteBits  .e.  ptr + bit (ptBits (capPTType cap)) - 1]);
            mapM_x (flip storePTE InvalidPTE) slots
          od)
        | _ \<Rightarrow>   return ()
        );
 cap \<leftarrow> liftM capCap $  getSlotCap slot;
    updateCap slot (ArchObjectCap $ cap \<lparr> capPTMappedAddress := Nothing \<rparr>)
  od)
  )"

defs performPageInvocation_def:
"performPageInvocation x0\<equiv> (case x0 of
    (PageMap cap ctSlot (pte,slot)) \<Rightarrow>    (do
    oldPte \<leftarrow> getObject slot;
    tlbFlushRequired \<leftarrow> return ( oldPte \<noteq> InvalidPTE);
    updateCap ctSlot (ArchObjectCap cap);
    storePTE slot pte;
    doMachineOp $ cleanByVA_PoU (VPtr $ fromPPtr slot) (addrFromPPtr slot);
    when tlbFlushRequired $ (do
        (asid, vaddr) \<leftarrow> return $ fromJust $ capFMappedAddress cap;
        invalidateTLBByASIDVA asid vaddr
    od)
    od)
  | (PageUnmap cap ctSlot) \<Rightarrow>    (do
    (case capFMappedAddress cap of
          Some (asid, vaddr) \<Rightarrow>   unmapPage (capFSize cap) asid vaddr (capFBasePtr cap)
        | _ \<Rightarrow>   return ()
        );
 cap \<leftarrow> liftM capCap $  getSlotCap ctSlot;
    updateCap ctSlot (ArchObjectCap $ cap \<lparr> capFMappedAddress := Nothing \<rparr>)
  od)
  | (PageGetAddr ptr) \<Rightarrow>    (do
    paddr \<leftarrow> return ( fromPAddr $ addrFromPPtr ptr);
    ct \<leftarrow> getCurThread;
    msgTransferred \<leftarrow> setMRs ct Nothing [paddr];
    msgInfo \<leftarrow> return $ MI_ \<lparr>
            msgLength= msgTransferred,
            msgExtraCaps= 0,
            msgCapsUnwrapped= 0,
            msgLabel= 0 \<rparr>;
    setMessageInfo ct msgInfo
  od)
  | (PageFlush flushType vstart vend pstart space asid) \<Rightarrow>    (do
    start \<leftarrow> return ( VPtr $ fromPPtr $ ptrFromPAddr pstart);
    end \<leftarrow> return ( start + (vend - vstart));
    when (start < end) $ (
        doMachineOp $ doFlush flushType start end pstart
    )
  od)
  )"

defs performASIDControlInvocation_def:
"performASIDControlInvocation x0\<equiv> (case x0 of
    (MakePool frame slot parent base) \<Rightarrow>    (do
    deleteObjects frame pageBits;
    pcap \<leftarrow> getSlotCap parent;
    updateFreeIndex parent (maxFreeIndex (capBlockSize pcap));
    placeNewObject frame (makeObject ::asidpool) 0;
    poolPtr \<leftarrow> return ( PPtr $ fromPPtr frame);
    cteInsert (ArchObjectCap $ ASIDPoolCap poolPtr base) parent slot;
    haskell_assert (base && mask asidLowBits = 0)
        [];
    asidTable \<leftarrow> gets (armKSASIDTable \<circ> ksArchState);
    asidTable' \<leftarrow> return ( asidTable aLU [(asidHighBitsOf base, Just poolPtr)]);
    modify (\<lambda> s. s \<lparr>
        ksArchState := (ksArchState s) \<lparr> armKSASIDTable := asidTable' \<rparr>\<rparr>)
    od)
  )"

defs performASIDPoolInvocation_def:
"performASIDPoolInvocation x0\<equiv> (case x0 of
    (Assign asid poolPtr ctSlot) \<Rightarrow>    (do
    oldcap \<leftarrow> getSlotCap ctSlot;
 cap \<leftarrow> liftM capCap $  return ( oldcap);
    updateCap ctSlot (ArchObjectCap $ cap \<lparr> capPTMappedAddress := Just (asid,0) \<rparr>);
 pool \<leftarrow> liftM (inv ASIDPool) $  getObject poolPtr;
    pool' \<leftarrow> return ( pool aLU [(asid && mask asidLowBits,
                        Just $ ASIDPoolVSpace Nothing $ capPTBasePtr cap)]);
    setObject poolPtr $ ASIDPool pool'
    od)
  )"

defs performARMMMUInvocation_def:
"performARMMMUInvocation i\<equiv> withoutPreemption $ (do
    (case i of
          InvokeVSpace oper \<Rightarrow>   performVSpaceInvocation oper
        | InvokePageTable oper \<Rightarrow>   performPageTableInvocation oper
        | InvokePage oper \<Rightarrow>   performPageInvocation oper
        | InvokeASIDControl oper \<Rightarrow>   performASIDControlInvocation oper
        | InvokeASIDPool oper \<Rightarrow>   performASIDPoolInvocation oper
        | InvokeVCPU v54 \<Rightarrow>   haskell_fail []
        );
    return $ []
od)"

defs storePTE_def:
"storePTE slot pte\<equiv> (
    setObject slot pte
)"

defs mapKernelWindow_def:
"mapKernelWindow \<equiv> error []"

defs activateGlobalVSpace_def:
"activateGlobalVSpace \<equiv> error []"

defs createIPCBufferFrame_def:
"createIPCBufferFrame \<equiv> error []"

defs createBIFrame_def:
"createBIFrame \<equiv> error []"

defs createFramesOfRegion_def:
"createFramesOfRegion \<equiv> error []"

defs createITPDPTs_def:
"createITPDPTs  \<equiv> error []"

defs writeITPDPTs_def:
"writeITPDPTs  \<equiv> error []"

defs createITASIDPool_def:
"createITASIDPool  \<equiv> error []"

defs writeITASIDPool_def:
"writeITASIDPool  \<equiv> error []"

defs createDeviceFrames_def:
"createDeviceFrames  \<equiv> error []"

defs vptrFromPPtr_def:
"vptrFromPPtr  \<equiv> error []"


end

end
