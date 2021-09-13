#!/bin/bash

PREF=ek8s
ARCH_DIRS=(wget)
#ARCH_DIRS="registry/ "
for source in ${ARCH_DIRS[@]}; do
  pushd /var/lib/import
  rm -Rf ../export/$PREF-rancher.tar*
  tar -cf - $source | split --bytes=10240m --suffix-length=3 --numeric-suffix - ../export/$PREF-rancher.tar.
  pushd /var/lib/export
  for part in $(find ./ -name "ek8s-rancher.tar.*" | grep -v sha25); do
    sha256sum $part > $part.sha256sum
  done
done
#sha256sum $PREF.tar* > sha256.list

