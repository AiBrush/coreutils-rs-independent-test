# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.14.7)

### Summary
- **Tools tracked:** 107 total (107 with binaries)
- **Compatibility:** 0/0 tests passed (0%) across 0 tools
- **Benchmarked:** 0 tools with performance data
- **Fastest speedup:**  at 0.0x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
>
> Legend: `-` = no data collected | `N/A` = not applicable | `⏭️ 0 tests` = test ran but produced 0 results

| Tool | fcoreutils size | GNU size | Compat f\* vs GNU | Speedup f\* vs GNU |
|------|----------------:|---------:|------------------:|-------------------:|
| arch | 425.2 KB | 34.5 KB | - | - |
| b2sum | 633.9 KB | 54.5 KB | - | - |
| base32 | 444.9 KB | 38.5 KB | - | - |
| base64 | 558.6 KB | 38.5 KB | - | - |
| basename | 429.7 KB | 34.5 KB | - | - |
| basenc | 467.8 KB | 46.5 KB | - | - |
| cat | 459.0 KB | 38.5 KB | - | - |
| chcon | 458.9 KB | 58.5 KB | - | - |
| chgrp | 524.5 KB | 58.5 KB | - | - |
| chmod | 530.2 KB | 54.5 KB | - | - |
| chown | 528.4 KB | 58.5 KB | - | - |
| chroot | 464.7 KB | 38.5 KB | - | - |
| cksum | 634.8 KB | 102.5 KB | - | - |
| comm | 453.7 KB | 38.5 KB | - | - |
| cp | 566.4 KB | 138.5 KB | - | - |
| csplit | 1.8 MB | 50.5 KB | - | - |
| cut | 635.5 KB | 38.5 KB | - | - |
| date | 508.5 KB | 106.5 KB | - | - |
| dd | 502.7 KB | 70.5 KB | - | - |
| df | 544.5 KB | 87.1 KB | - | - |
| dir | 591.0 KB | 139.0 KB | - | - |
| dircolors | 450.1 KB | 46.5 KB | - | - |
| dirname | 426.5 KB | 34.4 KB | - | - |
| du | 511.8 KB | 98.5 KB | - | - |
| echo | 427.0 KB | 34.4 KB | - | - |
| env | 474.7 KB | 46.9 KB | - | - |
| expand | 453.5 KB | 34.5 KB | - | - |
| expr | 1.8 MB | 42.4 KB | - | - |
| factor | 472.0 KB | 62.5 KB | - | - |
| false | 297.0 KB | 26.3 KB | - | - |
| fmt | 457.4 KB | 38.5 KB | - | - |
| fold | 450.7 KB | 34.5 KB | - | - |
| groups | 428.5 KB | 34.5 KB | - | - |
| head | 452.0 KB | 42.5 KB | - | - |
| hostid | 424.7 KB | 34.5 KB | - | - |
| id | 435.9 KB | 38.5 KB | - | - |
| install | 516.6 KB | 142.5 KB | - | - |
| join | 469.3 KB | 50.5 KB | - | - |
| kill | 454.5 KB | 22.4 KB | - | - |
| link | 430.5 KB | 34.5 KB | - | - |
| ln | 456.4 KB | 54.5 KB | - | - |
| logname | 424.7 KB | 34.5 KB | - | - |
| ls | 593.2 KB | 139.0 KB | - | - |
| md5sum | 624.7 KB | 38.4 KB | - | - |
| mkdir | 443.0 KB | 74.5 KB | - | - |
| mkfifo | 432.3 KB | 42.5 KB | - | - |
| mknod | 437.0 KB | 42.5 KB | - | - |
| mktemp | 443.9 KB | 34.5 KB | - | - |
| mv | 474.8 KB | 134.5 KB | - | - |
| nice | 457.7 KB | 34.5 KB | - | - |
| nl | 1.8 MB | 38.6 KB | - | - |
| nohup | 455.9 KB | 34.4 KB | - | - |
| nproc | 444.4 KB | 34.5 KB | - | - |
| numfmt | 517.0 KB | 58.5 KB | - | - |
| od | 534.5 KB | 70.5 KB | - | - |
| paste | 450.4 KB | 38.4 KB | - | - |
| pathchk | 438.7 KB | 34.5 KB | - | - |
| pinky | 768.6 KB | 38.4 KB | - | - |
| pr | 502.2 KB | 70.6 KB | - | - |
| printenv | 428.7 KB | 34.4 KB | - | - |
| printf | 495.0 KB | 54.4 KB | - | - |
| ptx | 520.6 KB | 54.5 KB | - | - |
| pwd | 429.7 KB | 34.5 KB | - | - |
| readlink | 444.2 KB | 42.4 KB | - | - |
| realpath | 445.0 KB | 42.4 KB | - | - |
| rev | 439.3 KB | 14.4 KB | - | - |
| rm | 532.7 KB | 58.5 KB | - | - |
| rmdir | 431.2 KB | 46.4 KB | - | - |
| runcon | 463.9 KB | 34.5 KB | - | - |
| seq | 546.7 KB | 50.5 KB | - | - |
| sha1sum | 617.0 KB | 38.4 KB | - | - |
| sha224sum | 617.1 KB | 38.4 KB | - | - |
| sha256sum | 617.9 KB | 38.4 KB | - | - |
| sha384sum | 617.0 KB | 38.4 KB | - | - |
| sha512sum | 617.1 KB | 38.4 KB | - | - |
| shred | 456.9 KB | 54.5 KB | - | - |
| shuf | 474.5 KB | 46.5 KB | - | - |
| sleep | 444.4 KB | 34.5 KB | - | - |
| sort | 1.1 MB | 102.8 KB | - | - |
| split | 538.0 KB | 54.9 KB | - | - |
| stat | 467.4 KB | 86.5 KB | - | - |
| stdbuf | 484.4 KB | 50.5 KB | - | - |
| stty | 454.7 KB | 78.5 KB | - | - |
| sum | 442.5 KB | 34.4 KB | - | - |
| sync | 430.6 KB | 34.4 KB | - | - |
| tac | 1.9 MB | 38.4 KB | - | - |
| tail | 478.0 KB | 62.5 KB | - | - |
| tee | 436.3 KB | 38.5 KB | - | - |
| test | 440.5 KB | 46.4 KB | - | - |
| timeout | 486.9 KB | 38.9 KB | - | - |
| touch | 463.4 KB | 94.5 KB | - | - |
| tr | 699.5 KB | 46.5 KB | - | - |
| true | 296.6 KB | 26.3 KB | - | - |
| truncate | 441.9 KB | 38.5 KB | - | - |
| tsort | 460.2 KB | 46.5 KB | - | - |
| tty | 425.8 KB | 34.5 KB | - | - |
| uname | 428.6 KB | 34.5 KB | - | - |
| unexpand | 453.3 KB | 38.5 KB | - | - |
| uniq | 903.0 KB | 38.5 KB | - | - |
| unlink | 429.4 KB | 34.5 KB | - | - |
| uptime | 501.2 KB | 14.4 KB | - | - |
| users | 461.2 KB | 34.5 KB | - | - |
| vdir | 591.0 KB | 139.0 KB | - | - |
| wc | 907.6 KB | 54.5 KB | - | - |
| who | 782.6 KB | 58.5 KB | - | - |
| whoami | 425.0 KB | 34.5 KB | - | - |
| yes | 1.8 KB | 34.4 KB | - | - |

### Known Issues
- 83 compatibility test failures across 1 platform(s)

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Runs 0+ compatibility tests comparing output byte-for-byte against GNU coreutils
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

## Platform Functional Tests (v0.14.7)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Linux ARM64 | 358 | 83 | 3 | ⚠️ |
| macOS ARM64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
