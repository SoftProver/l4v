(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file ArchVSpace_H.thy *)
(*
 * Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

(*
  VSpace lookup code.
*)

theory ArchVSpace_H
imports
  CNode_H
  Untyped_H
  KI_Decls_H
  ArchVSpaceDecls_H
begin

context Arch begin global_naming RISCV64_H

defs isPageTablePTE_def:
"isPageTablePTE x0\<equiv> (case x0 of
    (PageTablePTE _ _) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs getPPtrFromHWPTE_def:
"getPPtrFromHWPTE pte\<equiv> ptrFromPAddr (ptePPN pte `~shiftL~` ptBits)"

defs ptBitsLeft_def:
"ptBitsLeft level \<equiv> ptTranslationBits * level + pageBits"

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
       checkPTAt (getPPtrFromHWPTE pte);
       lookupPTSlotFromLevel (level - 1) (getPPtrFromHWPTE pte) vPtr
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
    ptr <- returnOk (getPPtrFromHWPTE pte);
    if ptr = targetPtPtr
        then returnOk slot
        else doE
          liftE $ checkPTAt ptr;
          lookupPTFromLevel (level - 1) ptr vPtr targetPtPtr
        odE
  odE"

defs ipcBufferSizeBits_def:
"ipcBufferSizeBits \<equiv> 10"

defs copyGlobalMappings_def:
"copyGlobalMappings newPT\<equiv> (do
    globalPT \<leftarrow> gets (riscvKSGlobalPT \<circ> ksArchState);
    base \<leftarrow> return ( ptIndex maxPTLevel pptrBase);
    ptSize \<leftarrow> return ( 1 `~shiftL~` ptTranslationBits);
    forM_x [base  .e.  ptSize - 1] (\<lambda> index. (do
        offset \<leftarrow> return ( PPtr index `~shiftL~` pteBits);
        pte \<leftarrow> getObject $ globalPT + offset;
        storePTE (newPT + offset) pte
    od))
od)"

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

defs findVSpaceForASID_def:
"findVSpaceForASID asid\<equiv> (doE
    haskell_assertE (asid > 0) [];
    haskell_assertE (asid \<le> snd asidRange) [];
    asidTable \<leftarrow> withoutFailure $ gets (riscvKSASIDTable \<circ> ksArchState);
    poolPtr \<leftarrow> returnOk ( asidTable (asidHighBitsOf asid));
 pool \<leftarrow> liftME (inv ASIDPool) $  (case poolPtr of
          Some ptr \<Rightarrow>   withoutFailure $ getObject ptr
        | None \<Rightarrow>   throw InvalidRoot
        );
    pm \<leftarrow> returnOk ( pool (asid && mask asidLowBits));
    (case pm of
          Some ptr \<Rightarrow>   (doE
            haskell_assertE (ptr \<noteq> 0) [];
            withoutFailure $ checkPTAt ptr;
            returnOk ptr
          odE)
        | None \<Rightarrow>   throw InvalidRoot
        )
odE)"

defs maybeVSpaceForASID_def:
"maybeVSpaceForASID asid \<equiv>
    liftME Just (findVSpaceForASID asid) `~catchFailure~` const (return Nothing)"

defs ptIndex_def:
"ptIndex level vPtr \<equiv>
    (fromVPtr vPtr `~shiftR~` ptBitsLeft level) && mask ptTranslationBits"

defs ptSlotIndex_def:
"ptSlotIndex level ptPtr vPtr \<equiv>
    ptPtr + PPtr (ptIndex level vPtr `~shiftL~` pteBits)"

defs lookupPTSlot_def:
"lookupPTSlot \<equiv> lookupPTSlotFromLevel maxPTLevel"

defs handleVMFault_def:
"handleVMFault thread f \<equiv>
    let
     loadf = (\<lambda>  a. ArchFault $ VMFault a [0, vmFaultTypeFSR RISCVLoadAccessFault]);
          storef = (\<lambda>  a. ArchFault $ VMFault a [0, vmFaultTypeFSR RISCVStoreAccessFault]);
          instrf = (\<lambda>  a. ArchFault $ VMFault a [1, vmFaultTypeFSR RISCVInstructionAccessFault])
    in
                                (doE
    w \<leftarrow> withoutFailure $ doMachineOp read_stval;
    addr \<leftarrow> returnOk ( VPtr w);
    (case f of
          RISCVLoadPageFault \<Rightarrow>   throw $ loadf addr
        | RISCVLoadAccessFault \<Rightarrow>   throw $ loadf addr
        | RISCVStorePageFault \<Rightarrow>   throw $ storef addr
        | RISCVStoreAccessFault \<Rightarrow>   throw $ storef addr
        | RISCVInstructionPageFault \<Rightarrow>   throw $ instrf addr
        | RISCVInstructionAccessFault \<Rightarrow>   throw $ instrf addr
        )
                                odE)"

