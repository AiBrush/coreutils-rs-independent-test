# fcoreutils Independent Test Report

Generated: 2026-02-12 12:37:19 UTC

## Executive Summary

| Metric | Result |
|--------|--------|
| Tools Implemented | 10/10 |
| Total Tests | 1239 |
| Passed | 1200 |
| Failed | 39 |
| Overall Compatibility | 96.9% |
| Platforms Tested | 5 |

## Performance Overview

Best measured speedup (fcoreutils vs GNU) across all platforms:

| Tool | Best Speedup |
|------|-------------|
| wc | **32.7x** |
| cut | **6.3x** |
| sha256sum | **1.4x** |
| md5sum | **1.4x** |
| b2sum | **1.3x** |
| base64 | **2.7x** |
| sort | **998.0x** |
| tr | **1.6x** |
| uniq | **11.1x** |
| tac | **2.3x** |

## Compatibility Overview

| Tool | Tests | Passed | Failed | Pass Rate |
|------|-------|--------|--------|-----------|
| wc | 355 | 232 | 121 | 65.4% |
| cut | 245 | 243 | 0 | 99.2% |
| sha256sum | 170 | 124 | 44 | 72.9% |
| md5sum | 150 | 112 | 38 | 74.7% |
| b2sum | 125 | 87 | 38 | 69.6% |
| base64 | 165 | 165 | 0 | 100.0% |
| sort | 245 | 234 | 11 | 95.5% |
| tr | 230 | 230 | 0 | 100.0% |
| uniq | 230 | 175 | 55 | 76.1% |
| tac | 150 | 148 | 0 | 98.7% |

## Platform Results

### Darwin_arm64

- Compatibility: 396/413 tests passed
- Failed: 17
- Skipped: 0

### Linux_aarch64

- Compatibility: 402/413 tests passed
- Failed: 11
- Skipped: 0

### Linux_x86_64

- Compatibility: 402/413 tests passed
- Failed: 11
- Skipped: 0

### MINGW64_NT-10.0-26100_x86_64

- Compatibility: 0/0 tests passed
- Failed: 0
- Skipped: 0

### MINGW64_NT-10.0-26200-ARM64_x86_64

- Compatibility: 0/0 tests passed
- Failed: 0
- Skipped: 0

## Failed Test Details

### uniq_10MB_many_duplicates_-c

**Diff:**
```
1c1
< e598e45ea4f471a4766304adbd98705e  -
---
> a58c1b0a270f9ffd03391bc410081149  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates -c
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### uniq_-u_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u all unique
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_-i_case_insensitive

**Diff:**
```
2a3,4
> WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i case insensitive
# GNU command:
uniq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_-c_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c all unique
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_10MB_many_duplicates

**Diff:**
```
1c1
< 544f5d9b2b9fdf868b0b4b951dfc6141  -
---
> f97158f659492adf3a611d6fcd7bba0e  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates
# GNU command:
uniq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### uniq_-i_-c_case_insensitive_count

**Diff:**
```
2c2,4
<       3 World
---
>       2 World
>       1 WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i -c case insensitive count
# GNU command:
uniq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_-u_unique_only

**Diff:**
```
2a3
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u unique only
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_all_unique_(adjacent)

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - all unique (adjacent)
# GNU command:
uniq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_-c_count

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c count
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_basic_dedup

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - basic dedup
# GNU command:
uniq '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_10MB_many_duplicates_-c

**Diff:**
```
1c1
< e598e45ea4f471a4766304adbd98705e  -
---
> a58c1b0a270f9ffd03391bc410081149  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates -c
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### uniq_-u_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u all unique
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_-i_case_insensitive

**Diff:**
```
2a3,4
> WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i case insensitive
# GNU command:
uniq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_-c_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c all unique
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_10MB_many_duplicates

**Diff:**
```
1c1
< 544f5d9b2b9fdf868b0b4b951dfc6141  -
---
> f97158f659492adf3a611d6fcd7bba0e  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates
# GNU command:
uniq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### uniq_-i_-c_case_insensitive_count

**Diff:**
```
2c2,4
<       3 World
---
>       2 World
>       1 WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i -c case insensitive count
# GNU command:
uniq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_-u_unique_only

**Diff:**
```
2a3
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u unique only
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_all_unique_(adjacent)

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - all unique (adjacent)
# GNU command:
uniq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_-c_count

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c count
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_basic_dedup

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - basic dedup
# GNU command:
uniq '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/duplicates.txt'
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
sha256sum -c --status '/tmp/fcoreutils_checksums_qyv3oZ'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --status '/tmp/fcoreutils_checksums_qyv3oZ'
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
> db738d1cc80315f5f522d88a30beccd36390fdc8169b1081f0ab391ee57de165246308b6a6d1bd8020298329d7a8121b7a08c9a0c40f94a4f021365d6737ea72 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

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
> md5sum: WARNING: 2 listed files could not be read
Ex
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c check valid
# GNU command:
md5sum -c '/tmp/fcoreutils_md5check_ASr8vf'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c '/tmp/fcoreutils_md5check_ASr8vf'
echo "fcoreutils exit: $?"

```

### sha256sum_abc_hash

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

### uniq_10MB_many_duplicates_-c

**Diff:**
```
1c1
< e907786b34d048d40ad473928868f210 *-
---
> 05adfd9c3204a806eef7e93421587a06 *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates -c
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### md5sum_-c_--ignore-missing

**Diff:**
```
1c1
< md5sum: /tmp/fcoreutils_md5missing_tcxRQg: no file was verified
---
> md5sum: C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils_md5missing_tcxRQg: no file was verified

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --ignore-missing
# GNU command:
md5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_tcxRQg'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_tcxRQg'
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
> 0 0 7 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/null_bytes.bin

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
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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

### uniq_-u_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u all unique
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### b2sum_two_files

**Diff:**
```
1,2c1,2
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *C:/Use
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
> ad7bf7edeb9f383906e189b8d9caa266 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

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
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-da
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

