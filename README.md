# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.8.8)

### Summary
- **Tools tracked:** 84 total
- **Compatibility:** 1054/1197 tests passed (88.1%)
- **Fastest speedup:** wc at 31.6x faster than GNU

### Full Tools Comparison

> Sizes are relative (f\* size ÷ reference size — lower is smaller).
> Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | Size f\* vs GNU | Size f\* vs uutils | Compat f\* vs GNU | Compat f\* vs uutils | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|-------------------:|------------------:|---------------------:|-------------------:|----------------------:|
| wc | 16.62x | 0.63x | 100% | - | **31.6x** | **17.1x** |
| cut | 16.50x | 0.48x | 100% | - | **5.4x** | **1.9x** |
| sha256sum | 131.36x | 2.17x | 100% | - | **1.0x** | **3.8x** |
| md5sum | 131.35x | 2.17x | 100% | - | **1.4x** | **1.3x** |
| b2sum | 11.63x | 0.27x | 100% | - | **1.3x** | **1.2x** |
| base64 | 14.48x | 0.43x | 100% | - | **6.5x** | **5.7x** |
| sort | 9.53x | 0.29x | 100% | - | **17.6x** | **18.0x** |
| tr | 14.97x | 0.52x | 100% | - | **6.3x** | **6.0x** |
| uniq | 23.57x | 0.68x | 100% | - | **13.5x** | **6.6x** |
| tac | 50.81x | 0.70x | 100% | - | **3.9x** | **2.1x** |
| head | 10.78x | - | - | - | - | - |
| tail | 7.77x | - | - | - | - | - |
| cat | 11.94x | - | - | - | - | - |
| rev | 30.81x | - | - | - | - | - |
| expand | 13.06x | - | - | - | - | - |
| unexpand | 11.56x | - | - | - | - | - |
| fold | 12.98x | - | - | - | - | - |
| paste | 11.82x | - | - | - | - | - |
| nl | 47.97x | - | - | - | - | - |
| comm | 11.86x | - | - | - | - | - |
| join | 9.43x | - | - | - | - | - |
| basenc | 9.80x | - | - | - | - | - |
| base32 | 11.56x | - | - | - | - | - |
| ln | 8.30x | - | - | - | - | - |
| touch | 4.84x | - | - | - | - | - |
| truncate | 11.48x | - | - | - | - | - |
| mkdir | 5.95x | - | - | - | - | - |
| rmdir | 9.31x | - | - | - | - | - |
| mknod | 10.24x | - | - | - | - | - |
| mkfifo | 10.19x | - | - | - | - | - |
| mktemp | 12.89x | - | - | - | - | - |
| seq | 9.72x | - | - | - | - | - |
| shuf | 10.10x | - | - | - | - | - |
| tsort | 10.04x | - | - | - | - | - |
| tee | 11.54x | - | - | - | - | - |
| sum | 12.81x | - | - | - | - | - |
| cksum | 4.32x | - | - | - | - | - |
| sha1sum | 131.37x | - | - | - | - | - |
| sha224sum | 131.37x | - | - | - | - | - |
| sha384sum | 131.37x | - | - | - | - | - |
| sha512sum | 131.37x | - | - | - | - | - |
| id | 11.27x | - | - | - | - | - |
| groups | 12.44x | - | - | - | - | - |
| whoami | 12.34x | - | - | - | - | - |
| logname | 12.34x | - | - | - | - | - |
| uname | 12.45x | - | - | - | - | - |
| uptime | 36.09x | - | - | - | - | - |
| arch | 12.34x | - | - | - | - | - |
| hostid | 12.34x | - | - | - | - | - |
| tty | 12.37x | - | - | - | - | - |
| nproc | 12.90x | - | - | - | - | - |
| pwd | 12.47x | - | - | - | - | - |
| env | 9.98x | - | - | - | - | - |
| timeout | 12.49x | - | - | - | - | - |
| nice | 13.29x | - | - | - | - | - |
| nohup | 13.27x | - | - | - | - | - |
| sleep | 12.90x | - | - | - | - | - |
| sync | 12.53x | - | - | - | - | - |
| true | 11.25x | - | - | - | - | - |
| false | 11.27x | - | - | - | - | - |
| link | 12.51x | - | - | - | - | - |
| unlink | 12.47x | - | - | - | - | - |
| basename | 12.48x | - | - | - | - | - |
| dirname | 12.43x | - | - | - | - | - |
| pathchk | 12.68x | - | - | - | - | - |
| realpath | 10.48x | - | - | - | - | - |
| readlink | 10.37x | - | - | - | - | - |
| dircolors | 9.70x | - | - | - | - | - |
| echo | 12.43x | - | - | - | - | - |
| factor | 7.25x | - | - | - | - | - |
| expr | 43.49x | - | - | - | - | - |
| test | 9.51x | - | - | - | - | - |
| cp | 3.57x | - | - | - | - | - |
| mv | 3.53x | - | - | - | - | - |
| rm | 8.94x | - | - | - | - | - |
| dd | 7.04x | - | - | - | - | - |
| split | 9.58x | - | - | - | - | - |
| csplit | 36.69x | - | - | - | - | - |
| install | 3.60x | - | - | - | - | - |
| shred | 8.37x | - | - | - | - | - |
| chmod | 9.65x | - | - | - | - | - |
| chown | 9.03x | - | - | - | - | - |
| chgrp | 8.96x | - | - | - | - | - |
| yes | 12.37x | - | 17% | - | **3.9x** | - |

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
