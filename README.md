# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.22.4)

### Summary
- **Tools tracked:** 107 total (107 with binaries)
- **Compatibility:** 3806/3911 tests passed (97.3%) across 107 tools
- **Benchmarked:** 101 tools with performance data
- **Fastest speedup:** unexpand at 40.5x faster than GNU

### Assembly (x86-64 nasm) Summary
- **Assembly tools:** 30 tools (static ELF binaries, no libc)
- **GNU compat tests:** 2842 passed, 0 failed
- **Security tests:** 8974/9158 passed (98.0%)
- **Tools:** arch, base64, cat, cut, echo, expand, false, fold, head, hostid, logname, md5sum, nl, od, pwd, rev, seq, sleep, sort, sync, tac, tail, tr, true, tty, unexpand, uniq, wc, whoami, yes

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
>
> Legend: `-` = no data collected | `N/A` = not applicable | `⏭️ 0 tests` = test ran but produced 0 results
> ASM columns only shown for tools with x86-64 assembly implementations.

| Tool | fcoreutils size | GNU size | Compat f\* vs GNU | Speedup f\* vs GNU | ASM size | ASM vs GNU | ASM Compat | ASM Security |
|------|----------------:|---------:|------------------:|-------------------:|---------:|-----------:|-----------:|-------------:|
| arch | 425.7 KB | 34.5 KB | ✅ 17/17 | 0.9x | 13.5 KB | - | ✅ 12/12 | ⚠️ 97% |
| b2sum | 633.8 KB | 54.5 KB | ✅ 25/25 | **1.3x** | - | - | - | - |
| base32 | 452.1 KB | 38.5 KB | ✅ 29/29 | **1.8x** | - | - | - | - |
| base64 | 551.8 KB | 38.5 KB | ✅ 33/33 | **6.8x** | 5.7 KB | **1.7x** | ✅ 17/17 | ✅ 109/109 |
| basename | 430.3 KB | 34.5 KB | ✅ 26/26 | 0.9x | - | - | - | - |
| basenc | 471.2 KB | 46.5 KB | ⚠️ 99% (95/96) | **2.6x** | - | - | - | - |
| cat | 476.0 KB | 38.5 KB | ✅ 49/49 | **1.9x** | 3.4 KB | **3.8x** | ✅ 65/65 | ⚠️ 98% |
| chcon | 459.3 KB | 58.5 KB | ⚠️ 62% (15/24) | N/A | - | - | - | - |
| chgrp | 524.4 KB | 58.5 KB | ⚠️ 89% (17/19) | **1.0x** | - | - | - | - |
| chmod | 529.8 KB | 54.5 KB | ⚠️ 99% (78/79) | - | - | - | - | - |
| chown | 528.7 KB | 58.5 KB | ⚠️ 85% (17/20) | **1.0x** | - | - | - | - |
| chroot | 465.6 KB | 38.5 KB | ⚠️ 47% (18/38) | N/A | - | - | - | - |
| cksum | 714.0 KB | 102.5 KB | ✅ 48/48 | **1.3x** | - | - | - | - |
| comm | 456.2 KB | 38.5 KB | ✅ 30/30 | **6.9x** | - | - | - | - |
| cp | 571.4 KB | 138.5 KB | ✅ 69/69 | **1.1x** | - | - | - | - |
| csplit | 1.1 MB | 50.5 KB | ✅ 2/2 | - | - | - | - | - |
| cut | 631.4 KB | 38.5 KB | ⚠️ 97% (96/99) | **7.7x** | 9.3 KB | **4.1x** | ✅ 24/24 | ✅ 91/91 |
| date | 509.1 KB | 106.5 KB | ✅ 46/46 | 0.9x | - | - | - | - |
| dd | 503.9 KB | 70.5 KB | ✅ 29/29 | **1.1x** | - | - | - | - |
| df | 542.5 KB | 87.1 KB | ✅ 25/25 | **1.2x** | - | - | - | - |
| dir | 614.7 KB | 139.0 KB | ✅ 45/45 | **1.0x** | - | - | - | - |
| dircolors | 450.0 KB | 46.5 KB | ✅ 14/14 | 0.8x | - | - | - | - |
| dirname | 426.9 KB | 34.4 KB | ✅ 23/23 | **1.0x** | - | - | - | - |
| du | 512.9 KB | 98.5 KB | ✅ 51/51 | 0.9x | - | - | - | - |
| echo | 427.5 KB | 34.4 KB | ✅ 53/53 | 0.9x | 2.9 KB | 0.1x | ✅ 57/57 | ⚠️ 98% |
| env | 476.2 KB | 46.9 KB | ⚠️ 96% (49/51) | **1.0x** | - | - | - | - |
| expand | 533.0 KB | 34.5 KB | ✅ 35/35 | **10.5x** | 4.9 KB | **5.5x** | ✅ 60/60 | ✅ 106/106 |
| expr | 1.1 MB | 42.4 KB | ✅ 43/43 | **1.5x** | - | - | - | - |
| factor | 473.1 KB | 62.5 KB | ⚠️ 93% (55/59) | **2.3x** | - | - | - | - |
| false | 297.3 KB | 26.3 KB | ✅ 6/6 | 0.8x | 188 B | - | ✅ 20/20 | ⚠️ 98% |
| fmt | 465.5 KB | 38.5 KB | ✅ 22/22 | **1.3x** | - | - | - | - |
| fold | 543.1 KB | 34.5 KB | ⚠️ 98% (57/58) | **8.9x** | 4.3 KB | **1.8x** | ✅ 58/58 | ✅ 90/90 |
| groups | 429.0 KB | 34.5 KB | ✅ 28/28 | 0.9x | - | - | - | - |
| head | 457.6 KB | 42.5 KB | ⚠️ 95% (60/63) | **2.3x** | 7.2 KB | **2.9x** | ✅ 19/19 | ✅ 89/89 |
| hostid | 425.2 KB | 34.5 KB | ✅ 6/6 | 0.8x | 2.5 KB | - | ✅ 6/6 | ⚠️ 97% |
| id | 436.2 KB | 38.5 KB | ✅ 27/27 | **1.1x** | - | - | - | - |
| install | 520.7 KB | 142.5 KB | ⚠️ 84% (27/32) | **1.1x** | - | - | - | - |
| join | 471.5 KB | 50.5 KB | ✅ 37/37 | **1.2x** | - | - | - | - |
| kill | 452.5 KB | 22.4 KB | ✅ 20/20 | 0.9x | - | - | - | - |
| link | 431.1 KB | 34.5 KB | ✅ 32/32 | 0.9x | - | - | - | - |
| ln | 457.2 KB | 54.5 KB | ✅ 33/33 | **1.0x** | - | - | - | - |
| logname | 425.2 KB | 34.5 KB | ✅ 13/13 | 0.9x | 2.6 KB | - | ✅ 9/9 | ⚠️ 97% |
| ls | 618.0 KB | 139.0 KB | ✅ 65/65 | **1.1x** | - | - | - | - |
| md5sum | 683.1 KB | 38.4 KB | ✅ 30/30 | **1.0x** | 9.6 KB | 0.7x | ✅ 16/16 | ✅ 119/119 |
| mkdir | 445.9 KB | 74.5 KB | ⚠️ 84% (37/44) | **1.1x** | - | - | - | - |
| mkfifo | 432.9 KB | 42.5 KB | ✅ 11/11 | **1.0x** | - | - | - | - |
| mknod | 437.7 KB | 42.5 KB | ✅ 12/12 | **1.0x** | - | - | - | - |
| mktemp | 447.0 KB | 34.5 KB | ⚠️ 88% (15/17) | 0.9x | - | - | - | - |
| mv | 477.3 KB | 134.5 KB | ✅ 3/3 | **1.0x** | - | - | - | - |
| nice | 457.2 KB | 34.5 KB | ⚠️ 94% (32/34) | **1.0x** | - | - | - | - |
| nl | 1.1 MB | 38.6 KB | ⚠️ 98% (61/62) | **11.2x** | 10.1 KB | **5.0x** | ✅ 69/69 | ✅ 101/101 |
| nohup | 456.6 KB | 34.4 KB | ✅ 11/11 | **1.0x** | - | - | - | - |
| nproc | 443.1 KB | 34.5 KB | ⚠️ 94% (29/31) | 0.8x | - | - | - | - |
| numfmt | 528.3 KB | 58.5 KB | ⚠️ 97% (32/33) | **1.0x** | - | - | - | - |
| od | 536.2 KB | 70.5 KB | ✅ 50/50 | **11.0x** | 13.4 KB | **10.0x** | ✅ 58/58 | ✅ 104/104 |
| paste | 455.5 KB | 38.4 KB | ✅ 32/32 | **3.9x** | - | - | - | - |
| pathchk | 438.8 KB | 34.5 KB | ✅ 22/22 | 0.9x | - | - | - | - |
| pinky | 483.0 KB | 38.4 KB | ✅ 32/32 | 0.9x | - | - | - | - |
| pr | 515.7 KB | 70.6 KB | ⚠️ 95% (18/19) | **8.3x** | - | - | - | - |
| printenv | 429.4 KB | 34.4 KB | ✅ 9/9 | 0.9x | - | - | - | - |
| printf | 501.4 KB | 54.4 KB | ✅ 74/74 | 0.9x | - | - | - | - |
| ptx | 534.3 KB | 54.5 KB | ✅ 15/15 | **2.0x** | - | - | - | - |
| pwd | 430.4 KB | 34.5 KB | ⚠️ 94% (16/17) | 0.9x | 2.7 KB | - | ✅ 14/14 | ⚠️ 97% |
| readlink | 443.5 KB | 42.4 KB | ✅ 60/60 | **1.0x** | - | - | - | - |
| realpath | 445.3 KB | 42.4 KB | ✅ 43/43 | 0.9x | - | - | - | - |
| rev | 439.8 KB | 14.4 KB | ✅ 32/32 | **20.8x** | 2.6 KB | **9.9x** | ✅ 15/15 | ✅ 89/89 |
| rm | 532.0 KB | 58.5 KB | ✅ 23/23 | **1.0x** | - | - | - | - |
| rmdir | 431.8 KB | 46.4 KB | ✅ 21/21 | 0.9x | - | - | - | - |
| runcon | 465.0 KB | 34.5 KB | ⚠️ 40% (2/5) | N/A | - | - | - | - |
| seq | 546.1 KB | 50.5 KB | ✅ 62/62 | **19.8x** | 10.8 KB | **19.5x** | ✅ 50/50 | ⚠️ 98% |
| sha1sum | 687.5 KB | 38.4 KB | ✅ 43/43 | **1.1x** | - | - | - | - |
| sha224sum | 680.2 KB | 38.4 KB | ✅ 39/39 | **1.1x** | - | - | - | - |
| sha256sum | 682.7 KB | 38.4 KB | ✅ 34/34 | **1.2x** | - | - | - | - |
| sha384sum | 685.4 KB | 38.4 KB | ✅ 39/39 | **1.1x** | - | - | - | - |
| sha512sum | 685.4 KB | 38.4 KB | ✅ 39/39 | 0.9x | - | - | - | - |
| shred | 457.4 KB | 54.5 KB | ✅ 27/27 | **2.1x** | - | - | - | - |
| shuf | 516.7 KB | 46.5 KB | ⚠️ 98% (52/53) | **5.1x** | - | - | - | - |
| sleep | 445.1 KB | 34.5 KB | ✅ 15/15 | 0.9x | 2.6 KB | - | ✅ 17/17 | ⚠️ 98% |
| sort | 1.1 MB | 102.8 KB | ✅ 111/111 | **13.6x** | 12.0 KB | **1.3x** | ✅ 46/46 | ✅ 105/105 |
| split | 616.5 KB | 54.9 KB | ✅ 72/72 | **1.4x** | - | - | - | - |
| stat | 464.2 KB | 86.5 KB | ✅ 38/38 | **1.1x** | - | - | - | - |
| stdbuf | 487.0 KB | 50.5 KB | ✅ 13/13 | 0.9x | - | - | - | - |
| stty | 455.2 KB | 78.5 KB | ⚠️ 60% (25/42) | N/A | - | - | - | - |
| sum | 442.2 KB | 34.4 KB | ✅ 23/23 | **1.2x** | - | - | - | - |
| sync | 431.2 KB | 34.4 KB | ⚠️ 90% (9/10) | 0.9x | 3.1 KB | - | ✅ 16/16 | ⚠️ 97% |
| tac | 1.1 MB | 38.4 KB | ✅ 59/59 | **3.0x** | 4.6 KB | **2.1x** | ✅ 13/13 | ✅ 86/86 |
| tail | 488.3 KB | 62.5 KB | ✅ 80/80 | **2.7x** | 7.5 KB | **3.0x** | ✅ 18/18 | ✅ 90/90 |
| tee | 436.7 KB | 38.5 KB | ✅ 27/27 | **1.2x** | - | - | - | - |
| test | 440.6 KB | 46.4 KB | ✅ 116/116 | **1.0x** | - | - | - | - |
| timeout | 487.4 KB | 38.9 KB | ✅ 36/36 | 0.9x | - | - | - | - |
| touch | 461.0 KB | 94.5 KB | ⚠️ 94% (45/48) | 0.9x | - | - | - | - |
| tr | 547.2 KB | 46.5 KB | ✅ 59/59 | **8.6x** | 9.8 KB | **2.1x** | ✅ 20/20 | ✅ 91/91 |
| true | 296.9 KB | 26.3 KB | ✅ 7/7 | 0.7x | 1.2 KB | - | ✅ 9/9 | ⚠️ 98% |
| truncate | 442.5 KB | 38.5 KB | ⚠️ 94% (46/49) | 0.9x | - | - | - | - |
| tsort | 461.0 KB | 46.5 KB | ✅ 19/19 | **10.3x** | - | - | - | - |
| tty | 425.4 KB | 34.5 KB | ✅ 10/10 | 0.9x | 2.0 KB | - | ✅ 16/16 | ⚠️ 98% |
| uname | 429.4 KB | 34.5 KB | ✅ 14/14 | **1.1x** | - | - | - | - |
| unexpand | 471.7 KB | 38.5 KB | ⚠️ 96% (26/27) | **40.5x** | 7.4 KB | **3.0x** | ✅ 57/57 | ✅ 104/104 |
| uniq | 621.7 KB | 38.5 KB | ⚠️ 99% (85/86) | **12.0x** | 11.7 KB | **5.1x** | ✅ 72/72 | ✅ 99/99 |
| unlink | 430.0 KB | 34.5 KB | ✅ 30/30 | **1.0x** | - | - | - | - |
| uptime | 501.9 KB | 14.4 KB | ✅ 16/16 | **1.5x** | - | - | - | - |
| users | 462.4 KB | 34.5 KB | ✅ 6/6 | 0.8x | - | - | - | - |
| vdir | 614.7 KB | 139.0 KB | ✅ 41/41 | **1.1x** | - | - | - | - |
| wc | 629.2 KB | 54.5 KB | ✅ 77/77 | **21.4x** | 9.6 KB | **1.5x** | ✅ 23/23 | ✅ 95/95 |
| who | 492.9 KB | 58.5 KB | ✅ 38/38 | **1.0x** | - | - | - | - |
| whoami | 423.9 KB | 34.5 KB | ✅ 16/16 | 0.9x | 2.2 KB | - | ✅ 4/4 | ⚠️ 98% |
| yes | 433.5 KB | 34.4 KB | ⚠️ 86% (25/29) | **1.4x** | 1.8 KB | 0.9x | - | - |

### Known Issues
- 246 compatibility test failures across 3 platform(s)

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
- Builds and tests x86-64 assembly implementations (nasm) for 30 tools
- Tests run across multiple platforms via GitHub Actions

## Running Locally
```bash
# Install and test (Rust)
./scripts/install_from_github.sh
./tests/compatibility/run_all.sh
./tests/benchmarks/run_all.sh

# Install and test (Assembly — Linux x86-64 only)
./scripts/install_assembly.sh
./tests/assembly/run_all.sh --repo-dir /path/to/fcoreutils --asm-dir ~/.local/bin/asm
./tests/assembly/bench_all.sh

# Generate chart
pip install matplotlib
python3 scripts/plot_speedup.py
```

## Platform Functional Tests (v0.22.4)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 3806 | 5 | 100 | ⚠️ |
| Linux ARM64 | 656 | 118 | 30 | ⚠️ |
| macOS ARM64 | 651 | 123 | 30 | ⚠️ |
| Windows x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
