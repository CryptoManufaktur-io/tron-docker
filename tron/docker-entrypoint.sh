#!/usr/bin/env bash
set -euo pipefail

__get_snapshot() {
  mkdir -p /tron/snapshot
  cd /tron/snapshot

  # Download files
  aria2c -o file.tgz -c -x6 -s6 --auto-file-renaming=false --conditional-get=true --allow-overwrite=true "${SNAPSHOT}"
  aria2c -o file.md5sum "${SNAPSHOT_HASH}"

  # check hash
  file_checksum=$(md5sum file.tgz | awk '{print $1}' | tr '[:upper:]' '[:lower:]')
  expected_checksum=$(awk '{print $1}' file.md5sum | tr '[:upper:]' '[:lower:]')

  # Check if the file was downloaded successfully
  if [[ "${file_checksum}" == "${expected_checksum}" ]]; then
    tar -xvzf file.tgz -C /tron

    # clean up
    cd /
    rm -rf /tron/snapshot
    echo "Done setting up snapshot"
  else
    echo "Error: snapshot hash did not match."
    exit 1
  fi
}

# Prep output-dir
if [ -n "${SNAPSHOT}" ] && [ ! -d "/tron/output-directory" ]; then
  __get_snapshot
else
    mkdir -p /tron/output-directory
  echo "No snapshot fetch necessary"
fi

exec java -Xmx24g -XX:+UseConcMarkSweepGC -Dlogback.configurationFile=file:/log-stdout.xml -jar /FullNode.jar -c /main_net_config.conf -d /tron/output-directory
