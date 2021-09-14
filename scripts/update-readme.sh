#!/bin/bash

git clone http://dpdk.org/git/dpdk

touch tmp.md

cd dpdk

IFS=$'\n'

for OUT in $(git log --oneline --author conor.walsh@intel.com -n 10); do
        echo $OUT | cut -d' ' -f1 | { read id; echo "* [${OUT#* }](https://github.com/DPDK/dpdk/commit/$id)" >> ../tmp.md; }
done

cd ..

awk -v data="$(<tmp.md)" '/START_SECTION:dpdk/ {f=1} /END_SECTION:dpdk/ && f {print data; f=0}1' README.md > README.md.tmp; mv README.md.tmp README.md

touch tmpgen.md
echo "_Generated: $(env TZ=Europe/Dublin date +%Y\-%m\-%d\ %l%P\ \I\S\T)_" > tmpgen.md

awk -v data="$(<tmpgen.md)" '/START_SECTION:gen/ {f=1} /END_SECTION:gen/ && f {print data; f=0}1' README.md > README.md.tmp; mv README.md.tmp README.md

rm -rf dpdk
rm tmp.md
rm tmpgen.md
rm README.md.tmp
