Create a rigorous, independent test suite for fcoreutils - a Rust replacement for GNU coreutils.

## Your Mission

You are an independent quality assurance engineer. Your job is to RUTHLESSLY test fcoreutils against GNU coreutils and report HONEST results. Do not sugar-coat findings. If fcoreutils fails, document exactly how it fails.

## Project Setup

Repository: https://github.com/AiBrush/coreutils-rs-independent-test

This project must:
1. Create GitHub Actions workflows for cross-platform testing
2. Compare against system GNU coreutils
3. Test on Linux, macOS, and Windows
4. Test on both x86_64 and ARM64 architectures
5. Run functional compatibility tests
6. Test for 100% compatibility
7. Run performance benchmarks
8. Benchmark performance comparing GNU vs fcoreutils
9. Collect and report results from CI

## Tools to Test (All 10)

| Tool | Binary | Status |
|------|--------|--------|
| wc | fwc | Implemented |
| cut | fcut | Implemented |
| sha256sum | fsha256sum | Implemented |
| md5sum | fmd5sum | Implemented |
| b2sum | fb2sum | Implemented |
| base64 | fbase64 | Implemented |
| sort | fsort | Implemented |
| tr | ftr | Implemented |
| uniq | funiq | Implemented |
| tac | ftac | Implemented |

Test ALL tools. For tools not yet implemented, the test should:
1. Detect if the tool exists
2. Skip tests gracefully if not available
3. Report "NOT IMPLEMENTED" in results
4. Still have test infrastructure ready for when it's implemented

## Installation Requirements

```bash
# Remove any existing installation
cargo uninstall fcoreutils 2>/dev/null || true

# Install fresh from crates.io (as a real user would)
cargo install fcoreutils

# Verify installation
which fwc fcut fsha256sum fmd5sum fb2sum

# Verify GNU coreutils available for comparison
which wc cut sha256sum md5sum b2sum
```

## Platform Matrix

Create CI workflows that test on:

| OS | Architecture | Runner |
|----|--------------|--------|
| Linux | x86_64 | ubuntu-latest |
| Linux | ARM64 | ubuntu-24.04-arm |
| macOS | x86_64 | macos-13 |
| macOS | ARM64 | macos-latest (Apple Silicon) |
| Windows | x86_64 | windows-latest |
| Windows | ARM64 | windows-11-arm |

## GitHub Actions Workflows to Create

### 1. `.github/workflows/compatibility-tests.yml`

Tests that fcoreutils output is byte-identical to GNU coreutils.

### 2. `.github/workflows/benchmarks.yml`

Performance benchmarks comparing fcoreutils vs GNU coreutils.

### 3. `.github/workflows/collect-results.yml`

Aggregates results from all platforms into a single report.


## Test Categories

### Category 1: Compatibility Tests (Must Pass 100%)

For EVERY tool, test that output is BYTE-FOR-BYTE IDENTICAL to GNU.

**Test methodology:**
```bash
# Generate output from both tools
gnu_tool [args] [input] > /tmp/gnu_output 2>&1; echo "exit:$?" >> /tmp/gnu_output
f_tool [args] [input] > /tmp/f_output 2>&1; echo "exit:$?" >> /tmp/f_output

# Compare (must be identical)
diff /tmp/gnu_output /tmp/f_output
```

**Test cases to cover:**

1. **Empty input** - Empty file, empty stdin
2. **Single byte** - Files with just one character
3. **No trailing newline** - Files without final \n
4. **Binary data** - Files with null bytes, high bytes (0x80-0xFF)
5. **Unicode** - UTF-8 multibyte characters, emojis, CJK
6. **Huge files** - 1GB+ files (memory mapping behavior)
7. **Many small files** - 10,000+ files in one command
8. **Stdin vs file** - Same content via pipe vs file argument
9. **Special filenames** - Spaces, quotes, newlines in names
10. **Symlinks** - Regular files vs symlinks to files
11. **Pipes and FIFOs** - Non-seekable inputs
12. **Permission errors** - Files without read permission
13. **Missing files** - Non-existent paths
14. **Empty arguments** - Empty string as argument
15. **All flag combinations** - Every documented flag

**Tool-specific edge cases:**

#### wc (fwc)
- Files with only whitespace
- Lines longer than 10KB
- Mixed line endings (LF, CRLF, CR)
- --files0-from with embedded nulls
- -L with tabs (tab stop calculation at 8)
- -m character count vs -c byte count on UTF-8
- Multiple files with --total

