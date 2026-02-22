# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.8.8)

### Summary
- **Tools tracked:** 84 total
- **Compatibility:** 1054/1197 tests passed (88.1%)
- **Fastest speedup:** wc at 31.0x faster than GNU

### Full Tools Comparison

> Sizes are relative (f\* size ÷ reference size — lower is smaller).
> Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | Size f\* vs GNU | Size f\* vs uutils | Compat f\* vs GNU | Compat f\* vs uutils | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|-------------------:|------------------:|---------------------:|-------------------:|----------------------:|
| wc | 16.62x | 0.63x | 100% | - | **31.0x** | **17.2x** |
| cut | 16.50x | 0.48x | 100% | - | **5.5x** | **1.9x** |
| sha256sum | 131.36x | 2.17x | 100% | - | **1.0x** | **3.8x** |
| md5sum | 131.35x | 2.17x | 100% | - | **1.4x** | **1.3x** |
| b2sum | 11.63x | 0.27x | 100% | - | **1.3x** | **1.2x** |
| base64 | 14.48x | 0.43x | 100% | - | **6.5x** | **5.7x** |
| sort | 9.53x | 0.29x | 100% | - | **17.6x** | **18.0x** |
| tr | 14.97x | 0.52x | 100% | - | **6.5x** | **6.9x** |
| uniq | 23.57x | 0.68x | 100% | - | **13.5x** | **6.5x** |
| tac | 50.81x | 0.70x | 100% | - | **3.9x** | **2.1x** |
| head | 10.78x | - | 100% | - | - | - |
| tail | 7.77x | - | 100% | - | - | - |
| cat | 11.94x | - | 100% | - | - | - |
| rev | 30.81x | - | 100% | - | - | - |
| expand | 13.06x | - | 100% | - | - | - |
| unexpand | 11.56x | - | 100% | - | - | - |
| fold | 12.98x | - | 100% | - | - | - |
| paste | 11.82x | - | 100% | - | - | - |
| nl | 47.97x | - | 100% | - | - | - |
| comm | 11.86x | - | 100% | - | - | - |
| join | 9.43x | - | 100% | - | - | - |
| basenc | 9.80x | - | 100% | - | - | - |
| base32 | 11.56x | - | 100% | - | - | - |
| ln | 8.30x | - | 100% | - | - | - |
| touch | 4.84x | - | 95% | - | - | - |
| truncate | 11.48x | - | 100% | - | - | - |
| mkdir | 5.95x | - | 100% | - | - | - |
| rmdir | 9.31x | - | 83% | - | - | - |
| mknod | 10.24x | - | 100% | - | - | - |
| mkfifo | 10.19x | - | 100% | - | - | - |
| mktemp | 12.89x | - | 100% | - | - | - |
| seq | 9.72x | - | 100% | - | - | - |
| shuf | 10.10x | - | 100% | - | - | - |
| tsort | 10.04x | - | 100% | - | - | - |
| tee | 11.54x | - | 100% | - | - | - |
| sum | 12.81x | - | 100% | - | - | - |
| cksum | 4.32x | - | 100% | - | - | - |
| sha1sum | 131.37x | - | 100% | - | - | - |
| sha224sum | 131.37x | - | 100% | - | - | - |
| sha384sum | 131.37x | - | 100% | - | - | - |
| sha512sum | 131.37x | - | 100% | - | - | - |
| id | 11.27x | - | 100% | - | - | - |
| groups | 12.44x | - | 100% | - | - | - |
| whoami | 12.34x | - | 100% | - | - | - |
| logname | 12.34x | - | 100% | - | - | - |
| uname | 12.45x | - | 100% | - | - | - |
| uptime | 36.09x | - | 80% | - | - | - |
| arch | 12.34x | - | 100% | - | - | - |
| hostid | 12.34x | - | 100% | - | - | - |
| tty | 12.37x | - | 100% | - | - | - |
| nproc | 12.90x | - | 100% | - | - | - |
| pwd | 12.47x | - | 100% | - | - | - |
| env | 9.98x | - | 100% | - | - | - |
| timeout | 12.49x | - | 90% | - | - | - |
| nice | 13.29x | - | 100% | - | - | - |
| nohup | 13.27x | - | 100% | - | - | - |
| sleep | 12.90x | - | 100% | - | - | - |
| sync | 12.53x | - | 83% | - | - | - |
| true | 11.25x | - | 100% | - | - | - |
| false | 11.27x | - | 100% | - | - | - |
| link | 12.51x | - | 100% | - | - | - |
| unlink | 12.47x | - | 100% | - | - | - |
| basename | 12.48x | - | 100% | - | - | - |
| dirname | 12.43x | - | 100% | - | - | - |
| pathchk | 12.68x | - | 100% | - | - | - |
| realpath | 10.48x | - | 100% | - | - | - |
| readlink | 10.37x | - | 100% | - | - | - |
| dircolors | 9.70x | - | 86% | - | - | - |
| echo | 12.43x | - | 100% | - | - | - |
| factor | 7.25x | - | 100% | - | - | - |
| expr | 43.49x | - | 100% | - | - | - |
| test | 9.51x | - | 100% | - | - | - |
| cp | 3.57x | - | 100% | - | - | - |
| mv | 3.53x | - | - | - | - | - |
| rm | 8.94x | - | 100% | - | - | - |
| dd | 7.04x | - | 100% | - | - | - |
| split | 9.58x | - | 100% | - | - | - |
| csplit | 36.69x | - | - | - | - | - |
| install | 3.60x | - | 100% | - | - | - |
| shred | 8.37x | - | 100% | - | - | - |
| chmod | 9.65x | - | 100% | - | - | - |
| chown | 9.03x | - | 100% | - | - | - |
| chgrp | 8.96x | - | 100% | - | - | - |
| yes | 12.37x | - | 17% | - | **4.2x** | - |

### Known Issues
- 143 compatibility test failures across 5 platforms

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/coreutils-rs) — installed from GitHub Releases
- [uutils/coreutils](https://github.com/uutils/coreutils) — built from source (latest main)
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Builds uutils/coreutils from source for comparison
- Runs 1197+ compatibility tests comparing output byte-for-byte against GNU coreutils
- Benchmarks using `hyperfine` with warmup runs and timed runs
- Measures binary sizes of f\*, GNU, and uutils for each tool
- Tests run across multiple platforms via GitHub Actions

## Running Locally
```bash
# Run benchmarks for the latest version (includes uutils build)
./scripts/install_from_github.sh
./tests/benchmarks/run_all.sh

# Run compatibility tests
./tests/compatibility/run_all.sh

# Generate the plot
pip install matplotlib
python3 scripts/plot_speedup.py
```

## Platform Functional Tests (v0.8.8)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 417 | 19 | 0 | ⚠️ |
| Linux ARM64 | 417 | 19 | 0 | ⚠️ |
| macOS ARM64 | 220 | 105 | 0 | ⚠️ |
| Windows x86_64 | 0 | 0 | 0 | ✅ |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
