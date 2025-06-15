#!/bin/bash

tmux split -b -v -l 30 bash -c 'while true; do cilium status; sleep 5; tput reset; done'
tmux last-pane
