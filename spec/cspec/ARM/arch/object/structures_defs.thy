theory structures_defs
imports "../../../../../../KernelState_C"
begin


lemma word_sub_mask:
  "\<lbrakk> w && m1 = v1; m1 && m2 = m2; v1 && m2 = v2 \<rbrakk>
     \<Longrightarrow> w && m2 = v2"
  by (clarsimp simp: word_bw_assocs)


record endpoint_CL =
    epQueue_head_CL :: "word32"
    epQueue_tail_CL :: "word32"
    state_CL :: "word32"

definition endpoint_lift :: "endpoint_C \<Rightarrow> endpoint_CL" where
  "endpoint_lift endpoint \<equiv> \<lparr>
       endpoint_CL.epQueue_head_CL = (((index (endpoint_C.words_C endpoint) 1) << 0) AND NOT (mask 4)),
       endpoint_CL.epQueue_tail_CL = (((index (endpoint_C.words_C endpoint) 0) << 0) AND NOT (mask 4)),
       endpoint_CL.state_CL = (((index (endpoint_C.words_C endpoint) 0) >> 0) AND mask 2) \<rparr>"

record mdb_node_CL =
    mdbNext_CL :: "word32"
    mdbRevocable_CL :: "word32"
    mdbFirstBadged_CL :: "word32"
    mdbPrev_CL :: "word32"

definition mdb_node_lift :: "mdb_node_C \<Rightarrow> mdb_node_CL" where
  "mdb_node_lift mdb_node \<equiv> \<lparr>
       mdb_node_CL.mdbNext_CL = (((index (mdb_node_C.words_C mdb_node) 1) << 0) AND NOT (mask 3)),
       mdb_node_CL.mdbRevocable_CL = (((index (mdb_node_C.words_C mdb_node) 1) >> 1) AND mask 1),
       mdb_node_CL.mdbFirstBadged_CL = (((index (mdb_node_C.words_C mdb_node) 1) >> 0) AND mask 1),
       mdb_node_CL.mdbPrev_CL = (((index (mdb_node_C.words_C mdb_node) 0) << 0) AND NOT (mask 3)) \<rparr>"

record notification_CL =
    ntfnBoundTCB_CL :: "word32"
    ntfnMsgIdentifier_CL :: "word32"
    ntfnQueue_head_CL :: "word32"
    ntfnQueue_tail_CL :: "word32"
    state_CL :: "word32"

definition notification_lift :: "notification_C \<Rightarrow> notification_CL" where
  "notification_lift notification \<equiv> \<lparr>
       notification_CL.ntfnBoundTCB_CL = (((index (notification_C.words_C notification) 3) << 0) AND NOT (mask 4)),
       notification_CL.ntfnMsgIdentifier_CL = (((index (notification_C.words_C notification) 2) >> 0)),
       notification_CL.ntfnQueue_head_CL = (((index (notification_C.words_C notification) 1) << 0) AND NOT (mask 4)),
       notification_CL.ntfnQueue_tail_CL = (((index (notification_C.words_C notification) 0) << 0) AND NOT (mask 4)),
       notification_CL.state_CL = (((index (notification_C.words_C notification) 0) >> 0) AND mask 2) \<rparr>"

record stored_hw_asid_CL =
    asid_CL :: "word32"
    valid_CL :: "word32"
    pdeType_CL :: "word32"

definition stored_hw_asid_lift :: "stored_hw_asid_C \<Rightarrow> stored_hw_asid_CL" where
  "stored_hw_asid_lift stored_hw_asid \<equiv> \<lparr>
       stored_hw_asid_CL.asid_CL = (((index (stored_hw_asid_C.words_C stored_hw_asid) 0) >> 24) AND mask 8),
       stored_hw_asid_CL.valid_CL = (((index (stored_hw_asid_C.words_C stored_hw_asid) 0) >> 23) AND mask 1),
       stored_hw_asid_CL.pdeType_CL = (((index (stored_hw_asid_C.words_C stored_hw_asid) 0) >> 0) AND mask 2) \<rparr>"

record thread_state_CL =
    blockingIPCBadge_CL :: "word32"
    blockingIPCCanGrant_CL :: "word32"
    blockingIPCCanGrantReply_CL :: "word32"
    blockingIPCIsCall_CL :: "word32"
    tcbQueued_CL :: "word32"
    blockingObject_CL :: "word32"
    tsType_CL :: "word32"

definition thread_state_lift :: "thread_state_C \<Rightarrow> thread_state_CL" where
  "thread_state_lift thread_state \<equiv> \<lparr>
       thread_state_CL.blockingIPCBadge_CL = (((index (thread_state_C.words_C thread_state) 2) >> 4) AND mask 28),
       thread_state_CL.blockingIPCCanGrant_CL = (((index (thread_state_C.words_C thread_state) 2) >> 3) AND mask 1),
       thread_state_CL.blockingIPCCanGrantReply_CL = (((index (thread_state_C.words_C thread_state) 2) >> 2) AND mask 1),
       thread_state_CL.blockingIPCIsCall_CL = (((index (thread_state_C.words_C thread_state) 2) >> 1) AND mask 1),
       thread_state_CL.tcbQueued_CL = (((index (thread_state_C.words_C thread_state) 1) >> 0) AND mask 1),
       thread_state_CL.blockingObject_CL = (((index (thread_state_C.words_C thread_state) 0) << 0) AND NOT (mask 4)),
       thread_state_CL.tsType_CL = (((index (thread_state_C.words_C thread_state) 0) >> 0) AND mask 4) \<rparr>"

record vm_attributes_CL =
    armExecuteNever_CL :: "word32"
    armParityEnabled_CL :: "word32"
    armPageCacheable_CL :: "word32"

definition vm_attributes_lift :: "vm_attributes_C \<Rightarrow> vm_attributes_CL" where
  "vm_attributes_lift vm_attributes \<equiv> \<lparr>
       vm_attributes_CL.armExecuteNever_CL = (((index (vm_attributes_C.words_C vm_attributes) 0) >> 2) AND mask 1),
       vm_attributes_CL.armParityEnabled_CL = (((index (vm_attributes_C.words_C vm_attributes) 0) >> 1) AND mask 1),
       vm_attributes_CL.armPageCacheable_CL = (((index (vm_attributes_C.words_C vm_attributes) 0) >> 0) AND mask 1) \<rparr>"

record cap_untyped_cap_CL =
    capFreeIndex_CL :: "word32"
    capIsDevice_CL :: "word32"
    capBlockSize_CL :: "word32"
    capPtr_CL :: "word32"

record cap_endpoint_cap_CL =
    capEPBadge_CL :: "word32"
    capCanGrantReply_CL :: "word32"
    capCanGrant_CL :: "word32"
    capCanSend_CL :: "word32"
    capCanReceive_CL :: "word32"
    capEPPtr_CL :: "word32"

record cap_notification_cap_CL =
    capNtfnBadge_CL :: "word32"
    capNtfnCanReceive_CL :: "word32"
    capNtfnCanSend_CL :: "word32"
    capNtfnPtr_CL :: "word32"

record cap_reply_cap_CL =
    capReplyCanGrant_CL :: "word32"
    capReplyMaster_CL :: "word32"
    capTCBPtr_CL :: "word32"

record cap_cnode_cap_CL =
    capCNodeRadix_CL :: "word32"
    capCNodeGuardSize_CL :: "word32"
    capCNodeGuard_CL :: "word32"
    capCNodePtr_CL :: "word32"

record cap_thread_cap_CL =
    capTCBPtr_CL :: "word32"

record cap_small_frame_cap_CL =
    capFMappedASIDLow_CL :: "word32"
    capFVMRights_CL :: "word32"
    capFMappedAddress_CL :: "word32"
    capFIsDevice_CL :: "word32"
    capFMappedASIDHigh_CL :: "word32"
    capFBasePtr_CL :: "word32"

record cap_frame_cap_CL =
    capFSize_CL :: "word32"
    capFMappedASIDLow_CL :: "word32"
    capFVMRights_CL :: "word32"
    capFMappedAddress_CL :: "word32"
    capFIsDevice_CL :: "word32"
    capFMappedASIDHigh_CL :: "word32"
    capFBasePtr_CL :: "word32"

record cap_asid_pool_cap_CL =
    capASIDBase_CL :: "word32"
    capASIDPool_CL :: "word32"

record cap_page_table_cap_CL =
    capPTIsMapped_CL :: "word32"
    capPTMappedASID_CL :: "word32"
    capPTMappedAddress_CL :: "word32"
    capPTBasePtr_CL :: "word32"

record cap_page_directory_cap_CL =
    capPDMappedASID_CL :: "word32"
    capPDIsMapped_CL :: "word32"
    capPDBasePtr_CL :: "word32"

record cap_irq_handler_cap_CL =
    capIRQ_CL :: "word32"

record cap_zombie_cap_CL =
    capZombieID_CL :: "word32"
    capZombieType_CL :: "word32"

datatype cap_CL =
    Cap_null_cap
  | Cap_untyped_cap cap_untyped_cap_CL
  | Cap_endpoint_cap cap_endpoint_cap_CL
  | Cap_notification_cap cap_notification_cap_CL
  | Cap_reply_cap cap_reply_cap_CL
  | Cap_cnode_cap cap_cnode_cap_CL
  | Cap_thread_cap cap_thread_cap_CL
  | Cap_small_frame_cap cap_small_frame_cap_CL
  | Cap_frame_cap cap_frame_cap_CL
  | Cap_asid_pool_cap cap_asid_pool_cap_CL
  | Cap_page_table_cap cap_page_table_cap_CL
  | Cap_page_directory_cap cap_page_directory_cap_CL
  | Cap_asid_control_cap
  | Cap_irq_control_cap
  | Cap_irq_handler_cap cap_irq_handler_cap_CL
  | Cap_zombie_cap cap_zombie_cap_CL
  | Cap_domain_cap

definition cap_get_tag :: "cap_C \<Rightarrow> word32" where
  "cap_get_tag cap \<equiv>
     if ((index (cap_C.words_C cap) 0) AND 0xe \<noteq> 0xe)
      then ((index (cap_C.words_C cap) 0) >> 0) AND mask 4
      else ((index (cap_C.words_C cap) 0) >> 0) AND mask 8"

