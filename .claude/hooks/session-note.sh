#!/usr/bin/env bash
# SessionStart dashboard for tyrealq.github.io.
#
# Summarizes the site's work streams: recent activity, content inventory,
# future-dated items, drafts, and deploy status. Everything is computed
# from the folder and git history at run time, so nothing here goes stale.

set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." 2>/dev/null && pwd)"
[ -n "$REPO" ] && cd "$REPO" 2>/dev/null || exit 0

NL=$'\n'
dash="tyrealq.github.io dashboard  ·  $(date '+%a %b %-d, %Y')${NL}"

# --- where you left off ------------------------------------------------------
recent=$(git log -3 --format='  %ad  %s' --date=format:'%b %-d' 2>/dev/null \
  | sed -E 's/^(  [A-Za-z]+ [0-9]+  )(docs|chore|feat|fix|refactor|test|perf|ci): /\1/')
if [ -n "$recent" ]; then
  last_epoch=$(git log -1 --format=%ct 2>/dev/null)
  days=$(( ( $(date +%s) - ${last_epoch:-0} ) / 86400 ))
  dash+="${NL}Where you left off  ($days days ago)${NL}${recent}${NL}"
fi

# --- deploy status ------------------------------------------------------------
dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
unpushed=$(git rev-list --count '@{u}..HEAD' 2>/dev/null || echo 0)
if [ "$dirty" -gt 0 ] || [ "$unpushed" -gt 0 ]; then
  line=""
  [ "$dirty" -gt 0 ] && line="$dirty uncommitted change(s)"
  if [ "$unpushed" -gt 0 ]; then
    [ -n "$line" ] && line+=", "
    line+="$unpushed unpushed commit(s)"
  fi
  dash+="${NL}Deploy  ($line)${NL}"
fi

# --- content ------------------------------------------------------------------
today=$(date '+%Y-%m-%d')
content=""
tmpfuture=$(mktemp)

for col in _publications _talks _portfolio; do
  [ -d "$col" ] || continue
  count=$(find "$col" -name '*.md' | wc -l | tr -d ' ')
  label=$(printf '%s' "$col" | sed 's/^_//')

  latest=""
  if [ "$col" != "_portfolio" ]; then
    latest=$(find "$col" -name '*.md' -exec awk '
      { gsub(/\r/, "") }
      /^---$/ && NR==1 { fm=1; next }
      fm && /^---$/ { exit }
      fm && /^date:/ {
        sub(/^date: */, ""); sub(/ *$/, "")
        gsub(/"/, "")
        d = $0
        if (d !~ /^[0-9]{4}-/) {
          split("January 01 February 02 March 03 April 04 May 05 June 06 July 07 August 08 September 09 October 10 November 11 December 12", m, " ")
          for (i = 1; i < length(m); i += 2) mon[m[i]] = m[i+1]
          n = split(d, parts, " ")
          if (n >= 2 && parts[1] in mon) d = parts[n] "-" mon[parts[1]] "-01"
        }
        print d
        exit
      }
    ' {} \; 2>/dev/null | sort -r | head -1)
  fi

  if [ -n "$latest" ]; then
    content+="  $label  $count items  (latest $latest)${NL}"
  else
    content+="  $label  $count items${NL}"
  fi

  if [ "$col" != "_portfolio" ]; then
    find "$col" -name '*.md' -exec awk -v today="$today" '
      { gsub(/\r/, "") }
      /^---$/ && NR==1 { fm=1; next }
      fm && /^---$/ { exit }
      fm && /^date:/ {
        sub(/^date: */, ""); sub(/ *$/, "")
        gsub(/"/, "")
        d = $0
        if (d !~ /^[0-9]{4}-/) {
          split("January 01 February 02 March 03 April 04 May 05 June 06 July 07 August 08 September 09 October 10 November 11 December 12", m, " ")
          for (i = 1; i < length(m); i += 2) mon[m[i]] = m[i+1]
          n = split(d, parts, " ")
          if (n >= 2 && parts[1] in mon) d = parts[n] "-" mon[parts[1]] "-01"
        }
        if (d > today) print "  " FILENAME "  (" d ")"
        exit
      }
    ' {} \; 2>/dev/null >> "$tmpfuture"
  fi
done

dash+="${NL}Content${NL}${content}"

if [ -s "$tmpfuture" ]; then
  fut=$(cat "$tmpfuture")
  futcount=$(printf '%s\n' "$fut" | wc -l | tr -d ' ')
  dash+="${NL}Future-dated  ($futcount items, not rendered until date arrives)${NL}${fut}${NL}"
fi
rm -f "$tmpfuture"

# --- drafts -------------------------------------------------------------------
if [ -d _drafts ]; then
  draftcount=$(find _drafts -name '*.md' | wc -l | tr -d ' ')
  if [ "$draftcount" -gt 0 ]; then
    drafts=$(find _drafts -name '*.md' -exec basename {} .md \; | sort | sed 's/^/  /')
    dash+="${NL}Drafts  ($draftcount)${NL}${drafts}${NL}"
  fi
fi

# --- skills -------------------------------------------------------------------
skills=$(find .claude/skills -name SKILL.md 2>/dev/null | sort | while IFS= read -r f; do
  name=$(awk 'NR==1 && $0=="---"{i=1;next} i && $0=="---"{exit} i && index($0,"name: ")==1{sub(/^name: */,"");print;exit}' "$f")
  desc=$(awk 'NR==1 && $0=="---"{i=1;next} i && $0=="---"{exit} i && index($0,"description: ")==1{sub(/^description: */,"");print;exit}' "$f" | sed 's/\. .*/./')
  [ "${#desc}" -gt 62 ] && desc="${desc:0:62}..."
  printf '  /%-10s %s\n' "${name:-$(basename "$(dirname "$f")")}" "$desc"
done)
[ -n "$skills" ] && dash+="${NL}Skills${NL}${skills}${NL}"

jq -n --arg d "$dash" '{
  systemMessage: $d,
  suppressOutput: true,
  hookSpecificOutput: { hookEventName: "SessionStart", additionalContext: $d }
}'
