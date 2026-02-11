# fcoreutils Independent Test Report

Generated: 2026-02-11 21:48:18 UTC

## Executive Summary

| Metric | Result |
|--------|--------|
| Tools Implemented | 10/10 |
| Overall Compatibility | 96.9% |
| Platforms Tested | 5 |
| Recommendation | **NEEDS WORK** |

## Platform Results

### Darwin_arm64

- Compatibility: 400/413 tests passed
- Failed: 13
- Skipped: 0

### Linux_aarch64

- Compatibility: 400/413 tests passed
- Failed: 13
- Skipped: 0

### Linux_x86_64

- Compatibility: 401/413 tests passed
- Failed: 12
- Skipped: 0

### MINGW64_NT-10.0-26100_x86_64

- Compatibility: 0/0 tests passed
- Failed: 0
- Skipped: 0

### MINGW64_NT-10.0-26200-ARM64_x86_64

- Compatibility: 0/0 tests passed
- Failed: 0
- Skipped: 0

## Compatibility Matrix

| Tool | Tests Run | Passed | Failed | Pass Rate |
|------|-----------|--------|--------|-----------|
| wc | 355 | 229 | 124 | 64.5% |
| cut | 245 | 238 | 5 | 97.1% |
| sha256sum | 170 | 113 | 55 | 66.5% |
| md5sum | 150 | 99 | 51 | 66.0% |
| b2sum | 125 | 81 | 44 | 64.8% |
| base64 | 165 | 165 | 0 | 100.0% |
| sort | 245 | 227 | 18 | 92.7% |
| tr | 230 | 230 | 0 | 100.0% |
| uniq | 230 | 230 | 0 | 100.0% |
| tac | 150 | 123 | 25 | 82.0% |

## Failed Test Details

### md5sum_-c_--ignore-missing

**Diff:**
```
1d0
< md5sum: /tmp/fcoreutils_md5missing_0EXMmW: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --ignore-missing
# GNU command:
md5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_0EXMmW'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_0EXMmW'
echo "fcoreutils exit: $?"

```

### tac_-b_with_custom_separator

**Diff:**
```
1c1,7
< ---part3---part2part1
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac --before [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -b with custom separator
# GNU command:
printf 'part1---part2---part3' | tac -b -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3' | ftac -b -s '---'
echo "fcoreutils exit: $?"

```

### wc_binary_file_with_null_bytes

**Diff:**
```
1c1
< 0 0 7 /tmp/fcoreutils-test-data/null_bytes.bin
---
> 0 1 7 /tmp/fcoreutils-test-data/null_bytes.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - binary file with null bytes
# GNU command:
wc '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "fcoreutils exit: $?"

```

### tac_-r_regex_separator_(digits)

**Diff:**
```
1c1
< 98gamma765beta432alpha1
\ No newline at end of file
---
> gamma789beta456alpha123
\ No newline at end of file

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -r regex separator (digits)
# GNU command:
printf 'alpha123beta456gamma789' | tac -r -s '[0-9]+'
echo "GNU exit: $?"

# fcoreutils command:
printf 'alpha123beta456gamma789' | ftac -r -s '[0-9]+'
echo "fcoreutils exit: $?"

```

### sort_already_sorted

**Diff:**
```
101,102c101
< sort: write failed: 'standard output': Broken pipe
< sort: write error
---
> fsort: Broken pipe (os error 32)

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - already sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "fcoreutils exit: $?"

```

### tac_stdin_no_final_newline

**Diff:**
```
1c1,2
< cb
---
> c
> b

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - stdin no final newline
# GNU command:
printf 'a\nb\nc' | tac
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\nb\nc' | ftac
echo "fcoreutils exit: $?"

```

### tac_no_trailing_newline

**Diff:**
```
1c1,2
< line 3line 2
---
> line 3
> line 2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - no trailing newline
# GNU command:
tac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
ftac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### cut_tab_delimiter_explicit

**Diff:**
```
1,2c1
< cut: the delimiter must be a single character
< Try 'cut --help' for more information.
---
> fcut: the delimiter must be a single character

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: cut - tab delimiter explicit
# GNU command:
printf 'a\tb\tc\n' | cut -d'\t' -f2
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\tb\tc\n' | fcut -d'\t' -f2
echo "fcoreutils exit: $?"

