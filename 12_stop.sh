#!/bin/bash

echo
echo stop loadbalancer

(
    cd lbs
    docker compose stop
    docker compose rm -f
)

echo
echo stop registry mirrors
docker stop dockerio ghcrio quayio vmware

echo delete kind cluster
kind delete cluster -n antrea2cilium

echo exit tmux
sleep 10

tmux kill-session
