theory structures_proofs
imports structures_defs
begin


lemmas endpoint_C_words_C_fl_simp[simp] = endpoint_C_words_C_fl[simplified]

lemma endpoint_ptr_words_NULL:
  "c_guard (p::endpoint_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma endpoint_ptr_words_aligned:
  "c_guard (p::endpoint_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[4]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma endpoint_ptr_words_ptr_safe:
  "ptr_safe (p::endpoint_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[4]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas endpoint_ptr_guards[simp] =
  endpoint_ptr_words_NULL
  endpoint_ptr_words_aligned
  endpoint_ptr_words_ptr_safe

lemma (in kernel_all_substitute) endpoint_ptr_get_epQueue_head_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>endpoint_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>endpoint_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC endpoint_ptr_get_epQueue_head(\<acute>endpoint_ptr)
            \<lbrace>\<acute>ret__unsigned = endpoint_CL.epQueue_head_CL (endpoint_lift ((the (ptrval s))))\<rbrace> " 
   unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: h_t_valid_clift_Some_iff)
  apply (simp add: endpoint_lift_def guard_simps mask_def typ_heap_simps ucast_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) endpoint_ptr_set_epQueue_head_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>endpoint_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>endpoint_ptr\<rbrace>
            PROC endpoint_ptr_set_epQueue_head(\<acute>endpoint_ptr, \<acute>v32)
            {t. \<exists>endpoint.
                              endpoint_lift endpoint =
                              endpoint_lift ((the (ptrval s))) \<lparr> endpoint_CL.epQueue_head_CL := (\<^bsup>s\<^esup>v32 AND NOT (mask 4)) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      (\<^bsup>s\<^esup>endpoint_ptr)
                                      endpoint)
                                  (t_hrs_' (globals s))
                              } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (clarsimp simp add: packed_heap_update_collapse_hrs typ_heap_simps)?
  apply (rule exI, rule conjI[rotated], rule refl)
  apply (clarsimp simp: h_t_valid_clift_Some_iff endpoint_lift_def typ_heap_simps)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) endpoint_ptr_get_epQueue_tail_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>endpoint_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>endpoint_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC endpoint_ptr_get_epQueue_tail(\<acute>endpoint_ptr)
            \<lbrace>\<acute>ret__unsigned = endpoint_CL.epQueue_tail_CL (endpoint_lift ((the (ptrval s))))\<rbrace> " 
   unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: h_t_valid_clift_Some_iff)
  apply (simp add: endpoint_lift_def guard_simps mask_def typ_heap_simps ucast_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) endpoint_ptr_set_epQueue_tail_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>endpoint_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>endpoint_ptr\<rbrace>
            PROC endpoint_ptr_set_epQueue_tail(\<acute>endpoint_ptr, \<acute>v32)
            {t. \<exists>endpoint.
                              endpoint_lift endpoint =
                              endpoint_lift ((the (ptrval s))) \<lparr> endpoint_CL.epQueue_tail_CL := (\<^bsup>s\<^esup>v32 AND NOT (mask 4)) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      (\<^bsup>s\<^esup>endpoint_ptr)
                                      endpoint)
                                  (t_hrs_' (globals s))
                              } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (clarsimp simp add: packed_heap_update_collapse_hrs typ_heap_simps)?
  apply (rule exI, rule conjI[rotated], rule refl)
  apply (clarsimp simp: h_t_valid_clift_Some_iff endpoint_lift_def typ_heap_simps)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) endpoint_ptr_get_state_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>endpoint_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>endpoint_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC endpoint_ptr_get_state(\<acute>endpoint_ptr)
            \<lbrace>\<acute>ret__unsigned = endpoint_CL.state_CL (endpoint_lift ((the (ptrval s))))\<rbrace> " 
   unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: h_t_valid_clift_Some_iff)
  apply (simp add: endpoint_lift_def guard_simps mask_def typ_heap_simps ucast_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) endpoint_ptr_set_state_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>endpoint_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>endpoint_ptr\<rbrace>
            PROC endpoint_ptr_set_state(\<acute>endpoint_ptr, \<acute>v32)
            {t. \<exists>endpoint.
                              endpoint_lift endpoint =
                              endpoint_lift ((the (ptrval s))) \<lparr> endpoint_CL.state_CL := (\<^bsup>s\<^esup>v32 AND mask 2) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      (\<^bsup>s\<^esup>endpoint_ptr)
                                      endpoint)
                                  (t_hrs_' (globals s))
                              } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (clarsimp simp add: packed_heap_update_collapse_hrs typ_heap_simps)?
  apply (rule exI, rule conjI[rotated], rule refl)
  apply (clarsimp simp: h_t_valid_clift_Some_iff endpoint_lift_def typ_heap_simps)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemmas mdb_node_C_words_C_fl_simp[simp] = mdb_node_C_words_C_fl[simplified]

lemma mdb_node_ptr_words_NULL:
  "c_guard (p::mdb_node_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma mdb_node_ptr_words_aligned:
  "c_guard (p::mdb_node_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[2]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma mdb_node_ptr_words_ptr_safe:
  "ptr_safe (p::mdb_node_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[2]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas mdb_node_ptr_guards[simp] =
  mdb_node_ptr_words_NULL
  mdb_node_ptr_words_aligned
  mdb_node_ptr_words_ptr_safe

lemma (in kernel_all_substitute) mdb_node_new_spec:
  "\<forall> s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_mdb_node_C :== PROC mdb_node_new(\<acute>mdbNext, \<acute>mdbRevocable, \<acute>mdbFirstBadged, \<acute>mdbPrev)
       \<lbrace> mdb_node_lift \<acute>ret__struct_mdb_node_C = \<lparr>
          mdb_node_CL.mdbNext_CL = (\<^bsup>s\<^esup>mdbNext AND NOT (mask 3)),
          mdb_node_CL.mdbRevocable_CL = (\<^bsup>s\<^esup>mdbRevocable AND mask 1),
          mdb_node_CL.mdbFirstBadged_CL = (\<^bsup>s\<^esup>mdbFirstBadged AND mask 1),
          mdb_node_CL.mdbPrev_CL = (\<^bsup>s\<^esup>mdbPrev AND NOT (mask 3)) \<rparr> \<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (simp add: mdb_node_lift_def)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps)?)
  done

lemma (in kernel_all_substitute) mdb_node_get_mdbNext_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC mdb_node_get_mdbNext(\<acute>mdb_node)
       \<lbrace>\<acute>ret__unsigned = mdb_node_CL.mdbNext_CL (mdb_node_lift \<^bsup>s\<^esup>mdb_node)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: mdb_node_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) mdb_node_ptr_set_mdbNext_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr)\<rbrace>
            PROC mdb_node_ptr_set_mdbNext(\<acute>mdb_node_ptr, \<acute>v32)
            {t. \<exists>mdb_node.
                              mdb_node_lift mdb_node =
                              mdb_node_lift ((cte_C.cteMDBNode_C (the (ptrval s)))) \<lparr> mdb_node_CL.mdbNext_CL := (\<^bsup>s\<^esup>v32 AND NOT (mask 3)) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr))
                                      (cte_C.cteMDBNode_C_update (\<lambda>_. mdb_node)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def mdb_node_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) mdb_node_get_mdbRevocable_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC mdb_node_get_mdbRevocable(\<acute>mdb_node)
       \<lbrace>\<acute>ret__unsigned = mdb_node_CL.mdbRevocable_CL (mdb_node_lift \<^bsup>s\<^esup>mdb_node)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: mdb_node_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) mdb_node_set_mdbRevocable_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_mdb_node_C :== PROC mdb_node_set_mdbRevocable(\<acute>mdb_node, \<acute>v32)
       \<lbrace>mdb_node_lift \<acute>ret__struct_mdb_node_C = mdb_node_lift \<^bsup>s\<^esup>mdb_node \<lparr> mdb_node_CL.mdbRevocable_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr>\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps ucast_id
                        mdb_node_lift_def
                        mask_def shift_over_ao_dists
                        multi_shift_simps word_size
                        word_ao_dist word_bw_assocs
                        NOT_eq)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_and_max_simps)?
  done

lemma (in kernel_all_substitute) mdb_node_ptr_set_mdbRevocable_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr)\<rbrace>
            PROC mdb_node_ptr_set_mdbRevocable(\<acute>mdb_node_ptr, \<acute>v32)
            {t. \<exists>mdb_node.
                              mdb_node_lift mdb_node =
                              mdb_node_lift ((cte_C.cteMDBNode_C (the (ptrval s)))) \<lparr> mdb_node_CL.mdbRevocable_CL := (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr))
                                      (cte_C.cteMDBNode_C_update (\<lambda>_. mdb_node)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def mdb_node_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) mdb_node_get_mdbFirstBadged_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC mdb_node_get_mdbFirstBadged(\<acute>mdb_node)
       \<lbrace>\<acute>ret__unsigned = mdb_node_CL.mdbFirstBadged_CL (mdb_node_lift \<^bsup>s\<^esup>mdb_node)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: mdb_node_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) mdb_node_set_mdbFirstBadged_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_mdb_node_C :== PROC mdb_node_set_mdbFirstBadged(\<acute>mdb_node, \<acute>v32)
       \<lbrace>mdb_node_lift \<acute>ret__struct_mdb_node_C = mdb_node_lift \<^bsup>s\<^esup>mdb_node \<lparr> mdb_node_CL.mdbFirstBadged_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr>\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps ucast_id
                        mdb_node_lift_def
                        mask_def shift_over_ao_dists
                        multi_shift_simps word_size
                        word_ao_dist word_bw_assocs
                        NOT_eq)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_and_max_simps)?
  done

lemma (in kernel_all_substitute) mdb_node_ptr_set_mdbFirstBadged_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr)\<rbrace>
            PROC mdb_node_ptr_set_mdbFirstBadged(\<acute>mdb_node_ptr, \<acute>v32)
            {t. \<exists>mdb_node.
                              mdb_node_lift mdb_node =
                              mdb_node_lift ((cte_C.cteMDBNode_C (the (ptrval s)))) \<lparr> mdb_node_CL.mdbFirstBadged_CL := (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr))
                                      (cte_C.cteMDBNode_C_update (\<lambda>_. mdb_node)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def mdb_node_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) mdb_node_get_mdbPrev_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC mdb_node_get_mdbPrev(\<acute>mdb_node)
       \<lbrace>\<acute>ret__unsigned = mdb_node_CL.mdbPrev_CL (mdb_node_lift \<^bsup>s\<^esup>mdb_node)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: mdb_node_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) mdb_node_set_mdbPrev_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_mdb_node_C :== PROC mdb_node_set_mdbPrev(\<acute>mdb_node, \<acute>v32)
       \<lbrace>mdb_node_lift \<acute>ret__struct_mdb_node_C = mdb_node_lift \<^bsup>s\<^esup>mdb_node \<lparr> mdb_node_CL.mdbPrev_CL :=  (\<^bsup>s\<^esup>v32 AND NOT (mask 3)) \<rparr>\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps ucast_id
                        mdb_node_lift_def
                        mask_def shift_over_ao_dists
                        multi_shift_simps word_size
                        word_ao_dist word_bw_assocs
                        NOT_eq)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_and_max_simps)?
  done

lemma (in kernel_all_substitute) mdb_node_ptr_set_mdbPrev_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr)\<rbrace>
            PROC mdb_node_ptr_set_mdbPrev(\<acute>mdb_node_ptr, \<acute>v32)
            {t. \<exists>mdb_node.
                              mdb_node_lift mdb_node =
                              mdb_node_lift ((cte_C.cteMDBNode_C (the (ptrval s)))) \<lparr> mdb_node_CL.mdbPrev_CL := (\<^bsup>s\<^esup>v32 AND NOT (mask 3)) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>mdb_node_ptr [''cteMDBNode_C''] :: cte_C ptr))
                                      (cte_C.cteMDBNode_C_update (\<lambda>_. mdb_node)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def mdb_node_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemmas notification_C_words_C_fl_simp[simp] = notification_C_words_C_fl[simplified]

lemma notification_ptr_words_NULL:
  "c_guard (p::notification_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma notification_ptr_words_aligned:
  "c_guard (p::notification_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[4]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma notification_ptr_words_ptr_safe:
  "ptr_safe (p::notification_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[4]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas notification_ptr_guards[simp] =
  notification_ptr_words_NULL
  notification_ptr_words_aligned
  notification_ptr_words_ptr_safe

lemma (in kernel_all_substitute) notification_ptr_get_ntfnBoundTCB_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC notification_ptr_get_ntfnBoundTCB(\<acute>notification_ptr)
            \<lbrace>\<acute>ret__unsigned = notification_CL.ntfnBoundTCB_CL (notification_lift ((the (ptrval s))))\<rbrace> " 
   unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: h_t_valid_clift_Some_iff)
  apply (simp add: notification_lift_def guard_simps mask_def typ_heap_simps ucast_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) notification_ptr_set_ntfnBoundTCB_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            PROC notification_ptr_set_ntfnBoundTCB(\<acute>notification_ptr, \<acute>v32)
            {t. \<exists>notification.
                              notification_lift notification =
                              notification_lift ((the (ptrval s))) \<lparr> notification_CL.ntfnBoundTCB_CL := (\<^bsup>s\<^esup>v32 AND NOT (mask 4)) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      (\<^bsup>s\<^esup>notification_ptr)
                                      notification)
                                  (t_hrs_' (globals s))
                              } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (clarsimp simp add: packed_heap_update_collapse_hrs typ_heap_simps)?
  apply (rule exI, rule conjI[rotated], rule refl)
  apply (clarsimp simp: h_t_valid_clift_Some_iff notification_lift_def typ_heap_simps)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) notification_ptr_get_ntfnMsgIdentifier_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC notification_ptr_get_ntfnMsgIdentifier(\<acute>notification_ptr)
            \<lbrace>\<acute>ret__unsigned = notification_CL.ntfnMsgIdentifier_CL (notification_lift ((the (ptrval s))))\<rbrace> " 
   unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: h_t_valid_clift_Some_iff)
  apply (simp add: notification_lift_def guard_simps mask_def typ_heap_simps ucast_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) notification_ptr_set_ntfnMsgIdentifier_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            PROC notification_ptr_set_ntfnMsgIdentifier(\<acute>notification_ptr, \<acute>v32)
            {t. \<exists>notification.
                              notification_lift notification =
                              notification_lift ((the (ptrval s))) \<lparr> notification_CL.ntfnMsgIdentifier_CL := (\<^bsup>s\<^esup>v32 AND mask 32) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      (\<^bsup>s\<^esup>notification_ptr)
                                      notification)
                                  (t_hrs_' (globals s))
                              } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (clarsimp simp add: packed_heap_update_collapse_hrs typ_heap_simps)?
  apply (rule exI, rule conjI[rotated], rule refl)
  apply (clarsimp simp: h_t_valid_clift_Some_iff notification_lift_def typ_heap_simps)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) notification_ptr_get_ntfnQueue_head_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC notification_ptr_get_ntfnQueue_head(\<acute>notification_ptr)
            \<lbrace>\<acute>ret__unsigned = notification_CL.ntfnQueue_head_CL (notification_lift ((the (ptrval s))))\<rbrace> " 
   unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: h_t_valid_clift_Some_iff)
  apply (simp add: notification_lift_def guard_simps mask_def typ_heap_simps ucast_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) notification_ptr_set_ntfnQueue_head_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            PROC notification_ptr_set_ntfnQueue_head(\<acute>notification_ptr, \<acute>v32)
            {t. \<exists>notification.
                              notification_lift notification =
                              notification_lift ((the (ptrval s))) \<lparr> notification_CL.ntfnQueue_head_CL := (\<^bsup>s\<^esup>v32 AND NOT (mask 4)) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      (\<^bsup>s\<^esup>notification_ptr)
                                      notification)
                                  (t_hrs_' (globals s))
                              } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (clarsimp simp add: packed_heap_update_collapse_hrs typ_heap_simps)?
  apply (rule exI, rule conjI[rotated], rule refl)
  apply (clarsimp simp: h_t_valid_clift_Some_iff notification_lift_def typ_heap_simps)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) notification_ptr_get_ntfnQueue_tail_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC notification_ptr_get_ntfnQueue_tail(\<acute>notification_ptr)
            \<lbrace>\<acute>ret__unsigned = notification_CL.ntfnQueue_tail_CL (notification_lift ((the (ptrval s))))\<rbrace> " 
   unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: h_t_valid_clift_Some_iff)
  apply (simp add: notification_lift_def guard_simps mask_def typ_heap_simps ucast_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) notification_ptr_set_ntfnQueue_tail_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            PROC notification_ptr_set_ntfnQueue_tail(\<acute>notification_ptr, \<acute>v32)
            {t. \<exists>notification.
                              notification_lift notification =
                              notification_lift ((the (ptrval s))) \<lparr> notification_CL.ntfnQueue_tail_CL := (\<^bsup>s\<^esup>v32 AND NOT (mask 4)) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      (\<^bsup>s\<^esup>notification_ptr)
                                      notification)
                                  (t_hrs_' (globals s))
                              } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (clarsimp simp add: packed_heap_update_collapse_hrs typ_heap_simps)?
  apply (rule exI, rule conjI[rotated], rule refl)
  apply (clarsimp simp: h_t_valid_clift_Some_iff notification_lift_def typ_heap_simps)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) notification_ptr_get_state_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC notification_ptr_get_state(\<acute>notification_ptr)
            \<lbrace>\<acute>ret__unsigned = notification_CL.state_CL (notification_lift ((the (ptrval s))))\<rbrace> " 
   unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: h_t_valid_clift_Some_iff)
  apply (simp add: notification_lift_def guard_simps mask_def typ_heap_simps ucast_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) notification_ptr_set_state_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>notification_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>notification_ptr\<rbrace>
            PROC notification_ptr_set_state(\<acute>notification_ptr, \<acute>v32)
            {t. \<exists>notification.
                              notification_lift notification =
                              notification_lift ((the (ptrval s))) \<lparr> notification_CL.state_CL := (\<^bsup>s\<^esup>v32 AND mask 2) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      (\<^bsup>s\<^esup>notification_ptr)
                                      notification)
                                  (t_hrs_' (globals s))
                              } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (clarsimp simp add: packed_heap_update_collapse_hrs typ_heap_simps)?
  apply (rule exI, rule conjI[rotated], rule refl)
  apply (clarsimp simp: h_t_valid_clift_Some_iff notification_lift_def typ_heap_simps)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemmas stored_hw_asid_C_words_C_fl_simp[simp] = stored_hw_asid_C_words_C_fl[simplified]

