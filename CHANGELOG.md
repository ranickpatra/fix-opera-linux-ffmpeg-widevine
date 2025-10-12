# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

- universal shebang bash interpreter to safely find bash on `$PATH`

### Removed


### Fixed

- in the preflight check: Prefer our user-friendly error messages while avoiding double error message from the operating system by redirecting also `stderr` to `/dev/null`
- potential runtime error: prefer `command -v` over `which`-command, which can have different behaviour on different Linux distributions and always use the first result in `PATH` independently of multiple defined commands
