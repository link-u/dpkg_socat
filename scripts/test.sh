#! /bin/bash -eux

set -eux

## git リポジトリ上の root のパスを取得
scripts_dir=$(readlink -f $(cd $(dirname $(readlink -f $0)) && pwd))
root_dir=$(cd ${scripts_dir} && cd .. && pwd)
cd ${root_dir}

apt install -y ./artifact/*.deb
apt show socat
which socat

socat -V

ldd $(which socat)