lemma cap_get_tag_eq_x:
  "(cap_get_tag c = x) = ((if ((x << 0) AND 0xe \<noteq> 0xe)
      then ((index (cap_C.words_C c) 0) >> 0) AND mask 4
      else ((index (cap_C.words_C c) 0) >> 0) AND mask 8) = x)"
  by (auto simp add: cap_get_tag_def mask_def word_bw_assocs)

lemma cap_irq_control_cap_tag_mask_helpers:
  "w && 0xff = 0xe \<Longrightarrow> w && 0xf = 0xe"
  by (auto elim: word_sub_mask simp: mask_def)

lemma cap_irq_handler_cap_tag_mask_helpers:
  "w && 0xff = 0x1e \<Longrightarrow> w && 0xf = 0xe"
  by (auto elim: word_sub_mask simp: mask_def)

lemma cap_zombie_cap_tag_mask_helpers:
  "w && 0xff = 0x2e \<Longrightarrow> w && 0xf = 0xe"
  by (auto elim: word_sub_mask simp: mask_def)

lemma cap_domain_cap_tag_mask_helpers:
  "w && 0xff = 0x3e \<Longrightarrow> w && 0xf = 0xe"
  by (auto elim: word_sub_mask simp: mask_def)

definition cap_lift :: "cap_C \<Rightarrow> cap_CL option" where
  "cap_lift cap \<equiv>
    (let tag = cap_get_tag cap in
     if tag = scast cap_null_cap then Some (Cap_null_cap)
     else if tag = scast cap_untyped_cap then Some (Cap_untyped_cap \<lparr> 
       cap_untyped_cap_CL.capFreeIndex_CL = (((index (cap_C.words_C cap) 1) >> 6) AND mask 26),
       cap_untyped_cap_CL.capIsDevice_CL = (((index (cap_C.words_C cap) 1) >> 5) AND mask 1),
       cap_untyped_cap_CL.capBlockSize_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 5),
       cap_untyped_cap_CL.capPtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 4)) \<rparr>)
     else if tag = scast cap_endpoint_cap then Some (Cap_endpoint_cap \<lparr> 
       cap_endpoint_cap_CL.capEPBadge_CL = (((index (cap_C.words_C cap) 0) >> 4) AND mask 28),
       cap_endpoint_cap_CL.capCanGrantReply_CL = (((index (cap_C.words_C cap) 1) >> 3) AND mask 1),
       cap_endpoint_cap_CL.capCanGrant_CL = (((index (cap_C.words_C cap) 1) >> 2) AND mask 1),
       cap_endpoint_cap_CL.capCanSend_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 1),
       cap_endpoint_cap_CL.capCanReceive_CL = (((index (cap_C.words_C cap) 1) >> 1) AND mask 1),
       cap_endpoint_cap_CL.capEPPtr_CL = (((index (cap_C.words_C cap) 1) << 0) AND NOT (mask 4)) \<rparr>)
     else if tag = scast cap_notification_cap then Some (Cap_notification_cap \<lparr> 
       cap_notification_cap_CL.capNtfnBadge_CL = (((index (cap_C.words_C cap) 1) >> 4) AND mask 28),
       cap_notification_cap_CL.capNtfnCanReceive_CL = (((index (cap_C.words_C cap) 1) >> 1) AND mask 1),
       cap_notification_cap_CL.capNtfnCanSend_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 1),
       cap_notification_cap_CL.capNtfnPtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 4)) \<rparr>)
     else if tag = scast cap_reply_cap then Some (Cap_reply_cap \<lparr> 
       cap_reply_cap_CL.capReplyCanGrant_CL = (((index (cap_C.words_C cap) 0) >> 5) AND mask 1),
       cap_reply_cap_CL.capReplyMaster_CL = (((index (cap_C.words_C cap) 0) >> 4) AND mask 1),
       cap_reply_cap_CL.capTCBPtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 6)) \<rparr>)
     else if tag = scast cap_cnode_cap then Some (Cap_cnode_cap \<lparr> 
       cap_cnode_cap_CL.capCNodeRadix_CL = (((index (cap_C.words_C cap) 1) >> 18) AND mask 5),
       cap_cnode_cap_CL.capCNodeGuardSize_CL = (((index (cap_C.words_C cap) 1) >> 23) AND mask 5),
       cap_cnode_cap_CL.capCNodeGuard_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 18),
       cap_cnode_cap_CL.capCNodePtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 5)) \<rparr>)
     else if tag = scast cap_thread_cap then Some (Cap_thread_cap \<lparr> 
       cap_thread_cap_CL.capTCBPtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 4)) \<rparr>)
     else if tag = scast cap_small_frame_cap then Some (Cap_small_frame_cap \<lparr> 
       cap_small_frame_cap_CL.capFMappedASIDLow_CL = (((index (cap_C.words_C cap) 1) >> 22) AND mask 10),
       cap_small_frame_cap_CL.capFVMRights_CL = (((index (cap_C.words_C cap) 1) >> 20) AND mask 2),
       cap_small_frame_cap_CL.capFMappedAddress_CL = (((index (cap_C.words_C cap) 1) << 12) AND NOT (mask 12)),
       cap_small_frame_cap_CL.capFIsDevice_CL = (((index (cap_C.words_C cap) 0) >> 31) AND mask 1),
       cap_small_frame_cap_CL.capFMappedASIDHigh_CL = (((index (cap_C.words_C cap) 0) >> 24) AND mask 7),
       cap_small_frame_cap_CL.capFBasePtr_CL = (((index (cap_C.words_C cap) 0) << 8) AND NOT (mask 12)) \<rparr>)
     else if tag = scast cap_frame_cap then Some (Cap_frame_cap \<lparr> 
       cap_frame_cap_CL.capFSize_CL = (((index (cap_C.words_C cap) 1) >> 30) AND mask 2),
       cap_frame_cap_CL.capFMappedASIDLow_CL = (((index (cap_C.words_C cap) 1) >> 20) AND mask 10),
       cap_frame_cap_CL.capFVMRights_CL = (((index (cap_C.words_C cap) 1) >> 18) AND mask 2),
       cap_frame_cap_CL.capFMappedAddress_CL = (((index (cap_C.words_C cap) 1) << 14) AND NOT (mask 14)),
       cap_frame_cap_CL.capFIsDevice_CL = (((index (cap_C.words_C cap) 0) >> 29) AND mask 1),
       cap_frame_cap_CL.capFMappedASIDHigh_CL = (((index (cap_C.words_C cap) 0) >> 22) AND mask 7),
       cap_frame_cap_CL.capFBasePtr_CL = (((index (cap_C.words_C cap) 0) << 10) AND NOT (mask 14)) \<rparr>)
     else if tag = scast cap_asid_pool_cap then Some (Cap_asid_pool_cap \<lparr> 
       cap_asid_pool_cap_CL.capASIDBase_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 17),
       cap_asid_pool_cap_CL.capASIDPool_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 4)) \<rparr>)
     else if tag = scast cap_page_table_cap then Some (Cap_page_table_cap \<lparr> 
       cap_page_table_cap_CL.capPTIsMapped_CL = (((index (cap_C.words_C cap) 1) >> 29) AND mask 1),
       cap_page_table_cap_CL.capPTMappedASID_CL = (((index (cap_C.words_C cap) 1) >> 12) AND mask 17),
       cap_page_table_cap_CL.capPTMappedAddress_CL = (((index (cap_C.words_C cap) 1) << 20) AND NOT (mask 20)),
       cap_page_table_cap_CL.capPTBasePtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 10)) \<rparr>)
     else if tag = scast cap_page_directory_cap then Some (Cap_page_directory_cap \<lparr> 
       cap_page_directory_cap_CL.capPDMappedASID_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 17),
       cap_page_directory_cap_CL.capPDIsMapped_CL = (((index (cap_C.words_C cap) 0) >> 4) AND mask 1),
       cap_page_directory_cap_CL.capPDBasePtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 14)) \<rparr>)
     else if tag = scast cap_asid_control_cap then Some (Cap_asid_control_cap)
     else if tag = scast cap_irq_control_cap then Some (Cap_irq_control_cap)
     else if tag = scast cap_irq_handler_cap then Some (Cap_irq_handler_cap \<lparr> 
       cap_irq_handler_cap_CL.capIRQ_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 8) \<rparr>)
     else if tag = scast cap_zombie_cap then Some (Cap_zombie_cap \<lparr> 
       cap_zombie_cap_CL.capZombieID_CL = (((index (cap_C.words_C cap) 1) >> 0)),
       cap_zombie_cap_CL.capZombieType_CL = (((index (cap_C.words_C cap) 0) >> 8) AND mask 6) \<rparr>)
     else if tag = scast cap_domain_cap then Some (Cap_domain_cap)
     else None)"

