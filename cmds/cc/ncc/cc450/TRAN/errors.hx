
/*
 * C compiler file errors.h
 * Copyright (C) Codemist Ltd, 1991
 */

#ifndef _errors_LOADED
#define _errors_LOADED 1

typedef char *syserr_message_type;
extern void syserr(syserr_message_type errcode, ...);

/*
 * C compiler error prototype file (miperrs.h)
 * Copyright (C) Codemist Ltd, 1988.
 */

/*
 * RCS $Revision: 1.1 $ Codemist 131
 * Checkin $Date: 1995/05/19 11:36:18 $
 * Revising $Author: nickc $
 */

/*
 * This file is input to the genhdrs utility, which can compress error
 * strings (but leaving escape sequences alone so that format checking can
 * occur) and optionally mapping syserr messages onto numeric codes
 * (in case somebody wants to save the about 4Kbytes of memory involved).
 */

/* AM: (after discussion with LDS) It would seem that error texts below */
/* which (seriously) take 2 or more arguments should be of the form     */
/*    #define ermsg(a,b,c) "ho hum %s had a %s %s", a, b, c             */
/* etc. to allow different sentence order in other (natural) languages. */

/* One nice thing would be to have a variant form of $r (etc) which did */
/* not quote its arg to avoid many uses of symname_() in the code.      */

#ifdef __CC_NORCROFT
  /*
   * The next procedure takes a string as a format... check args.
   */
  #pragma -v3
#endif

/* cc_msg has been left in globals.h since it takes an uncompressed string */
extern void cc_rerr(char *errcode, ...);
extern void cc_ansi_rerr(char *errcode, ...);
extern void cc_warn(char *errcode, ...);
extern void cc_ansi_warn(char *errcode, ...);
extern void cc_pccwarn(char *errcode, ...);
extern void cc_err(char *errcode, ...);
extern void cc_fatalerr(char *errcode, ...);

#ifdef __CC_NORCROFT
  /*
   * End of procedures that take error strings or codes.
   */
  #pragma -v0
#endif


      /* Map strings to offsets in compressed string table */

#define bind_warn_extern_clash \
        "P� \215\100h $r�$r \215\100h \050ANSI 6 \232\016 m\007o\264e\051"    /* "extern clash $r, $r clash (ANSI 6 char monocase)" */
#define bind_warn_unused_static_decl "\026�\013e\016li�Ka\014c \266�\177\
W$r"    /* "unused earlier static declaration of $r" */
#define bind_warn_not_in_hdr "P� $r \136\266\016\013�head\003"    /* "extern $r not declared in header" */
#define bind_warn_main_not_int "P� \'�\001\033ne\005\015���\033�\030"    /* "extern 'main' needs to be 'int' function" */
#define bind_warn_label_not_used "l�� $r w�\224\013�\136�\005"    /* "label $r was defined but not used" */
/*
 * Note that when part of an error string MUST be stored as a regular
 * non-compressed string I have to inform the GenHdrs utility with %Z and %O
 * This arises when a string contains literal strings as extra sub-args.
 */
#define bind_warn_not_used(is_typedef,is_fn,binder) \
        "%s $b \266\016\013�\136�\005"    /* "%s $b declared but not used" */, \
      ((is_typedef) ? "typedef" : ((is_fn) ? "function" : "variable")),\
      binder
#define bind_warn_static_not_used "Ka\014c $b \266\016\013�\136�\005"    /* "static $b declared but not used" */
#define cg_warn_implicit_return "i���\020t�n\213�\336�%s\050\051"    /* "implicit return in non-void %s()" */
#define flowgraf_warn_implicit_return "i���\020t�n\213�\336��\030"    /* "implicit return in non-void function" */
#define pp_warn_triglyph \
        "ANSI \'%c%c%c\033tr\204\314ph �\'%c\033\321�\203w���\240\035d\005\
\077"    /* "ANSI '%c%c%c' trigraph for '%c' found - was this intended?" */
#define pp_warn_nested_comment "\232�c\207\315�\035c\002%s\023��mm�"    /* "character sequence %s inside comment" */
#define pp_warn_many_arglines \
        "\050�s�b��\010\0515\076\075 %lu ��W�cr\022�\205�s"    /* "(possible error): >= %lu lines of macro arguments" */
#define pp_warn_redefinition "\020pe�\224i\177W\043\224\002�cr\022%s"    /* "repeated definition of #define macro %s" */
#define pp_rerr_redefinition "diff\003\037r\005ef\001i\177W\043\224\002�\
cr\022%s"    /* "differing redefinition of #define macro %s" */
#define pp_rerr_nonunique_formal "d\316�\034\002�cr\022�\174�\0175\'%s\'"    /* "duplicate macro formal parameter: '%s'" */
#define pp_rerr_define_hash_arg "\313\0037�W\043 \136�cr\022�\174�\017"    /* "operand of # not macro formal parameter" */
#define pp_rerr_define_hashhash "\043\043 �rs\004\032l\100\004tok\035\213\
\043\224\002body"    /* "## first or last token in #define body" */
#define pp_warn_ifvaldef "\043if\024\027%s �y\023d�\034\002tr\210bB\330"    /* "#ifdef %s may indicate trouble..." */ /* MACH_EXTNS */
#define pp_warn_nonansi_header "N�ANSI \043\001\215u�\074%s\076"    /* "Non-ANSI #include <%s>" */
#define pp_warn_bad_pragma "Un\020�gn\031\013\043p\314g� \050n\022\'-\033\
\032\026kQwn w\010d\051"    /* "Unrecognised #pragma (no '-' or unknown word)" */
#define pp_warn_bad_pragma1 "Un\020�gn\031\013\043p\314g� -%c"    /* "Unrecognised #pragma -%c" */
#define pp_warn_unused_macro "\043\224\002�cr\022\'%s\033\224\013�\136�\
\005"    /* "#define macro '%s' defined but not used" */
#define regalloc_warn_use_before_set "$b �\140֤\013�\002�\037\315t"    /* "$b may be used before being set" */
#define regalloc_warn_never_used "$b �\315\004�nev��\005"    /* "$b is set but never used" */
#define sem_warn_unsigned "ANSI s�pr\031e5\'l\007g\033$s \'\026s\216\005\
\033yi�d\015\'l\007g\'"    /* "ANSI surprise: 'long' $s 'unsigned' yields 'long'" */
#define sem_warn_format_type "\377tu\011Y�\002$t m\031m\034\232嗒\004\'\
%.\052s\'"    /* "actual type $t mismatches format '%.*s'" */
#define sem_warn_bad_format "Il\212\174��\004���\262\'%%%c\'"    /* "Illegal format conversion '%%%c'" */
#define sem_warn_incomplete_format "In��Bt\002��\004Kr\342"    /* "Incomplete format string" */
#define sem_warn_format_nargs "F\010�\004\020�i\020\015%ld �\017%s��%ld \
giv\035"    /* "Format requires %ld parameter%s, but %ld given" */
#define sem_warn_addr_array "\'\046\033\026n�\265s\016\140��\032\016\314\
\140$e"    /* "'&' unnecessary for function or array $e" */
#define sem_warn_bad_shift(m,n) "shif�$m b\140%ld \026\224\013�ANSI C"    /* "shift of $m by %ld undefined in ANSI C" */,m,n
#define sem_warn_divrem_0 "div\031i\262b\140z\003o5$s"    /* "division by zero: $s" */
#define sem_warn_ucomp_0 "od�\026s\216\013��\016\031\262\340 05$s"    /* "odd unsigned comparison with 0: $s" */
#define sem_warn_fp_overflow(op) "�\034\037�\004�\004��w5$s"    /* "floating point constant overflow: $s" */,op
#define sem_rerr_udiad_overflow(op,a,b,c) "\026s\216\013�\004��w5$s"    /* "unsigned constant overflow: $s" */,op
#define sem_rerr_diad_overflow(op,a,b,c) "s\216\013�\004��w5$s"    /* "signed constant overflow: $s" */,op
#define sem_rerr_umonad_overflow(op,a,b) "\026s\216\013�\004��w5$s"    /* "unsigned constant overflow: $s" */,op
#define sem_rerr_monad_overflow(op,a,b) "s\216\013�\004��w5$s"    /* "signed constant overflow: $s" */,op
#define sem_rerr_implicit_cast_overflow(t,a,b) \
                                "i���\264\004\050�$t���w"    /* "implicit cast (to $t) overflow" */,t
