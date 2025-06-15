#!/bin/bash

# header{xxx} available starting with curl 7.84 only..
check_command="curl -s -o /dev/null -w \"%header{date} CODE %{http_code}\n\" http://localhost | grep -v 200"
# so to make scrolling more visible, use more or less random request detail local_port
check_command="curl -s -o /dev/null -w \"%{local_port} CODE %{http_code}\n\" http://localhost | grep -v 200"

tmux split -b -v bash -c "while true; do $check_command ; done"
tmux last-pane
