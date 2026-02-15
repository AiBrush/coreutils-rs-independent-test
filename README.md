# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.5.3)

### Summary
- **Tools tested:** 10 (wc, cut, sha256sum, md5sum, b2sum, base64, sort, tr, uniq, tac)
- **Compatibility:** 820/826 tests passed (99.3%)
- **Fastest speedup:** wc at 30.7x faster than GNU

### Performance Highlights

| Tool | f* vs GNU | f* vs uutils |
|------|----------:|-------------:|
| wc | **30.7x** | **16.3x** |
| sort | **17.5x** | **16.7x** |
| uniq | **15.2x** | **6.0x** |
| base64 | **7.2x** | **6.8x** |
| cut | **6.4x** | **3.9x** |
| tac | **4.8x** | **2.5x** |
| tr | **2.7x** | **2.7x** |
| md5sum | **1.5x** | **1.4x** |
| sha256sum | **1.4x** | **5.3x** |
| b2sum | **1.3x** | **1.3x** |

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