### uniq_-i_case_insensitive

**Diff:**
```
2a3,4
> WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i case insensitive
# GNU command:
uniq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### wc_random_binary_1k

**Diff:**
```
1c1
<    2   33 1024 /tmp/fcoreutils-test-data/random_1k.bin
---
>    2   27 1024 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
< 58c9bf6c4314c49806e19b135b1e3837 */tmp/fcoreutils-test-data/random_1k.bin
---
> 58c9bf6c4314c49806e19b135b1e3837 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
> md5sum: WARNING: 2 listed files could not be read
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --quiet
# GNU command:
md5sum -c --quiet '/tmp/fcoreutils_md5check_ASr8vf'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --quiet '/tmp/fcoreutils_md5check_ASr8vf'
echo "fcoreutils exit: $?"

```

### b2sum_fox_hash

**Diff:**
```
1c1
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

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
< c1d36a480ab4fdd2586f9c63fc4afd38e23567439098753b9aff3c966e4ceb4b */tmp/fcoreutils-test-data/random_1k.bin
---
> c1d36a480ab4fdd2586f9c63fc4afd38e23567439098753b9aff3c966e4ceb4b *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
> d41d8cd98f00b204e9800998ecf8427e *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

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
1,100c1,102
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
< 4533e0984bd7778bdbd53763938cb70f8a04b47e2c0b62d61b4e6277757a8197c14d9a9570de6aba8bbead698abf3a06b051f3718702e1ea45390423ee3f38ff */tmp/fcoreutils-test-data/random_10m.bin
---
> 4533e0984bd7778bdbd53763938cb70f8a04b47e2c0b62d61b4e6277757a8197c14d9a9570de6aba8bbead698abf3a06b051f3718702e1ea45390423ee3f38ff *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

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

### md5sum_abc_hash

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
> db4825991ce51e3533c381dc23011f454da850e107c6046c6e6b00b89b321f183c50acd0e62cbecc771255d2a38bd5506f05e8c90a5b1536064b3efdd58e9dd1 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

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
> cf4ab791c62b8d2b2109c90275287816 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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
Binary files /tmp/gnu_output_3687 and /tmp/f_output_3687 differ

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
Binary files /tmp/gnu_output_4568 and /tmp/f_output_4568 differ

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
> sha256sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> sha256sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> sha256sum: WARNING: 2 listed files could not be read
Exi
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c check valid checksums
# GNU command:
sha256sum -c '/tmp/fcoreutils_checksums_qyv3oZ'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c '/tmp/fcoreutils_checksums_qyv3oZ'
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
> bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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
> d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

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
< 87c5bf56b65c6ac61df015cce5d776df42c89ace2c196cef43ac55f77a1b0657069a2bad7aac2b9e16d00f985c5de3f63199363d362d448c7a857cc9c4c77adf */tmp/fcoreutils-test-data/random_1k.bin
---
> 87c5bf56b65c6ac61df015cce5d776df42c89ace2c196cef43ac55f77a1b0657069a2bad7aac2b9e16d00f985c5de3f63199363d362d448c7a857cc9c4c77adf *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
< 9e31173e486089298a1e10fc9605c4d2 */tmp/fcoreutils-test-data/random_10m.bin
---
> 9e31173e486089298a1e10fc9605c4d2 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

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

### sha256sum_three_files

**Diff:**
```
1,3c1,3
< e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 */tmp/fcoreutils-test-data/checksum_empty.txt
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
< d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt
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
> d8bb14d833d59559 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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

### uniq_-c_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c all unique
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
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

### uniq_10MB_many_duplicates

**Diff:**
```
1c1
< 63d922e114dc7d3c46412142c7be45dc *-
---
> 7db84f1838a5335211fa9072ccb9ec1d *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates
# GNU command:
uniq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
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
> 9a583d626afcfce6a312a7ce22ac0abc4f0ec7263e18f258e0a3959b9a7242f1 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

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
> 900150983cd24fb0d6963f7d28e17f72 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> 9e107d9d372bb6826bd81d3542a419d6 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

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

### uniq_-i_-c_case_insensitive_count

**Diff:**
```
2c2,4
<       3 World
---
>       2 World
>       1 WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i -c case insensitive count
# GNU command:
uniq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-c_check_valid

**Diff:**
```
1,2c1,5
< /tmp/fcoreutils-test-data/checksum_abc.txt: OK
< /tmp/fcoreutils-test-data/checksum_fox.txt: OK
---
> b2sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> b2sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> b2sum: WARNING: 2 listed files could not be read
Exit code misma
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -c check valid
# GNU command:
b2sum -c '/tmp/fcoreutils_b2check_LISZyp'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -c '/tmp/fcoreutils_b2check_LISZyp'
echo "fcoreutils exit: $?"

```

### uniq_-u_unique_only

**Diff:**
```
2a3
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u unique only
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_10MB_file_hash

**Diff:**
```
1c1
< 6fc4c14f0bfd2e1d5332d4262ae623af5d2438546485c7b7f60c81c3603b9262 */tmp/fcoreutils-test-data/text_10m.txt
---
> 6fc4c14f0bfd2e1d5332d4262ae623af5d2438546485c7b7f60c81c3603b9262 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

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
> 80a19a7c7a935063e1c83b5cbcae48db *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

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
> wc: /tmp/fcoreutils-test-data/simple.csv: The system cannot find the path specified. (os error 3)
> wc: /tmp/fcoreutils-test-data/unsorted.txt: The system cannot find the path specified. (os error 3)
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - --files0-from
# GNU command:
wc --files0-from='/tmp/fcoreutils_filelist_J7Y67g'
echo "GNU exit: $?"

# fcoreutils command:
fwc --files0-from='/tmp/fcoreutils_filelist_J7Y67g'
echo "fcoreutils exit: $?"

```

