# Migrate a k8s cluster with antrea CNI to cilium

I have no tanzu to mess around, so I use kind

It's meant for a demo, so I run it in a tmux session and some panes will be opened to watch what is happening:
- in the cluster
- possible nginx errors
- and cilium state

This is based on [Tutorial: How to Migrate to Cilium](https://isovalent.com/blog/post/tutorial-migrating-to-cilium-part-1/) by Nico Vibert
and [Migrating from Calico](https://isovalent.com/labs/cilium-migrating-from-calico/) Lab

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
- k9s
- helm
- cilium
- jq

## Summary

### Infrastructure

I added some 'infrastructure' for convenience which is running in docker

#### Registry mirrors

To speed things up, as images are pulled multiple time alone for a single run and to avoid waiting and hitting rate limits I added mirrors to be used
(props to Duffie Cooley)

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

## Doing
Start tmux and then execute scripts in oder:

```shell
# docker registry mirrors in kind network
$ ./00_registry_mirrors.sh

# kind cluster without cni, k9s to watch all pods will be started in a tmux pane
$ ./01_create_cluster.sh

# deploy antrea
$ ./02_install_antrea.sh

# start a loadbalancer in docker within kind network
$ ./03_loadbalancer.sh

# run curl in a loop and output any non-200 state in a tmux pane
$ ./04_check_nginx.sh

# create nginx deployment
$ ./05_nginx.sh

# check antreas subnets with configured nets for cilium
$ ./06_check_subnets.sh

# should be no conflict, so deploy cilium with migration setting
# and add CiliumNodeConfig for switching node by node
$ ./07_deploy_cilium.sh

# call next script for each node. 
$ ./08_switch_node.sh antrea2cilium-worker

# remove migration settings
$ ./09_finalize_migration.sh

# remove antrea
$ ./11_delete_antrea.sh

# finished, no errors destroy everything including tmux session.
$ ./12_stop.sh 
```

To watch cilium state, cilium.sh will start another tmux pane calling ```cilimu status``` every few seconds
```shell
# can be called any time
$ ./cilium.sh
```



