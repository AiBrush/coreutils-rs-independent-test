# fcoreutils v0.0.15 — Detailed Results

Generated: 2026-02-14 10:09:12 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 405 | 8 | 98.1% |
| Linux_aarch64 | 413 | 409 | 4 | 99.0% |
| Linux_x86_64 | 413 | 409 | 4 | 99.0% |

**Overall: 1223/1239 (98.7%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0009s | 0.0009s | **1.0x** |
| wc | default 1MB text | 0.0036s | 0.0026s | **1.4x** |
| wc | default 10MB text | 0.0330s | 0.0217s | **1.5x** |
| wc | default 100MB text | 0.2885s | 0.1812s | **1.6x** |
| wc | -l 10MB text | 0.0033s | 0.0018s | **1.8x** |
| wc | -w 10MB text | 0.0331s | 0.0204s | **1.6x** |
| wc | -c 10MB text | 0.0007s | 0.0007s | **0.9x** |
| wc | -m 10MB text | 0.0330s | 0.0032s | **10.5x** |
| wc | -L 10MB text | 0.0332s | 0.0153s | **2.2x** |
| wc | default 10MB binary | 0.2343s | 0.0561s | **4.2x** |
| wc | default 10MB repetitive | 0.0532s | 0.0233s | **2.3x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0012s | 0.0016s | **0.8x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0046s | **4.0x** |
| cut | -c1-100 10MB CSV | 0.0181s | 0.0046s | **3.9x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0031s | **5.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0207s | 0.0051s | **4.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0228s | 0.0045s | **5.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0260s | 0.0062s | **4.2x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0032s | 0.0013s | **2.5x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0010s | 0.0008s | **1.3x** |
| sha256sum | single 1MB text | 0.0016s | 0.0014s | **1.1x** |
| sha256sum | single 10MB text | 0.0065s | 0.0067s | **1.0x** |
| sha256sum | single 10MB binary | 0.0070s | 0.0071s | **1.0x** |
| sha256sum | single 100MB text | 0.0567s | 0.0596s | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0012s | **0.9x** |
| sha256sum | 100 files | 0.0016s | 0.0020s | **0.8x** |
| md5sum | single 100KB text | 0.0011s | 0.0009s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0023s | **1.3x** |
| md5sum | single 10MB text | 0.0197s | 0.0156s | **1.3x** |
| md5sum | single 10MB binary | 0.0211s | 0.0166s | **1.3x** |
| md5sum | single 100MB text | 0.1881s | 0.1488s | **1.3x** |
| md5sum | 10 files | 0.0010s | 0.0012s | **0.9x** |
| md5sum | 100 files | 0.0015s | 0.0020s | **0.8x** |
| b2sum | single 100KB text | 0.0008s | 0.0009s | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0020s | **1.0x** |
| b2sum | single 10MB text | 0.0130s | 0.0126s | **1.0x** |
| b2sum | single 10MB binary | 0.0139s | 0.0134s | **1.0x** |
| b2sum | single 100MB text | 0.1233s | 0.1171s | **1.1x** |
| b2sum | -l 256 10MB | 0.0128s | 0.0126s | **1.0x** |
| b2sum | -l 128 10MB | 0.0130s | 0.0126s | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0021s | **0.7x** |
| base64 | encode 100KB text | 0.0008s | 0.0008s | **0.9x** |
| base64 | encode 1MB text | 0.0015s | 0.0018s | **0.9x** |
| base64 | encode 10MB text | 0.0087s | 0.0097s | **0.9x** |
| base64 | encode 10MB binary | 0.0095s | 0.0102s | **0.9x** |
| base64 | decode 1MB | 0.0035s | 0.0023s | **1.5x** |
| base64 | decode 10MB | 0.0295s | 0.0172s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0085s | 0.0098s | **0.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0065s | 0.0065s | **1.0x** |
| sort | lexicographic 1MB | 0.0071s | 0.0042s | **1.7x** |
| sort | lexicographic 10MB random | 0.0486s | 0.0147s | **3.3x** |
| sort | already sorted 10MB | 0.0241s | 0.0085s | **2.8x** |
| sort | reverse sorted 10MB | 0.0237s | 0.0087s | **2.7x** |
| sort | -n numeric 10MB | 0.0670s | 0.0291s | **2.3x** |
| sort | -r reverse 10MB | 0.0504s | 0.0150s | **3.4x** |
| sort | -u unique 10MB | 0.0518s | 0.0160s | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0677s | 0.0285s | **2.4x** |
| sort | repetitive 10MB | 0.0410s | 0.0189s | **2.2x** |
| sort | --parallel=4 10MB | 0.0488s | 0.0146s | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0017s | 0.0015s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0060s | **1.5x** |
| tr | -d digits 10MB | 0.0109s | 0.0109s | **1.0x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0180s | **1.1x** |
| tr | -s spaces 10MB | 0.0165s | 0.0206s | **0.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0060s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0108s | 0.0108s | **1.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0061s | **1.5x** |
| uniq | default 10MB many duplicates | 0.0088s | 0.0044s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0160s | 0.0052s | **3.1x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0068s | **4.3x** |
| uniq | -d duplicates only 10MB | 0.0089s | 0.0046s | **1.9x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0057s | **2.8x** |
| uniq | repetitive 10MB | 0.0459s | 0.0067s | **6.9x** |
| tac | reverse 100KB text | 0.0007s | 0.0008s | **0.9x** |
| tac | reverse 1MB text | 0.0015s | 0.0013s | **1.1x** |
| tac | reverse 10MB text | 0.0076s | 0.0049s | **1.6x** |
| tac | reverse 100MB text | 0.0757s | 0.0430s | **1.8x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0054s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0163s | 0.0098s | **1.7x** |
| tac | custom separator 1MB | 0.0041s | 0.0046s | **0.9x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0031s | **1.8x** |
| wc | default 10MB text | 0.0541s | 0.0272s | **2.0x** |
| wc | default 100MB text | 0.4796s | 0.2294s | **2.1x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0249s | **2.2x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0541s | 0.0037s | **14.5x** |
| wc | -L 10MB text | 0.0541s | 0.0154s | **3.5x** |
| wc | default 10MB binary | 0.3159s | 0.0859s | **3.7x** |
| wc | default 10MB repetitive | 0.0730s | 0.0319s | **2.3x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0026s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0055s | **4.1x** |
| cut | -c1-100 10MB CSV | 0.0223s | 0.0054s | **4.1x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0037s | **4.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0074s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0071s | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0104s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | **2.0x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0009s | **1.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.2x** |
| sha256sum | single 10MB text | 0.0083s | 0.0080s | **1.0x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0085s | **1.0x** |
| sha256sum | single 100MB text | 0.0743s | 0.0732s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0016s | **0.9x** |
| sha256sum | 100 files | 0.0024s | 0.0042s | **0.6x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.4x** |
| md5sum | single 1MB text | 0.0029s | 0.0028s | **1.0x** |
| md5sum | single 10MB text | 0.0170s | 0.0201s | **0.8x** |
| md5sum | single 10MB binary | 0.0177s | 0.0211s | **0.8x** |
| md5sum | single 100MB text | 0.1598s | 0.1931s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0016s | **0.9x** |
| md5sum | 100 files | 0.0023s | 0.0041s | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0010s | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0020s | **1.2x** |
| b2sum | single 10MB text | 0.0149s | 0.0118s | **1.3x** |
| b2sum | single 10MB binary | 0.0156s | 0.0124s | **1.3x** |
| b2sum | single 100MB text | 0.1420s | 0.1107s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0119s | **1.3x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0119s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0042s | **0.5x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0021s | **1.0x** |
| base64 | encode 10MB text | 0.0122s | 0.0066s | **1.8x** |
| base64 | encode 10MB binary | 0.0127s | 0.0072s | **1.8x** |
| base64 | decode 1MB | 0.0040s | 0.0028s | **1.4x** |
| base64 | decode 10MB | 0.0324s | 0.0164s | **2.0x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0067s | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0036s | **2.4x** |
| sort | lexicographic 1MB | 0.0086s | 0.0050s | **1.7x** |
| sort | lexicographic 10MB random | 0.0537s | 0.0170s | **3.2x** |
| sort | already sorted 10MB | 0.0261s | 0.0107s | **2.4x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0108s | **2.5x** |
| sort | -n numeric 10MB | 0.0730s | 0.0375s | **1.9x** |
| sort | -r reverse 10MB | 0.0542s | 0.0170s | **3.2x** |
| sort | -u unique 10MB | 0.0570s | 0.0169s | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0658s | 0.0321s | **2.1x** |
| sort | repetitive 10MB | 0.0546s | 0.0183s | **3.0x** |
| sort | --parallel=4 10MB | 0.0540s | 0.0171s | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0022s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0083s | **1.5x** |
| tr | -d digits 10MB | 0.0160s | 0.0145s | **1.1x** |
| tr | -d lowercase 10MB | 0.0285s | 0.0259s | **1.1x** |
| tr | -s spaces 10MB | 0.0266s | 0.0300s | **0.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0083s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0144s | **1.1x** |
| tr | translate binary 10MB | 0.0117s | 0.0107s | **1.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0044s | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0043s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0048s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0069s | **4.2x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0048s | **2.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0048s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0053s | **2.7x** |
| uniq | repetitive 10MB | 0.0417s | 0.0071s | **5.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0010s | **1.0x** |
| tac | reverse 1MB text | 0.0019s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0061s | **1.7x** |
| tac | reverse 100MB text | 0.1026s | 0.0466s | **2.2x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0067s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0117s | **1.9x** |
| tac | custom separator 1MB | 0.0060s | 0.0064s | **0.9x** |
