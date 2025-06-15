#!/bin/bash
ANTREA_VERSION=v2.3.0
kubectl delete -f https://github.com/antrea-io/antrea/releases/download/${ANTREA_VERSION}/antrea.yml
