#! /bin/bash

set -eux

## git リポジトリ上の root のパスを取得
root_dir=$(cd $(dirname $(readlink -f $0)) && cd .. && pwd)

## ビルド時に必要なパッケージのインストール
env --chdir="${root_dir}/socat" \
  mk-build-deps --install --remove \
  --tool='apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes' \
  debian/control

## deb ファイルのビルド
bash "${root_dir}/scripts/create_changelog.sh"
bash "${root_dir}/scripts/build.sh"
