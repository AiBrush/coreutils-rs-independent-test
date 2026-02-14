# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.0.58)

### Summary
- **Tools tested:** 10 (wc, cut, sha256sum, md5sum, b2sum, base64, sort, tr, uniq, tac)
- **Compatibility:** 822/826 tests passed (99.5%)
- **Fastest speedup:** wc at 35.6x faster than GNU

### Performance Highlights

| Tool | Speedup (vs GNU) |
|------|----------------:|
| wc | **35.6x** |
| cut | **6.6x** |
| sha256sum | **1.1x** |
| md5sum | **1.3x** |
| b2sum | **1.3x** |
| base64 | **3.0x** |
| sort | **8.4x** |
| tr | **4.6x** |
| uniq | **12.5x** |
| tac | **0.7x** |

### Known Issues
- 4 compatibility test failures across 2 platforms

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Runs 826+ compatibility tests comparing output byte-for-byte against GNU coreutils
- Benchmarks using `hyperfine` with warmup runs and timed runs
- Tests run across multiple platforms via GitHub Actions

## Running Locally
```bash
# Run benchmarks for the latest version
./scripts/install_from_github.sh
./tests/benchmarks/run_all.sh

# Run compatibility tests
./tests/compatibility/run_all.sh

# Generate the plot
pip install matplotlib
python3 scripts/plot_speedup.py
```
