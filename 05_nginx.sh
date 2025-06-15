#!/bin/bash

kubectl apply -f manifests/nginx.yaml

kubectl rollout status --watch deployment nginx
