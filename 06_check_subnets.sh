#!/bin/bash

echo "#####"
echo
echo "Antrea subnets"

kubectl get antreaagentinfos.crd.antrea.io -o json | jq ".items[].nodeSubnets[]"

echo
echo "#####"
echo
echo "Cilum subnets"

grep -i cidr helm/values-migration.yaml
