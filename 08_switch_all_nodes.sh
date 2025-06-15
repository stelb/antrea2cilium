#!/bin/bash

NODES=$(kind  get nodes -n antrea2cilium)

date
for n in $NODES; do
	echo $n
	./08_switch_node.sh $n
	date
done
