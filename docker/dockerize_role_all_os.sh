#!/bin/bash
role=$1
for os in $(ls -1 env/* | sed  's/env\///g'); do
  ./dockerize_role.sh $role $os 
done
