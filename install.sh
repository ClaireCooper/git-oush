#!/usr/bin/env bash

set -e

SELF_ROOT="${0%/*}"
PREFIX="${1%/}"

if [[ -z "$PREFIX" ]]; then
  printf '%s\n' \
    "usage: $0 <installation location>" \
    "  e.g. $0 /usr/local" >&2
  exit 1
fi

install -d -m 755 "$PREFIX"/{bin,share/misc/git-oush}

install -m 755 "$SELF_ROOT/bin"/* "$PREFIX/bin"
install -m 755 "$SELF_ROOT/share/misc/git-oush"/* "$PREFIX/share/misc/git-oush"

echo "Installed git oush to $PREFIX/bin/git-oush"