# fcoreutils v0.0.53 — Detailed Results

Generated: 2026-02-16 09:40:30 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | **0.9x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.4x** |
| wc | default 10MB text | 0.0331s | 0.0058s | **5.7x** |
| wc | default 100MB text | 0.2922s | 0.0402s | **7.3x** |
| wc | -l 10MB text | 0.0035s | 0.0019s | **1.8x** |
| wc | -w 10MB text | 0.0333s | 0.0064s | **5.2x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0332s | 0.0021s | **15.8x** |
| wc | -L 10MB text | 0.0334s | 0.0063s | **5.3x** |
| wc | default 10MB binary | 0.2346s | 0.0178s | **13.2x** |
| wc | default 10MB repetitive | 0.0504s | 0.0068s | **7.5x** |
| wc | 10 files | 0.0009s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0013s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0190s | 0.0035s | **5.4x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0029s | **6.5x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0048s | **4.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0047s | **4.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0236s | 0.0049s | **4.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0275s | 0.0054s | **5.1x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0013s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0019s | 0.0029s | **0.7x** |
| sha256sum | single 10MB text | 0.0073s | 0.0076s | **1.0x** |
| sha256sum | single 10MB binary | 0.0082s | 0.0078s | **1.1x** |
| sha256sum | single 100MB text | 0.0620s | 0.0548s | **1.1x** |
| sha256sum | 10 files | 0.0012s | 0.0021s | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0026s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | **0.9x** |
| md5sum | single 10MB text | 0.0205s | 0.0163s | **1.3x** |
| md5sum | single 10MB binary | 0.0221s | 0.0169s | **1.3x** |
| md5sum | single 100MB text | 0.1937s | 0.1418s | **1.4x** |
| md5sum | 10 files | 0.0012s | 0.0021s | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0027s | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0022s | 0.0025s | **0.9x** |
| b2sum | single 10MB text | 0.0135s | 0.0129s | **1.0x** |
| b2sum | single 10MB binary | 0.0145s | 0.0134s | **1.1x** |
| b2sum | single 100MB text | 0.1283s | 0.1191s | **1.1x** |
| b2sum | -l 256 10MB | 0.0134s | 0.0130s | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0130s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0017s | **1.0x** |
| base64 | encode 10MB text | 0.0095s | 0.0033s | **2.9x** |
| base64 | encode 10MB binary | 0.0104s | 0.0034s | **3.1x** |
| base64 | decode 1MB | 0.0040s | 0.0026s | **1.5x** |
| base64 | decode 10MB | 0.0309s | 0.0147s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0036s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0071s | 0.0029s | **2.4x** |
| sort | lexicographic 1MB | 0.0076s | 0.0030s | **2.6x** |
| sort | lexicographic 10MB random | 0.0523s | 0.0062s | **8.4x** |
| sort | already sorted 10MB | 0.0250s | 0.0054s | **4.6x** |
| sort | reverse sorted 10MB | 0.0246s | 0.0048s | **5.1x** |
| sort | -n numeric 10MB | 0.0693s | 0.0216s | **3.2x** |
| sort | -r reverse 10MB | 0.0528s | 0.0065s | **8.1x** |
| sort | -u unique 10MB | 0.0561s | 0.0139s | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0714s | 0.0186s | **3.8x** |
| sort | repetitive 10MB | 0.0416s | 0.0115s | **3.6x** |
| sort | --parallel=4 10MB | 0.0506s | 0.0058s | **8.7x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0020s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0056s | **1.6x** |
| tr | -d digits 10MB | 0.0115s | 0.0128s | **0.9x** |
| tr | -d lowercase 10MB | 0.0198s | 0.0183s | **1.1x** |
| tr | -s spaces 10MB | 0.0171s | 0.0157s | **1.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0061s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0133s | **0.9x** |
| tr | translate binary 10MB | 0.0091s | 0.0099s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0030s | **5.5x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0066s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0042s | **3.9x** |
| uniq | repetitive 10MB | 0.0463s | 0.0041s | **11.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0081s | 0.0046s | **1.8x** |
| tac | reverse 100MB text | 0.0794s | 0.0378s | **2.1x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0047s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0168s | 0.0093s | **1.8x** |
| tac | custom separator 1MB | 0.0044s | 0.0040s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0058s | 0.0028s | **2.0x** |
| wc | default 10MB text | 0.0540s | 0.0031s | **17.3x** |
| wc | default 100MB text | 0.4772s | 0.0144s | **33.2x** |
| wc | -l 10MB text | 0.0020s | 0.0026s | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0121s | **4.5x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0542s | 0.0031s | **17.3x** |
| wc | -L 10MB text | 0.0540s | 0.0130s | **4.1x** |
| wc | default 10MB binary | 0.3153s | 0.0390s | **8.1x** |
| wc | default 10MB repetitive | 0.0732s | 0.0046s | **15.9x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0040s | **5.6x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0041s | **5.5x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0072s | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0081s | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0083s | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0100s | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0095s | **0.9x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0099s | **0.9x** |
| sha256sum | single 100MB text | 0.0742s | 0.0746s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | **0.7x** |
| md5sum | single 10MB text | 0.0171s | 0.0173s | **1.0x** |
| md5sum | single 10MB binary | 0.0178s | 0.0180s | **1.0x** |
| md5sum | single 100MB text | 0.1595s | 0.1521s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | **0.8x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0155s | 0.0126s | **1.2x** |
| b2sum | single 100MB text | 0.1416s | 0.1109s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0121s | **1.2x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0023s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0123s | 0.0051s | **2.4x** |
| base64 | encode 10MB binary | 0.0128s | 0.0052s | **2.5x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | **1.9x** |
| base64 | decode 10MB | 0.0325s | 0.0104s | **3.1x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0051s | **2.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0042s | **2.1x** |
| sort | lexicographic 1MB | 0.0086s | 0.0040s | **2.2x** |
| sort | lexicographic 10MB random | 0.0707s | 0.0100s | **7.0x** |
| sort | already sorted 10MB | 0.0353s | 0.0072s | **4.9x** |
| sort | reverse sorted 10MB | 0.0367s | 0.0081s | **4.5x** |
| sort | -n numeric 10MB | 0.1043s | 0.0373s | **2.8x** |
| sort | -r reverse 10MB | 0.0709s | 0.0109s | **6.5x** |
| sort | -u unique 10MB | 0.0731s | 0.0142s | **5.1x** |
| sort | -t, -k2 CSV 10MB | 0.0894s | 0.0310s | **2.9x** |
| sort | repetitive 10MB | 0.0649s | 0.0162s | **4.0x** |
| sort | --parallel=4 10MB | 0.0700s | 0.0104s | **6.7x** |
| tr | a-z to A-Z 1MB | 0.0031s | 0.0024s | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0181s | 0.0068s | **2.7x** |
| tr | -d digits 10MB | 0.0235s | 0.0128s | **1.8x** |
| tr | -d lowercase 10MB | 0.0392s | 0.0106s | **3.7x** |
| tr | -s spaces 10MB | 0.0386s | 0.0169s | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0179s | 0.0065s | **2.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0239s | 0.0126s | **1.9x** |
| tr | translate binary 10MB | 0.0157s | 0.0092s | **1.7x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0048s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0042s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0048s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0081s | **3.6x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0048s | **2.5x** |
| uniq | -u unique only 10MB | 0.0126s | 0.0049s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0049s | **2.8x** |
| uniq | repetitive 10MB | 0.0416s | 0.0067s | **6.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0047s | **2.2x** |
| tac | reverse 100MB text | 0.1028s | 0.0389s | **2.6x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0049s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0096s | **2.4x** |
| tac | custom separator 1MB | 0.0081s | 0.0053s | **1.5x** |
