#!/bin/bash

# create final config for cilium helm deployment
cilium install --helm-values helm/values-initial.yaml \
  --set operator.unmanagedPodWatcher.restart=true \
  --set cni.customConf=false \
  --set policyEnforcementMode=default \
  --set bpf.hostLegacyRouting=false \
  --dry-run-helm-values >helm/values-final.yaml

# check
diff helm/values-initial.yaml helm/values-final.yaml

# upgrade
helm upgrade --namespace kube-system cilium cilium/cilium --values helm/values-final.yaml
kubectl -n kube-system rollout restart daemonset cilium

# wait for rollout
cilium status --wait

# remove per-node config
kubectl delete -n kube-system ciliumnodeconfigs.cilium.io cilium-default