Flags to test: -c -m -l -L -w --files0-from --total
*add more flags and tests as the original coreutils has more flags*

#### cut (fcut)
- Delimiter not present in line
- Empty fields (consecutive delimiters)
- Field ranges: -3, 3-, 3-5, 1,3,5
- --complement behavior
- -z (null-terminated)
- Multi-byte delimiters (should error)
- Field 0 (should error)

Flags to test: -b -c -d -f -s --complement --output-delimiter -z
*add more flags and tests as the original coreutils has more flags*

#### sha256sum (fsha256sum)
- Check mode (-c) with OK files
- Check mode with FAILED files
- Check mode with missing files
- Check mode with malformed checksum files
- Binary vs text mode markers (* vs space)
- --tag format (BSD style)
- --strict and --warn behavior
- --ignore-missing
- Empty file hash
- Large file (1GB+) hash

Flags to test: -b -c --ignore-missing --quiet --status --strict -t -w --tag -z

*add more flags and tests as the original coreutils has more flags*


#### md5sum (fmd5sum)
- Same tests as sha256sum
- Verify against known MD5 test vectors

Flags to test: -b -c --ignore-missing --quiet --status --strict -t -w --tag -z

*add more flags and tests as the original coreutils has more flags*

#### b2sum (fb2sum)
- Same tests as sha256sum
- Variable length output (-l flag)
- Default 512-bit output

Flags to test: -b -c -l --tag -t plus check flags

*add more flags and tests as the original coreutils has more flags*

#### base64 (fbase64)
- Encode/decode roundtrip
- Line wrapping (-w)
- Ignore garbage (-i) on decode
- Invalid base64 input
- Binary data encoding
- Empty input
- Padding handling

Flags to test: -d -i -w

*add more flags and tests as the original coreutils has more flags*

#### sort (fsort)
- Numeric sort (-n)
- Human numeric sort (-h) - 1K, 2M, 3G
- Version sort (-V) - 1.2.3 vs 1.10.1
- Reverse (-r)
- Unique (-u)
- Key sorting (-k)
- Field separator (-t)
- Case insensitive (-f)
- Dictionary order (-d)
- Stable sort (-s)
- Check sorted (-c)
- Merge (-m)
- Parallel (--parallel)
- Memory limit (-S)
- Already sorted input
- Reverse sorted input
- Random input
- Many duplicate lines

Flags to test: -b -d -f -g -h -i -M -n -R -r -V -k -t -u -s -c -m -o -T --parallel -S -z

*add more flags and tests as the original coreutils has more flags*

#### tr (ftr)
- Simple translation (a-z A-Z)
- Delete mode (-d)
- Squeeze mode (-s)
- Complement (-c)
- Character classes [:alpha:] [:digit:] [:space:] etc.
- Ranges (a-z, 0-9)
- Escape sequences (\n \t \\ etc.)
- SET1 longer than SET2
- SET2 longer than SET1
- Empty sets

Flags to test: -c -C -d -s -t
Character classes: [:alnum:] [:alpha:] [:blank:] [:cntrl:] [:digit:] [:graph:] [:lower:] [:print:] [:punct:] [:space:] [:upper:] [:xdigit:]

*add more flags and tests as the original coreutils has more flags*

#### uniq (funiq)
- Count mode (-c)
- Duplicate only (-d)
- All duplicates (-D)
- Unique only (-u)
- Skip fields (-f)
- Skip chars (-s)
- Compare N chars (-w)
- Case insensitive (-i)
- Zero-terminated (-z)
- Group mode (--group)
- Adjacent vs non-adjacent duplicates
- Empty lines
- Lines differing only in whitespace

Flags to test: -c -d -D --all-repeated -f --group -i -s -u -w -z

*add more flags and tests as the original coreutils has more flags*

#### tac (ftac)
- Basic line reversal
- Custom separator (-s)
- Before mode (-b) - separator before instead of after
- Regex separator (-r)
- Binary files
- Files without trailing newline
- Single line file
- Empty file
- Very long lines

Flags to test: -b -r -s

*add more flags and tests as the original coreutils has more flags*

### Category 2: Performance Benchmarks (All 10 Tools)

**Benchmark methodology:**