defs deleteASIDPool_def:
"deleteASIDPool base ptr\<equiv> (do
    haskell_assert (base && mask asidLowBits = 0)
        [];
    asidTable \<leftarrow> gets (riscvKSASIDTable \<circ> ksArchState);
    when (asidTable (asidHighBitsOf base) = Just ptr) $ (do
 pool \<leftarrow> liftM (inv ASIDPool) $  getObject ptr;
        asidTable' \<leftarrow> return ( asidTable aLU [(asidHighBitsOf base, Nothing)]);
        modify (\<lambda> s. s \<lparr>
            ksArchState := (ksArchState s) \<lparr> riscvKSASIDTable := asidTable' \<rparr>\<rparr>);
        tcb \<leftarrow> getCurThread;
        setVMRoot tcb
    od)
od)"

defs deleteASID_def:
"deleteASID asid pt\<equiv> (do
    asidTable \<leftarrow> gets (riscvKSASIDTable \<circ> ksArchState);
    (case asidTable (asidHighBitsOf asid) of
          None \<Rightarrow>   return ()
        | Some poolPtr \<Rightarrow>   (do
 pool \<leftarrow> liftM (inv ASIDPool) $  getObject poolPtr;
            when (pool (asid && mask asidLowBits) = Just pt) $ (do
                doMachineOp $ hwASIDFlush (fromASID asid);
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
    withoutFailure $ doMachineOp sfence
odE)"

defs checkMappingPPtr_def:
"checkMappingPPtr pptr pte \<equiv>
    (case pte of
          PagePTE ppn _ _ _ _ \<Rightarrow>  
            unlessE (ptrFromPAddr (ppn `~shiftL~` ptBits) = pptr) $ throw InvalidRoot
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
    withoutFailure $ doMachineOp sfence
odE)"

defs setVMRoot_def:
"setVMRoot tcb\<equiv> (do
    threadRootSlot \<leftarrow> getThreadVSpaceRoot tcb;
    threadRoot \<leftarrow> getSlotCap threadRootSlot;
    haskell_assert (isValidVTableRoot threadRoot \<or> threadRoot = NullCap)
           [];
    catchFailure
        ((case threadRoot of
              ArchObjectCap (PageTableCap pt (Some (asid, _))) \<Rightarrow>   (doE
                pt' \<leftarrow> findVSpaceForASID asid;
                whenE (pt \<noteq> pt') $ throw InvalidRoot;
                withoutFailure $ doMachineOp $
                    setVSpaceRoot (addrFromPPtr pt) (fromASID asid)
              odE)
            | _ \<Rightarrow>   throw InvalidRoot)
            )
        (\<lambda> _. (do
            globalPT \<leftarrow> gets (riscvKSGlobalPT \<circ> ksArchState);
            doMachineOp $ setVSpaceRoot (addrFromKPPtr globalPT) 0
        od)
                                                                  )
od)"

defs checkValidIPCBuffer_def:
"checkValidIPCBuffer vptr x1\<equiv> (case x1 of
    (ArchObjectCap (FrameCap _ _ _ False _)) \<Rightarrow>    (doE
    whenE (vptr && mask ipcBufferSizeBits \<noteq> 0) $ throw AlignmentError;
    returnOk ()
    odE)
  | _ \<Rightarrow>    throw IllegalOperation
  )"

defs isValidVTableRoot_def:
"isValidVTableRoot x0\<equiv> (case x0 of
    (ArchObjectCap (PageTableCap _ (Some _))) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs maskVMRights_def:
"maskVMRights r m\<equiv> (case (r, capAllowRead m, capAllowWrite m) of
      (VMReadOnly, True, _) \<Rightarrow>   VMReadOnly
    | (VMReadWrite, True, False) \<Rightarrow>   VMReadOnly
    | (VMReadWrite, True, True) \<Rightarrow>   VMReadWrite
    | _ \<Rightarrow>   VMKernelOnly
    )"

defs attribsFromWord_def:
"attribsFromWord w \<equiv> VMAttributes_ \<lparr> riscvExecuteNever= w !! 0 \<rparr>"

defs makeUserPTE_def:
"makeUserPTE baseAddr executable rights \<equiv>
    if rights = VMKernelOnly \<and> Not executable
    then InvalidPTE
    else PagePTE_ \<lparr>
             ptePPN= baseAddr `~shiftR~` pageBits,
             pteGlobal= False,
             pteUser= True,
             pteExecute= executable,
             pteRights= rights \<rparr>"

