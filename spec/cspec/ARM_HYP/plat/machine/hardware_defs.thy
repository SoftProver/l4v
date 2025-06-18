theory hardware_defs
imports "../../../../../../KernelState_C"
begin


lemma word_sub_mask:
  "\<lbrakk> w && m1 = v1; m1 && m2 = m2; v1 && m2 = v2 \<rbrakk>
     \<Longrightarrow> w && m2 = v2"
  by (clarsimp simp: word_bw_assocs)


record iopte_CL =
    read_CL :: "word32"
    write_CL :: "word32"
    nonsecure_CL :: "word32"
    address_CL :: "word32"

definition iopte_lift :: "iopte_C \<Rightarrow> iopte_CL" where
  "iopte_lift iopte \<equiv> \<lparr>
       iopte_CL.read_CL = (((index (iopte_C.words_C iopte) 0) >> 31) AND mask 1),
       iopte_CL.write_CL = (((index (iopte_C.words_C iopte) 0) >> 30) AND mask 1),
       iopte_CL.nonsecure_CL = (((index (iopte_C.words_C iopte) 0) >> 29) AND mask 1),
       iopte_CL.address_CL = (((index (iopte_C.words_C iopte) 0) << 12) AND NOT (mask 12)) \<rparr>"

record iopde_iopde_4m_CL =
    read_CL :: "word32"
    write_CL :: "word32"
    nonsecure_CL :: "word32"
    address_CL :: "word32"

record iopde_iopde_pt_CL =
    read_CL :: "word32"
    write_CL :: "word32"
    nonsecure_CL :: "word32"
    address_CL :: "word32"

datatype iopde_CL =
    Iopde_iopde_4m iopde_iopde_4m_CL
  | Iopde_iopde_pt iopde_iopde_pt_CL

definition iopde_get_tag :: "iopde_C \<Rightarrow> word32" where
  "iopde_get_tag iopde \<equiv>
     ((index (iopde_C.words_C iopde) 0) >> 28) AND mask 1"

lemma iopde_get_tag_eq_x:
  "(iopde_get_tag c = x) = ((((index (iopde_C.words_C c) 0) >> 28) AND mask 1) = x)"
  by (auto simp add: iopde_get_tag_def mask_def word_bw_assocs)

definition iopde_lift :: "iopde_C \<Rightarrow> iopde_CL option" where
  "iopde_lift iopde \<equiv>
    (let tag = iopde_get_tag iopde in
     if tag = scast iopde_iopde_4m then Some (Iopde_iopde_4m \<lparr> 
       iopde_iopde_4m_CL.read_CL = (((index (iopde_C.words_C iopde) 0) >> 31) AND mask 1),
       iopde_iopde_4m_CL.write_CL = (((index (iopde_C.words_C iopde) 0) >> 30) AND mask 1),
       iopde_iopde_4m_CL.nonsecure_CL = (((index (iopde_C.words_C iopde) 0) >> 29) AND mask 1),
       iopde_iopde_4m_CL.address_CL = (((index (iopde_C.words_C iopde) 0) << 12) AND NOT (mask 22)) \<rparr>)
     else if tag = scast iopde_iopde_pt then Some (Iopde_iopde_pt \<lparr> 
       iopde_iopde_pt_CL.read_CL = (((index (iopde_C.words_C iopde) 0) >> 31) AND mask 1),
       iopde_iopde_pt_CL.write_CL = (((index (iopde_C.words_C iopde) 0) >> 30) AND mask 1),
       iopde_iopde_pt_CL.nonsecure_CL = (((index (iopde_C.words_C iopde) 0) >> 29) AND mask 1),
       iopde_iopde_pt_CL.address_CL = (((index (iopde_C.words_C iopde) 0) << 12) AND NOT (mask 12)) \<rparr>)
     else None)"

