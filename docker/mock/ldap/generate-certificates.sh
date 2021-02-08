#!/bin/bash

set -eux -o pipefail

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd -P)"

## Generate certificates in current dir

command -v >/dev/null || (
    echo "ERROR: mkcert is required"
    exit 1
)

mkcert -key-file "${CURRENT_DIR}/ldap.key" -cert-file "${CURRENT_DIR}/ldap.crt" \
  ldap.jenkins.io localhost jenkins 172.17.0.1 127.0.0.1 vpn.jenkins.io

cp "$(mkcert -CAROOT)/rootCA.pem" "${CURRENT_DIR}/ca.crt"
