#!/bin/sh


kubectl delete pod -n demo --all
kubectl delete pvc -n demo --all
kubectl delete pv --all
