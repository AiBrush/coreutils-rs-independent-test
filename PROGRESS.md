# Implementation Progress

## Infrastructure
- [x] Directory structure created
- [x] `tests/common.sh` - Shared test framework (run_test, run_exit_code_test, run_stdout_test, skip_test, JSON recording, failure saving)
- [x] `tests/helpers/generate_test_data.sh` - Test data generation (empty, tiny, unicode, binary, CSV, sort, duplicates, 1KB-10MB+)
- [x] `tests/compatibility/run_all.sh` - Compatibility test runner (aggregates all tools, writes JSON)
- [x] `tests/benchmarks/bench_common.sh` - Shared benchmark framework (hyperfine wrapper, JSON output)
- [x] `tests/benchmarks/run_all.sh` - Benchmark runner (aggregates all tools)
- [x] `scripts/install_from_github.sh` - Install fcoreutils from GitHub releases (replaces cargo install)
- [x] `scripts/plot_speedup.py` - Generate performance-over-versions chart
- [x] `requirements.txt` - Python dependencies (matplotlib)
- [x] `results/` directory structure with `benchmarks/` and `compatibility/` subdirs

## Compatibility Test Scripts (10/10)
- [x] `tests/compatibility/test_wc.sh` - 55+ tests (empty, flags -c/-l/-w/-m/-L, combined, multi-file, unicode, locale, files0-from)
- [x] `tests/compatibility/test_cut.sh` - 45+ tests (byte/char/field, delimiter, complement, output-delimiter, -z, -s)
- [x] `tests/compatibility/test_sha256sum.sh` - 30+ tests (basic, vectors, check mode, tag, strict, warn, -z, large files)
- [x] `tests/compatibility/test_md5sum.sh` - 30+ tests (basic, vectors, check mode, tag, strict, warn, -z)
- [x] `tests/compatibility/test_b2sum.sh` - 25+ tests (basic, variable length -l, check mode, tag)
- [x] `tests/compatibility/test_base64.sh` - 25+ tests (encode, decode, roundtrip, -w wrap, -i garbage, edge cases)
- [x] `tests/compatibility/test_sort.sh` - 35+ tests (-n, -h, -V, -M, -r, -u, -f, -d, -k, -t, -s, -c, -m, -g, -R, -z, locale)
- [x] `tests/compatibility/test_tr.sh` - 35+ tests (translate, -d, -s, -c/-C, -t, all char classes, escapes, set mismatches)
- [x] `tests/compatibility/test_uniq.sh` - 35+ tests (-c, -d, -D, --all-repeated, -u, -i, -f, -s, -w, -z, --group)
- [x] `tests/compatibility/test_tac.sh` - 25+ tests (basic, -s separator, -b before, -r regex, line endings, large files)

## Benchmark Scripts (10/10)
- [x] `tests/benchmarks/bench_wc.sh` - Default, -l, -w, -c, -m, -L, binary, repetitive, multi-file
- [x] `tests/benchmarks/bench_cut.sh` - Byte range, char range, field extraction, complement, various sizes
- [x] `tests/benchmarks/bench_sha256sum.sh` - Single file various sizes, multiple files (parallel)
- [x] `tests/benchmarks/bench_md5sum.sh` - Single file various sizes, multiple files (parallel)
- [x] `tests/benchmarks/bench_b2sum.sh` - Various sizes, variable length, multiple files
- [x] `tests/benchmarks/bench_base64.sh` - Encode/decode various sizes, line wrapping
- [x] `tests/benchmarks/bench_sort.sh` - Lexicographic, numeric, sorted/reverse/random, unique, key, parallel
- [x] `tests/benchmarks/bench_tr.sh` - Translation, delete, squeeze, char classes, binary
- [x] `tests/benchmarks/bench_uniq.sh` - Default, count, duplicate/unique, case insensitive, repetitive
- [x] `tests/benchmarks/bench_tac.sh` - Various sizes, content types, custom separator

## Stress Tests
- [x] `tests/stress/stress_tests.sh` - Concurrent (100 parallel), rapid (1000 runs), long lines, millions of lines, mixed binary, adversarial, signal handling, slow stdin

## CI & Reporting (Updated)
- [x] `.github/workflows/ci.yml` - Unified workflow: discover versions, compatibility tests, per-version benchmarks, report generation
- [x] `scripts/generate_report.py` - Simplified README + per-version detail reports from `results/` directory
- [x] `scripts/plot_speedup.py` - Performance-over-versions chart (matplotlib)
- [x] Install from GitHub releases (no more cargo install / crates.io)
- [x] Versioned results: `results/benchmarks/v{X.Y.Z}/{platform}.json`
- [x] REPORT.md removed (README.md is the single report)
- [x] Benchmarks restricted to Linux only (macOS/Windows removed from bench matrix, kept in compatibility)
- [x] Scripts filter to `linux_*.json` so chart and README reflect Linux performance only

## uutils/coreutils Integration (3-way comparison)
- [x] `scripts/install_uutils.sh` — Clone and build uutils from source, export UUTILS_DIR
- [x] `tests/benchmarks/bench_common.sh` — Extended `run_benchmark()` and `run_stdin_benchmark()` with optional 4th uutils command arg
- [x] All 10 `bench_*.sh` scripts — Added uutils commands as 4th arg to every benchmark call
- [x] `tests/benchmarks/run_all.sh` — Auto-builds uutils before benchmarks, graceful fallback
- [x] `scripts/plot_speedup.py` — Orange uutils line on chart, handles missing data from old versions
- [x] `scripts/generate_report.py` — 3-column Performance Highlights table (f* vs GNU, f* vs uutils, uutils vs GNU), uutils columns in per-version reports, Sources section
- [x] `.github/workflows/ci.yml` — Build uutils once before benchmark version loop, cargo cache for uutils

