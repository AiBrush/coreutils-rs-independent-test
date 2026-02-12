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

## Status: COMPLETE
All 10 tools have compatibility tests, benchmark scripts, and stress tests.
CI workflow discovers un-benchmarked versions, runs benchmarks, persists results, generates chart + README.
