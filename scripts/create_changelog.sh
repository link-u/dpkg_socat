#! /bin/bash

set -eu

## git リポジトリ上の root のパスを取得
scripts_dir=$(cd $(dirname $(readlink -f $0)) && cd .. && pwd)

## HEAD のコミットID と HEAD の時のタグを取得
git_commit="$(git rev-parse HEAD)"
git_ref="$(git tag --points-at ${git_commit})"

## ディストリビューションのコードネームの取得
code_name="$(lsb_release -cs)"

## changelog の作成
cp "${root_dir}/scripts/changelog_template" "${root_dir}/socat/debian/changelog"
env --chdir "${root_dir}/socat/debian" sed -i -r "s/%DATE%/$(LC_ALL=C TZ=JST-9 date '+%a, %d %b %Y %H:%M:%S %z')/g" changelog
if [ "${git_ref:0:1}" = "v" ]; then
  env --chdir "${root_dir}/socat/debian" sed -i -r "s/X.Y.Z-alpha/${git_ref:1}.$(TZ=JST-9 date +%Y%m%d)+${code_name}/g" changelog
else
  ## socat のソースディレクトリ名の取得 (バージョン名の取得のため)
  src_dir=$(basename "$(ls -1vd ${root_dir}/socat/socat-*.tar.gz | tail -n 1)" .tar.gz);
  env --chdir "${root_dir}/socat/debian" sed -i -r "s/X.Y.Z-alpha/${src_dir:6}-$(TZ=JST-9 date +%Y%m%d.%H%M%S).${git_commit:0:7}+${code_name}/g" changelog
fi
