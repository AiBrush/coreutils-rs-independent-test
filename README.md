# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.3.4)

### Summary
- **Tools tested:** 10 (wc, cut, sha256sum, md5sum, b2sum, base64, sort, tr, uniq, tac)
- **Compatibility:** 826/826 tests passed (100.0%)
- **Fastest speedup:** wc at 46.6x faster than GNU

### Performance Highlights

| Tool | f* vs GNU | f* vs uutils |
|------|----------:|-------------:|
| wc | **46.6x** | **24.7x** |
| sort | **17.7x** | **16.3x** |
| uniq | **13.8x** | **4.5x** |
| cut | **5.6x** | **3.5x** |
| base64 | **5.5x** | **5.7x** |
| tac | **2.7x** | **1.5x** |
| tr | **2.6x** | **2.7x** |
| md5sum | **1.4x** | **1.3x** |
| b2sum | **1.3x** | **1.2x** |
| sha256sum | **1.2x** | **4.5x** |

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