lemma stored_hw_asid_ptr_words_NULL:
  "c_guard (p::stored_hw_asid_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma stored_hw_asid_ptr_words_aligned:
  "c_guard (p::stored_hw_asid_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[1]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma stored_hw_asid_ptr_words_ptr_safe:
  "ptr_safe (p::stored_hw_asid_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[1]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas stored_hw_asid_ptr_guards[simp] =
  stored_hw_asid_ptr_words_NULL
  stored_hw_asid_ptr_words_aligned
  stored_hw_asid_ptr_words_ptr_safe

lemmas thread_state_C_words_C_fl_simp[simp] = thread_state_C_words_C_fl[simplified]

lemma thread_state_ptr_words_NULL:
  "c_guard (p::thread_state_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma thread_state_ptr_words_aligned:
  "c_guard (p::thread_state_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[3]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma thread_state_ptr_words_ptr_safe:
  "ptr_safe (p::thread_state_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[3]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas thread_state_ptr_guards[simp] =
  thread_state_ptr_words_NULL
  thread_state_ptr_words_aligned
  thread_state_ptr_words_ptr_safe

lemma (in kernel_all_substitute) thread_state_ptr_get_blockingIPCBadge_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            \<acute>ret__unsigned :== PROC thread_state_ptr_get_blockingIPCBadge(\<acute>thread_state_ptr)
            \<lbrace>\<acute>ret__unsigned = thread_state_CL.blockingIPCBadge_CL (thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))))\<rbrace> " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)
  apply (frule clift_subtype, simp, simp, simp)
  apply (simp add: typ_heap_simps)
  apply (simp add: thread_state_lift_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  apply (simp add: mask_shift_simps)?
  done

lemma (in kernel_all_substitute) thread_state_ptr_set_blockingIPCBadge_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            PROC thread_state_ptr_set_blockingIPCBadge(\<acute>thread_state_ptr, \<acute>v32)
            {t. \<exists>thread_state.
                              thread_state_lift thread_state =
                              thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))) \<lparr> thread_state_CL.blockingIPCBadge_CL := (\<^bsup>s\<^esup>v32 AND mask 28) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr))
                                      (tcb_C.tcbState_C_update (\<lambda>_. thread_state)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def thread_state_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) thread_state_ptr_get_blockingIPCCanGrant_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            \<acute>ret__unsigned :== PROC thread_state_ptr_get_blockingIPCCanGrant(\<acute>thread_state_ptr)
            \<lbrace>\<acute>ret__unsigned = thread_state_CL.blockingIPCCanGrant_CL (thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))))\<rbrace> " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)
  apply (frule clift_subtype, simp, simp, simp)
  apply (simp add: typ_heap_simps)
  apply (simp add: thread_state_lift_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  apply (simp add: mask_shift_simps)?
  done

lemma (in kernel_all_substitute) thread_state_ptr_set_blockingIPCCanGrant_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            PROC thread_state_ptr_set_blockingIPCCanGrant(\<acute>thread_state_ptr, \<acute>v32)
            {t. \<exists>thread_state.
                              thread_state_lift thread_state =
                              thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))) \<lparr> thread_state_CL.blockingIPCCanGrant_CL := (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr))
                                      (tcb_C.tcbState_C_update (\<lambda>_. thread_state)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def thread_state_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) thread_state_ptr_get_blockingIPCCanGrantReply_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            \<acute>ret__unsigned :== PROC thread_state_ptr_get_blockingIPCCanGrantReply(\<acute>thread_state_ptr)
            \<lbrace>\<acute>ret__unsigned = thread_state_CL.blockingIPCCanGrantReply_CL (thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))))\<rbrace> " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)
  apply (frule clift_subtype, simp, simp, simp)
  apply (simp add: typ_heap_simps)
  apply (simp add: thread_state_lift_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  apply (simp add: mask_shift_simps)?
  done

lemma (in kernel_all_substitute) thread_state_ptr_set_blockingIPCCanGrantReply_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            PROC thread_state_ptr_set_blockingIPCCanGrantReply(\<acute>thread_state_ptr, \<acute>v32)
            {t. \<exists>thread_state.
                              thread_state_lift thread_state =
                              thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))) \<lparr> thread_state_CL.blockingIPCCanGrantReply_CL := (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr))
                                      (tcb_C.tcbState_C_update (\<lambda>_. thread_state)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def thread_state_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) thread_state_ptr_get_blockingIPCIsCall_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            \<acute>ret__unsigned :== PROC thread_state_ptr_get_blockingIPCIsCall(\<acute>thread_state_ptr)
            \<lbrace>\<acute>ret__unsigned = thread_state_CL.blockingIPCIsCall_CL (thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))))\<rbrace> " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)
  apply (frule clift_subtype, simp, simp, simp)
  apply (simp add: typ_heap_simps)
  apply (simp add: thread_state_lift_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  apply (simp add: mask_shift_simps)?
  done

lemma (in kernel_all_substitute) thread_state_ptr_set_blockingIPCIsCall_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            PROC thread_state_ptr_set_blockingIPCIsCall(\<acute>thread_state_ptr, \<acute>v32)
            {t. \<exists>thread_state.
                              thread_state_lift thread_state =
                              thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))) \<lparr> thread_state_CL.blockingIPCIsCall_CL := (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr))
                                      (tcb_C.tcbState_C_update (\<lambda>_. thread_state)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def thread_state_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) thread_state_get_tcbQueued_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC thread_state_get_tcbQueued(\<acute>thread_state)
       \<lbrace>\<acute>ret__unsigned = thread_state_CL.tcbQueued_CL (thread_state_lift \<^bsup>s\<^esup>thread_state)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: thread_state_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) thread_state_ptr_set_tcbQueued_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            PROC thread_state_ptr_set_tcbQueued(\<acute>thread_state_ptr, \<acute>v32)
            {t. \<exists>thread_state.
                              thread_state_lift thread_state =
                              thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))) \<lparr> thread_state_CL.tcbQueued_CL := (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr))
                                      (tcb_C.tcbState_C_update (\<lambda>_. thread_state)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def thread_state_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) thread_state_ptr_get_blockingObject_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            \<acute>ret__unsigned :== PROC thread_state_ptr_get_blockingObject(\<acute>thread_state_ptr)
            \<lbrace>\<acute>ret__unsigned = thread_state_CL.blockingObject_CL (thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))))\<rbrace> " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)
  apply (frule clift_subtype, simp, simp, simp)
  apply (simp add: typ_heap_simps)
  apply (simp add: thread_state_lift_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  apply (simp add: mask_shift_simps)?
  done

lemma (in kernel_all_substitute) thread_state_ptr_set_blockingObject_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            PROC thread_state_ptr_set_blockingObject(\<acute>thread_state_ptr, \<acute>v32)
            {t. \<exists>thread_state.
                              thread_state_lift thread_state =
                              thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))) \<lparr> thread_state_CL.blockingObject_CL := (\<^bsup>s\<^esup>v32 AND NOT (mask 4)) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr))
                                      (tcb_C.tcbState_C_update (\<lambda>_. thread_state)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def thread_state_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) thread_state_get_tsType_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC thread_state_get_tsType(\<acute>thread_state)
       \<lbrace>\<acute>ret__unsigned = thread_state_CL.tsType_CL (thread_state_lift \<^bsup>s\<^esup>thread_state)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: thread_state_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) thread_state_ptr_get_tsType_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            \<acute>ret__unsigned :== PROC thread_state_ptr_get_tsType(\<acute>thread_state_ptr)
            \<lbrace>\<acute>ret__unsigned = thread_state_CL.tsType_CL (thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))))\<rbrace> " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)
  apply (frule clift_subtype, simp, simp, simp)
  apply (simp add: typ_heap_simps)
  apply (simp add: thread_state_lift_def)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  apply (simp add: mask_shift_simps)?
  done

lemma (in kernel_all_substitute) thread_state_ptr_set_tsType_spec:
           defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr)\<rbrace>
            PROC thread_state_ptr_set_tsType(\<acute>thread_state_ptr, \<acute>v32)
            {t. \<exists>thread_state.
                              thread_state_lift thread_state =
                              thread_state_lift ((tcb_C.tcbState_C (the (ptrval s)))) \<lparr> thread_state_CL.tsType_CL := (\<^bsup>s\<^esup>v32 AND mask 4) \<rparr> \<and>
                              t_hrs_' (globals t) = hrs_mem_update (heap_update
                                      ((cparent \<^bsup>s\<^esup>thread_state_ptr [''tcbState_C''] :: tcb_C ptr))
                                      (tcb_C.tcbState_C_update (\<lambda>_. thread_state)(the (ptrval s))))
                                  (t_hrs_' (globals s))
                              } " 
  (* Invoke vcg *)
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)

  (* Infer h_t_valid for all three levels of indirection *)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (frule h_t_valid_c_guard_field[where f="[''words_C'']"],
                                       simp, simp add: typ_uinfo_t_def)

  (* Discharge guards, including c_guard for pointers *)
  apply (simp add: h_t_valid_c_guard guard_simps)

  (* Lift field updates to bitfield struct updates *)
  apply (simp add: heap_update_field_hrs h_t_valid_c_guard typ_heap_simps)

  (* Collapse multiple updates *)
  apply (simp add: packed_heap_update_collapse_hrs)

  (* Instantiate the toplevel object *)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)

  (* Instantiate the next-level object in terms of the last *)
  apply (frule clift_subtype, simp+)

  (* Resolve pointer accesses *)
  apply (simp add: h_val_field_clift')

  (* Rewrite bitfield struct updates as enclosing struct updates *)
  apply (frule h_t_valid_c_guard)
  apply (simp add: parent_update_child)

  (* Equate the updated values *)
  apply (rule exI, rule conjI[rotated], simp add: h_val_clift')

  (* Rewrite struct updates *)
  apply (simp add: o_def thread_state_lift_def)

  (* Solve bitwise arithmetic *)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemmas vm_attributes_C_words_C_fl_simp[simp] = vm_attributes_C_words_C_fl[simplified]

lemma vm_attributes_ptr_words_NULL:
  "c_guard (p::vm_attributes_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma vm_attributes_ptr_words_aligned:
  "c_guard (p::vm_attributes_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[1]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma vm_attributes_ptr_words_ptr_safe:
  "ptr_safe (p::vm_attributes_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[1]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas vm_attributes_ptr_guards[simp] =
  vm_attributes_ptr_words_NULL
  vm_attributes_ptr_words_aligned
  vm_attributes_ptr_words_ptr_safe

lemma (in kernel_all_substitute) vm_attributes_new_spec:
  "\<forall> s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_vm_attributes_C :== PROC vm_attributes_new(\<acute>armExecuteNever, \<acute>armParityEnabled, \<acute>armPageCacheable)
       \<lbrace> vm_attributes_lift \<acute>ret__struct_vm_attributes_C = \<lparr>
          vm_attributes_CL.armExecuteNever_CL = (\<^bsup>s\<^esup>armExecuteNever AND mask 1),
          vm_attributes_CL.armParityEnabled_CL = (\<^bsup>s\<^esup>armParityEnabled AND mask 1),
          vm_attributes_CL.armPageCacheable_CL = (\<^bsup>s\<^esup>armPageCacheable AND mask 1) \<rparr> \<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps)
  apply (simp add: vm_attributes_lift_def)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps)?)
  done

lemma (in kernel_all_substitute) vm_attributes_get_armExecuteNever_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC vm_attributes_get_armExecuteNever(\<acute>vm_attributes)
       \<lbrace>\<acute>ret__unsigned = vm_attributes_CL.armExecuteNever_CL (vm_attributes_lift \<^bsup>s\<^esup>vm_attributes)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: vm_attributes_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) vm_attributes_get_armParityEnabled_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC vm_attributes_get_armParityEnabled(\<acute>vm_attributes)
       \<lbrace>\<acute>ret__unsigned = vm_attributes_CL.armParityEnabled_CL (vm_attributes_lift \<^bsup>s\<^esup>vm_attributes)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: vm_attributes_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemma (in kernel_all_substitute) vm_attributes_get_armPageCacheable_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC vm_attributes_get_armPageCacheable(\<acute>vm_attributes)
       \<lbrace>\<acute>ret__unsigned = vm_attributes_CL.armPageCacheable_CL (vm_attributes_lift \<^bsup>s\<^esup>vm_attributes)\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (simp add: vm_attributes_lift_def mask_shift_simps guard_simps)
  apply (simp add: sign_extend_def' mask_def nth_is_and_neq_0 word_bw_assocs
                   shift_over_ao_dists word_oa_dist word_and_max_simps)?
  done

lemmas cap_C_words_C_fl_simp[simp] = cap_C_words_C_fl[simplified]

lemma cap_ptr_words_NULL:
  "c_guard (p::cap_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma cap_ptr_words_aligned:
  "c_guard (p::cap_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[2]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma cap_ptr_words_ptr_safe:
  "ptr_safe (p::cap_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[2]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas cap_ptr_guards[simp] =
  cap_ptr_words_NULL
  cap_ptr_words_aligned
  cap_ptr_words_ptr_safe

lemma (in kernel_all_substitute) cap_get_capType_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC cap_get_capType(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_get_tag \<^bsup>s\<^esup>cap\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (simp add:cap_get_tag_def mask_shift_simps guard_simps)
  done

lemma (in kernel_all_substitute) cap_capType_equals_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__int :==
       PROC cap_capType_equals(\<acute>cap, \<acute>cap_type_tag)
       \<lbrace>\<acute>ret__int = of_bl [cap_get_tag \<^bsup>s\<^esup>cap = \<^bsup>s\<^esup>cap_type_tag]\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (simp add:cap_get_tag_eq_x mask_shift_simps guard_simps)
  done

lemma (in kernel_all_substitute) cap_null_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_null_cap_new()
       \<lbrace>cap_get_tag \<acute>ret__struct_cap_C = scast cap_null_cap\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  by (clarsimp simp: guard_simps
                     cap_lift_def
                     Let_def
                     cap_get_tag_def
                     mask_shift_simps
                     cap_tag_defs
                     word_of_int_hom_syms)

lemma (in kernel_all_substitute) cap_untyped_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_untyped_cap_new(\<acute>capFreeIndex, \<acute>capIsDevice, \<acute>capBlockSize, \<acute>capPtr)
       \<lbrace>cap_untyped_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_untyped_cap_CL.capFreeIndex_CL = (\<^bsup>s\<^esup>capFreeIndex___unsigned AND mask 26),
          cap_untyped_cap_CL.capIsDevice_CL = (\<^bsup>s\<^esup>capIsDevice___unsigned AND mask 1),
          cap_untyped_cap_CL.capBlockSize_CL = (\<^bsup>s\<^esup>capBlockSize___unsigned AND mask 5),
          cap_untyped_cap_CL.capPtr_CL = (\<^bsup>s\<^esup>capPtr___unsigned AND NOT (mask 4)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_untyped_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_untyped_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_untyped_cap_lift_def)
  apply (erule cap_lift_untyped_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_untyped_cap_def))?
  done

