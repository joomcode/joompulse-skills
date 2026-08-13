#!/usr/bin/env bash
# Checks the plugin manifests stay consistent with each other, the repository,
# and the changelog. Version drift and stale repository URLs are the two things
# that most often break a plugin submission.
set -euo pipefail

repo="joomcode/joompulse-skills"
repo_url="https://github.com/${repo}"
fail=0

note() {
  echo "FAIL: $*" >&2
  fail=1
}

for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json; do
  python3 -c "import json,sys; json.load(open('$f'))" \
    || note "$f is not valid JSON"
done

read -r plugin_name plugin_version plugin_home plugin_repo <<<"$(python3 -c "
import json
d = json.load(open('.claude-plugin/plugin.json'))
print(d.get('name'), d.get('version'), d.get('homepage'), d.get('repository'))
")"

read -r entry_name entry_version entry_home entry_repo <<<"$(python3 -c "
import json
d = json.load(open('.claude-plugin/marketplace.json'))['plugins'][0]
print(d.get('name'), d.get('version'), d.get('homepage'), d.get('repository'))
")"

[ "$plugin_name" = "$entry_name" ] \
  || note "name differs: plugin.json '$plugin_name' vs marketplace entry '$entry_name'"
[ "$plugin_version" = "$entry_version" ] \
  || note "version differs: plugin.json '$plugin_version' vs marketplace entry '$entry_version'"

for url in "$plugin_home" "$plugin_repo" "$entry_home" "$entry_repo"; do
  [ "$url" = "$repo_url" ] || note "URL '$url' does not match $repo_url"
done

changelog_version=$(grep -m1 -oE '^## [0-9]+\.[0-9]+\.[0-9]+' CHANGELOG.md | awk '{print $2}')
[ "$plugin_version" = "$changelog_version" ] \
  || note "version differs: plugin.json '$plugin_version' vs newest CHANGELOG entry '$changelog_version'"

# The plugin name is a permanent identifier: renaming it breaks existing installs.
# CHANGELOG.md is exempt because it records the rename itself.
grep -rIn --exclude-dir=.git --exclude="$(basename "$0")" --exclude=CHANGELOG.md \
  'joomcode/pulse-skills' . \
  && note "found references to the old joomcode/pulse-skills path"

python3 - "$plugin_name" <<'PY' || fail=1
import glob, os, re, sys

plugin_name = sys.argv[1]
ok = True
for path in sorted(glob.glob("skills/*/SKILL.md")):
    directory = os.path.basename(os.path.dirname(path))
    text = open(path).read()
    match = re.match(r"^---\n(.*?)\n---", text, re.S)
    if not match:
        print(f"FAIL: {path} has no YAML frontmatter", file=sys.stderr)
        ok = False
        continue
    front = match.group(1)

    name = re.search(r"^name:\s*(.+)$", front, re.M)
    if not name:
        print(f"FAIL: {path} has no name", file=sys.stderr)
        ok = False
    elif name.group(1).strip().strip("\"'") != directory:
        print(f"FAIL: {path} name does not match its directory", file=sys.stderr)
        ok = False

    desc = re.search(r"^description:\s*(.*?)(?=^\w[\w-]*:|\Z)", front, re.S | re.M)
    if not desc:
        print(f"FAIL: {path} has no description", file=sys.stderr)
        ok = False
    else:
        collapsed = " ".join(desc.group(1).split()).strip("\"'")
        if len(collapsed) > 1024:
            print(
                f"FAIL: {path} description is {len(collapsed)} chars (limit 1024)",
                file=sys.stderr,
            )
            ok = False

sys.exit(0 if ok else 1)
PY

if [ "$fail" -ne 0 ]; then
  echo "Manifest check failed." >&2
  exit 1
fi

echo "Manifest check passed (plugin ${plugin_name} ${plugin_version})."
