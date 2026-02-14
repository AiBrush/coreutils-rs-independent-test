# fcoreutils v0.0.34 — Detailed Results

Generated: 2026-02-14 04:29:39 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 412 | 1 | 99.8% |

**Overall: 1231/1239 (99.4%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0012s | **0.9x** |
| wc | default 1MB text | 0.0039s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0347s | 0.0169s | **2.1x** |
| wc | default 100MB text | 0.2918s | 0.0411s | **7.1x** |
| wc | -l 10MB text | 0.0047s | 0.0024s | **2.0x** |
| wc | -w 10MB text | 0.0346s | 0.0172s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0345s | 0.0022s | **15.7x** |
| wc | -L 10MB text | 0.0348s | 0.0169s | **2.1x** |
| wc | default 10MB binary | 0.2343s | 0.0595s | **3.9x** |
| wc | default 10MB repetitive | 0.0549s | 0.0072s | **7.6x** |
| wc | 10 files | 0.0009s | 0.0012s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0036s | **5.3x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0032s | **5.9x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0047s | **4.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0050s | **4.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0045s | **5.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0050s | **5.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0011s | **1.1x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.2x** |
| sha256sum | single 10MB text | 0.0082s | 0.0067s | **1.2x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0067s | **1.1x** |
| sha256sum | single 100MB text | 0.0619s | 0.0528s | **1.2x** |
| sha256sum | 10 files | 0.0013s | 0.0019s | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0029s | **0.6x** |
| md5sum | single 100KB text | 0.0014s | 0.0013s | **1.1x** |
| md5sum | single 1MB text | 0.0032s | 0.0027s | **1.2x** |
| md5sum | single 10MB text | 0.0216s | 0.0165s | **1.3x** |
| md5sum | single 10MB binary | 0.0215s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1938s | 0.1497s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0019s | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0027s | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0146s | 0.0125s | **1.2x** |
| b2sum | single 10MB binary | 0.0142s | 0.0129s | **1.1x** |
| b2sum | single 100MB text | 0.1281s | 0.1121s | **1.1x** |
| b2sum | -l 256 10MB | 0.0146s | 0.0127s | **1.2x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0126s | **1.2x** |
| b2sum | 100 files | 0.0017s | 0.0028s | **0.6x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | **0.7x** |
| base64 | encode 1MB text | 0.0017s | 0.0018s | **1.0x** |
| base64 | encode 10MB text | 0.0104s | 0.0052s | **2.0x** |
| base64 | encode 10MB binary | 0.0100s | 0.0052s | **1.9x** |
| base64 | decode 1MB | 0.0039s | 0.0026s | **1.5x** |
| base64 | decode 10MB | 0.0311s | 0.0148s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0104s | 0.0052s | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0044s | **1.9x** |
| sort | lexicographic 1MB | 0.0080s | 0.0049s | **1.6x** |
| sort | lexicographic 10MB random | 0.0544s | 0.0144s | **3.8x** |
| sort | already sorted 10MB | 0.0251s | 0.0055s | **4.5x** |
| sort | reverse sorted 10MB | 0.0250s | 0.0078s | **3.2x** |
| sort | -n numeric 10MB | 0.0731s | 0.0276s | **2.7x** |
| sort | -r reverse 10MB | 0.0552s | 0.0144s | **3.8x** |
| sort | -u unique 10MB | 0.0562s | 0.0146s | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0749s | 0.0458s | **1.6x** |
| sort | repetitive 10MB | 0.0456s | 0.0133s | **3.4x** |
| sort | --parallel=4 10MB | 0.0527s | 0.0140s | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0021s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0069s | **1.3x** |
| tr | -d digits 10MB | 0.0112s | 0.0098s | **1.1x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0169s | **1.1x** |
| tr | -s spaces 10MB | 0.0167s | 0.0138s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0068s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0098s | **1.1x** |
| tr | translate binary 10MB | 0.0093s | 0.0069s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0048s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0047s | **3.5x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0062s | **1.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0078s | **3.7x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0049s | **1.9x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0049s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0060s | **2.7x** |
| uniq | repetitive 10MB | 0.0490s | 0.0076s | **6.4x** |
| tac | reverse 100KB text | 0.0008s | 0.0014s | **0.6x** |
| tac | reverse 1MB text | 0.0017s | 0.0019s | **0.9x** |
| tac | reverse 10MB text | 0.0093s | 0.0056s | **1.6x** |
| tac | reverse 100MB text | 0.0795s | 0.0392s | **2.0x** |
| tac | reverse CSV 10MB | 0.0086s | 0.0056s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0195s | 0.0112s | **1.7x** |
| tac | custom separator 1MB | 0.0046s | 0.0043s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0545s | 0.0210s | **2.6x** |
| wc | default 100MB text | 0.4848s | 0.0750s | **6.5x** |
| wc | -l 10MB text | 0.0021s | 0.0021s | **1.0x** |
| wc | -w 10MB text | 0.0546s | 0.0221s | **2.5x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0548s | 0.0023s | **23.7x** |
| wc | -L 10MB text | 0.0546s | 0.0233s | **2.3x** |
| wc | default 10MB binary | 0.3166s | 0.0834s | **3.8x** |
| wc | default 10MB repetitive | 0.0741s | 0.0136s | **5.4x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0237s | 0.0045s | **5.2x** |
| cut | -c1-100 10MB CSV | 0.0232s | 0.0042s | **5.5x** |
| cut | -d, -f1 10MB CSV | 0.0170s | 0.0064s | **2.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0224s | 0.0081s | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0075s | **3.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0310s | 0.0093s | **3.3x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0013s | **1.1x** |
| sha256sum | single 1MB text | 0.0020s | 0.0018s | **1.1x** |
| sha256sum | single 10MB text | 0.0089s | 0.0085s | **1.0x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0088s | **1.0x** |
| sha256sum | single 100MB text | 0.0755s | 0.0746s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0052s | **0.5x** |
| md5sum | single 100KB text | 0.0015s | 0.0014s | **1.1x** |
| md5sum | single 1MB text | 0.0029s | 0.0030s | **1.0x** |
| md5sum | single 10MB text | 0.0178s | 0.0207s | **0.9x** |
| md5sum | single 10MB binary | 0.0184s | 0.0218s | **0.8x** |
| md5sum | single 100MB text | 0.1611s | 0.1938s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0021s | **0.7x** |
| md5sum | 100 files | 0.0024s | 0.0050s | **0.5x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0024s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0151s | 0.0123s | **1.2x** |
| b2sum | single 10MB binary | 0.0158s | 0.0130s | **1.2x** |
| b2sum | single 100MB text | 0.1431s | 0.1121s | **1.3x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0124s | **1.2x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0123s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0052s | **0.4x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0017s | **1.3x** |
| base64 | encode 10MB text | 0.0128s | 0.0047s | **2.7x** |
| base64 | encode 10MB binary | 0.0131s | 0.0048s | **2.7x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | **1.8x** |
| base64 | decode 10MB | 0.0333s | 0.0121s | **2.8x** |
| base64 | encode -w 76 10MB | 0.0127s | 0.0048s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0090s | 0.0036s | **2.5x** |
| sort | lexicographic 1MB | 0.0088s | 0.0051s | **1.7x** |
| sort | lexicographic 10MB random | 0.0548s | 0.0131s | **4.2x** |
| sort | already sorted 10MB | 0.0267s | 0.0074s | **3.6x** |
| sort | reverse sorted 10MB | 0.0282s | 0.0103s | **2.7x** |
| sort | -n numeric 10MB | 0.0739s | 0.0295s | **2.5x** |
| sort | -r reverse 10MB | 0.0551s | 0.0119s | **4.6x** |
| sort | -u unique 10MB | 0.0581s | 0.0121s | **4.8x** |
| sort | -t, -k2 CSV 10MB | 0.0689s | 0.0400s | **1.7x** |
| sort | repetitive 10MB | 0.0558s | 0.0169s | **3.3x** |
| sort | --parallel=4 10MB | 0.0546s | 0.0118s | **4.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0020s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0135s | 0.0057s | **2.4x** |
| tr | -d digits 10MB | 0.0171s | 0.0125s | **1.4x** |
| tr | -d lowercase 10MB | 0.0294s | 0.0214s | **1.4x** |
| tr | -s spaces 10MB | 0.0281s | 0.0148s | **1.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0142s | 0.0057s | **2.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0164s | 0.0125s | **1.3x** |
| tr | translate binary 10MB | 0.0112s | 0.0054s | **2.1x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0062s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0062s | **2.3x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0073s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0101s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0059s | **2.0x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0060s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0143s | 0.0078s | **1.8x** |
| uniq | repetitive 10MB | 0.0425s | 0.0083s | **5.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0014s | **0.7x** |
| tac | reverse 1MB text | 0.0020s | 0.0019s | **1.1x** |
| tac | reverse 10MB text | 0.0110s | 0.0076s | **1.5x** |
| tac | reverse 100MB text | 0.1046s | 0.0520s | **2.0x** |
| tac | reverse CSV 10MB | 0.0098s | 0.0072s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0240s | 0.0133s | **1.8x** |
| tac | custom separator 1MB | 0.0059s | 0.0047s | **1.3x** |