lemma cap_lift_null_cap:
  "cap_get_tag cap = scast cap_null_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_null_cap)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_untyped_cap:
  "cap_get_tag cap = scast cap_untyped_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_untyped_cap \<lparr> 
       cap_untyped_cap_CL.capFreeIndex_CL = (((index (cap_C.words_C cap) 1) >> 6) AND mask 26),
       cap_untyped_cap_CL.capIsDevice_CL = (((index (cap_C.words_C cap) 1) >> 5) AND mask 1),
       cap_untyped_cap_CL.capBlockSize_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 5),
       cap_untyped_cap_CL.capPtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 4)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_endpoint_cap:
  "cap_get_tag cap = scast cap_endpoint_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_endpoint_cap \<lparr> 
       cap_endpoint_cap_CL.capEPBadge_CL = (((index (cap_C.words_C cap) 0) >> 4) AND mask 28),
       cap_endpoint_cap_CL.capCanGrantReply_CL = (((index (cap_C.words_C cap) 1) >> 3) AND mask 1),
       cap_endpoint_cap_CL.capCanGrant_CL = (((index (cap_C.words_C cap) 1) >> 2) AND mask 1),
       cap_endpoint_cap_CL.capCanSend_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 1),
       cap_endpoint_cap_CL.capCanReceive_CL = (((index (cap_C.words_C cap) 1) >> 1) AND mask 1),
       cap_endpoint_cap_CL.capEPPtr_CL = (((index (cap_C.words_C cap) 1) << 0) AND NOT (mask 4)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_notification_cap:
  "cap_get_tag cap = scast cap_notification_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_notification_cap \<lparr> 
       cap_notification_cap_CL.capNtfnBadge_CL = (((index (cap_C.words_C cap) 1) >> 4) AND mask 28),
       cap_notification_cap_CL.capNtfnCanReceive_CL = (((index (cap_C.words_C cap) 1) >> 1) AND mask 1),
       cap_notification_cap_CL.capNtfnCanSend_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 1),
       cap_notification_cap_CL.capNtfnPtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 4)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_reply_cap:
  "cap_get_tag cap = scast cap_reply_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_reply_cap \<lparr> 
       cap_reply_cap_CL.capReplyCanGrant_CL = (((index (cap_C.words_C cap) 0) >> 5) AND mask 1),
       cap_reply_cap_CL.capReplyMaster_CL = (((index (cap_C.words_C cap) 0) >> 4) AND mask 1),
       cap_reply_cap_CL.capTCBPtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 6)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_cnode_cap:
  "cap_get_tag cap = scast cap_cnode_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_cnode_cap \<lparr> 
       cap_cnode_cap_CL.capCNodeRadix_CL = (((index (cap_C.words_C cap) 1) >> 18) AND mask 5),
       cap_cnode_cap_CL.capCNodeGuardSize_CL = (((index (cap_C.words_C cap) 1) >> 23) AND mask 5),
       cap_cnode_cap_CL.capCNodeGuard_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 18),
       cap_cnode_cap_CL.capCNodePtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 5)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_thread_cap:
  "cap_get_tag cap = scast cap_thread_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_thread_cap \<lparr> 
       cap_thread_cap_CL.capTCBPtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 4)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_small_frame_cap:
  "cap_get_tag cap = scast cap_small_frame_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_small_frame_cap \<lparr> 
       cap_small_frame_cap_CL.capFMappedASIDLow_CL = (((index (cap_C.words_C cap) 1) >> 22) AND mask 10),
       cap_small_frame_cap_CL.capFVMRights_CL = (((index (cap_C.words_C cap) 1) >> 20) AND mask 2),
       cap_small_frame_cap_CL.capFMappedAddress_CL = (((index (cap_C.words_C cap) 1) << 12) AND NOT (mask 12)),
       cap_small_frame_cap_CL.capFIsDevice_CL = (((index (cap_C.words_C cap) 0) >> 31) AND mask 1),
       cap_small_frame_cap_CL.capFMappedASIDHigh_CL = (((index (cap_C.words_C cap) 0) >> 24) AND mask 7),
       cap_small_frame_cap_CL.capFBasePtr_CL = (((index (cap_C.words_C cap) 0) << 8) AND NOT (mask 12)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_frame_cap:
  "cap_get_tag cap = scast cap_frame_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_frame_cap \<lparr> 
       cap_frame_cap_CL.capFSize_CL = (((index (cap_C.words_C cap) 1) >> 30) AND mask 2),
       cap_frame_cap_CL.capFMappedASIDLow_CL = (((index (cap_C.words_C cap) 1) >> 20) AND mask 10),
       cap_frame_cap_CL.capFVMRights_CL = (((index (cap_C.words_C cap) 1) >> 18) AND mask 2),
       cap_frame_cap_CL.capFMappedAddress_CL = (((index (cap_C.words_C cap) 1) << 14) AND NOT (mask 14)),
       cap_frame_cap_CL.capFIsDevice_CL = (((index (cap_C.words_C cap) 0) >> 29) AND mask 1),
       cap_frame_cap_CL.capFMappedASIDHigh_CL = (((index (cap_C.words_C cap) 0) >> 22) AND mask 7),
       cap_frame_cap_CL.capFBasePtr_CL = (((index (cap_C.words_C cap) 0) << 10) AND NOT (mask 14)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_asid_pool_cap:
  "cap_get_tag cap = scast cap_asid_pool_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_asid_pool_cap \<lparr> 
       cap_asid_pool_cap_CL.capASIDBase_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 17),
       cap_asid_pool_cap_CL.capASIDPool_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 4)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_page_table_cap:
  "cap_get_tag cap = scast cap_page_table_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_page_table_cap \<lparr> 
       cap_page_table_cap_CL.capPTIsMapped_CL = (((index (cap_C.words_C cap) 1) >> 29) AND mask 1),
       cap_page_table_cap_CL.capPTMappedASID_CL = (((index (cap_C.words_C cap) 1) >> 12) AND mask 17),
       cap_page_table_cap_CL.capPTMappedAddress_CL = (((index (cap_C.words_C cap) 1) << 20) AND NOT (mask 20)),
       cap_page_table_cap_CL.capPTBasePtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 10)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_page_directory_cap:
  "cap_get_tag cap = scast cap_page_directory_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_page_directory_cap \<lparr> 
       cap_page_directory_cap_CL.capPDMappedASID_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 17),
       cap_page_directory_cap_CL.capPDIsMapped_CL = (((index (cap_C.words_C cap) 0) >> 4) AND mask 1),
       cap_page_directory_cap_CL.capPDBasePtr_CL = (((index (cap_C.words_C cap) 0) << 0) AND NOT (mask 14)) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_asid_control_cap:
  "cap_get_tag cap = scast cap_asid_control_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_asid_control_cap)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_irq_control_cap:
  "cap_get_tag cap = scast cap_irq_control_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_irq_control_cap)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_irq_handler_cap:
  "cap_get_tag cap = scast cap_irq_handler_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_irq_handler_cap \<lparr> 
       cap_irq_handler_cap_CL.capIRQ_CL = (((index (cap_C.words_C cap) 1) >> 0) AND mask 8) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_zombie_cap:
  "cap_get_tag cap = scast cap_zombie_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_zombie_cap \<lparr> 
       cap_zombie_cap_CL.capZombieID_CL = (((index (cap_C.words_C cap) 1) >> 0)),
       cap_zombie_cap_CL.capZombieType_CL = (((index (cap_C.words_C cap) 0) >> 8) AND mask 6) \<rparr>)"
  by (simp add:cap_lift_def cap_tag_defs)

lemma cap_lift_domain_cap:
  "cap_get_tag cap = scast cap_domain_cap \<Longrightarrow>
  cap_lift cap =
  Some (Cap_domain_cap)"
  by (simp add:cap_lift_def cap_tag_defs)


definition cap_untyped_cap_access ::
  "(cap_untyped_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_untyped_cap_access f cap \<equiv>
     (case cap of Cap_untyped_cap rec \<Rightarrow> f rec)"

definition cap_untyped_cap_update ::
  "(cap_untyped_cap_CL \<Rightarrow> cap_untyped_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_untyped_cap_update f cap \<equiv>
     (case cap of Cap_untyped_cap rec \<Rightarrow>
        Cap_untyped_cap (f rec))"

definition cap_untyped_cap_lift :: "cap_C \<Rightarrow> cap_untyped_cap_CL" where
  "cap_untyped_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_untyped_cap rec) \<Rightarrow> rec"

lemma cap_untyped_cap_lift:
  "(cap_get_tag c = scast cap_untyped_cap) = (cap_lift c = Some (Cap_untyped_cap (cap_untyped_cap_lift c)))"
  unfolding cap_lift_def cap_untyped_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_endpoint_cap_access ::
  "(cap_endpoint_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_endpoint_cap_access f cap \<equiv>
     (case cap of Cap_endpoint_cap rec \<Rightarrow> f rec)"

definition cap_endpoint_cap_update ::
  "(cap_endpoint_cap_CL \<Rightarrow> cap_endpoint_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_endpoint_cap_update f cap \<equiv>
     (case cap of Cap_endpoint_cap rec \<Rightarrow>
        Cap_endpoint_cap (f rec))"

definition cap_endpoint_cap_lift :: "cap_C \<Rightarrow> cap_endpoint_cap_CL" where
  "cap_endpoint_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_endpoint_cap rec) \<Rightarrow> rec"

lemma cap_endpoint_cap_lift:
  "(cap_get_tag c = scast cap_endpoint_cap) = (cap_lift c = Some (Cap_endpoint_cap (cap_endpoint_cap_lift c)))"
  unfolding cap_lift_def cap_endpoint_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_notification_cap_access ::
  "(cap_notification_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_notification_cap_access f cap \<equiv>
     (case cap of Cap_notification_cap rec \<Rightarrow> f rec)"

definition cap_notification_cap_update ::
  "(cap_notification_cap_CL \<Rightarrow> cap_notification_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_notification_cap_update f cap \<equiv>
     (case cap of Cap_notification_cap rec \<Rightarrow>
        Cap_notification_cap (f rec))"

definition cap_notification_cap_lift :: "cap_C \<Rightarrow> cap_notification_cap_CL" where
  "cap_notification_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_notification_cap rec) \<Rightarrow> rec"

lemma cap_notification_cap_lift:
  "(cap_get_tag c = scast cap_notification_cap) = (cap_lift c = Some (Cap_notification_cap (cap_notification_cap_lift c)))"
  unfolding cap_lift_def cap_notification_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_reply_cap_access ::
  "(cap_reply_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_reply_cap_access f cap \<equiv>
     (case cap of Cap_reply_cap rec \<Rightarrow> f rec)"

definition cap_reply_cap_update ::
  "(cap_reply_cap_CL \<Rightarrow> cap_reply_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_reply_cap_update f cap \<equiv>
     (case cap of Cap_reply_cap rec \<Rightarrow>
        Cap_reply_cap (f rec))"

definition cap_reply_cap_lift :: "cap_C \<Rightarrow> cap_reply_cap_CL" where
  "cap_reply_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_reply_cap rec) \<Rightarrow> rec"

lemma cap_reply_cap_lift:
  "(cap_get_tag c = scast cap_reply_cap) = (cap_lift c = Some (Cap_reply_cap (cap_reply_cap_lift c)))"
  unfolding cap_lift_def cap_reply_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_cnode_cap_access ::
  "(cap_cnode_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_cnode_cap_access f cap \<equiv>
     (case cap of Cap_cnode_cap rec \<Rightarrow> f rec)"

definition cap_cnode_cap_update ::
  "(cap_cnode_cap_CL \<Rightarrow> cap_cnode_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_cnode_cap_update f cap \<equiv>
     (case cap of Cap_cnode_cap rec \<Rightarrow>
        Cap_cnode_cap (f rec))"

