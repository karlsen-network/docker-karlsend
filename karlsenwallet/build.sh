#!/bin/sh

REPO_URL_STABLE=https://github.com/karlsen-network/karlsend

VERSION=$1
KASPAD_VERSION=$(echo $VERSION | grep -oP ".*(?=_.+)")
PUSH=$2
REPO_URL=${3:-$REPO_URL_STABLE}

set -e

if [ -z "$VERSION" -o -z "$KASPAD_VERSION" ]; then
  echo "Usage ${0} <karlsend-version_buildnr> [push] [karlsend_repo_url]"
  echo "Example: ${0} v0.12.13_1"
  exit 1
fi

docker build --pull --build-arg KASPAD_VERSION=${KASPAD_VERSION} --build-arg REPO_URL=${REPO_URL} -t karlsennetwork/karlsenwallet:${VERSION} $(dirname $0)
docker tag karlsennetwork/karlsenwallet:${VERSION} karlsennetwork/karlsenwallet:latest

if [ "$PUSH" = "push" ]; then
  docker push karlsennetwork/karlsenwallet:${VERSION}
  if [ "$REPO_URL" = "$REPO_URL_STABLE" ]; then
    docker push karlsennetwork/karlsenwallet:latest    
  fi
fi

