# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.2.2)

### Summary
- **Tools tested:** 10 (wc, cut, sha256sum, md5sum, b2sum, base64, sort, tr, uniq, tac)
- **Compatibility:** 820/826 tests passed (99.3%)
- **Fastest speedup:** wc at 34.8x faster than GNU

### Performance Highlights

| Tool | f* vs GNU | f* vs uutils |
|------|----------:|-------------:|
| wc | **34.8x** | **18.3x** |
| sort | **17.6x** | **15.1x** |
| uniq | **13.2x** | **4.0x** |
| cut | **8.6x** | **5.2x** |
| base64 | **6.4x** | **5.7x** |
| tr | **6.1x** | **5.8x** |
| tac | **4.5x** | **2.3x** |
| md5sum | **1.4x** | **1.3x** |
| b2sum | **1.3x** | **1.1x** |
| sha256sum | **1.0x** | **3.8x** |

### Known Issues
- 6 compatibility test failures across 2 platforms

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
