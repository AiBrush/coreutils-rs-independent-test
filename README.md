# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.9.8)

### Summary
- **Tools tracked:** 107 total
- **Compatibility:** 874/880 tests passed (99.3%)
- **Fastest speedup:** wc at 31.6x faster than GNU

### Full Tools Comparison

> Sizes are raw binary sizes. Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | fcoreutils size | GNU size | uutils size | Compat f\* vs GNU | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|----------:|----------:|------------------:|-------------------:|----------------------:|
| arch | - | - | - | - | - | - |
| b2sum | 633.9 KB | 54.5 KB | 2.3 MB | ✅ 100% | **1.3x** | **1.2x** |
| base32 | - | - | - | - | - | - |
| base64 | 558.2 KB | 38.5 KB | 1.3 MB | ⚠️ 97% | **5.8x** | **5.8x** |
| basename | - | - | - | - | - | - |
| basenc | - | - | - | - | - | - |
| cat | - | - | - | - | - | - |
| chcon | - | - | - | - | - | - |
| chgrp | - | - | - | - | - | - |
| chmod | - | - | - | - | - | - |
| chown | - | - | - | - | - | - |
| chroot | - | - | - | - | - | - |
| cksum | - | - | - | - | - | - |
| comm | - | - | - | - | - | - |
| cp | - | - | - | - | - | - |
| csplit | - | - | - | - | - | - |
| cut | 635.1 KB | 38.5 KB | 1.3 MB | ✅ 100% | **5.4x** | **1.7x** |
| date | - | - | - | - | - | - |
| dd | - | - | - | - | - | - |
| df | - | - | - | - | - | - |
| dir | - | - | - | - | - | - |
| dircolors | - | - | - | - | - | - |
| dirname | - | - | - | - | - | - |
| du | - | - | - | - | - | - |
| echo | - | - | - | - | - | - |
| env | - | - | - | - | - | - |
| expand | - | - | - | - | - | - |
| expr | - | - | - | - | - | - |
| factor | - | - | - | - | - | - |
| false | - | - | - | - | - | - |
| fmt | - | - | - | - | - | - |
| fold | - | - | - | - | - | - |
| groups | - | - | - | - | - | - |
| head | - | - | - | - | - | - |
| hostid | - | - | - | - | - | - |
| id | - | - | - | - | - | - |
| install | - | - | - | - | - | - |
| join | - | - | - | - | - | - |
| kill | - | - | - | - | - | - |
| link | - | - | - | - | - | - |
| ln | - | - | - | - | - | - |
| logname | - | - | - | - | - | - |
| ls | - | - | - | - | - | - |
| md5sum | 657.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.3x** |
| mkdir | - | - | - | - | - | - |
| mkfifo | - | - | - | - | - | - |
| mknod | - | - | - | - | - | - |
| mktemp | - | - | - | - | - | - |
| mv | - | - | - | - | - | - |
| nice | - | - | - | - | - | - |
| nl | - | - | - | - | - | - |
| nohup | - | - | - | - | - | - |
| nproc | - | - | - | - | - | - |
| numfmt | - | - | - | - | - | - |
| od | - | - | - | - | - | - |
| paste | - | - | - | - | - | - |
| pathchk | - | - | - | - | - | - |
| pinky | - | - | - | - | - | - |
| pr | - | - | - | - | - | - |
| printenv | - | - | - | - | - | - |
| printf | - | - | - | - | - | - |
| ptx | - | - | - | - | - | - |
| pwd | - | - | - | - | - | - |
| readlink | - | - | - | - | - | - |
| realpath | - | - | - | - | - | - |
| rev | - | - | - | - | - | - |
| rm | - | - | - | - | - | - |
| rmdir | - | - | - | - | - | - |
| runcon | - | - | - | - | - | - |
| seq | - | - | - | - | - | - |
| sha1sum | - | - | - | - | - | - |
| sha224sum | - | - | - | - | - | - |
| sha256sum | 657.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.0x** |
| sha384sum | - | - | - | - | - | - |
| sha512sum | - | - | - | - | - | - |
| shred | - | - | - | - | - | - |
| shuf | - | - | - | - | - | - |
| sleep | - | - | - | - | - | - |
| sort | 980.4 KB | 102.8 KB | 3.2 MB | ✅ 100% | **12.1x** | **12.4x** |
| split | - | - | - | - | - | - |
| stat | - | - | - | - | - | - |
| stdbuf | - | - | - | - | - | - |
| stty | - | - | - | - | - | - |
| sum | - | - | - | - | - | - |
| sync | - | - | - | - | - | - |
| tac | 1.9 MB | 38.4 KB | 2.7 MB | ✅ 100% | **3.1x** | **1.7x** |
| tail | - | - | - | - | - | - |
| tee | - | - | - | - | - | - |
| test | - | - | - | - | - | - |
| timeout | - | - | - | - | - | - |
| touch | - | - | - | - | - | - |
| tr | 696.2 KB | 46.5 KB | 1.3 MB | ✅ 100% | **6.6x** | **6.9x** |
| true | - | - | - | - | - | - |
| truncate | - | - | - | - | - | - |
| tsort | - | - | - | - | - | - |
| tty | - | - | - | - | - | - |
| uname | - | - | - | - | - | - |
| unexpand | - | - | - | - | - | - |
| uniq | 907.0 KB | 38.5 KB | 1.3 MB | ✅ 100% | **10.3x** | **6.6x** |
| unlink | - | - | - | - | - | - |
| uptime | - | - | - | - | - | - |
| users | - | - | - | - | - | - |
| vdir | - | - | - | - | - | - |
| wc | 904.8 KB | 54.5 KB | 1.4 MB | ⚠️ 97% | **31.6x** | **17.2x** |
| who | - | - | - | - | - | - |
| whoami | - | - | - | - | - | - |
| yes | 1.8 KB | 34.4 KB | - | ✅ 100% | **4.2x** | - |

### Known Issues
- 6 compatibility test failures across 5 platforms

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- [uutils/coreutils](https://github.com/uutils/coreutils) — built from source (latest main)
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Builds uutils/coreutils from source for comparison
- Runs 880+ compatibility tests comparing output byte-for-byte against GNU coreutils
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

## Platform Functional Tests (v0.9.8)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 437 | 3 | 0 | ⚠️ |
| Linux ARM64 | 437 | 3 | 0 | ⚠️ |
| macOS ARM64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
