# cd
setopt auto_cd
unsetopt cdable_vars cd_silent chase_dots chase_links posix_cd

# dir stack, for now not set since it's not set up
# still counts as cd
# setopt autopushd pushdsilent pushdtohome pushd_ignore_dups(?)
# unsetopt pushd_minus(?)

# completion
setopt always_last_prompt always_to_end auto_list auto_menu auto_param_keys auto_param_slash
unsetopt auto_name_dirs bash_auto_list complete_aliases complete_in_word glob_complete

setopt inc_append_history share_history extended_history
setopt hist_ignore_dups hist_expire_dups_first hist_save_no_dups hist_find_no_dups
setopt hist_reduce_blanks hist_allow_clobber
setopt hist_ignore_space hist_no_store
setopt hist_verify

# needed
setopt extendedglob ksh_autoload

# alerts
setopt bad_pattern notify
setopt nonomatch nobeep nohistbeep
