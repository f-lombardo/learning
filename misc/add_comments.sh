#!/usr/bin/env bash

# Generate with e.g.:
#   yarn tsc --pretty false -p tsconfig.json --noEmit > tsc-strict.log
# (NB: note '--pretty false' as colored output will break parsing)
TSC_LOG_FILE=tsc-strict.log

COMMENT='// @ts-expect-error TODO: fix this'

RE='([^\s].*\.ts)\(([0-9]+),([0-9]+)\)'

# Maps a filename to the number of inserted lines
declare -A INSERTIONS_BY_FILENAME

OLDIFS="${IFS}"

IFS=$'\n'
for ERR in $(ggrep -P -o "^${RE}" ${TSC_LOG_FILE}); do
  PARTS=$(echo ${ERR} | sed -r "s/${RE}/\1 \2 \3/")

  IFS=" "
  set ${PARTS}
  FILENAME=$1
  LINE=$(( $2 + INSERTIONS_BY_FILENAME[${FILENAME}] ))
  COL=$3

  IFS="${OLDIFS}"

  gsed -i'' -e "${LINE}i/${COMMENT}/" "${FILENAME}"

  # need to increment per-file counter of insertions so that next changes to same file have correct updated line number
  INSERTIONS_BY_FILENAME[${FILENAME}]=$(( INSERTIONS_BY_FILENAME[${FILENAME}] + 1 ))
done

# cleanup

IFS="${OLDIFS}"


yarn run eslint -c .eslintrc.json --fix --quiet src