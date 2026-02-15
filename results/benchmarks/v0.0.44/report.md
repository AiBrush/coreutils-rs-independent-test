# fcoreutils v0.0.44 — Detailed Results

Generated: 2026-02-15 22:32:53 UTC

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
| wc | default 10MB text | 0.0346s | 0.0060s | **5.7x** |
| wc | default 100MB text | 0.2928s | 0.0399s | **7.3x** |
| wc | -l 10MB text | 0.0039s | 0.0020s | **2.0x** |
| wc | -w 10MB text | 0.0345s | 0.0060s | **5.7x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0344s | 0.0022s | **15.8x** |
| wc | -L 10MB text | 0.0344s | 0.0062s | **5.5x** |
| wc | default 10MB binary | 0.2355s | 0.0173s | **13.6x** |
| wc | default 10MB repetitive | 0.0506s | 0.0070s | **7.2x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0025s | **7.6x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0027s | **7.0x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0042s | **4.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0048s | **4.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0046s | **5.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0045s | **5.9x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0028s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0010s | 0.0019s | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | **0.6x** |
| sha256sum | single 10MB text | 0.0076s | 0.0074s | **1.0x** |
| sha256sum | single 10MB binary | 0.0081s | 0.0075s | **1.1x** |
| sha256sum | single 100MB text | 0.0625s | 0.0545s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | **0.5x** |
| sha256sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0035s | **0.9x** |
| md5sum | single 10MB text | 0.0211s | 0.0163s | **1.3x** |
| md5sum | single 10MB binary | 0.0223s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1941s | 0.1420s | **1.4x** |
| md5sum | 10 files | 0.0010s | 0.0019s | **0.5x** |
| md5sum | 100 files | 0.0016s | 0.0025s | **0.6x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0024s | **0.8x** |
| b2sum | single 10MB text | 0.0139s | 0.0129s | **1.1x** |
| b2sum | single 10MB binary | 0.0144s | 0.0134s | **1.1x** |
| b2sum | single 100MB text | 0.1287s | 0.1188s | **1.1x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0130s | **1.1x** |
| b2sum | -l 128 10MB | 0.0141s | 0.0129s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0016s | **1.0x** |
| base64 | encode 10MB text | 0.0095s | 0.0032s | **2.9x** |
| base64 | encode 10MB binary | 0.0103s | 0.0034s | **3.0x** |
| base64 | decode 1MB | 0.0037s | 0.0024s | **1.5x** |
| base64 | decode 10MB | 0.0303s | 0.0146s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0097s | 0.0034s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0075s | 0.0028s | **2.7x** |
| sort | lexicographic 1MB | 0.0076s | 0.0028s | **2.7x** |
| sort | lexicographic 10MB random | 0.0503s | 0.0053s | **9.5x** |
| sort | already sorted 10MB | 0.0239s | 0.0048s | **4.9x** |
| sort | reverse sorted 10MB | 0.0241s | 0.0048s | **5.1x** |
| sort | -n numeric 10MB | 0.0682s | 0.0216s | **3.2x** |
| sort | -r reverse 10MB | 0.0522s | 0.0064s | **8.2x** |
| sort | -u unique 10MB | 0.0548s | 0.0146s | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0702s | 0.0185s | **3.8x** |
| sort | repetitive 10MB | 0.0417s | 0.0120s | **3.5x** |
| sort | --parallel=4 10MB | 0.0505s | 0.0057s | **8.9x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0021s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0074s | **1.2x** |
| tr | -d digits 10MB | 0.0110s | 0.0124s | **0.9x** |
| tr | -d lowercase 10MB | 0.0197s | 0.0205s | **1.0x** |
| tr | -s spaces 10MB | 0.0164s | 0.0139s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0070s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0123s | **0.9x** |
| tr | translate binary 10MB | 0.0093s | 0.0109s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0034s | **4.9x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0065s | **4.5x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0045s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0042s | **3.8x** |
| uniq | repetitive 10MB | 0.0463s | 0.0041s | **11.4x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.7x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0089s | 0.0050s | **1.8x** |
| tac | reverse 100MB text | 0.0806s | 0.0431s | **1.9x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0047s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0169s | 0.0097s | **1.8x** |
| tac | custom separator 1MB | 0.0044s | 0.0038s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.0x** |
| wc | default 1MB text | 0.0058s | 0.0030s | **2.0x** |
| wc | default 10MB text | 0.0547s | 0.0033s | **16.8x** |
| wc | default 100MB text | 0.4833s | 0.0152s | **31.8x** |
| wc | -l 10MB text | 0.0023s | 0.0029s | **0.8x** |
| wc | -w 10MB text | 0.0548s | 0.0094s | **5.9x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0547s | 0.0033s | **16.6x** |
| wc | -L 10MB text | 0.0548s | 0.0103s | **5.3x** |
| wc | default 10MB binary | 0.3204s | 0.0276s | **11.6x** |
| wc | default 10MB repetitive | 0.0733s | 0.0049s | **15.1x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0233s | 0.0040s | **5.8x** |
| cut | -c1-100 10MB CSV | 0.0233s | 0.0039s | **6.0x** |
| cut | -d, -f1 10MB CSV | 0.0174s | 0.0056s | **3.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0227s | 0.0067s | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0251s | 0.0070s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0315s | 0.0082s | **3.8x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0032s | **1.1x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0013s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0026s | **0.5x** |
| sha256sum | single 1MB text | 0.0021s | 0.0036s | **0.6x** |
| sha256sum | single 10MB text | 0.0092s | 0.0103s | **0.9x** |
| sha256sum | single 10MB binary | 0.0094s | 0.0106s | **0.9x** |
| sha256sum | single 100MB text | 0.0757s | 0.0765s | **1.0x** |
| sha256sum | 10 files | 0.0015s | 0.0027s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0038s | **0.7x** |
| md5sum | single 100KB text | 0.0015s | 0.0026s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0053s | **0.6x** |
| md5sum | single 10MB text | 0.0178s | 0.0181s | **1.0x** |
| md5sum | single 10MB binary | 0.0186s | 0.0187s | **1.0x** |
| md5sum | single 100MB text | 0.1617s | 0.1539s | **1.1x** |
| md5sum | 10 files | 0.0014s | 0.0027s | **0.5x** |
| md5sum | 100 files | 0.0024s | 0.0036s | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0024s | 0.0026s | **0.9x** |
| b2sum | single 10MB text | 0.0156s | 0.0127s | **1.2x** |
| b2sum | single 10MB binary | 0.0163s | 0.0132s | **1.2x** |
| b2sum | single 100MB text | 0.1438s | 0.1119s | **1.3x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0125s | **1.2x** |
| b2sum | -l 128 10MB | 0.0155s | 0.0126s | **1.2x** |
| b2sum | 100 files | 0.0023s | 0.0024s | **0.9x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0021s | 0.0018s | **1.2x** |
| base64 | encode 10MB text | 0.0129s | 0.0053s | **2.4x** |
| base64 | encode 10MB binary | 0.0136s | 0.0054s | **2.5x** |
| base64 | decode 1MB | 0.0041s | 0.0024s | **1.7x** |
| base64 | decode 10MB | 0.0336s | 0.0110s | **3.1x** |
| base64 | encode -w 76 10MB | 0.0130s | 0.0054s | **2.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0092s | 0.0041s | **2.2x** |
| sort | lexicographic 1MB | 0.0089s | 0.0040s | **2.2x** |
| sort | lexicographic 10MB random | 0.0575s | 0.0091s | **6.3x** |
| sort | already sorted 10MB | 0.0268s | 0.0073s | **3.7x** |
| sort | reverse sorted 10MB | 0.0279s | 0.0070s | **4.0x** |
| sort | -n numeric 10MB | 0.0770s | 0.0313s | **2.5x** |
| sort | -r reverse 10MB | 0.0583s | 0.0099s | **5.9x** |
| sort | -u unique 10MB | 0.0624s | 0.0191s | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0707s | 0.0291s | **2.4x** |
| sort | repetitive 10MB | 0.0556s | 0.0164s | **3.4x** |
| sort | --parallel=4 10MB | 0.0587s | 0.0095s | **6.2x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0026s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0130s | 0.0068s | **1.9x** |
| tr | -d digits 10MB | 0.0170s | 0.0155s | **1.1x** |
| tr | -d lowercase 10MB | 0.0294s | 0.0259s | **1.1x** |
| tr | -s spaces 10MB | 0.0271s | 0.0144s | **1.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0130s | 0.0074s | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0162s | 0.0154s | **1.0x** |
| tr | translate binary 10MB | 0.0126s | 0.0114s | **1.1x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0049s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0145s | 0.0041s | **3.5x** |
| uniq | -c count 10MB many dups | 0.0125s | 0.0049s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0088s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0124s | 0.0050s | **2.5x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0050s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0145s | 0.0054s | **2.7x** |
| uniq | repetitive 10MB | 0.0424s | 0.0056s | **7.6x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0022s | 0.0019s | **1.1x** |
| tac | reverse 10MB text | 0.0113s | 0.0057s | **2.0x** |
| tac | reverse 100MB text | 0.1053s | 0.0450s | **2.3x** |
| tac | reverse CSV 10MB | 0.0100s | 0.0058s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0116s | **2.1x** |
| tac | custom separator 1MB | 0.0062s | 0.0043s | **1.4x** |
