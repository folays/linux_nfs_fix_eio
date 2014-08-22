#!/bin/sh
set -e

fix_dir="$(dirname $0)"
fix_dir_absolute="$(readlink -f "$fix_dir")"
linux_version=$(uname -r)

make -C /lib/modules/$linux_version/build M="$fix_dir_absolute/linux-source/fs/nfs" nfsv3.ko

if ! test -e "$fix_dir/nfsv3.ko"; then
  ln -s linux-source/fs/nfs/nfsv3.ko "$fix_dir/nfsv3.ko"
fi
