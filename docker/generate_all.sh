#!/bin/bash

for os in $(ls -1 env/* | sed  's/env\///g'); do
  ./generate.sh $os 
done