```

### tac_-s_custom_separator_(---)

**Diff:**
```
1c1,7
< part3---part2---part1---
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac [OPTIONS] [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -s custom separator (---)
# GNU command:
printf 'part1---part2---part3---' | tac -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3---' | ftac -s '---'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--ignore-missing

**Diff:**
```
1d0
< sha256sum: /tmp/fcoreutils_missingcheck_VJVS6m: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --ignore-missing
# GNU command:
sha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_VJVS6m'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_VJVS6m'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=C_default_count

**Diff:**
```
1c1
<  3  2 44 /tmp/fcoreutils-test-data/cjk.txt
---
>  3  4 44 /tmp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=C default count
# GNU command:
LC_ALL=C wc '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=C fwc '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-c_--ignore-missing

**Diff:**
```
1d0
< md5sum: /tmp/fcoreutils_md5missing_SMdtCA: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --ignore-missing
# GNU command:
md5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_SMdtCA'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_SMdtCA'
echo "fcoreutils exit: $?"

```

### tac_-b_with_custom_separator

**Diff:**
```
1c1,7
< ---part3---part2part1
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac --before [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -b with custom separator
# GNU command:
printf 'part1---part2---part3' | tac -b -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3' | ftac -b -s '---'
echo "fcoreutils exit: $?"

```

### wc_binary_file_with_null_bytes

**Diff:**
```
1c1
< 0 0 7 /tmp/fcoreutils-test-data/null_bytes.bin
---
> 0 1 7 /tmp/fcoreutils-test-data/null_bytes.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - binary file with null bytes
# GNU command:
wc '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "fcoreutils exit: $?"

```

### tac_-r_regex_separator_(digits)

**Diff:**
```
1c1
< 98gamma765beta432alpha1
\ No newline at end of file
---
> gamma789beta456alpha123
\ No newline at end of file

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -r regex separator (digits)
# GNU command:
printf 'alpha123beta456gamma789' | tac -r -s '[0-9]+'
echo "GNU exit: $?"

# fcoreutils command:
printf 'alpha123beta456gamma789' | ftac -r -s '[0-9]+'
echo "fcoreutils exit: $?"

```

### wc_random_binary_1k

**Diff:**
```
1c1
<    4   23 1024 /tmp/fcoreutils-test-data/random_1k.bin
---
>    4   24 1024 /tmp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - random binary 1k
# GNU command:
wc '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### sort_already_sorted

**Diff:**
```
101,102c101
< sort: write failed: 'standard output': Broken pipe
< sort: write error
---
> fsort: Broken pipe (os error 32)

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - already sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "fcoreutils exit: $?"

```

### tac_stdin_no_final_newline

**Diff:**
```
1c1,2
< cb
---
> c
> b

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - stdin no final newline
# GNU command:
printf 'a\nb\nc' | tac
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\nb\nc' | ftac
echo "fcoreutils exit: $?"

```

### tac_no_trailing_newline

**Diff:**
```
1c1,2
< line 3line 2
---
> line 3
> line 2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - no trailing newline
# GNU command:
tac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
ftac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### cut_tab_delimiter_explicit

**Diff:**
```
1,2c1
< cut: the delimiter must be a single character
< Try 'cut --help' for more information.
---
> fcut: the delimiter must be a single character

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: cut - tab delimiter explicit
# GNU command:
printf 'a\tb\tc\n' | cut -d'\t' -f2
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\tb\tc\n' | fcut -d'\t' -f2
echo "fcoreutils exit: $?"

```

### tac_-s_custom_separator_(---)

**Diff:**
```
1c1,7
< part3---part2---part1---
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac [OPTIONS] [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -s custom separator (---)
# GNU command:
printf 'part1---part2---part3---' | tac -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3---' | ftac -s '---'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--ignore-missing

**Diff:**
```
1d0
< sha256sum: /tmp/fcoreutils_missingcheck_3Kz9DL: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --ignore-missing
# GNU command:
sha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_3Kz9DL'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_3Kz9DL'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=C_default_count

**Diff:**
```
1c1
<  3  2 44 /tmp/fcoreutils-test-data/cjk.txt
---
>  3  4 44 /tmp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=C default count
# GNU command:
LC_ALL=C wc '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=C fwc '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-t_(text_mode)

**Diff:**
```
1c1
< 900150983cd24fb0d6963f7d28e17f72  /tmp/fcoreutils-test-data/checksum_abc.txt
---
> 900150983cd24fb0d6963f7d28e17f72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -t (text mode)
# GNU command:
md5sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--status_valid_checksums

**Diff:**
```

Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --status valid checksums
# GNU command:
sha256sum -c --status '/tmp/fcoreutils_checksums_hL36aY'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --status '/tmp/fcoreutils_checksums_hL36aY'
echo "fcoreutils exit: $?"

```

### wc_-l_empty

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L empty
# GNU command:
wc -L '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### b2sum_10MB_text_hash

**Diff:**
```
1c1
< db738d1cc80315f5f522d88a30beccd36390fdc8169b1081f0ab391ee57de165246308b6a6d1bd8020298329d7a8121b7a08c9a0c40f94a4f021365d6737ea72 */tmp/fcoreutils-test-data/text_10m.txt
---
> db738d1cc80315f5f522d88a30beccd36390fdc8169b1081f0ab391ee57de165246308b6a6d1bd8020298329d7a8121b7a08c9a0c40f94a4f021365d6737ea72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - 10MB text hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### md5sum_fox_known_hash

**Diff:**
```
1c1
< 9e107d9d372bb6826bd81d3542a419d6 *-
---
> 9e107d9d372bb6826bd81d3542a419d6  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - fox known hash
# GNU command:
printf 'The quick brown fox jumps over the lazy dog' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
printf 'The quick brown fox jumps over the lazy dog' | fmd5sum
echo "fcoreutils exit: $?"

```

### md5sum_-c_check_valid

**Diff:**
```
1,2c1,5
< /tmp/fcoreutils-test-data/checksum_abc.txt: OK
< /tmp/fcoreutils-test-data/checksum_fox.txt: OK
---
> /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified. (os error 3)
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified. (os error 3)
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fmd5sum: WARNING: 2 listed file could not be read
Ex
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c check valid
# GNU command:
md5sum -c '/tmp/fcoreutils_md5check_XSt937'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c '/tmp/fcoreutils_md5check_XSt937'
echo "fcoreutils exit: $?"

```

### sha256sum_abc_hash

**Diff:**
```
1c1
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - abc hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_UTF-8_CJK

**Diff:**
```
1c1
< 44 /tmp/fcoreutils-test-data/cjk.txt
---
> 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m UTF-8 CJK
# GNU command:
wc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### wc_dos_line_endings

**Diff:**
```
1c1
<  3  3 21 /tmp/fcoreutils-test-data/dos_endings.txt
---
>  3  3 21 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/dos_endings.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - dos line endings
# GNU command:
wc '/tmp/fcoreutils-test-data/dos_endings.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/dos_endings.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-c_--ignore-missing

**Diff:**
```
1d0
< md5sum: /tmp/fcoreutils_md5missing_vjVcfu: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --ignore-missing
# GNU command:
md5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_vjVcfu'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_vjVcfu'
echo "fcoreutils exit: $?"

```

### sha256sum_--tag_multiple_files

**Diff:**
```
1,2c1,2
< SHA256 (/tmp/fcoreutils-test-data/checksum_abc.txt) = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
< SHA256 (/tmp/fcoreutils-test-data/checksum_fox.txt) = d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592
---
> SHA256 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
> SHA256 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt) = d7a8f
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - --tag multiple files
# GNU command:
sha256sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-b_(binary_mode)

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -b (binary mode)
# GNU command:
b2sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### tac_-b_with_custom_separator

**Diff:**
```
1c1,7
< ---part3---part2part1
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac.exe --before [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -b with custom separator
# GNU command:
printf 'part1---part2---part3' | tac -b -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3' | ftac -b -s '---'
echo "fcoreutils exit: $?"

```

### md5sum_--tag_format

**Diff:**
```
1c1
< MD5 (/tmp/fcoreutils-test-data/checksum_abc.txt) = 900150983cd24fb0d6963f7d28e17f72
---
> MD5 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = 900150983cd24fb0d6963f7d28e17f72

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - --tag format
# GNU command:
md5sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_binary_file_with_null_bytes

**Diff:**
```
1c1
< 0 1 7 /tmp/fcoreutils-test-data/null_bytes.bin
---
> 0 1 7 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/null_bytes.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - binary file with null bytes
# GNU command:
wc '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "fcoreutils exit: $?"

```

### wc_-lwc_(all_three)

**Diff:**
```
1c1
<   1941  19372 101997 /tmp/fcoreutils-test-data/text_100k.txt
---
>   1941  19372 101997 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -lwc (all three)
# GNU command:
wc -lwc '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lwc '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-b_(binary_mode)

**Diff:**
```
1c1
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -b (binary mode)
# GNU command:
sha256sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_abc_known_hash

**Diff:**
```
1c1
< 900150983cd24fb0d6963f7d28e17f72 *-
---
> 900150983cd24fb0d6963f7d28e17f72  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - abc known hash
# GNU command:
printf 'abc' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
printf 'abc' | fmd5sum
echo "fcoreutils exit: $?"

```

### wc_10MB_file_-w

**Diff:**
```
1c1
< 1666809 /tmp/fcoreutils-test-data/text_10m.txt
---
> 1666809 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10MB file -w
# GNU command:
wc -w '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -w '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-l_512_(default_512-bit)

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -l 512 (default 512-bit)
# GNU command:
b2sum -l 512 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -l 512 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_empty_string_known_hash

**Diff:**
```
1c1
< d41d8cd98f00b204e9800998ecf8427e *-
---
> d41d8cd98f00b204e9800998ecf8427e  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - empty string known hash
# GNU command:
printf '' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
printf '' | fmd5sum
echo "fcoreutils exit: $?"

```

### b2sum_two_files

**Diff:**
```
1,2c1,2
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  C:/Use
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - two files
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### md5sum_10MB_text_hash

**Diff:**
```
1c1
< ad7bf7edeb9f383906e189b8d9caa266 */tmp/fcoreutils-test-data/text_10m.txt
---
> ad7bf7edeb9f383906e189b8d9caa266  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - 10MB text hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-t_(text_mode)

**Diff:**
```
1c1
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  /tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -t (text mode)
# GNU command:
sha256sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_two_files

**Diff:**
```
1,2c1,2
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
< d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-da
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - two files
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### tac_-r_regex_separator_(digits)

**Diff:**
```
1c1
< 98gamma765beta432alpha1
\ No newline at end of file
---
> gamma789beta456alpha123
\ No newline at end of file

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -r regex separator (digits)
# GNU command:
printf 'alpha123beta456gamma789' | tac -r -s '[0-9]+'
echo "GNU exit: $?"

# fcoreutils command:
printf 'alpha123beta456gamma789' | ftac -r -s '[0-9]+'
echo "fcoreutils exit: $?"

```

### wc_random_binary_1k

**Diff:**
```
1c1
<    5   35 1024 /tmp/fcoreutils-test-data/random_1k.bin
---
>    5   29 1024 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - random binary 1k
# GNU command:
wc '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### md5sum_binary_file_hash

**Diff:**
```
1c1
< 1b50f162817fe4307ff88e2255112f46 */tmp/fcoreutils-test-data/random_1k.bin
---
> 1b50f162817fe4307ff88e2255112f46  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - binary file hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### md5sum_-c_--quiet

**Diff:**
```
0a1,5
> /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified. (os error 3)
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified. (os error 3)
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fmd5sum: WARNING: 2 listed file could not be read
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --quiet
# GNU command:
md5sum -c --quiet '/tmp/fcoreutils_md5check_XSt937'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --quiet '/tmp/fcoreutils_md5check_XSt937'
echo "fcoreutils exit: $?"

```

### b2sum_fox_hash

**Diff:**
```
1c1
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - fox hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### wc_-w_empty

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -w empty
# GNU command:
wc -w '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -w '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_vs_-c_on_UTF-8

**Diff:**
```
1c1
< 14 /tmp/fcoreutils-test-data/utf8_multibyte.txt
---
> 14 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/utf8_multibyte.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m vs -c on UTF-8
# GNU command:
wc -m '/tmp/fcoreutils-test-data/utf8_multibyte.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/utf8_multibyte.txt'
echo "fcoreutils exit: $?"

```

### wc_-L_CJK

**Diff:**
```
1c1
< 11 /tmp/fcoreutils-test-data/cjk.txt
---
> 8 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L CJK
# GNU command:
wc -L '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_binary_file_hash

**Diff:**
```
1c1
< 802c88befafbef488d288559eb00c072943bc2b41ee26f4d1258182434f3291b */tmp/fcoreutils-test-data/random_1k.bin
---
> 802c88befafbef488d288559eb00c072943bc2b41ee26f4d1258182434f3291b  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - binary file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### md5sum_empty_file_hash

**Diff:**
```
1c1
< d41d8cd98f00b204e9800998ecf8427e */tmp/fcoreutils-test-data/checksum_empty.txt
---
> d41d8cd98f00b204e9800998ecf8427e  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - empty file hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "fcoreutils exit: $?"

```

### wc_10MB_file_-c

**Diff:**
```
1c1
< 10133420 /tmp/fcoreutils-test-data/text_10m.txt
---
> 10133420 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10MB file -c
# GNU command:
wc -c '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -c '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### wc_only_newlines

**Diff:**
```
1c1
< 3 0 3 /tmp/fcoreutils-test-data/only_newlines.txt
---
> 3 0 3 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/only_newlines.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - only newlines
# GNU command:
wc '/tmp/fcoreutils-test-data/only_newlines.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/only_newlines.txt'
echo "fcoreutils exit: $?"

```

### sort_already_sorted

**Diff:**
```
1,100c1,101
< aaaeijzrjruxnacvjhswxoyco
< aaaeq
< aaagywiitxovchwltd
< aaakjcdcvitv
< aaapo
< aaatkqhrzggrlffssqpldzncjvqazxjoqgymwveck
< aaavrjidsjnqvzllrgazmoltyrgphktmvlswchsmfdyqiaqvf
< aaaxctclwogujstislvdvyqdkyqxecgeuct
< aabbyclmbdgyamhthuwuwqsumuefjzgejzyabodotjg
< aabfuvqbkmmvdavwiuqutjikqnyquqpmczzumci
< aabjzvuyhevmolryksgqrftvhxstn
< aableqihcrnirhqybigxelpcxroxhmziysecvs
< aaboyiovpmj
< aabpx
< aabtjjcbdfpipabtllqnxoborwxufjutsjultao
< aabudmsqxpdwlnarkqsvpwgihhi
< aabwilbvawqbmukkm
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - already sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "fcoreutils exit: $?"

```

### b2sum_empty_string_stdin

**Diff:**
```
1c1
< 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce *-
---
> 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - empty string stdin
# GNU command:
printf '' | b2sum
echo "GNU exit: $?"

# fcoreutils command:
printf '' | fb2sum
echo "fcoreutils exit: $?"

```

### sha256sum_empty_string_known_hash

**Diff:**
```
1c1
< e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 *-
---
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - empty string known hash
# GNU command:
printf '' | sha256sum
echo "GNU exit: $?"

# fcoreutils command:
printf '' | fsha256sum
echo "fcoreutils exit: $?"

```

### wc_-c_text_file

**Diff:**
```
1c1
< 101997 /tmp/fcoreutils-test-data/text_100k.txt
---
> 101997 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -c text file
# GNU command:
wc -c '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -c '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### b2sum_10MB_binary_hash

**Diff:**
```
1c1
< 853a454f4d58a912e54da4a17232530d8340cd8c2ab6894ffa1c16f093dc0d0b8674b16d6880be5cf7ae4e8b6e91a93e08985f3765c1956a8570fd8a31c743ea */tmp/fcoreutils-test-data/random_10m.bin
---
> 853a454f4d58a912e54da4a17232530d8340cd8c2ab6894ffa1c16f093dc0d0b8674b16d6880be5cf7ae4e8b6e91a93e08985f3765c1956a8570fd8a31c743ea  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - 10MB binary hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "fcoreutils exit: $?"

```

### wc_with_trailing_newline

**Diff:**
```
1c1
< 1 1 6 /tmp/fcoreutils-test-data/with_trailing_newline.txt
---
> 1 1 6 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/with_trailing_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - with trailing newline
# GNU command:
wc '/tmp/fcoreutils-test-data/with_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/with_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_stdin_binary_data

**Diff:**
```
1c1
< 802c88befafbef488d288559eb00c072943bc2b41ee26f4d1258182434f3291b *-
---
> 802c88befafbef488d288559eb00c072943bc2b41ee26f4d1258182434f3291b  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - stdin binary data
# GNU command:
cat '/tmp/fcoreutils-test-data/random_1k.bin' | sha256sum
echo "GNU exit: $?"

# fcoreutils command:
cat '/tmp/fcoreutils-test-data/random_1k.bin' | fsha256sum
echo "fcoreutils exit: $?"

```

### md5sum_abc_hash

**Diff:**
```
1c1
< 900150983cd24fb0d6963f7d28e17f72 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> 900150983cd24fb0d6963f7d28e17f72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - abc hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### b2sum_CSV_file_hash

**Diff:**
```
1c1
< db4825991ce51e3533c381dc23011f454da850e107c6046c6e6b00b89b321f183c50acd0e62cbecc771255d2a38bd5506f05e8c90a5b1536064b3efdd58e9dd1 */tmp/fcoreutils-test-data/simple.csv
---
> db4825991ce51e3533c381dc23011f454da850e107c6046c6e6b00b89b321f183c50acd0e62cbecc771255d2a38bd5506f05e8c90a5b1536064b3efdd58e9dd1  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - CSV file hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_three_files_with_flags

**Diff:**
```
1,3c1,3
<   4   5 /tmp/fcoreutils-test-data/simple.csv
<   9   9 /tmp/fcoreutils-test-data/unsorted.txt
<   9   9 /tmp/fcoreutils-test-data/duplicates.txt
---
>   4   5 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv
>   9   9 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/unsorted.txt
>   9   9 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/duplicates.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - three files with flags
# GNU command:
wc -lw '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt' '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lw '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt' '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### wc_-l_only_newlines

**Diff:**
```
1c1
< 3 /tmp/fcoreutils-test-data/only_newlines.txt
---
> 3 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/only_newlines.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -l only newlines
# GNU command:
wc -l '/tmp/fcoreutils-test-data/only_newlines.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -l '/tmp/fcoreutils-test-data/only_newlines.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-l_128_(128-bit_output)

**Diff:**
```
1c1
< cf4ab791c62b8d2b2109c90275287816 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> cf4ab791c62b8d2b2109c90275287816  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -l 128 (128-bit output)
# GNU command:
b2sum -l 128 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -l 128 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-z_output

**Diff:**
```
Binary files /tmp/gnu_output_4737 and /tmp/f_output_4737 differ

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -z output
# GNU command:
sha256sum -z '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -z '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-z_output

**Diff:**
```
Binary files /tmp/gnu_output_5662 and /tmp/f_output_5662 differ

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -z output
# GNU command:
md5sum -z '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -z '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_check_valid_checksums

**Diff:**
```
1,2c1,5
< /tmp/fcoreutils-test-data/checksum_abc.txt: OK
< /tmp/fcoreutils-test-data/checksum_fox.txt: OK
---
> fsha256sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> fsha256sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fsha256sum: WARNING: 2 listed files could not be read

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c check valid checksums
# GNU command:
sha256sum -c '/tmp/fcoreutils_checksums_hL36aY'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c '/tmp/fcoreutils_checksums_hL36aY'
echo "fcoreutils exit: $?"

```

### wc_spaces_no_newline

**Diff:**
```
1c1
< 0 0 3 /tmp/fcoreutils-test-data/spaces_no_newline.txt
---
> 0 0 3 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/spaces_no_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - spaces no newline
# GNU command:
wc '/tmp/fcoreutils-test-data/spaces_no_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/spaces_no_newline.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-l_256_(256-bit_output)

**Diff:**
```
1c1
< bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -l 256 (256-bit output)
# GNU command:
b2sum -l 256 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -l 256 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_-w_whitespace_only

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/whitespace_only.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/whitespace_only.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -w whitespace only
# GNU command:
wc -w '/tmp/fcoreutils-test-data/whitespace_only.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -w '/tmp/fcoreutils-test-data/whitespace_only.txt'
echo "fcoreutils exit: $?"

```

### wc_-L_with_tabs_(tab_stop_at_8)

**Diff:**
```
1c1
< 17 /tmp/fcoreutils-test-data/tabs.txt
---
> 17 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/tabs.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L with tabs (tab stop at 8)
# GNU command:
wc -L '/tmp/fcoreutils-test-data/tabs.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/tabs.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_combining_umlaut

**Diff:**
```
1c1
< 4 /tmp/fcoreutils-test-data/combining_umlaut.txt
---
> 4 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/combining_umlaut.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m combining umlaut
# GNU command:
wc -m '/tmp/fcoreutils-test-data/combining_umlaut.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/combining_umlaut.txt'
echo "fcoreutils exit: $?"

```

### tac_stdin_no_final_newline

**Diff:**
```
1c1,2
< cb
---
> c
> b

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - stdin no final newline
# GNU command:
printf 'a\nb\nc' | tac
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\nb\nc' | ftac
echo "fcoreutils exit: $?"

```

### wc_-L_only_tabs

**Diff:**
```
1c1
< 24 /tmp/fcoreutils-test-data/only_tabs.txt
---
> 24 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/only_tabs.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L only tabs
# GNU command:
wc -L '/tmp/fcoreutils-test-data/only_tabs.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/only_tabs.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_fox_hash

**Diff:**
```
1c1
< d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - fox hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_stdin_hash

**Diff:**
```
1c1
< fec91c70284c72d0d4e3684788a90de9338a5b2f47f01fedbe203cafd68708718ae5672d10eca804a8121904047d40d1d6cf11e7a76419357a9469af41f22d01 *-
---
> fec91c70284c72d0d4e3684788a90de9338a5b2f47f01fedbe203cafd68708718ae5672d10eca804a8121904047d40d1d6cf11e7a76419357a9469af41f22d01  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - stdin hash
# GNU command:
echo 'hello world' | b2sum
echo "GNU exit: $?"

# fcoreutils command:
echo 'hello world' | fb2sum
echo "fcoreutils exit: $?"

```

### wc_1MB_line_-L

**Diff:**
```
1c1
< 1048576 /tmp/fcoreutils-test-data/long_line_1m.txt
---
> 1048576 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/long_line_1m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 1MB line -L
# GNU command:
wc -L '/tmp/fcoreutils-test-data/long_line_1m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/long_line_1m.txt'
echo "fcoreutils exit: $?"

```

### b2sum_100_files

**Diff:**
```
1,100c1,100
< af40a0d5d3e24cd8d9e6beb33ff5b1af5fc3154238a36150a0ce5f9798944807f298377440919a4d9db021d48a32c7c46711192dc3c706e8302aaecca43fe71c */tmp/fcoreutils-test-data/many_files/file_0001.txt
< 9347c8272d0ca029edfa94e9f444d54a05d5c72b4dc7c306ee37825803a972b8cc506f10e0ac1ba955629c87cab3f47dce6f648ba99666c95546bedaf3047d12 */tmp/fcoreutils-test-data/many_files/file_0002.txt
< aa54ece2b90b390155ed695829d8d71f8a249f701a5a23c0543865539ce45cce40af6290609dd4a2da51f1f22fbff57ddf8f02ebb918e3e56336519d
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - 100 files
# GNU command:
eval b2sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "GNU exit: $?"

# fcoreutils command:
eval fb2sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "fcoreutils exit: $?"

```

### wc_-L_long_line_10k

**Diff:**
```
1c1
< 10000 /tmp/fcoreutils-test-data/long_line_10k.txt
---
> 10000 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/long_line_10k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L long line 10k
# GNU command:
wc -L '/tmp/fcoreutils-test-data/long_line_10k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/long_line_10k.txt'
echo "fcoreutils exit: $?"

```

### wc_-c_empty

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -c empty
# GNU command:
wc -c '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -c '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### b2sum_binary_file_hash

**Diff:**
```
1c1
< 423b7ec64cee09934fb1ddaa1ffc1e27be1f437e376294ecccc21f90bc48ba28ca33c4df548bef2965e3baea9a8702ca99b8020baed265037034d189c48152f3 */tmp/fcoreutils-test-data/random_1k.bin
---
> 423b7ec64cee09934fb1ddaa1ffc1e27be1f437e376294ecccc21f90bc48ba28ca33c4df548bef2965e3baea9a8702ca99b8020baed265037034d189c48152f3  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - binary file hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### wc_10MB_file_all_flags

**Diff:**
```
1c1
<   133358  1666809 10133420 10133420      164 /tmp/fcoreutils-test-data/text_10m.txt
---
>   133358  1666809 10133420 10133420      164 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10MB file all flags
# GNU command:
wc -lwcmL '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lwcmL '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### md5sum_10MB_binary_hash

**Diff:**
```
1c1
< 7f902a2a6fbdd42ac95a9ef78e8cbdba */tmp/fcoreutils-test-data/random_10m.bin
---
> 7f902a2a6fbdd42ac95a9ef78e8cbdba  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - 10MB binary hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "fcoreutils exit: $?"

```

### wc_-L_tab_at_position_8

**Diff:**
```
1c1
< 11 /tmp/fcoreutils-test-data/tab_at_8.txt
---
> 11 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/tab_at_8.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L tab at position 8
# GNU command:
wc -L '/tmp/fcoreutils-test-data/tab_at_8.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/tab_at_8.txt'
echo "fcoreutils exit: $?"

```

### tac_no_trailing_newline

**Diff:**
```
1c1,2
< line 3line 2
---
> line 3
> line 2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - no trailing newline
# GNU command:
tac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
ftac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_three_files

**Diff:**
```
1,3c1,3
< e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 */tmp/fcoreutils-test-data/checksum_empty.txt
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
< d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt
> ba7816
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - three files
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_--tag_format

**Diff:**
```
1c1
< BLAKE2b (/tmp/fcoreutils-test-data/checksum_abc.txt) = ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
---
> BLAKE2b (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - --tag format
# GNU command:
b2sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### cut_tab_delimiter_explicit

**Diff:**
```
1,2c1
< cut: the delimiter must be a single character
< Try 'cut --help' for more information.
---
> fcut: the delimiter must be a single character

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: cut - tab delimiter explicit
# GNU command:
printf 'a\tb\tc\n' | cut -d'\t' -f2
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\tb\tc\n' | fcut -d'\t' -f2
echo "fcoreutils exit: $?"

```

### b2sum_--tag_multiple_files

**Diff:**
```
1,2c1,2
< BLAKE2b (/tmp/fcoreutils-test-data/checksum_abc.txt) = ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
< BLAKE2b (/tmp/fcoreutils-test-data/checksum_fox.txt) = a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918
---
> BLAKE2b (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = ba80a53f981c4d0d6a2797b69f1
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - --tag multiple files
# GNU command:
b2sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-l_64_(64-bit_output)

**Diff:**
```
1c1
< d8bb14d833d59559 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> d8bb14d833d59559  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -l 64 (64-bit output)
# GNU command:
b2sum -l 64 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -l 64 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_text_with_embedded_nulls

**Diff:**
```
1c1
<  1  1 16 /tmp/fcoreutils-test-data/text_with_nulls.txt
---
>  1  1 16 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_with_nulls.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - text with embedded nulls
# GNU command:
wc '/tmp/fcoreutils-test-data/text_with_nulls.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/text_with_nulls.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_ASCII_file

**Diff:**
```
1c1
< 63 /tmp/fcoreutils-test-data/simple.csv
---
> 63 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m ASCII file
# GNU command:
wc -m '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_empty_file

**Diff:**
```
1c1
< 0 0 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 0 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - empty file
# GNU command:
wc '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### wc_1MB_file_default

**Diff:**
```
1c1
<   19399  193964 1019451 /tmp/fcoreutils-test-data/text_1m.txt
---
>   19399  193964 1019451 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_1m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 1MB file default
# GNU command:
wc '/tmp/fcoreutils-test-data/text_1m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/text_1m.txt'
echo "fcoreutils exit: $?"

```

### wc_-L_simple_text

**Diff:**
```
1c1
< 17 /tmp/fcoreutils-test-data/simple.csv
---
> 17 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L simple text
# GNU command:
wc -L '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_multiple_files_total_line

**Diff:**
```
1,2c1,2
<   4   5  63 /tmp/fcoreutils-test-data/simple.csv
<   9   9  59 /tmp/fcoreutils-test-data/unsorted.txt
---
>   4   5  63 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv
>   9   9  59 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/unsorted.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - multiple files total line
# GNU command:
wc '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=C_-m_char_count

**Diff:**
```
1c1
< 44 /tmp/fcoreutils-test-data/cjk.txt
---
> 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=C -m char count
# GNU command:
LC_ALL=C wc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=C fwc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### wc_-lc_(lines_and_bytes)

**Diff:**
```
1c1
<   1941 101997 /tmp/fcoreutils-test-data/text_100k.txt
---
>   1941 101997 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -lc (lines and bytes)
# GNU command:
wc -lc '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lc '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_CSV_file_hash

**Diff:**
```
1c1
< 9a583d626afcfce6a312a7ce22ac0abc4f0ec7263e18f258e0a3959b9a7242f1 */tmp/fcoreutils-test-data/simple.csv
---
> 9a583d626afcfce6a312a7ce22ac0abc4f0ec7263e18f258e0a3959b9a7242f1  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - CSV file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_-cm_(chars_and_bytes_mismatch_on_UTF-8)

**Diff:**
```
1c1
< 44 44 /tmp/fcoreutils-test-data/cjk.txt
---
> 44 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -cm (chars and bytes mismatch on UTF-8)
# GNU command:
wc -cm '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -cm '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### md5sum_two_files

**Diff:**
```
1,2c1,2
< 900150983cd24fb0d6963f7d28e17f72 */tmp/fcoreutils-test-data/checksum_abc.txt
< 9e107d9d372bb6826bd81d3542a419d6 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> 900150983cd24fb0d6963f7d28e17f72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> 9e107d9d372bb6826bd81d3542a419d6  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - two files
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### wc_10MB_file_-l

**Diff:**
```
1c1
< 133358 /tmp/fcoreutils-test-data/text_10m.txt
---
> 133358 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10MB file -l
# GNU command:
wc -l '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -l '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### tac_-s_custom_separator_(---)

**Diff:**
```
1c1,7
< part3---part2---part1---
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac.exe [OPTIONS] [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -s custom separator (---)
# GNU command:
printf 'part1---part2---part3---' | tac -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3---' | ftac -s '---'
echo "fcoreutils exit: $?"

```

### b2sum_-c_check_valid

**Diff:**
```
1,2c1,5
< /tmp/fcoreutils-test-data/checksum_abc.txt: OK
< /tmp/fcoreutils-test-data/checksum_fox.txt: OK
---
> fb2sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> fb2sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fb2sum: WARNING: 2 listed files could not be read
Exit code mi
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -c check valid
# GNU command:
b2sum -c '/tmp/fcoreutils_b2check_CokeqU'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -c '/tmp/fcoreutils_b2check_CokeqU'
echo "fcoreutils exit: $?"

```

### sha256sum_10MB_file_hash

**Diff:**
```
1c1
< 6fc4c14f0bfd2e1d5332d4262ae623af5d2438546485c7b7f60c81c3603b9262 */tmp/fcoreutils-test-data/text_10m.txt
---
> 6fc4c14f0bfd2e1d5332d4262ae623af5d2438546485c7b7f60c81c3603b9262  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - 10MB file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### md5sum_CSV_file_hash

**Diff:**
```
1c1
< 80a19a7c7a935063e1c83b5cbcae48db */tmp/fcoreutils-test-data/simple.csv
---
> 80a19a7c7a935063e1c83b5cbcae48db  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - CSV file hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_--files0-from

**Diff:**
```
1,3c1,2
<   4   5  63 /tmp/fcoreutils-test-data/simple.csv
<   9   9  59 /tmp/fcoreutils-test-data/unsorted.txt
<  13  14 122 total
---
> fwc: /tmp/fcoreutils-test-data/simple.csv: The system cannot find the path specified. (os error 3)
> fwc: /tmp/fcoreutils-test-data/unsorted.txt: The system cannot find the path specified. (os error 3)
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - --files0-from
# GNU command:
wc --files0-from='/tmp/fcoreutils_filelist_wZrSjP'
echo "GNU exit: $?"

# fcoreutils command:
fwc --files0-from='/tmp/fcoreutils_filelist_wZrSjP'
echo "fcoreutils exit: $?"

```

### wc_tabs_no_newline

**Diff:**
```
1c1
< 0 0 3 /tmp/fcoreutils-test-data/tabs_no_newline.txt
---
> 0 0 3 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/tabs_no_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - tabs no newline
# GNU command:
wc '/tmp/fcoreutils-test-data/tabs_no_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/tabs_no_newline.txt'
echo "fcoreutils exit: $?"

```

### b2sum_three_files

**Diff:**
```
1,3c1,3
< 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce */tmp/fcoreutils-test-data/checksum_empty.txt
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fco
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - three files
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-t_(text_mode)

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  /tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -t (text mode)
# GNU command:
b2sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-b_(binary_mode)

**Diff:**
```
1c1
< 900150983cd24fb0d6963f7d28e17f72 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> 900150983cd24fb0d6963f7d28e17f72 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -b (binary mode)
# GNU command:
md5sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_empty

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m empty
# GNU command:
wc -m '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### sort_10MB_already_sorted

**Diff:**
```
1c1
< 53561bd29cf3a725351e07664548d5c3 *-
---
> f602b458d573dbf0f44fac392c682a55 *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - 10MB already sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/sorted_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/sorted_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### b2sum_abc_hash

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - abc hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_stdin_binary_data

**Diff:**
```
1c1
< 1b50f162817fe4307ff88e2255112f46 *-
---
> 1b50f162817fe4307ff88e2255112f46  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - stdin binary data
# GNU command:
cat '/tmp/fcoreutils-test-data/random_1k.bin' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
cat '/tmp/fcoreutils-test-data/random_1k.bin' | fmd5sum
echo "fcoreutils exit: $?"

```

### wc_-l_no_trailing_newline

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/no_trailing_newline.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/no_trailing_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -l no trailing newline
# GNU command:
wc -l '/tmp/fcoreutils-test-data/no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -l '/tmp/fcoreutils-test-data/no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### wc_CR-only_endings

**Diff:**
```
1c1
<  0  3 18 /tmp/fcoreutils-test-data/cr_endings.txt
---
>  0  3 18 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cr_endings.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - CR-only endings
# GNU command:
wc '/tmp/fcoreutils-test-data/cr_endings.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/cr_endings.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-c_--status

**Diff:**
```

Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --status
# GNU command:
md5sum -c --status '/tmp/fcoreutils_md5check_XSt937'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --status '/tmp/fcoreutils_md5check_XSt937'
echo "fcoreutils exit: $?"

```

### b2sum_abc_stdin

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *-
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - abc stdin
# GNU command:
printf 'abc' | b2sum
echo "GNU exit: $?"

# fcoreutils command:
printf 'abc' | fb2sum
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--ignore-missing

**Diff:**
```
1d0
< sha256sum: /tmp/fcoreutils_missingcheck_oV2313: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --ignore-missing
# GNU command:
sha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_oV2313'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_oV2313'
echo "fcoreutils exit: $?"

```

### sha256sum_10MB_binary_hash

**Diff:**
```
1c1
< 2377af025644a05e733d363674c3835eef3cfbf241aa84b44a397636045a5833 */tmp/fcoreutils-test-data/random_10m.bin
---
> 2377af025644a05e733d363674c3835eef3cfbf241aa84b44a397636045a5833  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - 10MB binary hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "fcoreutils exit: $?"

```

### sort_10MB_reverse_sorted

**Diff:**
```
1c1
< 53561bd29cf3a725351e07664548d5c3 *-
---
> f602b458d573dbf0f44fac392c682a55 *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - 10MB reverse sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/reverse_sorted_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/reverse_sorted_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### sha256sum_100_files

**Diff:**
```
1,100c1,100
< c2b26e44665c599bcac768a6313f07c6594969867c72f4ce950cd3951d218619 */tmp/fcoreutils-test-data/many_files/file_0001.txt
< 335705b42b7f43282dd4c82598a7d1c671e19eae44a20eee7db1486e436ed621 */tmp/fcoreutils-test-data/many_files/file_0002.txt
< 230af3048c94e1609125b9bd57c4d6cc0524d5bdc5e65dbcbf738d5cf3bfcb0a */tmp/fcoreutils-test-data/many_files/file_0003.txt
< 4466d9fbe5cebe445eaee45a7ba0c44562408c82532f77e67845129450af78b3 */tmp/fcoreutils-test-data/many_files/file_0004.txt
< 6150bdaece
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - 100 files
# GNU command:
eval sha256sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "GNU exit: $?"

# fcoreutils command:
eval fsha256sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "fcoreutils exit: $?"

```

### wc_unix_line_endings

**Diff:**
```
1c1
<  3  3 18 /tmp/fcoreutils-test-data/unix_endings.txt
---
>  3  3 18 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/unix_endings.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - unix line endings
# GNU command:
wc '/tmp/fcoreutils-test-data/unix_endings.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/unix_endings.txt'
echo "fcoreutils exit: $?"

```

### wc_-c_binary_file

**Diff:**
```
1c1
< 1024 /tmp/fcoreutils-test-data/random_1k.bin
---
> 1024 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -c binary file
# GNU command:
wc -c '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc -c '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### wc_-m_emoji

**Diff:**
```
1c1
< 26 /tmp/fcoreutils-test-data/emoji.txt
---
> 26 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/emoji.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m emoji
# GNU command:
wc -m '/tmp/fcoreutils-test-data/emoji.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/emoji.txt'
echo "fcoreutils exit: $?"

```

### wc_-w_text_file

**Diff:**
```
1c1
< 19372 /tmp/fcoreutils-test-data/text_100k.txt
---
> 19372 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -w text file
# GNU command:
wc -w '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -w '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### wc_whitespace_only_file

**Diff:**
```
1c1
<  3  0 19 /tmp/fcoreutils-test-data/whitespace_only.txt
---
>  3  0 19 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/whitespace_only.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - whitespace only file
# GNU command:
wc '/tmp/fcoreutils-test-data/whitespace_only.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/whitespace_only.txt'
echo "fcoreutils exit: $?"

```

### md5sum_stdin_hash

**Diff:**
```
1c1
< 6f5902ac237024bdd0c176cb93063dc4 *-
---
> 6f5902ac237024bdd0c176cb93063dc4  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - stdin hash
# GNU command:
echo 'hello world' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
echo 'hello world' | fmd5sum
echo "fcoreutils exit: $?"

```

### sha256sum_--tag_format

**Diff:**
```
1c1
< SHA256 (/tmp/fcoreutils-test-data/checksum_abc.txt) = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
---
> SHA256 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - --tag format
# GNU command:
sha256sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_10KB_line

**Diff:**
```
1c1
<     1     1 10002 /tmp/fcoreutils-test-data/long_line_10k.txt
---
>     1     1 10002 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/long_line_10k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10KB line
# GNU command:
wc '/tmp/fcoreutils-test-data/long_line_10k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/long_line_10k.txt'
echo "fcoreutils exit: $?"

```

### wc_single_byte_file

**Diff:**
```
1c1
< 0 1 1 /tmp/fcoreutils-test-data/single_byte.txt
---
> 0 1 1 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/single_byte.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - single byte file
# GNU command:
wc '/tmp/fcoreutils-test-data/single_byte.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/single_byte.txt'
echo "fcoreutils exit: $?"

```

### wc_-l_text_file

**Diff:**
```
1c1
< 1941 /tmp/fcoreutils-test-data/text_100k.txt
---
> 1941 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -l text file
# GNU command:
wc -l '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -l '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### md5sum_100_files

**Diff:**
```
1,100c1,100
< 64caaade85e35cf456b1819b4e5f298c */tmp/fcoreutils-test-data/many_files/file_0001.txt
< 42bf43424b1d47e55121cd14df6c28f3 */tmp/fcoreutils-test-data/many_files/file_0002.txt
< f15330bfbd37c8d666514cfe2509bf13 */tmp/fcoreutils-test-data/many_files/file_0003.txt
< 7b6c188acbd77eecdce37b61f6af73b9 */tmp/fcoreutils-test-data/many_files/file_0004.txt
< dc8bdadd897529e1739f8a3d536dd8c0 */tmp/fcoreutils-test-data/many_files/file_0005.txt
< c13d7486efc9565b9202b16332a8dd84 */tmp/fcoreutils-t
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - 100 files
# GNU command:
eval md5sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "GNU exit: $?"

# fcoreutils command:
eval fmd5sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "fcoreutils exit: $?"

```

### wc_two_files

**Diff:**
```
1,2c1,2
<   4   5  63 /tmp/fcoreutils-test-data/simple.csv
<   9   9  59 /tmp/fcoreutils-test-data/unsorted.txt
---
>   4   5  63 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv
>   9   9  59 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/unsorted.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - two files
# GNU command:
wc '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt'
echo "fcoreutils exit: $?"

```

### wc_-lw_(lines_and_words)

**Diff:**
```
1c1
<   1941  19372 /tmp/fcoreutils-test-data/text_100k.txt
---
>   1941  19372 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -lw (lines and words)
# GNU command:
wc -lw '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lw '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### md5sum_--tag_multiple_files

**Diff:**
```
1,2c1,2
< MD5 (/tmp/fcoreutils-test-data/checksum_abc.txt) = 900150983cd24fb0d6963f7d28e17f72
< MD5 (/tmp/fcoreutils-test-data/checksum_fox.txt) = 9e107d9d372bb6826bd81d3542a419d6
---
> MD5 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = 900150983cd24fb0d6963f7d28e17f72
> MD5 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt) = 9e107d9d372bb6826bd81d3542a419d6

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - --tag multiple files
# GNU command:
md5sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_empty_file_hash

**Diff:**
```
1c1
< 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce */tmp/fcoreutils-test-data/checksum_empty.txt
---
> 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - empty file hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=C_default_count

**Diff:**
```
1c1
<  3  5 44 /tmp/fcoreutils-test-data/cjk.txt
---
>  3  4 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=C default count
# GNU command:
LC_ALL=C wc '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=C fwc '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=en_US.UTF-8_-m_char_count

**Diff:**
```
1c1
< 22 /tmp/fcoreutils-test-data/cjk.txt
---
> 22 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=en_US.UTF-8 -m char count
# GNU command:
LC_ALL=en_US.UTF-8 wc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=en_US.UTF-8 fwc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### wc_-Lw_(max_line_and_words)

**Diff:**
```
1c1
<  5 17 /tmp/fcoreutils-test-data/simple.csv
---
>  5 17 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -Lw (max line and words)
# GNU command:
wc -Lw '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fwc -Lw '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_no_trailing_newline

**Diff:**
```
1c1
< 0 1 5 /tmp/fcoreutils-test-data/no_trailing_newline.txt
---
> 0 1 5 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/no_trailing_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - no trailing newline
# GNU command:
wc '/tmp/fcoreutils-test-data/no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_empty_file_hash

**Diff:**
```
1c1
< e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 */tmp/fcoreutils-test-data/checksum_empty.txt
---
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - empty file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--quiet_valid_checksums

**Diff:**
```
0a1,5
> fsha256sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> fsha256sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fsha256sum: WARNING: 2 listed files could not be read
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --quiet valid checksums
# GNU command:
sha256sum -c --quiet '/tmp/fcoreutils_checksums_hL36aY'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --quiet '/tmp/fcoreutils_checksums_hL36aY'
echo "fcoreutils exit: $?"

```

### sha256sum_stdin_hash

**Diff:**
```
1c1
< a948904f2f0f479b8f8197694b30184b0d2ed1c1cd2a1ec0fb85d299a192a447 *-
---
> a948904f2f0f479b8f8197694b30184b0d2ed1c1cd2a1ec0fb85d299a192a447  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - stdin hash
# GNU command:
echo 'hello world' | sha256sum
echo "GNU exit: $?"

# fcoreutils command:
echo 'hello world' | fsha256sum
echo "fcoreutils exit: $?"

```

### sha256sum_UTF-8_file_hash

**Diff:**
```
1c1
< e8071c6ca8997c90d608c3cf28b310c39a7787730f7d14f44d0bf94442f9e9b3 */tmp/fcoreutils-test-data/cjk.txt
---
> e8071c6ca8997c90d608c3cf28b310c39a7787730f7d14f44d0bf94442f9e9b3  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - UTF-8 file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### md5sum_three_files

**Diff:**
```
1,3c1,3
< d41d8cd98f00b204e9800998ecf8427e */tmp/fcoreutils-test-data/checksum_empty.txt
< 900150983cd24fb0d6963f7d28e17f72 */tmp/fcoreutils-test-data/checksum_abc.txt
< 9e107d9d372bb6826bd81d3542a419d6 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> d41d8cd98f00b204e9800998ecf8427e  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt
> 900150983cd24fb0d6963f7d28e17f72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> 9e107d9d372bb6826bd81d3
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - three files
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### wc_single_newline

**Diff:**
```
1c1
< 1 0 1 /tmp/fcoreutils-test-data/single_newline.txt
---
> 1 0 1 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/single_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - single newline
# GNU command:
wc '/tmp/fcoreutils-test-data/single_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/single_newline.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_file_with_null_bytes

**Diff:**
```
1c1
< 2b4377fbe075e03f60af522ba83f77fba18a3e24ee1db3348beba889535e6500 */tmp/fcoreutils-test-data/null_bytes.bin
---
> 2b4377fbe075e03f60af522ba83f77fba18a3e24ee1db3348beba889535e6500  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/null_bytes.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - file with null bytes
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "fcoreutils exit: $?"

```

### wc_1MB_line

**Diff:**
```
1c1
<       1       1 1048578 /tmp/fcoreutils-test-data/long_line_1m.txt
---
>       1       1 1048578 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/long_line_1m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 1MB line
# GNU command:
wc '/tmp/fcoreutils-test-data/long_line_1m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/long_line_1m.txt'
echo "fcoreutils exit: $?"

```

### wc_mixed_line_endings

**Diff:**
```
1c1
<  3  4 25 /tmp/fcoreutils-test-data/mixed_endings.txt
---
>  3  4 25 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/mixed_endings.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - mixed line endings
# GNU command:
wc '/tmp/fcoreutils-test-data/mixed_endings.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/mixed_endings.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_abc_known_hash

**Diff:**
```
1c1
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad *-
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - abc known hash
# GNU command:
printf 'abc' | sha256sum
echo "GNU exit: $?"

# fcoreutils command:
printf 'abc' | fsha256sum
echo "fcoreutils exit: $?"

```

### md5sum_fox_hash

**Diff:**
```
1c1
< 9e107d9d372bb6826bd81d3542a419d6 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> 9e107d9d372bb6826bd81d3542a419d6  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - fox hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### sort_10MB_random_sort

**Diff:**
```
1c1
< 53561bd29cf3a725351e07664548d5c3 *-
---
> f602b458d573dbf0f44fac392c682a55 *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - 10MB random sort
# GNU command:
sort '/tmp/fcoreutils-test-data/random_lines_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/random_lines_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### sha256sum_binary_marker_()

**Diff:**
```
1c1
< 802c88befafbef488d288559eb00c072943bc2b41ee26f4d1258182434f3291b */tmp/fcoreutils-test-data/random_1k.bin
---
> 802c88befafbef488d288559eb00c072943bc2b41ee26f4d1258182434f3291b *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - binary marker (*)
# GNU command:
sha256sum -b '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -b '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### md5sum_-c_--ignore-missing

**Diff:**
```
1d0
< md5sum: /tmp/fcoreutils_md5missing_8jsy9l: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --ignore-missing
# GNU command:
md5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_8jsy9l'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_8jsy9l'
echo "fcoreutils exit: $?"

```

### tac_-b_with_custom_separator

**Diff:**
```
1c1,7
< ---part3---part2part1
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac --before [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -b with custom separator
# GNU command:
printf 'part1---part2---part3' | tac -b -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3' | ftac -b -s '---'
echo "fcoreutils exit: $?"

```

### tac_-r_regex_separator_(digits)

**Diff:**
```
1c1
< 98gamma765beta432alpha1
\ No newline at end of file
---
> gamma789beta456alpha123
\ No newline at end of file

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -r regex separator (digits)
# GNU command:
printf 'alpha123beta456gamma789' | tac -r -s '[0-9]+'
echo "GNU exit: $?"

# fcoreutils command:
printf 'alpha123beta456gamma789' | ftac -r -s '[0-9]+'
echo "fcoreutils exit: $?"

```

### sort_-d_dictionary_order

**Diff:**
```
2d1
< hello_world
3a3
> hello_world

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - -d dictionary order
# GNU command:
printf 'hello world\nhello-world\nhello_world\nhelloworld\n' | sort -d
echo "GNU exit: $?"

# fcoreutils command:
printf 'hello world\nhello-world\nhello_world\nhelloworld\n' | fsort -d
echo "fcoreutils exit: $?"

```

### sort_already_sorted

**Diff:**
```
101,102c101
< sort: write failed: 'standard output': Broken pipe
< sort: write error: Broken pipe
---
> fsort: Broken pipe (os error 32)

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - already sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "fcoreutils exit: $?"

```

### tac_stdin_no_final_newline

**Diff:**
```
1c1,2
< cb
---
> c
> b

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - stdin no final newline
# GNU command:
printf 'a\nb\nc' | tac
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\nb\nc' | ftac
echo "fcoreutils exit: $?"

```

### tac_no_trailing_newline

**Diff:**
```
1c1,2
< line 3line 2
---
> line 3
> line 2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - no trailing newline
# GNU command:
tac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
ftac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### cut_tab_delimiter_explicit

**Diff:**
```
1,2c1
< cut: the delimiter must be a single character
< Try 'cut --help' for more information.
---
> fcut: the delimiter must be a single character

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: cut - tab delimiter explicit
# GNU command:
printf 'a\tb\tc\n' | cut -d'\t' -f2
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\tb\tc\n' | fcut -d'\t' -f2
echo "fcoreutils exit: $?"

```

### tac_-s_custom_separator_(---)

**Diff:**
```
1c1,7
< part3---part2---part1---
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac [OPTIONS] [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -s custom separator (---)
# GNU command:
printf 'part1---part2---part3---' | tac -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3---' | ftac -s '---'
echo "fcoreutils exit: $?"

```

### sort_-k3_(sort_by_field_3)

**Diff:**
```
1d0
< name,age,city
4a4
> name,age,city

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - -k3 (sort by field 3)
# GNU command:
sort -t, -k3 '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fsort -t, -k3 '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--ignore-missing

**Diff:**
```
1d0
< sha256sum: /tmp/fcoreutils_missingcheck_H7SH85: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --ignore-missing
# GNU command:
sha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_H7SH85'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_H7SH85'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=C_default_count

**Diff:**
```
1c1
<  3  5 44 /tmp/fcoreutils-test-data/cjk.txt
---
>  3  4 44 /tmp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=C default count
# GNU command:
LC_ALL=C wc '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=C fwc '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-t_(text_mode)

**Diff:**
```
1c1
< 900150983cd24fb0d6963f7d28e17f72  /tmp/fcoreutils-test-data/checksum_abc.txt
---
> 900150983cd24fb0d6963f7d28e17f72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -t (text mode)
# GNU command:
md5sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--status_valid_checksums

**Diff:**
```

Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --status valid checksums
# GNU command:
sha256sum -c --status '/tmp/fcoreutils_checksums_giSE6R'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --status '/tmp/fcoreutils_checksums_giSE6R'
echo "fcoreutils exit: $?"

```

### wc_-l_empty

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L empty
# GNU command:
wc -L '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### b2sum_10MB_text_hash

**Diff:**
```
1c1
< db738d1cc80315f5f522d88a30beccd36390fdc8169b1081f0ab391ee57de165246308b6a6d1bd8020298329d7a8121b7a08c9a0c40f94a4f021365d6737ea72 */tmp/fcoreutils-test-data/text_10m.txt
---
> db738d1cc80315f5f522d88a30beccd36390fdc8169b1081f0ab391ee57de165246308b6a6d1bd8020298329d7a8121b7a08c9a0c40f94a4f021365d6737ea72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - 10MB text hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### md5sum_fox_known_hash

**Diff:**
```
1c1
< 9e107d9d372bb6826bd81d3542a419d6 *-
---
> 9e107d9d372bb6826bd81d3542a419d6  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - fox known hash
# GNU command:
printf 'The quick brown fox jumps over the lazy dog' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
printf 'The quick brown fox jumps over the lazy dog' | fmd5sum
echo "fcoreutils exit: $?"

```

### md5sum_-c_check_valid

**Diff:**
```
1,2c1,5
< /tmp/fcoreutils-test-data/checksum_abc.txt: OK
< /tmp/fcoreutils-test-data/checksum_fox.txt: OK
---
> /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified. (os error 3)
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified. (os error 3)
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fmd5sum: WARNING: 2 listed file could not be read
Ex
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c check valid
# GNU command:
md5sum -c '/tmp/fcoreutils_md5check_lS6gDm'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c '/tmp/fcoreutils_md5check_lS6gDm'
echo "fcoreutils exit: $?"

```

### sha256sum_abc_hash

**Diff:**
```
1c1
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - abc hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_UTF-8_CJK

**Diff:**
```
1c1
< 44 /tmp/fcoreutils-test-data/cjk.txt
---
> 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m UTF-8 CJK
# GNU command:
wc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### wc_dos_line_endings

**Diff:**
```
1c1
<  3  3 21 /tmp/fcoreutils-test-data/dos_endings.txt
---
>  3  3 21 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/dos_endings.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - dos line endings
# GNU command:
wc '/tmp/fcoreutils-test-data/dos_endings.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/dos_endings.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-c_--ignore-missing

**Diff:**
```
1d0
< md5sum: /tmp/fcoreutils_md5missing_XPxZcP: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --ignore-missing
# GNU command:
md5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_XPxZcP'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_XPxZcP'
echo "fcoreutils exit: $?"

```

### sha256sum_--tag_multiple_files

**Diff:**
```
1,2c1,2
< SHA256 (/tmp/fcoreutils-test-data/checksum_abc.txt) = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
< SHA256 (/tmp/fcoreutils-test-data/checksum_fox.txt) = d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592
---
> SHA256 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
> SHA256 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt) = d7a8f
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - --tag multiple files
# GNU command:
sha256sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-b_(binary_mode)

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -b (binary mode)
# GNU command:
b2sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### tac_-b_with_custom_separator

**Diff:**
```
1c1,7
< ---part3---part2part1
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac.exe --before [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -b with custom separator
# GNU command:
printf 'part1---part2---part3' | tac -b -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3' | ftac -b -s '---'
echo "fcoreutils exit: $?"

```

### md5sum_--tag_format

**Diff:**
```
1c1
< MD5 (/tmp/fcoreutils-test-data/checksum_abc.txt) = 900150983cd24fb0d6963f7d28e17f72
---
> MD5 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = 900150983cd24fb0d6963f7d28e17f72

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - --tag format
# GNU command:
md5sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_binary_file_with_null_bytes

**Diff:**
```
1c1
< 0 1 7 /tmp/fcoreutils-test-data/null_bytes.bin
---
> 0 1 7 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/null_bytes.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - binary file with null bytes
# GNU command:
wc '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "fcoreutils exit: $?"

```

### wc_-lwc_(all_three)

**Diff:**
```
1c1
<   1941  19372 101997 /tmp/fcoreutils-test-data/text_100k.txt
---
>   1941  19372 101997 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -lwc (all three)
# GNU command:
wc -lwc '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lwc '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-b_(binary_mode)

**Diff:**
```
1c1
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -b (binary mode)
# GNU command:
sha256sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_abc_known_hash

**Diff:**
```
1c1
< 900150983cd24fb0d6963f7d28e17f72 *-
---
> 900150983cd24fb0d6963f7d28e17f72  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - abc known hash
# GNU command:
printf 'abc' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
printf 'abc' | fmd5sum
echo "fcoreutils exit: $?"

```

### wc_10MB_file_-w

**Diff:**
```
1c1
< 1666809 /tmp/fcoreutils-test-data/text_10m.txt
---
> 1666809 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10MB file -w
# GNU command:
wc -w '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -w '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-l_512_(default_512-bit)

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -l 512 (default 512-bit)
# GNU command:
b2sum -l 512 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -l 512 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_empty_string_known_hash

**Diff:**
```
1c1
< d41d8cd98f00b204e9800998ecf8427e *-
---
> d41d8cd98f00b204e9800998ecf8427e  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - empty string known hash
# GNU command:
printf '' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
printf '' | fmd5sum
echo "fcoreutils exit: $?"

```

### b2sum_two_files

**Diff:**
```
1,2c1,2
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  C:/Use
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - two files
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### md5sum_10MB_text_hash

**Diff:**
```
1c1
< ad7bf7edeb9f383906e189b8d9caa266 */tmp/fcoreutils-test-data/text_10m.txt
---
> ad7bf7edeb9f383906e189b8d9caa266  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - 10MB text hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-t_(text_mode)

**Diff:**
```
1c1
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  /tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -t (text mode)
# GNU command:
sha256sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_two_files

**Diff:**
```
1,2c1,2
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
< d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-da
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - two files
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### tac_-r_regex_separator_(digits)

**Diff:**
```
1c1
< 98gamma765beta432alpha1
\ No newline at end of file
---
> gamma789beta456alpha123
\ No newline at end of file

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -r regex separator (digits)
# GNU command:
printf 'alpha123beta456gamma789' | tac -r -s '[0-9]+'
echo "GNU exit: $?"

# fcoreutils command:
printf 'alpha123beta456gamma789' | ftac -r -s '[0-9]+'
echo "fcoreutils exit: $?"

```

### wc_random_binary_1k

**Diff:**
```
1c1
<    2   30 1024 /tmp/fcoreutils-test-data/random_1k.bin
---
>    2   29 1024 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - random binary 1k
# GNU command:
wc '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### md5sum_binary_file_hash

**Diff:**
```
1c1
< 0b2e3813ebebb0d1ff2cea6d0530bdd1 */tmp/fcoreutils-test-data/random_1k.bin
---
> 0b2e3813ebebb0d1ff2cea6d0530bdd1  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - binary file hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### md5sum_-c_--quiet

**Diff:**
```
0a1,5
> /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified. (os error 3)
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified. (os error 3)
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fmd5sum: WARNING: 2 listed file could not be read
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --quiet
# GNU command:
md5sum -c --quiet '/tmp/fcoreutils_md5check_lS6gDm'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --quiet '/tmp/fcoreutils_md5check_lS6gDm'
echo "fcoreutils exit: $?"

```

### b2sum_fox_hash

**Diff:**
```
1c1
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - fox hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### wc_-w_empty

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -w empty
# GNU command:
wc -w '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -w '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_vs_-c_on_UTF-8

**Diff:**
```
1c1
< 14 /tmp/fcoreutils-test-data/utf8_multibyte.txt
---
> 14 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/utf8_multibyte.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m vs -c on UTF-8
# GNU command:
wc -m '/tmp/fcoreutils-test-data/utf8_multibyte.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/utf8_multibyte.txt'
echo "fcoreutils exit: $?"

```

### wc_-L_CJK

**Diff:**
```
1c1
< 11 /tmp/fcoreutils-test-data/cjk.txt
---
> 8 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L CJK
# GNU command:
wc -L '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_binary_file_hash

**Diff:**
```
1c1
< 43a9d05e7c532b115e043ff2dd2bc009f4d258c5f29667a603cf3f54c6ae4c17 */tmp/fcoreutils-test-data/random_1k.bin
---
> 43a9d05e7c532b115e043ff2dd2bc009f4d258c5f29667a603cf3f54c6ae4c17  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - binary file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### md5sum_empty_file_hash

**Diff:**
```
1c1
< d41d8cd98f00b204e9800998ecf8427e */tmp/fcoreutils-test-data/checksum_empty.txt
---
> d41d8cd98f00b204e9800998ecf8427e  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - empty file hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "fcoreutils exit: $?"

```

### wc_10MB_file_-c

**Diff:**
```
1c1
< 10133420 /tmp/fcoreutils-test-data/text_10m.txt
---
> 10133420 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10MB file -c
# GNU command:
wc -c '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -c '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### wc_only_newlines

**Diff:**
```
1c1
< 3 0 3 /tmp/fcoreutils-test-data/only_newlines.txt
---
> 3 0 3 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/only_newlines.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - only newlines
# GNU command:
wc '/tmp/fcoreutils-test-data/only_newlines.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/only_newlines.txt'
echo "fcoreutils exit: $?"

```

### sort_already_sorted

**Diff:**
```
1,100c1,101
< aaaeijzrjruxnacvjhswxoyco
< aaaeq
< aaagywiitxovchwltd
< aaakjcdcvitv
< aaapo
< aaatkqhrzggrlffssqpldzncjvqazxjoqgymwveck
< aaavrjidsjnqvzllrgazmoltyrgphktmvlswchsmfdyqiaqvf
< aaaxctclwogujstislvdvyqdkyqxecgeuct
< aabbyclmbdgyamhthuwuwqsumuefjzgejzyabodotjg
< aabfuvqbkmmvdavwiuqutjikqnyquqpmczzumci
< aabjzvuyhevmolryksgqrftvhxstn
< aableqihcrnirhqybigxelpcxroxhmziysecvs
< aaboyiovpmj
< aabpx
< aabtjjcbdfpipabtllqnxoborwxufjutsjultao
< aabudmsqxpdwlnarkqsvpwgihhi
< aabwilbvawqbmukkm
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - already sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/sorted_10m.txt' | head -100
echo "fcoreutils exit: $?"

```

### b2sum_empty_string_stdin

**Diff:**
```
1c1
< 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce *-
---
> 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - empty string stdin
# GNU command:
printf '' | b2sum
echo "GNU exit: $?"

# fcoreutils command:
printf '' | fb2sum
echo "fcoreutils exit: $?"

```

### sha256sum_empty_string_known_hash

**Diff:**
```
1c1
< e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 *-
---
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - empty string known hash
# GNU command:
printf '' | sha256sum
echo "GNU exit: $?"

# fcoreutils command:
printf '' | fsha256sum
echo "fcoreutils exit: $?"

```

### wc_-c_text_file

**Diff:**
```
1c1
< 101997 /tmp/fcoreutils-test-data/text_100k.txt
---
> 101997 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -c text file
# GNU command:
wc -c '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -c '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### b2sum_10MB_binary_hash

**Diff:**
```
1c1
< 322c7e5cdc0b7d8b9ba7f79bdde17a361e53513552de033595aff07e857fbceb301af190fd10f7c8cd2b943f90b7c1b808383315a344435e89b9dcb105728ebf */tmp/fcoreutils-test-data/random_10m.bin
---
> 322c7e5cdc0b7d8b9ba7f79bdde17a361e53513552de033595aff07e857fbceb301af190fd10f7c8cd2b943f90b7c1b808383315a344435e89b9dcb105728ebf  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - 10MB binary hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "fcoreutils exit: $?"

```

### wc_with_trailing_newline

**Diff:**
```
1c1
< 1 1 6 /tmp/fcoreutils-test-data/with_trailing_newline.txt
---
> 1 1 6 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/with_trailing_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - with trailing newline
# GNU command:
wc '/tmp/fcoreutils-test-data/with_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/with_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_stdin_binary_data

**Diff:**
```
1c1
< 43a9d05e7c532b115e043ff2dd2bc009f4d258c5f29667a603cf3f54c6ae4c17 *-
---
> 43a9d05e7c532b115e043ff2dd2bc009f4d258c5f29667a603cf3f54c6ae4c17  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - stdin binary data
# GNU command:
cat '/tmp/fcoreutils-test-data/random_1k.bin' | sha256sum
echo "GNU exit: $?"

# fcoreutils command:
cat '/tmp/fcoreutils-test-data/random_1k.bin' | fsha256sum
echo "fcoreutils exit: $?"

```

### md5sum_abc_hash

**Diff:**
```
1c1
< 900150983cd24fb0d6963f7d28e17f72 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> 900150983cd24fb0d6963f7d28e17f72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - abc hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### b2sum_CSV_file_hash

**Diff:**
```
1c1
< db4825991ce51e3533c381dc23011f454da850e107c6046c6e6b00b89b321f183c50acd0e62cbecc771255d2a38bd5506f05e8c90a5b1536064b3efdd58e9dd1 */tmp/fcoreutils-test-data/simple.csv
---
> db4825991ce51e3533c381dc23011f454da850e107c6046c6e6b00b89b321f183c50acd0e62cbecc771255d2a38bd5506f05e8c90a5b1536064b3efdd58e9dd1  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - CSV file hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_three_files_with_flags

**Diff:**
```
1,3c1,3
<   4   5 /tmp/fcoreutils-test-data/simple.csv
<   9   9 /tmp/fcoreutils-test-data/unsorted.txt
<   9   9 /tmp/fcoreutils-test-data/duplicates.txt
---
>   4   5 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv
>   9   9 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/unsorted.txt
>   9   9 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/duplicates.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - three files with flags
# GNU command:
wc -lw '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt' '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lw '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt' '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### wc_-l_only_newlines

**Diff:**
```
1c1
< 3 /tmp/fcoreutils-test-data/only_newlines.txt
---
> 3 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/only_newlines.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -l only newlines
# GNU command:
wc -l '/tmp/fcoreutils-test-data/only_newlines.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -l '/tmp/fcoreutils-test-data/only_newlines.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-l_128_(128-bit_output)

**Diff:**
```
1c1
< cf4ab791c62b8d2b2109c90275287816 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> cf4ab791c62b8d2b2109c90275287816  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -l 128 (128-bit output)
# GNU command:
b2sum -l 128 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -l 128 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-z_output

**Diff:**
```
Binary files /tmp/gnu_output_3372 and /tmp/f_output_3372 differ

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -z output
# GNU command:
sha256sum -z '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -z '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-z_output

**Diff:**
```
Binary files /tmp/gnu_output_4297 and /tmp/f_output_4297 differ

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -z output
# GNU command:
md5sum -z '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -z '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_check_valid_checksums

**Diff:**
```
1,2c1,5
< /tmp/fcoreutils-test-data/checksum_abc.txt: OK
< /tmp/fcoreutils-test-data/checksum_fox.txt: OK
---
> fsha256sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> fsha256sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fsha256sum: WARNING: 2 listed files could not be read

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c check valid checksums
# GNU command:
sha256sum -c '/tmp/fcoreutils_checksums_giSE6R'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c '/tmp/fcoreutils_checksums_giSE6R'
echo "fcoreutils exit: $?"

```

### wc_spaces_no_newline

**Diff:**
```
1c1
< 0 0 3 /tmp/fcoreutils-test-data/spaces_no_newline.txt
---
> 0 0 3 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/spaces_no_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - spaces no newline
# GNU command:
wc '/tmp/fcoreutils-test-data/spaces_no_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/spaces_no_newline.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-l_256_(256-bit_output)

**Diff:**
```
1c1
< bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -l 256 (256-bit output)
# GNU command:
b2sum -l 256 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -l 256 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_-w_whitespace_only

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/whitespace_only.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/whitespace_only.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -w whitespace only
# GNU command:
wc -w '/tmp/fcoreutils-test-data/whitespace_only.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -w '/tmp/fcoreutils-test-data/whitespace_only.txt'
echo "fcoreutils exit: $?"

```

### wc_-L_with_tabs_(tab_stop_at_8)

**Diff:**
```
1c1
< 17 /tmp/fcoreutils-test-data/tabs.txt
---
> 17 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/tabs.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L with tabs (tab stop at 8)
# GNU command:
wc -L '/tmp/fcoreutils-test-data/tabs.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/tabs.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_combining_umlaut

**Diff:**
```
1c1
< 4 /tmp/fcoreutils-test-data/combining_umlaut.txt
---
> 4 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/combining_umlaut.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m combining umlaut
# GNU command:
wc -m '/tmp/fcoreutils-test-data/combining_umlaut.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/combining_umlaut.txt'
echo "fcoreutils exit: $?"

```

### tac_stdin_no_final_newline

**Diff:**
```
1c1,2
< cb
---
> c
> b

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - stdin no final newline
# GNU command:
printf 'a\nb\nc' | tac
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\nb\nc' | ftac
echo "fcoreutils exit: $?"

```

### wc_-L_only_tabs

**Diff:**
```
1c1
< 24 /tmp/fcoreutils-test-data/only_tabs.txt
---
> 24 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/only_tabs.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L only tabs
# GNU command:
wc -L '/tmp/fcoreutils-test-data/only_tabs.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/only_tabs.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_fox_hash

**Diff:**
```
1c1
< d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - fox hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_stdin_hash

**Diff:**
```
1c1
< fec91c70284c72d0d4e3684788a90de9338a5b2f47f01fedbe203cafd68708718ae5672d10eca804a8121904047d40d1d6cf11e7a76419357a9469af41f22d01 *-
---
> fec91c70284c72d0d4e3684788a90de9338a5b2f47f01fedbe203cafd68708718ae5672d10eca804a8121904047d40d1d6cf11e7a76419357a9469af41f22d01  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - stdin hash
# GNU command:
echo 'hello world' | b2sum
echo "GNU exit: $?"

# fcoreutils command:
echo 'hello world' | fb2sum
echo "fcoreutils exit: $?"

```

### wc_1MB_line_-L

**Diff:**
```
1c1
< 1048576 /tmp/fcoreutils-test-data/long_line_1m.txt
---
> 1048576 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/long_line_1m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 1MB line -L
# GNU command:
wc -L '/tmp/fcoreutils-test-data/long_line_1m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/long_line_1m.txt'
echo "fcoreutils exit: $?"

```

### b2sum_100_files

**Diff:**
```
1,100c1,100
< af40a0d5d3e24cd8d9e6beb33ff5b1af5fc3154238a36150a0ce5f9798944807f298377440919a4d9db021d48a32c7c46711192dc3c706e8302aaecca43fe71c */tmp/fcoreutils-test-data/many_files/file_0001.txt
< 9347c8272d0ca029edfa94e9f444d54a05d5c72b4dc7c306ee37825803a972b8cc506f10e0ac1ba955629c87cab3f47dce6f648ba99666c95546bedaf3047d12 */tmp/fcoreutils-test-data/many_files/file_0002.txt
< aa54ece2b90b390155ed695829d8d71f8a249f701a5a23c0543865539ce45cce40af6290609dd4a2da51f1f22fbff57ddf8f02ebb918e3e56336519d
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - 100 files
# GNU command:
eval b2sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "GNU exit: $?"

# fcoreutils command:
eval fb2sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "fcoreutils exit: $?"

```

### wc_-L_long_line_10k

**Diff:**
```
1c1
< 10000 /tmp/fcoreutils-test-data/long_line_10k.txt
---
> 10000 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/long_line_10k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L long line 10k
# GNU command:
wc -L '/tmp/fcoreutils-test-data/long_line_10k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/long_line_10k.txt'
echo "fcoreutils exit: $?"

```

### wc_-c_empty

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -c empty
# GNU command:
wc -c '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -c '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### b2sum_binary_file_hash

**Diff:**
```
1c1
< c78ad329815a4d59ac2d4271ccf63de6d705778e30ef414be0f0f8bb79a2028004b032f9449886abb44cca192cc0b1e775582423cfa6dc4c1e8e35b70849509e */tmp/fcoreutils-test-data/random_1k.bin
---
> c78ad329815a4d59ac2d4271ccf63de6d705778e30ef414be0f0f8bb79a2028004b032f9449886abb44cca192cc0b1e775582423cfa6dc4c1e8e35b70849509e  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - binary file hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### wc_10MB_file_all_flags

**Diff:**
```
1c1
<   133358  1666809 10133420 10133420      164 /tmp/fcoreutils-test-data/text_10m.txt
---
>   133358  1666809 10133420 10133420      164 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10MB file all flags
# GNU command:
wc -lwcmL '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lwcmL '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### md5sum_10MB_binary_hash

**Diff:**
```
1c1
< 4adc0e57adc601d356f298fe05a949c3 */tmp/fcoreutils-test-data/random_10m.bin
---
> 4adc0e57adc601d356f298fe05a949c3  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - 10MB binary hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "fcoreutils exit: $?"

```

### wc_-L_tab_at_position_8

**Diff:**
```
1c1
< 11 /tmp/fcoreutils-test-data/tab_at_8.txt
---
> 11 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/tab_at_8.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L tab at position 8
# GNU command:
wc -L '/tmp/fcoreutils-test-data/tab_at_8.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/tab_at_8.txt'
echo "fcoreutils exit: $?"

```

### tac_no_trailing_newline

**Diff:**
```
1c1,2
< line 3line 2
---
> line 3
> line 2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - no trailing newline
# GNU command:
tac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
ftac '/tmp/fcoreutils-test-data/tac_no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_three_files

**Diff:**
```
1,3c1,3
< e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 */tmp/fcoreutils-test-data/checksum_empty.txt
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
< d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt
> ba7816
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - three files
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_--tag_format

**Diff:**
```
1c1
< BLAKE2b (/tmp/fcoreutils-test-data/checksum_abc.txt) = ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
---
> BLAKE2b (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - --tag format
# GNU command:
b2sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### cut_tab_delimiter_explicit

**Diff:**
```
1,2c1
< cut: the delimiter must be a single character
< Try 'cut --help' for more information.
---
> fcut: the delimiter must be a single character

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: cut - tab delimiter explicit
# GNU command:
printf 'a\tb\tc\n' | cut -d'\t' -f2
echo "GNU exit: $?"

# fcoreutils command:
printf 'a\tb\tc\n' | fcut -d'\t' -f2
echo "fcoreutils exit: $?"

```

### b2sum_--tag_multiple_files

**Diff:**
```
1,2c1,2
< BLAKE2b (/tmp/fcoreutils-test-data/checksum_abc.txt) = ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
< BLAKE2b (/tmp/fcoreutils-test-data/checksum_fox.txt) = a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918
---
> BLAKE2b (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = ba80a53f981c4d0d6a2797b69f1
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - --tag multiple files
# GNU command:
b2sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-l_64_(64-bit_output)

**Diff:**
```
1c1
< d8bb14d833d59559 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> d8bb14d833d59559  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -l 64 (64-bit output)
# GNU command:
b2sum -l 64 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -l 64 '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_text_with_embedded_nulls

**Diff:**
```
1c1
<  1  1 16 /tmp/fcoreutils-test-data/text_with_nulls.txt
---
>  1  1 16 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_with_nulls.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - text with embedded nulls
# GNU command:
wc '/tmp/fcoreutils-test-data/text_with_nulls.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/text_with_nulls.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_ASCII_file

**Diff:**
```
1c1
< 63 /tmp/fcoreutils-test-data/simple.csv
---
> 63 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m ASCII file
# GNU command:
wc -m '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_empty_file

**Diff:**
```
1c1
< 0 0 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 0 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - empty file
# GNU command:
wc '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### wc_1MB_file_default

**Diff:**
```
1c1
<   19399  193964 1019451 /tmp/fcoreutils-test-data/text_1m.txt
---
>   19399  193964 1019451 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_1m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 1MB file default
# GNU command:
wc '/tmp/fcoreutils-test-data/text_1m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/text_1m.txt'
echo "fcoreutils exit: $?"

```

### wc_-L_simple_text

**Diff:**
```
1c1
< 17 /tmp/fcoreutils-test-data/simple.csv
---
> 17 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -L simple text
# GNU command:
wc -L '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fwc -L '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_multiple_files_total_line

**Diff:**
```
1,2c1,2
<   4   5  63 /tmp/fcoreutils-test-data/simple.csv
<   9   9  59 /tmp/fcoreutils-test-data/unsorted.txt
---
>   4   5  63 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv
>   9   9  59 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/unsorted.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - multiple files total line
# GNU command:
wc '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=C_-m_char_count

**Diff:**
```
1c1
< 44 /tmp/fcoreutils-test-data/cjk.txt
---
> 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=C -m char count
# GNU command:
LC_ALL=C wc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=C fwc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### wc_-lc_(lines_and_bytes)

**Diff:**
```
1c1
<   1941 101997 /tmp/fcoreutils-test-data/text_100k.txt
---
>   1941 101997 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -lc (lines and bytes)
# GNU command:
wc -lc '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lc '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_CSV_file_hash

**Diff:**
```
1c1
< 9a583d626afcfce6a312a7ce22ac0abc4f0ec7263e18f258e0a3959b9a7242f1 */tmp/fcoreutils-test-data/simple.csv
---
> 9a583d626afcfce6a312a7ce22ac0abc4f0ec7263e18f258e0a3959b9a7242f1  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - CSV file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_-cm_(chars_and_bytes_mismatch_on_UTF-8)

**Diff:**
```
1c1
< 44 44 /tmp/fcoreutils-test-data/cjk.txt
---
> 44 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -cm (chars and bytes mismatch on UTF-8)
# GNU command:
wc -cm '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -cm '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### md5sum_two_files

**Diff:**
```
1,2c1,2
< 900150983cd24fb0d6963f7d28e17f72 */tmp/fcoreutils-test-data/checksum_abc.txt
< 9e107d9d372bb6826bd81d3542a419d6 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> 900150983cd24fb0d6963f7d28e17f72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> 9e107d9d372bb6826bd81d3542a419d6  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - two files
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### wc_10MB_file_-l

**Diff:**
```
1c1
< 133358 /tmp/fcoreutils-test-data/text_10m.txt
---
> 133358 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10MB file -l
# GNU command:
wc -l '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -l '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### tac_-s_custom_separator_(---)

**Diff:**
```
1c1,7
< part3---part2---part1---
\ No newline at end of file
---
> error: unexpected argument '---' found
> 
>   tip: to pass '---' as a value, use '-- ---'
> 
> Usage: ftac.exe [OPTIONS] [FILES]...
> 
> For more information, try '--help'.
Exit code mismatch: GNU=0, fcoreutils=2

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: tac - -s custom separator (---)
# GNU command:
printf 'part1---part2---part3---' | tac -s '---'
echo "GNU exit: $?"

# fcoreutils command:
printf 'part1---part2---part3---' | ftac -s '---'
echo "fcoreutils exit: $?"

```

### b2sum_-c_check_valid

**Diff:**
```
1,2c1,5
< /tmp/fcoreutils-test-data/checksum_abc.txt: OK
< /tmp/fcoreutils-test-data/checksum_fox.txt: OK
---
> fb2sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> fb2sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fb2sum: WARNING: 2 listed files could not be read
Exit code mi
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -c check valid
# GNU command:
b2sum -c '/tmp/fcoreutils_b2check_R4AsIN'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -c '/tmp/fcoreutils_b2check_R4AsIN'
echo "fcoreutils exit: $?"

```

### sha256sum_10MB_file_hash

**Diff:**
```
1c1
< 6fc4c14f0bfd2e1d5332d4262ae623af5d2438546485c7b7f60c81c3603b9262 */tmp/fcoreutils-test-data/text_10m.txt
---
> 6fc4c14f0bfd2e1d5332d4262ae623af5d2438546485c7b7f60c81c3603b9262  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - 10MB file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/text_10m.txt'
echo "fcoreutils exit: $?"

```

### md5sum_CSV_file_hash

**Diff:**
```
1c1
< 80a19a7c7a935063e1c83b5cbcae48db */tmp/fcoreutils-test-data/simple.csv
---
> 80a19a7c7a935063e1c83b5cbcae48db  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - CSV file hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_--files0-from

**Diff:**
```
1,3c1,2
<   4   5  63 /tmp/fcoreutils-test-data/simple.csv
<   9   9  59 /tmp/fcoreutils-test-data/unsorted.txt
<  13  14 122 total
---
> fwc: /tmp/fcoreutils-test-data/simple.csv: The system cannot find the path specified. (os error 3)
> fwc: /tmp/fcoreutils-test-data/unsorted.txt: The system cannot find the path specified. (os error 3)
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - --files0-from
# GNU command:
wc --files0-from='/tmp/fcoreutils_filelist_56DC2b'
echo "GNU exit: $?"

# fcoreutils command:
fwc --files0-from='/tmp/fcoreutils_filelist_56DC2b'
echo "fcoreutils exit: $?"

```

### wc_tabs_no_newline

**Diff:**
```
1c1
< 0 0 3 /tmp/fcoreutils-test-data/tabs_no_newline.txt
---
> 0 0 3 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/tabs_no_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - tabs no newline
# GNU command:
wc '/tmp/fcoreutils-test-data/tabs_no_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/tabs_no_newline.txt'
echo "fcoreutils exit: $?"

```

### b2sum_three_files

**Diff:**
```
1,3c1,3
< 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce */tmp/fcoreutils-test-data/checksum_empty.txt
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fco
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - three files
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-t_(text_mode)

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  /tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -t (text mode)
# GNU command:
b2sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -t '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-b_(binary_mode)

**Diff:**
```
1c1
< 900150983cd24fb0d6963f7d28e17f72 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> 900150983cd24fb0d6963f7d28e17f72 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -b (binary mode)
# GNU command:
md5sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -b '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_-m_empty

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/empty.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m empty
# GNU command:
wc -m '/tmp/fcoreutils-test-data/empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/empty.txt'
echo "fcoreutils exit: $?"

```

### sort_10MB_already_sorted

**Diff:**
```
1c1
< 53561bd29cf3a725351e07664548d5c3 *-
---
> f602b458d573dbf0f44fac392c682a55 *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - 10MB already sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/sorted_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/sorted_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### b2sum_abc_hash

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - abc hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### md5sum_stdin_binary_data

**Diff:**
```
1c1
< 0b2e3813ebebb0d1ff2cea6d0530bdd1 *-
---
> 0b2e3813ebebb0d1ff2cea6d0530bdd1  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - stdin binary data
# GNU command:
cat '/tmp/fcoreutils-test-data/random_1k.bin' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
cat '/tmp/fcoreutils-test-data/random_1k.bin' | fmd5sum
echo "fcoreutils exit: $?"

```

### wc_-l_no_trailing_newline

**Diff:**
```
1c1
< 0 /tmp/fcoreutils-test-data/no_trailing_newline.txt
---
> 0 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/no_trailing_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -l no trailing newline
# GNU command:
wc -l '/tmp/fcoreutils-test-data/no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -l '/tmp/fcoreutils-test-data/no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### wc_CR-only_endings

**Diff:**
```
1c1
<  0  3 18 /tmp/fcoreutils-test-data/cr_endings.txt
---
>  0  3 18 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cr_endings.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - CR-only endings
# GNU command:
wc '/tmp/fcoreutils-test-data/cr_endings.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/cr_endings.txt'
echo "fcoreutils exit: $?"

```

### md5sum_-c_--status

**Diff:**
```

Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --status
# GNU command:
md5sum -c --status '/tmp/fcoreutils_md5check_lS6gDm'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --status '/tmp/fcoreutils_md5check_lS6gDm'
echo "fcoreutils exit: $?"

```

### b2sum_abc_stdin

**Diff:**
```
1c1
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *-
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - abc stdin
# GNU command:
printf 'abc' | b2sum
echo "GNU exit: $?"

# fcoreutils command:
printf 'abc' | fb2sum
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--ignore-missing

**Diff:**
```
1d0
< sha256sum: /tmp/fcoreutils_missingcheck_GDUbud: no file was verified
Exit code mismatch: GNU=1, fcoreutils=0

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --ignore-missing
# GNU command:
sha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_GDUbud'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_GDUbud'
echo "fcoreutils exit: $?"

```

### sha256sum_10MB_binary_hash

**Diff:**
```
1c1
< 42bbca463b4dfe8dc2640e4b20b8d03cdc0ab9c4babb76d53fd0ee5eaa4ff56d */tmp/fcoreutils-test-data/random_10m.bin
---
> 42bbca463b4dfe8dc2640e4b20b8d03cdc0ab9c4babb76d53fd0ee5eaa4ff56d  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - 10MB binary hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/random_10m.bin'
echo "fcoreutils exit: $?"

```

### sort_10MB_reverse_sorted

**Diff:**
```
1c1
< 53561bd29cf3a725351e07664548d5c3 *-
---
> f602b458d573dbf0f44fac392c682a55 *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - 10MB reverse sorted
# GNU command:
sort '/tmp/fcoreutils-test-data/reverse_sorted_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/reverse_sorted_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### sha256sum_100_files

**Diff:**
```
1,100c1,100
< c2b26e44665c599bcac768a6313f07c6594969867c72f4ce950cd3951d218619 */tmp/fcoreutils-test-data/many_files/file_0001.txt
< 335705b42b7f43282dd4c82598a7d1c671e19eae44a20eee7db1486e436ed621 */tmp/fcoreutils-test-data/many_files/file_0002.txt
< 230af3048c94e1609125b9bd57c4d6cc0524d5bdc5e65dbcbf738d5cf3bfcb0a */tmp/fcoreutils-test-data/many_files/file_0003.txt
< 4466d9fbe5cebe445eaee45a7ba0c44562408c82532f77e67845129450af78b3 */tmp/fcoreutils-test-data/many_files/file_0004.txt
< 6150bdaece
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - 100 files
# GNU command:
eval sha256sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "GNU exit: $?"

# fcoreutils command:
eval fsha256sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "fcoreutils exit: $?"

```

### wc_unix_line_endings

**Diff:**
```
1c1
<  3  3 18 /tmp/fcoreutils-test-data/unix_endings.txt
---
>  3  3 18 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/unix_endings.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - unix line endings
# GNU command:
wc '/tmp/fcoreutils-test-data/unix_endings.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/unix_endings.txt'
echo "fcoreutils exit: $?"

```

### wc_-c_binary_file

**Diff:**
```
1c1
< 1024 /tmp/fcoreutils-test-data/random_1k.bin
---
> 1024 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -c binary file
# GNU command:
wc -c '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fwc -c '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

### wc_-m_emoji

**Diff:**
```
1c1
< 26 /tmp/fcoreutils-test-data/emoji.txt
---
> 26 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/emoji.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -m emoji
# GNU command:
wc -m '/tmp/fcoreutils-test-data/emoji.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -m '/tmp/fcoreutils-test-data/emoji.txt'
echo "fcoreutils exit: $?"

```

### wc_-w_text_file

**Diff:**
```
1c1
< 19372 /tmp/fcoreutils-test-data/text_100k.txt
---
> 19372 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -w text file
# GNU command:
wc -w '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -w '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### wc_whitespace_only_file

**Diff:**
```
1c1
<  3  0 19 /tmp/fcoreutils-test-data/whitespace_only.txt
---
>  3  0 19 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/whitespace_only.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - whitespace only file
# GNU command:
wc '/tmp/fcoreutils-test-data/whitespace_only.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/whitespace_only.txt'
echo "fcoreutils exit: $?"

```

### md5sum_stdin_hash

**Diff:**
```
1c1
< 6f5902ac237024bdd0c176cb93063dc4 *-
---
> 6f5902ac237024bdd0c176cb93063dc4  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - stdin hash
# GNU command:
echo 'hello world' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
echo 'hello world' | fmd5sum
echo "fcoreutils exit: $?"

```

### sha256sum_--tag_format

**Diff:**
```
1c1
< SHA256 (/tmp/fcoreutils-test-data/checksum_abc.txt) = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
---
> SHA256 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - --tag format
# GNU command:
sha256sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt'
echo "fcoreutils exit: $?"

```

### wc_10KB_line

**Diff:**
```
1c1
<     1     1 10002 /tmp/fcoreutils-test-data/long_line_10k.txt
---
>     1     1 10002 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/long_line_10k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 10KB line
# GNU command:
wc '/tmp/fcoreutils-test-data/long_line_10k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/long_line_10k.txt'
echo "fcoreutils exit: $?"

```

### wc_single_byte_file

**Diff:**
```
1c1
< 0 1 1 /tmp/fcoreutils-test-data/single_byte.txt
---
> 0 1 1 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/single_byte.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - single byte file
# GNU command:
wc '/tmp/fcoreutils-test-data/single_byte.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/single_byte.txt'
echo "fcoreutils exit: $?"

```

### wc_-l_text_file

**Diff:**
```
1c1
< 1941 /tmp/fcoreutils-test-data/text_100k.txt
---
> 1941 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -l text file
# GNU command:
wc -l '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -l '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### md5sum_100_files

**Diff:**
```
1,100c1,100
< 64caaade85e35cf456b1819b4e5f298c */tmp/fcoreutils-test-data/many_files/file_0001.txt
< 42bf43424b1d47e55121cd14df6c28f3 */tmp/fcoreutils-test-data/many_files/file_0002.txt
< f15330bfbd37c8d666514cfe2509bf13 */tmp/fcoreutils-test-data/many_files/file_0003.txt
< 7b6c188acbd77eecdce37b61f6af73b9 */tmp/fcoreutils-test-data/many_files/file_0004.txt
< dc8bdadd897529e1739f8a3d536dd8c0 */tmp/fcoreutils-test-data/many_files/file_0005.txt
< c13d7486efc9565b9202b16332a8dd84 */tmp/fcoreutils-t
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - 100 files
# GNU command:
eval md5sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "GNU exit: $?"

# fcoreutils command:
eval fmd5sum  '/tmp/fcoreutils-test-data/many_files/file_0001.txt' '/tmp/fcoreutils-test-data/many_files/file_0002.txt' '/tmp/fcoreutils-test-data/many_files/file_0003.txt' '/tmp/fcoreutils-test-data/many_files/file_0004.txt' '/tmp/fcoreutils-test-data/many_files/file_0005.txt' '/tmp/fcoreutils-test-data/many_files/file_0006.txt' '/tmp/fcoreutils-test-data/many_files/file_0007.txt' '/tmp/fcoreutils-test-data/many_files/file_0008.txt' '/tmp/fcoreutils-test-data/many_files/file_0009.txt' '/tmp/fcoreutils-test-data/many_files/file_0010.txt' '/tmp/fcoreutils-test-data/many_files/file_0011.txt' '/tmp/fcoreutils-test-data/many_files/file_0012.txt' '/tmp/fcoreutils-test-data/many_files/file_0013.txt' '/tmp/fcoreutils-test-data/many_files/file_0014.txt' '/tmp/fcoreutils-test-data/many_files/file_0015.txt' '/tmp/fcoreutils-test-data/many_files/file_0016.txt' '/tmp/fcoreutils-test-data/many_files/file_0017.txt' '/tmp/fcoreutils-test-data/many_files/file_0018.txt' '/tmp/fcoreutils-test-data/many_files/file_0019.txt' '/tmp/fcoreutils-test-data/many_files/file_0020.txt' '/tmp/fcoreutils-test-data/many_files/file_0021.txt' '/tmp/fcoreutils-test-data/many_files/file_0022.txt' '/tmp/fcoreutils-test-data/many_files/file_0023.txt' '/tmp/fcoreutils-test-data/many_files/file_0024.txt' '/tmp/fcoreutils-test-data/many_files/file_0025.txt' '/tmp/fcoreutils-test-data/many_files/file_0026.txt' '/tmp/fcoreutils-test-data/many_files/file_0027.txt' '/tmp/fcoreutils-test-data/many_files/file_0028.txt' '/tmp/fcoreutils-test-data/many_files/file_0029.txt' '/tmp/fcoreutils-test-data/many_files/file_0030.txt' '/tmp/fcoreutils-test-data/many_files/file_0031.txt' '/tmp/fcoreutils-test-data/many_files/file_0032.txt' '/tmp/fcoreutils-test-data/many_files/file_0033.txt' '/tmp/fcoreutils-test-data/many_files/file_0034.txt' '/tmp/fcoreutils-test-data/many_files/file_0035.txt' '/tmp/fcoreutils-test-data/many_files/file_0036.txt' '/tmp/fcoreutils-test-data/many_files/file_0037.txt' '/tmp/fcoreutils-test-data/many_files/file_0038.txt' '/tmp/fcoreutils-test-data/many_files/file_0039.txt' '/tmp/fcoreutils-test-data/many_files/file_0040.txt' '/tmp/fcoreutils-test-data/many_files/file_0041.txt' '/tmp/fcoreutils-test-data/many_files/file_0042.txt' '/tmp/fcoreutils-test-data/many_files/file_0043.txt' '/tmp/fcoreutils-test-data/many_files/file_0044.txt' '/tmp/fcoreutils-test-data/many_files/file_0045.txt' '/tmp/fcoreutils-test-data/many_files/file_0046.txt' '/tmp/fcoreutils-test-data/many_files/file_0047.txt' '/tmp/fcoreutils-test-data/many_files/file_0048.txt' '/tmp/fcoreutils-test-data/many_files/file_0049.txt' '/tmp/fcoreutils-test-data/many_files/file_0050.txt' '/tmp/fcoreutils-test-data/many_files/file_0051.txt' '/tmp/fcoreutils-test-data/many_files/file_0052.txt' '/tmp/fcoreutils-test-data/many_files/file_0053.txt' '/tmp/fcoreutils-test-data/many_files/file_0054.txt' '/tmp/fcoreutils-test-data/many_files/file_0055.txt' '/tmp/fcoreutils-test-data/many_files/file_0056.txt' '/tmp/fcoreutils-test-data/many_files/file_0057.txt' '/tmp/fcoreutils-test-data/many_files/file_0058.txt' '/tmp/fcoreutils-test-data/many_files/file_0059.txt' '/tmp/fcoreutils-test-data/many_files/file_0060.txt' '/tmp/fcoreutils-test-data/many_files/file_0061.txt' '/tmp/fcoreutils-test-data/many_files/file_0062.txt' '/tmp/fcoreutils-test-data/many_files/file_0063.txt' '/tmp/fcoreutils-test-data/many_files/file_0064.txt' '/tmp/fcoreutils-test-data/many_files/file_0065.txt' '/tmp/fcoreutils-test-data/many_files/file_0066.txt' '/tmp/fcoreutils-test-data/many_files/file_0067.txt' '/tmp/fcoreutils-test-data/many_files/file_0068.txt' '/tmp/fcoreutils-test-data/many_files/file_0069.txt' '/tmp/fcoreutils-test-data/many_files/file_0070.txt' '/tmp/fcoreutils-test-data/many_files/file_0071.txt' '/tmp/fcoreutils-test-data/many_files/file_0072.txt' '/tmp/fcoreutils-test-data/many_files/file_0073.txt' '/tmp/fcoreutils-test-data/many_files/file_0074.txt' '/tmp/fcoreutils-test-data/many_files/file_0075.txt' '/tmp/fcoreutils-test-data/many_files/file_0076.txt' '/tmp/fcoreutils-test-data/many_files/file_0077.txt' '/tmp/fcoreutils-test-data/many_files/file_0078.txt' '/tmp/fcoreutils-test-data/many_files/file_0079.txt' '/tmp/fcoreutils-test-data/many_files/file_0080.txt' '/tmp/fcoreutils-test-data/many_files/file_0081.txt' '/tmp/fcoreutils-test-data/many_files/file_0082.txt' '/tmp/fcoreutils-test-data/many_files/file_0083.txt' '/tmp/fcoreutils-test-data/many_files/file_0084.txt' '/tmp/fcoreutils-test-data/many_files/file_0085.txt' '/tmp/fcoreutils-test-data/many_files/file_0086.txt' '/tmp/fcoreutils-test-data/many_files/file_0087.txt' '/tmp/fcoreutils-test-data/many_files/file_0088.txt' '/tmp/fcoreutils-test-data/many_files/file_0089.txt' '/tmp/fcoreutils-test-data/many_files/file_0090.txt' '/tmp/fcoreutils-test-data/many_files/file_0091.txt' '/tmp/fcoreutils-test-data/many_files/file_0092.txt' '/tmp/fcoreutils-test-data/many_files/file_0093.txt' '/tmp/fcoreutils-test-data/many_files/file_0094.txt' '/tmp/fcoreutils-test-data/many_files/file_0095.txt' '/tmp/fcoreutils-test-data/many_files/file_0096.txt' '/tmp/fcoreutils-test-data/many_files/file_0097.txt' '/tmp/fcoreutils-test-data/many_files/file_0098.txt' '/tmp/fcoreutils-test-data/many_files/file_0099.txt' '/tmp/fcoreutils-test-data/many_files/file_0100.txt'
echo "fcoreutils exit: $?"

```

### wc_two_files

**Diff:**
```
1,2c1,2
<   4   5  63 /tmp/fcoreutils-test-data/simple.csv
<   9   9  59 /tmp/fcoreutils-test-data/unsorted.txt
---
>   4   5  63 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv
>   9   9  59 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/unsorted.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - two files
# GNU command:
wc '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/simple.csv' '/tmp/fcoreutils-test-data/unsorted.txt'
echo "fcoreutils exit: $?"

```

### wc_-lw_(lines_and_words)

**Diff:**
```
1c1
<   1941  19372 /tmp/fcoreutils-test-data/text_100k.txt
---
>   1941  19372 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_100k.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -lw (lines and words)
# GNU command:
wc -lw '/tmp/fcoreutils-test-data/text_100k.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc -lw '/tmp/fcoreutils-test-data/text_100k.txt'
echo "fcoreutils exit: $?"

```

### md5sum_--tag_multiple_files

**Diff:**
```
1,2c1,2
< MD5 (/tmp/fcoreutils-test-data/checksum_abc.txt) = 900150983cd24fb0d6963f7d28e17f72
< MD5 (/tmp/fcoreutils-test-data/checksum_fox.txt) = 9e107d9d372bb6826bd81d3542a419d6
---
> MD5 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt) = 900150983cd24fb0d6963f7d28e17f72
> MD5 (C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt) = 9e107d9d372bb6826bd81d3542a419d6

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - --tag multiple files
# GNU command:
md5sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum --tag '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### b2sum_empty_file_hash

**Diff:**
```
1c1
< 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce */tmp/fcoreutils-test-data/checksum_empty.txt
---
> 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - empty file hash
# GNU command:
b2sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=C_default_count

**Diff:**
```
1c1
<  3  5 44 /tmp/fcoreutils-test-data/cjk.txt
---
>  3  4 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=C default count
# GNU command:
LC_ALL=C wc '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=C fwc '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### wc_LC_ALL=en_US.UTF-8_-m_char_count

**Diff:**
```
1c1
< 22 /tmp/fcoreutils-test-data/cjk.txt
---
> 22 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - LC_ALL=en_US.UTF-8 -m char count
# GNU command:
LC_ALL=en_US.UTF-8 wc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
LC_ALL=en_US.UTF-8 fwc -m '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### wc_-Lw_(max_line_and_words)

**Diff:**
```
1c1
<  5 17 /tmp/fcoreutils-test-data/simple.csv
---
>  5 17 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - -Lw (max line and words)
# GNU command:
wc -Lw '/tmp/fcoreutils-test-data/simple.csv'
echo "GNU exit: $?"

# fcoreutils command:
fwc -Lw '/tmp/fcoreutils-test-data/simple.csv'
echo "fcoreutils exit: $?"

```

### wc_no_trailing_newline

**Diff:**
```
1c1
< 0 1 5 /tmp/fcoreutils-test-data/no_trailing_newline.txt
---
> 0 1 5 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/no_trailing_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - no trailing newline
# GNU command:
wc '/tmp/fcoreutils-test-data/no_trailing_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/no_trailing_newline.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_empty_file_hash

**Diff:**
```
1c1
< e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 */tmp/fcoreutils-test-data/checksum_empty.txt
---
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - empty file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/checksum_empty.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--quiet_valid_checksums

**Diff:**
```
0a1,5
> fsha256sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> fsha256sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> fsha256sum: WARNING: 2 listed files could not be read
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --quiet valid checksums
# GNU command:
sha256sum -c --quiet '/tmp/fcoreutils_checksums_giSE6R'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --quiet '/tmp/fcoreutils_checksums_giSE6R'
echo "fcoreutils exit: $?"

```

### sha256sum_stdin_hash

**Diff:**
```
1c1
< a948904f2f0f479b8f8197694b30184b0d2ed1c1cd2a1ec0fb85d299a192a447 *-
---
> a948904f2f0f479b8f8197694b30184b0d2ed1c1cd2a1ec0fb85d299a192a447  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - stdin hash
# GNU command:
echo 'hello world' | sha256sum
echo "GNU exit: $?"

# fcoreutils command:
echo 'hello world' | fsha256sum
echo "fcoreutils exit: $?"

```

### sha256sum_UTF-8_file_hash

**Diff:**
```
1c1
< e8071c6ca8997c90d608c3cf28b310c39a7787730f7d14f44d0bf94442f9e9b3 */tmp/fcoreutils-test-data/cjk.txt
---
> e8071c6ca8997c90d608c3cf28b310c39a7787730f7d14f44d0bf94442f9e9b3  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - UTF-8 file hash
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/cjk.txt'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/cjk.txt'
echo "fcoreutils exit: $?"

```

### md5sum_three_files

**Diff:**
```
1,3c1,3
< d41d8cd98f00b204e9800998ecf8427e */tmp/fcoreutils-test-data/checksum_empty.txt
< 900150983cd24fb0d6963f7d28e17f72 */tmp/fcoreutils-test-data/checksum_abc.txt
< 9e107d9d372bb6826bd81d3542a419d6 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> d41d8cd98f00b204e9800998ecf8427e  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt
> 900150983cd24fb0d6963f7d28e17f72  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> 9e107d9d372bb6826bd81d3
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - three files
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_empty.txt' '/tmp/fcoreutils-test-data/checksum_abc.txt' '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### wc_single_newline

**Diff:**
```
1c1
< 1 0 1 /tmp/fcoreutils-test-data/single_newline.txt
---
> 1 0 1 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/single_newline.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - single newline
# GNU command:
wc '/tmp/fcoreutils-test-data/single_newline.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/single_newline.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_file_with_null_bytes

**Diff:**
```
1c1
< 2b4377fbe075e03f60af522ba83f77fba18a3e24ee1db3348beba889535e6500 */tmp/fcoreutils-test-data/null_bytes.bin
---
> 2b4377fbe075e03f60af522ba83f77fba18a3e24ee1db3348beba889535e6500  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/null_bytes.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - file with null bytes
# GNU command:
sha256sum '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum '/tmp/fcoreutils-test-data/null_bytes.bin'
echo "fcoreutils exit: $?"

```

### wc_1MB_line

**Diff:**
```
1c1
<       1       1 1048578 /tmp/fcoreutils-test-data/long_line_1m.txt
---
>       1       1 1048578 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/long_line_1m.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - 1MB line
# GNU command:
wc '/tmp/fcoreutils-test-data/long_line_1m.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/long_line_1m.txt'
echo "fcoreutils exit: $?"

```

### wc_mixed_line_endings

**Diff:**
```
1c1
<  3  4 25 /tmp/fcoreutils-test-data/mixed_endings.txt
---
>  3  4 25 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/mixed_endings.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - mixed line endings
# GNU command:
wc '/tmp/fcoreutils-test-data/mixed_endings.txt'
echo "GNU exit: $?"

# fcoreutils command:
fwc '/tmp/fcoreutils-test-data/mixed_endings.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_abc_known_hash

**Diff:**
```
1c1
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad *-
---
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - abc known hash
# GNU command:
printf 'abc' | sha256sum
echo "GNU exit: $?"

# fcoreutils command:
printf 'abc' | fsha256sum
echo "fcoreutils exit: $?"

```

### md5sum_fox_hash

**Diff:**
```
1c1
< 9e107d9d372bb6826bd81d3542a419d6 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> 9e107d9d372bb6826bd81d3542a419d6  C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - fox hash
# GNU command:
md5sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum '/tmp/fcoreutils-test-data/checksum_fox.txt'
echo "fcoreutils exit: $?"

```

### sort_10MB_random_sort

**Diff:**
```
1c1
< 53561bd29cf3a725351e07664548d5c3 *-
---
> f602b458d573dbf0f44fac392c682a55 *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sort - 10MB random sort
# GNU command:
sort '/tmp/fcoreutils-test-data/random_lines_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
fsort '/tmp/fcoreutils-test-data/random_lines_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### sha256sum_binary_marker_()

**Diff:**
```
1c1
< 43a9d05e7c532b115e043ff2dd2bc009f4d258c5f29667a603cf3f54c6ae4c17 */tmp/fcoreutils-test-data/random_1k.bin
---
> 43a9d05e7c532b115e043ff2dd2bc009f4d258c5f29667a603cf3f54c6ae4c17 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - binary marker (*)
# GNU command:
sha256sum -b '/tmp/fcoreutils-test-data/random_1k.bin'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -b '/tmp/fcoreutils-test-data/random_1k.bin'
echo "fcoreutils exit: $?"

```

## Performance Results

### Darwin_arm64

| Tool | GNU (mean) | fcoreutils (mean) | Speedup |
|------|-----------|-------------------|---------|
| wc (default 100KB text) | 0.0126s | 0.0003s | **45.2x** |
| wc (default 1MB text) | - | 0.0032s | - |
| wc (default 10MB text) | 0.0351s | 0.0024s | **14.8x** |
| wc (default 100MB text) | 0.2751s | 0.0250s | **11.0x** |
| wc (-l 10MB text) | 0.0056s | 0.0015s | **3.7x** |
| wc (-w 10MB text) | 0.0323s | 0.0050s | **6.5x** |
| wc (-c 10MB text) | 0.0042s | 0.0013s | **3.3x** |
| wc (-m 10MB text) | 0.0354s | 0.0035s | **10.2x** |
| wc (-L 10MB text) | 0.0401s | 0.0278s | **1.4x** |
| wc (default 10MB binary) | 0.1359s | 0.0067s | **20.3x** |
| wc (default 10MB repetitive) | 0.0434s | 0.0108s | **4.0x** |
| wc (10 files) | 0.0015s | 0.0038s | **0.4x** |
| wc (100 files) | 0.0122s | 0.0091s | **1.3x** |
| cut (-b1-100 10MB CSV) | 0.0411s | 0.0116s | **3.5x** |
| cut (-c1-100 10MB CSV) | 0.0317s | 0.0075s | **4.3x** |
| cut (-d, -f1 10MB CSV) | 0.0212s | 0.0025s | **8.5x** |
| cut (-d, -f1,3,5 10MB CSV) | 0.0344s | 0.0073s | **4.7x** |
| cut (-d, -f2-4 10MB CSV) | 0.0362s | 0.0080s | **4.5x** |
| cut (--complement -d, -f1 10MB CSV) | 0.0592s | 0.0119s | **5.0x** |
| cut (-d, -f1 100KB text) | 0.0031s | 0.0024s | **1.3x** |
| cut (-d, -f1 1MB text) | 0.0045s | 0.0038s | **1.2x** |
| cut (-d: -f1 colon file) | 0.0034s | 0.0022s | **1.5x** |
| sha256sum (single 100KB text) | 0.0001s | 0.0008s | **0.2x** |
| sha256sum (single 1MB text) | 0.0069s | 0.0039s | **1.8x** |
| sha256sum (single 10MB text) | 0.0573s | 0.0430s | **1.3x** |
| sha256sum (single 10MB binary) | 0.0451s | 0.0362s | **1.2x** |
| sha256sum (single 100MB text) | 0.4295s | 0.3371s | **1.3x** |
| sha256sum (10 files) | 0.0001s | 0.0016s | - |
| sha256sum (100 files) | 0.0190s | 0.0025s | **7.7x** |
| md5sum | - | - | no data |
| b2sum (single 100KB text) | 0.0032s | 0.0035s | **0.9x** |
| b2sum (single 1MB text) | 0.0029s | 0.0040s | **0.7x** |
| b2sum (single 10MB text) | 0.0226s | 0.0134s | **1.7x** |
| b2sum (single 10MB binary) | 0.0243s | 0.0128s | **1.9x** |
| b2sum (single 100MB text) | 0.1994s | 0.1506s | **1.3x** |
| b2sum (-l 256 10MB) | 0.0231s | 0.0291s | **0.8x** |
| b2sum (-l 128 10MB) | 0.0222s | 0.0126s | **1.8x** |
| b2sum (100 files) | 0.0041s | 0.0034s | **1.2x** |
| base64 (encode 100KB text) | 0.0014s | 0.0031s | **0.5x** |
| base64 (encode 1MB text) | 0.0028s | 0.0021s | **1.3x** |
| base64 (encode 10MB text) | 0.0153s | 0.0075s | **2.0x** |
| base64 (encode 10MB binary) | 0.0176s | 0.0092s | **1.9x** |
| base64 (decode 1MB) | 0.0061s | 0.0068s | **0.9x** |
| base64 (decode 10MB) | 0.0336s | 0.0337s | **1.0x** |
| base64 (encode -w 76 10MB) | 0.0189s | 0.0012s | **15.6x** |
| base64 (encode -w 0 (no wrap) 10MB) | 0.0294s | 0.0088s | **3.4x** |
| sort (lexicographic 1MB) | 0.1206s | 0.0073s | **16.6x** |
| sort (lexicographic 10MB random) | 0.5316s | 0.0490s | **10.9x** |
| sort (already sorted 10MB) | 0.3028s | 0.0069s | **44.0x** |
| sort (reverse sorted 10MB) | 0.3349s | 0.0134s | **25.0x** |
| sort (-n numeric 10MB) | 0.4548s | 0.0386s | **11.8x** |
| sort (-r reverse 10MB) | 0.4630s | 0.0308s | **15.0x** |
| sort (-u unique 10MB) | 0.5637s | 0.0291s | **19.4x** |
| sort (-t, -k2 CSV 10MB) | 0.6403s | 0.0967s | **6.6x** |
| sort (repetitive 10MB) | 0.0812s | 0.0325s | **2.5x** |
| sort (--parallel=4 10MB) | 0.5165s | 0.0414s | **12.5x** |
| tr (a-z to A-Z 1MB) | 0.0021s | 0.0084s | **0.3x** |
| tr (a-z to A-Z 10MB) | 0.0263s | 0.0211s | **1.2x** |
| tr (-d digits 10MB) | 0.0517s | 0.0394s | **1.3x** |
| tr (-d lowercase 10MB) | 0.0633s | 0.0512s | **1.2x** |
| tr (-s spaces 10MB) | 0.0634s | 0.0383s | **1.7x** |
| tr ([:lower:] to [:upper:] 10MB) | 0.0336s | 0.0181s | **1.9x** |
| tr (-d [:digit:] 10MB CSV) | 0.0519s | 0.0297s | **1.8x** |
| tr (translate binary 10MB) | 0.0270s | 0.0282s | **1.0x** |
| uniq (default 10MB many duplicates) | 0.0378s | 0.0210s | **1.8x** |
| uniq (default 10MB sorted (low dup)) | 0.0066s | 0.0053s | **1.2x** |
| uniq (-c count 10MB many dups) | 0.0180s | 0.0095s | **1.9x** |
| uniq (-c count 10MB sorted) | 0.0270s | 0.0061s | **4.4x** |
| uniq (-d duplicates only 10MB) | 0.0146s | 0.0171s | **0.9x** |
| uniq (-u unique only 10MB) | 0.0130s | 0.0161s | **0.8x** |
| uniq (-i case insensitive 10MB) | 0.0133s | 0.0059s | **2.2x** |
| uniq (repetitive 10MB) | 0.0505s | 0.0165s | **3.1x** |
| tac | - | - | no data |

### Linux_aarch64

| Tool | GNU (mean) | fcoreutils (mean) | Speedup |
|------|-----------|-------------------|---------|
| wc (default 100KB text) | 0.0011s | 0.0008s | **1.4x** |
| wc (default 1MB text) | 0.0038s | 0.0011s | **3.4x** |
| wc (default 10MB text) | 0.0347s | 0.0027s | **12.9x** |
| wc (default 100MB text) | 0.2902s | 0.0146s | **19.9x** |
| wc (-l 10MB text) | 0.0043s | 0.0020s | **2.2x** |
| wc (-w 10MB text) | 0.0347s | 0.0027s | **12.7x** |
| wc (-c 10MB text) | 0.0008s | 0.0009s | **0.8x** |
| wc (-m 10MB text) | 0.0345s | 0.0034s | **10.3x** |
| wc (-L 10MB text) | 0.0347s | 0.0145s | **2.4x** |
| wc (default 10MB binary) | 0.2349s | 0.0028s | **82.4x** |
| wc (default 10MB repetitive) | 0.0504s | 0.0041s | **12.4x** |
| wc (10 files) | 0.0008s | 0.0008s | **1.0x** |
| wc (100 files) | 0.0012s | 0.0012s | **1.0x** |
| cut (-b1-100 10MB CSV) | 0.0182s | 0.0034s | **5.4x** |
| cut (-c1-100 10MB CSV) | 0.0183s | 0.0034s | **5.4x** |
| cut (-d, -f1 10MB CSV) | 0.0183s | 0.0024s | **7.6x** |
| cut (-d, -f1,3,5 10MB CSV) | 0.0209s | 0.0041s | **5.1x** |
| cut (-d, -f2-4 10MB CSV) | 0.0230s | 0.0043s | **5.4x** |
| cut (--complement -d, -f1 10MB CSV) | 0.0259s | 0.0057s | **4.5x** |
| cut (-d, -f1 100KB text) | 0.0007s | 0.0007s | **1.0x** |
| cut (-d, -f1 1MB text) | 0.0033s | 0.0011s | **2.9x** |
| cut (-d: -f1 colon file) | 0.0007s | 0.0007s | **1.0x** |
| sha256sum (single 100KB text) | 0.0011s | 0.0010s | **1.1x** |
| sha256sum (single 1MB text) | 0.0016s | 0.0033s | **0.5x** |
| sha256sum (single 10MB text) | 0.0081s | 0.0260s | **0.3x** |
| sha256sum (single 10MB binary) | 0.0082s | 0.0272s | **0.3x** |
| sha256sum (single 100MB text) | 0.0598s | 0.2481s | **0.2x** |
| sha256sum (10 files) | 0.0012s | 0.0013s | **0.9x** |
| sha256sum (100 files) | 0.0018s | 0.0018s | **1.0x** |
| md5sum (single 100KB text) | 0.0013s | 0.0009s | **1.3x** |
| md5sum (single 1MB text) | 0.0033s | 0.0024s | **1.4x** |
| md5sum (single 10MB text) | 0.0217s | 0.0163s | **1.3x** |
| md5sum (single 10MB binary) | 0.0227s | 0.0171s | **1.3x** |
| md5sum (single 100MB text) | 0.1916s | 0.1492s | **1.3x** |
| md5sum (10 files) | 0.0012s | 0.0013s | **0.9x** |
| md5sum (100 files) | 0.0017s | 0.0017s | **1.0x** |
| b2sum (single 100KB text) | 0.0009s | 0.0010s | **1.0x** |
| b2sum (single 1MB text) | 0.0022s | 0.0020s | **1.1x** |
| b2sum (single 10MB text) | 0.0148s | 0.0125s | **1.2x** |
| b2sum (single 10MB binary) | 0.0155s | 0.0131s | **1.2x** |
| b2sum (single 100MB text) | 0.1269s | 0.1123s | **1.1x** |
| b2sum (-l 256 10MB) | 0.0145s | 0.0124s | **1.2x** |
| b2sum (-l 128 10MB) | 0.0149s | 0.0127s | **1.2x** |
| b2sum (100 files) | 0.0018s | 0.0018s | **1.0x** |
| base64 (encode 100KB text) | 0.0010s | 0.0010s | **1.0x** |
| base64 (encode 1MB text) | 0.0020s | 0.0020s | **1.0x** |
| base64 (encode 10MB text) | 0.0104s | 0.0079s | **1.3x** |
| base64 (encode 10MB binary) | 0.0112s | 0.0082s | **1.4x** |
| base64 (decode 1MB) | 0.0040s | 0.0026s | **1.5x** |
| base64 (decode 10MB) | 0.0305s | 0.0179s | **1.7x** |
| base64 (encode -w 76 10MB) | 0.0106s | 0.0081s | **1.3x** |
| base64 (encode -w 0 (no wrap) 10MB) | 0.0081s | 0.0057s | **1.4x** |
| sort (lexicographic 1MB) | 0.0077s | 0.0042s | **1.8x** |
| sort (lexicographic 10MB random) | 0.0563s | 0.0223s | **2.5x** |
| sort (already sorted 10MB) | 0.0250s | 0.0084s | **3.0x** |
| sort (reverse sorted 10MB) | 0.0248s | 0.0086s | **2.9x** |
| sort (-n numeric 10MB) | 0.0790s | 0.0443s | **1.8x** |
| sort (-r reverse 10MB) | 0.0571s | 0.0222s | **2.6x** |
| sort (-u unique 10MB) | 0.0611s | 0.0251s | **2.4x** |
| sort (-t, -k2 CSV 10MB) | 0.0809s | 0.0426s | **1.9x** |
| sort (repetitive 10MB) | 0.0434s | 0.0216s | **2.0x** |
| sort (--parallel=4 10MB) | 0.0540s | 0.0209s | **2.6x** |
| tr (a-z to A-Z 1MB) | 0.0019s | 0.0028s | **0.7x** |
| tr (a-z to A-Z 10MB) | 0.0089s | 0.0125s | **0.7x** |
| tr (-d digits 10MB) | 0.0112s | 0.0155s | **0.7x** |
| tr (-d lowercase 10MB) | 0.0190s | 0.0236s | **0.8x** |
| tr (-s spaces 10MB) | 0.0168s | 0.0279s | **0.6x** |
| tr ([:lower:] to [:upper:] 10MB) | 0.0087s | 0.0121s | **0.7x** |
| tr (-d [:digit:] 10MB CSV) | 0.0111s | 0.0156s | **0.7x** |
| tr (translate binary 10MB) | 0.0092s | 0.0144s | **0.6x** |
| uniq (default 10MB many duplicates) | 0.0094s | 0.0047s | **2.0x** |
| uniq (default 10MB sorted (low dup)) | 0.0163s | 0.0044s | **3.7x** |
| uniq (-c count 10MB many dups) | 0.0097s | 0.0047s | **2.1x** |
| uniq (-c count 10MB sorted) | 0.0292s | 0.0055s | **5.3x** |
| uniq (-d duplicates only 10MB) | 0.0094s | 0.0046s | **2.0x** |
| uniq (-u unique only 10MB) | 0.0095s | 0.0048s | **2.0x** |
| uniq (-i case insensitive 10MB) | 0.0163s | 0.0047s | **3.5x** |
| uniq (repetitive 10MB) | 0.0467s | 0.0072s | **6.5x** |
| tac (reverse 100KB text) | 0.0010s | 0.0012s | **0.8x** |
| tac (reverse 1MB text) | 0.0018s | 0.0021s | **0.9x** |
| tac (reverse 10MB text) | 0.0096s | 0.0055s | **1.8x** |
| tac (reverse 100MB text) | 0.0784s | 0.0453s | **1.7x** |
| tac (reverse CSV 10MB) | 0.0082s | 0.0052s | **1.6x** |
| tac (reverse repetitive 10MB) | 0.0174s | 0.0103s | **1.7x** |
| tac (custom separator 1MB) | 0.0046s | 0.0043s | **1.1x** |

### Linux_x86_64

| Tool | GNU (mean) | fcoreutils (mean) | Speedup |
|------|-----------|-------------------|---------|
| wc (default 100KB text) | 0.0013s | 0.0008s | **1.6x** |
| wc (default 1MB text) | 0.0056s | 0.0010s | **5.9x** |
| wc (default 10MB text) | 0.0543s | 0.0022s | **24.9x** |
| wc (default 100MB text) | 0.4835s | 0.0110s | **44.0x** |
| wc (-l 10MB text) | 0.0018s | 0.0018s | **1.0x** |
| wc (-w 10MB text) | 0.0543s | 0.0020s | **27.6x** |
| wc (-c 10MB text) | 0.0008s | 0.0008s | **1.1x** |
| wc (-m 10MB text) | 0.0542s | 0.0027s | **19.7x** |
| wc (-L 10MB text) | 0.0543s | 0.0150s | **3.6x** |
| wc (default 10MB binary) | 0.3166s | 0.0022s | **141.4x** |
| wc (default 10MB repetitive) | 0.0728s | 0.0034s | **21.5x** |
| wc (10 files) | 0.0009s | 0.0009s | **1.0x** |
| wc (100 files) | 0.0016s | 0.0017s | **1.0x** |
| cut (-b1-100 10MB CSV) | 0.0213s | 0.0043s | **5.0x** |
| cut (-c1-100 10MB CSV) | 0.0213s | 0.0043s | **5.0x** |
| cut (-d, -f1 10MB CSV) | 0.0158s | 0.0032s | **4.9x** |
| cut (-d, -f1,3,5 10MB CSV) | 0.0209s | 0.0076s | **2.7x** |
| cut (-d, -f2-4 10MB CSV) | 0.0233s | 0.0070s | **3.3x** |
| cut (--complement -d, -f1 10MB CSV) | 0.0295s | 0.0102s | **2.9x** |
| cut (-d, -f1 100KB text) | 0.0008s | 0.0008s | **1.0x** |
| cut (-d, -f1 1MB text) | 0.0032s | 0.0014s | **2.3x** |
| cut (-d: -f1 colon file) | 0.0008s | 0.0008s | **1.0x** |
| sha256sum (single 100KB text) | 0.0012s | 0.0009s | **1.4x** |
| sha256sum (single 1MB text) | 0.0019s | 0.0015s | **1.3x** |
| sha256sum (single 10MB text) | 0.0083s | 0.0078s | **1.1x** |
| sha256sum (single 10MB binary) | 0.0086s | 0.0081s | **1.1x** |
| sha256sum (single 100MB text) | 0.0748s | 0.0712s | **1.1x** |
| sha256sum (10 files) | 0.0013s | 0.0013s | **1.0x** |
| sha256sum (100 files) | 0.0021s | 0.0021s | **1.0x** |
| md5sum (single 100KB text) | 0.0013s | 0.0010s | **1.3x** |
| md5sum (single 1MB text) | 0.0027s | 0.0028s | **1.0x** |
| md5sum (single 10MB text) | 0.0171s | 0.0206s | **0.8x** |
| md5sum (single 10MB binary) | 0.0178s | 0.0216s | **0.8x** |
| md5sum (single 100MB text) | 0.1607s | 0.2012s | **0.8x** |
| md5sum (10 files) | 0.0012s | 0.0013s | **1.0x** |
| md5sum (100 files) | 0.0020s | 0.0020s | **1.0x** |
| b2sum (single 100KB text) | 0.0010s | 0.0009s | **1.1x** |
| b2sum (single 1MB text) | 0.0022s | 0.0019s | **1.2x** |
| b2sum (single 10MB text) | 0.0150s | 0.0116s | **1.3x** |
| b2sum (single 10MB binary) | 0.0154s | 0.0122s | **1.3x** |
| b2sum (single 100MB text) | 0.1429s | 0.1098s | **1.3x** |
| b2sum (-l 256 10MB) | 0.0148s | 0.0116s | **1.3x** |
| b2sum (-l 128 10MB) | 0.0149s | 0.0115s | **1.3x** |
| b2sum (100 files) | 0.0019s | 0.0021s | **0.9x** |
| base64 (encode 100KB text) | 0.0010s | 0.0010s | **1.0x** |
| base64 (encode 1MB text) | 0.0018s | 0.0020s | **0.9x** |
| base64 (encode 10MB text) | 0.0111s | 0.0055s | **2.0x** |
| base64 (encode 10MB binary) | 0.0117s | 0.0059s | **2.0x** |
| base64 (decode 1MB) | 0.0037s | 0.0028s | **1.3x** |
| base64 (decode 10MB) | 0.0308s | 0.0173s | **1.8x** |
| base64 (encode -w 76 10MB) | 0.0116s | 0.0054s | **2.1x** |
| base64 (encode -w 0 (no wrap) 10MB) | 0.0083s | 0.0035s | **2.3x** |
| sort (lexicographic 1MB) | 0.0084s | 0.0044s | **1.9x** |
| sort (lexicographic 10MB random) | 0.0589s | 0.0174s | **3.4x** |
| sort (already sorted 10MB) | 0.0262s | 0.0108s | **2.4x** |
| sort (reverse sorted 10MB) | 0.0273s | 0.0107s | **2.6x** |
| sort (-n numeric 10MB) | 0.0737s | 0.0400s | **1.8x** |
| sort (-r reverse 10MB) | 0.0559s | 0.0198s | **2.8x** |
| sort (-u unique 10MB) | 0.0596s | 0.0193s | **3.1x** |
| sort (-t, -k2 CSV 10MB) | 0.0673s | 0.0332s | **2.0x** |
| sort (repetitive 10MB) | 0.0564s | 0.0193s | **2.9x** |
| sort (--parallel=4 10MB) | 0.0552s | 0.0182s | **3.0x** |
| tr (a-z to A-Z 1MB) | 0.0023s | 0.0028s | **0.8x** |
| tr (a-z to A-Z 10MB) | 0.0137s | 0.0147s | **0.9x** |
| tr (-d digits 10MB) | 0.0171s | 0.0188s | **0.9x** |
| tr (-d lowercase 10MB) | 0.0285s | 0.0303s | **0.9x** |
| tr (-s spaces 10MB) | 0.0277s | 0.0387s | **0.7x** |
| tr ([:lower:] to [:upper:] 10MB) | 0.0112s | 0.0147s | **0.8x** |
| tr (-d [:digit:] 10MB CSV) | 0.0163s | 0.0189s | **0.9x** |
| tr (translate binary 10MB) | 0.0099s | 0.0161s | **0.6x** |
| uniq (default 10MB many duplicates) | 0.0121s | 0.0058s | **2.1x** |
| uniq (default 10MB sorted (low dup)) | 0.0134s | 0.0058s | **2.3x** |
| uniq (-c count 10MB many dups) | 0.0120s | 0.0059s | **2.0x** |
| uniq (-c count 10MB sorted) | 0.0281s | 0.0077s | **3.6x** |
| uniq (-d duplicates only 10MB) | 0.0119s | 0.0056s | **2.1x** |
| uniq (-u unique only 10MB) | 0.0118s | 0.0056s | **2.1x** |
| uniq (-i case insensitive 10MB) | 0.0132s | 0.0062s | **2.1x** |
| uniq (repetitive 10MB) | 0.0405s | 0.0081s | **5.0x** |
| tac (reverse 100KB text) | 0.0010s | 0.0010s | **0.9x** |
| tac (reverse 1MB text) | 0.0018s | 0.0019s | **0.9x** |
| tac (reverse 10MB text) | 0.0095s | 0.0059s | **1.6x** |
| tac (reverse 100MB text) | 0.0902s | 0.0485s | **1.9x** |
| tac (reverse CSV 10MB) | 0.0082s | 0.0056s | **1.5x** |
| tac (reverse repetitive 10MB) | 0.0203s | 0.0107s | **1.9x** |
| tac (custom separator 1MB) | 0.0058s | 0.0054s | **1.1x** |

### MINGW64_NT-10.0-26100_x86_64

| Tool | GNU (mean) | fcoreutils (mean) | Speedup |
|------|-----------|-------------------|---------|
| wc (default 100KB text) | - | - | - |
| wc (default 1MB text) | - | - | - |
| wc (default 10MB text) | - | - | - |
| wc (default 100MB text) | - | - | - |
| wc (-l 10MB text) | - | - | - |
| wc (-w 10MB text) | - | - | - |
| wc (-c 10MB text) | - | - | - |
| wc (-m 10MB text) | - | - | - |
| wc (-L 10MB text) | - | - | - |
| wc (default 10MB binary) | - | - | - |
| wc (default 10MB repetitive) | - | - | - |
| wc (10 files) | - | - | - |
| wc (100 files) | - | - | - |
| cut (-b1-100 10MB CSV) | - | - | - |
| cut (-c1-100 10MB CSV) | - | - | - |
| cut (-d, -f1 10MB CSV) | - | - | - |
| cut (-d, -f1,3,5 10MB CSV) | - | - | - |
| cut (-d, -f2-4 10MB CSV) | - | - | - |
| cut (--complement -d, -f1 10MB CSV) | - | - | - |
| cut (-d, -f1 100KB text) | - | - | - |
| cut (-d, -f1 1MB text) | - | - | - |
| cut (-d: -f1 colon file) | - | - | - |
| sha256sum (single 100KB text) | - | - | - |
| sha256sum (single 1MB text) | - | - | - |
| sha256sum (single 10MB text) | - | - | - |
| sha256sum (single 10MB binary) | - | - | - |
| sha256sum (single 100MB text) | - | - | - |
| sha256sum (10 files) | - | - | - |
| sha256sum (100 files) | - | - | - |
| md5sum (single 100KB text) | - | - | - |
| md5sum (single 1MB text) | - | - | - |
| md5sum (single 10MB text) | - | - | - |
| md5sum (single 10MB binary) | - | - | - |
| md5sum (single 100MB text) | - | - | - |
| md5sum (10 files) | - | - | - |
| md5sum (100 files) | - | - | - |
| b2sum (single 100KB text) | - | - | - |
| b2sum (single 1MB text) | - | - | - |
| b2sum (single 10MB text) | - | - | - |
| b2sum (single 10MB binary) | - | - | - |
| b2sum (single 100MB text) | - | - | - |
| b2sum (-l 256 10MB) | - | - | - |
| b2sum (-l 128 10MB) | - | - | - |
| b2sum (100 files) | - | - | - |
| base64 (encode 100KB text) | - | - | - |
| base64 (encode 1MB text) | - | - | - |
| base64 (encode 10MB text) | - | - | - |
| base64 (encode 10MB binary) | - | - | - |
| base64 (decode 1MB) | - | - | - |
| base64 (decode 10MB) | - | - | - |
| base64 (encode -w 76 10MB) | - | - | - |
| base64 (encode -w 0 (no wrap) 10MB) | - | - | - |
| sort (lexicographic 1MB) | - | - | - |
| sort (lexicographic 10MB random) | - | - | - |
| sort (already sorted 10MB) | - | - | - |
| sort (reverse sorted 10MB) | - | - | - |
| sort (-n numeric 10MB) | - | - | - |
| sort (-r reverse 10MB) | - | - | - |
| sort (-u unique 10MB) | - | - | - |
| sort (-t, -k2 CSV 10MB) | - | - | - |
| sort (repetitive 10MB) | - | - | - |
| sort (--parallel=4 10MB) | - | - | - |
| tr | - | - | no data |
| uniq (default 10MB many duplicates) | - | - | - |
| uniq (default 10MB sorted (low dup)) | - | - | - |
| uniq (-c count 10MB many dups) | - | - | - |
| uniq (-c count 10MB sorted) | - | - | - |
| uniq (-d duplicates only 10MB) | - | - | - |
| uniq (-u unique only 10MB) | - | - | - |
| uniq (-i case insensitive 10MB) | - | - | - |
| uniq (repetitive 10MB) | - | - | - |
| tac (reverse 100KB text) | - | - | - |
| tac (reverse 1MB text) | - | - | - |
| tac (reverse 10MB text) | - | - | - |
| tac (reverse 100MB text) | - | - | - |
| tac (reverse CSV 10MB) | - | - | - |
| tac (reverse repetitive 10MB) | - | - | - |
| tac (custom separator 1MB) | - | - | - |

### MINGW64_NT-10.0-26200-ARM64_x86_64

| Tool | GNU (mean) | fcoreutils (mean) | Speedup |
|------|-----------|-------------------|---------|
| wc (default 100KB text) | - | - | - |
| wc (default 1MB text) | - | - | - |
| wc (default 10MB text) | - | - | - |
| wc (default 100MB text) | - | - | - |
| wc (-l 10MB text) | - | - | - |
| wc (-w 10MB text) | - | - | - |
| wc (-c 10MB text) | - | - | - |
| wc (-m 10MB text) | - | - | - |
| wc (-L 10MB text) | - | - | - |
| wc (default 10MB binary) | - | - | - |
| wc (default 10MB repetitive) | - | - | - |
| wc (10 files) | - | - | - |
| wc (100 files) | - | - | - |
| cut (-b1-100 10MB CSV) | - | - | - |
| cut (-c1-100 10MB CSV) | - | - | - |
| cut (-d, -f1 10MB CSV) | - | - | - |
| cut (-d, -f1,3,5 10MB CSV) | - | - | - |
| cut (-d, -f2-4 10MB CSV) | - | - | - |
| cut (--complement -d, -f1 10MB CSV) | - | - | - |
| cut (-d, -f1 100KB text) | - | - | - |
| cut (-d, -f1 1MB text) | - | - | - |
| cut (-d: -f1 colon file) | - | - | - |
| sha256sum (single 100KB text) | - | - | - |
| sha256sum (single 1MB text) | - | - | - |
| sha256sum (single 10MB text) | - | - | - |
| sha256sum (single 10MB binary) | - | - | - |
| sha256sum (single 100MB text) | - | - | - |
| sha256sum (10 files) | - | - | - |
| sha256sum (100 files) | - | - | - |
| md5sum (single 100KB text) | - | - | - |
| md5sum (single 1MB text) | - | - | - |
| md5sum (single 10MB text) | - | - | - |
| md5sum (single 10MB binary) | - | - | - |
| md5sum (single 100MB text) | - | - | - |
| md5sum (10 files) | - | - | - |
| md5sum (100 files) | - | - | - |
| b2sum (single 100KB text) | - | - | - |
| b2sum (single 1MB text) | - | - | - |
| b2sum (single 10MB text) | - | - | - |
| b2sum (single 10MB binary) | - | - | - |
| b2sum (single 100MB text) | - | - | - |
| b2sum (-l 256 10MB) | - | - | - |
| b2sum (-l 128 10MB) | - | - | - |
| b2sum (100 files) | - | - | - |
| base64 (encode 100KB text) | - | - | - |
| base64 (encode 1MB text) | - | - | - |
| base64 (encode 10MB text) | - | - | - |
| base64 (encode 10MB binary) | - | - | - |
| base64 (decode 1MB) | - | - | - |
| base64 (decode 10MB) | - | - | - |
| base64 (encode -w 76 10MB) | - | - | - |
| base64 (encode -w 0 (no wrap) 10MB) | - | - | - |
| sort (lexicographic 1MB) | - | - | - |
| sort (lexicographic 10MB random) | - | - | - |
| sort (already sorted 10MB) | - | - | - |
| sort (reverse sorted 10MB) | - | - | - |
| sort (-n numeric 10MB) | - | - | - |
| sort (-r reverse 10MB) | - | - | - |
| sort (-u unique 10MB) | - | - | - |
| sort (-t, -k2 CSV 10MB) | - | - | - |
| sort (repetitive 10MB) | - | - | - |
| sort (--parallel=4 10MB) | - | - | - |
| tr | - | - | no data |
| uniq (default 10MB many duplicates) | - | - | - |
| uniq (default 10MB sorted (low dup)) | - | - | - |
| uniq (-c count 10MB many dups) | - | - | - |
| uniq (-c count 10MB sorted) | - | - | - |
| uniq (-d duplicates only 10MB) | - | - | - |
| uniq (-u unique only 10MB) | - | - | - |
| uniq (-i case insensitive 10MB) | - | - | - |
| uniq (repetitive 10MB) | - | - | - |
| tac (reverse 100KB text) | - | - | - |
| tac (reverse 1MB text) | - | - | - |
| tac (reverse 10MB text) | - | - | - |
| tac (reverse 100MB text) | - | - | - |
| tac (reverse CSV 10MB) | - | - | - |
| tac (reverse repetitive 10MB) | - | - | - |
| tac (custom separator 1MB) | - | - | - |


## Issues Found

1. 38 compatibility test failures detected across 5 platforms
2. See Failed Test Details above for specifics

## Recommendations

fcoreutils shows promise but has compatibility gaps that need to be addressed before production use.
Review the failed test details above for specific issues.
