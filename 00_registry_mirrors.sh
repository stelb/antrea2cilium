#!/bin/bash

# create registry mirrors in kind network
docker run -d --name dockerio --restart=always --net=kind -e REGISTRY_PROXY_REMOTEURL=https://registry-1.docker.io registry:2
docker run -d --name ghcrio --restart=always --net=kind -e REGISTRY_PROXY_REMOTEURL=https://ghcr.io registry:2
docker run -d --name quayio --restart=always --net=kind -e REGISTRY_PROXY_REMOTEURL=https://quay.io registry:2
docker run -d --name vmware --restart=always --net=kind -e REGISTRY_PROXY_REMOTEURL=https://projects.registry.vmware.com registry:2
