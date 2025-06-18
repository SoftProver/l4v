theory shared_types_proofs
imports shared_types_defs
begin


lemmas seL4_CNode_CapData_C_words_C_fl_simp[simp] = seL4_CNode_CapData_C_words_C_fl[simplified]

lemma seL4_CNode_CapData_ptr_words_NULL:
  "c_guard (p::seL4_CNode_CapData_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma seL4_CNode_CapData_ptr_words_aligned:
  "c_guard (p::seL4_CNode_CapData_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[1]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma seL4_CNode_CapData_ptr_words_ptr_safe:
  "ptr_safe (p::seL4_CNode_CapData_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[1]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas seL4_CNode_CapData_ptr_guards[simp] =
  seL4_CNode_CapData_ptr_words_NULL
  seL4_CNode_CapData_ptr_words_aligned
  seL4_CNode_CapData_ptr_words_ptr_safe

lemma (in kernel_all_substitute) seL4_CNode_CapData_get_guard_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_CNode_CapData_get_guard(\<acute>seL4_CNode_CapData)
       \<lbrace>\<acute>ret__unsigned = seL4_CNode_CapData_CL.guard_CL (seL4_CNode_CapData_lift \<^bsup>s\<^esup>seL4_CNode_CapData)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_CNode_CapData_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_CNode_CapData_get_guardSize_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_CNode_CapData_get_guardSize(\<acute>seL4_CNode_CapData)
       \<lbrace>\<acute>ret__unsigned = seL4_CNode_CapData_CL.guardSize_CL (seL4_CNode_CapData_lift \<^bsup>s\<^esup>seL4_CNode_CapData)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_CNode_CapData_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemmas seL4_CapRights_C_words_C_fl_simp[simp] = seL4_CapRights_C_words_C_fl[simplified]

lemma seL4_CapRights_ptr_words_NULL:
  "c_guard (p::seL4_CapRights_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma seL4_CapRights_ptr_words_aligned:
  "c_guard (p::seL4_CapRights_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[1]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma seL4_CapRights_ptr_words_ptr_safe:
  "ptr_safe (p::seL4_CapRights_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[1]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas seL4_CapRights_ptr_guards[simp] =
  seL4_CapRights_ptr_words_NULL
  seL4_CapRights_ptr_words_aligned
  seL4_CapRights_ptr_words_ptr_safe

lemma (in kernel_all_substitute) seL4_CapRights_get_capAllowGrantReply_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_CapRights_get_capAllowGrantReply(\<acute>seL4_CapRights)
       \<lbrace>\<acute>ret__unsigned = seL4_CapRights_CL.capAllowGrantReply_CL (seL4_CapRights_lift \<^bsup>s\<^esup>seL4_CapRights)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_CapRights_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_CapRights_get_capAllowGrant_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_CapRights_get_capAllowGrant(\<acute>seL4_CapRights)
       \<lbrace>\<acute>ret__unsigned = seL4_CapRights_CL.capAllowGrant_CL (seL4_CapRights_lift \<^bsup>s\<^esup>seL4_CapRights)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_CapRights_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_CapRights_get_capAllowRead_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_CapRights_get_capAllowRead(\<acute>seL4_CapRights)
       \<lbrace>\<acute>ret__unsigned = seL4_CapRights_CL.capAllowRead_CL (seL4_CapRights_lift \<^bsup>s\<^esup>seL4_CapRights)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_CapRights_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_CapRights_get_capAllowWrite_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_CapRights_get_capAllowWrite(\<acute>seL4_CapRights)
       \<lbrace>\<acute>ret__unsigned = seL4_CapRights_CL.capAllowWrite_CL (seL4_CapRights_lift \<^bsup>s\<^esup>seL4_CapRights)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_CapRights_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemmas seL4_MessageInfo_C_words_C_fl_simp[simp] = seL4_MessageInfo_C_words_C_fl[simplified]

lemma seL4_MessageInfo_ptr_words_NULL:
  "c_guard (p::seL4_MessageInfo_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma seL4_MessageInfo_ptr_words_aligned:
  "c_guard (p::seL4_MessageInfo_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[1]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma seL4_MessageInfo_ptr_words_ptr_safe:
  "ptr_safe (p::seL4_MessageInfo_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[1]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas seL4_MessageInfo_ptr_guards[simp] =
  seL4_MessageInfo_ptr_words_NULL
  seL4_MessageInfo_ptr_words_aligned
  seL4_MessageInfo_ptr_words_ptr_safe

