# fcoreutils v0.3.6 — Detailed Results

Generated: 2026-02-16 10:44:21 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 826/826 (100.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0337s | 0.0063s | 0.0251s | **5.4x** | **4.0x** |
| wc | default 100MB text | 0.2982s | 0.0414s | 0.2262s | **7.2x** | **5.5x** |
| wc | -l 10MB text | 0.0037s | 0.0019s | 0.0022s | **1.9x** | **1.1x** |
| wc | -w 10MB text | 0.0335s | 0.0061s | 0.0227s | **5.5x** | **3.7x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0336s | 0.0019s | 0.0024s | **17.5x** | **1.2x** |
| wc | -L 10MB text | 0.0339s | 0.0063s | 0.0171s | **5.4x** | **2.7x** |
| wc | default 10MB binary | 0.2351s | 0.0168s | 0.1176s | **14.0x** | **7.0x** |
| wc | default 10MB repetitive | 0.0537s | 0.0073s | 0.0364s | **7.3x** | **5.0x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0014s | 0.0015s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0182s | 0.0037s | 0.0059s | **4.9x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0036s | 0.0057s | **5.0x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0182s | 0.0029s | 0.0069s | **6.4x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0209s | 0.0043s | 0.0158s | **4.9x** | **3.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0228s | 0.0035s | 0.0124s | **6.6x** | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0259s | 0.0045s | 0.0158s | **5.7x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0014s | 0.0016s | **2.3x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | 0.0009s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0018s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0025s | 0.0036s | **0.6x** | **1.5x** |
| sha256sum | single 10MB text | 0.0070s | 0.0079s | 0.0263s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0083s | 0.0281s | **0.9x** | **3.4x** |
| sha256sum | single 100MB text | 0.0677s | 0.0546s | 0.2621s | **1.2x** | **4.8x** |
| sha256sum | 10 files | 0.0010s | 0.0012s | 0.0011s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0018s | 0.0016s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0034s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0203s | 0.0171s | 0.0170s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0213s | 0.0178s | 0.0177s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1998s | 0.1432s | 0.1651s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0011s | 0.0010s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0016s | 0.0018s | 0.0016s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0019s | 0.0020s | 0.0021s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0136s | 0.0133s | 0.0132s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0142s | 0.0137s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1339s | 0.1155s | 0.1281s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0136s | 0.0131s | 0.0129s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0137s | 0.0133s | 0.0132s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0015s | 0.0015s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0009s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0015s | 0.0014s | 0.0015s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0091s | 0.0033s | 0.0069s | **2.7x** | **2.1x** |
| base64 | encode 10MB binary | 0.0093s | 0.0032s | 0.0068s | **2.9x** | **2.1x** |
| base64 | decode 1MB | 0.0036s | 0.0014s | 0.0035s | **2.5x** | **2.4x** |
| base64 | decode 10MB | 0.0300s | 0.0032s | 0.0260s | **9.3x** | **8.1x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0031s | 0.0069s | **3.0x** | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0070s | 0.0023s | 0.0068s | **3.0x** | **2.9x** |
| sort | lexicographic 1MB | 0.0074s | 0.0025s | 0.0040s | **3.0x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0498s | 0.0059s | 0.0270s | **8.5x** | **4.6x** |
| sort | already sorted 10MB | 0.0240s | 0.0030s | 0.0124s | **8.0x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0240s | 0.0045s | 0.0132s | **5.3x** | **2.9x** |
| sort | -n numeric 10MB | 0.0674s | 0.0035s | 0.0573s | **19.1x** | **16.2x** |
| sort | -r reverse 10MB | 0.0506s | 0.0062s | 0.0269s | **8.1x** | **4.3x** |
| sort | -u unique 10MB | 0.0527s | 0.0073s | 0.0326s | **7.3x** | **4.5x** |
| sort | -t, -k2 CSV 10MB | 0.0683s | 0.0135s | 0.0630s | **5.0x** | **4.6x** |
| sort | repetitive 10MB | 0.0448s | 0.0096s | 0.0336s | **4.7x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0490s | 0.0061s | 0.0268s | **8.1x** | **4.4x** |
| tr | a-z to A-Z 1MB | 0.0017s | 0.0013s | 0.0017s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0050s | 0.0069s | **1.8x** | **1.4x** |
| tr | -d digits 10MB | 0.0110s | 0.0066s | 0.0100s | **1.7x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0085s | 0.0170s | **2.2x** | **2.0x** |
| tr | -s spaces 10MB | 0.0165s | 0.0044s | 0.0114s | **3.7x** | **2.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0051s | 0.0068s | **1.8x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0064s | 0.0100s | **1.7x** | **1.6x** |
| tr | translate binary 10MB | 0.0093s | 0.0052s | 0.0077s | **1.8x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0027s | 0.0085s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0030s | 0.0095s | **5.4x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0030s | 0.0085s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0068s | 0.0113s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0026s | 0.0085s | **3.5x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0026s | 0.0086s | **3.4x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0039s | 0.0095s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0476s | 0.0035s | 0.0144s | **13.7x** | **4.1x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0009s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0015s | 0.0014s | 0.0014s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0083s | 0.0027s | 0.0049s | **3.1x** | **1.8x** |
| tac | reverse 100MB text | 0.0843s | 0.0146s | 0.0419s | **5.8x** | **2.9x** |
| tac | reverse CSV 10MB | 0.0077s | 0.0022s | 0.0043s | **3.4x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0178s | 0.0037s | 0.0086s | **4.8x** | **2.3x** |
| tac | custom separator 1MB | 0.0042s | 0.0031s | 0.0036s | **1.3x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0543s | 0.0026s | 0.0302s | **20.6x** | **11.5x** |
| wc | default 100MB text | 0.4836s | 0.0089s | 0.2538s | **54.1x** | **28.4x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0081s | 0.0264s | **6.7x** | **3.3x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0544s | 0.0024s | 0.0020s | **22.6x** | **0.8x** |
| wc | -L 10MB text | 0.0538s | 0.0114s | 0.0197s | **4.7x** | **1.7x** |
| wc | default 10MB binary | 0.3171s | 0.0265s | 0.1520s | **12.0x** | **5.7x** |
| wc | default 10MB repetitive | 0.0729s | 0.0034s | 0.0395s | **21.6x** | **11.7x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0023s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0038s | 0.0074s | **5.9x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0039s | 0.0072s | **5.8x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0033s | 0.0085s | **5.1x** | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0064s | 0.0175s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0238s | 0.0047s | 0.0134s | **5.0x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0053s | 0.0162s | **5.8x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.2x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0097s | 0.0083s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0099s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0758s | 0.0751s | 0.0760s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0014s | 0.0014s | **0.9x** | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0171s | 0.0177s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0180s | 0.0183s | 0.0221s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1617s | 0.1528s | 0.2035s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0014s | 0.0014s | **0.9x** | **1.0x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0123s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0129s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1436s | 0.1128s | 0.1130s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0123s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0123s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0014s | 0.0018s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0122s | 0.0041s | 0.0081s | **3.0x** | **2.0x** |
| base64 | encode 10MB binary | 0.0127s | 0.0042s | 0.0085s | **3.1x** | **2.0x** |
| base64 | decode 1MB | 0.0040s | 0.0013s | 0.0044s | **3.0x** | **3.3x** |
| base64 | decode 10MB | 0.0325s | 0.0039s | 0.0339s | **8.3x** | **8.7x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0041s | 0.0082s | **3.0x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0032s | 0.0071s | **2.7x** | **2.2x** |
| sort | lexicographic 1MB | 0.0085s | 0.0031s | 0.0054s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0095s | 0.0351s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0259s | 0.0042s | 0.0177s | **6.2x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0064s | 0.0179s | **4.3x** | **2.8x** |
| sort | -n numeric 10MB | 0.0730s | 0.0056s | 0.0747s | **13.0x** | **13.3x** |
| sort | -r reverse 10MB | 0.0541s | 0.0095s | 0.0359s | **5.7x** | **3.8x** |
| sort | -u unique 10MB | 0.0572s | 0.0095s | 0.0394s | **6.0x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0661s | 0.0192s | 0.0814s | **3.4x** | **4.2x** |
| sort | repetitive 10MB | 0.0550s | 0.0116s | 0.0362s | **4.7x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0540s | 0.0097s | 0.0358s | **5.6x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0059s | 0.0078s | **2.2x** | **1.3x** |
| tr | -d digits 10MB | 0.0170s | 0.0056s | 0.0140s | **3.0x** | **2.5x** |
| tr | -d lowercase 10MB | 0.0297s | 0.0066s | 0.0224s | **4.5x** | **3.4x** |
| tr | -s spaces 10MB | 0.0272s | 0.0044s | 0.0270s | **6.2x** | **6.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0058s | 0.0073s | **2.2x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0170s | 0.0056s | 0.0142s | **3.1x** | **2.5x** |
| tr | translate binary 10MB | 0.0113s | 0.0057s | 0.0093s | **2.0x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0035s | 0.0113s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0039s | 0.0134s | **3.5x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0035s | 0.0113s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0095s | 0.0158s | **3.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0037s | 0.0114s | **3.3x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0043s | 0.0134s | **3.2x** | **3.1x** |
| uniq | repetitive 10MB | 0.0417s | 0.0041s | 0.0159s | **10.0x** | **3.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0036s | 0.0059s | **3.0x** | **1.6x** |
| tac | reverse 100MB text | 0.1037s | 0.0197s | 0.0525s | **5.3x** | **2.7x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0030s | 0.0057s | **3.0x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0052s | 0.0111s | **4.4x** | **2.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0035s | 0.0053s | **1.7x** | **1.5x** |
