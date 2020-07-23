#! /bin/bash -eux

set -eux

## git リポジトリ上の root のパスを取得
root_dir=$(cd $(dirname $(readlink -f $0)) && cd .. && pwd)
cd ${root_dir}

apt install -y ./artifact/*.deb
apt show socat
which socat

socat -V

ldd $(which socat)