lemma iopde_lift_iopde_4m:
  "iopde_get_tag iopde = scast iopde_iopde_4m \<Longrightarrow>
  iopde_lift iopde =
  Some (Iopde_iopde_4m \<lparr> 
       iopde_iopde_4m_CL.read_CL = (((index (iopde_C.words_C iopde) 0) >> 31) AND mask 1),
       iopde_iopde_4m_CL.write_CL = (((index (iopde_C.words_C iopde) 0) >> 30) AND mask 1),
       iopde_iopde_4m_CL.nonsecure_CL = (((index (iopde_C.words_C iopde) 0) >> 29) AND mask 1),
       iopde_iopde_4m_CL.address_CL = (((index (iopde_C.words_C iopde) 0) << 12) AND NOT (mask 22)) \<rparr>)"
  by (simp add:iopde_lift_def iopde_tag_defs)

lemma iopde_lift_iopde_pt:
  "iopde_get_tag iopde = scast iopde_iopde_pt \<Longrightarrow>
  iopde_lift iopde =
  Some (Iopde_iopde_pt \<lparr> 
       iopde_iopde_pt_CL.read_CL = (((index (iopde_C.words_C iopde) 0) >> 31) AND mask 1),
       iopde_iopde_pt_CL.write_CL = (((index (iopde_C.words_C iopde) 0) >> 30) AND mask 1),
       iopde_iopde_pt_CL.nonsecure_CL = (((index (iopde_C.words_C iopde) 0) >> 29) AND mask 1),
       iopde_iopde_pt_CL.address_CL = (((index (iopde_C.words_C iopde) 0) << 12) AND NOT (mask 12)) \<rparr>)"
  by (simp add:iopde_lift_def iopde_tag_defs)


definition iopde_iopde_4m_access ::
  "(iopde_iopde_4m_CL \<Rightarrow> 'a) \<Rightarrow> iopde_CL \<Rightarrow> 'a" where
  "iopde_iopde_4m_access f iopde \<equiv>
     (case iopde of Iopde_iopde_4m rec \<Rightarrow> f rec)"

definition iopde_iopde_4m_update ::
  "(iopde_iopde_4m_CL \<Rightarrow> iopde_iopde_4m_CL) \<Rightarrow>iopde_CL \<Rightarrow> iopde_CL" where
  "iopde_iopde_4m_update f iopde \<equiv>
     (case iopde of Iopde_iopde_4m rec \<Rightarrow>
        Iopde_iopde_4m (f rec))"

definition iopde_iopde_4m_lift :: "iopde_C \<Rightarrow> iopde_iopde_4m_CL" where
  "iopde_iopde_4m_lift iopde \<equiv>
    case (iopde_lift iopde) of Some (Iopde_iopde_4m rec) \<Rightarrow> rec"

lemma iopde_iopde_4m_lift:
  "(iopde_get_tag c = scast iopde_iopde_4m) = (iopde_lift c = Some (Iopde_iopde_4m (iopde_iopde_4m_lift c)))"
  unfolding iopde_lift_def iopde_iopde_4m_lift_def
  by (clarsimp simp: iopde_tag_defs Let_def)

definition iopde_iopde_pt_access ::
  "(iopde_iopde_pt_CL \<Rightarrow> 'a) \<Rightarrow> iopde_CL \<Rightarrow> 'a" where
  "iopde_iopde_pt_access f iopde \<equiv>
     (case iopde of Iopde_iopde_pt rec \<Rightarrow> f rec)"

definition iopde_iopde_pt_update ::
  "(iopde_iopde_pt_CL \<Rightarrow> iopde_iopde_pt_CL) \<Rightarrow>iopde_CL \<Rightarrow> iopde_CL" where
  "iopde_iopde_pt_update f iopde \<equiv>
     (case iopde of Iopde_iopde_pt rec \<Rightarrow>
        Iopde_iopde_pt (f rec))"

definition iopde_iopde_pt_lift :: "iopde_C \<Rightarrow> iopde_iopde_pt_CL" where
  "iopde_iopde_pt_lift iopde \<equiv>
    case (iopde_lift iopde) of Some (Iopde_iopde_pt rec) \<Rightarrow> rec"

lemma iopde_iopde_pt_lift:
  "(iopde_get_tag c = scast iopde_iopde_pt) = (iopde_lift c = Some (Iopde_iopde_pt (iopde_iopde_pt_lift c)))"
  unfolding iopde_lift_def iopde_iopde_pt_lift_def
  by (clarsimp simp: iopde_tag_defs Let_def)

lemmas iopde_lifts =
	iopde_iopde_4m_lift
	iopde_iopde_pt_lift


end
