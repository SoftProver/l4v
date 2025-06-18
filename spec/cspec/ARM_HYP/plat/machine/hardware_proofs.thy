theory hardware_proofs
imports hardware_defs
begin


lemmas iopte_C_words_C_fl_simp[simp] = iopte_C_words_C_fl[simplified]

lemma iopte_ptr_words_NULL:
  "c_guard (p::iopte_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma iopte_ptr_words_aligned:
  "c_guard (p::iopte_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[1]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma iopte_ptr_words_ptr_safe:
  "ptr_safe (p::iopte_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[1]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas iopte_ptr_guards[simp] =
  iopte_ptr_words_NULL
  iopte_ptr_words_aligned
  iopte_ptr_words_ptr_safe

lemmas iopde_C_words_C_fl_simp[simp] = iopde_C_words_C_fl[simplified]

lemma iopde_ptr_words_NULL:
  "c_guard (p::iopde_C ptr) \<Longrightarrow>
   0 < &(p\<rightarrow>[''words_C''])"
  by (fastforce intro:c_guard_NULL_fl simp:typ_uinfo_t_def)

lemma iopde_ptr_words_aligned:
  "c_guard (p::iopde_C ptr) \<Longrightarrow>
   ptr_aligned ((Ptr &(p\<rightarrow>[''words_C'']))::((word32[1]) ptr))"
  by (fastforce intro:c_guard_ptr_aligned_fl simp:typ_uinfo_t_def)

lemma iopde_ptr_words_ptr_safe:
  "ptr_safe (p::iopde_C ptr) d \<Longrightarrow>
   ptr_safe (Ptr &(p\<rightarrow>[''words_C''])::((word32[1]) ptr)) d"
  by (fastforce intro:ptr_safe_mono simp:typ_uinfo_t_def)


lemmas iopde_ptr_guards[simp] =
  iopde_ptr_words_NULL
  iopde_ptr_words_aligned
  iopde_ptr_words_ptr_safe

end
