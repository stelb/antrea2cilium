#!/bin/bash

kind create cluster --config config/cluster.yaml

tmux split -b -h k9s
tmux last-pane
