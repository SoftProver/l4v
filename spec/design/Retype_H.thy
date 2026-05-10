(* THIS FILE WAS AUTOMATICALLY GENERATED. DO NOT EDIT. *)
(* instead, see the skeleton file Retype_H.thy *)
(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * SPDX-License-Identifier: GPL-2.0-only
 *)

chapter "Retyping Objects"

theory Retype_H
imports
  RetypeDecls_H
  Endpoint_H
  Untyped_H
  Interrupt_H
begin

context Arch begin
requalify_consts
  deriveCap finaliseCap postCapDeletion isCapRevocable
  hasCancelSendRights sameRegionAs isPhysicalCap
  sameObjectAs updateCapData maskCapRights
  createObject capUntypedPtr capUntypedSize
  performInvocation decodeInvocation prepareThreadDelete
  cteRightsBits cteGuardBits

context begin global_naming global

requalify_consts
  RetypeDecls_H.deriveCap RetypeDecls_H.finaliseCap RetypeDecls_H.postCapDeletion
  RetypeDecls_H.hasCancelSendRights RetypeDecls_H.sameRegionAs RetypeDecls_H.isPhysicalCap
  RetypeDecls_H.sameObjectAs RetypeDecls_H.updateCapData RetypeDecls_H.maskCapRights
  RetypeDecls_H.createObject RetypeDecls_H.capUntypedPtr RetypeDecls_H.capUntypedSize
  RetypeDecls_H.performInvocation RetypeDecls_H.decodeInvocation RetypeDecls_H.isCapRevocable
end

end

defs deriveCap_def:
"deriveCap slot x1\<equiv> (let cap = x1 in
  if isZombie cap
  then   returnOk NullCap
  else if isIRQControlCap cap
  then   returnOk NullCap
  else if isUntypedCap cap
  then   (doE
    ensureNoChildren slot;
    returnOk cap
  odE)
  else if isReplyCap cap
  then   returnOk NullCap
  else if isArchObjectCap cap
  then let cap = capCap cap
  in  
    Arch.deriveCap slot cap
  else   returnOk cap
  )"

defs isCapRevocable_def:
"isCapRevocable newCap srcCap\<equiv> (case newCap of
      ArchObjectCap _ \<Rightarrow>   Arch.isCapRevocable newCap srcCap
    | EndpointCap _ _ _ _ _ _ \<Rightarrow>   capEPBadge newCap \<noteq> capEPBadge srcCap
    | NotificationCap _ _ _ _ \<Rightarrow>   capNtfnBadge newCap \<noteq> capNtfnBadge srcCap
    | IRQHandlerCap _ \<Rightarrow>   isIRQControlCap srcCap
    | UntypedCap _ _ _ _ \<Rightarrow>   True
    | _ \<Rightarrow>   False
    )"

defs finaliseCap_def:
"finaliseCap x0 x1 x2\<equiv> (let (v13, v14, v15) = (x0, x1, x2) in
  if isEndpointCap v13
  then let ptr = capEPPtr v13; final = v14
  in   (do
    when final $ cancelAllIPC ptr;
    return (NullCap, NullCap)
  od)
  else if isNotificationCap v13
  then let ptr = capNtfnPtr v13; final = v14
  in   (do
    when final $ (do
        unbindMaybeNotification ptr;
        cancelAllSignals ptr
    od);
    return (NullCap, NullCap)
  od)
  else if isReplyCap v13
  then   return (NullCap, NullCap)
  else if isNullCap v13
  then   return (NullCap, NullCap)
  else if isDomainCap v13
  then   return (NullCap, NullCap)
  else if v15
  then   haskell_fail []
  else if isCNodeCap v13 \<and> v14
  then let ptr = capCNodePtr v13; bits = capCNodeBits v13
  in  
    return (Zombie ptr (ZombieCNode bits) (bit bits), NullCap)
  else if isThreadCap v13 \<and> v14
  then let tcb = capTCBPtr v13
  in   (do
    cte_ptr \<leftarrow> getThreadCSpaceRoot tcb;
    unbindNotification tcb;
    suspend tcb;
    Arch.prepareThreadDelete tcb;
    return (Zombie cte_ptr ZombieTCB 5, NullCap)
  od)
  else if isZombie v13 \<and> v14
  then let z = v13
  in  
    return (z, NullCap)
  else if isArchObjectCap v13
  then let cap = capCap v13; final = v14
  in  
    Arch.finaliseCap cap final
  else if isIRQHandlerCap v13 \<and> v14
  then let irq = capIRQ v13; cap = v13
  in   (do
    deletingIRQHandler irq;
    return (NullCap, cap)
  od)
  else if isZombie v13 \<and> \<not> v14
  then   haskell_fail []
  else   return (NullCap, NullCap)
  )"

