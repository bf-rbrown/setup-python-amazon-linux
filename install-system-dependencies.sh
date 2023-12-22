#!/usr/bin/env bash

set -euo pipefail

# Reference https://stackoverflow.com/a/73208851/3316017

desired_openssl_package="openssl-devel"

IDLIKE=$(cat /etc/os-release | grep ID_LIKE | awk -F '=' '{print $2}')
if [[ ${IDLIKE} == "debian" ]]; then
  sudo apt-get update -y

else
  sudo yum update -y

  if yum info "openssl11-devel" &>/dev/null; then
    desired_openssl_package="openssl11-devel"
  fi

  sudo yum groupinstall -y "Development Tools"
  sudo yum install -y "${desired_openssl_package}" zlib-devel bzip2 bzip2-devel readline-devel libffi-devel \
    ncurses-devel sqlite sqlite-devel gdbm-devel tk-devel xz-devel \
    tar gzip wget
fi