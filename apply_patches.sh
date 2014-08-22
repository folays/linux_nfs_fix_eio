#!/bin/sh

cd "$(dirname $0)"

files=patches/*.patch

for file in $files; do
  patch -d linux-source/ -p1 < "$file"
done
