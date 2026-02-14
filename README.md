# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.1.1)

### Summary
- **Tools tested:** 10 (wc, cut, sha256sum, md5sum, b2sum, base64, sort, tr, uniq, tac)
- **Compatibility:** 826/826 tests passed (100.0%)
- **Fastest speedup:** wc at 32.5x faster than GNU

### Performance Highlights

| Tool | f* vs GNU | f* vs uutils | uutils vs GNU |
|------|----------:|-------------:|--------------:|
| wc | **32.5x** | **21.2x** | 24.3x |
| sort | **17.5x** | **16.3x** | 1.8x |
| uniq | **13.6x** | **4.4x** | 3.1x |
| cut | **5.5x** | **3.5x** | 3.0x |
| tr | **3.5x** | **3.8x** | 1.8x |
| base64 | **2.8x** | **2.9x** | 1.5x |
| tac | **2.5x** | **1.5x** | 2.2x |
| md5sum | **1.4x** | **1.3x** | 1.2x |
| b2sum | **1.3x** | **1.2x** | 1.3x |
| sha256sum | **1.2x** | **4.6x** | 1.1x |

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
