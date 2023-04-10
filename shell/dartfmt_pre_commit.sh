DARTFMT_OUTPUT=`dartfmt -w . | grep Formatted`

if [ -n "$DARTFMT_OUTPUT" ]; then
  echo $DARTFMT_OUTPUT
  echo "Re-attempt commit."
  exit 1
else
  echo "All Dart files formatted correctly. Yay!"
  exit 0

fi