#!/usr/bin/env python3
"""Bump a Homebrew formula's release tag and sha256 checksums in place.

Driven by the release `repository_dispatch` payload. For the named formula this
rewrites every per-platform GitHub release download URL to the new tag and
replaces each following `sha256` line with the matching value from the release's
`checksums-sha256.txt`. The bespoke `install`/`test` blocks are left untouched,
so a single generic receiver serves every formula in the tap.

Usage:
    update_formula.py <formula-file> <repo> <tag>

`repo` is the source repository in `owner/name` form; `tag` is the release tag
(for example `v0.3.0`). Exits non-zero if a required checksum is missing so a
broken release never produces a half-updated formula.
"""

from __future__ import annotations

import re
import sys
import urllib.request

# `url "https://github.com/<owner>/<repo>/releases/download/<tag>/<file>"`
URL_RE = re.compile(
    r'^(?P<prefix>\s*url ")'
    r"(?P<base>https://github\.com/[^\"]+/releases/download/)"
    r"(?P<tag>[^/]+)/"
    r"(?P<file>[^\"]+)"
    r'(?P<suffix>".*)$'
)
SHA_RE = re.compile(r'^(?P<prefix>\s*sha256 ")(?P<digest>[0-9a-f]{64})(?P<suffix>".*)$')


def fetch_checksums(repo: str, tag: str) -> dict[str, str]:
    """Return a mapping of release archive filename to its sha256 digest."""
    url = f"https://github.com/{repo}/releases/download/{tag}/checksums-sha256.txt"
    with urllib.request.urlopen(url) as resp:  # noqa: S310 - fixed https host
        text = resp.read().decode()
    sums: dict[str, str] = {}
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        digest, name = line.split()
        sums[name] = digest
    return sums


def bump(text: str, new_tag: str, sums: dict[str, str]) -> str:
    """Rewrite download URLs to `new_tag` and refresh each paired sha256."""
    lines = text.splitlines(keepends=True)
    pending_file: str | None = None
    for i, line in enumerate(lines):
        url_match = URL_RE.match(line)
        if url_match:
            old_tag = url_match.group("tag")
            newline = line[len(line.rstrip("\r\n")) :]
            new_file = url_match.group("file").replace(old_tag, new_tag)
            lines[i] = (
                f'{url_match.group("prefix")}{url_match.group("base")}'
                f'{new_tag}/{new_file}{url_match.group("suffix").rstrip()}{newline}'
            )
            pending_file = new_file
            continue
        sha_match = SHA_RE.match(line)
        if sha_match and pending_file is not None:
            if pending_file not in sums:
                raise SystemExit(
                    f"no checksum for {pending_file} in the release checksums file"
                )
            newline = line[len(line.rstrip("\r\n")) :]
            lines[i] = (
                f'{sha_match.group("prefix")}{sums[pending_file]}'
                f'{sha_match.group("suffix").rstrip()}{newline}'
            )
            pending_file = None
    return "".join(lines)


def main(argv: list[str]) -> int:
    if len(argv) != 4:
        print(__doc__, file=sys.stderr)
        return 2
    formula_file, repo, tag = argv[1], argv[2], argv[3]
    sums = fetch_checksums(repo, tag)
    with open(formula_file, encoding="utf-8") as fh:
        original = fh.read()
    updated = bump(original, new_tag=tag, sums=sums)
    if updated == original:
        print(f"{formula_file} already at {tag}; nothing to do")
        return 0
    with open(formula_file, "w", encoding="utf-8") as fh:
        fh.write(updated)
    print(f"bumped {formula_file} to {tag}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
