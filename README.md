# Migrate a k8s cluster with antrea CNI to cilium

I have no tanzu to mess around, so I use kind

## just show me.
I have added some tmux magic in the scripts, so you can see what's happening without arranging terminals.
Have a big monitor :)

https://asciinema.org/a/723314

## Requirements

My scripts expect a few installed commands

- tmux (used for automatically splitting terminal to be used for output)
- docker and compose plugin
- kind
- kubectl
- helm
- cilium
- jq

## Summary

### Infrastructure

I added some 'infrastructure' for convenience which is running in docker

#### Registry mirrors

To speed things up, as images are pulled multiple time alone for a single run and to avoid waiting and hitting rate limits I added mirrors to be used
(props to ...)

- docker
- github
- redhat
- vmware

They are deployed with network kind

#### Simple loadblancer

To check availibility of workload without different ports, while control-planes are upgraded
This needs the running kind setup


### kind cluster

- 3 control-planes
- 4 worker-nodes

You need at least 2 for redundancy... but this should be obvious :)

kind will be setup with config for the mentioned mirrors and without CNI

### Antrea Installation

just applying a manifest

### Cilium pre migration installation

Cilium will be installed without being activated and with special parameters to work with workload using a different CNI.

### Actual migration

Migration is triggered node by node by setting a label after cordon and draining a node.
Migration is finished after rebooting and uncordon.


### Remove Migration parameters

The cilium migration will be finalized by removing parameters needed for co-working with existing antrea

### Remove antrea

kubectl delete installation manifest