### uniq_all_unique_(adjacent)

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - all unique (adjacent)
# GNU command:
uniq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_-c_count

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c count
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/duplicates.txt'
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
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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
md5sum -c --status '/tmp/fcoreutils_md5check_ASr8vf'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --status '/tmp/fcoreutils_md5check_ASr8vf'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--ignore-missing

**Diff:**
```
1c1
< sha256sum: /tmp/fcoreutils_missingcheck_PoWUwS: no file was verified
---
> sha256sum: C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils_missingcheck_PoWUwS: no file was verified

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --ignore-missing
# GNU command:
sha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_PoWUwS'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_PoWUwS'
echo "fcoreutils exit: $?"

```

### sha256sum_10MB_binary_hash

**Diff:**
```
1c1
< 22606732c452f69bcca203194611f598a0e439fe6e8f75ec92318bf4742f7d4a */tmp/fcoreutils-test-data/random_10m.bin
---
> 22606732c452f69bcca203194611f598a0e439fe6e8f75ec92318bf4742f7d4a *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

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
> 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

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
>  3  2 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

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
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

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
> sha256sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> sha256sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> sha256sum: WARNING: 2 listed files could not be read
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --quiet valid checksums
# GNU command:
sha256sum -c --quiet '/tmp/fcoreutils_checksums_qyv3oZ'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --quiet '/tmp/fcoreutils_checksums_qyv3oZ'
echo "fcoreutils exit: $?"

```

### sha256sum_UTF-8_file_hash

**Diff:**
```
1c1
< e8071c6ca8997c90d608c3cf28b310c39a7787730f7d14f44d0bf94442f9e9b3 */tmp/fcoreutils-test-data/cjk.txt
---
> e8071c6ca8997c90d608c3cf28b310c39a7787730f7d14f44d0bf94442f9e9b3 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

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
> d41d8cd98f00b204e9800998ecf8427e *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt
> 900150983cd24fb0d6963f7d28e17f72 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
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
> 2b4377fbe075e03f60af522ba83f77fba18a3e24ee1db3348beba889535e6500 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/null_bytes.bin

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

### uniq_basic_dedup

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - basic dedup
# GNU command:
uniq '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/duplicates.txt'
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

### md5sum_fox_hash

**Diff:**
```
1c1
< 9e107d9d372bb6826bd81d3542a419d6 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> 9e107d9d372bb6826bd81d3542a419d6 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

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
< c1d36a480ab4fdd2586f9c63fc4afd38e23567439098753b9aff3c966e4ceb4b */tmp/fcoreutils-test-data/random_1k.bin
---
> c1d36a480ab4fdd2586f9c63fc4afd38e23567439098753b9aff3c966e4ceb4b *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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

### uniq_10MB_many_duplicates_-c

**Diff:**
```
1c1
< e598e45ea4f471a4766304adbd98705e  -
---
> a58c1b0a270f9ffd03391bc410081149  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates -c
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### wc_binary_file_with_null_bytes

**Diff:**
```
1c1
< 0 1 7 /tmp/fcoreutils-test-data/null_bytes.bin
---
> 0 0 7 /tmp/fcoreutils-test-data/null_bytes.bin

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

### uniq_-u_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u all unique
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_-i_case_insensitive

**Diff:**
```
2a3,4
> WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i case insensitive
# GNU command:
uniq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### wc_random_binary_1k

**Diff:**
```
1c1
<    4   28 1024 /tmp/fcoreutils-test-data/random_1k.bin
---
>    4   26 1024 /tmp/fcoreutils-test-data/random_1k.bin

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
102c102
< sort: write error: Broken pipe
---
> sort: write error

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

### uniq_-c_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c all unique
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_10MB_many_duplicates

**Diff:**
```
1c1
< 544f5d9b2b9fdf868b0b4b951dfc6141  -
---
> f97158f659492adf3a611d6fcd7bba0e  -

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates
# GNU command:
uniq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### uniq_-i_-c_case_insensitive_count

**Diff:**
```
2c2,4
<       3 World
---
>       2 World
>       1 WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i -c case insensitive count
# GNU command:
uniq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_-u_unique_only

**Diff:**
```
2a3
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u unique only
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### uniq_all_unique_(adjacent)

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - all unique (adjacent)
# GNU command:
uniq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_-c_count

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c count
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/duplicates.txt'
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

### wc_LC_ALL=C_default_count

**Diff:**
```
1c1
<  3  5 44 /tmp/fcoreutils-test-data/cjk.txt
---
>  3  2 44 /tmp/fcoreutils-test-data/cjk.txt

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

### uniq_basic_dedup

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - basic dedup
# GNU command:
uniq '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/duplicates.txt'
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
sha256sum -c --status '/tmp/fcoreutils_checksums_9C0Vnh'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --status '/tmp/fcoreutils_checksums_9C0Vnh'
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
> db738d1cc80315f5f522d88a30beccd36390fdc8169b1081f0ab391ee57de165246308b6a6d1bd8020298329d7a8121b7a08c9a0c40f94a4f021365d6737ea72 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

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
> md5sum: WARNING: 2 listed files could not be read
Ex
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c check valid
# GNU command:
md5sum -c '/tmp/fcoreutils_md5check_NoiNuN'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c '/tmp/fcoreutils_md5check_NoiNuN'
echo "fcoreutils exit: $?"

```

### sha256sum_abc_hash

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

### uniq_10MB_many_duplicates_-c

**Diff:**
```
1c1
< e907786b34d048d40ad473928868f210 *-
---
> 05adfd9c3204a806eef7e93421587a06 *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates -c
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "fcoreutils exit: $?"

```

### md5sum_-c_--ignore-missing

**Diff:**
```
1c1
< md5sum: /tmp/fcoreutils_md5missing_4UTOk1: no file was verified
---
> md5sum: C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils_md5missing_4UTOk1: no file was verified

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --ignore-missing
# GNU command:
md5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_4UTOk1'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --ignore-missing '/tmp/fcoreutils_md5missing_4UTOk1'
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
> 0 0 7 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/null_bytes.bin

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
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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