defs postCapDeletion_def:
"postCapDeletion info\<equiv> (case info of
      IRQHandlerCap irq \<Rightarrow>   deletedIRQHandler irq
    | ArchObjectCap c \<Rightarrow>   Arch.postCapDeletion c
    | _ \<Rightarrow>   return ()
    )"

defs hasCancelSendRights_def:
"hasCancelSendRights x0\<equiv> (case x0 of
    (EndpointCap _ _ True True True True) \<Rightarrow>    True
  | _ \<Rightarrow>    False
  )"

defs sameRegionAs_def:
"sameRegionAs x0 x1\<equiv> (let (a, b) = (x0, x1) in
  if isUntypedCap a
  then 
    let
        baseA = capPtr a;
        topA = baseA + PPtr (bit $ capBlockSize a) - 1;
        baseB = capUntypedPtr b;
        topB = baseB + PPtr (capUntypedSize b) - 1
    in
    
    isPhysicalCap b \<and> (baseA \<le> baseB) \<and> (topB \<le> topA) \<and> (baseB \<le> topB)
  else if isEndpointCap a \<and> isEndpointCap b
  then  
    capEPPtr a = capEPPtr b
  else if isNotificationCap a \<and> isNotificationCap b
  then  
    capNtfnPtr a = capNtfnPtr b
  else if isCNodeCap a \<and> isCNodeCap b
  then  
    capCNodePtr a = capCNodePtr b \<and> capCNodeBits a = capCNodeBits b
  else if isThreadCap a \<and> isThreadCap b
  then  
    capTCBPtr a = capTCBPtr b
  else if isReplyCap a \<and> isReplyCap b
  then  
    capTCBPtr a = capTCBPtr b
  else if isDomainCap a \<and> isDomainCap b
  then   True
  else if isIRQControlCap a \<and> isIRQControlCap b
  then   True
  else if isIRQControlCap a \<and> isIRQHandlerCap b
  then   True
  else if isIRQHandlerCap a \<and> isIRQHandlerCap b
  then (case (a, b) of
  (IRQHandlerCap a, IRQHandlerCap b) \<Rightarrow>   a = b
  )
  else if isArchObjectCap a \<and> isArchObjectCap b
  then (case (a, b) of
  (ArchObjectCap a, ArchObjectCap b) \<Rightarrow>  
    a `~Arch.sameRegionAs~` b
  )
  else   False
  )"

defs isPhysicalCap_def:
"isPhysicalCap x0\<equiv> (case x0 of
    NullCap \<Rightarrow>    False
  | IRQControlCap \<Rightarrow>    False
  | DomainCap \<Rightarrow>    False
  | (IRQHandlerCap _) \<Rightarrow>    False
  | (ReplyCap _ _ _) \<Rightarrow>    False
  | (ArchObjectCap a) \<Rightarrow>    Arch.isPhysicalCap a
  | _ \<Rightarrow>    True
  )"

defs sameObjectAs_def:
"sameObjectAs x0 x1\<equiv> (case (x0, x1) of
    ((UntypedCap _ _ _ _), _) \<Rightarrow>    False
  | (IRQControlCap, (IRQHandlerCap _)) \<Rightarrow>    False
  | ((ArchObjectCap a), (ArchObjectCap b)) \<Rightarrow>    a `~Arch.sameObjectAs~` b
  | (a, b) \<Rightarrow>    a `~sameRegionAs~` b
  )"

defs updateCapData_def:
"updateCapData x0 x1 x2\<equiv> (let (v16, v17, v18) = (x0, x1, x2) in
  if isEndpointCap v18
  then let preserve = v16; new = v17; cap = v18
  in  
    if
    Not preserve \<and> capEPBadge cap = 0 then cap \<lparr> capEPBadge := new && mask badgeBits \<rparr>
    else if
    True      then NullCap
    else undefined
  else if isNotificationCap v18
  then let preserve = v16; new = v17; cap = v18
  in  
    if
    Not preserve \<and> capNtfnBadge cap = 0 then cap \<lparr> capNtfnBadge := new && mask badgeBits \<rparr>
    else if
    True      then NullCap
    else undefined
  else if isCNodeCap v18
  then let w = v17; cap = v18
  in  
    let
        guardSizeBits = wordSizeCase 5 6;
        guardSize = fromIntegral $ (w `~shiftR~` Arch.cteRightsBits) &&
            mask guardSizeBits;
        guard = (w `~shiftR~` (Arch.cteRightsBits + guardSizeBits)) &&
            mask Arch.cteGuardBits && mask guardSize
    in
    if
    guardSize + capCNodeBits cap > finiteBitSize w then NullCap
    else if
    True      then cap \<lparr>
        capCNodeGuard := guard,
        capCNodeGuardSize := guardSize \<rparr>
    else undefined
  else if isArchObjectCap v18
  then let p = v16; w = v17; aoCap = capCap v18
  in  
    Arch.updateCapData p w aoCap
  else let cap = v18
  in   cap
  )"

