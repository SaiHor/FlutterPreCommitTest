#!/bin/bash

# This pre-commit hook run dartfmt on your code. If the code is not
# well-formatted, it will format it automatically, and then abort the commit
# (so you can review the changes). Make sure you changed "/path/to/dartfmt". On
# Windows, you can use an absolute path to your path.exe formatted as POSIX. For
# instance: "/d/Developer/Dart/dart-sdk/bin/dartfmt.bat" (note that the driver
# name is in lower case, and that the back-slashes are replaced with slashes).

# PUT MANUALLY YOUR ALIAS HERE

if [[ ! $(command -v "dartfmt" > /dev/null 2>&1) ]]; then
	print_error() {
		echo -e "Couldn't find 'dartfmt' in your system. Please edit '.git/hooks/pre-commit' to manually add:\n"
		echo -e "alias dartfmt='path/to/dartfmt'\n"
		echo "This line can be added at the line 10 of the file."
		echo "If you are using a WSL, you might need to add before your path with 'cmd.exe /c '."
		exit 1
	}

	DARTFMT=''

	# Search in WSL v1
	if [ -f "/d/Developer/Dart/dart-sdk/bin/dartfmt.bat" ]; then
		DARTFMT="/d/Developer/Dart/dart-sdk/bin/dartfmt.bat"
	elif [ -f "/d/Developer/flutter/bin/cache/dart-sdk/bin/dartfmt.bat" ]; then
		DARTFMT="/d/Developer/flutter/bin/cache/dart-sdk/bin/dartfmt.bat"
	# Search in WSL v2
	elif [ -f "/mnt/d/Developer/Dart/dart-sdk/bin/dartfmt.bat" ]; then
		DARTFMT="/mnt/d/Developer/Dart/dart-sdk/bin/dartfmt.bat"
	elif [ -f "/mnt/d/Developer/flutter/bin/cache/dart-sdk/bin/dartfmt.bat" ]; then
		DARTFMT="/mnt/d/Developer/flutter/bin/cache/dart-sdk/bin/dartfmt.bat"
	else
		print_error
	fi

	echo "Found darfmt: $DARTFMT"

	if [[ ! $(command -v "$DARTFMT" > /dev/null 2>&1) || ! $($DARTFMT --help > /dev/null 2>&1) ]]; then
		if cmd.exe /c ${DARTFMT/\/d/D:} --help > /dev/null 2>&1; then
			DARTFMT="cmd.exe /c ${DARTFMT/\/d/D:}"
		elif cmd.exe /c ${DARTFMT/\/mnt\/d/D:} --help > /dev/null 2>&1; then
			echo "dartfmt requires the cmd.exe envionment. Alias: cmd.exe /c ${DARTFMT/\/mnt\/d/D:}"
			DARTFMT="cmd.exe /c ${DARTFMT/\/mnt\/d/D:}"
			type $DARTFMT
		else
			print_error
		fi
	fi
fi

$DARTFMT -n --set-exit-if-changed .
exit_code=$?
echo "dartfmt exit code: $exit_code"

if [[ $exit_code != 0 ]]; then
	# If it does, fix them, show a warning, and quit (don't commit)
	echo "dartfmt detected lint errors."
	echo "Fixing errors."
	$DARTFMT -w .
	echo "Errors fixed. Please commit again."
	exit $exit_code
else
	echo "No lint error detected."
fi

exit 0