#!/usr/bin/env bash
set -Eeuo pipefail
umask 022

# Install a copy outside the releases; the SSH key can invoke only this command.
base="${ISP_DEPLOY_ROOT:-$HOME/apps/sbm-seg-isp}"
export PHP_VERSION=8.3
php=/usr/bin/php
repo=https://github.com/m-attr/SBM-SEG-ISP.git
url=https://seg-sbm-isp.alwaysdata.net
if [[ $# == 1 ]]; then
    sha=$1
elif [[ ${SSH_ORIGINAL_COMMAND:-} =~ ^deploy\ ([0-9a-f]{40})$ ]]; then
    sha=${BASH_REMATCH[1]}
else
    echo "Only 'deploy <40-character commit SHA>' is allowed." >&2
    exit 2
fi
[[ $sha =~ ^[0-9a-f]{40}$ ]] || { echo "Invalid commit SHA." >&2; exit 2; }
[[ -x $php && -r $base/shared/local.php ]] || { echo "Server setup is incomplete." >&2; exit 1; }
mkdir -p "$base/releases"
exec 9>"$base/deploy.lock"
flock -w 120 9
if [[ ! -d $base/repository.git ]]; then
    git init --bare "$base/repository.git"
    git --git-dir="$base/repository.git" remote add origin "$repo"
fi
git --git-dir="$base/repository.git" fetch --no-tags origin +refs/heads/main:refs/heads/main
git --git-dir="$base/repository.git" cat-file -e "$sha^{commit}"
git --git-dir="$base/repository.git" merge-base --is-ancestor "$sha" refs/heads/main ||
    { echo "Commit is not on main." >&2; exit 1; }

pending=$(mktemp -d "$base/releases/.pending-$sha-XXXXXX")
previous=$(readlink "$base/current" || true)
activated=0
cleanup() {
    status=$?
    trap - EXIT
    if [[ $status != 0 && $activated == 1 && -n $previous ]]; then
        ln -s "$previous" "$base/.rollback-$$"
        mv -Tf "$base/.rollback-$$" "$base/current"
        echo "Deployment failed; previous release restored." >&2
    fi
    [[ ! -d $pending ]] || rm -rf -- "$pending"
    exit "$status"
}
trap cleanup EXIT
git --git-dir="$base/repository.git" archive "$sha" | tar -x -C "$pending"
[[ ! -e $pending/config/local.php ]] || { echo "Private configuration was committed unexpectedly." >&2; exit 1; }
ln -s "$base/shared/local.php" "$pending/config/local.php"
find "$pending" -type f -name '*.php' -print0 | xargs -0 -r -n 1 "$php" -l
"$php" "$pending/scripts/check-db.php"
printf "<?php header('Content-Type: text/plain'); echo '%s';\n" "$sha" > "$pending/public/deployment-version.php"
# Retain prior releases for recovery; every deployment gets an immutable directory.
release="$base/releases/$sha-$(date -u +%Y%m%d%H%M%S)-$$"
mv "$pending" "$release"
ln -s "$release" "$base/.next-$$"
mv -Tf "$base/.next-$$" "$base/current"
activated=1
if [[ ${ISP_SKIP_HTTP_CHECK:-0} != 1 ]]; then
    actual=$(curl --fail --silent --show-error --retry 5 --retry-delay 2 "$url/deployment-version.php?commit=$sha")
    [[ $actual == "$sha" ]] || { echo "Hosted version check failed." >&2; exit 1; }
    curl --fail --silent --show-error --output /dev/null "$url/"
fi
echo "Deployed $sha"
