# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

![Speedup History](results/speedup-history.png)

## Latest Results (v0.0.68)

### Summary
- **Tools tested:** 10 (wc, cut, sha256sum, md5sum, b2sum, base64, sort, tr, uniq, tac)
- **Compatibility:** 826/826 tests passed (100.0%)
- **Fastest speedup:** wc at 31.0x faster than GNU

### Performance Highlights

| Tool | Speedup (vs GNU) |
|------|----------------:|
| wc | **31.0x** |
| sort | **15.1x** |
| uniq | **11.3x** |
| cut | **6.2x** |
| tr | **4.1x** |
| base64 | **3.1x** |
| tac | **2.4x** |
| md5sum | **1.4x** |
| b2sum | **1.3x** |
| sha256sum | **1.1x** |

### Known Issues
- No known issues

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
