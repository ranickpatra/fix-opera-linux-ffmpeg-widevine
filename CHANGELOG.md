# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- version-aware ffmpeg selection: detect Opera's bundled Chromium version and download the matching nwjs-ffmpeg release instead of always using the latest
- per-variant Chromium detection via binary inspection (`get_chromium_major`)
- ffmpeg download caching: skip re-download when multiple Opera variants share the same Chromium version

### Changed

- universal shebang bash interpreter to safely find bash on `$PATH`
- Widevine CDM is now downloaded once before the main loop instead of redundantly per variant
- release data is fetched once upfront (`?per_page=50`) and reused for version matching

### Removed


### Fixed

- in the preflight check: Prefer our user-friendly error messages while avoiding double error message from the operating system by redirecting also `stderr` to `/dev/null`
- potential runtime error: prefer `command -v` over `which`-command, which can have different behaviour on different Linux distributions and always use the first result in `PATH` independently of multiple defined commands
- `grep` error when `CDM_FLAG` starts with `--` by adding explicit end-of-options separator (`grep -qF -- "$CDM_FLAG"`)
