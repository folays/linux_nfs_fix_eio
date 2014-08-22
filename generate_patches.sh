#!/bin/sh

cd "$(dirname $0)"

files="$(diff -ru linux-source.orig/ linux-source/ | grep "^diff .*\.[ch]$" | grep -v "\.mod.c$" | awk '{print $3}' | cut -d/ -f2-)"

for file in $files; do
  file_=$(echo "$file" | tr / _)
  diff -u linux-source.orig/"$file" linux-source/"$file" > patches/"$file_".patch
done;