definition cap_cnode_cap_lift :: "cap_C \<Rightarrow> cap_cnode_cap_CL" where
  "cap_cnode_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_cnode_cap rec) \<Rightarrow> rec"

lemma cap_cnode_cap_lift:
  "(cap_get_tag c = scast cap_cnode_cap) = (cap_lift c = Some (Cap_cnode_cap (cap_cnode_cap_lift c)))"
  unfolding cap_lift_def cap_cnode_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_thread_cap_access ::
  "(cap_thread_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_thread_cap_access f cap \<equiv>
     (case cap of Cap_thread_cap rec \<Rightarrow> f rec)"

definition cap_thread_cap_update ::
  "(cap_thread_cap_CL \<Rightarrow> cap_thread_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_thread_cap_update f cap \<equiv>
     (case cap of Cap_thread_cap rec \<Rightarrow>
        Cap_thread_cap (f rec))"

definition cap_thread_cap_lift :: "cap_C \<Rightarrow> cap_thread_cap_CL" where
  "cap_thread_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_thread_cap rec) \<Rightarrow> rec"

lemma cap_thread_cap_lift:
  "(cap_get_tag c = scast cap_thread_cap) = (cap_lift c = Some (Cap_thread_cap (cap_thread_cap_lift c)))"
  unfolding cap_lift_def cap_thread_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_small_frame_cap_access ::
  "(cap_small_frame_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_small_frame_cap_access f cap \<equiv>
     (case cap of Cap_small_frame_cap rec \<Rightarrow> f rec)"

definition cap_small_frame_cap_update ::
  "(cap_small_frame_cap_CL \<Rightarrow> cap_small_frame_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_small_frame_cap_update f cap \<equiv>
     (case cap of Cap_small_frame_cap rec \<Rightarrow>
        Cap_small_frame_cap (f rec))"

definition cap_small_frame_cap_lift :: "cap_C \<Rightarrow> cap_small_frame_cap_CL" where
  "cap_small_frame_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_small_frame_cap rec) \<Rightarrow> rec"

lemma cap_small_frame_cap_lift:
  "(cap_get_tag c = scast cap_small_frame_cap) = (cap_lift c = Some (Cap_small_frame_cap (cap_small_frame_cap_lift c)))"
  unfolding cap_lift_def cap_small_frame_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_frame_cap_access ::
  "(cap_frame_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_frame_cap_access f cap \<equiv>
     (case cap of Cap_frame_cap rec \<Rightarrow> f rec)"

definition cap_frame_cap_update ::
  "(cap_frame_cap_CL \<Rightarrow> cap_frame_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_frame_cap_update f cap \<equiv>
     (case cap of Cap_frame_cap rec \<Rightarrow>
        Cap_frame_cap (f rec))"

definition cap_frame_cap_lift :: "cap_C \<Rightarrow> cap_frame_cap_CL" where
  "cap_frame_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_frame_cap rec) \<Rightarrow> rec"

lemma cap_frame_cap_lift:
  "(cap_get_tag c = scast cap_frame_cap) = (cap_lift c = Some (Cap_frame_cap (cap_frame_cap_lift c)))"
  unfolding cap_lift_def cap_frame_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_asid_pool_cap_access ::
  "(cap_asid_pool_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_asid_pool_cap_access f cap \<equiv>
     (case cap of Cap_asid_pool_cap rec \<Rightarrow> f rec)"

definition cap_asid_pool_cap_update ::
  "(cap_asid_pool_cap_CL \<Rightarrow> cap_asid_pool_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_asid_pool_cap_update f cap \<equiv>
     (case cap of Cap_asid_pool_cap rec \<Rightarrow>
        Cap_asid_pool_cap (f rec))"

definition cap_asid_pool_cap_lift :: "cap_C \<Rightarrow> cap_asid_pool_cap_CL" where
  "cap_asid_pool_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_asid_pool_cap rec) \<Rightarrow> rec"

lemma cap_asid_pool_cap_lift:
  "(cap_get_tag c = scast cap_asid_pool_cap) = (cap_lift c = Some (Cap_asid_pool_cap (cap_asid_pool_cap_lift c)))"
  unfolding cap_lift_def cap_asid_pool_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_page_table_cap_access ::
  "(cap_page_table_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_page_table_cap_access f cap \<equiv>
     (case cap of Cap_page_table_cap rec \<Rightarrow> f rec)"

definition cap_page_table_cap_update ::
  "(cap_page_table_cap_CL \<Rightarrow> cap_page_table_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_page_table_cap_update f cap \<equiv>
     (case cap of Cap_page_table_cap rec \<Rightarrow>
        Cap_page_table_cap (f rec))"

definition cap_page_table_cap_lift :: "cap_C \<Rightarrow> cap_page_table_cap_CL" where
  "cap_page_table_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_page_table_cap rec) \<Rightarrow> rec"

lemma cap_page_table_cap_lift:
  "(cap_get_tag c = scast cap_page_table_cap) = (cap_lift c = Some (Cap_page_table_cap (cap_page_table_cap_lift c)))"
  unfolding cap_lift_def cap_page_table_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_page_directory_cap_access ::
  "(cap_page_directory_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_page_directory_cap_access f cap \<equiv>
     (case cap of Cap_page_directory_cap rec \<Rightarrow> f rec)"

definition cap_page_directory_cap_update ::
  "(cap_page_directory_cap_CL \<Rightarrow> cap_page_directory_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_page_directory_cap_update f cap \<equiv>
     (case cap of Cap_page_directory_cap rec \<Rightarrow>
        Cap_page_directory_cap (f rec))"

definition cap_page_directory_cap_lift :: "cap_C \<Rightarrow> cap_page_directory_cap_CL" where
  "cap_page_directory_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_page_directory_cap rec) \<Rightarrow> rec"

lemma cap_page_directory_cap_lift:
  "(cap_get_tag c = scast cap_page_directory_cap) = (cap_lift c = Some (Cap_page_directory_cap (cap_page_directory_cap_lift c)))"
  unfolding cap_lift_def cap_page_directory_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_irq_handler_cap_access ::
  "(cap_irq_handler_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_irq_handler_cap_access f cap \<equiv>
     (case cap of Cap_irq_handler_cap rec \<Rightarrow> f rec)"

definition cap_irq_handler_cap_update ::
  "(cap_irq_handler_cap_CL \<Rightarrow> cap_irq_handler_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_irq_handler_cap_update f cap \<equiv>
     (case cap of Cap_irq_handler_cap rec \<Rightarrow>
        Cap_irq_handler_cap (f rec))"

definition cap_irq_handler_cap_lift :: "cap_C \<Rightarrow> cap_irq_handler_cap_CL" where
  "cap_irq_handler_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_irq_handler_cap rec) \<Rightarrow> rec"

lemma cap_irq_handler_cap_lift:
  "(cap_get_tag c = scast cap_irq_handler_cap) = (cap_lift c = Some (Cap_irq_handler_cap (cap_irq_handler_cap_lift c)))"
  unfolding cap_lift_def cap_irq_handler_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

definition cap_zombie_cap_access ::
  "(cap_zombie_cap_CL \<Rightarrow> 'a) \<Rightarrow> cap_CL \<Rightarrow> 'a" where
  "cap_zombie_cap_access f cap \<equiv>
     (case cap of Cap_zombie_cap rec \<Rightarrow> f rec)"

definition cap_zombie_cap_update ::
  "(cap_zombie_cap_CL \<Rightarrow> cap_zombie_cap_CL) \<Rightarrow>cap_CL \<Rightarrow> cap_CL" where
  "cap_zombie_cap_update f cap \<equiv>
     (case cap of Cap_zombie_cap rec \<Rightarrow>
        Cap_zombie_cap (f rec))"

definition cap_zombie_cap_lift :: "cap_C \<Rightarrow> cap_zombie_cap_CL" where
  "cap_zombie_cap_lift cap \<equiv>
    case (cap_lift cap) of Some (Cap_zombie_cap rec) \<Rightarrow> rec"

lemma cap_zombie_cap_lift:
  "(cap_get_tag c = scast cap_zombie_cap) = (cap_lift c = Some (Cap_zombie_cap (cap_zombie_cap_lift c)))"
  unfolding cap_lift_def cap_zombie_cap_lift_def
  by (clarsimp simp: cap_tag_defs Let_def)

lemmas cap_lifts =
	cap_untyped_cap_lift
	cap_endpoint_cap_lift
	cap_notification_cap_lift
	cap_reply_cap_lift
	cap_cnode_cap_lift
	cap_thread_cap_lift
	cap_small_frame_cap_lift
	cap_frame_cap_lift
	cap_asid_pool_cap_lift
	cap_page_table_cap_lift
	cap_page_directory_cap_lift
	cap_irq_handler_cap_lift
	cap_zombie_cap_lift


record lookup_fault_missing_capability_CL =
    bitsLeft_CL :: "word32"

record lookup_fault_depth_mismatch_CL =
    bitsFound_CL :: "word32"
    bitsLeft_CL :: "word32"

record lookup_fault_guard_mismatch_CL =
    guardFound_CL :: "word32"
    bitsLeft_CL :: "word32"
    bitsFound_CL :: "word32"

datatype lookup_fault_CL =
    Lookup_fault_invalid_root
  | Lookup_fault_missing_capability lookup_fault_missing_capability_CL
  | Lookup_fault_depth_mismatch lookup_fault_depth_mismatch_CL
  | Lookup_fault_guard_mismatch lookup_fault_guard_mismatch_CL

definition lookup_fault_get_tag :: "lookup_fault_C \<Rightarrow> word32" where
  "lookup_fault_get_tag lookup_fault \<equiv>
     ((index (lookup_fault_C.words_C lookup_fault) 0) >> 0) AND mask 2"

lemma lookup_fault_get_tag_eq_x:
  "(lookup_fault_get_tag c = x) = ((((index (lookup_fault_C.words_C c) 0) >> 0) AND mask 2) = x)"
  by (auto simp add: lookup_fault_get_tag_def mask_def word_bw_assocs)