lemma (in kernel_all_substitute) cap_untyped_cap_get_capFreeIndex_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_untyped_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_untyped_cap_get_capFreeIndex(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_untyped_cap_CL.capFreeIndex_CL (cap_untyped_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_untyped_cap_lift_def)
  apply (subst cap_lift_untyped_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_untyped_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_untyped_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_untyped_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_untyped_cap_set_capFreeIndex_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_untyped_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_untyped_cap_set_capFreeIndex(\<acute>cap, \<acute>v32)
       \<lbrace>cap_untyped_cap_lift \<acute>ret__struct_cap_C = cap_untyped_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_untyped_cap_CL.capFreeIndex_CL :=  (\<^bsup>s\<^esup>v32 AND mask 26)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_untyped_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_untyped_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_untyped_cap_ptr_set_capFreeIndex_spec:
    defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr)"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr) \<and> cap_get_tag (cte_C.cap_C (the (ptrval s))) = scast cap_untyped_cap\<rbrace>
            PROC cap_untyped_cap_ptr_set_capFreeIndex(\<acute>cap_ptr, \<acute>v32)
            {t. \<exists>cap. cap_untyped_cap_lift cap =
                                    cap_untyped_cap_lift (cte_C.cap_C (the (ptrval s))) \<lparr> cap_untyped_cap_CL.capFreeIndex_CL := (\<^bsup>s\<^esup>v32 AND mask 26) \<rparr> \<and>
                                    cap_get_tag cap = scast cap_untyped_cap \<and>
                                    t_hrs_' (globals t) = hrs_mem_update (heap_update
                                            ((cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr))
                                            (cte_C.cap_C_update (\<lambda>_. cap)(the (ptrval s))))
                                        (t_hrs_' (globals s))
                                    } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (drule h_t_valid_clift_Some_iff[THEN iffD1], erule exE)
  apply (frule clift_subtype, simp, simp)
  apply (clarsimp simp: typ_heap_simps c_guard_clift
                        packed_heap_update_collapse_hrs)
  apply (simp add: guard_simps mask_shift_simps
                   cap_tag_defs[THEN tag_eq_to_tag_masked_eq])?
  apply (simp add: parent_update_child[OF c_guard_clift]
                   typ_heap_simps c_guard_clift)
  apply (simp add: o_def cap_untyped_cap_lift_def)
  apply (simp only: cap_lift_untyped_cap cong: rev_conj_cong)
  apply (rule exI, rule conjI[rotated], rule conjI[OF _ refl])
   apply (simp_all add: cap_get_tag_eq_x cap_tag_defs mask_shift_simps)
  apply (intro conjI sign_extend_eq; simp add: mask_def word_ao_dist word_bw_assocs)?
  done

lemma (in kernel_all_substitute) cap_untyped_cap_get_capIsDevice_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_untyped_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_untyped_cap_get_capIsDevice(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_untyped_cap_CL.capIsDevice_CL (cap_untyped_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_untyped_cap_lift_def)
  apply (subst cap_lift_untyped_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_untyped_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_untyped_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_untyped_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_untyped_cap_get_capBlockSize_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_untyped_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_untyped_cap_get_capBlockSize(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_untyped_cap_CL.capBlockSize_CL (cap_untyped_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_untyped_cap_lift_def)
  apply (subst cap_lift_untyped_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_untyped_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_untyped_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_untyped_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_untyped_cap_get_capPtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_untyped_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_untyped_cap_get_capPtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_untyped_cap_CL.capPtr_CL (cap_untyped_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_untyped_cap_lift_def)
  apply (subst cap_lift_untyped_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_untyped_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_untyped_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_untyped_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_endpoint_cap_new(\<acute>capEPBadge, \<acute>capCanGrantReply, \<acute>capCanGrant, \<acute>capCanSend, \<acute>capCanReceive, \<acute>capEPPtr)
       \<lbrace>cap_endpoint_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_endpoint_cap_CL.capEPBadge_CL = (\<^bsup>s\<^esup>capEPBadge___unsigned AND mask 28),
          cap_endpoint_cap_CL.capCanGrantReply_CL = (\<^bsup>s\<^esup>capCanGrantReply___unsigned AND mask 1),
          cap_endpoint_cap_CL.capCanGrant_CL = (\<^bsup>s\<^esup>capCanGrant___unsigned AND mask 1),
          cap_endpoint_cap_CL.capCanSend_CL = (\<^bsup>s\<^esup>capCanSend___unsigned AND mask 1),
          cap_endpoint_cap_CL.capCanReceive_CL = (\<^bsup>s\<^esup>capCanReceive___unsigned AND mask 1),
          cap_endpoint_cap_CL.capEPPtr_CL = (\<^bsup>s\<^esup>capEPPtr___unsigned AND NOT (mask 4)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_endpoint_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_endpoint_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_endpoint_cap_lift_def)
  apply (erule cap_lift_endpoint_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_endpoint_cap_def))?
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_get_capEPPtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_endpoint_cap_get_capEPPtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_endpoint_cap_CL.capEPPtr_CL (cap_endpoint_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_endpoint_cap_lift_def)
  apply (subst cap_lift_endpoint_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_endpoint_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_endpoint_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_endpoint_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_get_capCanGrantReply_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_endpoint_cap_get_capCanGrantReply(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_endpoint_cap_CL.capCanGrantReply_CL (cap_endpoint_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_endpoint_cap_lift_def)
  apply (subst cap_lift_endpoint_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_endpoint_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_endpoint_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_endpoint_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_set_capCanGrantReply_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_endpoint_cap_set_capCanGrantReply(\<acute>cap, \<acute>v32)
       \<lbrace>cap_endpoint_cap_lift \<acute>ret__struct_cap_C = cap_endpoint_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_endpoint_cap_CL.capCanGrantReply_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_endpoint_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_endpoint_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_get_capCanGrant_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_endpoint_cap_get_capCanGrant(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_endpoint_cap_CL.capCanGrant_CL (cap_endpoint_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_endpoint_cap_lift_def)
  apply (subst cap_lift_endpoint_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_endpoint_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_endpoint_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_endpoint_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_set_capCanGrant_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_endpoint_cap_set_capCanGrant(\<acute>cap, \<acute>v32)
       \<lbrace>cap_endpoint_cap_lift \<acute>ret__struct_cap_C = cap_endpoint_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_endpoint_cap_CL.capCanGrant_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_endpoint_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_endpoint_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_get_capCanReceive_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_endpoint_cap_get_capCanReceive(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_endpoint_cap_CL.capCanReceive_CL (cap_endpoint_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_endpoint_cap_lift_def)
  apply (subst cap_lift_endpoint_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_endpoint_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_endpoint_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_endpoint_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_set_capCanReceive_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_endpoint_cap_set_capCanReceive(\<acute>cap, \<acute>v32)
       \<lbrace>cap_endpoint_cap_lift \<acute>ret__struct_cap_C = cap_endpoint_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_endpoint_cap_CL.capCanReceive_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_endpoint_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_endpoint_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_get_capCanSend_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_endpoint_cap_get_capCanSend(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_endpoint_cap_CL.capCanSend_CL (cap_endpoint_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_endpoint_cap_lift_def)
  apply (subst cap_lift_endpoint_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_endpoint_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_endpoint_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_endpoint_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_set_capCanSend_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_endpoint_cap_set_capCanSend(\<acute>cap, \<acute>v32)
       \<lbrace>cap_endpoint_cap_lift \<acute>ret__struct_cap_C = cap_endpoint_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_endpoint_cap_CL.capCanSend_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_endpoint_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_endpoint_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_get_capEPBadge_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_endpoint_cap_get_capEPBadge(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_endpoint_cap_CL.capEPBadge_CL (cap_endpoint_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_endpoint_cap_lift_def)
  apply (subst cap_lift_endpoint_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_endpoint_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_endpoint_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_endpoint_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_endpoint_cap_set_capEPBadge_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_endpoint_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_endpoint_cap_set_capEPBadge(\<acute>cap, \<acute>v32)
       \<lbrace>cap_endpoint_cap_lift \<acute>ret__struct_cap_C = cap_endpoint_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_endpoint_cap_CL.capEPBadge_CL :=  (\<^bsup>s\<^esup>v32 AND mask 28)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_endpoint_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_endpoint_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_notification_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_notification_cap_new(\<acute>capNtfnBadge, \<acute>capNtfnCanReceive, \<acute>capNtfnCanSend, \<acute>capNtfnPtr)
       \<lbrace>cap_notification_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_notification_cap_CL.capNtfnBadge_CL = (\<^bsup>s\<^esup>capNtfnBadge___unsigned AND mask 28),
          cap_notification_cap_CL.capNtfnCanReceive_CL = (\<^bsup>s\<^esup>capNtfnCanReceive___unsigned AND mask 1),
          cap_notification_cap_CL.capNtfnCanSend_CL = (\<^bsup>s\<^esup>capNtfnCanSend___unsigned AND mask 1),
          cap_notification_cap_CL.capNtfnPtr_CL = (\<^bsup>s\<^esup>capNtfnPtr___unsigned AND NOT (mask 4)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_notification_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_notification_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_notification_cap_lift_def)
  apply (erule cap_lift_notification_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_notification_cap_def))?
  done

lemma (in kernel_all_substitute) cap_notification_cap_get_capNtfnBadge_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_notification_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_notification_cap_get_capNtfnBadge(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_notification_cap_CL.capNtfnBadge_CL (cap_notification_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_notification_cap_lift_def)
  apply (subst cap_lift_notification_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_notification_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_notification_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_notification_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_notification_cap_set_capNtfnBadge_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_notification_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_notification_cap_set_capNtfnBadge(\<acute>cap, \<acute>v32)
       \<lbrace>cap_notification_cap_lift \<acute>ret__struct_cap_C = cap_notification_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_notification_cap_CL.capNtfnBadge_CL :=  (\<^bsup>s\<^esup>v32 AND mask 28)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_notification_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_notification_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_notification_cap_get_capNtfnCanReceive_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_notification_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_notification_cap_get_capNtfnCanReceive(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_notification_cap_CL.capNtfnCanReceive_CL (cap_notification_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_notification_cap_lift_def)
  apply (subst cap_lift_notification_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_notification_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_notification_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_notification_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_notification_cap_set_capNtfnCanReceive_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_notification_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_notification_cap_set_capNtfnCanReceive(\<acute>cap, \<acute>v32)
       \<lbrace>cap_notification_cap_lift \<acute>ret__struct_cap_C = cap_notification_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_notification_cap_CL.capNtfnCanReceive_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_notification_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_notification_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_notification_cap_get_capNtfnCanSend_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_notification_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_notification_cap_get_capNtfnCanSend(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_notification_cap_CL.capNtfnCanSend_CL (cap_notification_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_notification_cap_lift_def)
  apply (subst cap_lift_notification_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_notification_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_notification_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_notification_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_notification_cap_set_capNtfnCanSend_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_notification_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_notification_cap_set_capNtfnCanSend(\<acute>cap, \<acute>v32)
       \<lbrace>cap_notification_cap_lift \<acute>ret__struct_cap_C = cap_notification_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_notification_cap_CL.capNtfnCanSend_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_notification_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_notification_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_notification_cap_get_capNtfnPtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_notification_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_notification_cap_get_capNtfnPtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_notification_cap_CL.capNtfnPtr_CL (cap_notification_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_notification_cap_lift_def)
  apply (subst cap_lift_notification_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_notification_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_notification_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_notification_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_reply_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_reply_cap_new(\<acute>capReplyCanGrant, \<acute>capReplyMaster, \<acute>capTCBPtr)
       \<lbrace>cap_reply_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_reply_cap_CL.capReplyCanGrant_CL = (\<^bsup>s\<^esup>capReplyCanGrant___unsigned AND mask 1),
          cap_reply_cap_CL.capReplyMaster_CL = (\<^bsup>s\<^esup>capReplyMaster___unsigned AND mask 1),
          cap_reply_cap_CL.capTCBPtr_CL = (\<^bsup>s\<^esup>capTCBPtr___unsigned AND NOT (mask 6)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_reply_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_reply_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_reply_cap_lift_def)
  apply (erule cap_lift_reply_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_reply_cap_def))?
  done

lemma (in kernel_all_substitute) cap_reply_cap_get_capTCBPtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_reply_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_reply_cap_get_capTCBPtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_reply_cap_CL.capTCBPtr_CL (cap_reply_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_reply_cap_lift_def)
  apply (subst cap_lift_reply_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_reply_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_reply_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_reply_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_reply_cap_get_capReplyCanGrant_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_reply_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_reply_cap_get_capReplyCanGrant(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_reply_cap_CL.capReplyCanGrant_CL (cap_reply_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_reply_cap_lift_def)
  apply (subst cap_lift_reply_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_reply_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_reply_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_reply_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_reply_cap_set_capReplyCanGrant_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_reply_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_reply_cap_set_capReplyCanGrant(\<acute>cap, \<acute>v32)
       \<lbrace>cap_reply_cap_lift \<acute>ret__struct_cap_C = cap_reply_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_reply_cap_CL.capReplyCanGrant_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_reply_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_reply_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_reply_cap_get_capReplyMaster_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_reply_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_reply_cap_get_capReplyMaster(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_reply_cap_CL.capReplyMaster_CL (cap_reply_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_reply_cap_lift_def)
  apply (subst cap_lift_reply_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_reply_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_reply_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_reply_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_cnode_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_cnode_cap_new(\<acute>capCNodeRadix, \<acute>capCNodeGuardSize, \<acute>capCNodeGuard, \<acute>capCNodePtr)
       \<lbrace>cap_cnode_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_cnode_cap_CL.capCNodeRadix_CL = (\<^bsup>s\<^esup>capCNodeRadix___unsigned AND mask 5),
          cap_cnode_cap_CL.capCNodeGuardSize_CL = (\<^bsup>s\<^esup>capCNodeGuardSize___unsigned AND mask 5),
          cap_cnode_cap_CL.capCNodeGuard_CL = (\<^bsup>s\<^esup>capCNodeGuard___unsigned AND mask 18),
          cap_cnode_cap_CL.capCNodePtr_CL = (\<^bsup>s\<^esup>capCNodePtr___unsigned AND NOT (mask 5)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_cnode_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_cnode_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_cnode_cap_lift_def)
  apply (erule cap_lift_cnode_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_cnode_cap_def))?
  done

lemma (in kernel_all_substitute) cap_cnode_cap_get_capCNodeGuardSize_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_cnode_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_cnode_cap_get_capCNodeGuardSize(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_cnode_cap_CL.capCNodeGuardSize_CL (cap_cnode_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_cnode_cap_lift_def)
  apply (subst cap_lift_cnode_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_cnode_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_cnode_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_cnode_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_cnode_cap_set_capCNodeGuardSize_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_cnode_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_cnode_cap_set_capCNodeGuardSize(\<acute>cap, \<acute>v32)
       \<lbrace>cap_cnode_cap_lift \<acute>ret__struct_cap_C = cap_cnode_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_cnode_cap_CL.capCNodeGuardSize_CL :=  (\<^bsup>s\<^esup>v32 AND mask 5)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_cnode_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_cnode_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_cnode_cap_get_capCNodeRadix_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_cnode_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_cnode_cap_get_capCNodeRadix(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_cnode_cap_CL.capCNodeRadix_CL (cap_cnode_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_cnode_cap_lift_def)
  apply (subst cap_lift_cnode_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_cnode_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_cnode_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_cnode_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_cnode_cap_get_capCNodeGuard_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_cnode_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_cnode_cap_get_capCNodeGuard(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_cnode_cap_CL.capCNodeGuard_CL (cap_cnode_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_cnode_cap_lift_def)
  apply (subst cap_lift_cnode_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_cnode_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_cnode_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_cnode_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_cnode_cap_set_capCNodeGuard_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_cnode_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_cnode_cap_set_capCNodeGuard(\<acute>cap, \<acute>v32)
       \<lbrace>cap_cnode_cap_lift \<acute>ret__struct_cap_C = cap_cnode_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_cnode_cap_CL.capCNodeGuard_CL :=  (\<^bsup>s\<^esup>v32 AND mask 18)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_cnode_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_cnode_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_cnode_cap_get_capCNodePtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_cnode_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_cnode_cap_get_capCNodePtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_cnode_cap_CL.capCNodePtr_CL (cap_cnode_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_cnode_cap_lift_def)
  apply (subst cap_lift_cnode_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_cnode_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_cnode_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_cnode_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_thread_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_thread_cap_new(\<acute>capTCBPtr)
       \<lbrace>cap_thread_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_thread_cap_CL.capTCBPtr_CL = (\<^bsup>s\<^esup>capTCBPtr___unsigned AND NOT (mask 4)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_thread_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_thread_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_thread_cap_lift_def)
  apply (erule cap_lift_thread_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_thread_cap_def))?
  done

lemma (in kernel_all_substitute) cap_thread_cap_get_capTCBPtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_thread_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_thread_cap_get_capTCBPtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_thread_cap_CL.capTCBPtr_CL (cap_thread_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_thread_cap_lift_def)
  apply (subst cap_lift_thread_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_thread_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_thread_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_thread_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_small_frame_cap_new(\<acute>capFMappedASIDLow, \<acute>capFVMRights, \<acute>capFMappedAddress, \<acute>capFIsDevice, \<acute>capFMappedASIDHigh, \<acute>capFBasePtr)
       \<lbrace>cap_small_frame_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_small_frame_cap_CL.capFMappedASIDLow_CL = (\<^bsup>s\<^esup>capFMappedASIDLow___unsigned AND mask 10),
          cap_small_frame_cap_CL.capFVMRights_CL = (\<^bsup>s\<^esup>capFVMRights___unsigned AND mask 2),
          cap_small_frame_cap_CL.capFMappedAddress_CL = (\<^bsup>s\<^esup>capFMappedAddress___unsigned AND NOT (mask 12)),
          cap_small_frame_cap_CL.capFIsDevice_CL = (\<^bsup>s\<^esup>capFIsDevice___unsigned AND mask 1),
          cap_small_frame_cap_CL.capFMappedASIDHigh_CL = (\<^bsup>s\<^esup>capFMappedASIDHigh___unsigned AND mask 7),
          cap_small_frame_cap_CL.capFBasePtr_CL = (\<^bsup>s\<^esup>capFBasePtr___unsigned AND NOT (mask 12)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_small_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_small_frame_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_small_frame_cap_lift_def)
  apply (erule cap_lift_small_frame_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_small_frame_cap_def))?
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_get_capFMappedASIDLow_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_small_frame_cap_get_capFMappedASIDLow(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_small_frame_cap_CL.capFMappedASIDLow_CL (cap_small_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_small_frame_cap_lift_def)
  apply (subst cap_lift_small_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_small_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_small_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_small_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_set_capFMappedASIDLow_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_small_frame_cap_set_capFMappedASIDLow(\<acute>cap, \<acute>v32)
       \<lbrace>cap_small_frame_cap_lift \<acute>ret__struct_cap_C = cap_small_frame_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_small_frame_cap_CL.capFMappedASIDLow_CL :=  (\<^bsup>s\<^esup>v32 AND mask 10)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_small_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_small_frame_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_get_capFVMRights_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_small_frame_cap_get_capFVMRights(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_small_frame_cap_CL.capFVMRights_CL (cap_small_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_small_frame_cap_lift_def)
  apply (subst cap_lift_small_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_small_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_small_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_small_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_set_capFVMRights_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_small_frame_cap_set_capFVMRights(\<acute>cap, \<acute>v32)
       \<lbrace>cap_small_frame_cap_lift \<acute>ret__struct_cap_C = cap_small_frame_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_small_frame_cap_CL.capFVMRights_CL :=  (\<^bsup>s\<^esup>v32 AND mask 2)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_small_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_small_frame_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_get_capFMappedAddress_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_small_frame_cap_get_capFMappedAddress(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_small_frame_cap_CL.capFMappedAddress_CL (cap_small_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_small_frame_cap_lift_def)
  apply (subst cap_lift_small_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_small_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_small_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_small_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_set_capFMappedAddress_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_small_frame_cap_set_capFMappedAddress(\<acute>cap, \<acute>v32)
       \<lbrace>cap_small_frame_cap_lift \<acute>ret__struct_cap_C = cap_small_frame_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_small_frame_cap_CL.capFMappedAddress_CL :=  (\<^bsup>s\<^esup>v32 AND NOT (mask 12))\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_small_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_small_frame_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_get_capFIsDevice_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_small_frame_cap_get_capFIsDevice(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_small_frame_cap_CL.capFIsDevice_CL (cap_small_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_small_frame_cap_lift_def)
  apply (subst cap_lift_small_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_small_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_small_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_small_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_get_capFMappedASIDHigh_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_small_frame_cap_get_capFMappedASIDHigh(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_small_frame_cap_CL.capFMappedASIDHigh_CL (cap_small_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_small_frame_cap_lift_def)
  apply (subst cap_lift_small_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_small_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_small_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_small_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_set_capFMappedASIDHigh_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_small_frame_cap_set_capFMappedASIDHigh(\<acute>cap, \<acute>v32)
       \<lbrace>cap_small_frame_cap_lift \<acute>ret__struct_cap_C = cap_small_frame_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_small_frame_cap_CL.capFMappedASIDHigh_CL :=  (\<^bsup>s\<^esup>v32 AND mask 7)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_small_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_small_frame_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_small_frame_cap_get_capFBasePtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_small_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_small_frame_cap_get_capFBasePtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_small_frame_cap_CL.capFBasePtr_CL (cap_small_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_small_frame_cap_lift_def)
  apply (subst cap_lift_small_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_small_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_small_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_small_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_frame_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_frame_cap_new(\<acute>capFSize, \<acute>capFMappedASIDLow, \<acute>capFVMRights, \<acute>capFMappedAddress, \<acute>capFIsDevice, \<acute>capFMappedASIDHigh, \<acute>capFBasePtr)
       \<lbrace>cap_frame_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_frame_cap_CL.capFSize_CL = (\<^bsup>s\<^esup>capFSize___unsigned AND mask 2),
          cap_frame_cap_CL.capFMappedASIDLow_CL = (\<^bsup>s\<^esup>capFMappedASIDLow___unsigned AND mask 10),
          cap_frame_cap_CL.capFVMRights_CL = (\<^bsup>s\<^esup>capFVMRights___unsigned AND mask 2),
          cap_frame_cap_CL.capFMappedAddress_CL = (\<^bsup>s\<^esup>capFMappedAddress___unsigned AND NOT (mask 14)),
          cap_frame_cap_CL.capFIsDevice_CL = (\<^bsup>s\<^esup>capFIsDevice___unsigned AND mask 1),
          cap_frame_cap_CL.capFMappedASIDHigh_CL = (\<^bsup>s\<^esup>capFMappedASIDHigh___unsigned AND mask 7),
          cap_frame_cap_CL.capFBasePtr_CL = (\<^bsup>s\<^esup>capFBasePtr___unsigned AND NOT (mask 14)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_frame_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_frame_cap_lift_def)
  apply (erule cap_lift_frame_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_frame_cap_def))?
  done

lemma (in kernel_all_substitute) cap_frame_cap_get_capFSize_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_frame_cap_get_capFSize(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_frame_cap_CL.capFSize_CL (cap_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_frame_cap_lift_def)
  apply (subst cap_lift_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_frame_cap_get_capFMappedASIDLow_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_frame_cap_get_capFMappedASIDLow(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_frame_cap_CL.capFMappedASIDLow_CL (cap_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_frame_cap_lift_def)
  apply (subst cap_lift_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_frame_cap_set_capFMappedASIDLow_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_frame_cap_set_capFMappedASIDLow(\<acute>cap, \<acute>v32)
       \<lbrace>cap_frame_cap_lift \<acute>ret__struct_cap_C = cap_frame_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_frame_cap_CL.capFMappedASIDLow_CL :=  (\<^bsup>s\<^esup>v32 AND mask 10)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_frame_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_frame_cap_get_capFVMRights_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_frame_cap_get_capFVMRights(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_frame_cap_CL.capFVMRights_CL (cap_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_frame_cap_lift_def)
  apply (subst cap_lift_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_frame_cap_set_capFVMRights_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_frame_cap_set_capFVMRights(\<acute>cap, \<acute>v32)
       \<lbrace>cap_frame_cap_lift \<acute>ret__struct_cap_C = cap_frame_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_frame_cap_CL.capFVMRights_CL :=  (\<^bsup>s\<^esup>v32 AND mask 2)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_frame_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_frame_cap_get_capFMappedAddress_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_frame_cap_get_capFMappedAddress(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_frame_cap_CL.capFMappedAddress_CL (cap_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_frame_cap_lift_def)
  apply (subst cap_lift_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_frame_cap_set_capFMappedAddress_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_frame_cap_set_capFMappedAddress(\<acute>cap, \<acute>v32)
       \<lbrace>cap_frame_cap_lift \<acute>ret__struct_cap_C = cap_frame_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_frame_cap_CL.capFMappedAddress_CL :=  (\<^bsup>s\<^esup>v32 AND NOT (mask 14))\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_frame_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_frame_cap_get_capFIsDevice_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_frame_cap_get_capFIsDevice(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_frame_cap_CL.capFIsDevice_CL (cap_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_frame_cap_lift_def)
  apply (subst cap_lift_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_frame_cap_get_capFMappedASIDHigh_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_frame_cap_get_capFMappedASIDHigh(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_frame_cap_CL.capFMappedASIDHigh_CL (cap_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_frame_cap_lift_def)
  apply (subst cap_lift_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_frame_cap_set_capFMappedASIDHigh_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_frame_cap_set_capFMappedASIDHigh(\<acute>cap, \<acute>v32)
       \<lbrace>cap_frame_cap_lift \<acute>ret__struct_cap_C = cap_frame_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_frame_cap_CL.capFMappedASIDHigh_CL :=  (\<^bsup>s\<^esup>v32 AND mask 7)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_frame_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_frame_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_frame_cap_get_capFBasePtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_frame_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_frame_cap_get_capFBasePtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_frame_cap_CL.capFBasePtr_CL (cap_frame_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_frame_cap_lift_def)
  apply (subst cap_lift_frame_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_frame_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_frame_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_frame_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_asid_pool_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_asid_pool_cap_new(\<acute>capASIDBase, \<acute>capASIDPool)
       \<lbrace>cap_asid_pool_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_asid_pool_cap_CL.capASIDBase_CL = (\<^bsup>s\<^esup>capASIDBase___unsigned AND mask 17),
          cap_asid_pool_cap_CL.capASIDPool_CL = (\<^bsup>s\<^esup>capASIDPool___unsigned AND NOT (mask 4)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_asid_pool_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_asid_pool_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_asid_pool_cap_lift_def)
  apply (erule cap_lift_asid_pool_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_asid_pool_cap_def))?
  done

lemma (in kernel_all_substitute) cap_asid_pool_cap_get_capASIDBase_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_asid_pool_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_asid_pool_cap_get_capASIDBase(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_asid_pool_cap_CL.capASIDBase_CL (cap_asid_pool_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_asid_pool_cap_lift_def)
  apply (subst cap_lift_asid_pool_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_asid_pool_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_asid_pool_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_asid_pool_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_asid_pool_cap_get_capASIDPool_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_asid_pool_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_asid_pool_cap_get_capASIDPool(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_asid_pool_cap_CL.capASIDPool_CL (cap_asid_pool_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_asid_pool_cap_lift_def)
  apply (subst cap_lift_asid_pool_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_asid_pool_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_asid_pool_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_asid_pool_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_page_table_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_page_table_cap_new(\<acute>capPTIsMapped, \<acute>capPTMappedASID, \<acute>capPTMappedAddress, \<acute>capPTBasePtr)
       \<lbrace>cap_page_table_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_page_table_cap_CL.capPTIsMapped_CL = (\<^bsup>s\<^esup>capPTIsMapped___unsigned AND mask 1),
          cap_page_table_cap_CL.capPTMappedASID_CL = (\<^bsup>s\<^esup>capPTMappedASID___unsigned AND mask 17),
          cap_page_table_cap_CL.capPTMappedAddress_CL = (\<^bsup>s\<^esup>capPTMappedAddress___unsigned AND NOT (mask 21)),
          cap_page_table_cap_CL.capPTBasePtr_CL = (\<^bsup>s\<^esup>capPTBasePtr___unsigned AND NOT (mask 10)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_page_table_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_page_table_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_page_table_cap_lift_def)
  apply (erule cap_lift_page_table_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_page_table_cap_def))?
  done

lemma (in kernel_all_substitute) cap_page_table_cap_get_capPTIsMapped_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_table_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_page_table_cap_get_capPTIsMapped(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_page_table_cap_CL.capPTIsMapped_CL (cap_page_table_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_page_table_cap_lift_def)
  apply (subst cap_lift_page_table_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_page_table_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_page_table_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_page_table_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_page_table_cap_set_capPTIsMapped_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_table_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_page_table_cap_set_capPTIsMapped(\<acute>cap, \<acute>v32)
       \<lbrace>cap_page_table_cap_lift \<acute>ret__struct_cap_C = cap_page_table_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_page_table_cap_CL.capPTIsMapped_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_page_table_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_page_table_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_page_table_cap_ptr_set_capPTIsMapped_spec:
    defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr)"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr) \<and> cap_get_tag (cte_C.cap_C (the (ptrval s))) = scast cap_page_table_cap\<rbrace>
            PROC cap_page_table_cap_ptr_set_capPTIsMapped(\<acute>cap_ptr, \<acute>v32)
            {t. \<exists>cap. cap_page_table_cap_lift cap =
                                    cap_page_table_cap_lift (cte_C.cap_C (the (ptrval s))) \<lparr> cap_page_table_cap_CL.capPTIsMapped_CL := (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr> \<and>
                                    cap_get_tag cap = scast cap_page_table_cap \<and>
                                    t_hrs_' (globals t) = hrs_mem_update (heap_update
                                            ((cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr))
                                            (cte_C.cap_C_update (\<lambda>_. cap)(the (ptrval s))))
                                        (t_hrs_' (globals s))
                                    } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (drule h_t_valid_clift_Some_iff[THEN iffD1], erule exE)
  apply (frule clift_subtype, simp, simp)
  apply (clarsimp simp: typ_heap_simps c_guard_clift
                        packed_heap_update_collapse_hrs)
  apply (simp add: guard_simps mask_shift_simps
                   cap_tag_defs[THEN tag_eq_to_tag_masked_eq])?
  apply (simp add: parent_update_child[OF c_guard_clift]
                   typ_heap_simps c_guard_clift)
  apply (simp add: o_def cap_page_table_cap_lift_def)
  apply (simp only: cap_lift_page_table_cap cong: rev_conj_cong)
  apply (rule exI, rule conjI[rotated], rule conjI[OF _ refl])
   apply (simp_all add: cap_get_tag_eq_x cap_tag_defs mask_shift_simps)
  apply (intro conjI sign_extend_eq; simp add: mask_def word_ao_dist word_bw_assocs)?
  done

lemma (in kernel_all_substitute) cap_page_table_cap_get_capPTMappedASID_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_table_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_page_table_cap_get_capPTMappedASID(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_page_table_cap_CL.capPTMappedASID_CL (cap_page_table_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_page_table_cap_lift_def)
  apply (subst cap_lift_page_table_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_page_table_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_page_table_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_page_table_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_page_table_cap_set_capPTMappedASID_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_table_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_page_table_cap_set_capPTMappedASID(\<acute>cap, \<acute>v32)
       \<lbrace>cap_page_table_cap_lift \<acute>ret__struct_cap_C = cap_page_table_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_page_table_cap_CL.capPTMappedASID_CL :=  (\<^bsup>s\<^esup>v32 AND mask 17)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_page_table_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_page_table_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_page_table_cap_get_capPTMappedAddress_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_table_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_page_table_cap_get_capPTMappedAddress(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_page_table_cap_CL.capPTMappedAddress_CL (cap_page_table_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_page_table_cap_lift_def)
  apply (subst cap_lift_page_table_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_page_table_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_page_table_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_page_table_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_page_table_cap_set_capPTMappedAddress_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_table_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_page_table_cap_set_capPTMappedAddress(\<acute>cap, \<acute>v32)
       \<lbrace>cap_page_table_cap_lift \<acute>ret__struct_cap_C = cap_page_table_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_page_table_cap_CL.capPTMappedAddress_CL :=  (\<^bsup>s\<^esup>v32 AND NOT (mask 21))\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_page_table_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_page_table_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_page_table_cap_get_capPTBasePtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_table_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_page_table_cap_get_capPTBasePtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_page_table_cap_CL.capPTBasePtr_CL (cap_page_table_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_page_table_cap_lift_def)
  apply (subst cap_lift_page_table_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_page_table_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_page_table_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_page_table_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_page_directory_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_page_directory_cap_new(\<acute>capPDMappedASID, \<acute>capPDIsMapped, \<acute>capPDBasePtr)
       \<lbrace>cap_page_directory_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_page_directory_cap_CL.capPDMappedASID_CL = (\<^bsup>s\<^esup>capPDMappedASID___unsigned AND mask 17),
          cap_page_directory_cap_CL.capPDIsMapped_CL = (\<^bsup>s\<^esup>capPDIsMapped___unsigned AND mask 1),
          cap_page_directory_cap_CL.capPDBasePtr_CL = (\<^bsup>s\<^esup>capPDBasePtr___unsigned AND NOT (mask 14)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_page_directory_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_page_directory_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_page_directory_cap_lift_def)
  apply (erule cap_lift_page_directory_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_page_directory_cap_def))?
  done

lemma (in kernel_all_substitute) cap_page_directory_cap_get_capPDMappedASID_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_directory_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_page_directory_cap_get_capPDMappedASID(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_page_directory_cap_CL.capPDMappedASID_CL (cap_page_directory_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_page_directory_cap_lift_def)
  apply (subst cap_lift_page_directory_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_page_directory_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_page_directory_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_page_directory_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_page_directory_cap_ptr_set_capPDMappedASID_spec:
    defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr)"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr) \<and> cap_get_tag (cte_C.cap_C (the (ptrval s))) = scast cap_page_directory_cap\<rbrace>
            PROC cap_page_directory_cap_ptr_set_capPDMappedASID(\<acute>cap_ptr, \<acute>v32)
            {t. \<exists>cap. cap_page_directory_cap_lift cap =
                                    cap_page_directory_cap_lift (cte_C.cap_C (the (ptrval s))) \<lparr> cap_page_directory_cap_CL.capPDMappedASID_CL := (\<^bsup>s\<^esup>v32 AND mask 17) \<rparr> \<and>
                                    cap_get_tag cap = scast cap_page_directory_cap \<and>
                                    t_hrs_' (globals t) = hrs_mem_update (heap_update
                                            ((cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr))
                                            (cte_C.cap_C_update (\<lambda>_. cap)(the (ptrval s))))
                                        (t_hrs_' (globals s))
                                    } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (drule h_t_valid_clift_Some_iff[THEN iffD1], erule exE)
  apply (frule clift_subtype, simp, simp)
  apply (clarsimp simp: typ_heap_simps c_guard_clift
                        packed_heap_update_collapse_hrs)
  apply (simp add: guard_simps mask_shift_simps
                   cap_tag_defs[THEN tag_eq_to_tag_masked_eq])?
  apply (simp add: parent_update_child[OF c_guard_clift]
                   typ_heap_simps c_guard_clift)
  apply (simp add: o_def cap_page_directory_cap_lift_def)
  apply (simp only: cap_lift_page_directory_cap cong: rev_conj_cong)
  apply (rule exI, rule conjI[rotated], rule conjI[OF _ refl])
   apply (simp_all add: cap_get_tag_eq_x cap_tag_defs mask_shift_simps)
  apply (intro conjI sign_extend_eq; simp add: mask_def word_ao_dist word_bw_assocs)?
  done

lemma (in kernel_all_substitute) cap_page_directory_cap_get_capPDBasePtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_directory_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_page_directory_cap_get_capPDBasePtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_page_directory_cap_CL.capPDBasePtr_CL (cap_page_directory_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_page_directory_cap_lift_def)
  apply (subst cap_lift_page_directory_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_page_directory_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_page_directory_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_page_directory_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_page_directory_cap_get_capPDIsMapped_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_page_directory_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_page_directory_cap_get_capPDIsMapped(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_page_directory_cap_CL.capPDIsMapped_CL (cap_page_directory_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_page_directory_cap_lift_def)
  apply (subst cap_lift_page_directory_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_page_directory_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_page_directory_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_page_directory_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_page_directory_cap_ptr_set_capPDIsMapped_spec:
    defines "ptrval s \<equiv> cslift s (cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr)"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c (cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr) \<and> cap_get_tag (cte_C.cap_C (the (ptrval s))) = scast cap_page_directory_cap\<rbrace>
            PROC cap_page_directory_cap_ptr_set_capPDIsMapped(\<acute>cap_ptr, \<acute>v32)
            {t. \<exists>cap. cap_page_directory_cap_lift cap =
                                    cap_page_directory_cap_lift (cte_C.cap_C (the (ptrval s))) \<lparr> cap_page_directory_cap_CL.capPDIsMapped_CL := (\<^bsup>s\<^esup>v32 AND mask 1) \<rparr> \<and>
                                    cap_get_tag cap = scast cap_page_directory_cap \<and>
                                    t_hrs_' (globals t) = hrs_mem_update (heap_update
                                            ((cparent \<^bsup>s\<^esup>cap_ptr [''cap_C''] :: cte_C ptr))
                                            (cte_C.cap_C_update (\<lambda>_. cap)(the (ptrval s))))
                                        (t_hrs_' (globals s))
                                    } " 
  unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (frule h_t_valid_c_guard_cparent, simp, simp add: typ_uinfo_t_def)
  apply (drule h_t_valid_clift_Some_iff[THEN iffD1], erule exE)
  apply (frule clift_subtype, simp, simp)
  apply (clarsimp simp: typ_heap_simps c_guard_clift
                        packed_heap_update_collapse_hrs)
  apply (simp add: guard_simps mask_shift_simps
                   cap_tag_defs[THEN tag_eq_to_tag_masked_eq])?
  apply (simp add: parent_update_child[OF c_guard_clift]
                   typ_heap_simps c_guard_clift)
  apply (simp add: o_def cap_page_directory_cap_lift_def)
  apply (simp only: cap_lift_page_directory_cap cong: rev_conj_cong)
  apply (rule exI, rule conjI[rotated], rule conjI[OF _ refl])
   apply (simp_all add: cap_get_tag_eq_x cap_tag_defs mask_shift_simps)
  apply (intro conjI sign_extend_eq; simp add: mask_def word_ao_dist word_bw_assocs)?
  done

lemma (in kernel_all_substitute) cap_asid_control_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_asid_control_cap_new()
       \<lbrace>cap_get_tag \<acute>ret__struct_cap_C = scast cap_asid_control_cap\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  by (clarsimp simp: guard_simps
                     cap_lift_def
                     Let_def
                     cap_get_tag_def
                     mask_shift_simps
                     cap_tag_defs
                     word_of_int_hom_syms)

lemma (in kernel_all_substitute) cap_irq_control_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_irq_control_cap_new()
       \<lbrace>cap_get_tag \<acute>ret__struct_cap_C = scast cap_irq_control_cap\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  by (clarsimp simp: guard_simps
                     cap_lift_def
                     Let_def
                     cap_get_tag_def
                     mask_shift_simps
                     cap_tag_defs
                     word_of_int_hom_syms)

lemma (in kernel_all_substitute) cap_irq_handler_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_irq_handler_cap_new(\<acute>capIRQ)
       \<lbrace>cap_irq_handler_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_irq_handler_cap_CL.capIRQ_CL = (\<^bsup>s\<^esup>capIRQ___unsigned AND mask 8) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_irq_handler_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_irq_handler_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_irq_handler_cap_lift_def)
  apply (erule cap_lift_irq_handler_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_irq_handler_cap_def))?
  done

lemma (in kernel_all_substitute) cap_irq_handler_cap_get_capIRQ_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_irq_handler_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_irq_handler_cap_get_capIRQ(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_irq_handler_cap_CL.capIRQ_CL (cap_irq_handler_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_irq_handler_cap_lift_def)
  apply (subst cap_lift_irq_handler_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_irq_handler_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_irq_handler_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_irq_handler_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_zombie_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_zombie_cap_new(\<acute>capZombieID, \<acute>capZombieType)
       \<lbrace>cap_zombie_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_zombie_cap_CL.capZombieID_CL = (\<^bsup>s\<^esup>capZombieID___unsigned AND mask 32),
          cap_zombie_cap_CL.capZombieType_CL = (\<^bsup>s\<^esup>capZombieType___unsigned AND mask 6) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_zombie_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_zombie_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_zombie_cap_lift_def)
  apply (erule cap_lift_zombie_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_zombie_cap_def))?
  done

lemma (in kernel_all_substitute) cap_zombie_cap_get_capZombieID_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_zombie_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_zombie_cap_get_capZombieID(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_zombie_cap_CL.capZombieID_CL (cap_zombie_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_zombie_cap_lift_def)
  apply (subst cap_lift_zombie_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_zombie_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_zombie_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_zombie_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_zombie_cap_set_capZombieID_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_zombie_cap\<rbrace>
       \<acute>ret__struct_cap_C :== PROC cap_zombie_cap_set_capZombieID(\<acute>cap, \<acute>v32)
       \<lbrace>cap_zombie_cap_lift \<acute>ret__struct_cap_C = cap_zombie_cap_lift \<^bsup>s\<^esup>cap \<lparr> cap_zombie_cap_CL.capZombieID_CL :=  (\<^bsup>s\<^esup>v32 AND mask 32)\<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_zombie_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_lift_def cap_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: cap_zombie_cap_lift_def cap_lift_def cap_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) cap_zombie_cap_get_capZombieType_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_zombie_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_zombie_cap_get_capZombieType(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_zombie_cap_CL.capZombieType_CL (cap_zombie_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_zombie_cap_lift_def)
  apply (subst cap_lift_zombie_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_zombie_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_zombie_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_zombie_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) cap_domain_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_domain_cap_new()
       \<lbrace>cap_get_tag \<acute>ret__struct_cap_C = scast cap_domain_cap\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  by (clarsimp simp: guard_simps
                     cap_lift_def
                     Let_def
                     cap_get_tag_def
                     mask_shift_simps
                     cap_tag_defs
                     word_of_int_hom_syms)

lemma (in kernel_all_substitute) cap_vcpu_cap_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_cap_C :== PROC cap_vcpu_cap_new(\<acute>capVCPUPtr)
       \<lbrace>cap_vcpu_cap_lift \<acute>ret__struct_cap_C = \<lparr>
          cap_vcpu_cap_CL.capVCPUPtr_CL = (\<^bsup>s\<^esup>capVCPUPtr___unsigned AND NOT (mask 8)) \<rparr> \<and>
        cap_get_tag \<acute>ret__struct_cap_C = scast cap_vcpu_cap\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: cap_get_tag_eq_x cap_vcpu_cap_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: cap_vcpu_cap_lift_def)
  apply (erule cap_lift_vcpu_cap[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps cap_vcpu_cap_def))?
  done

lemma (in kernel_all_substitute) cap_vcpu_cap_get_capVCPUPtr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. cap_get_tag \<acute>cap = scast cap_vcpu_cap\<rbrace>
       \<acute>ret__unsigned :== PROC cap_vcpu_cap_get_capVCPUPtr(\<acute>cap)
       \<lbrace>\<acute>ret__unsigned = cap_vcpu_cap_CL.capVCPUPtr_CL (cap_vcpu_cap_lift \<^bsup>s\<^esup>cap)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:cap_vcpu_cap_lift_def)
  apply (subst cap_lift_vcpu_cap)
   apply (simp add: o_def
                    cap_get_tag_def
                    cap_vcpu_cap_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst cap_lift_vcpu_cap, simp)?
  apply (simp add: o_def
                   cap_get_tag_def
                   cap_vcpu_cap_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemmas lookup_fault_C_words_C_fl_simp[simp] = lookup_fault_C_words_C_fl[simplified]

lemma lookup_fault_ptr_words_NULL:
  "c_guard (p::lookup_fault_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma lookup_fault_ptr_words_aligned:
  "c_guard (p::lookup_fault_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[2]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma lookup_fault_ptr_words_ptr_safe:
  "ptr_safe (p::lookup_fault_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[2]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas lookup_fault_ptr_guards[simp] =
  lookup_fault_ptr_words_NULL
  lookup_fault_ptr_words_aligned
  lookup_fault_ptr_words_ptr_safe

lemma (in kernel_all_substitute) lookup_fault_get_lufType_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC lookup_fault_get_lufType(\<acute>lookup_fault)
       \<lbrace>\<acute>ret__unsigned = lookup_fault_get_tag \<^bsup>s\<^esup>lookup_fault\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (simp add:lookup_fault_get_tag_def mask_shift_simps guard_simps)
  done

lemma (in kernel_all_substitute) lookup_fault_invalid_root_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_lookup_fault_C :== PROC lookup_fault_invalid_root_new()
       \<lbrace>lookup_fault_get_tag \<acute>ret__struct_lookup_fault_C = scast lookup_fault_invalid_root\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  by (clarsimp simp: guard_simps
                     lookup_fault_lift_def
                     Let_def
                     lookup_fault_get_tag_def
                     mask_shift_simps
                     lookup_fault_tag_defs
                     word_of_int_hom_syms)

lemma (in kernel_all_substitute) lookup_fault_missing_capability_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_lookup_fault_C :== PROC lookup_fault_missing_capability_new(\<acute>bitsLeft)
       \<lbrace>lookup_fault_missing_capability_lift \<acute>ret__struct_lookup_fault_C = \<lparr>
          lookup_fault_missing_capability_CL.bitsLeft_CL = (\<^bsup>s\<^esup>bitsLeft___unsigned AND mask 6) \<rparr> \<and>
        lookup_fault_get_tag \<acute>ret__struct_lookup_fault_C = scast lookup_fault_missing_capability\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: lookup_fault_get_tag_eq_x lookup_fault_missing_capability_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: lookup_fault_missing_capability_lift_def)
  apply (erule lookup_fault_lift_missing_capability[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps lookup_fault_missing_capability_def))?
  done

lemma (in kernel_all_substitute) lookup_fault_missing_capability_get_bitsLeft_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. lookup_fault_get_tag \<acute>lookup_fault = scast lookup_fault_missing_capability\<rbrace>
       \<acute>ret__unsigned :== PROC lookup_fault_missing_capability_get_bitsLeft(\<acute>lookup_fault)
       \<lbrace>\<acute>ret__unsigned = lookup_fault_missing_capability_CL.bitsLeft_CL (lookup_fault_missing_capability_lift \<^bsup>s\<^esup>lookup_fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:lookup_fault_missing_capability_lift_def)
  apply (subst lookup_fault_lift_missing_capability)
   apply (simp add: o_def
                    lookup_fault_get_tag_def
                    lookup_fault_missing_capability_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst lookup_fault_lift_missing_capability, simp)?
  apply (simp add: o_def
                   lookup_fault_get_tag_def
                   lookup_fault_missing_capability_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) lookup_fault_depth_mismatch_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_lookup_fault_C :== PROC lookup_fault_depth_mismatch_new(\<acute>bitsFound, \<acute>bitsLeft)
       \<lbrace>lookup_fault_depth_mismatch_lift \<acute>ret__struct_lookup_fault_C = \<lparr>
          lookup_fault_depth_mismatch_CL.bitsFound_CL = (\<^bsup>s\<^esup>bitsFound___unsigned AND mask 6),
          lookup_fault_depth_mismatch_CL.bitsLeft_CL = (\<^bsup>s\<^esup>bitsLeft___unsigned AND mask 6) \<rparr> \<and>
        lookup_fault_get_tag \<acute>ret__struct_lookup_fault_C = scast lookup_fault_depth_mismatch\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: lookup_fault_get_tag_eq_x lookup_fault_depth_mismatch_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: lookup_fault_depth_mismatch_lift_def)
  apply (erule lookup_fault_lift_depth_mismatch[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps lookup_fault_depth_mismatch_def))?
  done

lemma (in kernel_all_substitute) lookup_fault_depth_mismatch_get_bitsFound_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. lookup_fault_get_tag \<acute>lookup_fault = scast lookup_fault_depth_mismatch\<rbrace>
       \<acute>ret__unsigned :== PROC lookup_fault_depth_mismatch_get_bitsFound(\<acute>lookup_fault)
       \<lbrace>\<acute>ret__unsigned = lookup_fault_depth_mismatch_CL.bitsFound_CL (lookup_fault_depth_mismatch_lift \<^bsup>s\<^esup>lookup_fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:lookup_fault_depth_mismatch_lift_def)
  apply (subst lookup_fault_lift_depth_mismatch)
   apply (simp add: o_def
                    lookup_fault_get_tag_def
                    lookup_fault_depth_mismatch_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst lookup_fault_lift_depth_mismatch, simp)?
  apply (simp add: o_def
                   lookup_fault_get_tag_def
                   lookup_fault_depth_mismatch_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) lookup_fault_depth_mismatch_get_bitsLeft_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. lookup_fault_get_tag \<acute>lookup_fault = scast lookup_fault_depth_mismatch\<rbrace>
       \<acute>ret__unsigned :== PROC lookup_fault_depth_mismatch_get_bitsLeft(\<acute>lookup_fault)
       \<lbrace>\<acute>ret__unsigned = lookup_fault_depth_mismatch_CL.bitsLeft_CL (lookup_fault_depth_mismatch_lift \<^bsup>s\<^esup>lookup_fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:lookup_fault_depth_mismatch_lift_def)
  apply (subst lookup_fault_lift_depth_mismatch)
   apply (simp add: o_def
                    lookup_fault_get_tag_def
                    lookup_fault_depth_mismatch_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst lookup_fault_lift_depth_mismatch, simp)?
  apply (simp add: o_def
                   lookup_fault_get_tag_def
                   lookup_fault_depth_mismatch_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) lookup_fault_guard_mismatch_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_lookup_fault_C :== PROC lookup_fault_guard_mismatch_new(\<acute>guardFound, \<acute>bitsLeft, \<acute>bitsFound)
       \<lbrace>lookup_fault_guard_mismatch_lift \<acute>ret__struct_lookup_fault_C = \<lparr>
          lookup_fault_guard_mismatch_CL.guardFound_CL = (\<^bsup>s\<^esup>guardFound___unsigned AND mask 32),
          lookup_fault_guard_mismatch_CL.bitsLeft_CL = (\<^bsup>s\<^esup>bitsLeft___unsigned AND mask 6),
          lookup_fault_guard_mismatch_CL.bitsFound_CL = (\<^bsup>s\<^esup>bitsFound___unsigned AND mask 6) \<rparr> \<and>
        lookup_fault_get_tag \<acute>ret__struct_lookup_fault_C = scast lookup_fault_guard_mismatch\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: lookup_fault_get_tag_eq_x lookup_fault_guard_mismatch_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: lookup_fault_guard_mismatch_lift_def)
  apply (erule lookup_fault_lift_guard_mismatch[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps lookup_fault_guard_mismatch_def))?
  done

lemma (in kernel_all_substitute) lookup_fault_guard_mismatch_get_guardFound_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. lookup_fault_get_tag \<acute>lookup_fault = scast lookup_fault_guard_mismatch\<rbrace>
       \<acute>ret__unsigned :== PROC lookup_fault_guard_mismatch_get_guardFound(\<acute>lookup_fault)
       \<lbrace>\<acute>ret__unsigned = lookup_fault_guard_mismatch_CL.guardFound_CL (lookup_fault_guard_mismatch_lift \<^bsup>s\<^esup>lookup_fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:lookup_fault_guard_mismatch_lift_def)
  apply (subst lookup_fault_lift_guard_mismatch)
   apply (simp add: o_def
                    lookup_fault_get_tag_def
                    lookup_fault_guard_mismatch_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst lookup_fault_lift_guard_mismatch, simp)?
  apply (simp add: o_def
                   lookup_fault_get_tag_def
                   lookup_fault_guard_mismatch_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) lookup_fault_guard_mismatch_get_bitsLeft_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. lookup_fault_get_tag \<acute>lookup_fault = scast lookup_fault_guard_mismatch\<rbrace>
       \<acute>ret__unsigned :== PROC lookup_fault_guard_mismatch_get_bitsLeft(\<acute>lookup_fault)
       \<lbrace>\<acute>ret__unsigned = lookup_fault_guard_mismatch_CL.bitsLeft_CL (lookup_fault_guard_mismatch_lift \<^bsup>s\<^esup>lookup_fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:lookup_fault_guard_mismatch_lift_def)
  apply (subst lookup_fault_lift_guard_mismatch)
   apply (simp add: o_def
                    lookup_fault_get_tag_def
                    lookup_fault_guard_mismatch_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst lookup_fault_lift_guard_mismatch, simp)?
  apply (simp add: o_def
                   lookup_fault_get_tag_def
                   lookup_fault_guard_mismatch_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) lookup_fault_guard_mismatch_get_bitsFound_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. lookup_fault_get_tag \<acute>lookup_fault = scast lookup_fault_guard_mismatch\<rbrace>
       \<acute>ret__unsigned :== PROC lookup_fault_guard_mismatch_get_bitsFound(\<acute>lookup_fault)
       \<lbrace>\<acute>ret__unsigned = lookup_fault_guard_mismatch_CL.bitsFound_CL (lookup_fault_guard_mismatch_lift \<^bsup>s\<^esup>lookup_fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:lookup_fault_guard_mismatch_lift_def)
  apply (subst lookup_fault_lift_guard_mismatch)
   apply (simp add: o_def
                    lookup_fault_get_tag_def
                    lookup_fault_guard_mismatch_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst lookup_fault_lift_guard_mismatch, simp)?
  apply (simp add: o_def
                   lookup_fault_get_tag_def
                   lookup_fault_guard_mismatch_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemmas pde_C_words_C_fl_simp[simp] = pde_C_words_C_fl[simplified]

lemma pde_ptr_words_NULL:
  "c_guard (p::pde_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma pde_ptr_words_aligned:
  "c_guard (p::pde_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[2]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma pde_ptr_words_ptr_safe:
  "ptr_safe (p::pde_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[2]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas pde_ptr_guards[simp] =
  pde_ptr_words_NULL
  pde_ptr_words_aligned
  pde_ptr_words_ptr_safe

lemma (in kernel_all_substitute) pde_get_pdeType_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC pde_get_pdeType(\<acute>pde)
       \<lbrace>\<acute>ret__unsigned = pde_get_tag \<^bsup>s\<^esup>pde\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (simp add:pde_get_tag_def mask_shift_simps guard_simps)
  done

lemma (in kernel_all_substitute) pde_ptr_get_pdeType_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>pde_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>pde_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC pde_ptr_get_pdeType(\<acute>pde_ptr)
            \<lbrace>\<acute>ret__unsigned = pde_get_tag ((the (ptrval s)))\<rbrace> " 
 unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (frule h_t_valid_field[where f="[''words_C'']"], simp+)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)
  apply (simp add:h_val_clift' clift_field)
  apply (simp add:pde_get_tag_def)
  apply (simp add:mask_shift_simps)?
  done

lemma (in kernel_all_substitute) pde_pde_invalid_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pde_C :== PROC pde_pde_invalid_new(\<acute>stored_hw_asid, \<acute>stored_asid_valid)
       \<lbrace>pde_pde_invalid_lift \<acute>ret__struct_pde_C = \<lparr>
          pde_pde_invalid_CL.stored_hw_asid_CL = (\<^bsup>s\<^esup>stored_hw_asid___unsigned AND mask 8),
          pde_pde_invalid_CL.stored_asid_valid_CL = (\<^bsup>s\<^esup>stored_asid_valid___unsigned AND mask 1) \<rparr> \<and>
        pde_get_tag \<acute>ret__struct_pde_C = scast pde_pde_invalid\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pde_get_tag_eq_x pde_pde_invalid_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: pde_pde_invalid_lift_def)
  apply (erule pde_lift_pde_invalid[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps pde_pde_invalid_def))?
  done

lemma (in kernel_all_substitute) pde_pde_invalid_get_stored_hw_asid_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pde_get_tag \<acute>pde = scast pde_pde_invalid\<rbrace>
       \<acute>ret__unsigned :== PROC pde_pde_invalid_get_stored_hw_asid(\<acute>pde)
       \<lbrace>\<acute>ret__unsigned = pde_pde_invalid_CL.stored_hw_asid_CL (pde_pde_invalid_lift \<^bsup>s\<^esup>pde)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:pde_pde_invalid_lift_def)
  apply (subst pde_lift_pde_invalid)
   apply (simp add: o_def
                    pde_get_tag_def
                    pde_pde_invalid_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst pde_lift_pde_invalid, simp)?
  apply (simp add: o_def
                   pde_get_tag_def
                   pde_pde_invalid_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) pde_pde_invalid_get_stored_asid_valid_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pde_get_tag \<acute>pde = scast pde_pde_invalid\<rbrace>
       \<acute>ret__unsigned :== PROC pde_pde_invalid_get_stored_asid_valid(\<acute>pde)
       \<lbrace>\<acute>ret__unsigned = pde_pde_invalid_CL.stored_asid_valid_CL (pde_pde_invalid_lift \<^bsup>s\<^esup>pde)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:pde_pde_invalid_lift_def)
  apply (subst pde_lift_pde_invalid)
   apply (simp add: o_def
                    pde_get_tag_def
                    pde_pde_invalid_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst pde_lift_pde_invalid, simp)?
  apply (simp add: o_def
                   pde_get_tag_def
                   pde_pde_invalid_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) pde_pde_section_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pde_C :== PROC pde_pde_section_new(\<acute>XN, \<acute>contiguous_hint, \<acute>address, \<acute>AF, \<acute>SH, \<acute>HAP, \<acute>MemAttr)
       \<lbrace>pde_pde_section_lift \<acute>ret__struct_pde_C = \<lparr>
          pde_pde_section_CL.XN_CL = (\<^bsup>s\<^esup>XN___unsigned AND mask 1),
          pde_pde_section_CL.contiguous_hint_CL = (\<^bsup>s\<^esup>contiguous_hint___unsigned AND mask 1),
          pde_pde_section_CL.address_CL = (\<^bsup>s\<^esup>address___unsigned AND NOT (mask 12)),
          pde_pde_section_CL.AF_CL = (\<^bsup>s\<^esup>AF___unsigned AND mask 1),
          pde_pde_section_CL.SH_CL = (\<^bsup>s\<^esup>SH___unsigned AND mask 2),
          pde_pde_section_CL.HAP_CL = (\<^bsup>s\<^esup>HAP___unsigned AND mask 2),
          pde_pde_section_CL.MemAttr_CL = (\<^bsup>s\<^esup>MemAttr___unsigned AND mask 4) \<rparr> \<and>
        pde_get_tag \<acute>ret__struct_pde_C = scast pde_pde_section\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pde_get_tag_eq_x pde_pde_section_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: pde_pde_section_lift_def)
  apply (erule pde_lift_pde_section[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps pde_pde_section_def))?
  done

lemma (in kernel_all_substitute) pde_pde_section_get_contiguous_hint_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pde_get_tag \<acute>pde = scast pde_pde_section\<rbrace>
       \<acute>ret__unsigned :== PROC pde_pde_section_get_contiguous_hint(\<acute>pde)
       \<lbrace>\<acute>ret__unsigned = pde_pde_section_CL.contiguous_hint_CL (pde_pde_section_lift \<^bsup>s\<^esup>pde)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:pde_pde_section_lift_def)
  apply (subst pde_lift_pde_section)
   apply (simp add: o_def
                    pde_get_tag_def
                    pde_pde_section_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst pde_lift_pde_section, simp)?
  apply (simp add: o_def
                   pde_get_tag_def
                   pde_pde_section_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) pde_pde_section_ptr_get_contiguous_hint_spec:
    defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>pde_ptr"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>pde_ptr \<and> pde_get_tag (the (ptrval s)) = scast pde_pde_section\<rbrace>
            \<acute>ret__unsigned :== PROC pde_pde_section_ptr_get_contiguous_hint(\<acute>pde_ptr)
            \<lbrace>\<acute>ret__unsigned = pde_pde_section_CL.contiguous_hint_CL (pde_pde_section_lift (the (ptrval s)))\<rbrace> " 
 unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: typ_heap_simps h_t_valid_clift_Some_iff guard_simps
                        mask_shift_simps sign_extend_def' nth_is_and_neq_0
                        pde_lift_pde_section pde_pde_section_lift_def)
  done


lemma (in kernel_all_substitute) pde_pde_section_get_address_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pde_get_tag \<acute>pde = scast pde_pde_section\<rbrace>
       \<acute>ret__unsigned :== PROC pde_pde_section_get_address(\<acute>pde)
       \<lbrace>\<acute>ret__unsigned = pde_pde_section_CL.address_CL (pde_pde_section_lift \<^bsup>s\<^esup>pde)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:pde_pde_section_lift_def)
  apply (subst pde_lift_pde_section)
   apply (simp add: o_def
                    pde_get_tag_def
                    pde_pde_section_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst pde_lift_pde_section, simp)?
  apply (simp add: o_def
                   pde_get_tag_def
                   pde_pde_section_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) pde_pde_section_set_address_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pde_get_tag \<acute>pde = scast pde_pde_section\<rbrace>
       \<acute>ret__struct_pde_C :== PROC pde_pde_section_set_address(\<acute>pde, \<acute>v32)
       \<lbrace>pde_pde_section_lift \<acute>ret__struct_pde_C = pde_pde_section_lift \<^bsup>s\<^esup>pde \<lparr> pde_pde_section_CL.address_CL :=  (\<^bsup>s\<^esup>v32 AND NOT (mask 12))\<rparr> \<and>
        pde_get_tag \<acute>ret__struct_pde_C = scast pde_pde_section\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pde_get_tag_eq_x pde_lift_def pde_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: pde_pde_section_lift_def pde_lift_def pde_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) pde_pde_section_ptr_get_address_spec:
    defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>pde_ptr"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>pde_ptr \<and> pde_get_tag (the (ptrval s)) = scast pde_pde_section\<rbrace>
            \<acute>ret__unsigned :== PROC pde_pde_section_ptr_get_address(\<acute>pde_ptr)
            \<lbrace>\<acute>ret__unsigned = pde_pde_section_CL.address_CL (pde_pde_section_lift (the (ptrval s)))\<rbrace> " 
 unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: typ_heap_simps h_t_valid_clift_Some_iff guard_simps
                        mask_shift_simps sign_extend_def' nth_is_and_neq_0
                        pde_lift_pde_section pde_pde_section_lift_def)
  done


lemma (in kernel_all_substitute) pde_pde_coarse_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pde_C :== PROC pde_pde_coarse_new(\<acute>address)
       \<lbrace>pde_pde_coarse_lift \<acute>ret__struct_pde_C = \<lparr>
          pde_pde_coarse_CL.address_CL = (\<^bsup>s\<^esup>address___unsigned AND NOT (mask 12)) \<rparr> \<and>
        pde_get_tag \<acute>ret__struct_pde_C = scast pde_pde_coarse\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pde_get_tag_eq_x pde_pde_coarse_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: pde_pde_coarse_lift_def)
  apply (erule pde_lift_pde_coarse[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps pde_pde_coarse_def))?
  done

lemma (in kernel_all_substitute) pde_pde_coarse_get_address_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pde_get_tag \<acute>pde = scast pde_pde_coarse\<rbrace>
       \<acute>ret__unsigned :== PROC pde_pde_coarse_get_address(\<acute>pde)
       \<lbrace>\<acute>ret__unsigned = pde_pde_coarse_CL.address_CL (pde_pde_coarse_lift \<^bsup>s\<^esup>pde)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:pde_pde_coarse_lift_def)
  apply (subst pde_lift_pde_coarse)
   apply (simp add: o_def
                    pde_get_tag_def
                    pde_pde_coarse_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst pde_lift_pde_coarse, simp)?
  apply (simp add: o_def
                   pde_get_tag_def
                   pde_pde_coarse_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) pde_pde_coarse_ptr_get_address_spec:
    defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>pde_ptr"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>pde_ptr \<and> pde_get_tag (the (ptrval s)) = scast pde_pde_coarse\<rbrace>
            \<acute>ret__unsigned :== PROC pde_pde_coarse_ptr_get_address(\<acute>pde_ptr)
            \<lbrace>\<acute>ret__unsigned = pde_pde_coarse_CL.address_CL (pde_pde_coarse_lift (the (ptrval s)))\<rbrace> " 
 unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: typ_heap_simps h_t_valid_clift_Some_iff guard_simps
                        mask_shift_simps sign_extend_def' nth_is_and_neq_0
                        pde_lift_pde_coarse pde_pde_coarse_lift_def)
  done


lemmas pdeS1_C_words_C_fl_simp[simp] = pdeS1_C_words_C_fl[simplified]

lemma pdeS1_ptr_words_NULL:
  "c_guard (p::pdeS1_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma pdeS1_ptr_words_aligned:
  "c_guard (p::pdeS1_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[2]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma pdeS1_ptr_words_ptr_safe:
  "ptr_safe (p::pdeS1_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[2]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas pdeS1_ptr_guards[simp] =
  pdeS1_ptr_words_NULL
  pdeS1_ptr_words_aligned
  pdeS1_ptr_words_ptr_safe

lemma (in kernel_all_substitute) pdeS1_pdeS1_invalid_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pdeS1_C :== PROC pdeS1_pdeS1_invalid_new()
       \<lbrace>pdeS1_get_tag \<acute>ret__struct_pdeS1_C = scast pdeS1_pdeS1_invalid\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  by (clarsimp simp: guard_simps
                     pdeS1_lift_def
                     Let_def
                     pdeS1_get_tag_def
                     mask_shift_simps
                     pdeS1_tag_defs
                     word_of_int_hom_syms)

lemma (in kernel_all_substitute) pdeS1_pdeS1_section_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pdeS1_C :== PROC pdeS1_pdeS1_section_new(\<acute>XN, \<acute>PXN, \<acute>contiguous_hint, \<acute>address, \<acute>nG, \<acute>AF, \<acute>SH, \<acute>AP, \<acute>NS, \<acute>AttrIndx)
       \<lbrace>pdeS1_pdeS1_section_lift \<acute>ret__struct_pdeS1_C = \<lparr>
          pdeS1_pdeS1_section_CL.XN_CL = (\<^bsup>s\<^esup>XN___unsigned AND mask 1),
          pdeS1_pdeS1_section_CL.PXN_CL = (\<^bsup>s\<^esup>PXN___unsigned AND mask 1),
          pdeS1_pdeS1_section_CL.contiguous_hint_CL = (\<^bsup>s\<^esup>contiguous_hint___unsigned AND mask 1),
          pdeS1_pdeS1_section_CL.address_CL = (\<^bsup>s\<^esup>address___unsigned AND NOT (mask 12)),
          pdeS1_pdeS1_section_CL.nG_CL = (\<^bsup>s\<^esup>nG___unsigned AND mask 1),
          pdeS1_pdeS1_section_CL.AF_CL = (\<^bsup>s\<^esup>AF___unsigned AND mask 1),
          pdeS1_pdeS1_section_CL.SH_CL = (\<^bsup>s\<^esup>SH___unsigned AND mask 2),
          pdeS1_pdeS1_section_CL.AP_CL = (\<^bsup>s\<^esup>AP___unsigned AND mask 2),
          pdeS1_pdeS1_section_CL.NS_CL = (\<^bsup>s\<^esup>NS___unsigned AND mask 1),
          pdeS1_pdeS1_section_CL.AttrIndx_CL = (\<^bsup>s\<^esup>AttrIndx___unsigned AND mask 3) \<rparr> \<and>
        pdeS1_get_tag \<acute>ret__struct_pdeS1_C = scast pdeS1_pdeS1_section\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pdeS1_get_tag_eq_x pdeS1_pdeS1_section_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: pdeS1_pdeS1_section_lift_def)
  apply (erule pdeS1_lift_pdeS1_section[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps pdeS1_pdeS1_section_def))?
  done

lemma (in kernel_all_substitute) pdeS1_pdeS1_coarse_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pdeS1_C :== PROC pdeS1_pdeS1_coarse_new(\<acute>NSTable, \<acute>APTable, \<acute>XNTable, \<acute>PXNTable, \<acute>address)
       \<lbrace>pdeS1_pdeS1_coarse_lift \<acute>ret__struct_pdeS1_C = \<lparr>
          pdeS1_pdeS1_coarse_CL.NSTable_CL = (\<^bsup>s\<^esup>NSTable___unsigned AND mask 1),
          pdeS1_pdeS1_coarse_CL.APTable_CL = (\<^bsup>s\<^esup>APTable___unsigned AND mask 2),
          pdeS1_pdeS1_coarse_CL.XNTable_CL = (\<^bsup>s\<^esup>XNTable___unsigned AND mask 1),
          pdeS1_pdeS1_coarse_CL.PXNTable_CL = (\<^bsup>s\<^esup>PXNTable___unsigned AND mask 1),
          pdeS1_pdeS1_coarse_CL.address_CL = (\<^bsup>s\<^esup>address___unsigned AND NOT (mask 12)) \<rparr> \<and>
        pdeS1_get_tag \<acute>ret__struct_pdeS1_C = scast pdeS1_pdeS1_coarse\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pdeS1_get_tag_eq_x pdeS1_pdeS1_coarse_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: pdeS1_pdeS1_coarse_lift_def)
  apply (erule pdeS1_lift_pdeS1_coarse[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps pdeS1_pdeS1_coarse_def))?
  done

lemmas pte_C_words_C_fl_simp[simp] = pte_C_words_C_fl[simplified]

lemma pte_ptr_words_NULL:
  "c_guard (p::pte_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma pte_ptr_words_aligned:
  "c_guard (p::pte_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[2]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma pte_ptr_words_ptr_safe:
  "ptr_safe (p::pte_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[2]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas pte_ptr_guards[simp] =
  pte_ptr_words_NULL
  pte_ptr_words_aligned
  pte_ptr_words_ptr_safe

lemma (in kernel_all_substitute) pte_get_pteType_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC pte_get_pteType(\<acute>pte)
       \<lbrace>\<acute>ret__unsigned = pte_get_tag \<^bsup>s\<^esup>pte\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (simp add:pte_get_tag_def mask_shift_simps guard_simps)
  done

lemma (in kernel_all_substitute) pte_ptr_get_pteType_spec:
           defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>pte_ptr"
           shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>pte_ptr\<rbrace>
            \<acute>ret__unsigned :== PROC pte_ptr_get_pteType(\<acute>pte_ptr)
            \<lbrace>\<acute>ret__unsigned = pte_get_tag ((the (ptrval s)))\<rbrace> " 
 unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (frule h_t_valid_field[where f="[''words_C'']"], simp+)
  apply (frule iffD1[OF h_t_valid_clift_Some_iff], rule exE, assumption, simp)
  apply (simp add:h_val_clift' clift_field)
  apply (simp add:pte_get_tag_def)
  apply (simp add:mask_shift_simps)?
  done

lemma (in kernel_all_substitute) pte_pte_invalid_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pte_C :== PROC pte_pte_invalid_new()
       \<lbrace>pte_get_tag \<acute>ret__struct_pte_C = scast pte_pte_invalid\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  by (clarsimp simp: guard_simps
                     pte_lift_def
                     Let_def
                     pte_get_tag_def
                     mask_shift_simps
                     pte_tag_defs
                     word_of_int_hom_syms)

lemma (in kernel_all_substitute) pte_pte_small_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pte_C :== PROC pte_pte_small_new(\<acute>XN, \<acute>contiguous_hint, \<acute>address, \<acute>AF, \<acute>SH, \<acute>HAP, \<acute>MemAttr)
       \<lbrace>pte_pte_small_lift \<acute>ret__struct_pte_C = \<lparr>
          pte_pte_small_CL.XN_CL = (\<^bsup>s\<^esup>XN___unsigned AND mask 1),
          pte_pte_small_CL.contiguous_hint_CL = (\<^bsup>s\<^esup>contiguous_hint___unsigned AND mask 1),
          pte_pte_small_CL.address_CL = (\<^bsup>s\<^esup>address___unsigned AND NOT (mask 12)),
          pte_pte_small_CL.AF_CL = (\<^bsup>s\<^esup>AF___unsigned AND mask 1),
          pte_pte_small_CL.SH_CL = (\<^bsup>s\<^esup>SH___unsigned AND mask 2),
          pte_pte_small_CL.HAP_CL = (\<^bsup>s\<^esup>HAP___unsigned AND mask 2),
          pte_pte_small_CL.MemAttr_CL = (\<^bsup>s\<^esup>MemAttr___unsigned AND mask 4) \<rparr> \<and>
        pte_get_tag \<acute>ret__struct_pte_C = scast pte_pte_small\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pte_get_tag_eq_x pte_pte_small_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: pte_pte_small_lift_def)
  apply (erule pte_lift_pte_small[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps pte_pte_small_def))?
  done

lemma (in kernel_all_substitute) pte_pte_small_get_contiguous_hint_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pte_get_tag \<acute>pte = scast pte_pte_small\<rbrace>
       \<acute>ret__unsigned :== PROC pte_pte_small_get_contiguous_hint(\<acute>pte)
       \<lbrace>\<acute>ret__unsigned = pte_pte_small_CL.contiguous_hint_CL (pte_pte_small_lift \<^bsup>s\<^esup>pte)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:pte_pte_small_lift_def)
  apply (subst pte_lift_pte_small)
   apply (simp add: o_def
                    pte_get_tag_def
                    pte_pte_small_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst pte_lift_pte_small, simp)?
  apply (simp add: o_def
                   pte_get_tag_def
                   pte_pte_small_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) pte_pte_small_ptr_get_contiguous_hint_spec:
    defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>pte_ptr"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>pte_ptr \<and> pte_get_tag (the (ptrval s)) = scast pte_pte_small\<rbrace>
            \<acute>ret__unsigned :== PROC pte_pte_small_ptr_get_contiguous_hint(\<acute>pte_ptr)
            \<lbrace>\<acute>ret__unsigned = pte_pte_small_CL.contiguous_hint_CL (pte_pte_small_lift (the (ptrval s)))\<rbrace> " 
 unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: typ_heap_simps h_t_valid_clift_Some_iff guard_simps
                        mask_shift_simps sign_extend_def' nth_is_and_neq_0
                        pte_lift_pte_small pte_pte_small_lift_def)
  done


lemma (in kernel_all_substitute) pte_pte_small_get_address_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pte_get_tag \<acute>pte = scast pte_pte_small\<rbrace>
       \<acute>ret__unsigned :== PROC pte_pte_small_get_address(\<acute>pte)
       \<lbrace>\<acute>ret__unsigned = pte_pte_small_CL.address_CL (pte_pte_small_lift \<^bsup>s\<^esup>pte)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:pte_pte_small_lift_def)
  apply (subst pte_lift_pte_small)
   apply (simp add: o_def
                    pte_get_tag_def
                    pte_pte_small_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst pte_lift_pte_small, simp)?
  apply (simp add: o_def
                   pte_get_tag_def
                   pte_pte_small_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) pte_pte_small_set_address_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. pte_get_tag \<acute>pte = scast pte_pte_small\<rbrace>
       \<acute>ret__struct_pte_C :== PROC pte_pte_small_set_address(\<acute>pte, \<acute>v32)
       \<lbrace>pte_pte_small_lift \<acute>ret__struct_pte_C = pte_pte_small_lift \<^bsup>s\<^esup>pte \<lparr> pte_pte_small_CL.address_CL :=  (\<^bsup>s\<^esup>v32 AND NOT (mask 12))\<rparr> \<and>
        pte_get_tag \<acute>ret__struct_pte_C = scast pte_pte_small\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pte_get_tag_eq_x pte_lift_def pte_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: pte_pte_small_lift_def pte_lift_def pte_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) pte_pte_small_ptr_get_address_spec:
    defines "ptrval s \<equiv> cslift s \<^bsup>s\<^esup>pte_ptr"
    shows "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. s \<Turnstile>\<^sub>c \<^bsup>s\<^esup>pte_ptr \<and> pte_get_tag (the (ptrval s)) = scast pte_pte_small\<rbrace>
            \<acute>ret__unsigned :== PROC pte_pte_small_ptr_get_address(\<acute>pte_ptr)
            \<lbrace>\<acute>ret__unsigned = pte_pte_small_CL.address_CL (pte_pte_small_lift (the (ptrval s)))\<rbrace> " 
 unfolding ptrval_def
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: typ_heap_simps h_t_valid_clift_Some_iff guard_simps
                        mask_shift_simps sign_extend_def' nth_is_and_neq_0
                        pte_lift_pte_small pte_pte_small_lift_def)
  done


lemmas pteS1_C_words_C_fl_simp[simp] = pteS1_C_words_C_fl[simplified]

lemma pteS1_ptr_words_NULL:
  "c_guard (p::pteS1_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma pteS1_ptr_words_aligned:
  "c_guard (p::pteS1_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[2]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma pteS1_ptr_words_ptr_safe:
  "ptr_safe (p::pteS1_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[2]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas pteS1_ptr_guards[simp] =
  pteS1_ptr_words_NULL
  pteS1_ptr_words_aligned
  pteS1_ptr_words_ptr_safe

lemma (in kernel_all_substitute) pteS1_pteS1_small_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_pteS1_C :== PROC pteS1_pteS1_small_new(\<acute>XN, \<acute>PXN, \<acute>contiguous_hint, \<acute>address, \<acute>nG, \<acute>AF, \<acute>SH, \<acute>AP, \<acute>NS, \<acute>AttrIndx)
       \<lbrace>pteS1_pteS1_small_lift \<acute>ret__struct_pteS1_C = \<lparr>
          pteS1_pteS1_small_CL.XN_CL = (\<^bsup>s\<^esup>XN___unsigned AND mask 1),
          pteS1_pteS1_small_CL.PXN_CL = (\<^bsup>s\<^esup>PXN___unsigned AND mask 1),
          pteS1_pteS1_small_CL.contiguous_hint_CL = (\<^bsup>s\<^esup>contiguous_hint___unsigned AND mask 1),
          pteS1_pteS1_small_CL.address_CL = (\<^bsup>s\<^esup>address___unsigned AND NOT (mask 12)),
          pteS1_pteS1_small_CL.nG_CL = (\<^bsup>s\<^esup>nG___unsigned AND mask 1),
          pteS1_pteS1_small_CL.AF_CL = (\<^bsup>s\<^esup>AF___unsigned AND mask 1),
          pteS1_pteS1_small_CL.SH_CL = (\<^bsup>s\<^esup>SH___unsigned AND mask 2),
          pteS1_pteS1_small_CL.AP_CL = (\<^bsup>s\<^esup>AP___unsigned AND mask 2),
          pteS1_pteS1_small_CL.NS_CL = (\<^bsup>s\<^esup>NS___unsigned AND mask 1),
          pteS1_pteS1_small_CL.AttrIndx_CL = (\<^bsup>s\<^esup>AttrIndx___unsigned AND mask 3) \<rparr> \<and>
        pteS1_get_tag \<acute>ret__struct_pteS1_C = scast pteS1_pteS1_small\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: pteS1_get_tag_eq_x pteS1_pteS1_small_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: pteS1_pteS1_small_lift_def)
  apply (erule pteS1_lift_pteS1_small[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps pteS1_pteS1_small_def))?
  done

lemmas seL4_Fault_C_words_C_fl_simp[simp] = seL4_Fault_C_words_C_fl[simplified]

lemma seL4_Fault_ptr_words_NULL:
  "c_guard (p::seL4_Fault_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma seL4_Fault_ptr_words_aligned:
  "c_guard (p::seL4_Fault_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[2]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma seL4_Fault_ptr_words_ptr_safe:
  "ptr_safe (p::seL4_Fault_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[2]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas seL4_Fault_ptr_guards[simp] =
  seL4_Fault_ptr_words_NULL
  seL4_Fault_ptr_words_aligned
  seL4_Fault_ptr_words_ptr_safe

lemma (in kernel_all_substitute) seL4_Fault_get_seL4_FaultType_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC seL4_Fault_get_seL4_FaultType(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_get_tag \<^bsup>s\<^esup>seL4_Fault\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (simp add:seL4_Fault_get_tag_def mask_shift_simps guard_simps)
  done

lemma (in kernel_all_substitute) seL4_Fault_NullFault_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_Fault_C :== PROC seL4_Fault_NullFault_new()
       \<lbrace>seL4_Fault_get_tag \<acute>ret__struct_seL4_Fault_C = scast seL4_Fault_NullFault\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  by (clarsimp simp: guard_simps
                     seL4_Fault_lift_def
                     Let_def
                     seL4_Fault_get_tag_def
                     mask_shift_simps
                     seL4_Fault_tag_defs
                     word_of_int_hom_syms)

lemma (in kernel_all_substitute) seL4_Fault_CapFault_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_Fault_C :== PROC seL4_Fault_CapFault_new(\<acute>address, \<acute>inReceivePhase)
       \<lbrace>seL4_Fault_CapFault_lift \<acute>ret__struct_seL4_Fault_C = \<lparr>
          seL4_Fault_CapFault_CL.address_CL = (\<^bsup>s\<^esup>address___unsigned AND mask 32),
          seL4_Fault_CapFault_CL.inReceivePhase_CL = (\<^bsup>s\<^esup>inReceivePhase___unsigned AND mask 1) \<rparr> \<and>
        seL4_Fault_get_tag \<acute>ret__struct_seL4_Fault_C = scast seL4_Fault_CapFault\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: seL4_Fault_get_tag_eq_x seL4_Fault_CapFault_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: seL4_Fault_CapFault_lift_def)
  apply (erule seL4_Fault_lift_CapFault[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps seL4_Fault_CapFault_def))?
  done

lemma (in kernel_all_substitute) seL4_Fault_CapFault_get_address_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_CapFault\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_CapFault_get_address(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_CapFault_CL.address_CL (seL4_Fault_CapFault_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_CapFault_lift_def)
  apply (subst seL4_Fault_lift_CapFault)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_CapFault_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_CapFault, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_CapFault_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_CapFault_get_inReceivePhase_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_CapFault\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_CapFault_get_inReceivePhase(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_CapFault_CL.inReceivePhase_CL (seL4_Fault_CapFault_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_CapFault_lift_def)
  apply (subst seL4_Fault_lift_CapFault)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_CapFault_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_CapFault, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_CapFault_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_UnknownSyscall_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_Fault_C :== PROC seL4_Fault_UnknownSyscall_new(\<acute>syscallNumber)
       \<lbrace>seL4_Fault_UnknownSyscall_lift \<acute>ret__struct_seL4_Fault_C = \<lparr>
          seL4_Fault_UnknownSyscall_CL.syscallNumber_CL = (\<^bsup>s\<^esup>syscallNumber___unsigned AND mask 32) \<rparr> \<and>
        seL4_Fault_get_tag \<acute>ret__struct_seL4_Fault_C = scast seL4_Fault_UnknownSyscall\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: seL4_Fault_get_tag_eq_x seL4_Fault_UnknownSyscall_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: seL4_Fault_UnknownSyscall_lift_def)
  apply (erule seL4_Fault_lift_UnknownSyscall[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps seL4_Fault_UnknownSyscall_def))?
  done

lemma (in kernel_all_substitute) seL4_Fault_UnknownSyscall_get_syscallNumber_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_UnknownSyscall\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_UnknownSyscall_get_syscallNumber(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_UnknownSyscall_CL.syscallNumber_CL (seL4_Fault_UnknownSyscall_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_UnknownSyscall_lift_def)
  apply (subst seL4_Fault_lift_UnknownSyscall)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_UnknownSyscall_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_UnknownSyscall, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_UnknownSyscall_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_UserException_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_Fault_C :== PROC seL4_Fault_UserException_new(\<acute>number, \<acute>code)
       \<lbrace>seL4_Fault_UserException_lift \<acute>ret__struct_seL4_Fault_C = \<lparr>
          seL4_Fault_UserException_CL.number_CL = (\<^bsup>s\<^esup>number___unsigned AND mask 32),
          seL4_Fault_UserException_CL.code_CL = (\<^bsup>s\<^esup>code___unsigned AND mask 28) \<rparr> \<and>
        seL4_Fault_get_tag \<acute>ret__struct_seL4_Fault_C = scast seL4_Fault_UserException\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: seL4_Fault_get_tag_eq_x seL4_Fault_UserException_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: seL4_Fault_UserException_lift_def)
  apply (erule seL4_Fault_lift_UserException[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps seL4_Fault_UserException_def))?
  done

lemma (in kernel_all_substitute) seL4_Fault_UserException_get_number_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_UserException\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_UserException_get_number(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_UserException_CL.number_CL (seL4_Fault_UserException_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_UserException_lift_def)
  apply (subst seL4_Fault_lift_UserException)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_UserException_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_UserException, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_UserException_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_UserException_get_code_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_UserException\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_UserException_get_code(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_UserException_CL.code_CL (seL4_Fault_UserException_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_UserException_lift_def)
  apply (subst seL4_Fault_lift_UserException)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_UserException_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_UserException, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_UserException_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_VMFault_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_Fault_C :== PROC seL4_Fault_VMFault_new(\<acute>address, \<acute>FSR, \<acute>instructionFault)
       \<lbrace>seL4_Fault_VMFault_lift \<acute>ret__struct_seL4_Fault_C = \<lparr>
          seL4_Fault_VMFault_CL.address_CL = (\<^bsup>s\<^esup>address___unsigned AND mask 32),
          seL4_Fault_VMFault_CL.FSR_CL = (\<^bsup>s\<^esup>FSR___unsigned AND mask 26),
          seL4_Fault_VMFault_CL.instructionFault_CL = (\<^bsup>s\<^esup>instructionFault___unsigned AND mask 1) \<rparr> \<and>
        seL4_Fault_get_tag \<acute>ret__struct_seL4_Fault_C = scast seL4_Fault_VMFault\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: seL4_Fault_get_tag_eq_x seL4_Fault_VMFault_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: seL4_Fault_VMFault_lift_def)
  apply (erule seL4_Fault_lift_VMFault[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps seL4_Fault_VMFault_def))?
  done

lemma (in kernel_all_substitute) seL4_Fault_VMFault_get_address_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_VMFault\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_VMFault_get_address(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_VMFault_CL.address_CL (seL4_Fault_VMFault_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_VMFault_lift_def)
  apply (subst seL4_Fault_lift_VMFault)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_VMFault_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_VMFault, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_VMFault_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_VMFault_get_FSR_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_VMFault\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_VMFault_get_FSR(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_VMFault_CL.FSR_CL (seL4_Fault_VMFault_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_VMFault_lift_def)
  apply (subst seL4_Fault_lift_VMFault)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_VMFault_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_VMFault, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_VMFault_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_VMFault_get_instructionFault_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_VMFault\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_VMFault_get_instructionFault(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_VMFault_CL.instructionFault_CL (seL4_Fault_VMFault_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_VMFault_lift_def)
  apply (subst seL4_Fault_lift_VMFault)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_VMFault_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_VMFault, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_VMFault_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_VGICMaintenance_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_Fault_C :== PROC seL4_Fault_VGICMaintenance_new(\<acute>idx, \<acute>idxValid)
       \<lbrace>seL4_Fault_VGICMaintenance_lift \<acute>ret__struct_seL4_Fault_C = \<lparr>
          seL4_Fault_VGICMaintenance_CL.idx_CL = (\<^bsup>s\<^esup>idx___unsigned AND mask 6),
          seL4_Fault_VGICMaintenance_CL.idxValid_CL = (\<^bsup>s\<^esup>idxValid___unsigned AND mask 1) \<rparr> \<and>
        seL4_Fault_get_tag \<acute>ret__struct_seL4_Fault_C = scast seL4_Fault_VGICMaintenance\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: seL4_Fault_get_tag_eq_x seL4_Fault_VGICMaintenance_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: seL4_Fault_VGICMaintenance_lift_def)
  apply (erule seL4_Fault_lift_VGICMaintenance[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps seL4_Fault_VGICMaintenance_def))?
  done

lemma (in kernel_all_substitute) seL4_Fault_VGICMaintenance_get_idx_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_VGICMaintenance\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_VGICMaintenance_get_idx(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_VGICMaintenance_CL.idx_CL (seL4_Fault_VGICMaintenance_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_VGICMaintenance_lift_def)
  apply (subst seL4_Fault_lift_VGICMaintenance)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_VGICMaintenance_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_VGICMaintenance, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_VGICMaintenance_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_VGICMaintenance_get_idxValid_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_VGICMaintenance\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_VGICMaintenance_get_idxValid(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_VGICMaintenance_CL.idxValid_CL (seL4_Fault_VGICMaintenance_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_VGICMaintenance_lift_def)
  apply (subst seL4_Fault_lift_VGICMaintenance)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_VGICMaintenance_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_VGICMaintenance, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_VGICMaintenance_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_VCPUFault_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_Fault_C :== PROC seL4_Fault_VCPUFault_new(\<acute>hsr)
       \<lbrace>seL4_Fault_VCPUFault_lift \<acute>ret__struct_seL4_Fault_C = \<lparr>
          seL4_Fault_VCPUFault_CL.hsr_CL = (\<^bsup>s\<^esup>hsr___unsigned AND mask 32) \<rparr> \<and>
        seL4_Fault_get_tag \<acute>ret__struct_seL4_Fault_C = scast seL4_Fault_VCPUFault\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: seL4_Fault_get_tag_eq_x seL4_Fault_VCPUFault_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: seL4_Fault_VCPUFault_lift_def)
  apply (erule seL4_Fault_lift_VCPUFault[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps seL4_Fault_VCPUFault_def))?
  done

lemma (in kernel_all_substitute) seL4_Fault_VCPUFault_get_hsr_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_VCPUFault\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_VCPUFault_get_hsr(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_VCPUFault_CL.hsr_CL (seL4_Fault_VCPUFault_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_VCPUFault_lift_def)
  apply (subst seL4_Fault_lift_VCPUFault)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_VCPUFault_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_VCPUFault, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_VCPUFault_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemma (in kernel_all_substitute) seL4_Fault_VPPIEvent_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_seL4_Fault_C :== PROC seL4_Fault_VPPIEvent_new(\<acute>irq_w)
       \<lbrace>seL4_Fault_VPPIEvent_lift \<acute>ret__struct_seL4_Fault_C = \<lparr>
          seL4_Fault_VPPIEvent_CL.irq_w_CL = (\<^bsup>s\<^esup>irq_w___unsigned AND mask 10) \<rparr> \<and>
        seL4_Fault_get_tag \<acute>ret__struct_seL4_Fault_C = scast seL4_Fault_VPPIEvent\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: seL4_Fault_get_tag_eq_x seL4_Fault_VPPIEvent_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: seL4_Fault_VPPIEvent_lift_def)
  apply (erule seL4_Fault_lift_VPPIEvent[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps seL4_Fault_VPPIEvent_def))?
  done

lemma (in kernel_all_substitute) seL4_Fault_VPPIEvent_get_irq_w_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. seL4_Fault_get_tag \<acute>seL4_Fault = scast seL4_Fault_VPPIEvent\<rbrace>
       \<acute>ret__unsigned :== PROC seL4_Fault_VPPIEvent_get_irq_w(\<acute>seL4_Fault)
       \<lbrace>\<acute>ret__unsigned = seL4_Fault_VPPIEvent_CL.irq_w_CL (seL4_Fault_VPPIEvent_lift \<^bsup>s\<^esup>seL4_Fault)\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp simp:guard_simps)
  apply (simp add:seL4_Fault_VPPIEvent_lift_def)
  apply (subst seL4_Fault_lift_VPPIEvent)
   apply (simp add: o_def
                    seL4_Fault_get_tag_def
                    seL4_Fault_VPPIEvent_def
                    mask_def word_size shift_over_ao_dists)
  apply (subst seL4_Fault_lift_VPPIEvent, simp)?
  apply (simp add: o_def
                   seL4_Fault_get_tag_def
                   seL4_Fault_VPPIEvent_def
                   mask_def word_size shift_over_ao_dists multi_shift_simps
                   word_bw_assocs word_oa_dist word_and_max_simps ucast_def
                   sign_extend_def' nth_is_and_neq_0)
  done

lemmas virq_C_words_C_fl_simp[simp] = virq_C_words_C_fl[simplified]

lemma virq_ptr_words_NULL:
  "c_guard (p::virq_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma virq_ptr_words_aligned:
  "c_guard (p::virq_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[1]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma virq_ptr_words_ptr_safe:
  "ptr_safe (p::virq_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[1]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas virq_ptr_guards[simp] =
  virq_ptr_words_NULL
  virq_ptr_words_aligned
  virq_ptr_words_ptr_safe

lemma (in kernel_all_substitute) virq_get_virqType_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__unsigned :== PROC virq_get_virqType(\<acute>virq)
       \<lbrace>\<acute>ret__unsigned = virq_get_tag \<^bsup>s\<^esup>virq\<rbrace>"
  apply(rule allI, rule conseqPre, vcg)
  apply (clarsimp)
  apply (simp add:virq_get_tag_def mask_shift_simps guard_simps)
  done

lemma (in kernel_all_substitute) virq_virq_invalid_set_virqEOIIRQEN_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. virq_get_tag \<acute>virq = scast virq_virq_invalid\<rbrace>
       \<acute>ret__struct_virq_C :== PROC virq_virq_invalid_set_virqEOIIRQEN(\<acute>virq, \<acute>v32)
       \<lbrace>virq_virq_invalid_lift \<acute>ret__struct_virq_C = virq_virq_invalid_lift \<^bsup>s\<^esup>virq \<lparr> virq_virq_invalid_CL.virqEOIIRQEN_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        virq_get_tag \<acute>ret__struct_virq_C = scast virq_virq_invalid\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: virq_get_tag_eq_x virq_lift_def virq_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: virq_virq_invalid_lift_def virq_lift_def virq_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) virq_virq_pending_new_spec:
  "\<forall>s. \<Gamma> \<turnstile> {s}
       \<acute>ret__struct_virq_C :== PROC virq_virq_pending_new(\<acute>virqGroup, \<acute>virqPriority, \<acute>virqEOIIRQEN, \<acute>virqIRQ)
       \<lbrace>virq_virq_pending_lift \<acute>ret__struct_virq_C = \<lparr>
          virq_virq_pending_CL.virqGroup_CL = (\<^bsup>s\<^esup>virqGroup___unsigned AND mask 1),
          virq_virq_pending_CL.virqPriority_CL = (\<^bsup>s\<^esup>virqPriority___unsigned AND mask 5),
          virq_virq_pending_CL.virqEOIIRQEN_CL = (\<^bsup>s\<^esup>virqEOIIRQEN___unsigned AND mask 1),
          virq_virq_pending_CL.virqIRQ_CL = (\<^bsup>s\<^esup>virqIRQ___unsigned AND mask 10) \<rparr> \<and>
        virq_get_tag \<acute>ret__struct_virq_C = scast virq_virq_pending\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply (clarsimp simp: guard_simps o_def mask_def shift_over_ao_dists)
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: virq_get_tag_eq_x virq_virq_pending_def
                         mask_def shift_over_ao_dists word_bw_assocs word_ao_dist)
  apply (simp add: virq_virq_pending_lift_def)
  apply (erule virq_lift_virq_pending[THEN subst[OF sym]]; simp?)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps virq_virq_pending_def))?
  done

lemma (in kernel_all_substitute) virq_virq_pending_set_virqEOIIRQEN_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. virq_get_tag \<acute>virq = scast virq_virq_pending\<rbrace>
       \<acute>ret__struct_virq_C :== PROC virq_virq_pending_set_virqEOIIRQEN(\<acute>virq, \<acute>v32)
       \<lbrace>virq_virq_pending_lift \<acute>ret__struct_virq_C = virq_virq_pending_lift \<^bsup>s\<^esup>virq \<lparr> virq_virq_pending_CL.virqEOIIRQEN_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        virq_get_tag \<acute>ret__struct_virq_C = scast virq_virq_pending\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: virq_get_tag_eq_x virq_lift_def virq_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: virq_virq_pending_lift_def virq_lift_def virq_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

lemma (in kernel_all_substitute) virq_virq_active_set_virqEOIIRQEN_spec:
  "\<forall>s. \<Gamma> \<turnstile> \<lbrace>s. virq_get_tag \<acute>virq = scast virq_virq_active\<rbrace>
       \<acute>ret__struct_virq_C :== PROC virq_virq_active_set_virqEOIIRQEN(\<acute>virq, \<acute>v32)
       \<lbrace>virq_virq_active_lift \<acute>ret__struct_virq_C = virq_virq_active_lift \<^bsup>s\<^esup>virq \<lparr> virq_virq_active_CL.virqEOIIRQEN_CL :=  (\<^bsup>s\<^esup>v32 AND mask 1)\<rparr> \<and>
        virq_get_tag \<acute>ret__struct_virq_C = scast virq_virq_active\<rbrace>"
  apply (rule allI, rule conseqPre, vcg)
  apply clarsimp
  apply (rule context_conjI[THEN iffD1[OF conj_commute]],
         fastforce simp: virq_get_tag_eq_x virq_lift_def virq_tag_defs
                         mask_def shift_over_ao_dists multi_shift_simps word_size
                         word_ao_dist word_bw_assocs)
  apply (simp add: virq_virq_active_lift_def virq_lift_def virq_tag_defs)
  apply ((intro conjI sign_extend_eq)?;
         (simp add: mask_def shift_over_ao_dists multi_shift_simps word_size
                    word_ao_dist word_bw_assocs word_and_max_simps))?
  done

end