### uniq_-u_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u all unique
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### b2sum_two_files

**Diff:**
```
1,2c1,2
< ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 */tmp/fcoreutils-test-data/checksum_abc.txt
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *C:/Use
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
> ad7bf7edeb9f383906e189b8d9caa266 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

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
> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-da
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

### uniq_-i_case_insensitive

**Diff:**
```
2a3,4
> WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i case insensitive
# GNU command:
uniq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -i '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### wc_random_binary_1k

**Diff:**
```
1c1
<    4   28 1024 /tmp/fcoreutils-test-data/random_1k.bin
---
>    4   22 1024 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
< 3c66856000675badb692369c06b7862d */tmp/fcoreutils-test-data/random_1k.bin
---
> 3c66856000675badb692369c06b7862d *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
> md5sum: WARNING: 2 listed files could not be read
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: md5sum - -c --quiet
# GNU command:
md5sum -c --quiet '/tmp/fcoreutils_md5check_NoiNuN'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --quiet '/tmp/fcoreutils_md5check_NoiNuN'
echo "fcoreutils exit: $?"

```

### b2sum_fox_hash

**Diff:**
```
1c1
< a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> a8add4bdddfd93e4877d2746e62817b116364a1fa7bc148d95090bc7333b3673f82401cf7aa2e4cb1ecd90296e3f14cb5413f8ed77be73045b13914cdcd6a918 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

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
< 6b9b302ed92b11b4d4b6ba249c84b3a5df0e0c39ddc18ca8da542c5587fe9394 */tmp/fcoreutils-test-data/random_1k.bin
---
> 6b9b302ed92b11b4d4b6ba249c84b3a5df0e0c39ddc18ca8da542c5587fe9394 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
> d41d8cd98f00b204e9800998ecf8427e *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

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
1,100c1,102
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
< 06f6f7d737c02435dad35962eaf2daf3b70d2f699810cfc818fa55b50b89c2cdb0e0ddb984d1bd7a9a6e52c7604589c1fb0b9a8750df8912d88befd77558401c */tmp/fcoreutils-test-data/random_10m.bin
---
> 06f6f7d737c02435dad35962eaf2daf3b70d2f699810cfc818fa55b50b89c2cdb0e0ddb984d1bd7a9a6e52c7604589c1fb0b9a8750df8912d88befd77558401c *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

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

### md5sum_abc_hash

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
> db4825991ce51e3533c381dc23011f454da850e107c6046c6e6b00b89b321f183c50acd0e62cbecc771255d2a38bd5506f05e8c90a5b1536064b3efdd58e9dd1 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

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
> cf4ab791c62b8d2b2109c90275287816 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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
Binary files /tmp/gnu_output_4918 and /tmp/f_output_4918 differ

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
Binary files /tmp/gnu_output_5799 and /tmp/f_output_5799 differ

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
> sha256sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> sha256sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> sha256sum: WARNING: 2 listed files could not be read
Exi
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c check valid checksums
# GNU command:
sha256sum -c '/tmp/fcoreutils_checksums_9C0Vnh'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c '/tmp/fcoreutils_checksums_9C0Vnh'
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
> bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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
> d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

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
< 3086b7a9001baaccab5a8df28264ec1fe92ef53309b0e557f2e54396d5155e8c1e38f3a49f9bb7b048e0074add9ea92eb5e620c1ad15debc08d5f734141895e1 */tmp/fcoreutils-test-data/random_1k.bin
---
> 3086b7a9001baaccab5a8df28264ec1fe92ef53309b0e557f2e54396d5155e8c1e38f3a49f9bb7b048e0074add9ea92eb5e620c1ad15debc08d5f734141895e1 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
< d7d525b705433e3c7d8f4b2015807c07 */tmp/fcoreutils-test-data/random_10m.bin
---
> d7d525b705433e3c7d8f4b2015807c07 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

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

### sha256sum_three_files

**Diff:**
```
1,3c1,3
< e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 */tmp/fcoreutils-test-data/checksum_empty.txt
< ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad */tmp/fcoreutils-test-data/checksum_abc.txt
< d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt
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
> d8bb14d833d59559 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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

### uniq_-c_all_unique

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c all unique
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/adjacent_unique.txt'
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

### uniq_10MB_many_duplicates

**Diff:**
```
1c1
< 63d922e114dc7d3c46412142c7be45dc *-
---
> 7db84f1838a5335211fa9072ccb9ec1d *-

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - 10MB many duplicates
# GNU command:
uniq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/many_duplicates_10m.txt' | md5sum
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
> 9a583d626afcfce6a312a7ce22ac0abc4f0ec7263e18f258e0a3959b9a7242f1 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

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
> 900150983cd24fb0d6963f7d28e17f72 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
> 9e107d9d372bb6826bd81d3542a419d6 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

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

### uniq_-i_-c_case_insensitive_count

**Diff:**
```
2c2,4
<       3 World
---
>       2 World
>       1 WORLD
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -i -c case insensitive count
# GNU command:
uniq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -ic '/tmp/fcoreutils-test-data/case_duplicates.txt'
echo "fcoreutils exit: $?"

```

### b2sum_-c_check_valid

**Diff:**
```
1,2c1,5
< /tmp/fcoreutils-test-data/checksum_abc.txt: OK
< /tmp/fcoreutils-test-data/checksum_fox.txt: OK
---
> b2sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> b2sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> b2sum: WARNING: 2 listed files could not be read
Exit code misma
```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: b2sum - -c check valid
# GNU command:
b2sum -c '/tmp/fcoreutils_b2check_das9Ld'
echo "GNU exit: $?"

# fcoreutils command:
fb2sum -c '/tmp/fcoreutils_b2check_das9Ld'
echo "fcoreutils exit: $?"

```