1. Use hyperfine for accurate timing:
```bash
hyperfine --warmup 3 --runs 10 \
  'wc /tmp/testfile' \
  'fwc /tmp/testfile'
```

**File sizes to test:**
- 1 KB (tiny)
- 100 KB (small)
- 10 MB (medium)
- 100 MB (large)
- 1 GB (huge) - where applicable

**Test different content types:**
- ASCII text (prose)
- Source code
- CSV/TSV data
- Binary data
- Highly repetitive content
- Random bytes

**Test parallel scenarios:**
- Single file
- 10 files
- 100 files
- 1000 files


**Benchmark scenarios per tool:**

#### wc benchmarks
- wc (default - lines, words, bytes)
- wc -l (lines only)
- wc -w (words only)
- wc -c (bytes only - should use stat)
- wc -m (characters)
- wc -L (max line length)
- Multiple files (10, 100, 1000 files)

#### cut benchmarks
- cut -b1-100 (byte range)
- cut -c1-100 (char range)
- cut -d: -f1 (field extraction)
- cut -d, -f1,3,5 (multiple fields)
- cut --complement

#### sha256sum/md5sum/b2sum benchmarks
- Single file (various sizes)
- Multiple files (10, 100 files)
- Parallel file processing

#### base64 benchmarks
- Encode (various sizes)
- Decode (various sizes)
- With line wrapping
- Without line wrapping

#### sort benchmarks
- Lexicographic sort
- Numeric sort (-n)
- Already sorted input
- Reverse sorted input
- Random input
- With -u (unique)
- With -k (key)
- Parallel sort (--parallel)

#### tr benchmarks
- Simple translation
- Delete mode
- Squeeze mode
- Character class translation

#### uniq benchmarks
- Default mode
- Count mode (-c)
- High duplicate ratio
- Low duplicate ratio
- Pre-sorted vs unsorted

#### tac benchmarks
- Line reversal (various sizes)
- Custom separator


**Performance report format:**

```
## wc Performance Results

| File Size | Content Type | GNU wc | fwc | Speedup |
|-----------|--------------|--------|-----|---------|
| 100 MB | text | 302ms | ??? | ???x |
| 100 MB | binary | ??? | ??? | ???x |
```


### Category 3: Platform-Specific Tests

**Linux x86_64:**
- AVX2/AVX-512 SIMD paths
- SHA-NI hardware acceleration

**Linux ARM64:**
- NEON SIMD paths
- Graviton optimization

**macOS x86_64:**
- AVX2 paths
- Compare vs GNU coreutils from Homebrew

**macOS ARM64 (Apple Silicon):**
- NEON paths
- M1/M2/M3 optimization

**Windows x86_64:**
- Path handling (backslashes)
- Line ending handling (CRLF vs LF)
- Console encoding

### Category 4: Stress Tests

Push the tools to their limits:

1. **Memory pressure** - Run with limited memory (ulimit -v)
2. **Concurrent execution** - 100 parallel instances
3. **Rapid repeated execution** - 10,000 runs in a loop
4. **Adversarial input** - Malformed data designed to break parsers
5. **Signal handling** - SIGINT/SIGTERM during processing
6. **Slow stdin** - Throttled input stream
7. **Very long lines** (1MB+ single line)
8. **Millions of short lines**
9. **Mixed binary and text**

### Category 4: Regression Tests

Test cases that have historically broken coreutils implementations:

1. **Locale sensitivity** - Run with LC_ALL=C vs LC_ALL=en_US.UTF-8
2. **wc counting** - The string "I\xcc\x88" (I + combining umlaut) 
3. **cut field 0** - Should error, not crash
4. **Negative ranges** - cut -b-0 should error
5. **Integer overflow** - Files with >2^63 bytes

## Report Format

### REPORT.md Structure