definition lookup_fault_lift :: "lookup_fault_C \<Rightarrow> lookup_fault_CL option" where
  "lookup_fault_lift lookup_fault \<equiv>
    (let tag = lookup_fault_get_tag lookup_fault in
     if tag = scast lookup_fault_invalid_root then Some (Lookup_fault_invalid_root)
     else if tag = scast lookup_fault_missing_capability then Some (Lookup_fault_missing_capability \<lparr> 
       lookup_fault_missing_capability_CL.bitsLeft_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 2) AND mask 6) \<rparr>)
     else if tag = scast lookup_fault_depth_mismatch then Some (Lookup_fault_depth_mismatch \<lparr> 
       lookup_fault_depth_mismatch_CL.bitsFound_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 8) AND mask 6),
       lookup_fault_depth_mismatch_CL.bitsLeft_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 2) AND mask 6) \<rparr>)
     else if tag = scast lookup_fault_guard_mismatch then Some (Lookup_fault_guard_mismatch \<lparr> 
       lookup_fault_guard_mismatch_CL.guardFound_CL = (((index (lookup_fault_C.words_C lookup_fault) 1) >> 0)),
       lookup_fault_guard_mismatch_CL.bitsLeft_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 8) AND mask 6),
       lookup_fault_guard_mismatch_CL.bitsFound_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 2) AND mask 6) \<rparr>)
     else None)"

lemma lookup_fault_lift_invalid_root:
  "lookup_fault_get_tag lookup_fault = scast lookup_fault_invalid_root \<Longrightarrow>
  lookup_fault_lift lookup_fault =
  Some (Lookup_fault_invalid_root)"
  by (simp add:lookup_fault_lift_def lookup_fault_tag_defs)

lemma lookup_fault_lift_missing_capability:
  "lookup_fault_get_tag lookup_fault = scast lookup_fault_missing_capability \<Longrightarrow>
  lookup_fault_lift lookup_fault =
  Some (Lookup_fault_missing_capability \<lparr> 
       lookup_fault_missing_capability_CL.bitsLeft_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 2) AND mask 6) \<rparr>)"
  by (simp add:lookup_fault_lift_def lookup_fault_tag_defs)

lemma lookup_fault_lift_depth_mismatch:
  "lookup_fault_get_tag lookup_fault = scast lookup_fault_depth_mismatch \<Longrightarrow>
  lookup_fault_lift lookup_fault =
  Some (Lookup_fault_depth_mismatch \<lparr> 
       lookup_fault_depth_mismatch_CL.bitsFound_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 8) AND mask 6),
       lookup_fault_depth_mismatch_CL.bitsLeft_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 2) AND mask 6) \<rparr>)"
  by (simp add:lookup_fault_lift_def lookup_fault_tag_defs)

lemma lookup_fault_lift_guard_mismatch:
  "lookup_fault_get_tag lookup_fault = scast lookup_fault_guard_mismatch \<Longrightarrow>
  lookup_fault_lift lookup_fault =
  Some (Lookup_fault_guard_mismatch \<lparr> 
       lookup_fault_guard_mismatch_CL.guardFound_CL = (((index (lookup_fault_C.words_C lookup_fault) 1) >> 0)),
       lookup_fault_guard_mismatch_CL.bitsLeft_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 8) AND mask 6),
       lookup_fault_guard_mismatch_CL.bitsFound_CL = (((index (lookup_fault_C.words_C lookup_fault) 0) >> 2) AND mask 6) \<rparr>)"
  by (simp add:lookup_fault_lift_def lookup_fault_tag_defs)


definition lookup_fault_missing_capability_access ::
  "(lookup_fault_missing_capability_CL \<Rightarrow> 'a) \<Rightarrow> lookup_fault_CL \<Rightarrow> 'a" where
  "lookup_fault_missing_capability_access f lookup_fault \<equiv>
     (case lookup_fault of Lookup_fault_missing_capability rec \<Rightarrow> f rec)"

definition lookup_fault_missing_capability_update ::
  "(lookup_fault_missing_capability_CL \<Rightarrow> lookup_fault_missing_capability_CL) \<Rightarrow>lookup_fault_CL \<Rightarrow> lookup_fault_CL" where
  "lookup_fault_missing_capability_update f lookup_fault \<equiv>
     (case lookup_fault of Lookup_fault_missing_capability rec \<Rightarrow>
        Lookup_fault_missing_capability (f rec))"

definition lookup_fault_missing_capability_lift :: "lookup_fault_C \<Rightarrow> lookup_fault_missing_capability_CL" where
  "lookup_fault_missing_capability_lift lookup_fault \<equiv>
    case (lookup_fault_lift lookup_fault) of Some (Lookup_fault_missing_capability rec) \<Rightarrow> rec"

lemma lookup_fault_missing_capability_lift:
  "(lookup_fault_get_tag c = scast lookup_fault_missing_capability) = (lookup_fault_lift c = Some (Lookup_fault_missing_capability (lookup_fault_missing_capability_lift c)))"
  unfolding lookup_fault_lift_def lookup_fault_missing_capability_lift_def
  by (clarsimp simp: lookup_fault_tag_defs Let_def)

definition lookup_fault_depth_mismatch_access ::
  "(lookup_fault_depth_mismatch_CL \<Rightarrow> 'a) \<Rightarrow> lookup_fault_CL \<Rightarrow> 'a" where
  "lookup_fault_depth_mismatch_access f lookup_fault \<equiv>
     (case lookup_fault of Lookup_fault_depth_mismatch rec \<Rightarrow> f rec)"

definition lookup_fault_depth_mismatch_update ::
  "(lookup_fault_depth_mismatch_CL \<Rightarrow> lookup_fault_depth_mismatch_CL) \<Rightarrow>lookup_fault_CL \<Rightarrow> lookup_fault_CL" where
  "lookup_fault_depth_mismatch_update f lookup_fault \<equiv>
     (case lookup_fault of Lookup_fault_depth_mismatch rec \<Rightarrow>
        Lookup_fault_depth_mismatch (f rec))"

definition lookup_fault_depth_mismatch_lift :: "lookup_fault_C \<Rightarrow> lookup_fault_depth_mismatch_CL" where
  "lookup_fault_depth_mismatch_lift lookup_fault \<equiv>
    case (lookup_fault_lift lookup_fault) of Some (Lookup_fault_depth_mismatch rec) \<Rightarrow> rec"

lemma lookup_fault_depth_mismatch_lift:
  "(lookup_fault_get_tag c = scast lookup_fault_depth_mismatch) = (lookup_fault_lift c = Some (Lookup_fault_depth_mismatch (lookup_fault_depth_mismatch_lift c)))"
  unfolding lookup_fault_lift_def lookup_fault_depth_mismatch_lift_def
  by (clarsimp simp: lookup_fault_tag_defs Let_def)

definition lookup_fault_guard_mismatch_access ::
  "(lookup_fault_guard_mismatch_CL \<Rightarrow> 'a) \<Rightarrow> lookup_fault_CL \<Rightarrow> 'a" where
  "lookup_fault_guard_mismatch_access f lookup_fault \<equiv>
     (case lookup_fault of Lookup_fault_guard_mismatch rec \<Rightarrow> f rec)"

definition lookup_fault_guard_mismatch_update ::
  "(lookup_fault_guard_mismatch_CL \<Rightarrow> lookup_fault_guard_mismatch_CL) \<Rightarrow>lookup_fault_CL \<Rightarrow> lookup_fault_CL" where
  "lookup_fault_guard_mismatch_update f lookup_fault \<equiv>
     (case lookup_fault of Lookup_fault_guard_mismatch rec \<Rightarrow>
        Lookup_fault_guard_mismatch (f rec))"

definition lookup_fault_guard_mismatch_lift :: "lookup_fault_C \<Rightarrow> lookup_fault_guard_mismatch_CL" where
  "lookup_fault_guard_mismatch_lift lookup_fault \<equiv>
    case (lookup_fault_lift lookup_fault) of Some (Lookup_fault_guard_mismatch rec) \<Rightarrow> rec"

lemma lookup_fault_guard_mismatch_lift:
  "(lookup_fault_get_tag c = scast lookup_fault_guard_mismatch) = (lookup_fault_lift c = Some (Lookup_fault_guard_mismatch (lookup_fault_guard_mismatch_lift c)))"
  unfolding lookup_fault_lift_def lookup_fault_guard_mismatch_lift_def
  by (clarsimp simp: lookup_fault_tag_defs Let_def)

lemmas lookup_fault_lifts =
	lookup_fault_missing_capability_lift
	lookup_fault_depth_mismatch_lift
	lookup_fault_guard_mismatch_lift


record pde_pde_invalid_CL =
    stored_hw_asid_CL :: "word32"
    stored_asid_valid_CL :: "word32"

record pde_pde_coarse_CL =
    address_CL :: "word32"
    P_CL :: "word32"
    Domain_CL :: "word32"

record pde_pde_section_CL =
    address_CL :: "word32"
    size_CL :: "word32"
    nG_CL :: "word32"
    S_CL :: "word32"
    APX_CL :: "word32"
    TEX_CL :: "word32"
    AP_CL :: "word32"
    P_CL :: "word32"
    Domain_CL :: "word32"
    XN_CL :: "word32"
    C_CL :: "word32"
    B_CL :: "word32"

datatype pde_CL =
    Pde_pde_invalid pde_pde_invalid_CL
  | Pde_pde_coarse pde_pde_coarse_CL
  | Pde_pde_section pde_pde_section_CL
  | Pde_pde_reserved

definition pde_get_tag :: "pde_C \<Rightarrow> word32" where
  "pde_get_tag pde \<equiv>
     ((index (pde_C.words_C pde) 0) >> 0) AND mask 2"

lemma pde_get_tag_eq_x:
  "(pde_get_tag c = x) = ((((index (pde_C.words_C c) 0) >> 0) AND mask 2) = x)"
  by (auto simp add: pde_get_tag_def mask_def word_bw_assocs)