defs checkVPAlignment_def:
"checkVPAlignment sz w \<equiv>
    unlessE (w && mask (pageBitsForSize sz) = 0) $ throw AlignmentError"

defs checkSlot_def:
"checkSlot slot test\<equiv> (doE
    pte \<leftarrow> withoutFailure $ getObject slot;
    unlessE (test pte) $ throw DeleteFirst
odE)"

defs decodeRISCVFrameInvocationMap_def:
"decodeRISCVFrameInvocationMap cte cap vptr rightsMask attr vspaceCap\<equiv> (doE
    (vspace,asid) \<leftarrow> (case vspaceCap of
          ArchObjectCap (PageTableCap vspace (Some (asid, _))) \<Rightarrow>   returnOk (vspace, asid)
        | _ \<Rightarrow>   throw $ InvalidCapability 1
        );
    vspaceCheck \<leftarrow> lookupErrorOnFailure False $ findVSpaceForASID asid;
    whenE (vspaceCheck \<noteq> vspace) $ throw $ InvalidCapability 1;
    pgBits \<leftarrow> returnOk ( pageBitsForSize $ capFSize cap);
    vtop \<leftarrow> returnOk ( vptr + (bit pgBits - 1));
    whenE (vtop \<ge> pptrUserTop) $ throw $ InvalidArgument 0;
    checkVPAlignment (capFSize cap) vptr;
    (bitsLeft, slot) \<leftarrow> withoutFailure $ lookupPTSlot vspace vptr;
    unlessE (bitsLeft = pgBits) $ throw $
        FailedLookup False $ MissingCapability bitsLeft;
    (case capFMappedAddress cap of
          Some (asid', vaddr') \<Rightarrow>   (doE
            whenE (asid' \<noteq> asid) $ throw $ InvalidCapability 1;
            whenE (vaddr' \<noteq> vptr) $ throw $ InvalidArgument 0;
            checkSlot slot (Not \<circ> isPageTablePTE)
          odE)
        | None \<Rightarrow>   checkSlot slot (\<lambda> pte.  pte = InvalidPTE)
        );
    vmRights \<leftarrow> returnOk ( maskVMRights (capFVMRights cap) $ rightsFromWord rightsMask);
    framePAddr \<leftarrow> returnOk ( addrFromPPtr (capFBasePtr cap));
    exec \<leftarrow> returnOk ( Not $ riscvExecuteNever (attribsFromWord attr));
    returnOk $ InvokePage $ PageMap_ \<lparr>
        pageMapCap= ArchObjectCap $ cap \<lparr> capFMappedAddress:= Just (asid,vptr) \<rparr>,
        pageMapCTSlot= cte,
        pageMapEntries= (makeUserPTE framePAddr exec vmRights, slot) \<rparr>
odE)"

defs decodeRISCVFrameInvocation_def:
"decodeRISCVFrameInvocation label args cte x3 extraCaps\<equiv> (let cap = x3 in
  if isFrameCap cap
  then  
    (case (invocationType label, args, extraCaps) of
          (ArchInvocationLabel RISCVPageMap, vaddr#rightsMask#attr#_, (vspaceCap,_)#_) \<Rightarrow>   (
            decodeRISCVFrameInvocationMap cte cap (VPtr vaddr) rightsMask attr vspaceCap
          )
        | (ArchInvocationLabel RISCVPageMap, _, _) \<Rightarrow>   throw TruncatedMessage
        | (ArchInvocationLabel RISCVPageUnmap, _, _) \<Rightarrow>  
            returnOk $ InvokePage $ PageUnmap_ \<lparr>
                pageUnmapCap= cap,
                pageUnmapCapSlot= cte \<rparr>
        | (ArchInvocationLabel RISCVPageGetAddress, _, _) \<Rightarrow>  
            returnOk $ InvokePage $ PageGetAddr (capFBasePtr cap)
        | _ \<Rightarrow>   throw IllegalOperation
        )
  else   haskell_fail []
  )"

