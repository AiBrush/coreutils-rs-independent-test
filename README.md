# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.14.1)

### Summary
- **Tools tracked:** 107 total
- **Compatibility:** 3120/3269 tests passed (95.4%)
- **Fastest speedup:** rev at 23.5x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | fcoreutils size | GNU size | Compat f\* vs GNU | Speedup f\* vs GNU |
|------|----------------:|----------:|------------------:|-------------------:|
| arch | 425.2 KB | 34.5 KB | ✅ 100% | **0.9x** |
| b2sum | 633.9 KB | 54.5 KB | ✅ 100% | - |
| base32 | 444.9 KB | 38.5 KB | ✅ 100% | **1.7x** |
| base64 | 558.6 KB | 38.5 KB | ✅ 100% | **6.9x** |
| basename | 429.7 KB | 34.5 KB | ✅ 100% | **0.9x** |
| basenc | 467.4 KB | 46.5 KB | ⚠️ 98% | **2.5x** |
| cat | 459.0 KB | 38.5 KB | ⚠️ 96% | - |
| chcon | 458.9 KB | 58.5 KB | - | - |
| chgrp | 524.5 KB | 58.5 KB | ⚠️ 90% | **1.0x** |
| chmod | 529.4 KB | 54.5 KB | - | **1.0x** |
| chown | 528.4 KB | 58.5 KB | ⚠️ 86% | **1.0x** |
| chroot | 464.7 KB | 38.5 KB | ⚠️ 31% | - |
| cksum | 634.7 KB | 102.5 KB | ⚠️ 98% | **0.9x** |
| comm | 453.7 KB | 38.5 KB | ✅ 100% | - |
| cp | 562.3 KB | 138.5 KB | - | **1.1x** |
| csplit | 1.8 MB | 50.5 KB | - | **17.7x** |
| cut | 635.4 KB | 38.5 KB | ⚠️ 95% | **5.9x** |
| date | 508.5 KB | 106.5 KB | ✅ 100% | - |
| dd | 500.7 KB | 70.5 KB | - | **1.1x** |
| df | 540.2 KB | 87.1 KB | ⚠️ 54% | - |
| dir | 590.9 KB | 139.0 KB | ❌ 0% | - |
| dircolors | 450.1 KB | 46.5 KB | ✅ 100% | - |
| dirname | 426.5 KB | 34.4 KB | ✅ 100% | **0.9x** |
| du | 511.7 KB | 98.5 KB | ⚠️ 98% | - |
| echo | 426.7 KB | 34.4 KB | ⚠️ 98% | **0.9x** |
| env | 474.2 KB | 46.9 KB | ⚠️ 96% | **0.9x** |
| expand | 453.5 KB | 34.5 KB | ✅ 100% | - |
| expr | 1.8 MB | 42.4 KB | ✅ 100% | **0.9x** |
| factor | 472.0 KB | 62.5 KB | ⚠️ 93% | **1.7x** |
| false | 297.0 KB | 26.3 KB | ✅ 100% | - |
| fmt | 457.4 KB | 38.5 KB | ✅ 100% | - |
| fold | 450.7 KB | 34.5 KB | ⚠️ 93% | - |
| groups | 428.5 KB | 34.5 KB | ⚠️ 89% | **0.9x** |
| head | 452.0 KB | 42.5 KB | ⚠️ 94% | - |
| hostid | 424.7 KB | 34.5 KB | ✅ 100% | **0.9x** |
| id | 435.9 KB | 38.5 KB | ✅ 100% | **1.1x** |
| install | 516.2 KB | 142.5 KB | ⚠️ 82% | **1.1x** |
| join | 469.3 KB | 50.5 KB | ✅ 100% | - |
| kill | 454.5 KB | 22.4 KB | ⚠️ 85% | - |
| link | 430.5 KB | 34.5 KB | ✅ 100% | **0.9x** |
| ln | 456.4 KB | 54.5 KB | ⚠️ 91% | **0.9x** |
| logname | 424.7 KB | 34.5 KB | ✅ 100% | **0.9x** |
| ls | 593.1 KB | 139.0 KB | ✅ 100% | - |
| md5sum | 624.7 KB | 38.4 KB | ✅ 100% | - |
| mkdir | 443.0 KB | 74.5 KB | ⚠️ 84% | **1.0x** |
| mkfifo | 432.3 KB | 42.5 KB | ✅ 100% | **1.0x** |
| mknod | 436.7 KB | 42.5 KB | ✅ 100% | **1.1x** |
| mktemp | 443.9 KB | 34.5 KB | ⚠️ 88% | - |
| mv | 474.8 KB | 134.5 KB | - | **1.1x** |
| nice | 457.7 KB | 34.5 KB | ⚠️ 94% | **0.9x** |
| nl | 1.8 MB | 38.6 KB | ⚠️ 94% | - |
| nohup | 455.9 KB | 34.4 KB | ✅ 100% | **0.9x** |
| nproc | 444.4 KB | 34.5 KB | ⚠️ 94% | **0.9x** |
| numfmt | 517.0 KB | 58.5 KB | ⚠️ 94% | - |
| od | 533.6 KB | 70.5 KB | ⚠️ 98% | - |
| paste | 450.4 KB | 38.4 KB | ⚠️ 94% | - |
| pathchk | 438.7 KB | 34.5 KB | ✅ 100% | **0.9x** |
| pinky | 768.6 KB | 38.4 KB | ✅ 100% | - |
| pr | 502.2 KB | 70.6 KB | ⚠️ 95% | - |
| printenv | 428.7 KB | 34.4 KB | ✅ 100% | - |
| printf | 494.7 KB | 54.4 KB | ⚠️ 99% | - |
| ptx | 520.6 KB | 54.5 KB | ✅ 100% | - |
| pwd | 429.7 KB | 34.5 KB | ⚠️ 82% | - |
| readlink | 443.7 KB | 42.4 KB | ⚠️ 97% | **0.9x** |
| realpath | 445.0 KB | 42.4 KB | ✅ 100% | **0.9x** |
| rev | 439.3 KB | 14.4 KB | ✅ 100% | **23.5x** |
| rm | 532.7 KB | 58.5 KB | ⚠️ 88% | **1.0x** |
| rmdir | 431.0 KB | 46.4 KB | ⚠️ 81% | **0.9x** |
| runcon | 463.9 KB | 34.5 KB | ⚠️ 57% | - |
| seq | 546.7 KB | 50.5 KB | ✅ 100% | **15.6x** |
| sha1sum | 617.0 KB | 38.4 KB | ✅ 100% | **0.8x** |
| sha224sum | 617.1 KB | 38.4 KB | ✅ 100% | **0.8x** |
| sha256sum | 617.9 KB | 38.4 KB | ✅ 100% | - |
| sha384sum | 617.0 KB | 38.4 KB | ✅ 100% | **0.9x** |
| sha512sum | 617.1 KB | 38.4 KB | ✅ 100% | **0.9x** |
| shred | 456.9 KB | 54.5 KB | ✅ 100% | **2.2x** |
| shuf | 470.8 KB | 46.5 KB | ⚠️ 87% | - |
| sleep | 444.4 KB | 34.5 KB | ✅ 100% | **1.0x** |
| sort | 1.0 MB | 102.8 KB | ⚠️ 96% | **13.7x** |
| split | 527.5 KB | 54.9 KB | - | **1.0x** |
| stat | 467.4 KB | 86.5 KB | ⚠️ 97% | - |
| stdbuf | 484.4 KB | 50.5 KB | ✅ 100% | - |
| stty | 454.7 KB | 78.5 KB | ⚠️ 82% | - |
| sum | 442.5 KB | 34.4 KB | ✅ 100% | **1.2x** |
| sync | 430.6 KB | 34.4 KB | ⚠️ 90% | **0.9x** |
| tac | 1.9 MB | 38.4 KB | ✅ 100% | - |
| tail | 478.0 KB | 62.5 KB | ⚠️ 99% | - |
| tee | 436.3 KB | 38.5 KB | ✅ 100% | **1.4x** |
| test | 440.2 KB | 46.4 KB | ✅ 100% | - |
| timeout | 486.9 KB | 38.9 KB | ✅ 100% | - |
| touch | 459.4 KB | 94.5 KB | ⚠️ 88% | **0.9x** |
| tr | 699.6 KB | 46.5 KB | ⚠️ 90% | **7.6x** |
| true | 296.6 KB | 26.3 KB | ✅ 100% | - |
| truncate | 441.9 KB | 38.5 KB | ⚠️ 94% | **1.0x** |
| tsort | 460.2 KB | 46.5 KB | ✅ 100% | **10.4x** |
| tty | 425.8 KB | 34.5 KB | ✅ 100% | **0.9x** |
| uname | 428.6 KB | 34.5 KB | ✅ 100% | **0.9x** |
| unexpand | 453.3 KB | 38.5 KB | ⚠️ 96% | - |
| uniq | 903.0 KB | 38.5 KB | ⚠️ 99% | **12.2x** |
| unlink | 429.4 KB | 34.5 KB | ✅ 100% | **0.9x** |
| uptime | 501.2 KB | 14.4 KB | ✅ 100% | - |
| users | 461.2 KB | 34.5 KB | ✅ 100% | - |
| vdir | 590.9 KB | 139.0 KB | ❌ 0% | - |
| wc | 906.9 KB | 54.5 KB | ⚠️ 97% | - |
| who | 782.6 KB | 58.5 KB | ✅ 100% | - |
| whoami | 425.0 KB | 34.5 KB | ✅ 100% | **0.9x** |
| yes | 1.8 KB | 34.4 KB | ⚠️ 90% | **3.9x** |

### Known Issues
- 145 compatibility test failures across 2 platform(s)

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Runs 3269+ compatibility tests comparing output byte-for-byte against GNU coreutils
- Benchmarks using `hyperfine` with warmup runs and timed runs
- Measures binary sizes of f\* and GNU for each tool
- Tests run across multiple platforms via GitHub Actions

## Running Locally
```bash
# Install and test
./scripts/install_from_github.sh
./tests/compatibility/run_all.sh
./tests/benchmarks/run_all.sh

# Generate chart
pip install matplotlib
python3 scripts/plot_speedup.py
```

## Platform Functional Tests (v0.14.1)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 3120 | 71 | 78 | ⚠️ |
| Linux ARM64 | 3117 | 74 | 78 | ⚠️ |
| macOS ARM64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
