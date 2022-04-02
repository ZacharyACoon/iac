#!/bin/bash
ANSIBLE_VERSION=stable-2.12

DVS="$(pwd)/volumes"

docker build ./ansible-docker --build-arg GIT_REF=${ANSIBLE_VERSION} --tag iac-ansible:${ANSIBLE_VERSION} --tag iac-ansible:latest
exec docker run --rm -it \
  -v "${DVS}/etc/ansible:/etc/ansible" \
  -v "${DVS}/root/.ssh:/root/.ssh" \
  -v "$(dirname ${SSH_AUTH_SOCK})":/ssh_auth_sock \
  -v "${DVS}/ansible:/ansible" \
  -e SSH_AUTH_SOCK=/ssh_auth_sock/S.gpg-agent.ssh \
  iac-ansible \
  /bin/bash
