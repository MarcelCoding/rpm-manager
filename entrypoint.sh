#!/bin/sh

REPO="/repo"
POOL="/pool"

echo "%_gpg_name ${GPG_NAME}" > ~/.rpmmacros

rm -rf "${REPO}/all/x86_64/pool"
mkdir -p "${REPO}/all/x86_64/pool"
find ${POOL} -iname "*.rpm" -type f -exec bash -c "mkdir -p \`dirname ${REPO}/all/x86_64{}\` && cp {} ${REPO}/all/x86_64{}" \;

find ./repo -iname "*.rpm" -type f -exec rpm --addsign {} \;

cd "${REPO}"

if test -f "${REPO}/all/x86_64/repodata"; then
  createrepo -d "${REPO}/all/x86_64"
else
  createrepo -d --update "${REPO}/all/x86_64"
fi