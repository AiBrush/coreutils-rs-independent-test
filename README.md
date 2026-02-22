# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.9.0)

### Summary
- **Tools tracked:** 84 total
- **Compatibility:** 1054/1197 tests passed (88.1%)
- **Fastest speedup:** wc at 32.9x faster than GNU

### Full Tools Comparison

> Sizes are relative (f\* size ÷ reference size — lower is smaller).
> Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | Size f\* vs GNU | Size f\* vs uutils | Compat f\* vs GNU | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|-------------------:|------------------:|-------------------:|----------------------:|
| wc | 16.62x | 0.63x | 100% | **32.9x** | **17.8x** |
| cut | 16.50x | 0.48x | 100% | **5.5x** | **1.7x** |
| sha256sum | 131.36x | 2.17x | 100% | **1.0x** | **1.0x** |
| md5sum | 131.35x | 2.17x | 100% | **1.0x** | **1.3x** |
| b2sum | 11.63x | 0.27x | 100% | **1.3x** | **1.1x** |
| base64 | 14.48x | 0.43x | 100% | **5.8x** | **5.9x** |
| sort | 9.53x | 0.29x | 100% | **12.4x** | **12.7x** |
| tr | 14.97x | 0.52x | 100% | **6.1x** | **6.6x** |
| uniq | 23.57x | 0.68x | 100% | **10.5x** | **6.7x** |
| tac | 50.81x | 0.70x | 100% | **3.1x** | **1.7x** |
| head | 10.78x | 0.34x | 100% | **1.4x** | **1.0x** |
| tail | 7.77x | 0.27x | 100% | **1.4x** | **2.1x** |
| cat | 11.94x | 0.35x | 100% | **2.8x** | **1.4x** |
| rev | 30.81x | - | 100% | **21.2x** | - |
| expand | 13.06x | 0.35x | 100% | **10.1x** | **2.5x** |
| unexpand | 11.56x | 0.35x | 100% | **1.9x** | **2.4x** |
| fold | 12.98x | 0.35x | 100% | **4.4x** | **1.3x** |
| paste | 11.82x | 0.36x | 100% | **1.5x** | **12.1x** |
| nl | 47.97x | 0.67x | 100% | **4.7x** | **1.6x** |
| comm | 11.86x | 0.36x | 100% | **3.3x** | **3.1x** |
| join | 9.43x | 0.18x | 100% | **0.7x** | **0.8x** |
| basenc | 9.80x | - | 100% | **0.7x** | - |
| base32 | 11.56x | - | 100% | **0.8x** | - |
| ln | 8.30x | - | 100% | **0.9x** | - |
| touch | 4.84x | - | 95% | **0.9x** | - |
| truncate | 11.48x | - | 100% | **0.9x** | - |
| mkdir | 5.95x | - | 100% | **1.0x** | - |
| rmdir | 9.31x | - | 83% | **0.9x** | - |
| mknod | 10.24x | - | 100% | **1.0x** | - |
| mkfifo | 10.19x | - | 100% | **1.0x** | - |
| mktemp | 12.89x | - | 100% | - | - |
| seq | 9.72x | - | 100% | **14.7x** | - |
| shuf | 10.10x | - | 100% | - | - |
| tsort | 10.04x | - | 100% | - | - |
| tee | 11.54x | - | 100% | - | - |
| sum | 12.81x | - | 100% | **1.4x** | - |
| cksum | 4.32x | - | 100% | **0.7x** | - |
| sha1sum | 131.37x | - | 100% | **0.8x** | - |
| sha224sum | 131.37x | - | 100% | **0.8x** | - |
| sha384sum | 131.37x | - | 100% | **0.9x** | - |
| sha512sum | 131.37x | - | 100% | **0.9x** | - |
| id | 11.27x | - | 100% | **1.0x** | - |
| groups | 12.44x | - | 100% | **0.9x** | - |
| whoami | 12.34x | - | 100% | **0.9x** | - |
| logname | 12.34x | - | 100% | **0.8x** | - |
| uname | 12.45x | - | 100% | **0.9x** | - |
| uptime | 36.09x | - | 80% | - | - |
| arch | 12.34x | - | 100% | **0.8x** | - |
| hostid | 12.34x | - | 100% | **0.8x** | - |
| tty | 12.37x | - | 100% | **0.8x** | - |
| nproc | 12.90x | - | 100% | **0.8x** | - |
| pwd | 12.47x | - | 100% | - | - |
| env | 9.98x | - | 100% | **0.9x** | - |
| timeout | 12.49x | - | 90% | - | - |
| nice | 13.29x | - | 100% | **0.9x** | - |
| nohup | 13.27x | - | 100% | **0.9x** | - |
| sleep | 12.90x | - | 100% | **0.9x** | - |
| sync | 12.53x | - | 83% | **0.8x** | - |
| true | 11.25x | - | 100% | - | - |
| false | 11.27x | - | 100% | - | - |
| link | 12.51x | - | 100% | **0.9x** | - |
| unlink | 12.47x | - | 100% | **0.9x** | - |
| basename | 12.48x | - | 100% | **0.8x** | - |
| dirname | 12.43x | - | 100% | **0.8x** | - |
| pathchk | 12.68x | - | 100% | **0.8x** | - |
| realpath | 10.48x | - | 100% | **0.8x** | - |
| readlink | 10.37x | - | 100% | **0.8x** | - |
| dircolors | 9.70x | - | 86% | - | - |
| echo | 12.43x | - | 100% | **0.8x** | - |
| factor | 7.25x | - | 100% | **0.9x** | - |
| expr | 43.49x | - | 100% | **0.8x** | - |
| test | 9.51x | - | 100% | - | - |
| cp | 3.57x | - | 100% | **1.0x** | - |
| mv | 3.53x | - | - | **1.0x** | - |
| rm | 8.94x | - | 100% | **0.9x** | - |
| dd | 7.04x | - | 100% | **0.8x** | - |
| split | 9.58x | - | 100% | **0.8x** | - |
| csplit | 36.69x | - | - | **16.5x** | - |
| install | 3.60x | - | 100% | **1.0x** | - |
| shred | 8.37x | - | 100% | **1.1x** | - |
| chmod | 9.65x | - | 100% | **0.9x** | - |
| chown | 9.03x | - | 100% | **0.9x** | - |
| chgrp | 8.96x | - | 100% | **0.9x** | - |
| yes | 12.37x | - | 17% | **4.2x** | - |

### Known Issues
- 143 compatibility test failures across 5 platforms

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
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

## Platform Functional Tests (v0.9.0)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 417 | 19 | 0 | ⚠️ |
| Linux ARM64 | 417 | 19 | 0 | ⚠️ |
| macOS ARM64 | 220 | 105 | 0 | ⚠️ |
| Windows x86_64 | 0 | 0 | 0 | ✅ |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
