#!/bin/bash

git clone http://dpdk.org/git/dpdk

touch tmp.md

cd dpdk

IFS=$'\n'

echo "<!--START_SECTION:dpdk-->" >> ../tmp.md
for OUT in $(git log --oneline --author conor.walsh@intel.com -n 10); do
        echo $OUT | cut -d' ' -f1 | { read id; echo "* [${OUT#* }](https://github.com/DPDK/dpdk/commit/$id)" >> ../tmp.md; }
done
echo "<!--END_SECTION:dpdk-->" >> ../tmp.md

cd ..

sed -e '/START_SECTION:dpdk/,/END_SECTION:dpdk/!b' -e '/END_SECTION:dpdk/!d;r tmp.md' -e 'd' README.md > README.md.tmp; mv README.md.tmp README.md

touch tmpgen.md
echo "<!--START_SECTION:gen-->" >> tmpgen.md
echo "_Generated: $(env TZ=Europe/Dublin date +%Y\-%m\-%d\ %l%P\ \I\S\T)_" >> tmpgen.md
echo "<!--END_SECTION:gen-->" >> tmpgen.md

sed -e '/START_SECTION:gen/,/END_SECTION:gen/!b' -e '/END_SECTION:gen/!d;r tmpgen.md' -e 'd' README.md > README.md.tmp; mv README.md.tmp README.md

rm -rf dpdk
rm tmp.md
rm tmpgen.md
