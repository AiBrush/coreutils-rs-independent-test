# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.3.2)

### Summary
- **Tools tested:** 10 (wc, cut, sha256sum, md5sum, b2sum, base64, sort, tr, uniq, tac)
- **Compatibility:** 824/826 tests passed (99.8%)
- **Fastest speedup:** wc at 32.3x faster than GNU

### Performance Highlights

| Tool | f* vs GNU | f* vs uutils |
|------|----------:|-------------:|
| wc | **32.3x** | **24.9x** |
| sort | **17.7x** | **16.8x** |
| uniq | **12.6x** | **3.9x** |
| cut | **7.7x** | **4.7x** |
| tr | **6.3x** | **7.1x** |
| base64 | **5.2x** | **4.5x** |
| tac | **3.7x** | **2.0x** |
| md5sum | **1.4x** | **1.4x** |
| b2sum | **1.4x** | **1.3x** |
| sha256sum | **1.2x** | **4.6x** |

### Known Issues
- 2 compatibility test failures across 2 platforms

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
