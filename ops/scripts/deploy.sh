#!/bin/bash

REPO_ROOT=$(git rev-parse --show-toplevel)

source $REPO_ROOT/.env

read -p "Enter IP address to deploy: " IP

ansible-playbook -e "HOST=$IP ansible_user=$REMOTE_USER" $REPO_ROOT/ops/ansible/run-web-app.yml --become-user "$REMOTE_USER"