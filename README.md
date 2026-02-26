# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.13.3)

### Summary
- **Tools tracked:** 107 total
- **Compatibility:** 0/0 tests passed (0%)
- **Fastest speedup:** rev at 23.5x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | fcoreutils size | GNU size | Compat f\* vs GNU | Speedup f\* vs GNU |
|------|----------------:|----------:|------------------:|-------------------:|
| arch | 424.9 KB | 34.5 KB | - | **0.9x** |
| b2sum | 633.9 KB | 54.5 KB | - | - |
| base32 | 444.4 KB | 38.5 KB | - | **1.6x** |
| base64 | 558.6 KB | 38.5 KB | - | **6.8x** |
| basename | 429.7 KB | 34.5 KB | - | **0.9x** |
| basenc | 458.9 KB | 46.5 KB | - | **1.4x** |
| cat | 459.0 KB | 38.5 KB | - | - |
| chcon | 458.9 KB | 58.5 KB | - | - |
| chgrp | 523.9 KB | 58.5 KB | - | **1.0x** |
| chmod | 525.5 KB | 54.5 KB | - | **1.0x** |
| chown | 528.4 KB | 58.5 KB | - | **1.0x** |
| chroot | 464.7 KB | 38.5 KB | - | - |
| cksum | 450.5 KB | 102.5 KB | - | **1.3x** |
| comm | 453.7 KB | 38.5 KB | - | - |
| cp | 562.3 KB | 138.5 KB | - | **1.2x** |
| csplit | 1.8 MB | 50.5 KB | - | **19.2x** |
| cut | 635.1 KB | 38.5 KB | - | **5.7x** |
| date | 505.2 KB | 106.5 KB | - | - |
| dd | 500.0 KB | 70.5 KB | - | **1.0x** |
| df | 540.2 KB | 87.1 KB | - | - |
| dir | 585.5 KB | 139.0 KB | - | - |
| dircolors | 450.1 KB | 46.5 KB | - | - |
| dirname | 426.5 KB | 34.4 KB | - | **0.9x** |
| du | 510.9 KB | 98.5 KB | - | - |
| echo | 426.4 KB | 34.4 KB | - | **0.9x** |
| env | 467.4 KB | 46.9 KB | - | **0.9x** |
| expand | 453.5 KB | 34.5 KB | - | - |
| expr | 1.8 MB | 42.4 KB | - | **0.9x** |
| factor | 453.0 KB | 62.5 KB | - | **1.0x** |
| false | 297.0 KB | 26.3 KB | - | - |
| fmt | 457.9 KB | 38.5 KB | - | - |
| fold | 450.7 KB | 34.5 KB | - | - |
| groups | 428.5 KB | 34.5 KB | - | **0.9x** |
| head | 451.9 KB | 42.5 KB | - | - |
| hostid | 424.7 KB | 34.5 KB | - | **0.9x** |
| id | 433.1 KB | 38.5 KB | - | **1.1x** |
| install | 513.4 KB | 142.5 KB | - | **1.1x** |
| join | 469.3 KB | 50.5 KB | - | - |
| kill | 453.2 KB | 22.4 KB | - | - |
| link | 430.5 KB | 34.5 KB | - | **0.9x** |
| ln | 451.7 KB | 54.5 KB | - | **0.9x** |
| logname | 424.7 KB | 34.5 KB | - | **0.9x** |
| ls | 586.9 KB | 139.0 KB | - | - |
| md5sum | 626.8 KB | 38.4 KB | - | - |
| mkdir | 442.5 KB | 74.5 KB | - | **1.0x** |
| mkfifo | 432.3 KB | 42.5 KB | - | **1.0x** |
| mknod | 434.4 KB | 42.5 KB | - | **1.1x** |
| mktemp | 443.9 KB | 34.5 KB | - | - |
| mv | 474.8 KB | 134.5 KB | - | **1.0x** |
| nice | 457.5 KB | 34.5 KB | - | **1.0x** |
| nl | 1.8 MB | 38.6 KB | - | - |
| nohup | 455.6 KB | 34.4 KB | - | **1.0x** |
| nproc | 444.0 KB | 34.5 KB | - | **0.9x** |
| numfmt | 517.0 KB | 58.5 KB | - | - |
| od | 527.7 KB | 70.5 KB | - | - |
| paste | 450.4 KB | 38.4 KB | - | - |
| pathchk | 438.7 KB | 34.5 KB | - | **0.9x** |
| pinky | 768.6 KB | 38.4 KB | - | - |
| pr | 502.2 KB | 70.6 KB | - | - |
| printenv | 428.4 KB | 34.4 KB | - | - |
| printf | 493.3 KB | 54.4 KB | - | - |
| ptx | 525.9 KB | 54.5 KB | - | - |
| pwd | 429.2 KB | 34.5 KB | - | **0.1x** |
| readlink | 439.2 KB | 42.4 KB | - | **0.9x** |
| realpath | 443.5 KB | 42.4 KB | - | **0.9x** |
| rev | 439.3 KB | 14.4 KB | - | **23.5x** |
| rm | 522.7 KB | 58.5 KB | - | **1.0x** |
| rmdir | 431.0 KB | 46.4 KB | - | **0.9x** |
| runcon | 463.9 KB | 34.5 KB | - | - |
| seq | 486.6 KB | 50.5 KB | - | **15.5x** |
| sha1sum | 616.9 KB | 38.4 KB | - | **0.9x** |
| sha224sum | 617.0 KB | 38.4 KB | - | **0.9x** |
| sha256sum | 617.8 KB | 38.4 KB | - | - |
| sha384sum | 616.9 KB | 38.4 KB | - | **0.9x** |
| sha512sum | 617.0 KB | 38.4 KB | - | **0.9x** |
| shred | 456.5 KB | 54.5 KB | - | **1.9x** |
| shuf | 470.0 KB | 46.5 KB | - | - |
| sleep | 444.4 KB | 34.5 KB | - | **1.0x** |
| sort | 1.0 MB | 102.8 KB | - | **13.6x** |
| split | 524.7 KB | 54.9 KB | - | **1.0x** |
| stat | 465.5 KB | 86.5 KB | - | - |
| stdbuf | 484.4 KB | 50.5 KB | - | - |
| stty | 454.7 KB | 78.5 KB | - | - |
| sum | 442.5 KB | 34.4 KB | - | **1.2x** |
| sync | 430.2 KB | 34.4 KB | - | **0.9x** |
| tac | 1.9 MB | 38.4 KB | - | - |
| tail | 477.9 KB | 62.5 KB | - | - |
| tee | 436.3 KB | 38.5 KB | - | **1.5x** |
| test | 440.5 KB | 46.4 KB | - | - |
| timeout | 486.9 KB | 38.9 KB | - | - |
| touch | 457.8 KB | 94.5 KB | - | **0.9x** |
| tr | 696.2 KB | 46.5 KB | - | **7.2x** |
| true | 296.6 KB | 26.3 KB | - | - |
| truncate | 441.2 KB | 38.5 KB | - | **0.9x** |
| tsort | 464.7 KB | 46.5 KB | - | **2.5x** |
| tty | 425.8 KB | 34.5 KB | - | **0.9x** |
| uname | 428.6 KB | 34.5 KB | - | **0.9x** |
| unexpand | 453.3 KB | 38.5 KB | - | - |
| uniq | 907.0 KB | 38.5 KB | - | **8.5x** |
| unlink | 429.4 KB | 34.5 KB | - | **1.0x** |
| uptime | 501.2 KB | 14.4 KB | - | - |
| users | 461.2 KB | 34.5 KB | - | - |
| vdir | 585.5 KB | 139.0 KB | - | - |
| wc | 906.9 KB | 54.5 KB | - | - |
| who | 782.6 KB | 58.5 KB | - | - |
| whoami | 425.0 KB | 34.5 KB | - | **0.9x** |
| yes | 1.8 KB | 34.4 KB | - | **4.2x** |

### Known Issues
- 76 compatibility test failures across 1 platform(s)

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

## Platform Functional Tests (v0.13.3)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | — | — | — | ⏭️ missing |
| Linux ARM64 | — | — | — | ⏭️ missing |
| macOS ARM64 | 276 | 76 | 36 | ⚠️ |
| Windows x86_64 | — | — | — | ⏭️ missing |
| Windows ARM64 | — | — | — | 🔍 x86_64 binary under ARM64 emulation — full test suite skipped to avoid SIMD crashes |
