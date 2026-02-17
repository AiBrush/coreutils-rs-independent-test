# fcoreutils v0.0.64 — Detailed Results

Generated: 2026-02-17 03:18:07 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 826/826 (100.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0037s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0331s | 0.0063s | **5.2x** |
| wc | default 100MB text | 0.2944s | 0.0460s | **6.4x** |
| wc | -l 10MB text | 0.0034s | 0.0021s | **1.6x** |
| wc | -w 10MB text | 0.0333s | 0.0065s | **5.1x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0333s | 0.0022s | **14.9x** |
| wc | -L 10MB text | 0.0332s | 0.0065s | **5.1x** |
| wc | default 10MB binary | 0.2366s | 0.0175s | **13.5x** |
| wc | default 10MB repetitive | 0.0505s | 0.0080s | **6.3x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.7x** |
| wc | 100 files | 0.0012s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0182s | 0.0032s | **5.7x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0031s | **6.0x** |
| cut | -d, -f1 10MB CSV | 0.0182s | 0.0041s | **4.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0043s | **4.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0229s | 0.0034s | **6.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0260s | 0.0048s | **5.4x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | single 1MB text | 0.0016s | 0.0025s | **0.7x** |
| sha256sum | single 10MB text | 0.0066s | 0.0071s | **0.9x** |
| sha256sum | single 10MB binary | 0.0077s | 0.0076s | **1.0x** |
| sha256sum | single 100MB text | 0.0605s | 0.0538s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0034s | **0.9x** |
| md5sum | single 10MB text | 0.0199s | 0.0160s | **1.2x** |
| md5sum | single 10MB binary | 0.0217s | 0.0168s | **1.3x** |
| md5sum | single 100MB text | 0.1926s | 0.1413s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0024s | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | **0.9x** |
| b2sum | single 10MB text | 0.0129s | 0.0123s | **1.1x** |
| b2sum | single 10MB binary | 0.0141s | 0.0130s | **1.1x** |
| b2sum | single 100MB text | 0.1273s | 0.1136s | **1.1x** |
| b2sum | -l 256 10MB | 0.0129s | 0.0122s | **1.1x** |
| b2sum | -l 128 10MB | 0.0130s | 0.0122s | **1.1x** |
| b2sum | 100 files | 0.0015s | 0.0013s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | **1.1x** |
| base64 | encode 10MB text | 0.0089s | 0.0047s | **1.9x** |
| base64 | encode 10MB binary | 0.0097s | 0.0051s | **1.9x** |
| base64 | decode 1MB | 0.0037s | 0.0022s | **1.7x** |
| base64 | decode 10MB | 0.0301s | 0.0111s | **2.7x** |
| base64 | encode -w 76 10MB | 0.0087s | 0.0047s | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0067s | 0.0042s | **1.6x** |
| sort | lexicographic 1MB | 0.0074s | 0.0026s | **2.8x** |
| sort | lexicographic 10MB random | 0.0510s | 0.0059s | **8.7x** |
| sort | already sorted 10MB | 0.0239s | 0.0040s | **5.9x** |
| sort | reverse sorted 10MB | 0.0233s | 0.0048s | **4.8x** |
| sort | -n numeric 10MB | 0.0681s | 0.0537s | **1.3x** |
| sort | -r reverse 10MB | 0.0518s | 0.0060s | **8.6x** |
| sort | -u unique 10MB | 0.0535s | 0.0122s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0698s | 0.0164s | **4.3x** |
| sort | repetitive 10MB | 0.0411s | 0.0074s | **5.6x** |
| sort | --parallel=4 10MB | 0.0503s | 0.0059s | **8.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0030s | **0.6x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0183s | **0.5x** |
| tr | -d digits 10MB | 0.0111s | 0.0133s | **0.8x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0193s | **1.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0056s | **3.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0086s | 0.0184s | **0.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0133s | **0.8x** |
| tr | translate binary 10MB | 0.0091s | 0.0174s | **0.5x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0047s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0161s | 0.0028s | **5.8x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0288s | 0.0066s | **4.3x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0045s | **2.0x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0045s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0159s | 0.0042s | **3.8x** |
| uniq | repetitive 10MB | 0.0462s | 0.0036s | **12.8x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.7x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0077s | 0.0044s | **1.7x** |
| tac | reverse 100MB text | 0.0784s | 0.0379s | **2.1x** |
| tac | reverse CSV 10MB | 0.0077s | 0.0046s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0165s | 0.0093s | **1.8x** |
| tac | custom separator 1MB | 0.0042s | 0.0041s | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0058s | 0.0028s | **2.1x** |
| wc | default 10MB text | 0.0543s | 0.0031s | **17.7x** |
| wc | default 100MB text | 0.4821s | 0.0145s | **33.4x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0087s | **6.3x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0544s | 0.0030s | **18.2x** |
| wc | -L 10MB text | 0.0545s | 0.0111s | **4.9x** |
| wc | default 10MB binary | 0.3156s | 0.0272s | **11.6x** |
| wc | default 10MB repetitive | 0.0731s | 0.0045s | **16.2x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0227s | 0.0042s | **5.4x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0042s | **5.3x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0051s | **3.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0071s | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0254s | 0.0053s | **4.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0308s | 0.0080s | **3.8x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0096s | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0099s | **0.9x** |
| sha256sum | single 100MB text | 0.0742s | 0.0754s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0038s | **0.7x** |
| md5sum | single 10MB text | 0.0172s | 0.0173s | **1.0x** |
| md5sum | single 10MB binary | 0.0181s | 0.0183s | **1.0x** |
| md5sum | single 100MB text | 0.1601s | 0.1529s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0031s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0122s | **1.2x** |
| b2sum | single 10MB binary | 0.0155s | 0.0127s | **1.2x** |
| b2sum | single 100MB text | 0.1418s | 0.1119s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0122s | **1.2x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0122s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | **1.5x** |
| base64 | encode 10MB text | 0.0124s | 0.0048s | **2.6x** |
| base64 | encode 10MB binary | 0.0129s | 0.0049s | **2.6x** |
| base64 | decode 1MB | 0.0040s | 0.0026s | **1.6x** |
| base64 | decode 10MB | 0.0331s | 0.0172s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0048s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0041s | **2.2x** |
| sort | lexicographic 1MB | 0.0090s | 0.0036s | **2.5x** |
| sort | lexicographic 10MB random | 0.0551s | 0.0096s | **5.8x** |
| sort | already sorted 10MB | 0.0266s | 0.0058s | **4.6x** |
| sort | reverse sorted 10MB | 0.0275s | 0.0075s | **3.7x** |
| sort | -n numeric 10MB | 0.0737s | 0.0534s | **1.4x** |
| sort | -r reverse 10MB | 0.0551s | 0.0097s | **5.7x** |
| sort | -u unique 10MB | 0.0581s | 0.0132s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0675s | 0.0238s | **2.8x** |
| sort | repetitive 10MB | 0.0561s | 0.0098s | **5.7x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0093s | **5.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0066s | **1.9x** |
| tr | -d digits 10MB | 0.0164s | 0.0150s | **1.1x** |
| tr | -d lowercase 10MB | 0.0294s | 0.0130s | **2.3x** |
| tr | -s spaces 10MB | 0.0300s | 0.0064s | **4.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0062s | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0132s | **1.2x** |
| tr | translate binary 10MB | 0.0124s | 0.0070s | **1.8x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0051s | **2.3x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0037s | **3.8x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0047s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0302s | 0.0081s | **3.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0047s | **2.6x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0049s | **2.9x** |
| uniq | repetitive 10MB | 0.0422s | 0.0054s | **7.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0050s | **2.1x** |
| tac | reverse 100MB text | 0.1047s | 0.0429s | **2.4x** |
| tac | reverse CSV 10MB | 0.0099s | 0.0053s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0234s | 0.0108s | **2.2x** |
| tac | custom separator 1MB | 0.0059s | 0.0046s | **1.3x** |
