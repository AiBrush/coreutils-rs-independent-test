# fcoreutils v0.0.51 — Detailed Results

Generated: 2026-02-15 22:23:40 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 236 | 21 | 215 | 8.9% |

**Overall: 433/649 (66.7%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0012s | **0.9x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.4x** |
| wc | default 10MB text | 0.0335s | 0.0060s | **5.6x** |
| wc | default 100MB text | 0.2931s | 0.0413s | **7.1x** |
| wc | -l 10MB text | 0.0037s | 0.0020s | **1.8x** |
| wc | -w 10MB text | 0.0336s | 0.0061s | **5.5x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0336s | 0.0022s | **15.2x** |
| wc | -L 10MB text | 0.0335s | 0.0064s | **5.2x** |
| wc | default 10MB binary | 0.2352s | 0.0171s | **13.7x** |
| wc | default 10MB repetitive | 0.0506s | 0.0067s | **7.6x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0190s | 0.0028s | **6.7x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0032s | **6.0x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0049s | **3.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0047s | **4.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0237s | 0.0047s | **5.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0269s | 0.0049s | **5.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | single 1MB text | 0.0019s | 0.0028s | **0.7x** |
| sha256sum | single 10MB text | 0.0070s | 0.0073s | **1.0x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0078s | **1.0x** |
| sha256sum | single 100MB text | 0.0626s | 0.0555s | **1.1x** |
| sha256sum | 10 files | 0.0013s | 0.0020s | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0027s | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | **0.9x** |
| md5sum | single 10MB text | 0.0204s | 0.0162s | **1.3x** |
| md5sum | single 10MB binary | 0.0216s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1937s | 0.1419s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0021s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0131s | 0.0130s | **1.0x** |
| b2sum | single 10MB binary | 0.0146s | 0.0138s | **1.1x** |
| b2sum | single 100MB text | 0.1283s | 0.1300s | **1.0x** |
| b2sum | -l 256 10MB | 0.0131s | 0.0129s | **1.0x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0131s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0017s | **1.1x** |
| base64 | encode 10MB text | 0.0093s | 0.0036s | **2.6x** |
| base64 | encode 10MB binary | 0.0102s | 0.0032s | **3.2x** |
| base64 | decode 1MB | 0.0038s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0309s | 0.0147s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0033s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0071s | 0.0029s | **2.4x** |
| sort | lexicographic 1MB | 0.0076s | 0.0030s | **2.6x** |
| sort | lexicographic 10MB random | 0.0510s | 0.0058s | **8.9x** |
| sort | already sorted 10MB | 0.0242s | 0.0053s | **4.6x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0046s | **5.2x** |
| sort | -n numeric 10MB | 0.0688s | 0.0223s | **3.1x** |
| sort | -r reverse 10MB | 0.0540s | 0.0071s | **7.6x** |
| sort | -u unique 10MB | 0.0551s | 0.0158s | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0733s | 0.0224s | **3.3x** |
| sort | repetitive 10MB | 0.0420s | 0.0126s | **3.3x** |
| sort | --parallel=4 10MB | 0.0534s | 0.0066s | **8.1x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0022s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0063s | **1.5x** |
| tr | -d digits 10MB | 0.0115s | 0.0133s | **0.9x** |
| tr | -d lowercase 10MB | 0.0196s | 0.0189s | **1.0x** |
| tr | -s spaces 10MB | 0.0170s | 0.0136s | **1.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0063s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0130s | **0.9x** |
| tr | translate binary 10MB | 0.0091s | 0.0103s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0033s | **4.9x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0047s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0066s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0044s | **3.7x** |
| uniq | repetitive 10MB | 0.0464s | 0.0041s | **11.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0018s | **1.0x** |
| tac | reverse 10MB text | 0.0083s | 0.0045s | **1.8x** |
| tac | reverse 100MB text | 0.0797s | 0.0377s | **2.1x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0047s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0169s | 0.0093s | **1.8x** |
| tac | custom separator 1MB | 0.0043s | 0.0039s | **1.1x** |

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
