theory shared_types_defs
imports "../../../../../KernelState_C"
begin


lemma word_sub_mask:
  "\<lbrakk> w && m1 = v1; m1 && m2 = m2; v1 && m2 = v2 \<rbrakk>
     \<Longrightarrow> w && m2 = v2"
  by (clarsimp simp: word_bw_assocs)


record seL4_CNode_CapData_CL =
    guard_CL :: "word32"
    guardSize_CL :: "word32"

definition seL4_CNode_CapData_lift :: "seL4_CNode_CapData_C \<Rightarrow> seL4_CNode_CapData_CL" where
  "seL4_CNode_CapData_lift seL4_CNode_CapData \<equiv> \<lparr>
       seL4_CNode_CapData_CL.guard_CL = (((index (seL4_CNode_CapData_C.words_C seL4_CNode_CapData) 0) >> 8) AND mask 18),
       seL4_CNode_CapData_CL.guardSize_CL = (((index (seL4_CNode_CapData_C.words_C seL4_CNode_CapData) 0) >> 3) AND mask 5) \<rparr>"

record seL4_CapRights_CL =
    capAllowGrantReply_CL :: "word32"
    capAllowGrant_CL :: "word32"
    capAllowRead_CL :: "word32"
    capAllowWrite_CL :: "word32"

definition seL4_CapRights_lift :: "seL4_CapRights_C \<Rightarrow> seL4_CapRights_CL" where
  "seL4_CapRights_lift seL4_CapRights \<equiv> \<lparr>
       seL4_CapRights_CL.capAllowGrantReply_CL = (((index (seL4_CapRights_C.words_C seL4_CapRights) 0) >> 3) AND mask 1),
       seL4_CapRights_CL.capAllowGrant_CL = (((index (seL4_CapRights_C.words_C seL4_CapRights) 0) >> 2) AND mask 1),
       seL4_CapRights_CL.capAllowRead_CL = (((index (seL4_CapRights_C.words_C seL4_CapRights) 0) >> 1) AND mask 1),
       seL4_CapRights_CL.capAllowWrite_CL = (((index (seL4_CapRights_C.words_C seL4_CapRights) 0) >> 0) AND mask 1) \<rparr>"

record seL4_MessageInfo_CL =
    label_CL :: "word32"
    capsUnwrapped_CL :: "word32"
    extraCaps_CL :: "word32"
    length_CL :: "word32"

definition seL4_MessageInfo_lift :: "seL4_MessageInfo_C \<Rightarrow> seL4_MessageInfo_CL" where
  "seL4_MessageInfo_lift seL4_MessageInfo \<equiv> \<lparr>
       seL4_MessageInfo_CL.label_CL = (((index (seL4_MessageInfo_C.words_C seL4_MessageInfo) 0) >> 12) AND mask 20),
       seL4_MessageInfo_CL.capsUnwrapped_CL = (((index (seL4_MessageInfo_C.words_C seL4_MessageInfo) 0) >> 9) AND mask 3),
       seL4_MessageInfo_CL.extraCaps_CL = (((index (seL4_MessageInfo_C.words_C seL4_MessageInfo) 0) >> 7) AND mask 2),
       seL4_MessageInfo_CL.length_CL = (((index (seL4_MessageInfo_C.words_C seL4_MessageInfo) 0) >> 0) AND mask 7) \<rparr>"

end