definition pde_lift :: "pde_C \<Rightarrow> pde_CL option" where
  "pde_lift pde \<equiv>
    (let tag = pde_get_tag pde in
     if tag = scast pde_pde_invalid then Some (Pde_pde_invalid \<lparr> 
       pde_pde_invalid_CL.stored_hw_asid_CL = (((index (pde_C.words_C pde) 0) >> 24) AND mask 8),
       pde_pde_invalid_CL.stored_asid_valid_CL = (((index (pde_C.words_C pde) 0) >> 23) AND mask 1) \<rparr>)
     else if tag = scast pde_pde_coarse then Some (Pde_pde_coarse \<lparr> 
       pde_pde_coarse_CL.address_CL = (((index (pde_C.words_C pde) 0) << 0) AND NOT (mask 10)),
       pde_pde_coarse_CL.P_CL = (((index (pde_C.words_C pde) 0) >> 9) AND mask 1),
       pde_pde_coarse_CL.Domain_CL = (((index (pde_C.words_C pde) 0) >> 5) AND mask 4) \<rparr>)
     else if tag = scast pde_pde_section then Some (Pde_pde_section \<lparr> 
       pde_pde_section_CL.address_CL = (((index (pde_C.words_C pde) 0) << 0) AND NOT (mask 20)),
       pde_pde_section_CL.size_CL = (((index (pde_C.words_C pde) 0) >> 18) AND mask 1),
       pde_pde_section_CL.nG_CL = (((index (pde_C.words_C pde) 0) >> 17) AND mask 1),
       pde_pde_section_CL.S_CL = (((index (pde_C.words_C pde) 0) >> 16) AND mask 1),
       pde_pde_section_CL.APX_CL = (((index (pde_C.words_C pde) 0) >> 15) AND mask 1),
       pde_pde_section_CL.TEX_CL = (((index (pde_C.words_C pde) 0) >> 12) AND mask 3),
       pde_pde_section_CL.AP_CL = (((index (pde_C.words_C pde) 0) >> 10) AND mask 2),
       pde_pde_section_CL.P_CL = (((index (pde_C.words_C pde) 0) >> 9) AND mask 1),
       pde_pde_section_CL.Domain_CL = (((index (pde_C.words_C pde) 0) >> 5) AND mask 4),
       pde_pde_section_CL.XN_CL = (((index (pde_C.words_C pde) 0) >> 4) AND mask 1),
       pde_pde_section_CL.C_CL = (((index (pde_C.words_C pde) 0) >> 3) AND mask 1),
       pde_pde_section_CL.B_CL = (((index (pde_C.words_C pde) 0) >> 2) AND mask 1) \<rparr>)
     else if tag = scast pde_pde_reserved then Some (Pde_pde_reserved)
     else None)"

lemma pde_lift_pde_invalid:
  "pde_get_tag pde = scast pde_pde_invalid \<Longrightarrow>
  pde_lift pde =
  Some (Pde_pde_invalid \<lparr> 
       pde_pde_invalid_CL.stored_hw_asid_CL = (((index (pde_C.words_C pde) 0) >> 24) AND mask 8),
       pde_pde_invalid_CL.stored_asid_valid_CL = (((index (pde_C.words_C pde) 0) >> 23) AND mask 1) \<rparr>)"
  by (simp add:pde_lift_def pde_tag_defs)

lemma pde_lift_pde_coarse:
  "pde_get_tag pde = scast pde_pde_coarse \<Longrightarrow>
  pde_lift pde =
  Some (Pde_pde_coarse \<lparr> 
       pde_pde_coarse_CL.address_CL = (((index (pde_C.words_C pde) 0) << 0) AND NOT (mask 10)),
       pde_pde_coarse_CL.P_CL = (((index (pde_C.words_C pde) 0) >> 9) AND mask 1),
       pde_pde_coarse_CL.Domain_CL = (((index (pde_C.words_C pde) 0) >> 5) AND mask 4) \<rparr>)"
  by (simp add:pde_lift_def pde_tag_defs)

lemma pde_lift_pde_section:
  "pde_get_tag pde = scast pde_pde_section \<Longrightarrow>
  pde_lift pde =
  Some (Pde_pde_section \<lparr> 
       pde_pde_section_CL.address_CL = (((index (pde_C.words_C pde) 0) << 0) AND NOT (mask 20)),
       pde_pde_section_CL.size_CL = (((index (pde_C.words_C pde) 0) >> 18) AND mask 1),
       pde_pde_section_CL.nG_CL = (((index (pde_C.words_C pde) 0) >> 17) AND mask 1),
       pde_pde_section_CL.S_CL = (((index (pde_C.words_C pde) 0) >> 16) AND mask 1),
       pde_pde_section_CL.APX_CL = (((index (pde_C.words_C pde) 0) >> 15) AND mask 1),
       pde_pde_section_CL.TEX_CL = (((index (pde_C.words_C pde) 0) >> 12) AND mask 3),
       pde_pde_section_CL.AP_CL = (((index (pde_C.words_C pde) 0) >> 10) AND mask 2),
       pde_pde_section_CL.P_CL = (((index (pde_C.words_C pde) 0) >> 9) AND mask 1),
       pde_pde_section_CL.Domain_CL = (((index (pde_C.words_C pde) 0) >> 5) AND mask 4),
       pde_pde_section_CL.XN_CL = (((index (pde_C.words_C pde) 0) >> 4) AND mask 1),
       pde_pde_section_CL.C_CL = (((index (pde_C.words_C pde) 0) >> 3) AND mask 1),
       pde_pde_section_CL.B_CL = (((index (pde_C.words_C pde) 0) >> 2) AND mask 1) \<rparr>)"
  by (simp add:pde_lift_def pde_tag_defs)

lemma pde_lift_pde_reserved:
  "pde_get_tag pde = scast pde_pde_reserved \<Longrightarrow>
  pde_lift pde =
  Some (Pde_pde_reserved)"
  by (simp add:pde_lift_def pde_tag_defs)


definition pde_pde_invalid_access ::
  "(pde_pde_invalid_CL \<Rightarrow> 'a) \<Rightarrow> pde_CL \<Rightarrow> 'a" where
  "pde_pde_invalid_access f pde \<equiv>
     (case pde of Pde_pde_invalid rec \<Rightarrow> f rec)"

definition pde_pde_invalid_update ::
  "(pde_pde_invalid_CL \<Rightarrow> pde_pde_invalid_CL) \<Rightarrow>pde_CL \<Rightarrow> pde_CL" where
  "pde_pde_invalid_update f pde \<equiv>
     (case pde of Pde_pde_invalid rec \<Rightarrow>
        Pde_pde_invalid (f rec))"

definition pde_pde_invalid_lift :: "pde_C \<Rightarrow> pde_pde_invalid_CL" where
  "pde_pde_invalid_lift pde \<equiv>
    case (pde_lift pde) of Some (Pde_pde_invalid rec) \<Rightarrow> rec"

lemma pde_pde_invalid_lift:
  "(pde_get_tag c = scast pde_pde_invalid) = (pde_lift c = Some (Pde_pde_invalid (pde_pde_invalid_lift c)))"
  unfolding pde_lift_def pde_pde_invalid_lift_def
  by (clarsimp simp: pde_tag_defs Let_def)

definition pde_pde_coarse_access ::
  "(pde_pde_coarse_CL \<Rightarrow> 'a) \<Rightarrow> pde_CL \<Rightarrow> 'a" where
  "pde_pde_coarse_access f pde \<equiv>
     (case pde of Pde_pde_coarse rec \<Rightarrow> f rec)"

definition pde_pde_coarse_update ::
  "(pde_pde_coarse_CL \<Rightarrow> pde_pde_coarse_CL) \<Rightarrow>pde_CL \<Rightarrow> pde_CL" where
  "pde_pde_coarse_update f pde \<equiv>
     (case pde of Pde_pde_coarse rec \<Rightarrow>
        Pde_pde_coarse (f rec))"

definition pde_pde_coarse_lift :: "pde_C \<Rightarrow> pde_pde_coarse_CL" where
  "pde_pde_coarse_lift pde \<equiv>
    case (pde_lift pde) of Some (Pde_pde_coarse rec) \<Rightarrow> rec"

lemma pde_pde_coarse_lift:
  "(pde_get_tag c = scast pde_pde_coarse) = (pde_lift c = Some (Pde_pde_coarse (pde_pde_coarse_lift c)))"
  unfolding pde_lift_def pde_pde_coarse_lift_def
  by (clarsimp simp: pde_tag_defs Let_def)

definition pde_pde_section_access ::
  "(pde_pde_section_CL \<Rightarrow> 'a) \<Rightarrow> pde_CL \<Rightarrow> 'a" where
  "pde_pde_section_access f pde \<equiv>
     (case pde of Pde_pde_section rec \<Rightarrow> f rec)"

definition pde_pde_section_update ::
  "(pde_pde_section_CL \<Rightarrow> pde_pde_section_CL) \<Rightarrow>pde_CL \<Rightarrow> pde_CL" where
  "pde_pde_section_update f pde \<equiv>
     (case pde of Pde_pde_section rec \<Rightarrow>
        Pde_pde_section (f rec))"

definition pde_pde_section_lift :: "pde_C \<Rightarrow> pde_pde_section_CL" where
  "pde_pde_section_lift pde \<equiv>
    case (pde_lift pde) of Some (Pde_pde_section rec) \<Rightarrow> rec"

lemma pde_pde_section_lift:
  "(pde_get_tag c = scast pde_pde_section) = (pde_lift c = Some (Pde_pde_section (pde_pde_section_lift c)))"
  unfolding pde_lift_def pde_pde_section_lift_def
  by (clarsimp simp: pde_tag_defs Let_def)

lemmas pde_lifts =
	pde_pde_invalid_lift
	pde_pde_coarse_lift
	pde_pde_section_lift


record pte_pte_large_CL =
    address_CL :: "word32"
    XN_CL :: "word32"
    TEX_CL :: "word32"
    nG_CL :: "word32"
    S_CL :: "word32"
    APX_CL :: "word32"
    AP_CL :: "word32"
    C_CL :: "word32"
    B_CL :: "word32"
    reserved_CL :: "word32"

record pte_pte_small_CL =
    address_CL :: "word32"
    nG_CL :: "word32"
    S_CL :: "word32"
    APX_CL :: "word32"
    TEX_CL :: "word32"
    AP_CL :: "word32"
    C_CL :: "word32"
    B_CL :: "word32"
    XN_CL :: "word32"

datatype pte_CL =
    Pte_pte_large pte_pte_large_CL
  | Pte_pte_small pte_pte_small_CL

definition pte_get_tag :: "pte_C \<Rightarrow> word32" where
  "pte_get_tag pte \<equiv>
     ((index (pte_C.words_C pte) 0) >> 1) AND mask 1"

