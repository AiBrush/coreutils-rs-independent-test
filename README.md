# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.9.8)

### Summary
- **Tools tracked:** 107 total
- **Compatibility:** 873/880 tests passed (99.2%)
- **Fastest speedup:** wc at 30.4x faster than GNU

### Full Tools Comparison

> Sizes are raw binary sizes. Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.
> `†` = tested against a source build (not the published release).

| Tool | fcoreutils size | GNU size | uutils size | Compat f\* vs GNU | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|----------:|----------:|------------------:|-------------------:|----------------------:|
| arch | 425.8 KB | 34.5 KB | - | ✅ 100% † | **0.7x** | - |
| b2sum | 633.9 KB | 54.5 KB | 2.3 MB | ✅ 100% | **1.3x** | **1.3x** |
| base32 | 445.0 KB | 38.5 KB | - | ✅ 100% † | **1.4x** | - |
| base64 | 558.2 KB | 38.5 KB | 1.3 MB | ⚠️ 97% | **5.0x** | **5.3x** |
| basename | 430.6 KB | 34.5 KB | - | ✅ 100% † | **0.8x** | - |
| basenc | 455.7 KB | 46.5 KB | - | ✅ 100% † | **1.0x** | - |
| cat | 462.4 KB | 38.5 KB | 1.3 MB | ✅ 100% † | **2.3x** | **1.5x** |
| chcon | - | - | - | - | - | - |
| chgrp | 524.0 KB | 58.5 KB | - | ✅ 100% † | **0.9x** | - |
| chmod | 525.9 KB | 54.5 KB | - | ✅ 100% † | **1.0x** | - |
| chown | 528.5 KB | 58.5 KB | - | ✅ 100% † | **1.0x** | - |
| chroot | - | - | - | - | - | - |
| cksum | 443.2 KB | 102.5 KB | - | ✅ 100% † | **1.2x** | - |
| comm | 456.6 KB | 38.5 KB | 1.3 MB | ✅ 100% † | **3.1x** | **3.0x** |
| cp | 494.7 KB | 138.5 KB | - | ✅ 100% † | **0.9x** | - |
| csplit | 1.8 MB | 50.5 KB | - | - | **16.7x** | - |
| cut | 635.1 KB | 38.5 KB | 1.3 MB | ✅ 100% | **5.5x** | **1.7x** |
| date | - | - | - | ✅ 100% † | - | - |
| dd | 496.3 KB | 70.5 KB | - | ✅ 100% † | **1.0x** | - |
| df | - | - | - | ⚠️ 24% † | - | - |
| dir | - | - | - | - | - | - |
| dircolors | 451.2 KB | 46.5 KB | - | ⚠️ 86% † | - | - |
| dirname | 427.5 KB | 34.4 KB | - | ✅ 100% † | **0.8x** | - |
| du | - | - | - | ⚠️ 76% † | - | - |
| echo | 427.2 KB | 34.4 KB | - | ✅ 100% † | **0.8x** | - |
| env | 468.4 KB | 46.9 KB | - | ✅ 100% † | **0.9x** | - |
| expand | 451.0 KB | 34.5 KB | 1.3 MB | ✅ 100% † | **7.7x** | **2.7x** |
| expr | 1.8 MB | 42.4 KB | - | ✅ 100% † | **0.9x** | - |
| factor | 453.0 KB | 62.5 KB | - | ✅ 100% † | **0.9x** | - |
| false | 296.5 KB | 26.3 KB | - | ✅ 100% † | - | - |
| fmt | - | - | - | ⚠️ 94% † | - | - |
| fold | 449.7 KB | 34.5 KB | 1.3 MB | ✅ 100% † | **4.2x** | **1.3x** |
| groups | 429.4 KB | 34.5 KB | - | ✅ 100% † | **0.7x** | - |
| head | 458.2 KB | 42.5 KB | 1.3 MB | ✅ 100% † | **1.8x** | **1.1x** |
| hostid | 425.7 KB | 34.5 KB | - | ✅ 100% † | **0.8x** | - |
| id | 433.9 KB | 38.5 KB | - | ✅ 100% † | **1.0x** | - |
| install | 513.5 KB | 142.5 KB | - | ✅ 100% † | **1.0x** | - |
| join | 472.3 KB | 50.5 KB | 2.6 MB | ✅ 100% † | **0.7x** | **0.8x** |
| kill | - | - | - | - | - | - |
| link | 431.5 KB | 34.5 KB | - | ✅ 100% † | **1.0x** | - |
| ln | 452.5 KB | 54.5 KB | - | ✅ 100% † | **0.9x** | - |
| logname | 425.7 KB | 34.5 KB | - | ✅ 100% † | **0.8x** | - |
| ls | - | - | - | ✅ 100% † | - | - |
| md5sum | 657.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.2x** |
| mkdir | 443.0 KB | 74.5 KB | - | ✅ 100% † | **1.0x** | - |
| mkfifo | 433.1 KB | 42.5 KB | - | ✅ 100% † | **1.0x** | - |
| mknod | 435.3 KB | 42.5 KB | - | ✅ 100% † | **1.1x** | - |
| mktemp | 444.8 KB | 34.5 KB | - | ✅ 100% † | - | - |
| mv | 475.5 KB | 134.5 KB | - | - | **1.1x** | - |
| nice | 458.7 KB | 34.5 KB | - | ✅ 100% † | **0.8x** | - |
| nl | 1.8 MB | 38.6 KB | 2.7 MB | ✅ 100% † | **4.3x** | **1.5x** |
| nohup | 456.6 KB | 34.4 KB | - | ✅ 100% † | **0.8x** | - |
| nproc | 445.0 KB | 34.5 KB | - | ✅ 100% † | **0.8x** | - |
| numfmt | - | - | - | ✅ 100% † | - | - |
| od | - | - | - | ⚠️ 97% † | - | - |
| paste | 452.1 KB | 38.4 KB | 1.2 MB | ✅ 100% † | **1.7x** | **13.7x** |
| pathchk | 437.7 KB | 34.5 KB | - | ✅ 100% † | **0.8x** | - |
| pinky | - | - | - | ⚠️ 33% † | - | - |
| pr | - | - | - | ⚠️ 63% † | - | - |
| printenv | - | - | - | - | - | - |
| printf | - | - | - | ⚠️ 92% † | - | - |
| ptx | - | - | - | ⚠️ 20% † | - | - |
| pwd | 430.2 KB | 34.5 KB | - | ✅ 100% † | - | - |
| readlink | 440.0 KB | 42.4 KB | - | ✅ 100% † | **0.9x** | - |
| realpath | 444.4 KB | 42.4 KB | - | ✅ 100% † | **0.9x** | - |
| rev | 442.7 KB | 14.4 KB | - | ✅ 100% † | **21.7x** | - |
| rm | 523.2 KB | 58.5 KB | - | ✅ 100% † | **0.9x** | - |
| rmdir | 432.0 KB | 46.4 KB | - | ⚠️ 83% † | **0.9x** | - |
| runcon | - | - | - | - | - | - |
| seq | 491.0 KB | 50.5 KB | - | ✅ 100% † | **16.4x** | - |
| sha1sum | 4.9 MB | 38.4 KB | - | ✅ 100% † | **0.8x** | - |
| sha224sum | 4.9 MB | 38.4 KB | - | ✅ 100% † | **0.8x** | - |
| sha256sum | 657.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.0x** |
| sha384sum | 4.9 MB | 38.4 KB | - | ✅ 100% † | **0.9x** | - |
| sha512sum | 4.9 MB | 38.4 KB | - | ✅ 100% † | **0.9x** | - |
| shred | 456.0 KB | 54.5 KB | - | ✅ 100% † | **2.0x** | - |
| shuf | 469.7 KB | 46.5 KB | - | ✅ 100% † | - | - |
| sleep | 445.3 KB | 34.5 KB | - | ✅ 100% † | **1.0x** | - |
| sort | 980.4 KB | 102.8 KB | 3.2 MB | ✅ 100% | **12.3x** | **12.7x** |
| split | 526.3 KB | 54.9 KB | - | ✅ 100% † | **0.9x** | - |
| stat | - | - | - | ⚠️ 79% † | - | - |
| stdbuf | - | - | - | ✅ 100% † | - | - |
| stty | - | - | - | ⚠️ 57% † | - | - |
| sum | 440.7 KB | 34.4 KB | - | ✅ 100% † | **1.3x** | - |
| sync | 431.4 KB | 34.4 KB | - | ⚠️ 83% † | **1.0x** | - |
| tac | 1.9 MB | 38.4 KB | 2.7 MB | ✅ 100% | **3.0x** | **1.6x** |
| tail | 485.8 KB | 62.5 KB | 1.7 MB | ✅ 100% † | **1.5x** | **2.1x** |
| tee | 444.4 KB | 38.5 KB | - | ✅ 100% † | - | - |
| test | 441.6 KB | 46.4 KB | - | ✅ 100% † | **0.2x** | - |
| timeout | 486.5 KB | 38.9 KB | - | ⚠️ 90% † | - | - |
| touch | 457.4 KB | 94.5 KB | - | ⚠️ 95% † | **0.8x** | - |
| tr | 696.2 KB | 46.5 KB | 1.3 MB | ✅ 100% | **7.0x** | **7.5x** |
| true | 296.1 KB | 26.3 KB | - | ✅ 100% † | - | - |
| truncate | 442.1 KB | 38.5 KB | - | ✅ 100% † | **0.8x** | - |
| tsort | 466.9 KB | 46.5 KB | - | ✅ 100% † | - | - |
| tty | 426.7 KB | 34.5 KB | - | ✅ 100% † | **0.7x** | - |
| uname | 429.6 KB | 34.5 KB | - | ✅ 100% † | **1.1x** | - |
| unexpand | 454.5 KB | 38.5 KB | 1.3 MB | ✅ 100% † | **3.2x** | **2.5x** |
| uniq | 907.0 KB | 38.5 KB | 1.3 MB | ✅ 100% | **9.6x** | **5.4x** |
| unlink | 430.4 KB | 34.5 KB | - | ✅ 100% † | **0.8x** | - |
| uptime | 518.7 KB | 14.4 KB | - | ⚠️ 80% † | - | - |
| users | - | - | - | ✅ 100% † | - | - |
| vdir | - | - | - | - | - | - |
| wc | 904.8 KB | 54.5 KB | 1.4 MB | ⚠️ 96% | **30.4x** | **16.9x** |
| who | - | - | - | ⚠️ 73% † | - | - |
| whoami | 425.9 KB | 34.5 KB | - | ✅ 100% † | **0.8x** | - |
| yes | 425.2 KB | 34.4 KB | - | ✅ 100% | **5.2x** | - |

### Known Issues
- 7 compatibility test failures across 5 platforms

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
| Linux x86_64 | 436 | 4 | 0 | ⚠️ |
| Linux ARM64 | 437 | 3 | 0 | ⚠️ |
| macOS ARM64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