defs badgeBits_def:
"badgeBits \<equiv> wordSizeCase 28 64"

defs maskCapRights_def:
"maskCapRights r x1\<equiv> (let c = x1; aoCap = capCap x1 in
  if isNullCap c
  then   NullCap
  else if isDomainCap c
  then   DomainCap
  else if isUntypedCap c
  then   c
  else if isEndpointCap c
  then   c \<lparr>
    capEPCanSend := capEPCanSend c \<and> capAllowWrite r,
    capEPCanReceive := capEPCanReceive c \<and> capAllowRead r,
    capEPCanGrant := capEPCanGrant c \<and> capAllowGrant r,
    capEPCanGrantReply := capEPCanGrantReply c \<and> capAllowGrantReply r \<rparr>
  else if isNotificationCap c
  then   c \<lparr>
    capNtfnCanSend := capNtfnCanSend c \<and> capAllowWrite r,
    capNtfnCanReceive := capNtfnCanReceive c \<and> capAllowRead r \<rparr>
  else if isReplyCap c
  then   c\<lparr>
    capReplyCanGrant := capReplyCanGrant c \<and> capAllowGrant r \<rparr>
  else if isCNodeCap c
  then   c
  else if isThreadCap c
  then   c
  else if isIRQControlCap c
  then   c
  else if isIRQHandlerCap c
  then   c
  else if isArchObjectCap c
  then   Arch.maskCapRights r aoCap
  else if isZombie c
  then   c
  else undefined
  )"

defs createObject_def:
"createObject t regionBase userSize isDevice \<equiv>
    let funupd = (\<lambda> f x v y. if y = x then v else f y) in
    (case toAPIType t of
          Some TCBObject \<Rightarrow>   (do
            placeNewObject regionBase (makeObject ::tcb) 0;
            curdom \<leftarrow> curDomain;
            threadSet (\<lambda> t. t \<lparr> tcbDomain := curdom \<rparr>)
                (PPtr $ fromPPtr regionBase);
            return $ ThreadCap (PPtr $ fromPPtr regionBase)
          od)
        | Some EndpointObject \<Rightarrow>   (do
            placeNewObject regionBase (makeObject ::endpoint) 0;
            return $ EndpointCap (PPtr $ fromPPtr regionBase) 0 True True True True
        od)
        | Some NotificationObject \<Rightarrow>   (do
            placeNewObject (PPtr $ fromPPtr regionBase) (makeObject ::notification) 0;
            return $ NotificationCap (PPtr $ fromPPtr regionBase) 0 True True
        od)
        | Some CapTableObject \<Rightarrow>   (do
            placeNewObject (PPtr $ fromPPtr regionBase) (makeObject ::cte) userSize;
            modify (\<lambda> ks. ks \<lparr> gsCNodes :=
              funupd (gsCNodes ks) (fromPPtr regionBase) (Just userSize)\<rparr>);
            return $ CNodeCap (PPtr $ fromPPtr regionBase) userSize 0 0
        od)
        | Some Untyped \<Rightarrow>  
            return $ UntypedCap isDevice (PPtr $ fromPPtr regionBase) userSize 0
        | None \<Rightarrow>   (do
            archCap \<leftarrow> Arch.createObject t regionBase userSize isDevice;
            return $ ArchObjectCap archCap
        od)
        )"

defs decodeInvocation_def:
"decodeInvocation label args capIndex slot x4 extraCaps\<equiv> (let cap = x4 in
  if isEndpointCap cap \<and> capEPCanSend cap
  then  
    returnOk $ InvokeEndpoint
        (capEPPtr cap) (capEPBadge cap) (capEPCanGrant cap)
        (capEPCanGrantReply cap)
  else if isNotificationCap cap \<and> capNtfnCanSend cap
  then   (
    returnOk $ InvokeNotification (capNtfnPtr cap) (capNtfnBadge cap)
  )
  else if isReplyCap cap \<and> \<not> capReplyMaster cap
  then   (
    returnOk $ InvokeReply (capTCBPtr cap) slot (capReplyCanGrant cap)
  )
  else if isThreadCap cap
  then  
    liftME InvokeTCB $ decodeTCBInvocation label args cap slot extraCaps
  else if isDomainCap cap
  then  
    liftME (uncurry InvokeDomain) $ decodeDomainInvocation label args extraCaps
  else if isCNodeCap cap
  then  
    liftME InvokeCNode $
        decodeCNodeInvocation label args cap $ map fst extraCaps
  else if isUntypedCap cap
  then  
    liftME InvokeUntyped $
        decodeUntypedInvocation label args slot cap $ map fst extraCaps
  else if isIRQControlCap cap
  then  
    liftME InvokeIRQControl $
        decodeIRQControlInvocation label args slot $ map fst extraCaps
  else if isIRQHandlerCap cap
  then let irq = capIRQ cap
  in  
    liftME InvokeIRQHandler $
        decodeIRQHandlerInvocation label irq extraCaps
  else if isArchObjectCap cap
  then let cap = capCap cap
  in  
    liftME InvokeArchObject $
        Arch.decodeInvocation label args capIndex slot cap extraCaps
  else   throw $ InvalidCapability 0
  )"

