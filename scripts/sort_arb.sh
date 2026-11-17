#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"

if [[ "${1:-}" == "--help" ]]; then
    printf 'Usage: %s [file.arb ...]\n' "$0"
    printf 'Sort ARB message keys alphabetically, keeping each @metadata entry beside its message.\n'
    printf 'With no files specified, sorts all files in lib/l10n/arb/.\n'
    exit 0
fi

if (($# == 0)); then
    shopt -s nullglob
    files=("$repo_root"/lib/l10n/arb/*.arb)
    shopt -u nullglob
    if ((${#files[@]} == 0)); then
        printf 'No ARB files found in %s\n' "$repo_root/lib/l10n/arb" >&2
        exit 1
    fi
    set -- "${files[@]}"
fi

python3 - "$@" <<'PY'
import json
import sys
from pathlib import Path


def sort_arb(path: Path) -> None:
    try:
        content = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise SystemExit(f"{path}: {error}") from error

    if not isinstance(content, dict):
        raise SystemExit(f"{path}: expected a top-level JSON object")

    locale = content.pop("@@locale", None)
    metadata_keys = [key for key in content if key.startswith("@")]
    for metadata_key in metadata_keys:
        message_key = metadata_key[1:]
        if not message_key or message_key not in content:
            raise SystemExit(
                f"{path}: metadata entry {metadata_key!r} has no matching message"
            )

    sorted_content = {}
    if locale is not None:
        sorted_content["@@locale"] = locale

    message_keys = sorted(key for key in content if not key.startswith("@"))
    for message_key in message_keys:
        sorted_content[message_key] = content[message_key]
        metadata_key = f"@{message_key}"
        if metadata_key in content:
            sorted_content[metadata_key] = content[metadata_key]

    path.write_text(
        json.dumps(sorted_content, ensure_ascii=False, indent=4) + "\n",
        encoding="utf-8",
    )


for filename in sys.argv[1:]:
    sort_arb(Path(filename))
PY
