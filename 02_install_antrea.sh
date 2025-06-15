#!/bin/bash
ANTREA_VERSION=v2.3.0
kubectl apply -f https://github.com/antrea-io/antrea/releases/download/${ANTREA_VERSION}/antrea.yml

kubectl rollout status --watch -n kube-system daemonset antrea-agent