lemma (in kernel_all_substitute) seL4_MessageInfo_new_spec:
  "\<forall> s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_MessageInfo_C :== PROC seL4_MessageInfo_new(\<acute>label, \<acute>capsUnwrapped, \<acute>extraCaps, \<acute>length)
       \<lbrace> seL4_MessageInfo_lift \<acute>ret__struct_seL4_MessageInfo_C = \<lparr>
          seL4_MessageInfo_CL.label_CL = (\<^bsup>s\<^esup>label AND mask 20),
          seL4_MessageInfo_CL.capsUnwrapped_CL = (\<^bsup>s\<^esup>capsUnwrapped AND mask 3),
          seL4_MessageInfo_CL.extraCaps_CL = (\<^bsup>s\<^esup>extraCaps AND mask 2),
          seL4_MessageInfo_CL.length_CL = (\<^bsup>s\<^esup>length AND mask 7) \<rparr> \<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (simp add: seL4_MessageInfo_lift_def)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps)?)
  done

lemma (in kernel_all_substitute) seL4_MessageInfo_get_label_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_MessageInfo_get_label(\<acute>seL4_MessageInfo)
       \<lbrace>\<acute>ret__unsigned = seL4_MessageInfo_CL.label_CL (seL4_MessageInfo_lift \<^bsup>s\<^esup>seL4_MessageInfo)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_MessageInfo_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_MessageInfo_get_capsUnwrapped_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_MessageInfo_get_capsUnwrapped(\<acute>seL4_MessageInfo)
       \<lbrace>\<acute>ret__unsigned = seL4_MessageInfo_CL.capsUnwrapped_CL (seL4_MessageInfo_lift \<^bsup>s\<^esup>seL4_MessageInfo)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_MessageInfo_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_MessageInfo_set_capsUnwrapped_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_MessageInfo_C :== PROC seL4_MessageInfo_set_capsUnwrapped(\<acute>seL4_MessageInfo, \<acute>v32)
       \<lbrace>seL4_MessageInfo_lift \<acute>ret__struct_seL4_MessageInfo_C = seL4_MessageInfo_lift \<^bsup>s\<^esup>seL4_MessageInfo \<lparr> seL4_MessageInfo_CL.capsUnwrapped_CL :=  (\<^bsup>s\<^esup>v32 AND mask 3) \<rparr>\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps ucast_id
                        seL4_MessageInfo_lift_def
                        mask_def shift_over_ao_dists
                        multi_shift_simps word_size
                        word_ao_dist word_bw_assocs
                        NOT_eq)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_MessageInfo_get_extraCaps_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_MessageInfo_get_extraCaps(\<acute>seL4_MessageInfo)
       \<lbrace>\<acute>ret__unsigned = seL4_MessageInfo_CL.extraCaps_CL (seL4_MessageInfo_lift \<^bsup>s\<^esup>seL4_MessageInfo)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_MessageInfo_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_MessageInfo_set_extraCaps_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_MessageInfo_C :== PROC seL4_MessageInfo_set_extraCaps(\<acute>seL4_MessageInfo, \<acute>v32)
       \<lbrace>seL4_MessageInfo_lift \<acute>ret__struct_seL4_MessageInfo_C = seL4_MessageInfo_lift \<^bsup>s\<^esup>seL4_MessageInfo \<lparr> seL4_MessageInfo_CL.extraCaps_CL :=  (\<^bsup>s\<^esup>v32 AND mask 2) \<rparr>\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps ucast_id
                        seL4_MessageInfo_lift_def
                        mask_def shift_over_ao_dists
                        multi_shift_simps word_size
                        word_ao_dist word_bw_assocs
                        NOT_eq)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_MessageInfo_get_length_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_MessageInfo_get_length(\<acute>seL4_MessageInfo)
       \<lbrace>\<acute>ret__unsigned = seL4_MessageInfo_CL.length_CL (seL4_MessageInfo_lift \<^bsup>s\<^esup>seL4_MessageInfo)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: seL4_MessageInfo_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) seL4_MessageInfo_set_length_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_MessageInfo_C :== PROC seL4_MessageInfo_set_length(\<acute>seL4_MessageInfo, \<acute>v32)
       \<lbrace>seL4_MessageInfo_lift \<acute>ret__struct_seL4_MessageInfo_C = seL4_MessageInfo_lift \<^bsup>s\<^esup>seL4_MessageInfo \<lparr> seL4_MessageInfo_CL.length_CL :=  (\<^bsup>s\<^esup>v32 AND mask 7) \<rparr>\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps ucast_id
                        seL4_MessageInfo_lift_def
                        mask_def shift_over_ao_dists
                        multi_shift_simps word_size
                        word_ao_dist word_bw_assocs
                        NOT_eq)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_and_max_simps)?
  done

end
