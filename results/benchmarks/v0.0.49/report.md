# fcoreutils v0.0.49 — Detailed Results

Generated: 2026-02-15 05:42:25 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | **1.0x** |
| wc | default 1MB text | 0.0039s | 0.0034s | **1.2x** |
| wc | default 10MB text | 0.0345s | 0.0065s | **5.3x** |
| wc | default 100MB text | 0.2944s | 0.0411s | **7.2x** |
| wc | -l 10MB text | 0.0045s | 0.0021s | **2.1x** |
| wc | -w 10MB text | 0.0345s | 0.0062s | **5.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0345s | 0.0024s | **14.2x** |
| wc | -L 10MB text | 0.0346s | 0.0067s | **5.2x** |
| wc | default 10MB binary | 0.2341s | 0.0171s | **13.7x** |
| wc | default 10MB repetitive | 0.0504s | 0.0070s | **7.2x** |
| wc | 10 files | 0.0008s | 0.0012s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0022s | **0.6x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0027s | **6.9x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0028s | **6.5x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0045s | **4.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0046s | **4.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0048s | **4.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0048s | **5.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0028s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0022s | **0.5x** |
| sha256sum | single 1MB text | 0.0018s | 0.0028s | **0.6x** |
| sha256sum | single 10MB text | 0.0082s | 0.0074s | **1.1x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0080s | **0.9x** |
| sha256sum | single 100MB text | 0.0642s | 0.0555s | **1.2x** |
| sha256sum | 10 files | 0.0011s | 0.0021s | **0.5x** |
| sha256sum | 100 files | 0.0018s | 0.0027s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0029s | **0.5x** |
| md5sum | single 1MB text | 0.0032s | 0.0037s | **0.9x** |
| md5sum | single 10MB text | 0.0215s | 0.0166s | **1.3x** |
| md5sum | single 10MB binary | 0.0213s | 0.0169s | **1.3x** |
| md5sum | single 100MB text | 0.1957s | 0.1427s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0022s | **0.5x** |
| md5sum | 100 files | 0.0021s | 0.0027s | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0025s | 0.0025s | **1.0x** |
| b2sum | single 10MB text | 0.0146s | 0.0132s | **1.1x** |
| b2sum | single 10MB binary | 0.0144s | 0.0136s | **1.1x** |
| b2sum | single 100MB text | 0.1305s | 0.1197s | **1.1x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0133s | **1.1x** |
| b2sum | -l 128 10MB | 0.0145s | 0.0132s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0017s | **1.1x** |
| base64 | encode 10MB text | 0.0105s | 0.0036s | **2.9x** |
| base64 | encode 10MB binary | 0.0100s | 0.0035s | **2.8x** |
| base64 | decode 1MB | 0.0040s | 0.0025s | **1.6x** |
| base64 | decode 10MB | 0.0304s | 0.0144s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0102s | 0.0037s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0083s | 0.0036s | **2.3x** |
| sort | lexicographic 1MB | 0.0078s | 0.0031s | **2.5x** |
| sort | lexicographic 10MB random | 0.0527s | 0.0060s | **8.8x** |
| sort | already sorted 10MB | 0.0245s | 0.0053s | **4.6x** |
| sort | reverse sorted 10MB | 0.0243s | 0.0050s | **4.8x** |
| sort | -n numeric 10MB | 0.0735s | 0.0235s | **3.1x** |
| sort | -r reverse 10MB | 0.0546s | 0.0070s | **7.8x** |
| sort | -u unique 10MB | 0.0574s | 0.0160s | **3.6x** |
| sort | -t, -k2 CSV 10MB | 0.0739s | 0.0214s | **3.5x** |
| sort | repetitive 10MB | 0.0423s | 0.0124s | **3.4x** |
| sort | --parallel=4 10MB | 0.0526s | 0.0060s | **8.8x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0022s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0074s | **1.2x** |
| tr | -d digits 10MB | 0.0112s | 0.0129s | **0.9x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0200s | **0.9x** |
| tr | -s spaces 10MB | 0.0167s | 0.0140s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0071s | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0129s | **0.9x** |
| tr | translate binary 10MB | 0.0092s | 0.0099s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0096s | 0.0052s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0035s | **4.6x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0048s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0067s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0048s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0044s | **3.8x** |
| uniq | repetitive 10MB | 0.0465s | 0.0042s | **11.1x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.7x** |
| tac | reverse 1MB text | 0.0017s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0092s | 0.0051s | **1.8x** |
| tac | reverse 100MB text | 0.0818s | 0.0401s | **2.0x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0049s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0172s | 0.0097s | **1.8x** |
| tac | custom separator 1MB | 0.0044s | 0.0042s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0058s | 0.0030s | **1.9x** |
| wc | default 10MB text | 0.0543s | 0.0031s | **17.3x** |
| wc | default 100MB text | 0.4835s | 0.0147s | **33.0x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | **0.8x** |
| wc | -w 10MB text | 0.0547s | 0.0094s | **5.8x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0549s | 0.0033s | **16.7x** |
| wc | -L 10MB text | 0.0544s | 0.0106s | **5.1x** |
| wc | default 10MB binary | 0.3168s | 0.0277s | **11.4x** |
| wc | default 10MB repetitive | 0.0733s | 0.0049s | **14.8x** |
| wc | 10 files | 0.0010s | 0.0014s | **0.7x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0230s | 0.0036s | **6.4x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0035s | **6.4x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0052s | **3.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0063s | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0064s | **3.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0076s | **4.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0031s | **0.7x** |
| sha256sum | single 10MB text | 0.0087s | 0.0098s | **0.9x** |
| sha256sum | single 10MB binary | 0.0091s | 0.0101s | **0.9x** |
| sha256sum | single 100MB text | 0.0764s | 0.0765s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0032s | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0026s | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0044s | **0.7x** |
| md5sum | single 10MB text | 0.0175s | 0.0179s | **1.0x** |
| md5sum | single 10MB binary | 0.0186s | 0.0182s | **1.0x** |
| md5sum | single 100MB text | 0.1625s | 0.1540s | **1.1x** |
| md5sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0158s | 0.0126s | **1.2x** |
| b2sum | single 100MB text | 0.1445s | 0.1123s | **1.3x** |
| b2sum | -l 256 10MB | 0.0156s | 0.0123s | **1.3x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0122s | **1.2x** |
| b2sum | 100 files | 0.0023s | 0.0020s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0022s | 0.0016s | **1.3x** |
| base64 | encode 10MB text | 0.0126s | 0.0057s | **2.2x** |
| base64 | encode 10MB binary | 0.0132s | 0.0058s | **2.3x** |
| base64 | decode 1MB | 0.0043s | 0.0025s | **1.7x** |
| base64 | decode 10MB | 0.0339s | 0.0118s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0132s | 0.0057s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0043s | **2.1x** |
| sort | lexicographic 1MB | 0.0089s | 0.0041s | **2.2x** |
| sort | lexicographic 10MB random | 0.0574s | 0.0095s | **6.1x** |
| sort | already sorted 10MB | 0.0270s | 0.0072s | **3.7x** |
| sort | reverse sorted 10MB | 0.0291s | 0.0080s | **3.7x** |
| sort | -n numeric 10MB | 0.0757s | 0.0312s | **2.4x** |
| sort | -r reverse 10MB | 0.0564s | 0.0103s | **5.5x** |
| sort | -u unique 10MB | 0.0598s | 0.0153s | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0694s | 0.0265s | **2.6x** |
| sort | repetitive 10MB | 0.0565s | 0.0169s | **3.3x** |
| sort | --parallel=4 10MB | 0.0564s | 0.0093s | **6.0x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0021s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0064s | **2.1x** |
| tr | -d digits 10MB | 0.0173s | 0.0113s | **1.5x** |
| tr | -d lowercase 10MB | 0.0304s | 0.0100s | **3.0x** |
| tr | -s spaces 10MB | 0.0277s | 0.0131s | **2.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0129s | 0.0072s | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0180s | 0.0114s | **1.6x** |
| tr | translate binary 10MB | 0.0120s | 0.0093s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0049s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0044s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0126s | 0.0055s | **2.3x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0084s | **3.5x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0048s | **2.5x** |
| uniq | -u unique only 10MB | 0.0124s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0144s | 0.0051s | **2.8x** |
| uniq | repetitive 10MB | 0.0424s | 0.0056s | **7.6x** |
| tac | reverse 100KB text | 0.0011s | 0.0013s | **0.8x** |
| tac | reverse 1MB text | 0.0021s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0110s | 0.0049s | **2.2x** |
| tac | reverse 100MB text | 0.1076s | 0.0411s | **2.6x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0052s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0242s | 0.0109s | **2.2x** |
| tac | custom separator 1MB | 0.0063s | 0.0047s | **1.3x** |
