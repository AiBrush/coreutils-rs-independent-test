# fcoreutils v0.0.59 — Detailed Results

Generated: 2026-02-14 14:08:29 UTC

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
| wc | default 1MB text | 0.0038s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0337s | 0.0063s | **5.3x** |
| wc | default 100MB text | 0.2923s | 0.0427s | **6.8x** |
| wc | -l 10MB text | 0.0036s | 0.0022s | **1.6x** |
| wc | -w 10MB text | 0.0337s | 0.0060s | **5.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0337s | 0.0022s | **15.2x** |
| wc | -L 10MB text | 0.0337s | 0.0064s | **5.3x** |
| wc | default 10MB binary | 0.2360s | 0.0173s | **13.7x** |
| wc | default 10MB repetitive | 0.0534s | 0.0081s | **6.6x** |
| wc | 10 files | 0.0011s | 0.0011s | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0032s | **5.9x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0033s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0045s | **4.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0051s | **4.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0038s | **6.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0051s | **5.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0021s | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | **0.7x** |
| sha256sum | single 10MB text | 0.0072s | 0.0072s | **1.0x** |
| sha256sum | single 10MB binary | 0.0074s | 0.0074s | **1.0x** |
| sha256sum | single 100MB text | 0.0615s | 0.0544s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0025s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0023s | **0.5x** |
| md5sum | single 1MB text | 0.0031s | 0.0036s | **0.9x** |
| md5sum | single 10MB text | 0.0207s | 0.0163s | **1.3x** |
| md5sum | single 10MB binary | 0.0216s | 0.0172s | **1.3x** |
| md5sum | single 100MB text | 0.1929s | 0.1414s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0021s | **0.5x** |
| md5sum | 100 files | 0.0017s | 0.0026s | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0021s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0137s | 0.0129s | **1.1x** |
| b2sum | single 10MB binary | 0.0143s | 0.0135s | **1.1x** |
| b2sum | single 100MB text | 0.1277s | 0.1188s | **1.1x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0129s | **1.1x** |
| b2sum | -l 128 10MB | 0.0137s | 0.0130s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0016s | **1.0x** |
| base64 | encode 10MB text | 0.0095s | 0.0032s | **3.0x** |
| base64 | encode 10MB binary | 0.0099s | 0.0033s | **3.0x** |
| base64 | decode 1MB | 0.0039s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0308s | 0.0152s | **2.0x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0032s | **2.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0029s | **2.5x** |
| sort | lexicographic 1MB | 0.0076s | 0.0030s | **2.5x** |
| sort | lexicographic 10MB random | 0.0526s | 0.0065s | **8.1x** |
| sort | already sorted 10MB | 0.0246s | 0.0045s | **5.4x** |
| sort | reverse sorted 10MB | 0.0243s | 0.0053s | **4.6x** |
| sort | -n numeric 10MB | 0.0703s | 0.0543s | **1.3x** |
| sort | -r reverse 10MB | 0.0535s | 0.0066s | **8.1x** |
| sort | -u unique 10MB | 0.0556s | 0.0143s | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0726s | 0.0197s | **3.7x** |
| sort | repetitive 10MB | 0.0456s | 0.0092s | **5.0x** |
| sort | --parallel=4 10MB | 0.0519s | 0.0062s | **8.4x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0019s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0067s | **1.3x** |
| tr | -d digits 10MB | 0.0111s | 0.0079s | **1.4x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0099s | **1.9x** |
| tr | -s spaces 10MB | 0.0168s | 0.0063s | **2.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0069s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0082s | **1.4x** |
| tr | translate binary 10MB | 0.0092s | 0.0080s | **1.1x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0048s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0033s | **5.0x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0048s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0068s | **4.3x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0047s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0043s | **3.7x** |
| uniq | repetitive 10MB | 0.0488s | 0.0043s | **11.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0014s | **0.6x** |
| tac | reverse 1MB text | 0.0016s | 0.0054s | **0.3x** |
| tac | reverse 10MB text | 0.0082s | 0.0308s | **0.3x** |
| tac | reverse 100MB text | 0.0793s | 0.3433s | **0.2x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0442s | **0.2x** |
| tac | reverse repetitive 10MB | 0.0193s | 0.1087s | **0.2x** |
| tac | custom separator 1MB | 0.0044s | 0.0383s | **0.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0543s | 0.0031s | **17.5x** |
| wc | default 100MB text | 0.4838s | 0.0140s | **34.5x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | **0.8x** |
| wc | -w 10MB text | 0.0545s | 0.0094s | **5.8x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0545s | 0.0030s | **18.0x** |
| wc | -L 10MB text | 0.0545s | 0.0099s | **5.5x** |
| wc | default 10MB binary | 0.3179s | 0.0275s | **11.6x** |
| wc | default 10MB repetitive | 0.0731s | 0.0045s | **16.2x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.9x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0041s | **5.6x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0041s | **5.6x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0053s | **3.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0221s | 0.0069s | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0054s | **4.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0310s | 0.0080s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0096s | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0100s | **0.9x** |
| sha256sum | single 100MB text | 0.0745s | 0.0759s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0030s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0174s | 0.0174s | **1.0x** |
| md5sum | single 10MB binary | 0.0180s | 0.0181s | **1.0x** |
| md5sum | single 100MB text | 0.1607s | 0.1532s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0030s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0155s | 0.0127s | **1.2x** |
| b2sum | single 100MB text | 0.1427s | 0.1117s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0121s | **1.2x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0123s | 0.0046s | **2.7x** |
| base64 | encode 10MB binary | 0.0130s | 0.0049s | **2.7x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | **1.8x** |
| base64 | decode 10MB | 0.0327s | 0.0126s | **2.6x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0047s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0036s | **2.4x** |
| sort | lexicographic 1MB | 0.0086s | 0.0038s | **2.3x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0089s | **6.1x** |
| sort | already sorted 10MB | 0.0262s | 0.0058s | **4.5x** |
| sort | reverse sorted 10MB | 0.0282s | 0.0074s | **3.8x** |
| sort | -n numeric 10MB | 0.0736s | 0.0529s | **1.4x** |
| sort | -r reverse 10MB | 0.0552s | 0.0094s | **5.9x** |
| sort | -u unique 10MB | 0.0577s | 0.0129s | **4.5x** |
| sort | -t, -k2 CSV 10MB | 0.0670s | 0.0234s | **2.9x** |
| sort | repetitive 10MB | 0.0551s | 0.0097s | **5.7x** |
| sort | --parallel=4 10MB | 0.0542s | 0.0093s | **5.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0018s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0078s | **1.6x** |
| tr | -d digits 10MB | 0.0159s | 0.0090s | **1.8x** |
| tr | -d lowercase 10MB | 0.0316s | 0.0095s | **3.3x** |
| tr | -s spaces 10MB | 0.0304s | 0.0067s | **4.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0139s | 0.0078s | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0174s | 0.0089s | **2.0x** |
| tr | translate binary 10MB | 0.0111s | 0.0084s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0048s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0038s | **3.7x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0047s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0084s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0047s | **2.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0050s | **2.8x** |
| uniq | repetitive 10MB | 0.0422s | 0.0051s | **8.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0018s | **0.5x** |
| tac | reverse 1MB text | 0.0020s | 0.0121s | **0.2x** |
| tac | reverse 10MB text | 0.0105s | 0.0785s | **0.1x** |
| tac | reverse 100MB text | 0.1043s | 0.8958s | **0.1x** |
| tac | reverse CSV 10MB | 0.0093s | 0.1151s | **0.1x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.2866s | **0.1x** |
| tac | custom separator 1MB | 0.0059s | 0.1004s | **0.1x** |