## New Tools (80+ tools — v0.5.9+)
- [x] PR #1 merged — 406 compat tests + 75 benchmarks for: head, tail, cat, rev, expand, unexpand, fold, paste, nl, comm, join
- [x] Additional tools: basenc, base32, ln, touch, truncate, mkdir, rmdir, mknod, mkfifo, mktemp, seq, shuf, tsort, tee, sum, cksum, sha1sum, sha224sum, sha384sum, sha512sum, id, groups, whoami, logname, uname, uptime, arch, hostid, tty, nproc, pwd, env, timeout, nice, nohup, sleep, sync, true, false, link, unlink, basename, dirname, pathchk, realpath, readlink, dircolors, echo, factor, expr, test, cp, mv, rm, dd, split, csplit, install, shred, chmod, chown, chgrp, yes, and more

## Consolidation (Feb 2026)
- [x] `tests/compatibility/run_all.sh` — Merged: now runs ALL tools (absorbed run_all_new.sh)
- [x] `tests/benchmarks/run_all.sh` — Merged: now runs ALL tools (absorbed run_all_new.sh)
- [x] `run_all_new.sh` files removed (both benchmarks and compatibility)
- [x] `.github/workflows/new-tools.yml` — Merged into `ci.yml`, file removed
- [x] `.github/workflows/ci.yml` — Unified workflow with all jobs:
  - `test-new-tools`: builds from source, runs full compat suite (workflow_dispatch only)
  - `bench-new-tools`: builds from source + uutils, runs full bench suite (workflow_dispatch only)
  - `benchmarks` job: uses `run_all.sh` (all tools), includes binary size measurement
  - `report` job: downloads new-tools artifacts when available, merges into results/

## Full Table in README
- [x] `scripts/generate_report.py` — Generates 6-column table for all ~80 tools:
  - Size f* vs GNU (binary size ratio)
  - Size f* vs uutils (binary size ratio)
  - Compat f* vs GNU (test pass rate %)
  - Compat f* vs uutils (not yet collected, shows "-")
  - Speedup f* vs GNU (peak speedup)
  - Speedup f* vs uutils (peak speedup)
- [x] Binary size collection added to `benchmarks` CI job (saved in `{platform}_sizes.json`)
- [x] `generate_report.py` reads per-tool compat data from new `compatibility_results.json` format
- [x] `generate_report.py` supplements versioned data with new-tools artifacts for unreleased tools

## Speedup Chart
- [x] `scripts/plot_speedup.py` — Already aggregates all tools from benchmark JSONs (no change needed)
- [x] `benchmarks` CI job now uses `run_all.sh` (all tools) so future versioned results include all tools

## README Table Improvements + Full GNU Coverage + Upstream Tests (Feb 2026)
- [x] Task 1: ALL_TOOLS sorted alphabetically (107 tools), loaded from tests/gnu_tools.txt
- [x] Task 2: Size columns changed from ratios to raw KB/MB (3 columns: f*, GNU, uutils)
- [x] Task 3: Compat column has ✅/⚠️/❌ emoji
- [x] Task 4a: tests/gnu_tools.txt created (107 tools)
- [x] Task 4b: compatibility/run_all.sh and benchmarks/run_all.sh auto-discover test_*.sh/bench_*.sh
- [x] Task 4c: generate_report.py loads ALL_TOOLS from gnu_tools.txt at runtime
- [x] Task 4d: Stubs created: chcon, chroot, dir, kill, printenv, runcon, vdir
- [x] Task 5a: GNU coreutils upstream tests downloaded to tests/compatibility/gnu_upstream/tests/
- [x] Task 5b: tests/compatibility/gnu_upstream/init_shim.sh — adapts GNU init.sh API for f* binaries
- [x] Task 5e: Gap tests added to test_printf, test_date, test_od, test_numfmt, test_ls, test_du, test_split, test_wc, test_sort, test_cat

## GNU Upstream Tests Merged into Compatibility (Feb 2026)
- [x] `tests/common.sh` — Added `run_gnu_upstream_tests()` function:
  - Discovers GNU upstream test scripts per tool from `tests/compatibility/gnu_upstream/tests/<tool>/`
  - Also includes tool-specific misc tests from `tests/compatibility/gnu_upstream/tests/misc/<tool>.sh`
  - Creates symlink directory mapping `f*` binaries → bare tool names
  - Patches test scripts to use `init_shim.sh`, runs with 30s timeout
  - Records PASS/FAIL/SKIP results via existing `record_result()` framework
- [x] All 107 compatibility test scripts updated to call `run_gnu_upstream_tests` before `finish_test_suite`
- [x] ~609 GNU upstream test scripts now count toward per-tool compatibility percentages
- [x] No changes needed to `generate_report.py`, `run_all.sh`, or CI workflow — results flow automatically

## Status: COMPLETE
All tools have compatibility tests, benchmark scripts, and stress tests.
CI workflow discovers un-benchmarked versions, runs benchmarks, persists results, generates chart + README.
uutils/coreutils added as third competitor for 3-way performance comparison.
All tools tested via unified run_all.sh scripts; new-tools workflow merged into main CI.
GNU upstream tests integrated into compatibility tests — per-tool compat scores now include GNU's own test suite.