defs decodeRISCVPageTableInvocationMap_def:
"decodeRISCVPageTableInvocationMap cte cap vptr attr vspaceCap\<equiv> (doE
    whenE (isJust $ capPTMappedAddress cap) $ throw $ InvalidCapability 0;
    (vspace,asid) \<leftarrow> (case vspaceCap of
          ArchObjectCap (PageTableCap vspace (Some (asid,_))) \<Rightarrow>   returnOk (vspace,asid)
        | _ \<Rightarrow>   throw $ InvalidCapability 1
        );
    whenE (vptr \<ge> pptrUserTop) $ throw $ InvalidArgument 0;
    vspaceCheck \<leftarrow> lookupErrorOnFailure False $ findVSpaceForASID asid;
    whenE (vspaceCheck \<noteq> vspace) $ throw $ InvalidCapability 1;
    (bitsLeft, slot) \<leftarrow> withoutFailure $ lookupPTSlot vspace vptr;
    oldPTE \<leftarrow> withoutFailure $ getObject slot;
    whenE (bitsLeft = pageBits \<or> oldPTE \<noteq> InvalidPTE) $ throw DeleteFirst;
    pte \<leftarrow> returnOk ( PageTablePTE_ \<lparr>
            ptePPN= addrFromPPtr (capPTBasePtr cap) `~shiftR~` pageBits,
            pteGlobal= False \<rparr>);
    vptr \<leftarrow> returnOk ( vptr && complement (mask bitsLeft));
    returnOk $ InvokePageTable $ PageTableMap_ \<lparr>
        ptMapCap= ArchObjectCap $ cap \<lparr> capPTMappedAddress:= Just (asid, vptr) \<rparr>,
        ptMapCTSlot= cte,
        ptMapPTE= pte,
        ptMapPTSlot= slot \<rparr>
odE)"

defs decodeRISCVPageTableInvocation_def:
"decodeRISCVPageTableInvocation label args cte x3 extraCaps\<equiv> (let cap = x3 in
  if isPageTableCap cap
  then  
   (case (invocationType label, args, extraCaps) of
          (ArchInvocationLabel RISCVPageTableMap, vaddr#attr#_, (vspaceCap,_)#_) \<Rightarrow>   (
            decodeRISCVPageTableInvocationMap cte cap (VPtr vaddr) attr vspaceCap
          )
        | (ArchInvocationLabel RISCVPageTableMap, _, _) \<Rightarrow>   throw TruncatedMessage
        | (ArchInvocationLabel RISCVPageTableUnmap, _, _) \<Rightarrow>   (doE
            cteVal \<leftarrow> withoutFailure $ getCTE cte;
            final \<leftarrow> withoutFailure $ isFinalCapability cteVal;
            unlessE final $ throw RevokeFirst;
            (case cap of
                  PageTableCap pt (Some (asid,_)) \<Rightarrow>   (doE
                        maybeVSpace \<leftarrow> withoutFailure $ maybeVSpaceForASID asid;
                        whenE (maybeVSpace = Just pt) $ throw RevokeFirst
                  odE)
                | _ \<Rightarrow>   returnOk ()
                );
            returnOk $ InvokePageTable $ PageTableUnmap_ \<lparr>
                ptUnmapCap= cap,
                ptUnmapCapSlot= cte \<rparr>
        odE)
        | _ \<Rightarrow>   throw IllegalOperation
        )
  else   haskell_fail []
  )"

