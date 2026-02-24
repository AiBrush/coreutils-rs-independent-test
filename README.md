# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.10.4)

### Summary
- **Tools tracked:** 107 total
- **Compatibility:** 2190/2224 tests passed (98.5%)
- **Fastest speedup:** wc at 29.6x faster than GNU

### Full Tools Comparison

> Sizes are raw binary sizes. Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | fcoreutils size | GNU size | uutils size | Compat f\* vs GNU | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|----------:|----------:|------------------:|-------------------:|----------------------:|
| arch | 425.1 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| b2sum | 631.8 KB | 54.5 KB | 2.3 MB | ✅ 100% | **1.3x** | **1.2x** |
| base32 | 445.5 KB | 38.5 KB | - | ✅ 100% | **1.5x** | - |
| base64 | 561.6 KB | 38.5 KB | 1.3 MB | ✅ 100% | **5.8x** | **5.9x** |
| basename | 430.0 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| basenc | 459.3 KB | 46.5 KB | - | ✅ 100% | **1.1x** | - |
| cat | 461.8 KB | 38.5 KB | 1.3 MB | ✅ 100% | **2.5x** | **1.8x** |
| chcon | 423.6 KB | 58.5 KB | - | ❌ 0% | - | - |
| chgrp | 523.2 KB | 58.5 KB | - | ✅ 100% | **0.9x** | - |
| chmod | 525.3 KB | 54.5 KB | - | ✅ 100% | **1.3x** | - |
| chown | 527.8 KB | 58.5 KB | - | ✅ 100% | **1.0x** | - |
| chroot | 465.1 KB | 38.5 KB | - | ❌ 0% | - | - |
| cksum | 450.9 KB | 102.5 KB | - | ✅ 100% | **1.1x** | - |
| comm | 456.0 KB | 38.5 KB | 1.3 MB | ✅ 100% | **3.3x** | **3.2x** |
| cp | 494.1 KB | 138.5 KB | - | ✅ 100% | **1.0x** | - |
| csplit | 1.8 MB | 50.5 KB | - | - | **17.1x** | - |
| cut | 638.6 KB | 38.5 KB | 1.3 MB | ✅ 100% | **5.0x** | **1.5x** |
| date | 504.6 KB | 106.5 KB | - | ✅ 100% | - | - |
| dd | 495.6 KB | 70.5 KB | - | ✅ 100% | **0.9x** | - |
| df | 536.8 KB | 87.1 KB | - | ⚠️ 53% | - | - |
| dir | 452.8 KB | 139.0 KB | - | ❌ 0% | - | - |
| dircolors | 450.5 KB | 46.5 KB | - | ✅ 100% | - | - |
| dirname | 426.9 KB | 34.4 KB | - | ✅ 100% | **0.9x** | - |
| du | 510.7 KB | 98.5 KB | - | ✅ 100% | - | - |
| echo | 426.6 KB | 34.4 KB | - | ✅ 100% | **0.8x** | - |
| env | 467.7 KB | 46.9 KB | - | ✅ 100% | **0.9x** | - |
| expand | 450.5 KB | 34.5 KB | 1.3 MB | ✅ 100% | **9.9x** | **2.8x** |
| expr | 1.8 MB | 42.4 KB | - | ✅ 100% | **0.8x** | - |
| factor | 452.3 KB | 62.5 KB | - | ✅ 100% | **0.9x** | - |
| false | 296.5 KB | 26.3 KB | - | ✅ 100% | - | - |
| fmt | 460.1 KB | 38.5 KB | - | ✅ 100% | - | - |
| fold | 449.1 KB | 34.5 KB | 1.3 MB | ✅ 100% | **4.9x** | **1.6x** |
| groups | 428.6 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| head | 457.6 KB | 42.5 KB | 1.3 MB | ✅ 100% | **1.7x** | **1.2x** |
| hostid | 425.0 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| id | 433.3 KB | 38.5 KB | - | ✅ 100% | **1.0x** | - |
| install | 512.8 KB | 142.5 KB | - | ✅ 100% | **1.1x** | - |
| join | 471.6 KB | 50.5 KB | 2.6 MB | ✅ 100% | **0.7x** | **0.8x** |
| kill | 327.2 KB | 22.4 KB | - | ❌ 0% | - | - |
| link | 430.9 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| ln | 451.8 KB | 54.5 KB | - | ✅ 100% | **0.9x** | - |
| logname | 425.0 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| ls | 578.7 KB | 139.0 KB | - | ✅ 100% | - | - |
| md5sum | 658.3 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.1x** | **1.2x** |
| mkdir | 442.3 KB | 74.5 KB | - | ✅ 100% | **1.0x** | - |
| mkfifo | 432.4 KB | 42.5 KB | - | ✅ 100% | **1.0x** | - |
| mknod | 434.5 KB | 42.5 KB | - | ✅ 100% | **1.0x** | - |
| mktemp | 444.1 KB | 34.5 KB | - | ✅ 100% | - | - |
| mv | 474.8 KB | 134.5 KB | - | - | **1.0x** | - |
| nice | 458.0 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| nl | 1.8 MB | 38.6 KB | 2.7 MB | ✅ 100% | **4.8x** | **1.6x** |
| nohup | 455.8 KB | 34.4 KB | - | ✅ 100% | **0.9x** | - |
| nproc | 444.4 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| numfmt | 517.3 KB | 58.5 KB | - | ✅ 100% | - | - |
| od | 520.6 KB | 70.5 KB | - | ✅ 100% | - | - |
| paste | 451.6 KB | 38.4 KB | 1.2 MB | ✅ 100% | **1.9x** | **15.1x** |
| pathchk | 437.0 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| pinky | 765.1 KB | 38.4 KB | - | ✅ 100% | - | - |
| pr | 500.6 KB | 70.6 KB | - | ✅ 100% | - | - |
| printenv | 428.7 KB | 34.4 KB | - | ❌ 0% | - | - |
| printf | 493.6 KB | 54.4 KB | - | ✅ 100% | - | - |
| ptx | 520.1 KB | 54.5 KB | - | ✅ 100% | - | - |
| pwd | 429.6 KB | 34.5 KB | - | ✅ 100% | - | - |
| readlink | 439.4 KB | 42.4 KB | - | ✅ 100% | **0.8x** | - |
| realpath | 443.8 KB | 42.4 KB | - | ✅ 100% | **0.8x** | - |
| rev | 442.1 KB | 14.4 KB | - | ✅ 100% | **21.7x** | - |
| rm | 522.5 KB | 58.5 KB | - | ✅ 100% | **0.9x** | - |
| rmdir | 431.3 KB | 46.4 KB | - | ⚠️ 83% | **0.9x** | - |
| runcon | 423.3 KB | 34.5 KB | - | ❌ 0% | - | - |
| seq | 487.0 KB | 50.5 KB | - | ✅ 100% | **16.8x** | - |
| sha1sum | 652.1 KB | 38.4 KB | - | ✅ 100% | **0.9x** | - |
| sha224sum | 652.8 KB | 38.4 KB | - | ✅ 100% | **0.9x** | - |
| sha256sum | 652.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.0x** |
| sha384sum | 652.0 KB | 38.4 KB | - | ✅ 100% | **0.7x** | - |
| sha512sum | 652.1 KB | 38.4 KB | - | ✅ 100% | **0.7x** | - |
| shred | 455.9 KB | 54.5 KB | - | ✅ 100% | **2.2x** | - |
| shuf | 469.0 KB | 46.5 KB | - | ✅ 100% | - | - |
| sleep | 444.6 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| sort | 971.6 KB | 102.8 KB | 3.2 MB | ✅ 100% | **12.1x** | **12.5x** |
| split | 526.9 KB | 54.9 KB | - | ✅ 100% | **1.0x** | - |
| stat | 465.8 KB | 86.5 KB | - | ⚠️ 97% | - | - |
| stdbuf | 485.1 KB | 50.5 KB | - | ✅ 100% | - | - |
| stty | 449.6 KB | 78.5 KB | - | ⚠️ 57% | - | - |
| sum | 440.1 KB | 34.4 KB | - | ✅ 100% | **1.4x** | - |
| sync | 430.6 KB | 34.4 KB | - | ⚠️ 83% | **0.8x** | - |
| tac | 1.9 MB | 38.4 KB | 2.7 MB | ✅ 100% | **3.0x** | **1.6x** |
| tail | 485.3 KB | 62.5 KB | 1.7 MB | ✅ 100% | **1.4x** | **1.9x** |
| tee | 443.6 KB | 38.5 KB | - | ✅ 100% | - | - |
| test | 440.9 KB | 46.4 KB | - | ✅ 100% | - | - |
| timeout | 485.9 KB | 38.9 KB | - | ⚠️ 90% | - | - |
| touch | 457.7 KB | 94.5 KB | - | ✅ 100% | **0.9x** | - |
| tr | 678.1 KB | 46.5 KB | 1.3 MB | ✅ 100% | **6.3x** | **7.2x** |
| true | 296.0 KB | 26.3 KB | - | ✅ 100% | - | - |
| truncate | 441.5 KB | 38.5 KB | - | ✅ 100% | **0.9x** | - |
| tsort | 464.5 KB | 46.5 KB | - | ✅ 100% | - | - |
| tty | 426.0 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| uname | 428.9 KB | 34.5 KB | - | ⚠️ 79% | **0.8x** | - |
| unexpand | 453.9 KB | 38.5 KB | 1.3 MB | ✅ 100% | **4.2x** | **2.5x** |
| uniq | 902.7 KB | 38.5 KB | 1.3 MB | ✅ 100% | **10.7x** | **5.7x** |
| unlink | 429.7 KB | 34.5 KB | - | ✅ 100% | **0.9x** | - |
| uptime | 518.1 KB | 14.4 KB | - | ⚠️ 80% | - | - |
| users | 462.3 KB | 34.5 KB | - | ✅ 100% | - | - |
| vdir | 452.8 KB | 139.0 KB | - | ❌ 0% | - | - |
| wc | 892.5 KB | 54.5 KB | 1.4 MB | ⚠️ 96% | **29.6x** | **16.1x** |
| who | 780.0 KB | 58.5 KB | - | ⚠️ 87% | - | - |
| whoami | 425.1 KB | 34.5 KB | - | ✅ 100% | **0.8x** | - |
| yes | 432.2 KB | 34.4 KB | - | ⚠️ 96% | **1.1x** | - |

### Known Issues
- 23 compatibility test failures across 1 platforms

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- [uutils/coreutils](https://github.com/uutils/coreutils) — built from source (latest main)
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Builds uutils/coreutils from source for comparison
- Runs 2224+ compatibility tests comparing output byte-for-byte against GNU coreutils
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

## Platform Functional Tests (v0.10.3)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 2190 | 23 | 11 | ⚠️ |
| Linux ARM64 | 2192 | 21 | 11 | ⚠️ |
| macOS ARM64 | 189 | 35 | 7 | ⚠️ |
| Windows x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
