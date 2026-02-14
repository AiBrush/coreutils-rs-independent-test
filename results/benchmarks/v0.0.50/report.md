# fcoreutils v0.0.50 — Detailed Results

Generated: 2026-02-14 18:25:18 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | **0.9x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0343s | 0.0059s | **5.8x** |
| wc | default 100MB text | 0.2945s | 0.0409s | **7.2x** |
| wc | -l 10MB text | 0.0042s | 0.0021s | **2.0x** |
| wc | -w 10MB text | 0.0344s | 0.0066s | **5.2x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0346s | 0.0025s | **13.9x** |
| wc | -L 10MB text | 0.0344s | 0.0065s | **5.3x** |
| wc | default 10MB binary | 0.2337s | 0.0172s | **13.6x** |
| wc | default 10MB repetitive | 0.0521s | 0.0071s | **7.3x** |
| wc | 10 files | 0.0009s | 0.0011s | **0.8x** |
| wc | 100 files | 0.0014s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0030s | **6.3x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0026s | **7.1x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0048s | **4.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0048s | **4.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0047s | **5.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0053s | **5.0x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | **0.6x** |
| sha256sum | single 1MB text | 0.0019s | 0.0029s | **0.7x** |
| sha256sum | single 10MB text | 0.0082s | 0.0076s | **1.1x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0078s | **1.0x** |
| sha256sum | single 100MB text | 0.0643s | 0.0554s | **1.2x** |
| sha256sum | 10 files | 0.0012s | 0.0021s | **0.5x** |
| sha256sum | 100 files | 0.0018s | 0.0026s | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0214s | 0.0166s | **1.3x** |
| md5sum | single 10MB binary | 0.0215s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1961s | 0.1426s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0026s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0022s | 0.0027s | **0.8x** |
| b2sum | single 10MB text | 0.0146s | 0.0132s | **1.1x** |
| b2sum | single 10MB binary | 0.0142s | 0.0135s | **1.1x** |
| b2sum | single 100MB text | 0.1306s | 0.1196s | **1.1x** |
| b2sum | -l 256 10MB | 0.0146s | 0.0131s | **1.1x** |
| b2sum | -l 128 10MB | 0.0145s | 0.0131s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | **1.0x** |
| base64 | encode 10MB text | 0.0103s | 0.0036s | **2.9x** |
| base64 | encode 10MB binary | 0.0100s | 0.0037s | **2.7x** |
| base64 | decode 1MB | 0.0038s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0308s | 0.0146s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0104s | 0.0036s | **2.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0031s | **2.6x** |
| sort | lexicographic 1MB | 0.0077s | 0.0032s | **2.4x** |
| sort | lexicographic 10MB random | 0.0532s | 0.0063s | **8.4x** |
| sort | already sorted 10MB | 0.0248s | 0.0055s | **4.5x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0050s | **4.9x** |
| sort | -n numeric 10MB | 0.0718s | 0.0239s | **3.0x** |
| sort | -r reverse 10MB | 0.0536s | 0.0068s | **7.9x** |
| sort | -u unique 10MB | 0.0553s | 0.0162s | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0735s | 0.0215s | **3.4x** |
| sort | repetitive 10MB | 0.0434s | 0.0127s | **3.4x** |
| sort | --parallel=4 10MB | 0.0526s | 0.0061s | **8.6x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0021s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0073s | **1.3x** |
| tr | -d digits 10MB | 0.0113s | 0.0129s | **0.9x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0197s | **1.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0135s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0074s | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0129s | **0.9x** |
| tr | translate binary 10MB | 0.0093s | 0.0100s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0095s | 0.0048s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0031s | **5.2x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0047s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0068s | **4.3x** |
| uniq | -d duplicates only 10MB | 0.0095s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0048s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0044s | **3.7x** |
| uniq | repetitive 10MB | 0.0464s | 0.0041s | **11.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.7x** |
| tac | reverse 1MB text | 0.0017s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0092s | 0.0047s | **1.9x** |
| tac | reverse 100MB text | 0.0817s | 0.0391s | **2.1x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0046s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0171s | 0.0094s | **1.8x** |
| tac | custom separator 1MB | 0.0045s | 0.0041s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0015s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0062s | 0.0029s | **2.1x** |
| wc | default 10MB text | 0.0554s | 0.0032s | **17.1x** |
| wc | default 100MB text | 0.4843s | 0.0161s | **30.1x** |
| wc | -l 10MB text | 0.0022s | 0.0027s | **0.8x** |
| wc | -w 10MB text | 0.0559s | 0.0095s | **5.9x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0553s | 0.0034s | **16.5x** |
| wc | -L 10MB text | 0.0549s | 0.0098s | **5.6x** |
| wc | default 10MB binary | 0.3170s | 0.0284s | **11.2x** |
| wc | default 10MB repetitive | 0.0737s | 0.0046s | **16.1x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0230s | 0.0036s | **6.4x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0036s | **6.4x** |
| cut | -d, -f1 10MB CSV | 0.0169s | 0.0054s | **3.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0227s | 0.0071s | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0250s | 0.0069s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0315s | 0.0080s | **4.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0030s | **1.1x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0015s | 0.0026s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0092s | 0.0098s | **0.9x** |
| sha256sum | single 10MB binary | 0.0093s | 0.0107s | **0.9x** |
| sha256sum | single 100MB text | 0.0785s | 0.0772s | **1.0x** |
| sha256sum | 10 files | 0.0020s | 0.0026s | **0.8x** |
| sha256sum | 100 files | 0.0026s | 0.0033s | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0177s | 0.0182s | **1.0x** |
| md5sum | single 10MB binary | 0.0190s | 0.0187s | **1.0x** |
| md5sum | single 100MB text | 0.1626s | 0.1541s | **1.1x** |
| md5sum | 10 files | 0.0014s | 0.0033s | **0.4x** |
| md5sum | 100 files | 0.0024s | 0.0032s | **0.8x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0024s | 0.0024s | **1.0x** |
| b2sum | single 10MB text | 0.0156s | 0.0127s | **1.2x** |
| b2sum | single 10MB binary | 0.0164s | 0.0135s | **1.2x** |
| b2sum | single 100MB text | 0.1439s | 0.1122s | **1.3x** |
| b2sum | -l 256 10MB | 0.0157s | 0.0124s | **1.3x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0124s | **1.2x** |
| b2sum | 100 files | 0.0023s | 0.0021s | **1.1x** |
| base64 | encode 100KB text | 0.0011s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0025s | 0.0015s | **1.6x** |
| base64 | encode 10MB text | 0.0132s | 0.0056s | **2.4x** |
| base64 | encode 10MB binary | 0.0132s | 0.0053s | **2.5x** |
| base64 | decode 1MB | 0.0042s | 0.0022s | **1.9x** |
| base64 | decode 10MB | 0.0332s | 0.0116s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0132s | 0.0055s | **2.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0091s | 0.0041s | **2.2x** |
| sort | lexicographic 1MB | 0.0087s | 0.0039s | **2.2x** |
| sort | lexicographic 10MB random | 0.0552s | 0.0088s | **6.3x** |
| sort | already sorted 10MB | 0.0272s | 0.0070s | **3.9x** |
| sort | reverse sorted 10MB | 0.0285s | 0.0072s | **3.9x** |
| sort | -n numeric 10MB | 0.0770s | 0.0314s | **2.5x** |
| sort | -r reverse 10MB | 0.0587s | 0.0101s | **5.8x** |
| sort | -u unique 10MB | 0.0614s | 0.0151s | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0687s | 0.0256s | **2.7x** |
| sort | repetitive 10MB | 0.0567s | 0.0180s | **3.1x** |
| sort | --parallel=4 10MB | 0.0570s | 0.0096s | **6.0x** |
| tr | a-z to A-Z 1MB | 0.0025s | 0.0022s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0136s | 0.0075s | **1.8x** |
| tr | -d digits 10MB | 0.0185s | 0.0122s | **1.5x** |
| tr | -d lowercase 10MB | 0.0302s | 0.0109s | **2.8x** |
| tr | -s spaces 10MB | 0.0298s | 0.0124s | **2.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0137s | 0.0069s | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0173s | 0.0116s | **1.5x** |
| tr | translate binary 10MB | 0.0115s | 0.0083s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0122s | 0.0050s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0145s | 0.0039s | **3.7x** |
| uniq | -c count 10MB many dups | 0.0125s | 0.0053s | **2.3x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0088s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0050s | **2.4x** |
| uniq | -u unique only 10MB | 0.0126s | 0.0050s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0143s | 0.0049s | **2.9x** |
| uniq | repetitive 10MB | 0.0424s | 0.0053s | **8.0x** |
| tac | reverse 100KB text | 0.0011s | 0.0012s | **0.9x** |
| tac | reverse 1MB text | 0.0021s | 0.0016s | **1.3x** |
| tac | reverse 10MB text | 0.0114s | 0.0048s | **2.4x** |
| tac | reverse 100MB text | 0.1072s | 0.0397s | **2.7x** |
| tac | reverse CSV 10MB | 0.0095s | 0.0050s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0237s | 0.0111s | **2.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0043s | **1.4x** |
