# fcoreutils v0.0.52 — Detailed Results

Generated: 2026-02-17 03:37:34 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | **0.9x** |
| wc | default 1MB text | 0.0039s | 0.0025s | **1.5x** |
| wc | default 10MB text | 0.0336s | 0.0062s | **5.4x** |
| wc | default 100MB text | 0.2930s | 0.0411s | **7.1x** |
| wc | -l 10MB text | 0.0036s | 0.0020s | **1.8x** |
| wc | -w 10MB text | 0.0336s | 0.0067s | **5.0x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0336s | 0.0023s | **14.5x** |
| wc | -L 10MB text | 0.0336s | 0.0062s | **5.4x** |
| wc | default 10MB binary | 0.2346s | 0.0175s | **13.4x** |
| wc | default 10MB repetitive | 0.0527s | 0.0069s | **7.7x** |
| wc | 10 files | 0.0009s | 0.0011s | **0.8x** |
| wc | 100 files | 0.0013s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0029s | **6.5x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0029s | **6.5x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0046s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0046s | **4.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0050s | **4.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0268s | 0.0047s | **5.7x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0022s | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0026s | **0.7x** |
| sha256sum | single 10MB text | 0.0072s | 0.0074s | **1.0x** |
| sha256sum | single 10MB binary | 0.0077s | 0.0077s | **1.0x** |
| sha256sum | single 100MB text | 0.0622s | 0.0545s | **1.1x** |
| sha256sum | 10 files | 0.0012s | 0.0021s | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0026s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0022s | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0037s | **0.9x** |
| md5sum | single 10MB text | 0.0202s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0221s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1938s | 0.1422s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0021s | **0.5x** |
| md5sum | 100 files | 0.0018s | 0.0025s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0133s | 0.0129s | **1.0x** |
| b2sum | single 10MB binary | 0.0147s | 0.0135s | **1.1x** |
| b2sum | single 100MB text | 0.1286s | 0.1185s | **1.1x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0130s | **1.0x** |
| b2sum | -l 128 10MB | 0.0135s | 0.0129s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0017s | **1.0x** |
| base64 | encode 10MB text | 0.0094s | 0.0033s | **2.8x** |
| base64 | encode 10MB binary | 0.0104s | 0.0034s | **3.1x** |
| base64 | decode 1MB | 0.0039s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0310s | 0.0149s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0033s | **2.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0031s | **2.3x** |
| sort | lexicographic 1MB | 0.0078s | 0.0031s | **2.5x** |
| sort | lexicographic 10MB random | 0.0529s | 0.0054s | **9.8x** |
| sort | already sorted 10MB | 0.0240s | 0.0052s | **4.7x** |
| sort | reverse sorted 10MB | 0.0243s | 0.0046s | **5.2x** |
| sort | -n numeric 10MB | 0.0692s | 0.0220s | **3.1x** |
| sort | -r reverse 10MB | 0.0517s | 0.0061s | **8.4x** |
| sort | -u unique 10MB | 0.0548s | 0.0137s | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0733s | 0.0195s | **3.8x** |
| sort | repetitive 10MB | 0.0424s | 0.0121s | **3.5x** |
| sort | --parallel=4 10MB | 0.0508s | 0.0059s | **8.6x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0020s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0059s | **1.5x** |
| tr | -d digits 10MB | 0.0111s | 0.0129s | **0.9x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0187s | **1.0x** |
| tr | -s spaces 10MB | 0.0172s | 0.0159s | **1.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0056s | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0130s | **0.9x** |
| tr | translate binary 10MB | 0.0091s | 0.0100s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0047s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0160s | 0.0031s | **5.2x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0065s | **4.5x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0043s | **3.8x** |
| uniq | repetitive 10MB | 0.0463s | 0.0042s | **11.0x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0081s | 0.0044s | **1.8x** |
| tac | reverse 100MB text | 0.0796s | 0.0377s | **2.1x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0046s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0167s | 0.0092s | **1.8x** |
| tac | custom separator 1MB | 0.0043s | 0.0039s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0058s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0540s | 0.0031s | **17.2x** |
| wc | default 100MB text | 0.4860s | 0.0142s | **34.2x** |
| wc | -l 10MB text | 0.0021s | 0.0026s | **0.8x** |
| wc | -w 10MB text | 0.0539s | 0.0121s | **4.4x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.9x** |
| wc | -m 10MB text | 0.0540s | 0.0031s | **17.4x** |
| wc | -L 10MB text | 0.0541s | 0.0134s | **4.0x** |
| wc | default 10MB binary | 0.3172s | 0.0394s | **8.1x** |
| wc | default 10MB repetitive | 0.0726s | 0.0046s | **15.9x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0042s | **5.3x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0042s | **5.4x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0065s | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0079s | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0084s | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0097s | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0031s | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0096s | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0099s | **0.9x** |
| sha256sum | single 100MB text | 0.0743s | 0.0748s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0039s | **0.8x** |
| md5sum | single 10MB text | 0.0170s | 0.0174s | **1.0x** |
| md5sum | single 10MB binary | 0.0179s | 0.0188s | **0.9x** |
| md5sum | single 100MB text | 0.1600s | 0.1526s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0025s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0033s | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0156s | 0.0126s | **1.2x** |
| b2sum | single 100MB text | 0.1416s | 0.1109s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0121s | **1.2x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0123s | 0.0052s | **2.4x** |
| base64 | encode 10MB binary | 0.0128s | 0.0052s | **2.5x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | **1.9x** |
| base64 | decode 10MB | 0.0323s | 0.0104s | **3.1x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0052s | **2.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0040s | **2.1x** |
| sort | lexicographic 1MB | 0.0086s | 0.0040s | **2.1x** |
| sort | lexicographic 10MB random | 0.0703s | 0.0103s | **6.8x** |
| sort | already sorted 10MB | 0.0352s | 0.0072s | **4.9x** |
| sort | reverse sorted 10MB | 0.0367s | 0.0082s | **4.5x** |
| sort | -n numeric 10MB | 0.1043s | 0.0371s | **2.8x** |
| sort | -r reverse 10MB | 0.0704s | 0.0106s | **6.7x** |
| sort | -u unique 10MB | 0.0735s | 0.0139s | **5.3x** |
| sort | -t, -k2 CSV 10MB | 0.0894s | 0.0314s | **2.8x** |
| sort | repetitive 10MB | 0.0645s | 0.0166s | **3.9x** |
| sort | --parallel=4 10MB | 0.0697s | 0.0102s | **6.8x** |
| tr | a-z to A-Z 1MB | 0.0031s | 0.0024s | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0183s | 0.0066s | **2.8x** |
| tr | -d digits 10MB | 0.0236s | 0.0126s | **1.9x** |
| tr | -d lowercase 10MB | 0.0391s | 0.0106s | **3.7x** |
| tr | -s spaces 10MB | 0.0370s | 0.0180s | **2.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0183s | 0.0066s | **2.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0238s | 0.0127s | **1.9x** |
| tr | translate binary 10MB | 0.0152s | 0.0093s | **1.6x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0050s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0043s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0047s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0289s | 0.0081s | **3.6x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0047s | **2.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0047s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0049s | **2.9x** |
| uniq | repetitive 10MB | 0.0418s | 0.0065s | **6.4x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0046s | **2.3x** |
| tac | reverse 100MB text | 0.1025s | 0.0387s | **2.6x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0049s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0095s | **2.4x** |
| tac | custom separator 1MB | 0.0080s | 0.0059s | **1.3x** |
