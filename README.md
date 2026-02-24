# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.10.1)

### Summary
- **Tools tracked:** 107 total
- **Compatibility:** 4530/4679 tests passed (96.8%)
- **Fastest speedup:** wc at 31.7x faster than GNU

### Full Tools Comparison

> Sizes are raw binary sizes. Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | fcoreutils size | GNU size | uutils size | Compat f\* vs GNU | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|----------:|----------:|------------------:|-------------------:|----------------------:|
| arch | 424.9 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| b2sum | 633.9 KB | 54.5 KB | 2.3 MB | ✅ 100% | **1.3x** | **1.2x** |
| base32 | 445.3 KB | 38.5 KB | - | ✅ 100% | **1.5x** | - |
| base64 | 558.6 KB | 38.5 KB | 1.3 MB | ✅ 100% | **5.7x** | **5.9x** |
| basename | 429.7 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| basenc | 458.9 KB | 46.5 KB | - | ✅ 100% | **1.1x** | - |
| cat | 458.7 KB | 38.5 KB | 1.3 MB | ✅ 100% | **2.6x** | **1.8x** |
| chcon | 423.3 KB | 58.5 KB | - | ❌ 0% | - | - |
| chgrp | 523.9 KB | 58.5 KB | - | ✅ 100% | **1.0x** | - |
| chmod | 525.5 KB | 54.5 KB | - | ✅ 100% | **0.9x** | - |
| chown | 528.4 KB | 58.5 KB | - | ✅ 100% | **0.9x** | - |
| chroot | 464.7 KB | 38.5 KB | - | ❌ 0% | - | - |
| cksum | 450.5 KB | 102.5 KB | - | ✅ 100% | **1.2x** | - |
| comm | 453.7 KB | 38.5 KB | 1.3 MB | ✅ 100% | **3.5x** | **3.4x** |
| cp | 494.2 KB | 138.5 KB | - | ✅ 100% | **0.9x** | - |
| csplit | 1.8 MB | 50.5 KB | - | - | **17.0x** | - |
| cut | 635.1 KB | 38.5 KB | 1.3 MB | ✅ 100% | **5.4x** | **1.7x** |
| date | 505.2 KB | 106.5 KB | - | ⚠️ 94% | - | - |
| dd | 495.7 KB | 70.5 KB | - | ✅ 100% | **0.9x** | - |
| df | 539.7 KB | 87.1 KB | - | ⚠️ 53% | - | - |
| dir | 452.3 KB | 139.0 KB | - | ❌ 0% | - | - |
| dircolors | 450.2 KB | 46.5 KB | - | ⚠️ 86% | - | - |
| dirname | 426.5 KB | 34.4 KB | - | ✅ 100% | **0.8x** | - |
| du | 510.9 KB | 98.5 KB | - | ✅ 100% | - | - |
| echo | 426.4 KB | 34.4 KB | - | ✅ 100% | **0.8x** | - |
| env | 467.4 KB | 46.9 KB | - | ✅ 100% | **0.9x** | - |
| expand | 446.7 KB | 34.5 KB | 1.3 MB | ✅ 100% | **10.0x** | **2.8x** |
| expr | 1.8 MB | 42.4 KB | - | ✅ 100% | **0.8x** | - |
| factor | 453.0 KB | 62.5 KB | - | ✅ 100% | **1.0x** | - |
| false | 297.0 KB | 26.3 KB | - | ✅ 100% | - | - |
| fmt | 457.6 KB | 38.5 KB | - | ⚠️ 83% | - | - |
| fold | 445.7 KB | 34.5 KB | 1.3 MB | ✅ 100% | **4.9x** | **1.7x** |
| groups | 428.5 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| head | 455.3 KB | 42.5 KB | 1.3 MB | ✅ 100% | **2.0x** | **1.2x** |
| hostid | 424.7 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| id | 433.1 KB | 38.5 KB | - | ✅ 100% | **1.0x** | - |
| install | 513.4 KB | 142.5 KB | - | ✅ 100% | **1.1x** | - |
| join | 468.2 KB | 50.5 KB | 2.6 MB | ✅ 100% | **0.7x** | **0.8x** |
| kill | 327.9 KB | 22.4 KB | - | ❌ 0% | - | - |
| link | 430.5 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| ln | 451.7 KB | 54.5 KB | - | ✅ 100% | **0.9x** | - |
| logname | 424.7 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| ls | 587.9 KB | 139.0 KB | - | ⚠️ 98% | - | - |
| md5sum | 657.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.3x** |
| mkdir | 442.5 KB | 74.5 KB | - | ✅ 100% | **1.0x** | - |
| mkfifo | 432.3 KB | 42.5 KB | - | ✅ 100% | **1.0x** | - |
| mknod | 434.4 KB | 42.5 KB | - | ✅ 100% | **1.0x** | - |
| mktemp | 443.9 KB | 34.5 KB | - | ✅ 100% | - | - |
| mv | 474.8 KB | 134.5 KB | - | - | **1.0x** | - |
| nice | 457.5 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| nl | 1.8 MB | 38.6 KB | 2.7 MB | ✅ 100% | **4.8x** | **1.7x** |
| nohup | 455.6 KB | 34.4 KB | - | ✅ 100% | **0.9x** | - |
| nproc | 444.0 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| numfmt | 516.7 KB | 58.5 KB | - | ⚠️ 65% | - | - |
| od | 521.0 KB | 70.5 KB | - | ✅ 100% | - | - |
| paste | 450.4 KB | 38.4 KB | 1.2 MB | ✅ 100% | **2.5x** | **20.3x** |
| pathchk | 438.7 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| pinky | 768.6 KB | 38.4 KB | - | ✅ 100% | - | - |
| pr | 502.2 KB | 70.6 KB | - | ✅ 100% | - | - |
| printenv | 428.4 KB | 34.4 KB | - | ❌ 0% | - | - |
| printf | 493.2 KB | 54.4 KB | - | ⚠️ 98% | - | - |
| ptx | 525.9 KB | 54.5 KB | - | ✅ 100% | - | - |
| pwd | 429.2 KB | 34.5 KB | - | ✅ 100% | - | - |
| readlink | 439.2 KB | 42.4 KB | - | ✅ 100% | **0.8x** | - |
| realpath | 443.5 KB | 42.4 KB | - | ✅ 100% | **0.8x** | - |
| rev | 439.3 KB | 14.4 KB | - | ✅ 100% | **22.9x** | - |
| rm | 522.7 KB | 58.5 KB | - | ✅ 100% | **0.9x** | - |
| rmdir | 431.0 KB | 46.4 KB | - | ⚠️ 83% | **0.9x** | - |
| runcon | 423.0 KB | 34.5 KB | - | ❌ 0% | - | - |
| seq | 485.9 KB | 50.5 KB | - | ✅ 100% | **16.0x** | - |
| sha1sum | 657.3 KB | 38.4 KB | - | ✅ 100% | **0.8x** | - |
| sha224sum | 657.4 KB | 38.4 KB | - | ✅ 100% | **0.8x** | - |
| sha256sum | 657.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.0x** |
| sha384sum | 657.3 KB | 38.4 KB | - | ✅ 100% | **0.9x** | - |
| sha512sum | 657.4 KB | 38.4 KB | - | ✅ 100% | **0.9x** | - |
| shred | 456.5 KB | 54.5 KB | - | ✅ 100% | **2.7x** | - |
| shuf | 470.1 KB | 46.5 KB | - | ✅ 100% | - | - |
| sleep | 444.4 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| sort | 980.4 KB | 102.8 KB | 3.2 MB | ✅ 100% | **11.9x** | **12.0x** |
| split | 523.7 KB | 54.9 KB | - | ✅ 100% | **1.0x** | - |
| stat | 465.5 KB | 86.5 KB | - | ⚠️ 97% | - | - |
| stdbuf | 484.4 KB | 50.5 KB | - | ✅ 100% | - | - |
| stty | 449.4 KB | 78.5 KB | - | ⚠️ 57% | - | - |
| sum | 439.7 KB | 34.4 KB | - | ✅ 100% | **1.4x** | - |
| sync | 430.2 KB | 34.4 KB | - | ⚠️ 83% | **0.8x** | - |
| tac | 1.9 MB | 38.4 KB | 2.7 MB | ✅ 100% | **3.1x** | **1.7x** |
| tail | 481.5 KB | 62.5 KB | 1.7 MB | ✅ 100% | **1.5x** | **2.1x** |
| tee | 443.4 KB | 38.5 KB | - | ✅ 100% | - | - |
| test | 440.5 KB | 46.4 KB | - | ✅ 100% | - | - |
| timeout | 485.9 KB | 38.9 KB | - | ⚠️ 90% | - | - |
| touch | 457.8 KB | 94.5 KB | - | ✅ 100% | **0.9x** | - |
| tr | 696.2 KB | 46.5 KB | 1.3 MB | ✅ 100% | **6.5x** | **6.7x** |
| true | 296.6 KB | 26.3 KB | - | ✅ 100% | - | - |
| truncate | 441.2 KB | 38.5 KB | - | ✅ 100% | **0.9x** | - |
| tsort | 464.7 KB | 46.5 KB | - | ✅ 100% | - | - |
| tty | 425.8 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| uname | 428.6 KB | 34.5 KB | - | ⚠️ 79% | **0.8x** | - |
| unexpand | 449.5 KB | 38.5 KB | 1.3 MB | ✅ 100% | **4.5x** | **2.9x** |
| uniq | 907.0 KB | 38.5 KB | 1.3 MB | ✅ 100% | **10.3x** | **6.1x** |
| unlink | 429.4 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| uptime | 517.8 KB | 14.4 KB | - | ✅ 100% | - | - |
| users | 461.2 KB | 34.5 KB | - | ✅ 100% | - | - |
| vdir | 452.3 KB | 139.0 KB | - | ❌ 0% | - | - |
| wc | 905.5 KB | 54.5 KB | 1.4 MB | ⚠️ 99% | **31.7x** | **17.5x** |
| who | 782.8 KB | 58.5 KB | - | ⚠️ 73% | - | - |
| whoami | 425.0 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| yes | 1.8 KB | 34.4 KB | - | ✅ 100% | **4.3x** | - |

### Known Issues
- 120 compatibility test failures across 5 platforms

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- [uutils/coreutils](https://github.com/uutils/coreutils) — built from source (latest main)
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Builds uutils/coreutils from source for comparison
- Runs 4679+ compatibility tests comparing output byte-for-byte against GNU coreutils
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

## Platform Functional Tests (v0.10.1)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 2172 | 41 | 11 | ⚠️ |
| Linux ARM64 | 2171 | 42 | 11 | ⚠️ |
| macOS ARM64 | 187 | 37 | 7 | ⚠️ |
| Windows x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
