# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html#variables
local CONFIG_DIR=${XDG_CONFIG_HOME:-~/.config}/zsh
local CACHE_DIR=${XDG_CACHE_HOME:-~/.cache}/zsh
local DATA_DIR=${XDG_CACHE_HOME:-~/.local/share}/zsh

for file in $CONFIG_DIR/base/*.zsh; do
    source $file
done

function loadPlugin() {
    source "$CONFIG_DIR/plugins/$1.zsh"
}

function loadTheme() {
    source "$CONFIG_DIR/themes/$1.zsh"
}

# initialisize all vars
loadTheme default
