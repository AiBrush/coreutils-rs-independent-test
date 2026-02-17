# fcoreutils v0.0.28 — Detailed Results

Generated: 2026-02-17 06:44:37 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 396 | 17 | 95.9% |
| Linux_aarch64 | 413 | 402 | 11 | 97.3% |
| Linux_x86_64 | 236 | 21 | 215 | 8.9% |

**Overall: 819/1062 (77.1%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0012s | 0.0011s | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0343s | 0.0173s | **2.0x** |
| wc | default 100MB text | 0.2971s | 0.0435s | **6.8x** |
| wc | -l 10MB text | 0.0045s | 0.0021s | **2.1x** |
| wc | -w 10MB text | 0.0344s | 0.0168s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0343s | 0.0020s | **17.4x** |
| wc | -L 10MB text | 0.0342s | 0.0172s | **2.0x** |
| wc | default 10MB binary | 0.2347s | 0.0601s | **3.9x** |
| wc | default 10MB repetitive | 0.0533s | 0.0072s | **7.4x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0014s | 0.0014s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0052s | **3.6x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0054s | **3.4x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0048s | **3.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0058s | **3.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0055s | **4.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0070s | **3.8x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0013s | 0.0011s | **1.2x** |
| sha256sum | single 1MB text | 0.0018s | 0.0019s | **0.9x** |
| sha256sum | single 10MB text | 0.0080s | 0.0086s | **0.9x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0088s | **0.9x** |
| sha256sum | single 100MB text | 0.0664s | 0.0720s | **0.9x** |
| sha256sum | 10 files | 0.0012s | 0.0010s | **1.3x** |
| sha256sum | 100 files | 0.0019s | 0.0015s | **1.3x** |
| md5sum | single 100KB text | 0.0013s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0032s | 0.0028s | **1.1x** |
| md5sum | single 10MB text | 0.0212s | 0.0176s | **1.2x** |
| md5sum | single 10MB binary | 0.0222s | 0.0184s | **1.2x** |
| md5sum | single 100MB text | 0.1981s | 0.1620s | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0010s | **1.2x** |
| md5sum | 100 files | 0.0019s | 0.0015s | **1.3x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0026s | **0.8x** |
| b2sum | single 10MB text | 0.0143s | 0.0149s | **1.0x** |
| b2sum | single 10MB binary | 0.0150s | 0.0155s | **1.0x** |
| b2sum | single 100MB text | 0.1327s | 0.1343s | **1.0x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0149s | **1.0x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0149s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0029s | **0.6x** |
| base64 | encode 10MB text | 0.0101s | 0.0064s | **1.6x** |
| base64 | encode 10MB binary | 0.0105s | 0.0065s | **1.6x** |
| base64 | decode 1MB | 0.0039s | 0.0032s | **1.2x** |
| base64 | decode 10MB | 0.0310s | 0.0191s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0062s | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0049s | **1.6x** |
| sort | lexicographic 1MB | 0.0078s | 0.0050s | **1.6x** |
| sort | lexicographic 10MB random | 0.0551s | 0.0206s | **2.7x** |
| sort | already sorted 10MB | 0.0247s | 0.0068s | **3.6x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0124s | **2.0x** |
| sort | -n numeric 10MB | 0.0759s | 0.0063s | **12.0x** |
| sort | -r reverse 10MB | 0.0563s | 0.0204s | **2.8x** |
| sort | -u unique 10MB | 0.0572s | 0.0227s | **2.5x** |
| sort | -t, -k2 CSV 10MB | 0.0761s | 0.0564s | **1.3x** |
| sort | repetitive 10MB | 0.0430s | 0.0150s | **2.9x** |
| sort | --parallel=4 10MB | 0.0545s | 0.0199s | **2.7x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0017s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0093s | 0.0064s | **1.5x** |
| tr | -d digits 10MB | 0.0112s | 0.0099s | **1.1x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0167s | **1.1x** |
| tr | -s spaces 10MB | 0.0167s | 0.0137s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0063s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0098s | **1.2x** |
| tr | translate binary 10MB | 0.0092s | 0.0065s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0053s | **1.8x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0067s | **2.5x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0054s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0097s | **3.0x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0054s | **1.7x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0053s | **1.7x** |
| uniq | -i case insensitive 10MB | 0.0165s | 0.0073s | **2.2x** |
| uniq | repetitive 10MB | 0.0467s | 0.0077s | **6.1x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | **0.9x** |
| tac | reverse 1MB text | 0.0017s | 0.0019s | **0.9x** |
| tac | reverse 10MB text | 0.0089s | 0.0044s | **2.0x** |
| tac | reverse 100MB text | 0.0828s | 0.0395s | **2.1x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0043s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0173s | 0.0092s | **1.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0032s | **1.4x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | N/A | - | - |
| wc | default 1MB text | N/A | - | - |
| wc | default 10MB text | N/A | - | - |
| wc | default 100MB text | N/A | - | - |
| wc | -l 10MB text | N/A | - | - |
| wc | -w 10MB text | N/A | - | - |
| wc | -c 10MB text | N/A | - | - |
| wc | -m 10MB text | N/A | - | - |
| wc | -L 10MB text | N/A | - | - |
| wc | default 10MB binary | N/A | - | - |
| wc | default 10MB repetitive | N/A | - | - |
| wc | 10 files | N/A | - | - |
| wc | 100 files | N/A | - | - |
| cut | -b1-100 10MB CSV | N/A | - | - |
| cut | -c1-100 10MB CSV | N/A | - | - |
| cut | -d, -f1 10MB CSV | N/A | - | - |
| cut | -d, -f1,3,5 10MB CSV | N/A | - | - |
| cut | -d, -f2-4 10MB CSV | N/A | - | - |
| cut | --complement -d, -f1 10MB CSV | N/A | - | - |
| cut | -d, -f1 100KB text | N/A | - | - |
| cut | -d, -f1 1MB text | N/A | - | - |
| cut | -d: -f1 colon file | N/A | - | - |
| sha256sum | single 100KB text | N/A | - | - |
| sha256sum | single 1MB text | N/A | - | - |
| sha256sum | single 10MB text | N/A | - | - |
| sha256sum | single 10MB binary | N/A | - | - |
| sha256sum | single 100MB text | N/A | - | - |
| sha256sum | 10 files | N/A | - | - |
| sha256sum | 100 files | N/A | - | - |
| md5sum | single 100KB text | N/A | - | - |
| md5sum | single 1MB text | N/A | - | - |
| md5sum | single 10MB text | N/A | - | - |
| md5sum | single 10MB binary | N/A | - | - |
| md5sum | single 100MB text | N/A | - | - |
| md5sum | 10 files | N/A | - | - |
| md5sum | 100 files | N/A | - | - |
| b2sum | single 100KB text | N/A | - | - |
| b2sum | single 1MB text | N/A | - | - |
| b2sum | single 10MB text | N/A | - | - |
| b2sum | single 10MB binary | N/A | - | - |
| b2sum | single 100MB text | N/A | - | - |
| b2sum | -l 256 10MB | N/A | - | - |
| b2sum | -l 128 10MB | N/A | - | - |
| b2sum | 100 files | N/A | - | - |
| base64 | encode 100KB text | N/A | - | - |
| base64 | encode 1MB text | N/A | - | - |
| base64 | encode 10MB text | N/A | - | - |
| base64 | encode 10MB binary | N/A | - | - |
| base64 | decode 1MB | N/A | - | - |
| base64 | decode 10MB | N/A | - | - |
| base64 | encode -w 76 10MB | N/A | - | - |
| base64 | encode -w 0 (no wrap) 10MB | N/A | - | - |
| sort | lexicographic 1MB | N/A | - | - |
| sort | lexicographic 10MB random | N/A | - | - |
| sort | already sorted 10MB | N/A | - | - |
| sort | reverse sorted 10MB | N/A | - | - |
| sort | -n numeric 10MB | N/A | - | - |
| sort | -r reverse 10MB | N/A | - | - |
| sort | -u unique 10MB | N/A | - | - |
| sort | -t, -k2 CSV 10MB | N/A | - | - |
| sort | repetitive 10MB | N/A | - | - |
| sort | --parallel=4 10MB | N/A | - | - |
| tr | a-z to A-Z 1MB | N/A | - | - |
| tr | a-z to A-Z 10MB | N/A | - | - |
| tr | -d digits 10MB | N/A | - | - |
| tr | -d lowercase 10MB | N/A | - | - |
| tr | -s spaces 10MB | N/A | - | - |
| tr | [:lower:] to [:upper:] 10MB | N/A | - | - |
| tr | -d [:digit:] 10MB CSV | N/A | - | - |
| tr | translate binary 10MB | N/A | - | - |
| uniq | default 10MB many duplicates | N/A | - | - |
| uniq | default 10MB sorted (low dup) | N/A | - | - |
| uniq | -c count 10MB many dups | N/A | - | - |
| uniq | -c count 10MB sorted | N/A | - | - |
| uniq | -d duplicates only 10MB | N/A | - | - |
| uniq | -u unique only 10MB | N/A | - | - |
| uniq | -i case insensitive 10MB | N/A | - | - |
| uniq | repetitive 10MB | N/A | - | - |
| tac | reverse 100KB text | N/A | - | - |
| tac | reverse 1MB text | N/A | - | - |
| tac | reverse 10MB text | N/A | - | - |
| tac | reverse 100MB text | N/A | - | - |
| tac | reverse CSV 10MB | N/A | - | - |
| tac | reverse repetitive 10MB | N/A | - | - |
| tac | custom separator 1MB | N/A | - | - |
