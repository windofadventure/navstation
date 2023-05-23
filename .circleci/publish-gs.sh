#!/usr/bin/env bash

echo "Publishing"

set -x

EXT=$1
REPO=$2
DISTRO=$3

pwd
ls

### Make sure you set:
### GOOGLE_COMPUTE_REGION
### GCLOUD_SERVICE_KEY
### GOOGLE_PROJECT_ID

### for PackageFiles in cross-build-release/release/*/*.img ###
for pkg_file in cross-build-release/release/*/*."$EXT"; do
  zipName=$(basename "$pkg_file")
  zipDir=$(dirname "$pkg_file")
  mkdir ./tmp
  chmod 755 ./tmp
  cd "$zipDir" || exit 255
  xz -z -c -v -7 --threads=5 "${zipName}" > ../../../tmp/"${zipName}".xz
  cd ../../..
  #cloudsmith push raw "$REPO" ./tmp/"${zipName}".xz --summary "BBN OS built by CircleCi on $(date)" --description "BBN OS build"
  gsutil ${GSTORAGE}
  RESULT=$?
  if [ $RESULT -eq 144 ]; then
    echo "skipping already deployed $pkg_file"
  fi
done
