# fcoreutils v0.0.27 — Detailed Results

Generated: 2026-02-16 06:17:34 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 397 | 16 | 96.1% |
| Linux_aarch64 | 413 | 402 | 11 | 97.3% |
| Linux_x86_64 | 413 | 402 | 11 | 97.3% |

**Overall: 1201/1239 (96.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0040s | 0.0028s | **1.4x** |
| wc | default 10MB text | 0.0343s | 0.0174s | **2.0x** |
| wc | default 100MB text | 0.2958s | 0.0414s | **7.1x** |
| wc | -l 10MB text | 0.0044s | 0.0023s | **1.9x** |
| wc | -w 10MB text | 0.0343s | 0.0170s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0343s | 0.0021s | **16.3x** |
| wc | -L 10MB text | 0.0343s | 0.0172s | **2.0x** |
| wc | default 10MB binary | 0.2345s | 0.0596s | **3.9x** |
| wc | default 10MB repetitive | 0.0506s | 0.0082s | **6.2x** |
| wc | 10 files | 0.0009s | 0.0009s | **1.0x** |
| wc | 100 files | 0.0014s | 0.0014s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0049s | **3.8x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0051s | **3.6x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0031s | **6.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0056s | **3.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0052s | **4.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0068s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0016s | **2.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0010s | **1.2x** |
| sha256sum | single 1MB text | 0.0018s | 0.0019s | **1.0x** |
| sha256sum | single 10MB text | 0.0080s | 0.0084s | **1.0x** |
| sha256sum | single 10MB binary | 0.0082s | 0.0088s | **0.9x** |
| sha256sum | single 100MB text | 0.0663s | 0.0719s | **0.9x** |
| sha256sum | 10 files | 0.0012s | 0.0009s | **1.3x** |
| sha256sum | 100 files | 0.0019s | 0.0015s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0033s | 0.0029s | **1.2x** |
| md5sum | single 10MB text | 0.0216s | 0.0180s | **1.2x** |
| md5sum | single 10MB binary | 0.0222s | 0.0183s | **1.2x** |
| md5sum | single 100MB text | 0.1977s | 0.1625s | **1.2x** |
| md5sum | 10 files | 0.0013s | 0.0010s | **1.3x** |
| md5sum | 100 files | 0.0019s | 0.0015s | **1.2x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0026s | **0.8x** |
| b2sum | single 10MB text | 0.0143s | 0.0150s | **1.0x** |
| b2sum | single 10MB binary | 0.0149s | 0.0157s | **0.9x** |
| b2sum | single 100MB text | 0.1326s | 0.1369s | **1.0x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0150s | **0.9x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0150s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0028s | **0.6x** |
| base64 | encode 10MB text | 0.0101s | 0.0064s | **1.6x** |
| base64 | encode 10MB binary | 0.0106s | 0.0066s | **1.6x** |
| base64 | decode 1MB | 0.0039s | 0.0031s | **1.2x** |
| base64 | decode 10MB | 0.0302s | 0.0182s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0063s | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0079s | 0.0050s | **1.6x** |
| sort | lexicographic 1MB | 0.0077s | 0.0041s | **1.9x** |
| sort | lexicographic 10MB random | 0.0534s | 0.0177s | **3.0x** |
| sort | already sorted 10MB | 0.0243s | 0.0066s | **3.7x** |
| sort | reverse sorted 10MB | 0.0243s | 0.0088s | **2.8x** |
| sort | -n numeric 10MB | 0.0732s | 0.0064s | **11.4x** |
| sort | -r reverse 10MB | 0.0553s | 0.0176s | **3.1x** |
| sort | -u unique 10MB | 0.0578s | 0.0193s | **3.0x** |
| sort | -t, -k2 CSV 10MB | 0.0764s | 0.0341s | **2.2x** |
| sort | repetitive 10MB | 0.0422s | 0.0151s | **2.8x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0179s | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0017s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0061s | **1.4x** |
| tr | -d digits 10MB | 0.0110s | 0.0098s | **1.1x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0166s | **1.1x** |
| tr | -s spaces 10MB | 0.0167s | 0.0140s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0062s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0099s | **1.1x** |
| tr | translate binary 10MB | 0.0094s | 0.0066s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0055s | **1.7x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0068s | **2.4x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0054s | **1.8x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0097s | **3.0x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0055s | **1.7x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0054s | **1.7x** |
| uniq | -i case insensitive 10MB | 0.0165s | 0.0074s | **2.2x** |
| uniq | repetitive 10MB | 0.0467s | 0.0078s | **6.0x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0090s | 0.0045s | **2.0x** |
| tac | reverse 100MB text | 0.0829s | 0.0401s | **2.1x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0044s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0172s | 0.0092s | **1.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0037s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0061s | 0.0036s | **1.7x** |
| wc | default 10MB text | 0.0549s | 0.0211s | **2.6x** |
| wc | default 100MB text | 0.4827s | 0.0663s | **7.3x** |
| wc | -l 10MB text | 0.0023s | 0.0020s | **1.1x** |
| wc | -w 10MB text | 0.0548s | 0.0222s | **2.5x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0547s | 0.0020s | **27.4x** |
| wc | -L 10MB text | 0.0548s | 0.0234s | **2.3x** |
| wc | default 10MB binary | 0.3178s | 0.0829s | **3.8x** |
| wc | default 10MB repetitive | 0.0731s | 0.0123s | **6.0x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.1x** |
| wc | 100 files | 0.0020s | 0.0019s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0233s | 0.0056s | **4.2x** |
| cut | -c1-100 10MB CSV | 0.0233s | 0.0054s | **4.3x** |
| cut | -d, -f1 10MB CSV | 0.0172s | 0.0035s | **4.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0230s | 0.0077s | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0071s | **3.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0107s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.1x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0024s | **1.5x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0015s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0022s | 0.0026s | **0.9x** |
| sha256sum | single 10MB text | 0.0092s | 0.0124s | **0.7x** |
| sha256sum | single 10MB binary | 0.0094s | 0.0126s | **0.7x** |
| sha256sum | single 100MB text | 0.0761s | 0.1050s | **0.7x** |
| sha256sum | 10 files | 0.0015s | 0.0010s | **1.5x** |
| sha256sum | 100 files | 0.0026s | 0.0019s | **1.3x** |
| md5sum | single 100KB text | 0.0015s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0031s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0178s | 0.0244s | **0.7x** |
| md5sum | single 10MB binary | 0.0186s | 0.0251s | **0.7x** |
| md5sum | single 100MB text | 0.1615s | 0.2249s | **0.7x** |
| md5sum | 10 files | 0.0015s | 0.0010s | **1.5x** |
| md5sum | 100 files | 0.0026s | 0.0020s | **1.3x** |
| b2sum | single 100KB text | 0.0011s | 0.0010s | **1.0x** |
| b2sum | single 1MB text | 0.0025s | 0.0029s | **0.9x** |
| b2sum | single 10MB text | 0.0158s | 0.0162s | **1.0x** |
| b2sum | single 10MB binary | 0.0162s | 0.0166s | **1.0x** |
| b2sum | single 100MB text | 0.1438s | 0.1427s | **1.0x** |
| b2sum | -l 256 10MB | 0.0157s | 0.0162s | **1.0x** |
| b2sum | -l 128 10MB | 0.0157s | 0.0162s | **1.0x** |
| b2sum | 100 files | 0.0024s | 0.0020s | **1.2x** |
| base64 | encode 100KB text | 0.0011s | 0.0012s | **0.9x** |
| base64 | encode 1MB text | 0.0022s | 0.0038s | **0.6x** |
| base64 | encode 10MB text | 0.0131s | 0.0062s | **2.1x** |
| base64 | encode 10MB binary | 0.0134s | 0.0062s | **2.2x** |
| base64 | decode 1MB | 0.0042s | 0.0037s | **1.1x** |
| base64 | decode 10MB | 0.0336s | 0.0227s | **1.5x** |
| base64 | encode -w 76 10MB | 0.0131s | 0.0062s | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0093s | 0.0034s | **2.7x** |
| sort | lexicographic 1MB | 0.0093s | 0.0047s | **2.0x** |
| sort | lexicographic 10MB random | 0.0568s | 0.0216s | **2.6x** |
| sort | already sorted 10MB | 0.0275s | 0.0075s | **3.7x** |
| sort | reverse sorted 10MB | 0.0284s | 0.0113s | **2.5x** |
| sort | -n numeric 10MB | 0.0766s | 0.0067s | **11.5x** |
| sort | -r reverse 10MB | 0.0577s | 0.0206s | **2.8x** |
| sort | -u unique 10MB | 0.0612s | 0.0210s | **2.9x** |
| sort | -t, -k2 CSV 10MB | 0.0711s | 0.0381s | **1.9x** |
| sort | repetitive 10MB | 0.0554s | 0.0137s | **4.1x** |
| sort | --parallel=4 10MB | 0.0571s | 0.0200s | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0020s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0092s | **1.4x** |
| tr | -d digits 10MB | 0.0176s | 0.0156s | **1.1x** |
| tr | -d lowercase 10MB | 0.0315s | 0.0256s | **1.2x** |
| tr | -s spaces 10MB | 0.0282s | 0.0176s | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0091s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0186s | 0.0153s | **1.2x** |
| tr | translate binary 10MB | 0.0116s | 0.0088s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0125s | 0.0058s | **2.2x** |
| uniq | default 10MB sorted (low dup) | 0.0146s | 0.0072s | **2.0x** |
| uniq | -c count 10MB many dups | 0.0125s | 0.0056s | **2.2x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0107s | **2.8x** |
| uniq | -d duplicates only 10MB | 0.0130s | 0.0059s | **2.2x** |
| uniq | -u unique only 10MB | 0.0125s | 0.0056s | **2.2x** |
| uniq | -i case insensitive 10MB | 0.0146s | 0.0077s | **1.9x** |
| uniq | repetitive 10MB | 0.0424s | 0.0069s | **6.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0021s | 0.0022s | **0.9x** |
| tac | reverse 10MB text | 0.0113s | 0.0044s | **2.6x** |
| tac | reverse 100MB text | 0.1043s | 0.0389s | **2.7x** |
| tac | reverse CSV 10MB | 0.0101s | 0.0052s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0241s | 0.0101s | **2.4x** |
| tac | custom separator 1MB | 0.0062s | 0.0045s | **1.4x** |
