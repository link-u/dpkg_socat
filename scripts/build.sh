#! /bin/bash

set -eux

## git リポジトリ上の root のパスを取得
scripts_dir=$(cd $(dirname $(readlink -f $0)) && cd .. && pwd)

## socat のソースディレクトリ名の取得
src_dir=$(basename "$(ls -1vd ${root_dir}/socat/socat-*.tar.gz | tail -n 1)" .tar.gz);

## debian package のビルド
env --chdir "${root_dir}/socat"   cp -r debian -t "${src_dir}";
echo "${root_dir}/socat/${src_dir}"
env --chdir "${root_dir}/socat/${src_dir}" fakeroot debian/rules clean -j"$(nproc)"
env --chdir "${root_dir}/socat/${src_dir}" fakeroot debian/rules build -j"$(nproc)"
env --chdir "${root_dir}/socat/${src_dir}" fakeroot debian/rules binary -j"$(nproc)"
