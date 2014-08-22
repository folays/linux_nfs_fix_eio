#!/bin/sh
set -e

fix_dir="$(dirname $0)"
linux_headers_version="linux-headers-"$(uname -r)
linux_source_version="linux-source-"$(uname -r | cut -d- -f1)

if ! dpkg -s $linux_headers_version > /dev/null; then
  apt-get install $linux_headers_version
fi

if ! dpkg -s $linux_source_version > /dev/null; then
  apt-get install $linux_source_version
fi

if ! test -e "$fix_dir/$linux_source_version/fs/nfs"; then
  tar -vjxf /usr/src/$linux_source_version.tar.bz2 -C "$fix_dir/" $linux_source_version/fs/nfs/
  cp -a "$fix_dir/$linux_source_version/" "$fix_dir/$linux_source_version.orig/"
fi

if ! test -e "$fix_dir/linux-source"; then
  ln -s $linux_source_version "$fix_dir/linux-source"
fi

if ! test -e "$fix_dir/linux-source.orig"; then
  ln -s $linux_source_version.orig "$fix_dir/linux-source.orig"
fi