lemma pte_get_tag_eq_x:
  "(pte_get_tag c = x) = ((((index (pte_C.words_C c) 0) >> 1) AND mask 1) = x)"
  by (auto simp add: pte_get_tag_def mask_def word_bw_assocs)

definition pte_lift :: "pte_C \<Rightarrow> pte_CL option" where
  "pte_lift pte \<equiv>
    (let tag = pte_get_tag pte in
     if tag = scast pte_pte_large then Some (Pte_pte_large \<lparr> 
       pte_pte_large_CL.address_CL = (((index (pte_C.words_C pte) 0) << 0) AND NOT (mask 16)),
       pte_pte_large_CL.XN_CL = (((index (pte_C.words_C pte) 0) >> 15) AND mask 1),
       pte_pte_large_CL.TEX_CL = (((index (pte_C.words_C pte) 0) >> 12) AND mask 3),
       pte_pte_large_CL.nG_CL = (((index (pte_C.words_C pte) 0) >> 11) AND mask 1),
       pte_pte_large_CL.S_CL = (((index (pte_C.words_C pte) 0) >> 10) AND mask 1),
       pte_pte_large_CL.APX_CL = (((index (pte_C.words_C pte) 0) >> 9) AND mask 1),
       pte_pte_large_CL.AP_CL = (((index (pte_C.words_C pte) 0) >> 4) AND mask 2),
       pte_pte_large_CL.C_CL = (((index (pte_C.words_C pte) 0) >> 3) AND mask 1),
       pte_pte_large_CL.B_CL = (((index (pte_C.words_C pte) 0) >> 2) AND mask 1),
       pte_pte_large_CL.reserved_CL = (((index (pte_C.words_C pte) 0) >> 0) AND mask 1) \<rparr>)
     else if tag = scast pte_pte_small then Some (Pte_pte_small \<lparr> 
       pte_pte_small_CL.address_CL = (((index (pte_C.words_C pte) 0) << 0) AND NOT (mask 12)),
       pte_pte_small_CL.nG_CL = (((index (pte_C.words_C pte) 0) >> 11) AND mask 1),
       pte_pte_small_CL.S_CL = (((index (pte_C.words_C pte) 0) >> 10) AND mask 1),
       pte_pte_small_CL.APX_CL = (((index (pte_C.words_C pte) 0) >> 9) AND mask 1),
       pte_pte_small_CL.TEX_CL = (((index (pte_C.words_C pte) 0) >> 6) AND mask 3),
       pte_pte_small_CL.AP_CL = (((index (pte_C.words_C pte) 0) >> 4) AND mask 2),
       pte_pte_small_CL.C_CL = (((index (pte_C.words_C pte) 0) >> 3) AND mask 1),
       pte_pte_small_CL.B_CL = (((index (pte_C.words_C pte) 0) >> 2) AND mask 1),
       pte_pte_small_CL.XN_CL = (((index (pte_C.words_C pte) 0) >> 0) AND mask 1) \<rparr>)
     else None)"

lemma pte_lift_pte_large:
  "pte_get_tag pte = scast pte_pte_large \<Longrightarrow>
  pte_lift pte =
  Some (Pte_pte_large \<lparr> 
       pte_pte_large_CL.address_CL = (((index (pte_C.words_C pte) 0) << 0) AND NOT (mask 16)),
       pte_pte_large_CL.XN_CL = (((index (pte_C.words_C pte) 0) >> 15) AND mask 1),
       pte_pte_large_CL.TEX_CL = (((index (pte_C.words_C pte) 0) >> 12) AND mask 3),
       pte_pte_large_CL.nG_CL = (((index (pte_C.words_C pte) 0) >> 11) AND mask 1),
       pte_pte_large_CL.S_CL = (((index (pte_C.words_C pte) 0) >> 10) AND mask 1),
       pte_pte_large_CL.APX_CL = (((index (pte_C.words_C pte) 0) >> 9) AND mask 1),
       pte_pte_large_CL.AP_CL = (((index (pte_C.words_C pte) 0) >> 4) AND mask 2),
       pte_pte_large_CL.C_CL = (((index (pte_C.words_C pte) 0) >> 3) AND mask 1),
       pte_pte_large_CL.B_CL = (((index (pte_C.words_C pte) 0) >> 2) AND mask 1),
       pte_pte_large_CL.reserved_CL = (((index (pte_C.words_C pte) 0) >> 0) AND mask 1) \<rparr>)"
  by (simp add:pte_lift_def pte_tag_defs)

lemma pte_lift_pte_small:
  "pte_get_tag pte = scast pte_pte_small \<Longrightarrow>
  pte_lift pte =
  Some (Pte_pte_small \<lparr> 
       pte_pte_small_CL.address_CL = (((index (pte_C.words_C pte) 0) << 0) AND NOT (mask 12)),
       pte_pte_small_CL.nG_CL = (((index (pte_C.words_C pte) 0) >> 11) AND mask 1),
       pte_pte_small_CL.S_CL = (((index (pte_C.words_C pte) 0) >> 10) AND mask 1),
       pte_pte_small_CL.APX_CL = (((index (pte_C.words_C pte) 0) >> 9) AND mask 1),
       pte_pte_small_CL.TEX_CL = (((index (pte_C.words_C pte) 0) >> 6) AND mask 3),
       pte_pte_small_CL.AP_CL = (((index (pte_C.words_C pte) 0) >> 4) AND mask 2),
       pte_pte_small_CL.C_CL = (((index (pte_C.words_C pte) 0) >> 3) AND mask 1),
       pte_pte_small_CL.B_CL = (((index (pte_C.words_C pte) 0) >> 2) AND mask 1),
       pte_pte_small_CL.XN_CL = (((index (pte_C.words_C pte) 0) >> 0) AND mask 1) \<rparr>)"
  by (simp add:pte_lift_def pte_tag_defs)


definition pte_pte_large_access ::
  "(pte_pte_large_CL \<Rightarrow> 'a) \<Rightarrow> pte_CL \<Rightarrow> 'a" where
  "pte_pte_large_access f pte \<equiv>
     (case pte of Pte_pte_large rec \<Rightarrow> f rec)"

definition pte_pte_large_update ::
  "(pte_pte_large_CL \<Rightarrow> pte_pte_large_CL) \<Rightarrow>pte_CL \<Rightarrow> pte_CL" where
  "pte_pte_large_update f pte \<equiv>
     (case pte of Pte_pte_large rec \<Rightarrow>
        Pte_pte_large (f rec))"

definition pte_pte_large_lift :: "pte_C \<Rightarrow> pte_pte_large_CL" where
  "pte_pte_large_lift pte \<equiv>
    case (pte_lift pte) of Some (Pte_pte_large rec) \<Rightarrow> rec"

lemma pte_pte_large_lift:
  "(pte_get_tag c = scast pte_pte_large) = (pte_lift c = Some (Pte_pte_large (pte_pte_large_lift c)))"
  unfolding pte_lift_def pte_pte_large_lift_def
  by (clarsimp simp: pte_tag_defs Let_def)

definition pte_pte_small_access ::
  "(pte_pte_small_CL \<Rightarrow> 'a) \<Rightarrow> pte_CL \<Rightarrow> 'a" where
  "pte_pte_small_access f pte \<equiv>
     (case pte of Pte_pte_small rec \<Rightarrow> f rec)"

definition pte_pte_small_update ::
  "(pte_pte_small_CL \<Rightarrow> pte_pte_small_CL) \<Rightarrow>pte_CL \<Rightarrow> pte_CL" where
  "pte_pte_small_update f pte \<equiv>
     (case pte of Pte_pte_small rec \<Rightarrow>
        Pte_pte_small (f rec))"

definition pte_pte_small_lift :: "pte_C \<Rightarrow> pte_pte_small_CL" where
  "pte_pte_small_lift pte \<equiv>
    case (pte_lift pte) of Some (Pte_pte_small rec) \<Rightarrow> rec"

lemma pte_pte_small_lift:
  "(pte_get_tag c = scast pte_pte_small) = (pte_lift c = Some (Pte_pte_small (pte_pte_small_lift c)))"
  unfolding pte_lift_def pte_pte_small_lift_def
  by (clarsimp simp: pte_tag_defs Let_def)

lemmas pte_lifts =
	pte_pte_large_lift
	pte_pte_small_lift


record seL4_Fault_CapFault_CL =
    address_CL :: "word32"
    inReceivePhase_CL :: "word32"

record seL4_Fault_UnknownSyscall_CL =
    syscallNumber_CL :: "word32"

record seL4_Fault_UserException_CL =
    number_CL :: "word32"
    code_CL :: "word32"

record seL4_Fault_VMFault_CL =
    address_CL :: "word32"
    FSR_CL :: "word32"
    instructionFault_CL :: "word32"

datatype seL4_Fault_CL =
    SeL4_Fault_NullFault
  | SeL4_Fault_CapFault seL4_Fault_CapFault_CL
  | SeL4_Fault_UnknownSyscall seL4_Fault_UnknownSyscall_CL
  | SeL4_Fault_UserException seL4_Fault_UserException_CL
  | SeL4_Fault_VMFault seL4_Fault_VMFault_CL

definition seL4_Fault_get_tag :: "seL4_Fault_C \<Rightarrow> word32" where
  "seL4_Fault_get_tag seL4_Fault \<equiv>
     ((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 0) AND mask 4"

lemma seL4_Fault_get_tag_eq_x:
  "(seL4_Fault_get_tag c = x) = ((((index (seL4_Fault_C.words_C c) 0) >> 0) AND mask 4) = x)"
  by (auto simp add: seL4_Fault_get_tag_def mask_def word_bw_assocs)

definition seL4_Fault_lift :: "seL4_Fault_C \<Rightarrow> seL4_Fault_CL option" where
  "seL4_Fault_lift seL4_Fault \<equiv>
    (let tag = seL4_Fault_get_tag seL4_Fault in
     if tag = scast seL4_Fault_NullFault then Some (SeL4_Fault_NullFault)
     else if tag = scast seL4_Fault_CapFault then Some (SeL4_Fault_CapFault \<lparr> 
       seL4_Fault_CapFault_CL.address_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 1) >> 0)),
       seL4_Fault_CapFault_CL.inReceivePhase_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 31) AND mask 1) \<rparr>)
     else if tag = scast seL4_Fault_UnknownSyscall then Some (SeL4_Fault_UnknownSyscall \<lparr> 
       seL4_Fault_UnknownSyscall_CL.syscallNumber_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 1) >> 0)) \<rparr>)
     else if tag = scast seL4_Fault_UserException then Some (SeL4_Fault_UserException \<lparr> 
       seL4_Fault_UserException_CL.number_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 1) >> 0)),
       seL4_Fault_UserException_CL.code_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 4) AND mask 28) \<rparr>)
     else if tag = scast seL4_Fault_VMFault then Some (SeL4_Fault_VMFault \<lparr> 
       seL4_Fault_VMFault_CL.address_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 1) >> 0)),
       seL4_Fault_VMFault_CL.FSR_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 18) AND mask 14),
       seL4_Fault_VMFault_CL.instructionFault_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 17) AND mask 1) \<rparr>)
     else None)"

