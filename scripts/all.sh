#! /bin/bash

set -eux

## git リポジトリ上の root のパスを取得
scripts_dir=$(cd $(dirname $(readlink -f $0)) && pwd)

## ビルド時に必要なパッケージのインストール
env --chdir="${scripts_dir}/../socat" \
  mk-build-deps --install --remove \
  --tool='apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes' \
  debian/control

## deb ファイルのビルド
bash "${scripts_dir}/create_changelog.sh"
bash "${scripts_dir}/build.sh"
