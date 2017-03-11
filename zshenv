export EDITOR='vim'
export BROWSER='chromium'
# "QGtkStyle was unable to detect the current GTK+ theme."
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# so java can easily read that
export COLUMNS
# otherwise ctest isn't very verbose
export CTEST_OUTPUT_ON_FAILURE=1
# let make use 5 threads
export MAKEFLAGS=-j5
# go
export GOPATH=~/dev/go