#define sem_warn_fix_fail "�\034\037�\240egr\174���\262fa\036\005"    /* "floating to integral conversion failed" */
#define sem_warn_index_ovfl "\210t-of-bo\026�off\315\004%ld\213add\373s"    /* "out-of-bound offset %ld in address" */
#define sem_warn_low_precision "\176w�p\020c\031i\007\213wid��tPt5$s"    /* "lower precision in wider context: $s" */
#define sem_warn_odd_condition "�\002W$s\213�di\177�tPt"    /* "use of $s in condition context" */
#define sem_warn_void_context "n\022��eff�\004�\336��tPt5$s"    /* "no side effect in void context: $s" */
#define sem_warn_olde_mismatch "�\205\035\0047�old-Ky��\207m\031m\034\232\
5$e"    /* "argument and old-style parameter mismatch: $e" */
#define sem_warn_uncheckable_format \
        "\'�\034\033�.Y\022pr\240f\057sc7\027etc. �v\016i�B�s\022c7\136�\
\232�k\005"    /* "'format' arg. to printf/scanf etc. is variable, so cannot be checked" */
#define sem_warn_narrowing "i���n\016�w\037\264t5$s"    /* "implicit narrowing cast: $s" */
#define sem_warn_fn_cast \
        "$s5\264\004�twe\035 ŕ\2077���obj�t"    /* "$s: cast between function pointer and non-function object" */
#define sem_warn_pointer_int "\246��\264�Y\022�\'"    /* "explicit cast of pointer to 'int'" */
#define bind_err_extern_clash "P� \215\100h $r�$r \050�k�%ld \232\016%s\
\051"    /* "extern clash $r, $r (linker %ld char%s)" */
#define bind_err_duplicate_tag "d\316�\034\002\224i\177W$sYa\025$b"    /* "duplicate definition of $s tag $b" */
#define bind_err_reuse_tag "\020-�\037$sYa\025$b �$sYag"    /* "re-using $s tag $b as $s tag" */
#define bind_err_incomplete_tentative \
        "\001��Bt\002t�a\014v\002\266�\177W$r"    /* "incomplete tentative declaration of $r" */
#define bind_err_type_disagreement "\366d\031ag\020em\035\004�$r"    /* "type disagreement for $r" */
#define bind_err_duplicate_definition "d\316�\034\002\224i\177W$r"    /* "duplicate definition of $r" */
#define bind_err_duplicate_label "d\316�\034\002\224i\177Wl�� $r �"    /* "duplicate definition of label $r - ignored" */
#define bind_err_unset_label "l�� $r h�\136�\035 \315t"    /* "label $r has not been set" */
#define bind_err_undefined_static \
        "Ka\014c �$b \136\224\013-\375P�"    /* "static function $b not defined - treated as extern" */
#define fp_err_very_big "O�l�\002�\034\037�\004�\002\321d"    /* "Overlarge floating point value found" */
#define fp_err_big_single \
        "O�l�\002\050s\342�p\020c\031i\007��\034\037�\004�\002\321d"    /* "Overlarge (single precision) floating point value found" */
