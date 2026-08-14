#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 RELEASE_TAG" >&2
  exit 2
fi

release_tag=$1

if [[ ! $release_tag =~ ^[0-9]+\.[0-9]+$ ]]; then
  echo "Release tag must be a stable X.Y version, got $release_tag" >&2
  exit 1
fi

version=$(tr -d '\r\n' < VERSION)
module_version=$(perl -MExtUtils::MakeMaker -e 'print MM->parse_version("lib/ClarID/Tools.pm")')

if [[ ${GITHUB_ACTIONS:-false} == true ]]; then
  git fetch --force origin "refs/tags/$release_tag:refs/tags/$release_tag"
fi

if [[ $(git cat-file -t "refs/tags/$release_tag" 2>/dev/null || true) != tag ]]; then
  echo "Release tag $release_tag must be annotated" >&2
  exit 1
fi

if [[ $(git rev-parse "refs/tags/${release_tag}^{commit}") != $(git rev-parse HEAD) ]]; then
  echo "Checked-out commit does not match release tag $release_tag" >&2
  exit 1
fi

if [[ $release_tag != "$version" ]]; then
  echo "Release tag $release_tag does not match VERSION $version" >&2
  exit 1
fi

if [[ $module_version != "$version" ]]; then
  echo "ClarID::Tools version $module_version does not match VERSION $version" >&2
  exit 1
fi

if ! perl -e '
  my $version = shift @ARGV;
  while (<>) {
    exit 0 if /^\Q$version\E \d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z /;
  }
  exit 1;
' "$version" Changes; then
  echo "Changes has no dated entry for $version" >&2
  exit 1
fi

if [[ -n ${GITHUB_OUTPUT:-} ]]; then
  {
    echo "version=$version"
    echo "revision=$(git rev-parse HEAD)"
  } >> "$GITHUB_OUTPUT"
fi

printf 'Verified release %s at %s\n' "$version" "$(git rev-parse --short HEAD)"
