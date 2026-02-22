# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.8.8)

### Summary
- **Tools tracked:** 84 total (10 with data)
- **Compatibility:** 826/826 tests passed (100.0%)
- **Fastest speedup:** wc at 34.6x faster than GNU

### Full Tools Comparison

> Sizes are relative (f\* size ÷ reference size — lower is smaller).
> Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

| Tool | Size f\* vs GNU | Size f\* vs uutils | Compat f\* vs GNU | Compat f\* vs uutils | Speedup f\* vs GNU | Speedup f\* vs uutils |
|------|----------------:|-------------------:|------------------:|---------------------:|-------------------:|----------------------:|
| wc | - | - | - | - | **34.6x** | **22.8x** |
| cut | - | - | - | - | **5.8x** | **1.9x** |
| sha256sum | - | - | - | - | **1.0x** | **3.8x** |
| md5sum | - | - | - | - | **1.4x** | **1.3x** |
| b2sum | - | - | - | - | **1.3x** | **1.3x** |
| base64 | - | - | - | - | **6.7x** | **7.0x** |
| sort | - | - | - | - | **17.6x** | **18.0x** |
| tr | - | - | - | - | **7.4x** | **7.2x** |
| uniq | - | - | - | - | **13.5x** | **6.6x** |
| tac | - | - | - | - | **3.9x** | **2.1x** |
| head | - | - | - | - | - | - |
| tail | - | - | - | - | - | - |
| cat | - | - | - | - | - | - |
| rev | - | - | - | - | - | - |
| expand | - | - | - | - | - | - |
| unexpand | - | - | - | - | - | - |
| fold | - | - | - | - | - | - |
| paste | - | - | - | - | - | - |
| nl | - | - | - | - | - | - |
| comm | - | - | - | - | - | - |
| join | - | - | - | - | - | - |
| basenc | - | - | - | - | - | - |
| base32 | - | - | - | - | - | - |
| ln | - | - | - | - | - | - |
| touch | - | - | - | - | - | - |
| truncate | - | - | - | - | - | - |
| mkdir | - | - | - | - | - | - |
| rmdir | - | - | - | - | - | - |
| mknod | - | - | - | - | - | - |
| mkfifo | - | - | - | - | - | - |
| mktemp | - | - | - | - | - | - |
| seq | - | - | - | - | - | - |
| shuf | - | - | - | - | - | - |
| tsort | - | - | - | - | - | - |
| tee | - | - | - | - | - | - |
| sum | - | - | - | - | - | - |
| cksum | - | - | - | - | - | - |
| sha1sum | - | - | - | - | - | - |
| sha224sum | - | - | - | - | - | - |
| sha384sum | - | - | - | - | - | - |
| sha512sum | - | - | - | - | - | - |
| id | - | - | - | - | - | - |
| groups | - | - | - | - | - | - |
| whoami | - | - | - | - | - | - |
| logname | - | - | - | - | - | - |
| uname | - | - | - | - | - | - |
| uptime | - | - | - | - | - | - |
| arch | - | - | - | - | - | - |
| hostid | - | - | - | - | - | - |
| tty | - | - | - | - | - | - |
| nproc | - | - | - | - | - | - |
| pwd | - | - | - | - | - | - |
| env | - | - | - | - | - | - |
| timeout | - | - | - | - | - | - |
| nice | - | - | - | - | - | - |
| nohup | - | - | - | - | - | - |
| sleep | - | - | - | - | - | - |
| sync | - | - | - | - | - | - |
| true | - | - | - | - | - | - |
| false | - | - | - | - | - | - |
| link | - | - | - | - | - | - |
| unlink | - | - | - | - | - | - |
| basename | - | - | - | - | - | - |
| dirname | - | - | - | - | - | - |
| pathchk | - | - | - | - | - | - |
| realpath | - | - | - | - | - | - |
| readlink | - | - | - | - | - | - |
| dircolors | - | - | - | - | - | - |
| echo | - | - | - | - | - | - |
| factor | - | - | - | - | - | - |
| expr | - | - | - | - | - | - |
| test | - | - | - | - | - | - |
| cp | - | - | - | - | - | - |
| mv | - | - | - | - | - | - |
| rm | - | - | - | - | - | - |
| dd | - | - | - | - | - | - |
| split | - | - | - | - | - | - |
| csplit | - | - | - | - | - | - |
| install | - | - | - | - | - | - |
| shred | - | - | - | - | - | - |
| chmod | - | - | - | - | - | - |
| chown | - | - | - | - | - | - |
| chgrp | - | - | - | - | - | - |
| yes | - | - | - | - | - | - |

### Known Issues
- No known issues

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/coreutils-rs) — installed from GitHub Releases
- [uutils/coreutils](https://github.com/uutils/coreutils) — built from source (latest main)
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Builds uutils/coreutils from source for comparison
- Runs 826+ compatibility tests comparing output byte-for-byte against GNU coreutils
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
