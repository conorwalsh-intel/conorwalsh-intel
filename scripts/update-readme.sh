#!/bin/bash

git clone http://dpdk.org/git/dpdk

cat scripts/template.md > README.md

cd dpdk

IFS=$'\n'

for OUT in $(git log --oneline --author conor.walsh@intel.com -n 10); do
        echo $OUT | cut -d' ' -f1 | { read id; echo "* [${OUT#* }](https://github.com/DPDK/dpdk/commit/$id)" >> ../README.md; }
done

cd ..

echo "" >> README.md
echo "_Generated: $(env TZ=Europe/Dublin date +%Y\-%m\-%d\ %H\ %r\ \I\S\T)_" >> README.md

rm -rf dpdk
