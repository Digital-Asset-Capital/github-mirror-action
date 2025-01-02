#! /bin/sh -l

REMOTE="${1}"

if [ -z "${REMOTE}" ]; then
  echo Please specify an origin
  exit 1
fi

git config --global --add safe.directory /github/workspace
git clone --bare "https://${GITHUB_ACTOR}:${TARGET_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" . || exit 1
git remote add --mirror=fetch mirror "https://${GITHUB_ACTOR}:${SOURCE_GITHUB_TOKEN}@github.com/${REMOTE}.git" || exit 1
git fetch mirror +refs/heads/*:refs/remotes/origin/* || exit 1
git push --force --mirror --prune origin || exit 1
