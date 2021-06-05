#!/bin/bash

git clone http://dpdk.org/git/dpdk

echo "### Conor Walsh

- 👷‍♂️ Software Engineer
- 🏢 Working for the Intel Network Platforms Group
- 💻 Working on DPDK
- 🌱 Learning more about C, Rust, networking and the cloud

#### 🔨 My Latest DPDK Commits
" > README.md

cd dpdk

IFS=$'\n'

for OUT in $(git log --oneline --author conor.walsh@intel.com -n 10); do
        echo $OUT | cut -d' ' -f1 | { read id; echo "* [${OUT#* }](https://github.com/DPDK/dpdk/commit/$id)" >> ../README.md; }
done