#define pp_err_eof_comment "EOF\213�mm�"    /* "EOF in comment" */
#define pp_err_eof_string "EOF\213Kr\342"    /* "EOF in string" */
#define pp_err_eol_string "�ot\002\050%c\051\023s\003��\002new�e"    /* "quote (%c) inserted before newline" */
#define pp_err_eof_escape "EOF\213Kr\037\265cape"    /* "EOF in string escape" */
#define pp_err_missing_quote "\374\'%c\'\213p\020-p�c\265s\032�mm7��e"    /* "Missing '%c' in pre-processor command line" */
#define pp_err_if_defined "N\022i\024n\014���\043i\027\224\005"    /* "No identifier after #if defined" */
#define pp_err_if_defined1 "N\022\'\051\033�\043i\027\224\005\050\330"    /* "No ')' after #if defined(..." */
#define pp_err_rpar_eof "\374\'\051\033�%s\050\330 \262�\002%ld"    /* "Missing ')' after %s(... on line %ld" */
#define pp_err_many_args "T�m7\140�\205�\015��cr\022%s\050\330 \262�\002\
%ld"    /* "Too many arguments to macro %s(... on line %ld" */
#define pp_err_few_args "T�few �\205�\015��cr\022%s\050\330 \262�\002%l\
d"    /* "Too few arguments to macro %s(... on line %ld" */
#define pp_err_missing_identifier "\374i\024n\014���\043\224e"    /* "Missing identifier after #define" */
#define pp_err_missing_parameter "\374�\207n�\002�\043\224\002%s\050\330"    /* "Missing parameter name in #define %s(..." */
#define pp_err_missing_comma "\374\',\033\032\'\051\033�\043\224\002%s\050\
\330"    /* "Missing ',' or ')' after #define %s(..." */
#define pp_err_undef "\374i\024n\014���\043\026\211"    /* "Missing identifier after #undef" */
#define pp_err_ifdef "\374i\024n\014���\043if\211"    /* "Missing identifier after #ifdef" */
#define pp_err_include_quote "\374\'\074\033\032\'\"\033�\043\001\215u\024"    /* "Missing '<' or '\"' after #include" */
#define pp_err_include_junk "J\026k �\043\001\215u�%c%s%c"    /* "Junk after #include %c%s%c" */
#define pp_err_include_file "\043\001\215u�f\036\002%c%s%c w\210ldn\'\004\
\313\035"    /* "#include file %c%s%c wouldn't open" */
#define pp_err_unknown_directive "UnkQwn di\020c\014ve5\043%s"    /* "Unknown directive: #%s" */
#define pp_err_endif_eof "\374\043\035di\027a\004EOF"    /* "Missing #endif at EOF" */
#define sem_err_typeclash "Il\212\011Y��\313\0037ds5$s"    /* "Illegal types for operands: $s" */
#define sem_err_sizeof_struct "�z\002W$c ne\005\013�\136ye\004\224\005"    /* "size of $c needed but not yet defined" */
#define sem_err_lvalue "Il\212\011\213l�e5�\032\016\314\140$e"    /* "Illegal in lvalue: function or array $e" */
#define sem_err_bitfield_address "b���d\015d\022\136hav\002add\373s\265"    /* "bit fields do not have addresses" */
#define sem_err_lvalue1 "Il\212\011\213l-�e5\'\035\205\033�\004$b"    /* "Illegal in l-value: 'enum' constant $b" */
#define sem_err_lvalue2 "Il\212\011\023Yh\002�tP�7 l-�e5$s"    /* "Illegal in the context of an l-value: $s" */
#define sem_err_nonconst "\231\011\213%s5\074\026kQwn\076"    /* "illegal in %s: <unknown>" */
#define sem_err_nonconst1 "\231\011\213%s5n\262�\004$b"    /* "illegal in %s: non constant $b" */
#define sem_err_nonconst2 "\231\011\213%s5$s"    /* "illegal in %s: $s" */
#define sem_err_nonfunction "\034te��appl\140\376�\030"    /* "attempt to apply a non-function" */
#define sem_err_void_argument "\'\336d\033��\140\136��\205�s"    /* "'void' values may not be arguments" */
#define sem_err_bad_cast "$s5�\264�$tY\022�"    /* "$s: illegal cast of $t to pointer" */
#define sem_err_bad_cast1 "$s5�\264�$t"    /* "$s: illegal cast to $t" */
#define sem_err_bad_cast2 "$s5\264��e�\174$t \231\011"    /* "$s: cast to non-equal $t illegal" */
#define sem_err_undef_struct \
        "$c \136ye\004\224\013\203c7\136�\315Bc�f�m"    /* "$c not yet defined - cannot be selected from" */
#define sem_err_unknown_field "$c h�n\022$r ��d"    /* "$c has no $r field" */
#define errs_membobj(m)\
  (m ? "member":"object")


#define bind_rerr_undefined_tag "$sYa\025$b \136\224\005"    /* "$s tag $b not defined" */
#define bind_rerr_linkage_disagreement \
        "�kag\002d\031ag\020em\035\004�$r -\375$m"    /* "linkage disagreement for $r - treated as $m" */
#define bind_rerr_local_extern "P� $r m\031m\034\232�t\313-Bv� \266�\030"    /* "extern $r mismatches top-level declaration" */
#define fp_rerr_very_small "sm\011l �\034\037�\004�\002����0.0"    /* "small floating point value converted to 0.0" */
#define fp_rerr_small_single \
        "sm\011l \050s\342�p\020c\031i\007��\034\037�\002����0.0"    /* "small (single precision) floating value converted to 0.0" */
#define pp_rerr_newline_eof "m�new�\002�\002EOF -\023s\003t\005"    /* "missing newline before EOF - inserted" */
#define pp_rerr_nonprint_char "\026pr\240��\232\016 %\043.2x \321��"    /* "unprintable char %#.2x found - ignored" */
#define pp_rerr_illegal_option "�\313\177-D%s%s"    /* "illegal option -D%s%s" */
#define pp_rerr_spurious_else "sp�i\210\015\043�s\002\261"    /* "spurious #else ignored" */
#define pp_rerr_spurious_elif "sp�i\210\015\043�i\027\261"    /* "spurious #elif ignored" */
#define pp_rerr_spurious_endif "sp�i\210\015\043\035di\027\261"    /* "spurious #endif ignored" */
#define pp_rerr_hash_line "n\205b�m�\342\213\043�e"    /* "number missing in #line" */
#define pp_rerr_hash_error "\043�\032\035�\026\017\013\"%s\""    /* "#error encountered \"%s\"" */
#define pp_rerr_hash_ident "\043i\024n\004�\136�ANSI C"    /* "#ident is not in ANSI C" */
#define pp_rerr_junk_eol "j\026k a\004\035�W\043%s �\002�"    /* "junk at end of #%s line - ignored" */
#define sem_rerr_sizeof_bitfield \
        "�zeW\074b���d\254�\203�zeof\050\240�\322\005"    /* "sizeof <bit field> illegal - sizeof(int) assumed" */
#define sem_rerr_sizeof_void "�z\002W\'\336d\033\020�ir\013-\3751"    /* "size of 'void' required - treated as 1" */
#define sem_rerr_sizeof_array "�z\002W\376\133\135 \016\314\140\020�ir\005\
,\375\1331\135"    /* "size of a [] array required, treated as [1]" */
#define sem_rerr_sizeof_function \
        "�z\002W�\020�ir\013-\375�z\002W�"    /* "size of function required - treated as size of pointer" */
#define sem_rerr_pointer_arith \
        "\074\240\254$s \074�\076\375\074\240\254$s \050\240\051\074�\076"    /* "<int> $s <pointer> treated as <int> $s (int)<pointer>" */
#define sem_rerr_pointer_arith1 \
        "\074�\254$s \074\240\076\375\050\240\051\074�\254$s \074\240\076"    /* "<pointer> $s <int> treated as (int)<pointer> $s <int>" */
#define sem_rerr_assign_const "�\216m\035�\'�\033obj�\004$e"    /* "assignment to 'const' object $e" */
#define sem_rerr_addr_regvar \
        "\'\020g\031\017\033\034tri�t\002�$b �\013wh\035 add\373\015tak\
\035"    /* "'register' attribute for $b ignored when address taken" */
#define sem_rerr_lcast "obj�t\015�a\004hav\002�\035 \264\004\016\002\136\
l-�\265"    /* "objects that have been cast are not l-values" */
#define sem_rerr_pointer_compare \
"��\016\031\262$s W�\2077d\023t:\n�li\017\1740 \050�\075\075 7�\041\075�\
�\007l\140\212\174\264e"    /* "comparison $s of pointer and int:\n\
  literal 0 (for == and !=) is only legal case" */
#define sem_rerr_different_pointers "diff\003\037�Y�\2655$s"    /* "differing pointer types: $s" */
#define sem_rerr_wrong_no_args "wr\007\025n\205b�W�\017\015�$e"    /* "wrong number of parameters to $e" */
#define sem_rerr_implicit_cast1 \
        "$s5i���\264�Y\022�e�\174�"    /* "$s: implicit cast of pointer to non-equal pointer" */
#define sem_rerr_implicit_cast2 "$s5i���\264��0\023��"    /* "$s: implicit cast of non-0 int to pointer" */
#define sem_rerr_implicit_cast3 "$s5i���\264�Y\022�\'"    /* "$s: implicit cast of pointer to 'int'" */
#define sem_rerr_implicit_cast4 "$s5i���\264�$tY\022�\'"    /* "$s: implicit cast of $t to 'int'" */
#define sem_rerr_cant_balance "diff\003\037�Y�\2655$s"    /* "differing pointer types: $s" */

#define sem_rerr_void_indirection "\231\011\023di\020c\177\262\050\336�\
\052\0515\'\052\'"    /* "illegal indirection on (void *): '*'" */
#define obj_fatalerr_io_object "I\057O �\032\262obj�\004K\020�"    /* "I/O error on object stream" */
#define compiler_rerr_no_extern_decl\
    "n\022P�\174\266�\030\023Yr7sla\177\026\206"    /* "no external declaration in translation unit" */
#define compiler_fatalerr_io_error "I\057O �\032wr\206\037\'%s\'"    /* "I/O error writing '%s'" */
#define driver_fatalerr_io_object "I\057O �\032\262obj�\004K\020�"    /* "I/O error on object stream" */
#define driver_fatalerr_io_asm "I\057O �\032\262�embl�\210tpu\004K\020�"    /* "I/O error on assembler output stream" */
#define driver_fatalerr_io_listing "I\057O �\032\262l\031t\037K\020�"    /* "I/O error on listing stream" */
#ifdef TARGET_HAS_AOUT
#define aout_fatalerr_toomany "T�m7\140symbol\015�\'a.\210t\033\210tput"    /* "Too many symbols for 'a.out' output" */
#define aout_fatalerr_toobig "Modu�t�bi\025�a.\210\004�\034\017"    /* "Module too big for a.out formatter" */
#endif
#ifdef TARGET_HAS_COFF
#define coff_fatalerr_toomany "T�m7\140\020\176ca\030\015�COFF ��\004�.\
\022f\036e"    /* "Too many relocations for COFF format in .o file" */
#define coff_fatalerr_toobig "Modu�t�bi\025�COFF �\034\017"    /* "Module too big for COFF formatter" */
#endif
#ifdef TARGET_IS_HELIOS
#define heliobj_warn_12bits "Off\315\004%ld \25412 b\206s"    /* "Offset %ld > 12 bits" */
#define heliobj_warn_16bits "Off\315\004%ld \25416 b\206s"    /* "Offset %ld > 16 bits" */
#define heliobj_warn_24bits "Off\315\004%ld \25424 b\206s"    /* "Offset %ld > 24 bits" */
#endif
#define misc_fatalerr_space1 "\210�K\010\002\050��\032�ff\003\051"    /* "out of store (for error buffer)" */
#define misc_fatalerr_toomanyerrs "T�m7\140�\010s"    /* "Too many errors" */
#define misc_fatalerr_space2 "\210�K\010\002\050�cc\137\011\176c\051\n\050\
Co�\036a\177W�\002\024�gg\037t�B\015\020�eK\013\340Yh\002-\025\313\030\n \
\020�i\020\015\376g\020a\004\024\174W�m\010y. R�o�\036\037\340\210\004-\
g�\340\nYh\002m\010\002\020Kr��-g\027\313\030�\032\340Yh\002p�g\314m b�\
k\035\023to\n sm\011l�pi�\265��\140h�p.\051"    /* "out of store (in cc_alloc)\n\
(Compilation of the debugging tables requested with the -g option\n\
 requires a great deal of memory. Recompiling without -g, with\n\
 the more restricted -gf option, or with the program broken into\n\
 smaller pieces, may help.)" */
#define misc_fatalerr_space3 "\210�K\010\002\050�cc\137\011\176c\051"    /* "out of store (in cc_alloc)" */
#define pp_fatalerr_hash_error "\043�\032\035�\026\017\013\"%s\""    /* "#error encountered \"%s\"" */

#define driver_message_nolisting \
        "Un���\313\035 %s �l\031t\3425-l \313\177\261\n"    /* "Unable to open %s for listing: -l option ignored\n" */
#ifdef NO_ASSEMBLER_OUTPUT
#define driver_message_noasm \
        "Thܯ�\262W�\002��\036�do�\136s\316p\010\004-s\n"    /* "This version of the compiler does not support -s\n" */
#endif
#define driver_message_writefail "C\210ldn\'\004wr\206\002f\036\002\'%s\'\n"    /* "Couldn't write file '%s'\n" */
#define driver_message_oddoption "Un\020�gniz\013\313\177\'%c\'5\261\n"    /* "Unrecognized option '%c': ignored\n" */
#define driver_message_readfail "C\210ldn\'\004\020a�f\036\002\'%s\'\n"    /* "Couldn't read file '%s'\n" */
/* NB the next error can not arise with the current ARM driver */
#define driver_message_toomanyfiles "T�m7\140f\036\002�s"    /* "Too many file args" */
#define driver_message_asmstdout "As\315mbl\140��w\036l g\022�Kd\210t\n"    /* "Assembly code will go to stdout\n" */
#define driver_message_no_listing \
        "-m \313\177�eBs\015\340\210\004s\210rc\002l\031t\342. Ign\010\005\n"    /* "-m option useless without source listing. Ignored\n" */
#define driver_message_nomap "-m f\036\002\136ava\036��\032c\010r\316\004\
�\n"    /* "-m file not available or corrupt - ignored\n" */
#define driver_message_notest \
        "Thܯ�\262W�\002��\036�do�\136s\316p\010\004�\002-t\265\004\313\
\030\n"    /* "This version of the compiler does not support the -test option\n" */
#define driver_message_needfile "A\004B\100\004\007\002f\036\002�\205\035\
\004w7t\005\n"    /* "At least one file argument wanted\n" */
#ifndef COMPILING_ON_ARM_OS
#define driver_message_spool "\210tpu�c\176g1.\176\025\046 c\176g2.\176\
g\n"    /* "output to clog1.log & clog2.log\n" */
#endif
#define driver_message_testfile "N\022f\036�\011\176w\013\340 -teK\n"    /* "No files allowed with -test\n" */
/* messages generated by misc.c */

#ifndef TARGET_IS_UNIX
#define misc_message_lineno(f,l,s) "\"%s\"��\002%ld5%s5"    /* "\"%s\", line %ld: %s: " */,f,l,s
#else
#define misc_message_lineno(f,l,s) "%s5%ld5%s5"    /* "%s: %ld: %s: " */,f,l,s
#endif
#define misc_message_sum1(f,nx,neq1) "%s5%ld w\016n\342%s"    /* "%s: %ld warning%s" */, f, nx, \
 neq1 ? "":"s"

#define misc_message_sum2 " \050\053 %ld s\316p\373s\005\051"    /* " (+ %ld suppressed)" */
#define misc_message_sum3(nx,neq1) "�%ld �\010%s"    /* ", %ld error%s" */, nx, \
 neq1 ? "":"s"

#define misc_message_sum5(nx,neq1) "�%ld s\003i\210\015�\010%s\n"    /* ", %ld serious error%s\n" */, nx, \
 neq1 ? "":"s"


#ifdef TARGET_STACK_MOVES_ONCE
/* Cannot be issued if NARGREGS==0 */
#define warn_untrustable "\026truK����g\035\003��%s"    /* "untrustable code generated for %s" */
#endif

 /* The next batch of things just get mapped onto syserr codes */

#define syserr_mkqualifiedtype "mkqualifiedtype(..., %ld)"
#define syserr_typeof "typeof(%ld)"
#define syserr_alignoftype "alignoftype(%ld,%#lx)"
#define syserr_sizeoftype "sizeoftype(%ld,%#lx)"
#define syserr_codeoftype "codeoftype"
#define syserr_equivtype "equivtype(%ld)"
#define syserr_compositetype "compositetype(%ld)"
#define syserr_trydiadicreduce "trydiadreduce(unsigned op %ld)"
#define syserr_trydiadicreduce1 "trydiadreduce(signed op %ld)"
#define syserr_trydiadicreduce2 "trydiadreduce(float op %ld)"
#define syserr_fp_op "FP op %ld unknown"
#define syserr_trymonadicreduce "trymonadreduce(int op %ld)"
#define syserr_trymonadicreduce1 "trymonadreduce(float op %ld)"
#define syserr_coerceunary "coerceunary(bitfieldvalue)"
#define syserr_coerceunary1 "coerceunary(%ld,%#lx)"
#define syserr_bitfieldassign "bitfieldassign"
#define syserr_mkindex "sem(mkindex)"
#define syserr_ptrdiff "sem(mkbinary/ptrdiff)"
#define syserr_va_arg_fn "sem(odd va_arg fn)"
#define syserr_mkcast "mkcast(%ld,%#lx)"
#define syserr_mkcast1 "mkcast(%ld)"
#define syserr_te_plain "te_plain(%ld)"
#define syserr_clone_node "clone_node(%ld)"
#define syserr_optimise "optimise &(%ld)"
#define syserr_optimise1 "optimise(%ld)"
#define syserr_mcrepofexpr "mcrepofexpr(%ld,%#lx)"
#define syserr_mcreparray "mcrep(array %ld)"
#define syserr_newdbuf "pp_newdbuf(%ld,%ld)"
#define syserr_pp_recursion "pp recursive sleep: '%s'"
#define syserr_pp_special "pp_special(%ld)"
#define syserr_overlarge_store1 "Overlarge storage request (binder %ld)"
#define syserr_overlarge_store2 "Overlarge storage request (local %ld)"
#define syserr_discard2 "discard2 %p"
#define syserr_discard3 "discard3 %p"
#define syserr_alloc_unmark "alloc_unmark - called too often"
#define syserr_alloc_unmark1 "alloc_unmark(no drop_local_store())"
#define syserr_alloc_reinit "alloc_reinit(no drop_local_store())"
#define syserr_addclash "add_clash (0x%lx, 0x%lx)"
#define syserr_forget_slave "forget_slave(%ld, %ld) %ld"
#define syserr_GAP "GAP in reference_register"
#define syserr_corrupt_register "corrupt_register %ld %p"
#define syserr_regalloc "regalloc(corrupt/alloc)"
#define syserr_regalloc_typefnaux "regalloc(typefnaux)"
#define syserr_regalloc_POP "regalloc(POP)"
#define syserr_call2 "CALL2 %ld"
#define syserr_dataflow "dataflow &-var"
#define syserr_choose_real_reg "choose_real_reg %lx"
#define syserr_fail_to_spill "Failed to spill register for %ld"
#define syserr_regalloc_reinit2 "regalloc_reinit2"
#define syserr_regheap "Register heap overflow"
#define syserr_bad_fmt_dir "bad fmt directive"
#define syserr_syserr "syserr simulated"
#define syserr_r1r "r1r %ld"
#define syserr_r2r "r2r %ld"
#define syserr_mr "mr %ld"
#define syserr_expand_jop "expand_jop(2address)"
#define syserr_nonauto_active "Non auto 'active_binders' element"
#define syserr_size_of_binder "size_of_binder"
#define syserr_insertblockbetween "insertblockbetween"
#define syserr_reopen_block "reopen_block called"
#define syserr_scaled_address "emit5(scaled address)"
#define syserr_expand_pushr "expand_jop_macro(PUSHR)"
#define syserr_remove_noop_failed "remove_noop failed"
#define syserr_remove_noop_failed2 "remove_noop failed2"
#define syserr_bad_bindaddr "Bad bindaddr_() with LDRVx1"
#define syserr_ldrfk "duff LDRF/DK %lx"
#define syserr_ldrk "duff LDR/B/WK %lx"
#define syserr_branch_backptr "Bad back-pointer code in branch_chain"
#define syserr_no_main_exit "use_cond_field(no main exit)"
#define syserr_two_returns "Two return exits from a block"
#define syserr_unrefblock "unrefblock"
#define syserr_zip_blocks "zip_blocks(SETSP confused %ld!=%ld)"
#define syserr_live_empty_block "ALIVE empty block L%ld"
#define syserr_loctype "loctype"
#define syserr_adconbase "cse_adconbase"
#define syserr_find_exprn "CSE: find_exprn %ld"
#define syserr_removecomparison "CSE: removecomparison %lx"
#define syserr_evalconst "CSE: evalconst %lx"
#define syserr_scanblock "cse_scanblock %08lx"
#define syserr_prune "csescan(prune)"
#define syserr_globalize "globalize_declaree1(%p,%ld)"
#define syserr_globalize1 "globalize_typeexpr(%p,%ld)"
#define syserr_copy_typeexpr "copy_typeexpr(%p,%ld)"
#define syserr_tentative "is_tentative(tmpdataq == NULL)"
#define syserr_tentative1 "is_tentative(ADCON)"
#define syserr_tentative2 "tentative definition confusion"
#define syserr_instate_decl "instate_decl %ld"
#define syserr_totarget "totargetsex(%d)"
#define syserr_vg_wpos "vg_wpos(%ld)"
#define syserr_vg_wflush "vg_wflush(type=0x%x)"
#define syserr_gendcI "gendcI(%ld,%ld)"
#define syserr_vg_wtype "vg_wtype=0x%x"
#define syserr_codevec "code vector overflow"
#define syserr_nonstring_lit "non-string literal: %.8lx"
#define syserr_addr_lit "Address-literals should not arise in HELIOS mode"
#define syserr_dumplits "dumplits(codep&3)"
#define syserr_dumplits1 "codebuf(dumplits1)"
#define syserr_dumplits2 "codebuf(dumplits2)"
#define syserr_outlitword "outlitword confused"
#define syserr_dumplits3 "codebuf(dumplits3)"
#define syserr_addlocalcse "addlocalcse %ld"
#define syserr_cse_lost_def "cse: def missing"
#define syserr_cse_lost_use "cse: use missing"
#define syserr_cse_linkrefstodefs "CSE: linkrefstodefs"
#define syserr_linkrefstodefs "cse_linkrefstodefs"
#define syserr_safetolift "cse_safetolift"
#define syserr_storecse "storecse %ld %ld\n"
#define syserr_baseop "CSE: baseop %lx"
#define syserr_cse_wordn "CSE_WORDn"
#define syserr_addcsedefs "addcsedefs"
#define syserr_cse_preheader "CSE: loop preheader %d != %ld"
#define syserr_modifycode "modifycode %ld %ld!=%ld"
#define syserr_regtype "ensure_regtype(%lx)"
#define syserr_struct_val "Value of structure requested improperly"
#define syserr_missing_expr "missing expr"
#define syserr_checknot "s_checknot"
#define syserr_structassign_val "value of structure assignment needed"
#define syserr_structdot "Struct returning function (with '.') reaches cg"
#define syserr_floating "Float %%"
#define syserr_cg_expr  "cg_expr(%ld = $s)"
#define syserr_bad_reg "bad reg %lx in use"
#define syserr_bad_fp_reg "fp reg in use"
#define syserr_cg_fnarg "cg_fnarg(odd rep %lx)"
#define syserr_fnarg_struct "cg(struct arg confused)"
#define syserr_cg_fnarg1 "cg_fnargs confused"
#define syserr_cg_argcount "arg count confused"
#define syserr_cg_fnarg2 "cg_fnargs tidy"
#define syserr_padbinder "odd padbinder$b in cg_fnargs()"
#define syserr_cg_fnap "cg_fnap"
#define syserr_cg_cmd "cg_cmd(%ld = $s)"
#define syserr_cg_endcase "cg_cmd(endcase)"
#define syserr_cg_break "cg_cmd(break)"
#define syserr_cg_cont "cg_cmd(cont)"
#define syserr_cg_switch "switch expression must have integer type"
#define syserr_cg_caselist "cg_caselist"
#define syserr_cg_case "cg_cmd(case)"
#define syserr_unset_case "Unset case_lab"
#define syserr_cg_default "cg_cmd(default)"
#define syserr_cg_badrep "rep bad in comparison %.8lx"
#define syserr_cg_plain "(plain) qualifies non-<narrow-int-binder>"
#define syserr_cg_cast "Illegal cast involving a structure or union"
#define syserr_cg_fpsize "fp sizes are wrong %ld %ld"
#define syserr_cg_cast1 "bad mode %ld in cast expression"
#define syserr_cg_cast2 "cast %ld %ld %ld %ld"
#define syserr_cg_indexword "Indexed address mode with word-store"
#define syserr_cg_bad_width "bad width %ld in cg_stind"
#define syserr_cg_bad_mode "bad mcmode %ld in cg_stind"
#define syserr_chroma "chroma_check(target.h setup wrong or multi-temp op confused)"
#define syserr_Q_swap "Q_swap(%lx)"
#define syserr_cg_stgclass "Funny storage class %#lx"
#define syserr_cg_storein "cg_storein(%ld)"
#define syserr_cg_addr "p nasty in '&(p=q)'"
#define syserr_cg_addr1 "cg_addr(%ld)"
#define syserr_cg_shift0 "n=0 in shift_op1"
#define syserr_not_shift "not a shift in shift_operand()"
#define syserr_not_shift1 "not a shift in shift_amount()"
#define syserr_integer_expected "integer expression expected"
#define syserr_nonauto_arg "Non-auto arg!"
#define syserr_struct_result "Unexpected struct result"
#define syserr_cg_topdecl "cg_topdecl(not fn type)"
#define syserr_cg_unknown "unknown top level %ld"

#ifdef TARGET_HAS_AOUT
#define syserr_aout_reloc "relocate_code_to_data(PCreloc)"
#define syserr_aout_checksym "obj_checksym(%s)"
#define syserr_aout_reloc1 "obj_coderelocation %.8lx"
#define syserr_aout_gendata "obj_gendata(%ld)"
#define syserr_aout_datalen "obj_data len=%ld"
#define syserr_aout_data "obj_data %ldEL%ld'%s'"
#define syserr_aout_debug "writedebug: aoutobj linked with xxxdbg not dbx"
#  ifdef TARGET_HAS_DEBUGGER  /* dbx support */
#define syserr_too_many_types "too many types in dbx"
#define syserr_addcodep "bad pointer in dbg_addcodep"
#define syserr_tagbindsort "bad tagbindsort 0x%08lx"
#define syserr_sprinttype "sprinttype(%p,0x%lx)"
#define syserr_dbx_locvar "debugger table confusion(local variable $r %lx %lx)"
#define syserr_dbx_scope "dbg_scope"
#define syserr_dbx_proc "dbg_proc"
#define syserr_dbx_proc1 "dbg_proc confused"
#define syserr_dbx_write "dbg_write(%lx)"
#  endif
#endif

#ifdef TARGET_HAS_COFF
#define syserr_coff_reloc "relocate_code_to_data(PCreloc)"
#define syserr_coff_pcrel "coff(unexpected X_PCreloc)"
#define syserr_coff_m88000 "coffobj(X_DataAddr needs extending)"
#define syserr_coff_toobig "coffobj(Module over 64K -- fix)"
#define syserr_coff_checksym "obj_checksym($r)"
#define syserr_coff_reloc1 "obj_coderelocation(%.8lx)"
#define syserr_coff_gendata "obj_gendata(%ld)"
#define syserr_coff_datalen "obj_data len=%ld"
#define syserr_coff_data "obj_data %ldEL%ld'%s'"
#endif

#ifdef TARGET_IS_HELIOS
#define syserr_heliobj_bad_xref "Invalid external reference $r %#lx"
#define syserr_heliobj_dataseggen "Data seg generation confused"
#define syserr_heliobj_gendata "obj_gendata(%ld)"
#define syserr_heliobj_datalen "obj_data len=%ld"
#define syserr_heliobj_data "obj_data %ldEL%ld'%s'"
#define syserr_heliobj_align "Helios obj align"
#define syserr_heliobj_2def "double definition in obj_symref $r"
#define syserr_heliobj_codedata "code/data confusion for $r"
#endif

      /* The following remain as ordinary (uncompressed) strings */

#define misc_message_announce "+++ %s: "
#define misc_message_announce1 "+++ %s: %ld: %s: "

/*
 * @@@ Wording here is subject to change...
 */
#define misc_message_warning   "Warning"
#define misc_message_error     "Error"
#define misc_message_serious   "Serious error"
#define misc_message_fatal     "Fatal error"
#define misc_message_fatal_internal "Fatal internal error"
#define misc_message_abandoned "\nCompilation abandoned.\n"

#define bind_msg_const "constant expression"

#define moan_floating_type "floating type initialiser"
#define moan_static_int_type "static integral type initialiser"

/*
 * The following are used in init_sym_name_table() and/or ctxtofdeclflag()
 * and eventually find their ways into various error messages.
 */

#define errname_aftercommand       " after command"
#define errname_unset              "<?>"
#define errname_pointertypes       "<after * in declarator>"
#define errname_toplevel           "<top level>"
#define errname_structelement      "<structure component>"
#define errname_formalarg          "<formal parameter>"
#define errname_formaltype         "<formal parameter type declaration>"
#define errname_blockhead          "<head of block>"
#define errname_typename           "<type-name>"
#define errname_unknown            "<unknown context>"
#define errname_error              "<previous error>"
#define errname_invisible          "<invisible>"
#define errname_let                "<let>"
#define errname_character          "<character constant>"
#define errname_wcharacter         "<wide character constant>"
#define errname_integer            "<integer constant>"
#define errname_floatcon           "<floating constant>"
#define errname_string             "<string constant>"
#define errname_wstring            "<wide string constant>"
#define errname_identifier         "<identifier>"
#define errname_binder             "<variable>"
#define errname_tagbind            "<struct/union tag>"
#define errname_cond               "_?_:_"
#define errname_displace           "++ or --"
#define errname_postinc            "++"
#define errname_postdec            "--"
#define errname_arrow              "->"
#define errname_addrof             "unary &"
#define errname_content            "unary *"
#define errname_monplus            "unary +"
#define errname_neg                "unary -"
#define errname_fnap               "<function argument>"
#define errname_subscript          "<subscript>"
#define errname_cast               "<cast>"
#define errname_sizeoftype         "sizeof"
#define errname_sizeofexpr         "sizeof"
#define errname_ptrdiff            "-"   /* for (a-b)=c msg */
#define errname_endcase            "break"
#define errname_block              "<block>"
#define errname_decl               "decl"
#define errname_fndef              "fndef"
#define errname_typespec           "typespec"
#define errname_typedefname        "typedefname"
#define errname_valof              "valof"
#define errname_ellipsis           "..."
#define errname_eol                "\\n"
#define errname_eof                "<eof>"

#ifdef RANGECHECK_SUPPORTED
#  define errname_rangecheck       "<rangecheck>"
#  define errname_checknot         "<checknot>"
#endif

/* end of miperrs.h */
/*
 * cfe/feerrs.h - prototype for front-end error messages file
 * version 2.
 */

  /* Ordinary error messages - mapped onto numeric codes */

#define lex_warn_force_unsigned "%s\375%sul\21332-b�i�Bm�a\030"    /* "%s treated as %sul in 32-bit implementation" */
#define lex_warn_multi_char "�p\010t��\203\1361 \232\016\213\'\330\'"    /* "non-portable - not 1 char in '...'" */

#define syn_warn_hashif_undef "Un\224\013�cr\022\'%s\'\213\043i\027-\375\
0"    /* "Undefined macro '%s' in #if - treated as 0" */
#define syn_warn_invent_extern "\001v�\037\'P�\023\004%s\050\051\073\'"    /* "inventing 'extern int %s();'" */
#define syn_warn_unary_plus "Un\016\140\'\053\033�\376fe\034�\002WANSI \
C"    /* "Unary '+' is a feature of ANSI C" */
#define syn_warn_spurious_braces "sp�i\210\015\173\175 \016o\026�sc\011\
\016\023\312\003"    /* "spurious {} around scalar initialiser" */
#define syn_warn_dangling_else "D7gl\037\'�\315\'\023d�\034�s�b��\010"    /* "Dangling 'else' indicates possible error" */
#define syn_warn_void_return "��\002\020t�n\213�\336��\030"    /* "non-value return in non-void function" */
#define syn_warn_use_of_short \
        "\'sh\010t\033s\176w\003Yh7 �\033\007Yhܒ\232\001\002\050\315\002\
m7u\011\051"    /* "'short' slower than 'int' on this machine (see manual)" */
#define syn_warn_enum_unchecked "N\022\366\232�k\037W\'\035\205\'\023Yh\
ܡ�\036\003"    /* "No type checking of 'enum' in this compiler" */
#define syn_warn_undeclared_parm \
        "�\174�\207$r \136\266\016\013\203�\033\322\005"    /* "formal parameter $r not declared - 'int' assumed" */
#define syn_warn_old_style "Old-Ky��$r"    /* "Old-style function $r" */
#define syn_warn_give_args "Dep\020c�\266�\177%s\050�\203giv\002\016\025�\
\265"    /* "Deprecated declaration %s() - give arg types" */
#define syn_warn_ANSI_decl "ANSI Ky��\266�\177�\005�\'%s\050\330\051\'"    /* "ANSI style function declaration used, '%s(...)'" */
#define syn_warn_archaic_init "Anci\035\004� of\023\312a\030��\002\'\075\'"    /* "Ancient form of initialisation, use '='" */
#define syn_warn_untyped_fn "\'\001\004%s\050\051\033\322\013\203\'\336\
d\'\023t\035d\005\077"    /* "'int %s()' assumed - 'void' intended?" */
#define syn_warn_no_named_member "$c h�n\022n�\013�mb\003"    /* "$c has no named member" */
#define syn_warn_extra_comma "S\316\003flu\210\015\',\'\213\'\035\205\033\
\266�\030"    /* "Superfluous ',' in 'enum' declaration" */

#define vargen_warn_nonull "om\206t\037t\314\036\037\'\\0\033�%s \133%l\
d\135"    /* "omitting trailing '\\0' for %s [%ld]" */
#define vargen_warn_unnamed_bitfield \
        "Unn�\013b���d\023\312\013�0"    /* "Unnamed bit field initialised to 0" */

#define lex_err_ioverflow "N\205b�%sY�l�\002�32-b�i�Bm�a\030"    /* "Number %s too large for 32-bit implementation" */
#define lex_err_overlong_fp "G�ssl\140�-l\007\025�\034\037�\004n\205b\003"    /* "Grossly over-long floating point number" */
#define lex_err_fp_syntax1 "D\204�\020�ir\013�\246\007\035\004m\016k\003"    /* "Digit required after exponent marker" */
#define lex_err_overlong_hex "G�ssl\140�-l\007\025hPa\024cim\174�t"    /* "Grossly over-long hexadecimal constant" */
#define lex_err_overlong_int "G�ssl\140�-l\007\025n\205b\003"    /* "Grossly over-long number" */
#define lex_err_need_hex_dig "HP d\204�ne\005\013�0x \0320X"    /* "Hex digit needed after 0x or 0X" */
#define lex_err_need_hex_dig1 "\374hP d\204\206\050s��\\x"    /* "Missing hex digit(s) after \\x" */
#define lex_err_backslash_blank \
        "\\\074sp\377e\2547�\\\074t�\254\016\002\001\317i�Kr\037\265cap\
\265"    /* "\\<space> and \\<tab> are invalid string escapes" */
#define lex_err_unterminated_string "New�\002\032\035�Wf\036\002\340�Kr\
\342"    /* "Newline or end of file within string" */
#define lex_err_bad_hash "m\031pl\377\013p\020p�c\265s\032\232�c\207\'%\
c\'"    /* "misplaced preprocessor character '%c'" */
#define lex_err_bad_char "�\232�c\207\0500x%lx \075 \'%c\'\051\213s\210\
rce"    /* "illegal character (0x%lx = \'%c\') in source" */
#define lex_err_bad_noprint_char "�\232�c\207\050hP ��0x%x\051\213s\210\
rce"    /* "illegal character (hex code 0x%x) in source" */
#define lex_err_ellipsis "\050\330�m�\004hav\002P\377tl\1403 dots"    /* "(...) must have exactly 3 dots" */
#define lex_err_illegal_whitespace "$s �\140\136hav\002wh\206\265p\377\002\
�\206"    /* "$s may not have whitespace in it" */

#define syn_err_bitsize "b��z\002%ld �\2031 \322\005"    /* "bit size %ld illegal - 1 assumed" */
#define syn_err_zerobitsize "z\003\022wid� n�\013b����\2031 \322\005"    /* "zero width named bit field - 1 assumed" */
#define syn_err_arraysize "Ar\314\140�z\002%ld �\2031 \322\005"    /* "Array size %ld illegal - 1 assumed" */
#define syn_err_expected "�$s -\023s\003��\002$l"    /* "expected $s - inserted before $l" */
#define syn_err_expected1 "�$s%s -\023s\003��\002$l"    /* "expected $s%s - inserted before $l" */
#define syn_err_expected2 "�$s \032$s -\023s\003�$s �\002$l"    /* "expected $s or $s - inserted $s before $l" */
#define syn_err_expecteda "�$s"    /* "expected $s" */
#define syn_err_expected1a "�$s%s"    /* "expected $s%s" */
#define syn_err_expected2a "�$s \032$s"    /* "expected $s or $s" */
#define syn_err_mix_strings "\232\016 7�wi�\050L\"\330\"�Kr\342\015d\022\
\136�c\034\035\034e"    /* "char and wide (L\"...\") strings do not concatenate" */
#define syn_err_expected_expr "\074\246\373�\007\254��\321�$s"    /* "<expression> expected but found $s" */
#define syn_err_type_needed "\366n�\002\246�t\005"    /* "type name expected" */
#ifdef EXTENSION_VALOF
#define syn_err_valof_block \
        "\173 �l\176w\037\376\264\004w\036l �t\341VALOF b\176ck"    /* "{ following a cast will be treated as VALOF block" */
#endif
#define syn_err_typedef "�\005e\027n�\002$r �\013�\246\373�\262�tPt"    /* "typedef name $r used in expression context" */
#define syn_err_assertion "\137\137\137�\003t\0500�$e\051"    /* "___assert(0, $e)" */
#define syn_err_expected_id "Exp\320\074i\024n\014�\003\254�$s �\321�$l"    /* "Expected <identifier> after $s but found $l" */
#define syn_err_hashif_eof "EOF \136new�\002�\043i\027\330"    /* "EOF not newline after #if ..." */
#define syn_err_hashif_junk "J\026k �\043i\027\074\246\373�\007\076"    /* "Junk after #if <expression>" */
#define syn_err_initialisers "t�m7y\023\312\003\015�\173\175 �agg\020g\034\
e"    /* "too many initialisers in {} for aggregate" */
#define syn_err_initialisers1 "\173\175 m�\004hav\0021 eBm\035�\001\312\
\002sc\011\016"    /* "{} must have 1 element to initialise scalar" */
#define syn_err_default "\'\211ault\033\136�s�\232 �"    /* "'default' not in switch - ignored" */
#define syn_err_default1 "d\316�\034\002\'\211ault\033\264\002\261"    /* "duplicate 'default' case ignored" */
#define syn_err_case "\'\264e\033\136�s�\232 �"    /* "'case' not in switch - ignored" */
#define syn_err_case1 "d\316��\264\002�t5%ld"    /* "duplicated case constant: %ld" */
#define syn_err_expected_cmd "\074�mm7d\254��\321�\376$s"    /* "<command> expected but found a $s" */
#define syn_err_expected_while "\'wh\036e\033�\'do\033\203\321�$l"    /* "'while' expected after 'do' - found $l" */
#define syn_err_else "M\031pl\377\013\'�\315\033\261"    /* "Misplaced 'else' ignored" */
#define syn_err_continue "\'�t\001ue\033\136�\176\313 �"    /* "'continue' not in loop - ignored" */
#define syn_err_break "\'b\020ak\033\136�\176\313 \032s�\232 �"    /* "'break' not in loop or switch - ignored" */
#define syn_err_no_label "\'goto\033\136�l\176w\013b\140l�� �"    /* "'goto' not followed by label - ignored" */
#define syn_err_no_brace "\'\173\033W�bod\140�\203\321�$l"    /* "'{' of function body expected - found $l" */
#define syn_err_stgclass \
        "K\010ag\002\215\100\015$s \136p\003m\206���tP\004%s �"    /* "storage class $s not permitted in context %s - ignored" */
#define syn_err_stgclass1 "K\010ag\002\215\100\015$s\023��a\014b�\340 $\
m �"    /* "storage class $s incompatible with $m - ignored" */
#define syn_err_typeclash "\366$s\023�s\031t\035\004\340 $m"    /* "type $s inconsistent with $m" */
#define syn_err_tag_brace \
        "\'\173\033\032\074i\024n\014�\003\254�$s��\321�$l"    /* "'{' or <identifier> expected after $s, but found $l" */
#define syn_err_expected3 "Exp�t\037\074\266\016\034\010\254\032\074�e\076\
��\321�$l"    /* "Expecting <declarator> or <type>, but found $l" */
#define syn_err_unneeded_id \
        "I\024n\014��\050%s�\321d\213\074�K\314c\004\266\016\034\010\254\
�"    /* "Identifier (%s) found in <abstract declarator> - ignored" */
#define syn_err_undef_struct(m,b,s) \
        "\026\224\013$c %s5$r"    /* "undefined $c %s: $r" */, b, errs_membobj(m), s
#define syn_err_selfdef_struct(m,b,s) \
        "\034te��\001\215u�$c %s5$r \340�\206s�f"    /* "attempt to include $c %s: $r within itself" */, \
        b, errs_membobj(m), s
#define syn_err_void_object(m,s) "�\'\336d\033%s5$r"    /* "illegal 'void' %s: $r" */, errs_membobj(m), s
#define syn_err_duplicate_type \
        "d\316�\034\002\366sp�if�a\177W�\174�\207$r"    /* "duplicate type specification of formal parameter $r" */
#define syn_err_not_a_formal "N��\174$r\213�\017-�e-sp�i�\003"    /* "Non-formal $r in parameter-type-specifier" */
#define syn_err_cant_init "$m v\016i�B\015�\140\136�\001\312\005"    /* "$m variables may not be initialised" */
#define syn_err_enumdef \
        "\074i\024n\014�\003\254��\321�$l\213\'\035\205\033\224i\030"    /* "<identifier> expected but found $l in 'enum' definition" */
#define syn_err_misplaced_brace "M\031pl\377\013\'\173\033a\004t\313 Bv\
� \203�\037b\176ck"    /* "Misplaced '{' at top level - ignoring block" */

#define vargen_err_long_string "Kr\342\023\312�l\007g\003Yh7 %s \133%ld\
\135"    /* "string initialiser longer than %s [%ld]" */
#define vargen_err_nonstatic_addr \
        "�Ka\014c add\373\015$b\213�\023\312\003"    /* "non-static address $b in pointer initialiser" */
#define vargen_err_bad_ptr "$s5Ĥ\002��\023\312\003"    /* "$s: illegal use in pointer initialiser" */
#define vargen_err_init_void "obj�t\015W\366\'\336d\033c7 \136�\001\312\
\005"    /* "objects of type 'void' can not be initialised" */
#define vargen_err_undefined_struct \
        "$c m�\004�\224\013�\050Ka\014c�v\016i��\266�\030"    /* "$c must be defined for (static) variable declaration" */
#define vargen_err_open_array "Un\001\312\013Ka\014c \133\135 \016\314y\015\
\231\011"    /* "Uninitialised static [] arrays illegal" */
#define vargen_err_overlarge_reg "g\176b\174\020g\031\207n\205b\003Y�l�\
e"    /* "global register number too large" */
#define vargen_err_not_int "\001\317idY�\002�g\176b\011\023\004\020g\031\
\017"    /* "invalid type for global int register" */
#define vargen_err_not_float "\001\317idY�\002�g\176b\174�a\004\020g\031\
\017"    /* "invalid type for global float register" */
#ifdef TARGET_CALL_USES_DESCRIPTOR
#define vargen_err_badinit "\231\011\023\312a\030Y\022$r%\053ld"    /* "illegal initialisation to $r%+ld" */
#endif
#ifdef TARGET_IS_HELIOS
#define vg_err_dynamicinit "In\312\013dyn� \016\314\140\340 -ZR \032-Z\
L"    /* "Initialised dynamic array with -ZR or -ZL" */
#endif
#define vargen_rerr_nonaligned \
        "N�\011\216\013ADCON a\004d\034a\0530x%lx \050�\002$r\0530x%lx�\
\315�NULL"    /* "Non-aligned ADCON at data+0x%lx (value $r+0x%lx) set to NULL" */
#define vargen_rerr_datadata_reloc \
       "RISC OS \050\032o�\003�\020�r7\004modu�h�Ka\014c\023\206.Y\022d\
\034\376$r"    /* "RISC OS (or other) reentrant module has static init. to data $r" */

#define lex_rerr_8_or_9 "d\204�8 \0329 \321d\213oct\174n\205b\003"    /* "digit 8 or 9 found in octal number" */
#define lex_rerr_pp_number "n\205b�\231\011l\140�l\176w\013b\140Bt\017"    /* "number illegally followed by letter" */
#define lex_rerr_hex_exponent "hP n\205b�c7\136hav\002\246\007�"    /* "hex number cannot have exponent" */
#define lex_rerr_esc16_truncated \
        "�l�\002\265cap\002\'\\x%s%lx\033t\341\'\\x%lx\'"    /* "overlarge escape '\\x%s%lx' treated as '\\x%lx'" */
#define lex_rerr_esc8_truncated "�l�\002\265cap\002\'\\%o\033t\341\'\\%\
o\'"    /* "overlarge escape '\\%o' treated as '\\%o'" */
#define lex_rerr_illegal_esc "�Kr\037\265cap\002\'\\%c\033-\375%c"    /* "illegal string escape '\\%c' - treated as %c" */
#define lex_rerr_not1wchar "L\'\330\033ne\005\015P\377tl\1401 wi�\232�c\
\017"    /* "L'...' needs exactly 1 wide character" */
#define lex_rerr_empty_char "n\022\232\016\015�\232�c\207�\004\'\'"    /* "no chars in character constant ''" */
#define lex_rerr_overlong_char "m\010\002�7 4 \232\016\015�\232�c\207�t"    /* "more than 4 chars in character constant" */

#define syn_rerr_array_0 "\016\314\140\1330\135 \321d"    /* "array [0] found" */
#ifdef EXTENSION_VALOF
#define syn_rerr_void_valof "\336�\317Wb\176ck\015\016\002\136p\003m\206\
t\005"    /* "void valof blocks are not permitted" */
#endif
#define syn_rerr_undeclared "\026\266\016\013na�,\023v�\037\'P�\023\004\
%s\'"    /* "undeclared name, inventing 'extern int %s'" */
#define syn_rerr_insert_parens \
        "p\016�h\265�\050\214\051\023s\003�\016o\026�\246\373�\262�l\176\
w\037$s"    /* "parentheses (..) inserted around expression following $s" */
#define syn_rerr_return "\020t�n \074\246r\254ħ\336��\030"    /* "return <expr> illegal for void function" */
#define syn_rerr_qualified_typedef(b,m) \
        "$mY�\005e\027$b h�$m \020-sp�i�\005"    /* "$m typedef $b has $m re-specified" */, m, b, m
#define syn_rerr_missing_type "m�\366sp�if�a\177\203�\033\322\005"    /* "missing type specification - 'int' assumed" */
#define syn_rerr_long_float "ANSI C do�\136s\316p\010\004\'l\007\025�\034\'"    /* "ANSI C does not support 'long float'" */
#define syn_rerr_missing_type1 \
        "om\206�\074�e\254�\002�\174\266\016\034\032\203�\033\322\005"    /* "omitted <type> before formal declarator - 'int' assumed" */
#define syn_rerr_missing_type2 \
        "�p�to\366�\174$r ne\005\015\366\032\215\100\015\203�\033\322\005"    /* "function prototype formal $r needs type or class - 'int' assumed" */
#define syn_rerr_ellipsis_first "�lip�\015\050\330�c7\136�\007l\140�\017"    /* "ellipsis (...) cannot be only parameter" */
#define syn_rerr_mixed_formals "p�to\3667�old-Ky��\017\015mix\005"    /* "prototype and old-style parameters mixed" */
#define syn_rerr_open_member "�\133\135 �mb\0035$r"    /* "illegal [] member: $r" */
#define syn_rerr_fn_returntype "�\020t�n\037$t �-\203\322\037�"    /* "function returning $t illegal -- assuming pointer" */
#define syn_rerr_array_elttype "\016\314\140W$t �-\203\322\037�"    /* "array of $t illegal -- assuming pointer" */
#define syn_rerr_fn_ptr(m,s) \
   "%s $r �\140\136��-\203\322\037�"    /* "%s $r may not be function -- assuming pointer" */, errs_membobj(m), s
#define syn_rerr_fn_ptr1 \
        "�$r �\140\136�\001\312\013\203\322\037Ű"    /* "function $r may not be initialised - assuming function pointer" */
#define syn_rerr_archaic_init "Anci\035\004� of\023\312a\030��\002\'\075\'"    /* "Ancient form of initialisation, use '='" */
#define syn_rerr_bitfield "�b���dY�\002$t \203�\033\322\005"    /* "illegal bit field type $t - 'int' assumed" */
#define syn_rerr_missing_formal "�\174n�\002m�\342\213�\224i\030"    /* "formal name missing in function definition" */
#define syn_rerr_ineffective "\266�\177\340 n\022eff�t"    /* "declaration with no effect" */
#define syn_rerr_duplicate_member(sv,b) "d\316�\034\002�mb�$r W$c"    /* "duplicate member $r of $c" */, sv, b
#define syn_rerr_missing_type3 \
        "\366\032\215\100\015ne\005\013\050Pcep\004��\224i\030�\203�\033\
\322\005"    /* "type or class needed (except in function definition) - 'int' assumed" */
#define syn_rerr_semicolon_in_arglist \
        "\',\033\050\136\'\073\'�\315p\016\034��\174�\017s"    /* "',' (not ';') separates formal parameters" */
#define syn_rerr_no_members "$c h�n\022�mb\003s"    /* "$c has no members" */

      /* The following remain as ordinary (uncompressed) strings */

#define syn_moan_hashif "#if <expression>"
#define syn_moan_case "case expression (ignored)"

 /* The next batch of things just get mapped onto syserr codes */

#define syserr_genpointer "genpointer&(%ld)"
#define syserr_initsubstatic "initsubstatic(bit)"
#define syserr_initstatic "initstatic(%ld,%#lx)"
#define syserr_initstatic1 "initstatic(%ld)"
#define syserr_rd_decl_init "rd_decl/init(%#lx)"
#define syserr_rd_typename "rd_typename()=0"
#define syserr_rdinit "syn_rdinit"
#define syserr_rd_declarator "rd_declarator(%ld)"
#define syserr_defaultstgclass "defaultstorageclass(%#x)"
#define syserr_rd_declrhslist "rd_declrhslist confused"
#define syserr_rd_decl2 "rd_decl2(%p,%ld)"
#define syserr_rd_strdecl "rd_strdecl"
#define syserr_lex_string "lex_string"

/* end of cfe/feerrs.h */
/*
 * c40/mcerrs.h - prototype for machine-specific error messages file
 */

  /* Ordinary error messages - mapped onto numeric codes */

/*
 * The following message is always machine specific since it may include
 * information about the source of support for the product.
 */
#define misc_disaster_banner   "\n���Â\052\n\052 Th\002��\036�h�\024t\320\
7\023�\011\023�s\031t\035cy.�Th�c7 occ�\052\n\052 b�a�\002�h�r\026 \210�\
\376v\206\174\373\210rc\002su\232 ��m\010\140\032d\031k�� \052\n\052 sp\
\377\002\032b�a�\002�\003\002�\376faul\004�\206.�I\027y\210 c7\136e\100\
\036\140\011\207 \052\n\052 y\210r p�g\314mY\022a\336�ca�\037��r\016\002\
fa\036u\020�pB\100\002�t\377\004y\210r�\052\n\052 \024\011\003.�Th\002\024\011\
��\140ֹ��h�p y\210 imm\005i\034�\1407�w\036l ־\052\n\052 ���\020p\010\
\004\376s�p\320��\036�faul��\002s\316p\010\004c�\020.���\052\n���Â\052\n\n"    /* "\n\
*************************************************************************\n\
* The compiler has detected an internal inconsistency.  This can occur  *\n\
* because it has run out of a vital resource such as memory or disk     *\n\
* space or because there is a fault in it.  If you cannot easily alter  *\n\
* your program to avoid causing this rare failure, please contact your  *\n\
* dealer.  The dealer may be able to help you immediately and will be   *\n\
* able to report a suspected compiler fault to the support centre.      *\n\
*************************************************************************\n\
\n" */

  /* System failure messages - text not preserved */

#define syserr_local_address 		"local_address %lx"
#define syserr_decode_branch_address	"decode_branch_address %.8lx"
#define syserr_unknown_diadic_op	"unknown diadic op code %02x"
#define syserr_unknown_triadic_op	"unknown triadic op code %02x"
#define syserr_non_float_dest		"destination of floating point op is not an extended precision register! (%s)"
#define syserr_unknown_indirect_mode	"unknown indirect addressing mode %x"
#define syserr_unknown_triadic_address	"unknown form of triadic addressing, instruction = %x"
#define syserr_unknown_parallel_op	"unknown parallel op code %x"
#define syserr_bad_parallel_addressing	"malformed parallel addressing discovered, instruction = %x"
#define syserr_unknown_op_code		"unknown op code %x"
#define syserr_asmlab 			"odd asmlab(%lx)"
#define syserr_display_asm 		"display_asm(%lx)"
#define syserr_asm_trailer 		"asm_trailer(%ld)"
#define syserr_datalen 			"asm_data len=%ld"
#define syserr_asm_trailer1 		"asm_trailer(%ldF%ld)"
#define syserr_asm_trailer2 		"asm_trailer(LIT_ADCON rpt)"
#define syserr_asm_confused 		"Assembler output confused - find '?'"
#define syserr_unknown_addressing_mode	"Unknown addressing mode - %x"
#define syserr_not_address_register	"relative reference through non-address register %d"
#define syserr_unsupported_branch_type	"unsopported branch type %ld"
#define syserr_bad_block_length		"negative block length %d"
#define syserr_large_shift		"attempting to shift by unreasonably large amount %d"
#define syserr_bad_addressing_mode	"asked to build an invalid addressing mode"
#define syserr_bad_arg 			"Bad arg %lx"
#define syserr_local_addr 		"local_addr"
#define syserr_firstbit			"warning: attempting to find first bit set of 0 !"
#define syserr_displacement 		"displacement out of range %ld"
#define syserr_labref 			"unknown label reference type %.8lx"
#define syserr_enter 			"emit(J_ENTER %ld)"
#define syserr_data_sym			"Unable to find another data symbol at %ld"
#define syserr_show_inst 		"show_instruction (%#lx)"
#define syserr_movr 			"movr r,r"
#define syserr_offset_out_of_range	"offset (%d) is too big"
#define syserr_cannot_do_block_move	"cannot do block move"
#define syserr_bad_length		"bad length for block operation => %d"	  
#define syserr_local_base 		"local_base %lx"
#define syserr_setsp_confused 		"SETSP confused %ld!=%ld %ld"
  
/* end of c40/mcerrs.h */
#ifndef NO_INSTORE_FILES
#  define NO_INSTORE_FILES 1
#endif

#define COMPRESSED_ERROR_MESSAGES 1

#ifdef DEFINE_ERROR_COMPRESSION_TABLE

static unsigned short int ecompression_info[256] = {
    0x0000,0x696e,0x6520,0x6572,0x7420,0x6564,0x2a2a,0x6f6e,
    0x6f72,0x616c,0x000a,0x0520,0x7469,0x7320,0x6172,0x7403,
    0x7265,0x0606,0x6f20,0x2001,0x6465,0x6720,0x756e,0x6620,
    0x0c07,0x6973,0x0820,0x2720,0x6174,0x656e,0x696c,0x0115,
    0x0020,0x0021,0x0022,0x0023,0x0024,0x0025,0x0026,0x0027,
    0x0028,0x0029,0x002a,0x002b,0x002c,0x002d,0x002e,0x002f,
    0x0030,0x0031,0x0032,0x0033,0x0034,0x3a20,0x0036,0x616e,
    0x0038,0x0039,0x003a,0x003b,0x003c,0x003d,0x003e,0x003f,
    0x6173,0x0041,0x6c65,0x0043,0x0044,0x0045,0x0046,0x0047,
    0x0048,0x0049,0x004a,0x7374,0x004c,0x004d,0x004e,0x004f,
    0x6578,0x6e6f,0x0052,0x0053,0x0054,0x0055,0x0056,0x6f17,
    0x0058,0x2074,0x005a,0x005b,0x005c,0x005d,0x5104,0x005f,
    0x7920,0x0061,0x0062,0x0063,0x0064,0x0065,0x0066,0x0067,
    0x0068,0x0069,0x006a,0x006b,0x006c,0x006d,0x006e,0x006f,
    0x0070,0x0071,0x0072,0x0073,0x0074,0x0075,0x0076,0x0077,
    0x0078,0x0079,0x007a,0x007b,0x0920,0x007d,0x6c6f,0x1820,
    0x6420,0x6563,0x1111,0x2d20,0x6967,0x756d,0x6974,0x0f20,
    0x6f75,0x1466,0x4267,0x1320,0x2e2e,0x636c,0x846e,0x0e61,
    0x6307,0x706f,0x6d61,0x740b,0x8901,0x9101,0x610d,0x6608,
    0x0320,0x1e8a,0x6368,0x6d70,0x7970,0x0120,0x6963,0x7412,
    0x0174,0x636f,0x656c,0x7369,0x7573,0x1663,0x5070,0x661a,
    0x66a5,0x6904,0x8e08,0x6c02,0x3e20,0x666f,0x6d65,0x7603,
    0x950f,0xaa05,0x0720,0x4073,0x6340,0x6573,0x148d,0x1c0b,
    0x2c20,0x6162,0x6166,0x6669,0x6c9e,0xba87,0x2020,0x2920,
    0x6275,0x749c,0x7786,0x8282,0x997c,0xa87f,0x0919,0x0cc6,
    0x1d74,0x667e,0x69c7,0x6f70,0x7261,0x7365,0x7570,0x7609,
    0x8193,0xad16,0xb385,0x072d,0x0e67,0x1973,0x6202,0x6c01,
    0x8c2e,0x976d,0x0372,0x10b7,0x690d,0x6f69,0x76dd,0xc004,
    0xc268,0xdb96,0x0167,0x0457,0x616d,0x650d,0x708f,0x726f,
    0x7468,0x7572,0x83b1,0x904b,0xa6d0,0xd51f,0xe6ae,0x27a0,
    0x6265,0x6402,0x6ed3,0x6f12,0x6faf,0x7175,0xc102,0xcf75,
    0xeb37,0x049f,0x0f6e,0x1073,0x4ded,0x59e1,0x6120,0x6163};


#endif

#define MAXSTACKDEPTH 4

#endif /* already loaded */

/* end of errors.h */
