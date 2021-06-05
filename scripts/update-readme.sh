#!/bin/bash

git clone http://dpdk.org/git/dpdk

echo "### Conor Walsh

- 👷‍♂️ Software Engineer
- 🏢 Working for Intel's Network Platforms Group
- 💻 Working on [DPDK](https://dpdk.org/)
- 🌱 Learning more about C, Rust, networking and the cloud

#### 🔨 My Latest DPDK Commits
" > README.md

cd dpdk

IFS=$'\n'

for OUT in $(git log --oneline --author conor.walsh@intel.com -n 10); do
        echo $OUT | cut -d' ' -f1 | { read id; echo "* [${OUT#* }](https://github.com/DPDK/dpdk/commit/$id)" >> ../README.md; }
done

cd ..

echo "" >> README.md
echo "_Generated: $(date +%Y\-%m\-%d\ %H\:%m)_" >> README.md

rm -rf dpdk