defs decodeRISCVASIDControlInvocation_def:
"decodeRISCVASIDControlInvocation label args x2 extraCaps\<equiv> (case x2 of
    ASIDControlCap \<Rightarrow>   
    (case (invocationType label, args, extraCaps) of
          (ArchInvocationLabel RISCVASIDControlMakePool, index#depth#_, (untyped,parentSlot)#(croot,_)#_) \<Rightarrow>   (doE
            asidTable \<leftarrow> withoutFailure $ gets (riscvKSASIDTable \<circ> ksArchState);
            free \<leftarrow> returnOk ( filter (\<lambda> (x,y). x \<le> (1 `~shiftL~` asidHighBits) - 1 \<and> isNothing y) $ assocs asidTable);
            whenE (null free) $ throw DeleteFirst;
            base \<leftarrow> returnOk ( (fst $ head free) `~shiftL~` asidLowBits);
            pool \<leftarrow> returnOk ( makeObject ::asidpool);
            frame \<leftarrow> (let v33 = untyped in
                if isUntypedCap v33 \<and> capBlockSize v33 = objBits pool \<and> \<not> capIsDevice v33
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
        | (ArchInvocationLabel RISCVASIDControlMakePool, _, _) \<Rightarrow>   throw TruncatedMessage
        | _ \<Rightarrow>   throw IllegalOperation
        )
  | _ \<Rightarrow>    haskell_fail []
  )"

defs decodeRISCVASIDPoolInvocation_def:
"decodeRISCVASIDPoolInvocation label x1 extraCaps\<equiv> (let cap = x1 in
  if isASIDPoolCap cap
  then  
    (case (invocationType label, extraCaps) of
          (ArchInvocationLabel RISCVASIDPoolAssign, (vspaceCap,vspaceCapSlot)#_) \<Rightarrow>  
            (case vspaceCap of
                  ArchObjectCap (PageTableCap _ None) \<Rightarrow>   (doE
                    asidTable \<leftarrow> withoutFailure $ gets (riscvKSASIDTable \<circ> ksArchState);
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
        | (ArchInvocationLabel RISCVASIDPoolAssign, _) \<Rightarrow>   throw TruncatedMessage
        | _ \<Rightarrow>   throw IllegalOperation
        )
  else   haskell_fail []
  )"

defs decodeRISCVMMUInvocation_def:
"decodeRISCVMMUInvocation label args x2 cte x4 extraCaps\<equiv> (let cap = x4 in
  if isFrameCap cap
  then  
    decodeRISCVFrameInvocation label args cte cap extraCaps
  else if isPageTableCap cap
  then  
    decodeRISCVPageTableInvocation label args cte cap extraCaps
  else if isASIDControlCap cap
  then  
    decodeRISCVASIDControlInvocation label args cap extraCaps
  else if isASIDPoolCap cap
  then  
    decodeRISCVASIDPoolInvocation label cap extraCaps
  else undefined
  )"

defs performPageTableInvocation_def:
"performPageTableInvocation x0\<equiv> (case x0 of
    (PageTableMap cap ctSlot pte ptSlot) \<Rightarrow>    (do
    updateCap ctSlot cap;
    storePTE ptSlot pte;
    doMachineOp sfence
    od)
  | (PageTableUnmap cap slot) \<Rightarrow>    (do
    (case capPTMappedAddress cap of
          Some (asid, vaddr) \<Rightarrow>   (do
            ptr \<leftarrow> return ( capPTBasePtr cap);
            unmapPageTable asid vaddr ptr;
            slots \<leftarrow> return ( [ptr, ptr + bit pteBits  .e.  ptr + bit ptBits - 1]);
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
    updateCap ctSlot cap;
    storePTE slot pte;
    doMachineOp sfence;
    return []
    od)
  | (PageUnmap cap ctSlot) \<Rightarrow>    (do
    (case capFMappedAddress cap of
          Some (asid, vaddr) \<Rightarrow>   unmapPage (capFSize cap) asid vaddr (capFBasePtr cap)
        | _ \<Rightarrow>   return ()
        );
 cap \<leftarrow> liftM capCap $  getSlotCap ctSlot;
    updateCap ctSlot (ArchObjectCap $ cap \<lparr> capFMappedAddress := Nothing \<rparr>);
    return []
  od)
  | (PageGetAddr ptr) \<Rightarrow>   
    return [fromPAddr $ addrFromPPtr ptr]
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
    asidTable \<leftarrow> gets (riscvKSASIDTable \<circ> ksArchState);
    asidTable' \<leftarrow> return ( asidTable aLU [(asidHighBitsOf base, Just poolPtr)]);
    modify (\<lambda> s. s \<lparr>
        ksArchState := (ksArchState s) \<lparr> riscvKSASIDTable := asidTable' \<rparr>\<rparr>)
    od)
  )"

defs performASIDPoolInvocation_def:
"performASIDPoolInvocation x0\<equiv> (case x0 of
    (Assign asid poolPtr ctSlot) \<Rightarrow>    (do
    oldcap \<leftarrow> getSlotCap ctSlot;
 cap \<leftarrow> liftM capCap $  return ( oldcap);
    updateCap ctSlot (ArchObjectCap $ cap \<lparr> capPTMappedAddress := Just (asid,0) \<rparr>);
    copyGlobalMappings (capPTBasePtr cap);
 pool \<leftarrow> liftM (inv ASIDPool) $  getObject poolPtr;
    pool' \<leftarrow> return ( pool aLU [(asid && mask asidLowBits, Just $ capPTBasePtr cap)]);
    setObject poolPtr $ ASIDPool pool'
    od)
  )"

defs performRISCVMMUInvocation_def:
"performRISCVMMUInvocation i\<equiv> withoutPreemption $ (
    (case i of
          InvokePageTable oper \<Rightarrow>   (do
            performPageTableInvocation oper;
            return []
          od)
        | InvokePage oper \<Rightarrow>   performPageInvocation oper
        | InvokeASIDControl oper \<Rightarrow>   (do
            performASIDControlInvocation oper;
            return []
        od)
        | InvokeASIDPool oper \<Rightarrow>   (do
            performASIDPoolInvocation oper;
            return []
        od)
        )
)"

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
