# fcoreutils v0.0.39 — Detailed Results

Generated: 2026-02-17 00:26:42 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 411 | 2 | 99.5% |

**Overall: 823/826 (99.6%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0013s | **0.9x** |
| wc | default 1MB text | 0.0038s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0341s | 0.0064s | **5.3x** |
| wc | default 100MB text | 0.2898s | 0.0405s | **7.2x** |
| wc | -l 10MB text | 0.0039s | 0.0021s | **1.8x** |
| wc | -w 10MB text | 0.0339s | 0.0066s | **5.2x** |
| wc | -c 10MB text | 0.0007s | 0.0011s | **0.7x** |
| wc | -m 10MB text | 0.0340s | 0.0024s | **14.3x** |
| wc | -L 10MB text | 0.0340s | 0.0061s | **5.6x** |
| wc | default 10MB binary | 0.2344s | 0.0175s | **13.4x** |
| wc | default 10MB repetitive | 0.0557s | 0.0077s | **7.3x** |
| wc | 10 files | 0.0008s | 0.0012s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0015s | **0.8x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0032s | **5.8x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0031s | **5.9x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0044s | **4.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0210s | 0.0047s | **4.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0039s | **5.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0053s | **5.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0011s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0028s | **1.2x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | **0.6x** |
| sha256sum | single 100KB text | 0.0011s | 0.0026s | **0.4x** |
| sha256sum | single 1MB text | 0.0017s | 0.0031s | **0.6x** |
| sha256sum | single 10MB text | 0.0073s | 0.0086s | **0.8x** |
| sha256sum | single 10MB binary | 0.0072s | 0.0086s | **0.8x** |
| sha256sum | single 100MB text | 0.0592s | 0.0580s | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0035s | **0.3x** |
| sha256sum | 100 files | 0.0018s | 0.0040s | **0.5x** |
| md5sum | single 100KB text | 0.0014s | 0.0027s | **0.5x** |
| md5sum | single 1MB text | 0.0031s | 0.0041s | **0.8x** |
| md5sum | single 10MB text | 0.0209s | 0.0176s | **1.2x** |
| md5sum | single 10MB binary | 0.0215s | 0.0183s | **1.2x** |
| md5sum | single 100MB text | 0.1910s | 0.1466s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0035s | **0.3x** |
| md5sum | 100 files | 0.0018s | 0.0042s | **0.4x** |
| b2sum | single 100KB text | 0.0008s | 0.0015s | **0.5x** |
| b2sum | single 1MB text | 0.0021s | 0.0026s | **0.8x** |
| b2sum | single 10MB text | 0.0139s | 0.0136s | **1.0x** |
| b2sum | single 10MB binary | 0.0142s | 0.0139s | **1.0x** |
| b2sum | single 100MB text | 0.1257s | 0.1173s | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0136s | **1.0x** |
| b2sum | -l 128 10MB | 0.0140s | 0.0136s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0027s | **0.6x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0017s | **0.9x** |
| base64 | encode 10MB text | 0.0098s | 0.0058s | **1.7x** |
| base64 | encode 10MB binary | 0.0099s | 0.0061s | **1.6x** |
| base64 | decode 1MB | 0.0038s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0308s | 0.0140s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0097s | 0.0058s | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0047s | **1.6x** |
| sort | lexicographic 1MB | 0.0076s | 0.0031s | **2.5x** |
| sort | lexicographic 10MB random | 0.0531s | 0.0062s | **8.5x** |
| sort | already sorted 10MB | 0.0248s | 0.0053s | **4.7x** |
| sort | reverse sorted 10MB | 0.0251s | 0.0054s | **4.7x** |
| sort | -n numeric 10MB | 0.0703s | 0.0220s | **3.2x** |
| sort | -r reverse 10MB | 0.0535s | 0.0070s | **7.6x** |
| sort | -u unique 10MB | 0.0555s | 0.0139s | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0721s | 0.0198s | **3.7x** |
| sort | repetitive 10MB | 0.0454s | 0.0130s | **3.5x** |
| sort | --parallel=4 10MB | 0.0520s | 0.0059s | **8.8x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0036s | **0.5x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0197s | **0.4x** |
| tr | -d digits 10MB | 0.0111s | 0.0102s | **1.1x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0172s | **1.1x** |
| tr | -s spaces 10MB | 0.0169s | 0.0147s | **1.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0198s | **0.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0104s | **1.1x** |
| tr | translate binary 10MB | 0.0093s | 0.0103s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0049s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0161s | 0.0029s | **5.6x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0061s | **1.5x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0075s | **3.9x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0048s | **1.9x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0047s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0058s | **2.8x** |
| uniq | repetitive 10MB | 0.0489s | 0.0045s | **10.9x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0084s | 0.0044s | **1.9x** |
| tac | reverse 100MB text | 0.0772s | 0.0370s | **2.1x** |
| tac | reverse CSV 10MB | 0.0079s | 0.0044s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0190s | 0.0094s | **2.0x** |
| tac | custom separator 1MB | 0.0043s | 0.0038s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0059s | 0.0031s | **1.9x** |
| wc | default 10MB text | 0.0547s | 0.0032s | **17.2x** |
| wc | default 100MB text | 0.4826s | 0.0143s | **33.7x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | **0.8x** |
| wc | -w 10MB text | 0.0545s | 0.0108s | **5.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0543s | 0.0030s | **18.4x** |
| wc | -L 10MB text | 0.0540s | 0.0100s | **5.4x** |
| wc | default 10MB binary | 0.3209s | 0.0276s | **11.6x** |
| wc | default 10MB repetitive | 0.0733s | 0.0046s | **15.9x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0039s | **5.7x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0039s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0062s | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0079s | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0073s | **3.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0091s | **3.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0027s | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0032s | **0.6x** |
| sha256sum | single 10MB text | 0.0084s | 0.0099s | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0105s | **0.9x** |
| sha256sum | single 100MB text | 0.0745s | 0.0739s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0053s | **0.3x** |
| sha256sum | 100 files | 0.0024s | 0.0061s | **0.4x** |
| md5sum | single 100KB text | 0.0015s | 0.0029s | **0.5x** |
| md5sum | single 1MB text | 0.0029s | 0.0042s | **0.7x** |
| md5sum | single 10MB text | 0.0171s | 0.0178s | **1.0x** |
| md5sum | single 10MB binary | 0.0179s | 0.0183s | **1.0x** |
| md5sum | single 100MB text | 0.1616s | 0.1519s | **1.1x** |
| md5sum | 10 files | 0.0014s | 0.0051s | **0.3x** |
| md5sum | 100 files | 0.0023s | 0.0061s | **0.4x** |
| b2sum | single 100KB text | 0.0010s | 0.0017s | **0.6x** |
| b2sum | single 1MB text | 0.0023s | 0.0026s | **0.9x** |
| b2sum | single 10MB text | 0.0150s | 0.0131s | **1.1x** |
| b2sum | single 10MB binary | 0.0153s | 0.0127s | **1.2x** |
| b2sum | single 100MB text | 0.1424s | 0.1116s | **1.3x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0132s | **1.2x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0127s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0049s | **0.5x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0017s | **1.2x** |
| base64 | encode 10MB text | 0.0125s | 0.0068s | **1.8x** |
| base64 | encode 10MB binary | 0.0132s | 0.0074s | **1.8x** |
| base64 | decode 1MB | 0.0040s | 0.0025s | **1.6x** |
| base64 | decode 10MB | 0.0327s | 0.0150s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0063s | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0042s | **2.1x** |
| sort | lexicographic 1MB | 0.0085s | 0.0037s | **2.3x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0088s | **6.1x** |
| sort | already sorted 10MB | 0.0262s | 0.0071s | **3.7x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0071s | **3.9x** |
| sort | -n numeric 10MB | 0.0735s | 0.0300s | **2.5x** |
| sort | -r reverse 10MB | 0.0545s | 0.0090s | **6.1x** |
| sort | -u unique 10MB | 0.0575s | 0.0130s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0666s | 0.0258s | **2.6x** |
| sort | repetitive 10MB | 0.0558s | 0.0164s | **3.4x** |
| sort | --parallel=4 10MB | 0.0569s | 0.0092s | **6.2x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0031s | **0.8x** |
| tr | a-z to A-Z 10MB | 0.0134s | 0.0073s | **1.8x** |
| tr | -d digits 10MB | 0.0172s | 0.0139s | **1.2x** |
| tr | -d lowercase 10MB | 0.0331s | 0.0229s | **1.4x** |
| tr | -s spaces 10MB | 0.0272s | 0.0159s | **1.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0078s | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0163s | 0.0136s | **1.2x** |
| tr | translate binary 10MB | 0.0121s | 0.0119s | **1.0x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0067s | **1.8x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0039s | **3.5x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0072s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0101s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0062s | **1.9x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0062s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0076s | **1.8x** |
| uniq | repetitive 10MB | 0.0422s | 0.0056s | **7.5x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0049s | **2.1x** |
| tac | reverse 100MB text | 0.1030s | 0.0433s | **2.4x** |
| tac | reverse CSV 10MB | 0.0097s | 0.0052s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0104s | **2.2x** |
| tac | custom separator 1MB | 0.0060s | 0.0042s | **1.4x** |
