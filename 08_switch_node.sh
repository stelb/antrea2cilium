#!/bin/bash

NODE=$1

# cordon & drain node
kubectl cordon $NODE
kubectl drain $NODE --ignore-daemonsets

# set label for migration
kubectl label node $NODE --overwrite "io.cilium.migration/cilium-default=true"

# restart cilium on NODE
kubectl -n kube-system delete pod --field-selector spec.nodeName=$NODE -l k8s-app=cilium

# wait for restart
kubectl -n kube-system rollout status ds/cilium -w

# reboot
docker restart $NODE

# wait for cilium
cilium status --wait

# uncordon
kubectl uncordon $NODE
