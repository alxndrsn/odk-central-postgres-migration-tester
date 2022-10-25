#!/bin/bash -eu
set -o pipefail

intialVersion=1.5.3

testPrefix="$(basename "$0")"
log() {
  echo "[$testPrefix] $*"
}

log "Cleaning up test directory..."
rm -rf "$testDir" || true
mkdir "$testDir"

log "Creating test directory..."
cd "$testDir"

log "Cloning odk-central git repo..."
git clone git@github.com:getodk/central.git
cd central
git checkout "v$initialVersion"
git submodule inito

log "TODO Cleaning docker-compose..."

log "Starting $initialVersion..."
docker-compose up

confirm_postgres_version 9.6

log "TODO Seeding database..."

confirm_seed_data
confirm_postgres_version 9.6

log "TODO upgrading central..."
# see: https://docs.getodk.org/central-upgrade/

confirm_postgres_version 14
confirm_seed_data
confirm_postgres_version 14

log "Test passed OK!"
