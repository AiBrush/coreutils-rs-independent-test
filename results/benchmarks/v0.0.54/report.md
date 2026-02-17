# fcoreutils v0.0.54 — Detailed Results

Generated: 2026-02-17 03:06:13 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0346s | 0.0065s | **5.4x** |
| wc | default 100MB text | 0.2904s | 0.0398s | **7.3x** |
| wc | -l 10MB text | 0.0044s | 0.0022s | **2.0x** |
| wc | -w 10MB text | 0.0346s | 0.0062s | **5.6x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0346s | 0.0023s | **15.2x** |
| wc | -L 10MB text | 0.0347s | 0.0068s | **5.1x** |
| wc | default 10MB binary | 0.2341s | 0.0172s | **13.6x** |
| wc | default 10MB repetitive | 0.0534s | 0.0070s | **7.6x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0027s | **6.7x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0027s | **6.7x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0045s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0047s | **4.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0231s | 0.0046s | **5.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0047s | **5.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0022s | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | **0.6x** |
| sha256sum | single 10MB text | 0.0080s | 0.0075s | **1.1x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0077s | **1.0x** |
| sha256sum | single 100MB text | 0.0595s | 0.0540s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0021s | **0.5x** |
| sha256sum | 100 files | 0.0018s | 0.0026s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0023s | **0.6x** |
| md5sum | single 1MB text | 0.0033s | 0.0037s | **0.9x** |
| md5sum | single 10MB text | 0.0214s | 0.0164s | **1.3x** |
| md5sum | single 10MB binary | 0.0216s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1908s | 0.1411s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0026s | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0022s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0145s | 0.0131s | **1.1x** |
| b2sum | single 10MB binary | 0.0139s | 0.0135s | **1.0x** |
| b2sum | single 100MB text | 0.1255s | 0.1185s | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0131s | **1.1x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0132s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | **1.1x** |
| base64 | encode 10MB text | 0.0098s | 0.0033s | **3.0x** |
| base64 | encode 10MB binary | 0.0099s | 0.0033s | **3.0x** |
| base64 | decode 1MB | 0.0038s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0307s | 0.0147s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0103s | 0.0034s | **3.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0034s | **2.4x** |
| sort | lexicographic 1MB | 0.0078s | 0.0032s | **2.4x** |
| sort | lexicographic 10MB random | 0.0531s | 0.0059s | **9.0x** |
| sort | already sorted 10MB | 0.0243s | 0.0054s | **4.5x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0046s | **5.3x** |
| sort | -n numeric 10MB | 0.0707s | 0.0235s | **3.0x** |
| sort | -r reverse 10MB | 0.0556s | 0.0068s | **8.2x** |
| sort | -u unique 10MB | 0.0559s | 0.0150s | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0725s | 0.0204s | **3.6x** |
| sort | repetitive 10MB | 0.0436s | 0.0124s | **3.5x** |
| sort | --parallel=4 10MB | 0.0517s | 0.0059s | **8.7x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0020s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0074s | **1.2x** |
| tr | -d digits 10MB | 0.0112s | 0.0134s | **0.8x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0203s | **0.9x** |
| tr | -s spaces 10MB | 0.0166s | 0.0174s | **1.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0092s | 0.0071s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0129s | **0.9x** |
| tr | translate binary 10MB | 0.0098s | 0.0097s | **1.0x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0036s | **4.5x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0048s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0067s | **4.3x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0047s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0044s | **3.7x** |
| uniq | repetitive 10MB | 0.0474s | 0.0042s | **11.2x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0089s | 0.0045s | **2.0x** |
| tac | reverse 100MB text | 0.0779s | 0.0375s | **2.1x** |
| tac | reverse CSV 10MB | 0.0078s | 0.0046s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0178s | 0.0094s | **1.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0041s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0544s | 0.0030s | **18.1x** |
| wc | default 100MB text | 0.4836s | 0.0138s | **35.0x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | **0.8x** |
| wc | -w 10MB text | 0.0543s | 0.0087s | **6.3x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0541s | 0.0029s | **18.4x** |
| wc | -L 10MB text | 0.0543s | 0.0097s | **5.6x** |
| wc | default 10MB binary | 0.3174s | 0.0276s | **11.5x** |
| wc | default 10MB repetitive | 0.0734s | 0.0044s | **16.6x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0034s | **6.6x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0034s | **6.6x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0051s | **3.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0063s | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0067s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0308s | 0.0076s | **4.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0013s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0021s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0097s | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0101s | **0.9x** |
| sha256sum | single 100MB text | 0.0749s | 0.0750s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | **0.8x** |
| md5sum | single 10MB text | 0.0171s | 0.0174s | **1.0x** |
| md5sum | single 10MB binary | 0.0179s | 0.0182s | **1.0x** |
| md5sum | single 100MB text | 0.1608s | 0.1530s | **1.1x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0030s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0156s | 0.0126s | **1.2x** |
| b2sum | single 100MB text | 0.1426s | 0.1112s | **1.3x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0121s | **1.2x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0120s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0018s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0020s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0123s | 0.0045s | **2.7x** |
| base64 | encode 10MB binary | 0.0130s | 0.0046s | **2.8x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | **1.9x** |
| base64 | decode 10MB | 0.0325s | 0.0102s | **3.2x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0046s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0036s | **2.4x** |
| sort | lexicographic 1MB | 0.0086s | 0.0035s | **2.4x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0083s | **6.5x** |
| sort | already sorted 10MB | 0.0267s | 0.0066s | **4.0x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0068s | **4.0x** |
| sort | -n numeric 10MB | 0.0734s | 0.0304s | **2.4x** |
| sort | -r reverse 10MB | 0.0546s | 0.0091s | **6.0x** |
| sort | -u unique 10MB | 0.0575s | 0.0126s | **4.6x** |
| sort | -t, -k2 CSV 10MB | 0.0664s | 0.0249s | **2.7x** |
| sort | repetitive 10MB | 0.0554s | 0.0154s | **3.6x** |
| sort | --parallel=4 10MB | 0.0552s | 0.0084s | **6.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0020s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0056s | **2.3x** |
| tr | -d digits 10MB | 0.0178s | 0.0109s | **1.6x** |
| tr | -d lowercase 10MB | 0.0295s | 0.0093s | **3.2x** |
| tr | -s spaces 10MB | 0.0290s | 0.0158s | **1.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0058s | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0172s | 0.0108s | **1.6x** |
| tr | translate binary 10MB | 0.0109s | 0.0076s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0049s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0035s | **4.0x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0048s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0080s | **3.6x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0047s | **2.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0049s | **2.9x** |
| uniq | repetitive 10MB | 0.0421s | 0.0057s | **7.4x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0047s | **2.2x** |
| tac | reverse 100MB text | 0.1042s | 0.0394s | **2.6x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0049s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0229s | 0.0096s | **2.4x** |
| tac | custom separator 1MB | 0.0059s | 0.0041s | **1.5x** |