```markdown
# fcoreutils Independent Test Report

Create a comprehensive report with:

Generated: [date]
fcoreutils version: [version]
Platforms tested: [list]

## Executive Summary

| Metric | Result |
|--------|--------|
| Tools Implemented | X/10 |
| Overall Compatibility | X% |
| Tools Benchmarked | X/10 |
| Recommendation | [READY/NEEDS WORK/NOT READY] |

## Platform Results

### Linux x86_64
- Compatibility: X/Y tests passed
- Performance: [table]

### Linux ARM64
- Compatibility: X/Y tests passed
- Performance: [table]

### macOS x86_64
- Compatibility: X/Y tests passed
- Performance: [table]

### macOS ARM64
- Compatibility: X/Y tests passed
- Performance: [table]

### Windows x86_64
- Compatibility: X/Y tests passed
- Performance: [table]

2. **Compatibility Matrix**
  | Tool | Tests Run | Passed | Failed | Pass Rate |
  |------|-----------|--------|--------|-----------|
  | fwc | 150 | 148 | 2 | 98.7% |

3. **Failed Test Details**
   For each failure:
    ### [Test Name]
    - Tool: [which tool]
    - Platform: [which platforms failed]
    - Command: [exact command]
    - Expected: [GNU output]
    - Actual: [fcoreutils output]
    - Diff: [differences]

4. **Performance Results**
   - Measured GNU vs fcoreutils times for each tool
   - Actual speedup measured per platform
   - Conditions where fcoreutils is slower

  | Tool | Linux x86 | Linux ARM | macOS ARM | Windows |
  |------|-----------|-----------|-----------|---------|
  | wc | Xx | Xx | Xx | Xx |
  | cut | Xx | Xx | Xx | Xx |
  | sha256sum | Xx | Xx | Xx | Xx |
  | md5sum | Xx | Xx | Xx | Xx |
  | b2sum | Xx | Xx | Xx | Xx |
  | base64 | Xx | Xx | Xx | Xx |
  | sort | Xx | Xx | Xx | Xx |
  | tr | Xx | Xx | Xx | Xx |
  | uniq | Xx | Xx | Xx | Xx |
  | tac | Xx | Xx | Xx | Xx |

5. **Issues Found**
  1. [Issue description, Bugs discovered ...]
  2. [Issue description, Missing features ...]
  3. [Issue description, Documentation errors ...]

## Recommendations

[Based on findings]
```

### File Outputs

- `REPORT.md` - Human-readable summary
- `compatibility_results.json` - Machine-readable test results
- `benchmark_results.json` - Performance data
- `failed_tests/` - Directory with reproduction cases for failures

## Critical Instructions

1. **BE HONEST** - If fcoreutils is worse, say so clearly
2. **BE THOROUGH** - Don't stop at happy path tests
3. **BE REPRODUCIBLE** - Every test must be runnable by others
4. **DOCUMENT EVERYTHING** - Failed tests need exact reproduction steps
5. **NO BIAS** - You're testing, not advocating
6. **CI-FIRST** - All tests run in GitHub Actions, not locally
7. **ISOLATED** - No external dependencies beyond fcoreutils and GNU coreutils
8. **AUTOMATED** - No manual intervention required
9. **REPRODUCIBLE** - Same results every time
10. **CLEAN** - No leftover files or processes

## Handling Unimplemented Tools

For each tool, the test script should:

```bash
check_tool_exists() {
    local tool="$1"
    if command -v "$tool" &> /dev/null; then
        return 0
    else
        echo "SKIP: $tool not implemented yet"
        return 1
    fi
}

# Example usage
if check_tool_exists "fbase64"; then
    run_base64_tests
else
    echo '{"tool": "base64", "status": "NOT_IMPLEMENTED"}' >> "$RESULTS_DIR/base64.json"
fi
```

## What Success Looks Like

A successful test run produces:

1. **For compatibility:** "100% of tests pass - output is byte-identical to GNU coreutils"
2. **For performance:** "Measured speedups: wc=25x, cut=8x, sha256sum=6x"
3. **For reliability:** "All stress tests passed without crashes or hangs"

## What Failure Looks Like

Be explicit about failures:

1. "fwc -L produces incorrect output for files with tabs - reports 16 instead of 8 for tab width"
2. "fsha256sum is only 1.2x faster than GNU sha256sum"
3. "fcut crashes on empty delimiter (-d '')"

## Start Now

1. Create test infrastructure for ALL 10 tools
2. Create GitHub Actions workflows
3. Create test scripts with graceful skip for unimplemented tools
4. Push to trigger CI
5. Review CI results
6. Generate and commit report

Your goal is to determine: **Is fcoreutils ready for real-world use as a GNU coreutils replacement?**

The test infrastructure should be ready and waiting for tools as they get implemented. Let the CI be the judge. Report what it finds. No bias, no excuses.

Be the harshest critic. Find every bug. The developers need to know the truth.
