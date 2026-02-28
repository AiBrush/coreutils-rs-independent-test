# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.14.7)

### Summary
- **Tools tracked:** 107 total (107 with binaries)
- **Compatibility:** 3211/3323 tests passed (96.6%) across 102 tools
- **Benchmarked:** 64 tools with performance data
- **Fastest speedup:** rev at 25.0x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
>
> Legend: `-` = no data collected | `N/A` = not applicable | `⏭️ 0 tests` = test ran but produced 0 results

| Tool | fcoreutils size | GNU size | Compat f\* vs GNU | Speedup f\* vs GNU |
|------|----------------:|---------:|------------------:|-------------------:|
| arch | 425.2 KB | 34.5 KB | ✅ 6/6 | 0.9x |
| b2sum | 633.9 KB | 54.5 KB | ✅ 25/25 | - |
| base32 | 444.9 KB | 38.5 KB | ✅ 29/29 | **1.7x** |
| base64 | 558.6 KB | 38.5 KB | ✅ 33/33 | **6.6x** |
| basename | 429.7 KB | 34.5 KB | ✅ 26/26 | 0.9x |
| basenc | 467.8 KB | 46.5 KB | ⚠️ 93% (89/96) | **2.6x** |
| cat | 459.0 KB | 38.5 KB | ⚠️ 94% (46/49) | - |
| chcon | 458.9 KB | 58.5 KB | ⏭️ 0 tests | - |
| chgrp | 524.5 KB | 58.5 KB | ⚠️ 89% (17/19) | **1.0x** |
| chmod | 530.2 KB | 54.5 KB | ⏭️ 0 tests | 0.9x |
| chown | 528.4 KB | 58.5 KB | ⚠️ 85% (17/20) | **1.0x** |
| chroot | 464.7 KB | 38.5 KB | ⚠️ 21% (3/14) | - |
| cksum | 634.8 KB | 102.5 KB | ✅ 48/48 | **1.2x** |
| comm | 453.7 KB | 38.5 KB | ✅ 30/30 | - |
| cp | 566.4 KB | 138.5 KB | ⏭️ 0 tests | **1.2x** |
| csplit | 1.8 MB | 50.5 KB | ⏭️ 0 tests | **17.3x** |
| cut | 635.5 KB | 38.5 KB | ⚠️ 97% (96/99) | **5.9x** |
| date | 508.5 KB | 106.5 KB | ✅ 46/46 | - |
| dd | 502.7 KB | 70.5 KB | ✅ 29/29 | **1.1x** |
| df | 544.5 KB | 87.1 KB | ⚠️ 68% (17/25) | - |
| dir | 591.0 KB | 139.0 KB | ❌ 0% (0/1) | - |
| dircolors | 450.1 KB | 46.5 KB | ✅ 14/14 | - |
| dirname | 426.5 KB | 34.4 KB | ✅ 23/23 | 0.9x |
| du | 511.8 KB | 98.5 KB | ✅ 51/51 | - |
| echo | 427.0 KB | 34.4 KB | ✅ 53/53 | 0.9x |
| env | 474.7 KB | 46.9 KB | ⚠️ 96% (49/51) | 0.9x |
| expand | 453.5 KB | 34.5 KB | ✅ 35/35 | - |
| expr | 1.8 MB | 42.4 KB | ✅ 43/43 | 0.9x |
| factor | 472.0 KB | 62.5 KB | ⚠️ 93% (55/59) | **1.7x** |
| false | 297.0 KB | 26.3 KB | ✅ 6/6 | <0.1x |
| fmt | 457.4 KB | 38.5 KB | ✅ 22/22 | - |
| fold | 450.7 KB | 34.5 KB | ⚠️ 93% (54/58) | - |
| groups | 428.5 KB | 34.5 KB | ✅ 8/8 | 0.9x |
| head | 452.0 KB | 42.5 KB | ⚠️ 95% (60/63) | - |
| hostid | 424.7 KB | 34.5 KB | ✅ 6/6 | 0.9x |
| id | 435.9 KB | 38.5 KB | ✅ 27/27 | **1.1x** |
| install | 516.6 KB | 142.5 KB | ⚠️ 84% (27/32) | **1.1x** |
| join | 469.3 KB | 50.5 KB | ✅ 37/37 | - |
| kill | 454.5 KB | 22.4 KB | ✅ 20/20 | - |
| link | 430.5 KB | 34.5 KB | ✅ 8/8 | 0.9x |
| ln | 456.4 KB | 54.5 KB | ✅ 33/33 | 0.9x |
| logname | 424.7 KB | 34.5 KB | ✅ 3/3 | 0.9x |
| ls | 593.2 KB | 139.0 KB | ✅ 65/65 | - |
| md5sum | 624.7 KB | 38.4 KB | ✅ 30/30 | - |
| mkdir | 443.0 KB | 74.5 KB | ⚠️ 84% (37/44) | **1.0x** |
| mkfifo | 432.3 KB | 42.5 KB | ✅ 11/11 | **1.0x** |
| mknod | 437.0 KB | 42.5 KB | ✅ 12/12 | **1.0x** |
| mktemp | 443.9 KB | 34.5 KB | ⚠️ 88% (15/17) | N/A |
| mv | 474.8 KB | 134.5 KB | ⏭️ 0 tests | **1.0x** |
| nice | 457.7 KB | 34.5 KB | ⚠️ 94% (32/34) | 0.9x |
| nl | 1.8 MB | 38.6 KB | ⚠️ 97% (60/62) | - |
| nohup | 455.9 KB | 34.4 KB | ✅ 11/11 | 0.9x |
| nproc | 444.4 KB | 34.5 KB | ⚠️ 94% (29/31) | 0.9x |
| numfmt | 517.0 KB | 58.5 KB | ⚠️ 94% (31/33) | - |
| od | 534.5 KB | 70.5 KB | ✅ 50/50 | - |
| paste | 450.4 KB | 38.4 KB | ⚠️ 94% (30/32) | - |
| pathchk | 438.7 KB | 34.5 KB | ✅ 22/22 | 0.9x |
| pinky | 768.6 KB | 38.4 KB | ✅ 7/7 | - |
| pr | 502.2 KB | 70.6 KB | ⚠️ 95% (18/19) | - |
| printenv | 428.7 KB | 34.4 KB | ✅ 9/9 | - |
| printf | 495.0 KB | 54.4 KB | ✅ 74/74 | - |
| ptx | 520.6 KB | 54.5 KB | ✅ 15/15 | - |
| pwd | 429.7 KB | 34.5 KB | ⚠️ 94% (16/17) | <0.1x |
| readlink | 444.2 KB | 42.4 KB | ⚠️ 98% (59/60) | 0.9x |
| realpath | 445.0 KB | 42.4 KB | ✅ 43/43 | 0.9x |
| rev | 439.3 KB | 14.4 KB | ✅ 32/32 | **25.0x** |
| rm | 532.7 KB | 58.5 KB | ✅ 23/23 | **1.0x** |
| rmdir | 431.2 KB | 46.4 KB | ✅ 21/21 | **1.0x** |
| runcon | 463.9 KB | 34.5 KB | ⚠️ 40% (2/5) | - |
| seq | 546.7 KB | 50.5 KB | ✅ 62/62 | **15.7x** |
| sha1sum | 617.0 KB | 38.4 KB | ✅ 15/15 | 0.8x |
| sha224sum | 617.1 KB | 38.4 KB | ✅ 10/10 | 0.8x |
| sha256sum | 617.9 KB | 38.4 KB | ✅ 34/34 | - |
| sha384sum | 617.0 KB | 38.4 KB | ✅ 10/10 | 0.9x |
| sha512sum | 617.1 KB | 38.4 KB | ✅ 10/10 | 0.9x |
| shred | 456.9 KB | 54.5 KB | ✅ 27/27 | **2.3x** |
| shuf | 474.5 KB | 46.5 KB | ⚠️ 98% (52/53) | - |
| sleep | 444.4 KB | 34.5 KB | ✅ 15/15 | **1.0x** |
| sort | 1.1 MB | 102.8 KB | ⚠️ 99% (110/111) | **13.0x** |
| split | 538.0 KB | 54.9 KB | ⚠️ 92% (66/72) | **1.0x** |
| stat | 467.4 KB | 86.5 KB | ⚠️ 97% (37/38) | - |
| stdbuf | 484.4 KB | 50.5 KB | ✅ 13/13 | - |
| stty | 454.7 KB | 78.5 KB | ⚠️ 80% (12/15) | - |
| sum | 442.5 KB | 34.4 KB | ✅ 23/23 | **1.2x** |
| sync | 430.6 KB | 34.4 KB | ⚠️ 90% (9/10) | 0.9x |
| tac | 1.9 MB | 38.4 KB | ✅ 59/59 | - |
| tail | 478.0 KB | 62.5 KB | ⚠️ 99% (79/80) | - |
| tee | 436.3 KB | 38.5 KB | ✅ 27/27 | **1.3x** |
| test | 440.5 KB | 46.4 KB | ⚠️ 98% (114/116) | <0.1x |
| timeout | 486.9 KB | 38.9 KB | ✅ 36/36 | - |
| touch | 463.4 KB | 94.5 KB | ⚠️ 92% (44/48) | 0.9x |
| tr | 699.5 KB | 46.5 KB | ✅ 59/59 | **7.7x** |
| true | 296.6 KB | 26.3 KB | ✅ 7/7 | <0.1x |
| truncate | 441.9 KB | 38.5 KB | ⚠️ 94% (46/49) | **1.0x** |
| tsort | 460.2 KB | 46.5 KB | ✅ 19/19 | **10.3x** |
| tty | 425.8 KB | 34.5 KB | ✅ 10/10 | 0.9x |
| uname | 428.6 KB | 34.5 KB | ✅ 14/14 | 0.9x |
| unexpand | 453.3 KB | 38.5 KB | ⚠️ 96% (26/27) | - |
| uniq | 903.0 KB | 38.5 KB | ⚠️ 99% (85/86) | **11.8x** |
| unlink | 429.4 KB | 34.5 KB | ✅ 7/7 | 0.9x |
| uptime | 501.2 KB | 14.4 KB | ✅ 5/5 | - |
| users | 461.2 KB | 34.5 KB | ✅ 6/6 | - |
| vdir | 591.0 KB | 139.0 KB | ❌ 0% (0/1) | - |
| wc | 907.6 KB | 54.5 KB | ⚠️ 99% (76/77) | - |
| who | 782.6 KB | 58.5 KB | ✅ 13/13 | - |
| whoami | 425.0 KB | 34.5 KB | ✅ 4/4 | 0.9x |
| yes | 1.8 KB | 34.4 KB | ⚠️ 86% (25/29) | **4.2x** |

### Known Issues
- 118 compatibility test failures across 2 platform(s)

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Runs 3323+ compatibility tests comparing output byte-for-byte against GNU coreutils
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
