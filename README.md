# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.18.4)

### Summary
- **Tools tracked:** 107 total (107 with binaries)
- **Compatibility:** 899/934 tests passed (96.3%) across 28 tools
- **Benchmarked:** 0 tools with performance data
- **Fastest speedup:**  at 0.0x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
>
> Legend: `-` = no data collected | `N/A` = not applicable | `⏭️ 0 tests` = test ran but produced 0 results

| Tool | fcoreutils size | GNU size | Compat f\* vs GNU | Speedup f\* vs GNU |
|------|----------------:|---------:|------------------:|-------------------:|
| arch | 425.7 KB | 34.5 KB | - | - |
| b2sum | 633.8 KB | 54.5 KB | ✅ 25/25 | - |
| base32 | 447.1 KB | 38.5 KB | ✅ 29/29 | - |
| base64 | 552.1 KB | 38.5 KB | ✅ 33/33 | - |
| basename | 430.3 KB | 34.5 KB | ✅ 26/26 | - |
| basenc | 466.9 KB | 46.5 KB | - | - |
| cat | 476.0 KB | 38.5 KB | ✅ 49/49 | - |
| chcon | 459.3 KB | 58.5 KB | - | - |
| chgrp | 524.4 KB | 58.5 KB | - | - |
| chmod | 529.8 KB | 54.5 KB | ⚠️ 99% (78/79) | - |
| chown | 528.7 KB | 58.5 KB | ⚠️ 85% (17/20) | - |
| chroot | 465.6 KB | 38.5 KB | ⚠️ 47% (18/38) | - |
| cksum | 713.7 KB | 102.5 KB | ✅ 48/48 | - |
| comm | 456.1 KB | 38.5 KB | ✅ 30/30 | - |
| cp | 571.4 KB | 138.5 KB | ✅ 69/69 | - |
| csplit | 1.8 MB | 50.5 KB | ✅ 2/2 | - |
| cut | 626.1 KB | 38.5 KB | - | - |
| date | 509.1 KB | 106.5 KB | ✅ 46/46 | - |
| dd | 503.9 KB | 70.5 KB | - | - |
| df | 542.5 KB | 87.1 KB | ✅ 25/25 | - |
| dir | 614.7 KB | 139.0 KB | - | - |
| dircolors | 450.0 KB | 46.5 KB | ✅ 14/14 | - |
| dirname | 426.9 KB | 34.4 KB | - | - |
| du | 512.9 KB | 98.5 KB | ✅ 51/51 | - |
| echo | 427.5 KB | 34.4 KB | ✅ 53/53 | - |
| env | 476.2 KB | 46.9 KB | - | - |
| expand | 533.6 KB | 34.5 KB | - | - |
| expr | 1.8 MB | 42.4 KB | ✅ 43/43 | - |
| factor | 473.0 KB | 62.5 KB | - | - |
| false | 297.3 KB | 26.3 KB | ✅ 6/6 | - |
| fmt | 465.6 KB | 38.5 KB | ✅ 22/22 | - |
| fold | 543.1 KB | 34.5 KB | ⚠️ 93% (54/58) | - |
| groups | 429.0 KB | 34.5 KB | - | - |
| head | 457.5 KB | 42.5 KB | - | - |
| hostid | 425.2 KB | 34.5 KB | ✅ 6/6 | - |
| id | 436.2 KB | 38.5 KB | - | - |
| install | 520.7 KB | 142.5 KB | - | - |
| join | 471.5 KB | 50.5 KB | - | - |
| kill | 452.5 KB | 22.4 KB | ✅ 20/20 | - |
| link | 431.1 KB | 34.5 KB | ✅ 32/32 | - |
| ln | 457.2 KB | 54.5 KB | ✅ 33/33 | - |
| logname | 425.2 KB | 34.5 KB | - | - |
| ls | 618.0 KB | 139.0 KB | - | - |
| md5sum | 682.9 KB | 38.4 KB | - | - |
| mkdir | 445.9 KB | 74.5 KB | ⚠️ 84% (37/44) | - |
| mkfifo | 432.9 KB | 42.5 KB | ✅ 11/11 | - |
| mknod | 437.7 KB | 42.5 KB | - | - |
| mktemp | 447.0 KB | 34.5 KB | - | - |
| mv | 477.3 KB | 134.5 KB | - | - |
| nice | 457.2 KB | 34.5 KB | - | - |
| nl | 1.8 MB | 38.6 KB | - | - |
| nohup | 456.6 KB | 34.4 KB | - | - |
| nproc | 443.1 KB | 34.5 KB | - | - |
| numfmt | 528.2 KB | 58.5 KB | - | - |
| od | 536.3 KB | 70.5 KB | - | - |
| paste | 453.5 KB | 38.4 KB | - | - |
| pathchk | 438.8 KB | 34.5 KB | ✅ 22/22 | - |
| pinky | 483.0 KB | 38.4 KB | - | - |
| pr | 511.0 KB | 70.6 KB | - | - |
| printenv | 429.4 KB | 34.4 KB | - | - |
| printf | 495.5 KB | 54.4 KB | - | - |
| ptx | 534.3 KB | 54.5 KB | - | - |
| pwd | 430.4 KB | 34.5 KB | - | - |
| readlink | 443.5 KB | 42.4 KB | - | - |
| realpath | 445.3 KB | 42.4 KB | - | - |
| rev | 439.9 KB | 14.4 KB | - | - |
| rm | 532.0 KB | 58.5 KB | - | - |
| rmdir | 431.8 KB | 46.4 KB | - | - |
| runcon | 465.0 KB | 34.5 KB | - | - |
| seq | 546.1 KB | 50.5 KB | - | - |
| sha1sum | 687.2 KB | 38.4 KB | - | - |
| sha224sum | 679.9 KB | 38.4 KB | - | - |
| sha256sum | 682.4 KB | 38.4 KB | - | - |
| sha384sum | 685.2 KB | 38.4 KB | - | - |
| sha512sum | 685.1 KB | 38.4 KB | - | - |
| shred | 457.4 KB | 54.5 KB | - | - |
| shuf | 487.7 KB | 46.5 KB | - | - |
| sleep | 445.1 KB | 34.5 KB | - | - |
| sort | 1.1 MB | 102.8 KB | - | - |
| split | 616.0 KB | 54.9 KB | - | - |
| stat | 464.2 KB | 86.5 KB | - | - |
| stdbuf | 487.0 KB | 50.5 KB | - | - |
| stty | 455.2 KB | 78.5 KB | - | - |
| sum | 442.2 KB | 34.4 KB | - | - |
| sync | 431.2 KB | 34.4 KB | - | - |
| tac | 1.8 MB | 38.4 KB | - | - |
| tail | 488.3 KB | 62.5 KB | - | - |
| tee | 436.9 KB | 38.5 KB | - | - |
| test | 440.6 KB | 46.4 KB | - | - |
| timeout | 487.4 KB | 38.9 KB | - | - |
| touch | 461.0 KB | 94.5 KB | - | - |
| tr | 560.3 KB | 46.5 KB | - | - |
| true | 296.9 KB | 26.3 KB | - | - |
| truncate | 442.5 KB | 38.5 KB | - | - |
| tsort | 460.9 KB | 46.5 KB | - | - |
| tty | 425.4 KB | 34.5 KB | - | - |
| uname | 429.4 KB | 34.5 KB | - | - |
| unexpand | 471.8 KB | 38.5 KB | - | - |
| uniq | 907.2 KB | 38.5 KB | - | - |
| unlink | 430.0 KB | 34.5 KB | - | - |
| uptime | 501.9 KB | 14.4 KB | - | - |
| users | 462.4 KB | 34.5 KB | - | - |
| vdir | 614.7 KB | 139.0 KB | - | - |
| wc | 909.7 KB | 54.5 KB | - | - |
| who | 492.1 KB | 58.5 KB | - | - |
| whoami | 423.9 KB | 34.5 KB | - | - |
| yes | 432.4 KB | 34.4 KB | - | - |

### Known Issues
- No known issues

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Runs 934+ compatibility tests comparing output byte-for-byte against GNU coreutils
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

## Platform Functional Tests (v0.18.4)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 899 | 0 | 35 | ✅ |
| Linux ARM64 | — | — | — | ⏭️ missing |
| macOS ARM64 | — | — | — | ⏭️ missing |
| Windows x86_64 | — | — | — | ⏭️ missing |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
