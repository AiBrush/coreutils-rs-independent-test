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

| Tool | fcoreutils size | GNU size | uutils size | Compat f\* vs GNU | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|----------:|----------:|------------------:|-------------------:|----------------------:|
| arch | - | - | - | - | **0.7x** | - |
| b2sum | 633.9 KB | 54.5 KB | 2.3 MB | ✅ 100% | **1.3x** | **1.3x** |
| base32 | - | - | - | - | **1.4x** | - |
| base64 | 558.2 KB | 38.5 KB | 1.3 MB | ⚠️ 97% | **5.0x** | **5.3x** |
| basename | - | - | - | - | **0.8x** | - |
| basenc | - | - | - | - | **1.0x** | - |
| cat | 462.4 KB | 38.5 KB | 1.3 MB | - | **2.3x** | **1.5x** |
| chcon | - | - | - | - | - | - |
| chgrp | - | - | - | - | **0.9x** | - |
| chmod | - | - | - | - | **1.0x** | - |
| chown | - | - | - | - | **1.0x** | - |
| chroot | - | - | - | - | - | - |
| cksum | - | - | - | - | **1.2x** | - |
| comm | 456.6 KB | 38.5 KB | 1.3 MB | - | **3.1x** | **3.0x** |
| cp | - | - | - | - | **0.9x** | - |
| csplit | - | - | - | - | **16.7x** | - |
| cut | 635.1 KB | 38.5 KB | 1.3 MB | ✅ 100% | **5.5x** | **1.7x** |
| date | - | - | - | - | - | - |
| dd | - | - | - | - | **1.0x** | - |
| df | - | - | - | - | - | - |
| dir | - | - | - | - | - | - |
| dircolors | - | - | - | - | - | - |
| dirname | - | - | - | - | **0.8x** | - |
| du | - | - | - | - | - | - |
| echo | - | - | - | - | **0.8x** | - |
| env | - | - | - | - | **0.9x** | - |
| expand | 451.0 KB | 34.5 KB | 1.3 MB | - | **7.7x** | **2.7x** |
| expr | - | - | - | - | **0.9x** | - |
| factor | - | - | - | - | **0.9x** | - |
| false | - | - | - | - | - | - |
| fmt | - | - | - | - | - | - |
| fold | 449.7 KB | 34.5 KB | 1.3 MB | - | **4.2x** | **1.3x** |
| groups | - | - | - | - | **0.7x** | - |
| head | 458.2 KB | 42.5 KB | 1.3 MB | - | **1.8x** | **1.1x** |
| hostid | - | - | - | - | **0.8x** | - |
| id | - | - | - | - | **1.0x** | - |
| install | - | - | - | - | **1.0x** | - |
| join | 472.3 KB | 50.5 KB | 2.6 MB | - | **0.7x** | **0.8x** |
| kill | - | - | - | - | - | - |
| link | - | - | - | - | **1.0x** | - |
| ln | - | - | - | - | **0.9x** | - |
| logname | - | - | - | - | **0.8x** | - |
| ls | - | - | - | - | - | - |
| md5sum | 657.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.2x** |
| mkdir | - | - | - | - | **1.0x** | - |
| mkfifo | - | - | - | - | **1.0x** | - |
| mknod | - | - | - | - | **1.1x** | - |
| mktemp | - | - | - | - | - | - |
| mv | - | - | - | - | **1.1x** | - |
| nice | - | - | - | - | **0.8x** | - |
| nl | 1.8 MB | 38.6 KB | 2.7 MB | - | **4.3x** | **1.5x** |
| nohup | - | - | - | - | **0.8x** | - |
| nproc | - | - | - | - | **0.8x** | - |
| numfmt | - | - | - | - | - | - |
| od | - | - | - | - | - | - |
| paste | 452.1 KB | 38.4 KB | 1.2 MB | - | **1.7x** | **13.7x** |
| pathchk | - | - | - | - | **0.8x** | - |
| pinky | - | - | - | - | - | - |
| pr | - | - | - | - | - | - |
| printenv | - | - | - | - | - | - |
| printf | - | - | - | - | - | - |
| ptx | - | - | - | - | - | - |
| pwd | - | - | - | - | - | - |
| readlink | - | - | - | - | **0.9x** | - |
| realpath | - | - | - | - | **0.9x** | - |
| rev | 442.7 KB | 14.4 KB | - | - | **21.7x** | - |
| rm | - | - | - | - | **0.9x** | - |
| rmdir | - | - | - | - | **0.9x** | - |
| runcon | - | - | - | - | - | - |
| seq | - | - | - | - | **16.4x** | - |
| sha1sum | - | - | - | - | **0.8x** | - |
| sha224sum | - | - | - | - | **0.8x** | - |
| sha256sum | 657.7 KB | 38.4 KB | 2.3 MB | ✅ 100% | **1.0x** | **1.0x** |
| sha384sum | - | - | - | - | **0.9x** | - |
| sha512sum | - | - | - | - | **0.9x** | - |
| shred | - | - | - | - | **2.0x** | - |
| shuf | - | - | - | - | - | - |
| sleep | - | - | - | - | **1.0x** | - |
| sort | 980.4 KB | 102.8 KB | 3.2 MB | ✅ 100% | **12.3x** | **12.7x** |
| split | - | - | - | - | **0.9x** | - |
| stat | - | - | - | - | - | - |
| stdbuf | - | - | - | - | - | - |
| stty | - | - | - | - | - | - |
| sum | - | - | - | - | **1.3x** | - |
| sync | - | - | - | - | **1.0x** | - |
| tac | 1.9 MB | 38.4 KB | 2.7 MB | ✅ 100% | **3.0x** | **1.6x** |
| tail | 485.8 KB | 62.5 KB | 1.7 MB | - | **1.5x** | **2.1x** |
| tee | - | - | - | - | - | - |
| test | - | - | - | - | **0.2x** | - |
| timeout | - | - | - | - | - | - |
| touch | - | - | - | - | **0.8x** | - |
| tr | 696.2 KB | 46.5 KB | 1.3 MB | ✅ 100% | **7.0x** | **7.5x** |
| true | - | - | - | - | - | - |
| truncate | - | - | - | - | **0.8x** | - |
| tsort | - | - | - | - | - | - |
| tty | - | - | - | - | **0.7x** | - |
| uname | - | - | - | - | **1.1x** | - |
| unexpand | 454.5 KB | 38.5 KB | 1.3 MB | - | **3.2x** | **2.5x** |
| uniq | 907.0 KB | 38.5 KB | 1.3 MB | ✅ 100% | **9.6x** | **5.4x** |
| unlink | - | - | - | - | **0.8x** | - |
| uptime | - | - | - | - | - | - |
| users | - | - | - | - | - | - |
| vdir | - | - | - | - | - | - |
| wc | 904.8 KB | 54.5 KB | 1.4 MB | ⚠️ 96% | **30.4x** | **16.9x** |
| who | - | - | - | - | - | - |
| whoami | - | - | - | - | **0.8x** | - |
| yes | - | - | - | ✅ 100% | **5.2x** | - |

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
