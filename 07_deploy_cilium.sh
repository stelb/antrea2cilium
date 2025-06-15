#!/bin/sh

cilium install -f helm/values-migration.yaml --dry-run-helm-values >helm/values-initial.yaml

helm install cilium cilium/cilium --namespace kube-system --values helm/values-initial.yaml

cilium status --wait

kubectl apply --server-side -f manifests/CiliumNodeConfig.yaml
