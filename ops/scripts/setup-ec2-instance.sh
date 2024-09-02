#!/bin/bash

read -p "Enter IP address to deploy: " IP

ansible-playbook -e "HOST=$IP ansible_user=ec2-user" ops/ansible/setup-ec2-instance.yml --become-user "ec2-user"