#!/bin/bash

SALT="tnbctvavpeowpenvrxatdnjvotamqbkq"

arrNodes=(
  "node1,10.0.3.101"
  "node2,10.0.3.102"
  "node3,10.0.3.103"
)

if [ ! -d ./nodes.d ]; then
  mkdir ./nodes.d
fi

for n in arrNodes; do
  HASH=$(echo "${n},${SALT}" | sha256sum | cut -f1 -d' ')
  touch ./nodes.d/${HASH}
done
