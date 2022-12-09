#!/bin/bash
dart_files=$(git diff --cached --name-only --diff-filter=ACM | grep '.dart$')

[ -z "$dart_files" ] && exit 0

function checkFmt() {
  unformatted=$(dartfmt -n $dart_files)
  [ -z "$unformatted" ] && return 0

  echo >&2 "Dart files must be formatted with dartfmt. Please run:"
  for fn in $unformatted; do
    echo >&2 "  dartfmt -w $PWD/$fn"
  done

  return 1
}

checkFmt || fail=yes

[ -z "$fail" ] || exit 1

echo 'all okay?'

exit 0
