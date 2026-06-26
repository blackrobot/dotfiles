#!/usr/bin/env bash
# Claude Code status line — mirrors p10k Pure style
# Left:   user@host  ~/dir  branch*  |  Model (1M / xhigh)  42%
# Right:  output-style  FAST  5h 85%  cache→3:47p  [session]  (right-justified to $COLUMNS)

input=$(cat)

jq_get() { echo "$input" | jq -r "${1} // empty"; }
tcolor()  { tput setaf "$1" 2>/dev/null || true; }
tbold()   { tput bold    2>/dev/null || true; }
titalic() { tput sitm    2>/dev/null || true; }

grey=$(tcolor 242)
bold_blue=$(tbold)$(tcolor 75)
green=$(tcolor 76)
yellow=$(tcolor 220)
orange=$(tcolor 208)
red=$(tbold)$(tcolor 196)
cyan=$(tcolor 117)
magenta=$(tcolor 176)
italic=$(titalic)
reset=$(tput sgr0 2>/dev/null || true)

cwd=$(jq_get '.workspace.current_dir')
[[ -z "$cwd" ]] && cwd=$(jq_get '.cwd')
model_raw=$(jq_get '.model.display_name')
used_pct=$(jq_get '.context_window.used_percentage')
session_name=$(jq_get '.session_name')
effort=$(jq_get '.effort.level')
fast_mode=$(jq_get '.fast_mode')
output_style=$(jq_get '.output_style.name')
rate_5h=$(jq_get '.rate_limits.five_hour.used_percentage')
transcript_path=$(jq_get '.transcript_path')
vim_mode=$(jq_get '.vim.mode')

# Percentage → escalating color: grey → yellow → orange → red as it fills
pct_color() {
  local p="$1"
  if   (( p >= 90 )); then printf '%s' "$red"
  elif (( p >= 75 )); then printf '%s' "$orange"
  elif (( p >= 60 )); then printf '%s' "$yellow"
  else                     printf '%s' "$grey"
  fi
}

left=()
right=()
left_extra_cols=0   # extra display columns from double-width glyphs in `left` (the worktree emoji) that vis_len counts as 1

# user@host — only when SSH'd in or running as root
user=$(whoami)
host=$(hostname -s)
if [[ -n "$SSH_CLIENT" ]] || [[ "$user" == "root" ]]; then
  left+=("${grey}${user}@${host}${reset}")
fi

