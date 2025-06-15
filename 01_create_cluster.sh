#!/bin/bash

kind create cluster --config config/cluster.yaml

# watch all pods in separate tmux pane
tmux split -b -h k9s -A -c po
tmux last-pane
