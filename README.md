# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.18.5)

### Summary
- **Tools tracked:** 107 total (0 with binaries)
- **Compatibility:** 0/0 tests passed (0%) across 0 tools
- **Benchmarked:** 0 tools with performance data
- **Fastest speedup:**  at 0.0x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
>
> Legend: `-` = no data collected | `N/A` = not applicable | `⏭️ 0 tests` = test ran but produced 0 results

| Tool | fcoreutils size | GNU size | Compat f\* vs GNU | Speedup f\* vs GNU |
|------|----------------:|---------:|------------------:|-------------------:|
| arch | - | - | - | - |
| b2sum | - | - | - | - |
| base32 | - | - | - | - |
| base64 | - | - | - | - |
| basename | - | - | - | - |
| basenc | - | - | - | - |
| cat | - | - | - | - |
| chcon | - | - | - | - |
| chgrp | - | - | - | - |
| chmod | - | - | - | - |
| chown | - | - | - | - |
| chroot | - | - | - | - |
| cksum | - | - | - | - |
| comm | - | - | - | - |
| cp | - | - | - | - |
| csplit | - | - | - | - |
| cut | - | - | - | - |
| date | - | - | - | - |
| dd | - | - | - | - |
| df | - | - | - | - |
| dir | - | - | - | - |
| dircolors | - | - | - | - |
| dirname | - | - | - | - |
| du | - | - | - | - |
| echo | - | - | - | - |
| env | - | - | - | - |
| expand | - | - | - | - |
| expr | - | - | - | - |
| factor | - | - | - | - |
| false | - | - | - | - |
| fmt | - | - | - | - |
| fold | - | - | - | - |
| groups | - | - | - | - |
| head | - | - | - | - |
| hostid | - | - | - | - |
| id | - | - | - | - |
| install | - | - | - | - |
| join | - | - | - | - |
| kill | - | - | - | - |
| link | - | - | - | - |
| ln | - | - | - | - |
| logname | - | - | - | - |
| ls | - | - | - | - |
| md5sum | - | - | - | - |
| mkdir | - | - | - | - |
| mkfifo | - | - | - | - |
| mknod | - | - | - | - |
| mktemp | - | - | - | - |
| mv | - | - | - | - |
| nice | - | - | - | - |
| nl | - | - | - | - |
| nohup | - | - | - | - |
| nproc | - | - | - | - |
| numfmt | - | - | - | - |
| od | - | - | - | - |
| paste | - | - | - | - |
| pathchk | - | - | - | - |
| pinky | - | - | - | - |
| pr | - | - | - | - |
| printenv | - | - | - | - |
| printf | - | - | - | - |
| ptx | - | - | - | - |
| pwd | - | - | - | - |
| readlink | - | - | - | - |
| realpath | - | - | - | - |
| rev | - | - | - | - |
| rm | - | - | - | - |
| rmdir | - | - | - | - |
| runcon | - | - | - | - |
| seq | - | - | - | - |
| sha1sum | - | - | - | - |
| sha224sum | - | - | - | - |
| sha256sum | - | - | - | - |
| sha384sum | - | - | - | - |
| sha512sum | - | - | - | - |
| shred | - | - | - | - |
| shuf | - | - | - | - |
| sleep | - | - | - | - |
| sort | - | - | - | - |
| split | - | - | - | - |
| stat | - | - | - | - |
| stdbuf | - | - | - | - |
| stty | - | - | - | - |
| sum | - | - | - | - |
| sync | - | - | - | - |
| tac | - | - | - | - |
| tail | - | - | - | - |
| tee | - | - | - | - |
| test | - | - | - | - |
| timeout | - | - | - | - |
| touch | - | - | - | - |
| tr | - | - | - | - |
| true | - | - | - | - |
| truncate | - | - | - | - |
| tsort | - | - | - | - |
| tty | - | - | - | - |
| uname | - | - | - | - |
| unexpand | - | - | - | - |
| uniq | - | - | - | - |
| unlink | - | - | - | - |
| uptime | - | - | - | - |
| users | - | - | - | - |
| vdir | - | - | - | - |
| wc | - | - | - | - |
| who | - | - | - | - |
| whoami | - | - | - | - |
| yes | - | - | - | - |

### Known Issues
- No known issues

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

## Platform Functional Tests (v0.18.5)

| Platform | Passed | Failed | Skipped | Status |
|----------|--------|--------|---------|--------|
| Linux x86_64 | 0 | 0 | 0 | ⏭️ no tests ran |
| Linux ARM64 | — | — | — | ⏭️ no binary available for aarch64-unknown-linux-gnu |
| macOS ARM64 | — | — | — | ⏭️ no binary available for aarch64-apple-darwin |
| Windows x86_64 | — | — | — | ⏭️ no binary available for x86_64-pc-windows-msvc |
| Windows ARM64 | — | — | — | ⏭️ no binary available for aarch64-pc-windows-msvc |