### uniq_-u_unique_only

**Diff:**
```
2a3
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -u unique only
# GNU command:
uniq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -u '/tmp/fcoreutils-test-data/duplicates.txt'
echo "fcoreutils exit: $?"

```

### sha256sum_10MB_file_hash

**Diff:**
```
1c1
< 6fc4c14f0bfd2e1d5332d4262ae623af5d2438546485c7b7f60c81c3603b9262 */tmp/fcoreutils-test-data/text_10m.txt
---
> 6fc4c14f0bfd2e1d5332d4262ae623af5d2438546485c7b7f60c81c3603b9262 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/text_10m.txt

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
> 80a19a7c7a935063e1c83b5cbcae48db *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/simple.csv

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
> wc: /tmp/fcoreutils-test-data/simple.csv: The system cannot find the path specified. (os error 3)
> wc: /tmp/fcoreutils-test-data/unsorted.txt: The system cannot find the path specified. (os error 3)
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: wc - --files0-from
# GNU command:
wc --files0-from='/tmp/fcoreutils_filelist_irvrMv'
echo "GNU exit: $?"

# fcoreutils command:
fwc --files0-from='/tmp/fcoreutils_filelist_irvrMv'
echo "fcoreutils exit: $?"

```

### uniq_all_unique_(adjacent)

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - all unique (adjacent)
# GNU command:
uniq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/adjacent_unique.txt'
echo "fcoreutils exit: $?"

```

### uniq_-c_count

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - -c count
# GNU command:
uniq -c '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq -c '/tmp/fcoreutils-test-data/duplicates.txt'
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
> ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt

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
md5sum -c --status '/tmp/fcoreutils_md5check_NoiNuN'
echo "GNU exit: $?"

# fcoreutils command:
fmd5sum -c --status '/tmp/fcoreutils_md5check_NoiNuN'
echo "fcoreutils exit: $?"

```

### sha256sum_-c_--ignore-missing

**Diff:**
```
1c1
< sha256sum: /tmp/fcoreutils_missingcheck_XJ0t60: no file was verified
---
> sha256sum: C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils_missingcheck_XJ0t60: no file was verified

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --ignore-missing
# GNU command:
sha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_XJ0t60'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --ignore-missing '/tmp/fcoreutils_missingcheck_XJ0t60'
echo "fcoreutils exit: $?"

```

### sha256sum_10MB_binary_hash

**Diff:**
```
1c1
< 2c89286c40fe9cb66e86822fd864f4d1419656c317af68271ebac06fe3e19341 */tmp/fcoreutils-test-data/random_10m.bin
---
> 2c89286c40fe9cb66e86822fd864f4d1419656c317af68271ebac06fe3e19341 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_10m.bin

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
> 786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

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
>  3  2 44 C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

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
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt

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
> sha256sum: /tmp/fcoreutils-test-data/checksum_abc.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_abc.txt: FAILED open or read
> sha256sum: /tmp/fcoreutils-test-data/checksum_fox.txt: The system cannot find the path specified.
> /tmp/fcoreutils-test-data/checksum_fox.txt: FAILED open or read
> sha256sum: WARNING: 2 listed files could not be read
Exit code mismatch: GNU=0, fcoreutils=1

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: sha256sum - -c --quiet valid checksums
# GNU command:
sha256sum -c --quiet '/tmp/fcoreutils_checksums_9C0Vnh'
echo "GNU exit: $?"

# fcoreutils command:
fsha256sum -c --quiet '/tmp/fcoreutils_checksums_9C0Vnh'
echo "fcoreutils exit: $?"

```

### sha256sum_UTF-8_file_hash

**Diff:**
```
1c1
< e8071c6ca8997c90d608c3cf28b310c39a7787730f7d14f44d0bf94442f9e9b3 */tmp/fcoreutils-test-data/cjk.txt
---
> e8071c6ca8997c90d608c3cf28b310c39a7787730f7d14f44d0bf94442f9e9b3 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/cjk.txt

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
> d41d8cd98f00b204e9800998ecf8427e *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_empty.txt
> 900150983cd24fb0d6963f7d28e17f72 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_abc.txt
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
> 2b4377fbe075e03f60af522ba83f77fba18a3e24ee1db3348beba889535e6500 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/null_bytes.bin

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

### uniq_basic_dedup

**Diff:**
```
5a6
> 

```
**Reproduction:**
```bash
#!/usr/bin/env bash
# Reproduction case for: uniq - basic dedup
# GNU command:
uniq '/tmp/fcoreutils-test-data/duplicates.txt'
echo "GNU exit: $?"

# fcoreutils command:
funiq '/tmp/fcoreutils-test-data/duplicates.txt'
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

### md5sum_fox_hash

