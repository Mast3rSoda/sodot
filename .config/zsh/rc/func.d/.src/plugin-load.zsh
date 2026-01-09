# inspired by: https://github.com/mattmc3/zsh_unplugged?tab=readme-ov-file#jigsaw-the-humble-plugin-load-function

plugin-load() {
    if [[ "$#" -eq 0 || "$1" = "-h" || "$1" = "--help" ]]; then
        # TODO: finish the help message
        cat << EOF
Usage: plugin-load [repo|url]...
Loads a zsh plugin from a remote repository

  -h, --help        show this message
  -v, --verbose     enables verbose logging
EOF
    fi

    local plugin repo commitsha plugdir initfile
    : ${SD_PLUGIN_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/sodot/plugins}
    for plugin in $@; do
        repo="$plugin"
        clone_args=(-q --depth 1 --recursive --shallow-submodules)
        # Pin repo to a specific commit sha if provided
        if [[ "$plugin" == *'@'* ]]; then
            repo="${plugin%@*}"
            commitsha="${plugin#*@}"
            clone_args+=(--no-checkout)
        fi
        plugdir=$SD_PLUGIN_DIR/${repo:t}
        initfile=$plugdir/${repo:t}.plugin.zsh

        if [[ ! -d $plugdir ]]; then
            echo "Cloning $repo..."
            git clone "${clone_args[@]}" https://github.com/$repo $plugdir
            if [[ -n "$commitsha" ]]; then
                git -C $plugdir fetch -q origin "$commitsha"
                git -C $plugdir checkout -q "$commitsha"
            fi
        fi
        if [[ ! -e $initfile ]]; then
            initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
            (( $#initfiles )) || { echo >&2 "No init file found '$repo'." && continue }
            ln -sf $initfiles[1] $initfile
        fi
        fpath+=$plugdir
        (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
    done
    unset plugin repo commitsha plugdir initfile
}
