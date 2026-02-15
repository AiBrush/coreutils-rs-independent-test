# fcoreutils v0.0.19 — Detailed Results

Generated: 2026-02-15 03:00:13 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 1233/1239 (99.5%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0039s | 0.0025s | **1.6x** |
| wc | default 10MB text | 0.0335s | 0.0063s | **5.3x** |
| wc | default 100MB text | 0.2919s | 0.0398s | **7.3x** |
| wc | -l 10MB text | 0.0038s | 0.0020s | **1.9x** |
| wc | -w 10MB text | 0.0336s | 0.0166s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0337s | 0.0019s | **17.4x** |
| wc | -L 10MB text | 0.0335s | 0.0169s | **2.0x** |
| wc | default 10MB binary | 0.2353s | 0.0595s | **4.0x** |
| wc | default 10MB repetitive | 0.0511s | 0.0068s | **7.5x** |
| wc | 10 files | 0.0009s | 0.0009s | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0051s | **3.7x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0049s | **3.9x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0035s | **5.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0060s | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0053s | **4.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0069s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0014s | **2.5x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0009s | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0009s | **1.3x** |
| sha256sum | single 1MB text | 0.0019s | 0.0016s | **1.2x** |
| sha256sum | single 10MB text | 0.0072s | 0.0070s | **1.0x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0074s | **1.1x** |
| sha256sum | single 100MB text | 0.0616s | 0.0601s | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0010s | **1.2x** |
| sha256sum | 100 files | 0.0018s | 0.0014s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0032s | 0.0025s | **1.3x** |
| md5sum | single 10MB text | 0.0206s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0224s | 0.0169s | **1.3x** |
| md5sum | single 100MB text | 0.1933s | 0.1493s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0009s | **1.3x** |
| md5sum | 100 files | 0.0018s | 0.0014s | **1.3x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0136s | 0.0128s | **1.1x** |
| b2sum | single 10MB binary | 0.0153s | 0.0137s | **1.1x** |
| b2sum | single 100MB text | 0.1279s | 0.1183s | **1.1x** |
| b2sum | -l 256 10MB | 0.0136s | 0.0129s | **1.1x** |
| b2sum | -l 128 10MB | 0.0136s | 0.0129s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0025s | **0.7x** |
| base64 | encode 10MB text | 0.0095s | 0.0065s | **1.5x** |
| base64 | encode 10MB binary | 0.0105s | 0.0067s | **1.6x** |
| base64 | decode 1MB | 0.0038s | 0.0031s | **1.2x** |
| base64 | decode 10MB | 0.0309s | 0.0194s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0094s | 0.0064s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0046s | **1.6x** |
| sort | lexicographic 1MB | 0.0078s | 0.0041s | **1.9x** |
| sort | lexicographic 10MB random | 0.0545s | 0.0205s | **2.7x** |
| sort | already sorted 10MB | 0.0249s | 0.0105s | **2.4x** |
| sort | reverse sorted 10MB | 0.0250s | 0.0106s | **2.4x** |
| sort | -n numeric 10MB | 0.0741s | 0.0399s | **1.9x** |
| sort | -r reverse 10MB | 0.0561s | 0.0210s | **2.7x** |
| sort | -u unique 10MB | 0.0588s | 0.0216s | **2.7x** |
| sort | -t, -k2 CSV 10MB | 0.0760s | 0.0376s | **2.0x** |
| sort | repetitive 10MB | 0.0440s | 0.0243s | **1.8x** |
| sort | --parallel=4 10MB | 0.0542s | 0.0194s | **2.8x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0020s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0071s | **1.3x** |
| tr | -d digits 10MB | 0.0113s | 0.0118s | **1.0x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0195s | **1.0x** |
| tr | -s spaces 10MB | 0.0168s | 0.0160s | **1.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0070s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0116s | **1.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0071s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0048s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0054s | **3.0x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0047s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0072s | **4.1x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0060s | **2.7x** |
| uniq | repetitive 10MB | 0.0465s | 0.0070s | **6.6x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0018s | 0.0020s | **0.9x** |
| tac | reverse 10MB text | 0.0085s | 0.0066s | **1.3x** |
| tac | reverse 100MB text | 0.0792s | 0.0572s | **1.4x** |
| tac | reverse CSV 10MB | 0.0085s | 0.0068s | **1.2x** |
| tac | reverse repetitive 10MB | 0.0172s | 0.0139s | **1.2x** |
| tac | custom separator 1MB | 0.0045s | 0.0055s | **0.8x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0026s | **2.1x** |
| wc | default 10MB text | 0.0546s | 0.0089s | **6.1x** |
| wc | default 100MB text | 0.4795s | 0.0658s | **7.3x** |
| wc | -l 10MB text | 0.0020s | 0.0019s | **1.0x** |
| wc | -w 10MB text | 0.0546s | 0.0200s | **2.7x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0547s | 0.0019s | **28.7x** |
| wc | -L 10MB text | 0.0546s | 0.0229s | **2.4x** |
| wc | default 10MB binary | 0.3175s | 0.0815s | **3.9x** |
| wc | default 10MB repetitive | 0.0733s | 0.0114s | **6.4x** |
| wc | 10 files | 0.0010s | 0.0009s | **1.1x** |
| wc | 100 files | 0.0020s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0050s | **4.5x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0053s | **4.3x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0035s | **4.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0073s | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0068s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0104s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0015s | **2.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0010s | **1.3x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.3x** |
| sha256sum | single 10MB text | 0.0086s | 0.0081s | **1.1x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0084s | **1.1x** |
| sha256sum | single 100MB text | 0.0753s | 0.0736s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0009s | **1.4x** |
| sha256sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0028s | 0.0028s | **1.0x** |
| md5sum | single 10MB text | 0.0175s | 0.0204s | **0.9x** |
| md5sum | single 10MB binary | 0.0183s | 0.0213s | **0.9x** |
| md5sum | single 100MB text | 0.1610s | 0.1935s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0010s | **1.5x** |
| md5sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0020s | **1.2x** |
| b2sum | single 10MB text | 0.0149s | 0.0119s | **1.3x** |
| b2sum | single 10MB binary | 0.0156s | 0.0125s | **1.3x** |
| b2sum | single 100MB text | 0.1428s | 0.1113s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0119s | **1.3x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0119s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0011s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0023s | **0.9x** |
| base64 | encode 10MB text | 0.0125s | 0.0078s | **1.6x** |
| base64 | encode 10MB binary | 0.0128s | 0.0074s | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0029s | **1.4x** |
| base64 | decode 10MB | 0.0371s | 0.0171s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0076s | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0052s | **1.7x** |
| sort | lexicographic 1MB | 0.0088s | 0.0042s | **2.1x** |
| sort | lexicographic 10MB random | 0.0557s | 0.0198s | **2.8x** |
| sort | already sorted 10MB | 0.0269s | 0.0123s | **2.2x** |
| sort | reverse sorted 10MB | 0.0280s | 0.0127s | **2.2x** |
| sort | -n numeric 10MB | 0.0736s | 0.0388s | **1.9x** |
| sort | -r reverse 10MB | 0.0549s | 0.0177s | **3.1x** |
| sort | -u unique 10MB | 0.0579s | 0.0181s | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0668s | 0.0345s | **1.9x** |
| sort | repetitive 10MB | 0.0548s | 0.0220s | **2.5x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0175s | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0023s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0092s | **1.4x** |
| tr | -d digits 10MB | 0.0170s | 0.0153s | **1.1x** |
| tr | -d lowercase 10MB | 0.0287s | 0.0265s | **1.1x** |
| tr | -s spaces 10MB | 0.0270s | 0.0257s | **1.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0091s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0168s | 0.0151s | **1.1x** |
| tr | translate binary 10MB | 0.0123s | 0.0093s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0043s | **2.8x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0041s | **3.4x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0046s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0066s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0047s | **2.6x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0046s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0052s | **2.7x** |
| uniq | repetitive 10MB | 0.0421s | 0.0065s | **6.5x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0018s | **1.1x** |
| tac | reverse 10MB text | 0.0105s | 0.0066s | **1.6x** |
| tac | reverse 100MB text | 0.1049s | 0.0510s | **2.1x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0067s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0233s | 0.0132s | **1.8x** |
| tac | custom separator 1MB | 0.0060s | 0.0070s | **0.9x** |