defs performInvocation_def:
"performInvocation block call x2\<equiv> (case x2 of
    (InvokeUntyped invok) \<Rightarrow>    (doE
    invokeUntyped invok;
    returnOk $ []
    odE)
  | (InvokeEndpoint ep badge canGrant canGrantReply) \<Rightarrow>   
  withoutPreemption $ (do
    thread \<leftarrow> getCurThread;
    sendIPC block call badge canGrant canGrantReply thread ep;
    return $ []
  od)
  | (InvokeNotification ep badge) \<Rightarrow>    (doE
    withoutPreemption $ sendSignal ep badge;
    returnOk $ []
  odE)
  | (InvokeReply thread slot canGrant) \<Rightarrow>   
  withoutPreemption $ (do
    sender \<leftarrow> getCurThread;
    doReplyTransfer sender thread slot canGrant;
    return $ []
  od)
  | (InvokeTCB invok) \<Rightarrow>    invokeTCB invok
  | (InvokeDomain thread domain) \<Rightarrow>    withoutPreemption $ (do
    setDomain thread domain;
    return $ []
  od)
  | (InvokeCNode invok) \<Rightarrow>    (doE
    invokeCNode invok;
    returnOk $ []
  odE)
  | (InvokeIRQControl invok) \<Rightarrow>    (doE
    performIRQControl invok;
    returnOk $ []
  odE)
  | (InvokeIRQHandler invok) \<Rightarrow>    (doE
    withoutPreemption $ invokeIRQHandler invok;
    returnOk $ []
  odE)
  | (InvokeArchObject invok) \<Rightarrow>    Arch.performInvocation invok
  )"

defs capUntypedPtr_def:
"capUntypedPtr x0\<equiv> (case x0 of
    NullCap \<Rightarrow>    error []
  | (UntypedCap _ p _ _) \<Rightarrow>    p
  | (EndpointCap (\<comment> \<open>PPtr\<close> p) _ _ _ _ _) \<Rightarrow>    PPtr p
  | (NotificationCap (\<comment> \<open>PPtr\<close> p) _ _ _) \<Rightarrow>    PPtr p
  | (ReplyCap (\<comment> \<open>PPtr\<close> p) _ _) \<Rightarrow>    PPtr p
  | (CNodeCap (\<comment> \<open>PPtr\<close> p) _ _ _) \<Rightarrow>    PPtr p
  | (ThreadCap (\<comment> \<open>PPtr\<close> p)) \<Rightarrow>    PPtr p
  | DomainCap \<Rightarrow>    error []
  | (Zombie (\<comment> \<open>PPtr\<close> p) _ _) \<Rightarrow>    PPtr p
  | IRQControlCap \<Rightarrow>    error []
  | (IRQHandlerCap _) \<Rightarrow>    error []
  | (ArchObjectCap a) \<Rightarrow>    Arch.capUntypedPtr a
  )"

defs capUntypedSize_def:
"capUntypedSize x0\<equiv> (case x0 of
    NullCap \<Rightarrow>    0
  | (UntypedCap _ _ b _) \<Rightarrow>    1 `~shiftL~` b
  | (CNodeCap _ c _ _) \<Rightarrow>    1 `~shiftL~` (objBits (undefined::cte) + c)
  | (EndpointCap _ _ _ _ _ _) \<Rightarrow>    1 `~shiftL~` objBits (undefined::endpoint)
  | (NotificationCap _ _ _ _) \<Rightarrow>    1 `~shiftL~` objBits (undefined::notification)
  | (ThreadCap _) \<Rightarrow>    1 `~shiftL~` objBits (undefined::tcb)
  | (DomainCap ) \<Rightarrow>    1
  | (ArchObjectCap a) \<Rightarrow>    Arch.capUntypedSize a
  | (Zombie _ ZombieTCB _) \<Rightarrow>    1 `~shiftL~` objBits (undefined::tcb)
  | (Zombie _ (ZombieCNode sz) _) \<Rightarrow>    1 `~shiftL~` (objBits (undefined::cte) + sz)
  | (ReplyCap _ _ _) \<Rightarrow>    1 `~shiftL~` objBits (undefined::tcb)
  | (IRQControlCap ) \<Rightarrow>    1
  | (IRQHandlerCap _) \<Rightarrow>    1
  )"


end
