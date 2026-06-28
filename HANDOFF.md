# Handoff

This document records the current status and next steps for continuing Tiger input method integration work on another machine.

## Repositories

- Official Tiger table source: <https://github.com/lvyww/tiger-code>
- Candidate upstream for Fcitx5 integration: <https://github.com/fcitx/fcitx5-table-extra>

## Current Status

The `tiger-code` repository has been initialized and pushed.

Latest local commit at handoff:

```text
f73b44c Add Fcitx5 tiger table source
```

Current repository structure:

```text
LICENSE
README.md
HANDOFF.md
scripts/
  build-fcitx5.sh
tables/
  tiger.conf.in
  tiger.txt
```

Only the words + characters variant is included. The single-character variant is intentionally left out to keep the first upstream proposal simple.

## License

The repository uses CC0-1.0 for Tiger table data.

Important policy:

- Table data is intended to be easy for open-source and commercial input method platforms to integrate.
- The name "虎码" / "Tiger" and related branding are not automatically licensed as trademarks.

## Source Files

The current files were copied from the existing local workspace:

```text
/home/yc/Nutstore/tiger_develop/tiger_files/publish/fcitx5/fcitx5_字词.txt
  -> tables/tiger.txt

/home/yc/Nutstore/tiger_develop/fcitx/fcitx5/inputmethod/tiger.conf
  -> tables/tiger.conf.in
```

`tables/tiger.txt` already contains the Fcitx5/libime table header:

```text
KeyCode=abcdefghijklmnopqrstuvwxyz
Length=4
Pinyin=@
[Rule]
...
[Data]
...
```

Do not prepend `head.txt` again when preparing upstream data.

## Local Build Check

Required tool:

```bash
libime_tabledict
```

Run:

```bash
./scripts/build-fcitx5.sh
```

Expected result:

```text
OK: /tmp/.../tiger.main.dict
```

This verifies that `tables/tiger.txt` can be compiled by Fcitx5/libime.

## Git Setup On A New Machine

Clone:

```bash
git clone git@github.com:lvyww/tiger-code.git
cd tiger-code
```

If SSH is not configured:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub
```

Add the public key to GitHub:

```text
GitHub -> Settings -> SSH and GPG keys -> New SSH key
```

Test:

```bash
ssh -T git@github.com
```

Expected result:

```text
Hi lvyww! You've successfully authenticated...
```

## Suggested Fcitx5 Upstream Issue

Open an issue in <https://github.com/fcitx/fcitx5-table-extra/issues>.

Suggested title:

```text
Add Tiger table input method
```

Suggested body:

```text
I am the author of Tiger input method (虎码).

I would like to contribute Tiger table data to fcitx5-table-extra.

Official source repository:
https://github.com/lvyww/tiger-code

License:
The table data is released under CC0-1.0.

This repository currently provides one Fcitx5 table variant:
- tiger: words + characters

Would this project be open to accepting Tiger as an extra table?
```

Wait for maintainer feedback before opening a large PR.

## Expected PR Shape For fcitx5-table-extra

If maintainers agree, the PR will likely need changes similar to:

```text
tables/tiger.txt
tables/tiger.conf.in
tables/CMakeLists.txt
```

In `tables/CMakeLists.txt`, add `tiger` to `TABLE_NAME`.

Check existing tables in `fcitx5-table-extra/tables/` for style and naming.

## APK Integration Workspace

There is also a local APK integration workspace:

```text
/home/yc/Nutstore/tiger_develop/fcitx
```

Important files there:

```text
go.sh
org.apk
android.keystore
fcitx5/
```

The optimized `go.sh` does the following:

1. Extracts `assets/` from `org.apk` into a temporary directory.
2. Overlays local Tiger Fcitx5 files from `fcitx5/`.
3. Builds `tiger.main.dict`.
4. Regenerates `assets/descriptor.json` with matching SHA256 values.
5. Repackages, zipaligns, signs, and verifies two APKs.

This script is for local APK packaging only. It is separate from the upstream `tiger-code` repository.

## Next Recommended Steps

1. Confirm `tiger-code` still builds:

   ```bash
   ./scripts/build-fcitx5.sh
   ```

2. Open the upstream issue in `fcitx5-table-extra`.
3. Wait for maintainer feedback on license, naming, and whether Tiger should be added.
4. If accepted, create a branch and prepare the PR against `fcitx5-table-extra`.
