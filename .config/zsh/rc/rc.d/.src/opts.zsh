###################################################################
### https://zsh.sourceforge.io/Doc/Release/Options.html#Options ###
###################################################################

# alerts
setopt notify
setopt nobeep nohistbeep

# changing directories
setopt auto_cd
unsetopt cdable_vars cd_silent chase_dots chase_links posix_cd

# dir stack, for now not set since it's not set up
# still counts as cd
# setopt autopushd pushdsilent pushdtohome pushd_ignore_dups(?)
# unsetopt pushd_minus(?)

# completion
setopt always_last_prompt always_to_end
setopt auto_list auto_menu # can also be: bash_auto_list/menu_complete
setopt auto_param_keys auto_param_slash auto_remove_slash
setopt hash_list_all list_ambiguous list_types

unsetopt auto_name_dirs complete_aliases complete_in_word glob_complete
unsetopt list_beep

# expansion and globbing
setopt bad_pattern
## case sensitivity
setopt case_glob case_match
setopt equals extended_glob glob glob_dots glob_star_short multibyte
unsetopt nomatch
setopt numeric_glob_sort rc_expand_param

# history
## how history is being shared between shells
setopt share_history # one of these: append_history/inc_append_history/inc_append_history_time/share_history
## bang?
setopt bang_hist
## use fcntl?
setopt hist_fcntl_lock
## how dups are being handled
### disable writing
setopt hist_ignore_dups # hist_ignore_dups/hist_ignore_all_dups
setopt hist_expire_dups_first hist_find_no_dups
## other
setopt hist_ignore_space hist_no_store hist_verify
setopt extended_history hist_reduce_blanks

# input/output
setopt aliases clobber
setopt correct
setopt flow_control hash_cmds hash_dirs
setopt path_dirs rm_star_wait
setopt short_loops sun_keyboard_hack

# job control
# setopt auto_continue
setopt bg_nice
setopt check_jobs check_running_jobs
setopt hup
# setopt posix_jobs

# prompting
setopt prompt_bang prompt_percent prompt_subst

# scripts and functions
setopt debug_before_cmd
setopt local_loops local_options local_patterns local_traps
unsetopt octal_zeroes
## debug
setopt pipe_fail source_trace # xtrace
## unset
setopt typeset_to_unset

# needed
setopt extendedglob ksh_autoload