lemma seL4_Fault_lift_NullFault:
  "seL4_Fault_get_tag seL4_Fault = scast seL4_Fault_NullFault \<Longrightarrow>
  seL4_Fault_lift seL4_Fault =
  Some (SeL4_Fault_NullFault)"
  by (simp add:seL4_Fault_lift_def seL4_Fault_tag_defs)

lemma seL4_Fault_lift_CapFault:
  "seL4_Fault_get_tag seL4_Fault = scast seL4_Fault_CapFault \<Longrightarrow>
  seL4_Fault_lift seL4_Fault =
  Some (SeL4_Fault_CapFault \<lparr> 
       seL4_Fault_CapFault_CL.address_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 1) >> 0)),
       seL4_Fault_CapFault_CL.inReceivePhase_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 31) AND mask 1) \<rparr>)"
  by (simp add:seL4_Fault_lift_def seL4_Fault_tag_defs)

lemma seL4_Fault_lift_UnknownSyscall:
  "seL4_Fault_get_tag seL4_Fault = scast seL4_Fault_UnknownSyscall \<Longrightarrow>
  seL4_Fault_lift seL4_Fault =
  Some (SeL4_Fault_UnknownSyscall \<lparr> 
       seL4_Fault_UnknownSyscall_CL.syscallNumber_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 1) >> 0)) \<rparr>)"
  by (simp add:seL4_Fault_lift_def seL4_Fault_tag_defs)

lemma seL4_Fault_lift_UserException:
  "seL4_Fault_get_tag seL4_Fault = scast seL4_Fault_UserException \<Longrightarrow>
  seL4_Fault_lift seL4_Fault =
  Some (SeL4_Fault_UserException \<lparr> 
       seL4_Fault_UserException_CL.number_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 1) >> 0)),
       seL4_Fault_UserException_CL.code_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 4) AND mask 28) \<rparr>)"
  by (simp add:seL4_Fault_lift_def seL4_Fault_tag_defs)

lemma seL4_Fault_lift_VMFault:
  "seL4_Fault_get_tag seL4_Fault = scast seL4_Fault_VMFault \<Longrightarrow>
  seL4_Fault_lift seL4_Fault =
  Some (SeL4_Fault_VMFault \<lparr> 
       seL4_Fault_VMFault_CL.address_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 1) >> 0)),
       seL4_Fault_VMFault_CL.FSR_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 18) AND mask 14),
       seL4_Fault_VMFault_CL.instructionFault_CL = (((index (seL4_Fault_C.words_C seL4_Fault) 0) >> 17) AND mask 1) \<rparr>)"
  by (simp add:seL4_Fault_lift_def seL4_Fault_tag_defs)


definition seL4_Fault_CapFault_access ::
  "(seL4_Fault_CapFault_CL \<Rightarrow> 'a) \<Rightarrow> seL4_Fault_CL \<Rightarrow> 'a" where
  "seL4_Fault_CapFault_access f seL4_Fault \<equiv>
     (case seL4_Fault of SeL4_Fault_CapFault rec \<Rightarrow> f rec)"

definition seL4_Fault_CapFault_update ::
  "(seL4_Fault_CapFault_CL \<Rightarrow> seL4_Fault_CapFault_CL) \<Rightarrow>seL4_Fault_CL \<Rightarrow> seL4_Fault_CL" where
  "seL4_Fault_CapFault_update f seL4_Fault \<equiv>
     (case seL4_Fault of SeL4_Fault_CapFault rec \<Rightarrow>
        SeL4_Fault_CapFault (f rec))"

definition seL4_Fault_CapFault_lift :: "seL4_Fault_C \<Rightarrow> seL4_Fault_CapFault_CL" where
  "seL4_Fault_CapFault_lift seL4_Fault \<equiv>
    case (seL4_Fault_lift seL4_Fault) of Some (SeL4_Fault_CapFault rec) \<Rightarrow> rec"

lemma seL4_Fault_CapFault_lift:
  "(seL4_Fault_get_tag c = scast seL4_Fault_CapFault) = (seL4_Fault_lift c = Some (SeL4_Fault_CapFault (seL4_Fault_CapFault_lift c)))"
  unfolding seL4_Fault_lift_def seL4_Fault_CapFault_lift_def
  by (clarsimp simp: seL4_Fault_tag_defs Let_def)

definition seL4_Fault_UnknownSyscall_access ::
  "(seL4_Fault_UnknownSyscall_CL \<Rightarrow> 'a) \<Rightarrow> seL4_Fault_CL \<Rightarrow> 'a" where
  "seL4_Fault_UnknownSyscall_access f seL4_Fault \<equiv>
     (case seL4_Fault of SeL4_Fault_UnknownSyscall rec \<Rightarrow> f rec)"

definition seL4_Fault_UnknownSyscall_update ::
  "(seL4_Fault_UnknownSyscall_CL \<Rightarrow> seL4_Fault_UnknownSyscall_CL) \<Rightarrow>seL4_Fault_CL \<Rightarrow> seL4_Fault_CL" where
  "seL4_Fault_UnknownSyscall_update f seL4_Fault \<equiv>
     (case seL4_Fault of SeL4_Fault_UnknownSyscall rec \<Rightarrow>
        SeL4_Fault_UnknownSyscall (f rec))"

definition seL4_Fault_UnknownSyscall_lift :: "seL4_Fault_C \<Rightarrow> seL4_Fault_UnknownSyscall_CL" where
  "seL4_Fault_UnknownSyscall_lift seL4_Fault \<equiv>
    case (seL4_Fault_lift seL4_Fault) of Some (SeL4_Fault_UnknownSyscall rec) \<Rightarrow> rec"

lemma seL4_Fault_UnknownSyscall_lift:
  "(seL4_Fault_get_tag c = scast seL4_Fault_UnknownSyscall) = (seL4_Fault_lift c = Some (SeL4_Fault_UnknownSyscall (seL4_Fault_UnknownSyscall_lift c)))"
  unfolding seL4_Fault_lift_def seL4_Fault_UnknownSyscall_lift_def
  by (clarsimp simp: seL4_Fault_tag_defs Let_def)

definition seL4_Fault_UserException_access ::
  "(seL4_Fault_UserException_CL \<Rightarrow> 'a) \<Rightarrow> seL4_Fault_CL \<Rightarrow> 'a" where
  "seL4_Fault_UserException_access f seL4_Fault \<equiv>
     (case seL4_Fault of SeL4_Fault_UserException rec \<Rightarrow> f rec)"

definition seL4_Fault_UserException_update ::
  "(seL4_Fault_UserException_CL \<Rightarrow> seL4_Fault_UserException_CL) \<Rightarrow>seL4_Fault_CL \<Rightarrow> seL4_Fault_CL" where
  "seL4_Fault_UserException_update f seL4_Fault \<equiv>
     (case seL4_Fault of SeL4_Fault_UserException rec \<Rightarrow>
        SeL4_Fault_UserException (f rec))"

definition seL4_Fault_UserException_lift :: "seL4_Fault_C \<Rightarrow> seL4_Fault_UserException_CL" where
  "seL4_Fault_UserException_lift seL4_Fault \<equiv>
    case (seL4_Fault_lift seL4_Fault) of Some (SeL4_Fault_UserException rec) \<Rightarrow> rec"

lemma seL4_Fault_UserException_lift:
  "(seL4_Fault_get_tag c = scast seL4_Fault_UserException) = (seL4_Fault_lift c = Some (SeL4_Fault_UserException (seL4_Fault_UserException_lift c)))"
  unfolding seL4_Fault_lift_def seL4_Fault_UserException_lift_def
  by (clarsimp simp: seL4_Fault_tag_defs Let_def)

definition seL4_Fault_VMFault_access ::
  "(seL4_Fault_VMFault_CL \<Rightarrow> 'a) \<Rightarrow> seL4_Fault_CL \<Rightarrow> 'a" where
  "seL4_Fault_VMFault_access f seL4_Fault \<equiv>
     (case seL4_Fault of SeL4_Fault_VMFault rec \<Rightarrow> f rec)"

definition seL4_Fault_VMFault_update ::
  "(seL4_Fault_VMFault_CL \<Rightarrow> seL4_Fault_VMFault_CL) \<Rightarrow>seL4_Fault_CL \<Rightarrow> seL4_Fault_CL" where
  "seL4_Fault_VMFault_update f seL4_Fault \<equiv>
     (case seL4_Fault of SeL4_Fault_VMFault rec \<Rightarrow>
        SeL4_Fault_VMFault (f rec))"

definition seL4_Fault_VMFault_lift :: "seL4_Fault_C \<Rightarrow> seL4_Fault_VMFault_CL" where
  "seL4_Fault_VMFault_lift seL4_Fault \<equiv>
    case (seL4_Fault_lift seL4_Fault) of Some (SeL4_Fault_VMFault rec) \<Rightarrow> rec"

lemma seL4_Fault_VMFault_lift:
  "(seL4_Fault_get_tag c = scast seL4_Fault_VMFault) = (seL4_Fault_lift c = Some (SeL4_Fault_VMFault (seL4_Fault_VMFault_lift c)))"
  unfolding seL4_Fault_lift_def seL4_Fault_VMFault_lift_def
  by (clarsimp simp: seL4_Fault_tag_defs Let_def)

lemmas seL4_Fault_lifts =
	seL4_Fault_CapFault_lift
	seL4_Fault_UnknownSyscall_lift
	seL4_Fault_UserException_lift
	seL4_Fault_VMFault_lift


end
