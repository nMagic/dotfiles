SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
if [[ ! -f "$SCRIPTPATH/settings.json" ]]; then echo "{ }" > "$SCRIPTPATH/settings.json"; fi
jq -s -r '.[0] * .[1]' "$SCRIPTPATH/settings.json" "$SCRIPTPATH/base.json" > "$SCRIPTPATH/tmp.json" && cat "$SCRIPTPATH/tmp.json" > "$SCRIPTPATH/settings.json" && rm "$SCRIPTPATH/tmp.json"