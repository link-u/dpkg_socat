#! /bin/bash

set -eux

## git リポジトリ上の root のパスを取得
root_dir=$(cd $(dirname $(readlink -f $0)) && cd .. && pwd)

## socat のソースディレクトリ名の取得と展開
src_filename=$(ls -1vd ${root_dir}/socat/socat-*.tar.gz | tail -n 1)
src_dir=$(basename "${src_filename}" .tar.gz);
env --chdir="${root_dir}/socat" tar xvf ${src_filename}

## debian package のビルド
env --chdir "${root_dir}/socat"   cp -r debian -t "${src_dir}";
echo "${root_dir}/socat/${src_dir}"
env --chdir "${root_dir}/socat/${src_dir}" fakeroot debian/rules clean -j"$(nproc)"
env --chdir "${root_dir}/socat/${src_dir}" fakeroot debian/rules build -j"$(nproc)"
env --chdir "${root_dir}/socat/${src_dir}" fakeroot debian/rules binary -j"$(nproc)"
