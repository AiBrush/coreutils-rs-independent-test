# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.0.39)

### Summary
- **Tools tested:** 10 (wc, cut, sha256sum, md5sum, b2sum, base64, sort, tr, uniq, tac)
- **Compatibility:** 823/826 tests passed (99.6%)
- **Fastest speedup:** wc at 33.7x faster than GNU

### Performance Highlights

| Tool | Speedup (vs GNU) |
|------|----------------:|
| wc | **33.7x** |
| cut | **5.9x** |
| sha256sum | **1.0x** |
| md5sum | **1.3x** |
| b2sum | **1.3x** |
| base64 | **2.2x** |
| sort | **8.8x** |
| tr | **1.8x** |
| uniq | **10.9x** |
| tac | **2.4x** |

### Known Issues
- 3 compatibility test failures across 2 platforms

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