# Linked git worktree → show the main repo path (shorter, familiar) with a tree
# glyph, instead of the long worktree checkout path. A linked worktree's git dir
# is always <common>/.git/worktrees/<name>; the main worktree / a plain repo is not.
worktree_icon=""
display_root="$cwd"
git_dir=$(git -C "$cwd" --no-optional-locks rev-parse --absolute-git-dir 2>/dev/null)
if [[ "$git_dir" == */worktrees/* ]]; then
  # First `worktree list` entry is always the main worktree's path.
  main_root=$(git -C "$cwd" --no-optional-locks worktree list --porcelain 2>/dev/null \
              | awk '/^worktree /{print substr($0,10); exit}')
  # `--show-prefix` is the path from the worktree root down to cwd (empty at the
  # root, "bin/" in a subdir); git computes it symlink-agnostically, so it's robust
  # where string-matching cwd against --show-toplevel is not.
  sub=$(git -C "$cwd" --no-optional-locks rev-parse --show-prefix 2>/dev/null)
  sub="${sub%/}"
  if [[ -n "$main_root" ]]; then
    worktree_icon=$(printf '\360\237\214\263')           # deciduous tree emoji (U+1F333), 2 cols wide
    left_extra_cols=1
    # Re-root onto the main repo path, preserving any subdir within the worktree.
    if [[ -n "$sub" ]]; then
      display_root="$main_root/$sub"
    else
      display_root="$main_root"
    fi
  fi
fi

# Current directory (bold blue) — abbreviate $HOME as ~.
# Strip the home prefix explicitly: a literal ~ in a ${var/#x/~} replacement
# gets tilde-expanded back to $HOME under bash 5.x, which silently defeats the
# abbreviation and prints the full /Users/... path.
home_dir="${HOME:-$(eval echo ~"$(whoami)")}"
if [[ "$display_root" == "$home_dir" ]]; then
  cwd_display="~"
elif [[ "$display_root" == "$home_dir"/* ]]; then
  # shellcheck disable=SC2088  # literal ~ is intentional — this is display text, not a path
  cwd_display="~/${display_root#"$home_dir"/}"
else
  cwd_display="$display_root"
fi
[[ -n "$worktree_icon" ]] && cwd_display="${worktree_icon} ${cwd_display}"
left+=("${bold_blue}${cwd_display}${reset}")

# Git branch + dirty/ahead/behind indicators — skip optional locks
if git -C "$cwd" rev-parse --git-dir --no-optional-locks >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    dirty=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null | head -1)
    ahead=$(git -C "$cwd" --no-optional-locks rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
    behind=$(git -C "$cwd" --no-optional-locks rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
    suffix=""
    [[ -n "$dirty" ]]     && suffix+="*"
    [[ "$ahead"  -gt 0 ]] && suffix+="⇡"
    [[ "$behind" -gt 0 ]] && suffix+="⇣"
    # Magenta when clean, yellow when dirty/out-of-sync
    if [[ -z "$dirty" ]] && [[ "$ahead" -eq 0 ]] && [[ "$behind" -eq 0 ]]; then
      branch_color="$magenta"
    else
      branch_color="$yellow"
    fi
    left+=("${branch_color}${branch}${suffix}${reset}")
  fi
fi

# Separator before Claude-specific info
left+=("${grey}|${reset}")

# Model name — condense "(with 1M context)" → "(1M)", then append the effort level
model="$model_raw"
if [[ -n "$model" ]]; then
  model=$(echo "$model" | sed -E 's/\(with /(/g; s/ context\)/)/g')
  if [[ -n "$effort" ]]; then
    # Insert effort into the model's existing parens, else append fresh parens
    paren_re='\(([^)]+)\)$'
    if [[ "$model" =~ $paren_re ]]; then
      inner="${BASH_REMATCH[1]}"
      model="${model/%($inner)/($inner / $effort)}"
    else
      model="${model} (${effort})"
    fi
  fi
  left+=("${grey}${italic}${model}${reset}")
fi

# Context window usage % — escalates grey → yellow → orange → red so a full
# context (time to /compact) is visually obvious
if [[ -n "$used_pct" ]]; then
  printf -v used_rounded "%.0f" "$used_pct"
  left+=("$(pct_color "$used_rounded")${used_rounded}%${reset}")
fi

# ---- Right-justified status cluster ----
# NOTE: Claude Code does not expose the permission mode (auto / plan / accept-edits
# / bypass) to status line scripts, so it cannot be shown here. These are the
# closest mode-like signals that the status line JSON actually provides.
if [[ -n "$output_style" && "$output_style" != "default" ]]; then
  right+=("${cyan}${output_style}${reset}")
fi
if [[ "$fast_mode" == "true" ]]; then
  right+=("${magenta}FAST${reset}")
fi
if [[ -n "$rate_5h" ]]; then
  printf -v rate_rounded "%.0f" "$rate_5h"
  # Only surface the 5h rate-limit usage once it's high enough to matter
  (( rate_rounded >= 80 )) && right+=("$(pct_color "$rate_rounded")5h ${rate_rounded}%${reset}")
fi

# Prompt-cache TTL window — Anthropic's prompt cache stays warm for CACHE_TTL_SECONDS
# after the last turn. The status line only re-renders on conversation activity (not
# on an idle timer), so a ticking countdown would freeze; instead show the wall-clock
# time the cache expires (cache→3:47p), which you can compare to the real clock at a
# glance. Once a render lands past expiry, warn that the next turn pays full price.
CACHE_TTL_SECONDS=300
if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
  # Last timestamp in the transcript = last turn that warmed the cache. Scan only
  # the tail (bounded) and tolerate non-JSON lines via fromjson?.
  last_ts=$(tail -n 40 "$transcript_path" \
            | jq -rR 'fromjson? | select(.timestamp) | .timestamp' 2>/dev/null \
            | tail -1)
  if [[ -n "$last_ts" ]]; then
    # ISO8601 UTC like 2026-05-28T19:42:13.456Z → strip trailing Z and fractional secs
    clean=${last_ts%Z}; clean=${clean%.*}
    last_epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%S" "$clean" +%s 2>/dev/null || true)
    if [[ -n "$last_epoch" ]]; then
      now=$(date +%s)
      expiry=$(( last_epoch + CACHE_TTL_SECONDS ))
      if (( now >= expiry )); then
        right+=("${orange}⚠ uncached${reset}")
      else
        # Local wall-clock expiry, e.g. " 3:47PM" → "3:47p"
        clk=$(date -r "$expiry" "+%l:%M%p" 2>/dev/null | tr 'APM' 'apm')
        clk="${clk# }"; clk="${clk%m}"
        right+=("${grey}cache→${clk}${reset}")
      fi
    fi
  fi
fi

# Vim mode — single bold letter, color signals the mode:
#   N green  (NORMAL — command mode, intentional state)
#   I grey   (INSERT — default editing, no need to shout)
#   V yellow (VISUAL / VISUAL LINE — selection active)
if [[ -n "$vim_mode" ]]; then
  case "$vim_mode" in
    NORMAL)      vim_label="${green}$(tbold)N${reset}" ;;
    INSERT)      vim_label="${grey}I${reset}" ;;
    VISUAL)      vim_label="${yellow}V${reset}" ;;
    "VISUAL LINE") vim_label="${yellow}VL${reset}" ;;
    *)           vim_label="${grey}${vim_mode:0:1}${reset}" ;;
  esac
  right+=("$vim_label")
fi

if [[ -n "$session_name" ]]; then
  right+=("${grey}[${session_name}]${reset}")
fi

# Join parts with two spaces
join() {
  local out="" first=1 p
  for p in "$@"; do
    if (( first )); then out="$p"; first=0; else out+="  $p"; fi
  done
  printf '%s' "$out"
}

# Visible (printable) width — strip SGR color codes and the sgr0 charset reset
vis_len() {
  local s
  s=$(printf '%s' "$1" | sed -E $'s/\x1b\\[[0-9;]*m//g; s/\x1b\\(B//g')
  printf '%s' "${#s}"
}

left_str=$(join "${left[@]}")
right_str=$(join "${right[@]}")

if [[ -n "$right_str" ]]; then
  cols="${COLUMNS:-80}"
  pad=$(( cols - $(vis_len "$left_str") - left_extra_cols - $(vis_len "$right_str") ))
  (( pad < 1 )) && pad=1
  printf '%s%*s%s\n' "$left_str" "$pad" "" "$right_str"
else
  printf '%s\n' "$left_str"
fi
