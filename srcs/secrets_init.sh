#!/bin/bash

secrets=("secret1" "secret2" "secret3" "secret4" "secret5")

mkdir -p secrets

for arg in "${secrets[@]}"; do
	[ -f "secrets/$arg" ] || touch "secrets/$arg"
done