# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.15.3)

### Summary
- **Tools tracked:** 107 total (107 with binaries)
- **Compatibility:** 3773/3911 tests passed (96.5%) across 107 tools
- **Benchmarked:** 101 tools with performance data
- **Fastest speedup:** rev at 23.5x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
>
> Legend: `-` = no data collected | `N/A` = not applicable | `⏭️ 0 tests` = test ran but produced 0 results

| Tool | fcoreutils size | GNU size | Compat f\* vs GNU | Speedup f\* vs GNU |
|------|----------------:|---------:|------------------:|-------------------:|
| arch | 425.2 KB | 34.5 KB | ✅ 17/17 | 0.9x |
| b2sum | 633.9 KB | 54.5 KB | ✅ 25/25 | **1.2x** |
| base32 | 444.9 KB | 38.5 KB | ✅ 29/29 | **1.7x** |
| base64 | 558.6 KB | 38.5 KB | ✅ 33/33 | **6.8x** |
| basename | 429.7 KB | 34.5 KB | ✅ 26/26 | 0.9x |
| basenc | 467.5 KB | 46.5 KB | ⚠️ 99% (95/96) | **2.4x** |
| cat | 460.2 KB | 38.5 KB | ✅ 49/49 | **1.9x** |
| chcon | 458.9 KB | 58.5 KB | ⚠️ 62% (15/24) | N/A |
| chgrp | 524.5 KB | 58.5 KB | ⚠️ 89% (17/19) | 0.9x |
| chmod | 530.2 KB | 54.5 KB | ⚠️ 99% (78/79) | - |
| chown | 528.4 KB | 58.5 KB | ⚠️ 85% (17/20) | **1.0x** |
| chroot | 464.7 KB | 38.5 KB | ⚠️ 47% (18/38) | N/A |
| cksum | 634.8 KB | 102.5 KB | ✅ 48/48 | 0.9x |
| comm | 453.7 KB | 38.5 KB | ✅ 30/30 | **3.6x** |
| cp | 570.0 KB | 138.5 KB | ✅ 69/69 | **1.1x** |
| csplit | 1.8 MB | 50.5 KB | ✅ 2/2 | - |
| cut | 635.5 KB | 38.5 KB | ⚠️ 97% (96/99) | **5.9x** |
| date | 508.5 KB | 106.5 KB | ✅ 46/46 | 0.8x |
| dd | 502.9 KB | 70.5 KB | ✅ 29/29 | **1.0x** |
| df | 544.5 KB | 87.1 KB | ✅ 25/25 | **1.2x** |
| dir | 612.9 KB | 139.0 KB | ✅ 45/45 | **1.0x** |
| dircolors | 450.2 KB | 46.5 KB | ⚠️ 86% (12/14) | **1.0x** |
| dirname | 426.5 KB | 34.4 KB | ✅ 23/23 | 0.9x |
| du | 511.8 KB | 98.5 KB | ✅ 51/51 | 0.7x |
| echo | 427.0 KB | 34.4 KB | ✅ 53/53 | 0.9x |
| env | 474.7 KB | 46.9 KB | ⚠️ 96% (49/51) | 0.9x |
| expand | 453.5 KB | 34.5 KB | ✅ 35/35 | **14.2x** |
| expr | 1.8 MB | 42.4 KB | ✅ 43/43 | **1.0x** |
| factor | 472.0 KB | 62.5 KB | ⚠️ 93% (55/59) | **2.1x** |
| false | 297.0 KB | 26.3 KB | ✅ 6/6 | <0.1x |
| fmt | 457.4 KB | 38.5 KB | ✅ 22/22 | **1.1x** |
| fold | 450.7 KB | 34.5 KB | ⚠️ 93% (54/58) | **6.9x** |
| groups | 428.5 KB | 34.5 KB | ✅ 28/28 | 0.9x |
| head | 452.0 KB | 42.5 KB | ⚠️ 95% (60/63) | **2.2x** |
| hostid | 424.7 KB | 34.5 KB | ✅ 6/6 | 0.9x |
| id | 435.9 KB | 38.5 KB | ✅ 27/27 | **1.1x** |
| install | 516.6 KB | 142.5 KB | ⚠️ 84% (27/32) | **1.1x** |
| join | 469.3 KB | 50.5 KB | ✅ 37/37 | **1.4x** |
| kill | 454.5 KB | 22.4 KB | ✅ 20/20 | <0.1x |
| link | 430.5 KB | 34.5 KB | ✅ 32/32 | 0.9x |
| ln | 456.4 KB | 54.5 KB | ✅ 33/33 | 0.9x |
| logname | 424.7 KB | 34.5 KB | ✅ 13/13 | 0.8x |
| ls | 616.0 KB | 139.0 KB | ✅ 65/65 | **1.1x** |
| md5sum | 624.7 KB | 38.4 KB | ✅ 30/30 | 0.9x |
| mkdir | 443.0 KB | 74.5 KB | ⚠️ 84% (37/44) | **1.1x** |
| mkfifo | 432.3 KB | 42.5 KB | ✅ 11/11 | **1.5x** |
| mknod | 437.0 KB | 42.5 KB | ✅ 12/12 | **1.0x** |
| mktemp | 443.9 KB | 34.5 KB | ⚠️ 88% (15/17) | 0.9x |
| mv | 474.8 KB | 134.5 KB | ✅ 3/3 | **1.1x** |
| nice | 457.7 KB | 34.5 KB | ⚠️ 94% (32/34) | 0.9x |
| nl | 1.8 MB | 38.6 KB | ⚠️ 97% (60/62) | **5.5x** |
| nohup | 455.9 KB | 34.4 KB | ✅ 11/11 | 0.9x |
| nproc | 444.4 KB | 34.5 KB | ⚠️ 94% (29/31) | 0.9x |
| numfmt | 518.1 KB | 58.5 KB | ⚠️ 94% (31/33) | **1.0x** |
| od | 534.5 KB | 70.5 KB | ✅ 50/50 | **2.5x** |
| paste | 450.4 KB | 38.4 KB | ⚠️ 94% (30/32) | **2.6x** |
| pathchk | 438.7 KB | 34.5 KB | ✅ 22/22 | 0.9x |
| pinky | 768.2 KB | 38.4 KB | ✅ 32/32 | 0.9x |
| pr | 502.0 KB | 70.6 KB | ⚠️ 95% (18/19) | **4.1x** |
| printenv | 428.7 KB | 34.4 KB | ✅ 9/9 | 0.9x |
| printf | 494.2 KB | 54.4 KB | ✅ 74/74 | 0.8x |
| ptx | 533.7 KB | 54.5 KB | ✅ 15/15 | **2.0x** |
| pwd | 429.7 KB | 34.5 KB | ⚠️ 94% (16/17) | 0.1x |
| readlink | 444.2 KB | 42.4 KB | ✅ 60/60 | 0.9x |
| realpath | 445.0 KB | 42.4 KB | ✅ 43/43 | 0.9x |
| rev | 439.3 KB | 14.4 KB | ✅ 32/32 | **23.5x** |
| rm | 532.7 KB | 58.5 KB | ✅ 23/23 | 0.9x |
| rmdir | 431.2 KB | 46.4 KB | ✅ 21/21 | 0.9x |
| runcon | 463.9 KB | 34.5 KB | ⚠️ 40% (2/5) | N/A |
| seq | 546.7 KB | 50.5 KB | ✅ 62/62 | **15.5x** |
| sha1sum | 617.0 KB | 38.4 KB | ✅ 43/43 | 0.8x |
| sha224sum | 617.1 KB | 38.4 KB | ✅ 39/39 | 0.8x |
| sha256sum | 617.9 KB | 38.4 KB | ✅ 34/34 | 0.8x |
| sha384sum | 617.0 KB | 38.4 KB | ✅ 39/39 | 0.9x |
| sha512sum | 617.1 KB | 38.4 KB | ✅ 39/39 | 0.9x |
| shred | 456.9 KB | 54.5 KB | ✅ 27/27 | **2.3x** |
| shuf | 474.5 KB | 46.5 KB | ⚠️ 98% (52/53) | **1.9x** |
| sleep | 444.4 KB | 34.5 KB | ✅ 15/15 | 0.9x |
| sort | 1.1 MB | 102.8 KB | ✅ 111/111 | **12.9x** |
| split | 539.1 KB | 54.9 KB | ✅ 72/72 | **1.1x** |
| stat | 467.4 KB | 86.5 KB | ⚠️ 97% (37/38) | **1.2x** |
| stdbuf | 484.4 KB | 50.5 KB | ✅ 13/13 | 0.9x |
| stty | 454.7 KB | 78.5 KB | ⚠️ 60% (25/42) | N/A |
| sum | 442.5 KB | 34.4 KB | ✅ 23/23 | **1.2x** |
| sync | 430.6 KB | 34.4 KB | ⚠️ 90% (9/10) | 0.9x |
| tac | 1.9 MB | 38.4 KB | ✅ 59/59 | **2.5x** |
| tail | 478.7 KB | 62.5 KB | ✅ 80/80 | **2.0x** |
| tee | 436.3 KB | 38.5 KB | ✅ 27/27 | **1.2x** |
| test | 440.2 KB | 46.4 KB | ✅ 116/116 | <0.1x |
| timeout | 486.9 KB | 38.9 KB | ✅ 36/36 | 0.2x |
| touch | 464.5 KB | 94.5 KB | ⚠️ 94% (45/48) | 0.9x |
| tr | 699.5 KB | 46.5 KB | ✅ 59/59 | **6.8x** |
| true | 296.6 KB | 26.3 KB | ✅ 7/7 | <0.1x |
| truncate | 441.9 KB | 38.5 KB | ⚠️ 94% (46/49) | 0.9x |
| tsort | 460.2 KB | 46.5 KB | ✅ 19/19 | **10.6x** |
| tty | 425.8 KB | 34.5 KB | ✅ 10/10 | 0.9x |
| uname | 428.6 KB | 34.5 KB | ✅ 14/14 | 0.9x |
| unexpand | 453.3 KB | 38.5 KB | ⚠️ 96% (26/27) | **5.0x** |
| uniq | 903.0 KB | 38.5 KB | ⚠️ 99% (85/86) | **11.8x** |
| unlink | 429.4 KB | 34.5 KB | ✅ 30/30 | 0.9x |
| uptime | 501.2 KB | 14.4 KB | ✅ 16/16 | **1.5x** |
| users | 461.2 KB | 34.5 KB | ✅ 6/6 | 0.9x |
| vdir | 612.9 KB | 139.0 KB | ✅ 41/41 | **1.1x** |
| wc | 909.5 KB | 54.5 KB | ✅ 77/77 | **17.0x** |
| who | 785.0 KB | 58.5 KB | ✅ 38/38 | 0.8x |
| whoami | 425.0 KB | 34.5 KB | ✅ 16/16 | 0.8x |
| yes | 430.8 KB | 34.4 KB | ⚠️ 7% (2/29) | **1.2x** |

### Known Issues
- 271 compatibility test failures across 3 platform(s)

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Runs 3911+ compatibility tests comparing output byte-for-byte against GNU coreutils
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

## Platform Functional Tests (v0.15.3)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 3773 | 30 | 108 | ⚠️ |
| Linux ARM64 | 656 | 118 | 30 | ⚠️ |
| macOS ARM64 | 651 | 123 | 30 | ⚠️ |
| Windows x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