**Diff:**
```
1c1
< 9e107d9d372bb6826bd81d3542a419d6 */tmp/fcoreutils-test-data/checksum_fox.txt
---
> 9e107d9d372bb6826bd81d3542a419d6 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/checksum_fox.txt

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
< 6b9b302ed92b11b4d4b6ba249c84b3a5df0e0c39ddc18ca8da542c5587fe9394 */tmp/fcoreutils-test-data/random_1k.bin
---
> 6b9b302ed92b11b4d4b6ba249c84b3a5df0e0c39ddc18ca8da542c5587fe9394 *C:/Users/RUNNER~1/AppData/Local/Temp/fcoreutils-test-data/random_1k.bin

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
| wc | - | - | no data |
| cut | - | - | no data |
| sha256sum | - | - | no data |
| md5sum | - | - | no data |
| b2sum | - | - | no data |
| base64 | - | - | no data |
| sort (lexicographic 1MB) | 0.1119s | 0.0074s | **15.1x** |
| sort (lexicographic 10MB random) | 0.4051s | 0.0159s | **25.5x** |
| sort (already sorted 10MB) | 0.2016s | 0.0002s | **998.0x** |
| sort (reverse sorted 10MB) | 0.2278s | 0.0110s | **20.8x** |
| sort (-n numeric 10MB) | 0.4400s | 0.0124s | **35.5x** |
| sort (-r reverse 10MB) | 0.3969s | 0.0118s | **33.5x** |
| sort (-u unique 10MB) | 0.4742s | 0.0511s | **9.3x** |
| sort (-t, -k2 CSV 10MB) | 0.5471s | 0.0256s | **21.4x** |
| sort (repetitive 10MB) | 0.0685s | 0.0164s | **4.2x** |
| sort (--parallel=4 10MB) | 0.4411s | 0.0391s | **11.3x** |
| tr | - | - | no data |
| uniq (default 10MB many duplicates) | 0.0107s | 0.0197s | **0.5x** |
| uniq (default 10MB sorted (low dup)) | 0.0200s | 0.0018s | **11.1x** |
| uniq (-c count 10MB many dups) | 0.0278s | 0.0131s | **2.1x** |
| uniq (-c count 10MB sorted) | 0.0499s | 0.0118s | **4.2x** |
| uniq (-d duplicates only 10MB) | 0.0266s | 0.0239s | **1.1x** |
| uniq (-u unique only 10MB) | 0.0111s | 0.0127s | **0.9x** |
| uniq (-i case insensitive 10MB) | 0.0193s | 0.0186s | **1.0x** |
| uniq (repetitive 10MB) | 0.0337s | 0.0114s | **3.0x** |
| tac | - | - | no data |

### Linux_aarch64

| Tool | GNU (mean) | fcoreutils (mean) | Speedup |
|------|-----------|-------------------|---------|
| wc (default 100KB text) | 0.0011s | 0.0009s | **1.2x** |
| wc (default 1MB text) | 0.0037s | 0.0025s | **1.5x** |
| wc (default 10MB text) | 0.0330s | 0.0171s | **1.9x** |
| wc (default 100MB text) | 0.2946s | 0.0371s | **7.9x** |
| wc (-l 10MB text) | 0.0034s | 0.0018s | **1.9x** |
| wc (-w 10MB text) | 0.0331s | 0.0168s | **2.0x** |
| wc (-c 10MB text) | 0.0007s | 0.0007s | **1.0x** |
| wc (-m 10MB text) | 0.0331s | 0.0018s | **18.6x** |
| wc (-L 10MB text) | 0.0332s | 0.0164s | **2.0x** |
| wc (default 10MB binary) | 0.2347s | 0.0588s | **4.0x** |
| wc (default 10MB repetitive) | 0.0523s | 0.0067s | **7.8x** |
| wc (10 files) | 0.0008s | 0.0008s | **1.0x** |
| wc (100 files) | 0.0012s | 0.0012s | **1.0x** |
| cut (-b1-100 10MB CSV) | 0.0183s | 0.0048s | **3.8x** |
| cut (-c1-100 10MB CSV) | 0.0183s | 0.0049s | **3.8x** |
| cut (-d, -f1 10MB CSV) | 0.0183s | 0.0029s | **6.3x** |
| cut (-d, -f1,3,5 10MB CSV) | 0.0210s | 0.0051s | **4.1x** |
| cut (-d, -f2-4 10MB CSV) | 0.0229s | 0.0052s | **4.4x** |
| cut (--complement -d, -f1 10MB CSV) | 0.0262s | 0.0065s | **4.1x** |
| cut (-d, -f1 100KB text) | 0.0007s | 0.0007s | **0.9x** |
| cut (-d, -f1 1MB text) | 0.0033s | 0.0014s | **2.4x** |
| cut (-d: -f1 colon file) | 0.0007s | 0.0007s | **1.0x** |
| sha256sum (single 100KB text) | 0.0011s | 0.0008s | **1.3x** |
| sha256sum (single 1MB text) | 0.0016s | 0.0017s | **0.9x** |
| sha256sum (single 10MB text) | 0.0066s | 0.0079s | **0.8x** |
| sha256sum (single 10MB binary) | 0.0070s | 0.0083s | **0.8x** |
| sha256sum (single 100MB text) | 0.0638s | 0.0705s | **0.9x** |
| sha256sum (10 files) | 0.0010s | 0.0007s | **1.4x** |
| sha256sum (100 files) | 0.0017s | 0.0012s | **1.4x** |
| md5sum (single 100KB text) | 0.0012s | 0.0009s | **1.3x** |
| md5sum (single 1MB text) | 0.0030s | 0.0025s | **1.2x** |
| md5sum (single 10MB text) | 0.0197s | 0.0170s | **1.2x** |
| md5sum (single 10MB binary) | 0.0210s | 0.0180s | **1.2x** |
| md5sum (single 100MB text) | 0.1969s | 0.1610s | **1.2x** |
| md5sum (10 files) | 0.0011s | 0.0009s | **1.2x** |
| md5sum (100 files) | 0.0016s | 0.0012s | **1.3x** |
| b2sum (single 100KB text) | 0.0009s | 0.0008s | **1.1x** |
| b2sum (single 1MB text) | 0.0020s | 0.0021s | **0.9x** |
| b2sum (single 10MB text) | 0.0130s | 0.0133s | **1.0x** |
| b2sum (single 10MB binary) | 0.0137s | 0.0138s | **1.0x** |
| b2sum (single 100MB text) | 0.1314s | 0.1242s | **1.1x** |
| b2sum (-l 256 10MB) | 0.0130s | 0.0132s | **1.0x** |
| b2sum (-l 128 10MB) | 0.0130s | 0.0133s | **1.0x** |
| b2sum (100 files) | 0.0016s | 0.0012s | **1.3x** |
| base64 (encode 100KB text) | 0.0008s | 0.0009s | **0.9x** |
| base64 (encode 1MB text) | 0.0016s | 0.0024s | **0.7x** |
| base64 (encode 10MB text) | 0.0088s | 0.0057s | **1.5x** |
| base64 (encode 10MB binary) | 0.0096s | 0.0060s | **1.6x** |
| base64 (decode 1MB) | 0.0038s | 0.0027s | **1.4x** |
| base64 (decode 10MB) | 0.0308s | 0.0177s | **1.7x** |
| base64 (encode -w 76 10MB) | 0.0092s | 0.0059s | **1.6x** |
| base64 (encode -w 0 (no wrap) 10MB) | 0.0069s | 0.0046s | **1.5x** |
| sort (lexicographic 1MB) | 0.0074s | 0.0036s | **2.0x** |
| sort (lexicographic 10MB random) | 0.0513s | 0.0155s | **3.3x** |
| sort (already sorted 10MB) | 0.0244s | 0.0064s | **3.8x** |
| sort (reverse sorted 10MB) | 0.0247s | 0.0085s | **2.9x** |
| sort (-n numeric 10MB) | 0.0690s | 0.0059s | **11.7x** |
| sort (-r reverse 10MB) | 0.0521s | 0.0163s | **3.2x** |
| sort (-u unique 10MB) | 0.0545s | 0.0174s | **3.1x** |
| sort (-t, -k2 CSV 10MB) | 0.0702s | 0.0298s | **2.4x** |
| sort (repetitive 10MB) | 0.0448s | 0.0144s | **3.1x** |
| sort (--parallel=4 10MB) | 0.0506s | 0.0154s | **3.3x** |
| tr (a-z to A-Z 1MB) | 0.0018s | 0.0016s | **1.1x** |
| tr (a-z to A-Z 10MB) | 0.0090s | 0.0061s | **1.5x** |
| tr (-d digits 10MB) | 0.0111s | 0.0096s | **1.2x** |
| tr (-d lowercase 10MB) | 0.0190s | 0.0167s | **1.1x** |
| tr (-s spaces 10MB) | 0.0169s | 0.0136s | **1.2x** |
| tr ([:lower:] to [:upper:] 10MB) | 0.0091s | 0.0062s | **1.5x** |
| tr (-d [:digit:] 10MB CSV) | 0.0111s | 0.0097s | **1.1x** |
| tr (translate binary 10MB) | 0.0093s | 0.0062s | **1.5x** |
| uniq (default 10MB many duplicates) | 0.0090s | 0.0050s | **1.8x** |
| uniq (default 10MB sorted (low dup)) | 0.0159s | 0.0060s | **2.6x** |
| uniq (-c count 10MB many dups) | 0.0090s | 0.0049s | **1.8x** |
| uniq (-c count 10MB sorted) | 0.0288s | 0.0092s | **3.1x** |
| uniq (-d duplicates only 10MB) | 0.0090s | 0.0050s | **1.8x** |
| uniq (-u unique only 10MB) | 0.0090s | 0.0049s | **1.8x** |
| uniq (-i case insensitive 10MB) | 0.0160s | 0.0070s | **2.3x** |
| uniq (repetitive 10MB) | 0.0478s | 0.0077s | **6.2x** |
| tac (reverse 100KB text) | 0.0008s | 0.0009s | **0.9x** |
| tac (reverse 1MB text) | 0.0015s | 0.0015s | **1.0x** |
| tac (reverse 10MB text) | 0.0077s | 0.0041s | **1.9x** |
| tac (reverse 100MB text) | 0.0814s | 0.0379s | **2.1x** |
| tac (reverse CSV 10MB) | 0.0078s | 0.0042s | **1.9x** |
| tac (reverse repetitive 10MB) | 0.0177s | 0.0089s | **2.0x** |
| tac (custom separator 1MB) | 0.0043s | 0.0034s | **1.3x** |

### Linux_x86_64

| Tool | GNU (mean) | fcoreutils (mean) | Speedup |
|------|-----------|-------------------|---------|
| wc (default 100KB text) | 0.0013s | 0.0010s | **1.3x** |
| wc (default 1MB text) | 0.0056s | 0.0033s | **1.7x** |
| wc (default 10MB text) | 0.0539s | 0.0206s | **2.6x** |
| wc (default 100MB text) | 0.4826s | 0.0672s | **7.2x** |
| wc (-l 10MB text) | 0.0020s | 0.0019s | **1.0x** |
| wc (-w 10MB text) | 0.0546s | 0.0194s | **2.8x** |
| wc (-c 10MB text) | 0.0008s | 0.0008s | **1.0x** |
| wc (-m 10MB text) | 0.0546s | 0.0017s | **32.7x** |
| wc (-L 10MB text) | 0.0544s | 0.0248s | **2.2x** |
| wc (default 10MB binary) | 0.3168s | 0.0814s | **3.9x** |
| wc (default 10MB repetitive) | 0.0730s | 0.0110s | **6.6x** |
| wc (10 files) | 0.0009s | 0.0009s | **1.0x** |
| wc (100 files) | 0.0016s | 0.0016s | **1.1x** |
| cut (-b1-100 10MB CSV) | 0.0215s | 0.0050s | **4.3x** |
| cut (-c1-100 10MB CSV) | 0.0215s | 0.0049s | **4.4x** |
| cut (-d, -f1 10MB CSV) | 0.0158s | 0.0035s | **4.5x** |
| cut (-d, -f1,3,5 10MB CSV) | 0.0211s | 0.0081s | **2.6x** |
| cut (-d, -f2-4 10MB CSV) | 0.0239s | 0.0076s | **3.1x** |
| cut (--complement -d, -f1 10MB CSV) | 0.0297s | 0.0110s | **2.7x** |
| cut (-d, -f1 100KB text) | 0.0008s | 0.0008s | **1.0x** |
| cut (-d, -f1 1MB text) | 0.0032s | 0.0023s | **1.4x** |
| cut (-d: -f1 colon file) | 0.0008s | 0.0008s | **1.0x** |
| sha256sum (single 100KB text) | 0.0013s | 0.0010s | **1.3x** |
| sha256sum (single 1MB text) | 0.0019s | 0.0023s | **0.8x** |
| sha256sum (single 10MB text) | 0.0088s | 0.0122s | **0.7x** |
| sha256sum (single 10MB binary) | 0.0091s | 0.0125s | **0.7x** |
| sha256sum (single 100MB text) | 0.0767s | 0.1086s | **0.7x** |
| sha256sum (10 files) | 0.0013s | 0.0009s | **1.4x** |
| sha256sum (100 files) | 0.0021s | 0.0016s | **1.3x** |
| md5sum (single 100KB text) | 0.0013s | 0.0011s | **1.2x** |
| md5sum (single 1MB text) | 0.0027s | 0.0035s | **0.8x** |
| md5sum (single 10MB text) | 0.0172s | 0.0240s | **0.7x** |
| md5sum (single 10MB binary) | 0.0179s | 0.0248s | **0.7x** |
| md5sum (single 100MB text) | 0.1621s | 0.2285s | **0.7x** |
| md5sum (10 files) | 0.0012s | 0.0009s | **1.4x** |
| md5sum (100 files) | 0.0021s | 0.0016s | **1.3x** |
| b2sum (single 100KB text) | 0.0010s | 0.0010s | **1.0x** |
| b2sum (single 1MB text) | 0.0022s | 0.0026s | **0.8x** |
| b2sum (single 10MB text) | 0.0149s | 0.0158s | **0.9x** |
| b2sum (single 10MB binary) | 0.0157s | 0.0161s | **1.0x** |
| b2sum (single 100MB text) | 0.1441s | 0.1462s | **1.0x** |
| b2sum (-l 256 10MB) | 0.0150s | 0.0159s | **0.9x** |
| b2sum (-l 128 10MB) | 0.0154s | 0.0160s | **1.0x** |
| b2sum (100 files) | 0.0020s | 0.0016s | **1.2x** |
| base64 (encode 100KB text) | 0.0009s | 0.0011s | **0.9x** |
| base64 (encode 1MB text) | 0.0019s | 0.0033s | **0.6x** |
| base64 (encode 10MB text) | 0.0115s | 0.0055s | **2.1x** |
| base64 (encode 10MB binary) | 0.0121s | 0.0055s | **2.2x** |
| base64 (decode 1MB) | 0.0038s | 0.0031s | **1.2x** |
| base64 (decode 10MB) | 0.0312s | 0.0180s | **1.7x** |
| base64 (encode -w 76 10MB) | 0.0114s | 0.0055s | **2.1x** |
| base64 (encode -w 0 (no wrap) 10MB) | 0.0085s | 0.0031s | **2.7x** |
| sort (lexicographic 1MB) | 0.0085s | 0.0041s | **2.1x** |
| sort (lexicographic 10MB random) | 0.0545s | 0.0162s | **3.4x** |
| sort (already sorted 10MB) | 0.0266s | 0.0075s | **3.6x** |
| sort (reverse sorted 10MB) | 0.0276s | 0.0110s | **2.5x** |
| sort (-n numeric 10MB) | 0.0745s | 0.0069s | **10.8x** |
| sort (-r reverse 10MB) | 0.0556s | 0.0184s | **3.0x** |
| sort (-u unique 10MB) | 0.0585s | 0.0171s | **3.4x** |
| sort (-t, -k2 CSV 10MB) | 0.0668s | 0.0361s | **1.8x** |
| sort (repetitive 10MB) | 0.0556s | 0.0135s | **4.1x** |
| sort (--parallel=4 10MB) | 0.0548s | 0.0171s | **3.2x** |
| tr (a-z to A-Z 1MB) | 0.0021s | 0.0019s | **1.1x** |
| tr (a-z to A-Z 10MB) | 0.0119s | 0.0084s | **1.4x** |
| tr (-d digits 10MB) | 0.0158s | 0.0148s | **1.1x** |
| tr (-d lowercase 10MB) | 0.0277s | 0.0249s | **1.1x** |
| tr (-s spaces 10MB) | 0.0279s | 0.0178s | **1.6x** |
| tr ([:lower:] to [:upper:] 10MB) | 0.0112s | 0.0084s | **1.3x** |
| tr (-d [:digit:] 10MB CSV) | 0.0165s | 0.0150s | **1.1x** |
| tr (translate binary 10MB) | 0.0092s | 0.0082s | **1.1x** |
| uniq (default 10MB many duplicates) | 0.0117s | 0.0057s | **2.0x** |
| uniq (default 10MB sorted (low dup)) | 0.0132s | 0.0073s | **1.8x** |
| uniq (-c count 10MB many dups) | 0.0118s | 0.0058s | **2.0x** |
| uniq (-c count 10MB sorted) | 0.0282s | 0.0109s | **2.6x** |
| uniq (-d duplicates only 10MB) | 0.0119s | 0.0057s | **2.1x** |
| uniq (-u unique only 10MB) | 0.0117s | 0.0056s | **2.1x** |
| uniq (-i case insensitive 10MB) | 0.0131s | 0.0076s | **1.7x** |
| uniq (repetitive 10MB) | 0.0409s | 0.0071s | **5.7x** |
| tac (reverse 100KB text) | 0.0009s | 0.0010s | **0.9x** |
| tac (reverse 1MB text) | 0.0017s | 0.0021s | **0.8x** |
| tac (reverse 10MB text) | 0.0090s | 0.0043s | **2.1x** |
| tac (reverse 100MB text) | 0.0920s | 0.0398s | **2.3x** |
| tac (reverse CSV 10MB) | 0.0089s | 0.0046s | **1.9x** |
| tac (reverse repetitive 10MB) | 0.0209s | 0.0089s | **2.3x** |
| tac (custom separator 1MB) | 0.0056s | 0.0042s | **1.4x** |

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

1. 39 compatibility test failures detected across 5 platforms
2. See Failed Test Details above for specifics