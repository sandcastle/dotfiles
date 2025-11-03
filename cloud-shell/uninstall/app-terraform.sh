#!/usr/bin/env bash

# Terraform
# https://developer.hashicorp.com/terraform/install
echo "Uninstalling Terraform..."

sudo apt remove -y terraform
rm -rf ~/.terraform.d
