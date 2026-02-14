# fcoreutils v0.0.55 — Detailed Results

Generated: 2026-02-14 06:46:33 UTC

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
| wc | default 10MB text | 0.0346s | 0.0062s | **5.6x** |
| wc | default 100MB text | 0.2899s | 0.0411s | **7.1x** |
| wc | -l 10MB text | 0.0047s | 0.0022s | **2.2x** |
| wc | -w 10MB text | 0.0345s | 0.0060s | **5.8x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0347s | 0.0025s | **14.0x** |
| wc | -L 10MB text | 0.0347s | 0.0063s | **5.5x** |
| wc | default 10MB binary | 0.2351s | 0.0174s | **13.5x** |
| wc | default 10MB repetitive | 0.0517s | 0.0072s | **7.2x** |
| wc | 10 files | 0.0009s | 0.0012s | **0.7x** |
| wc | 100 files | 0.0014s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0032s | **5.9x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0026s | **7.1x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0045s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0047s | **4.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0037s | **6.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0047s | **5.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0022s | **0.5x** |
| sha256sum | single 1MB text | 0.0018s | 0.0028s | **0.6x** |
| sha256sum | single 10MB text | 0.0079s | 0.0074s | **1.1x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0077s | **1.0x** |
| sha256sum | single 100MB text | 0.0599s | 0.0541s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0026s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | **0.9x** |
| md5sum | single 10MB text | 0.0214s | 0.0165s | **1.3x** |
| md5sum | single 10MB binary | 0.0214s | 0.0169s | **1.3x** |
| md5sum | single 100MB text | 0.1914s | 0.1414s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0021s | **0.5x** |
| md5sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0022s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0145s | 0.0132s | **1.1x** |
| b2sum | single 10MB binary | 0.0143s | 0.0134s | **1.1x** |
| b2sum | single 100MB text | 0.1260s | 0.1185s | **1.1x** |
| b2sum | -l 256 10MB | 0.0146s | 0.0132s | **1.1x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0131s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0016s | **1.0x** |
| base64 | encode 10MB text | 0.0098s | 0.0037s | **2.7x** |
| base64 | encode 10MB binary | 0.0098s | 0.0034s | **2.9x** |
| base64 | decode 1MB | 0.0037s | 0.0025s | **1.5x** |
| base64 | decode 10MB | 0.0304s | 0.0145s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0099s | 0.0033s | **3.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0033s | **2.4x** |
| sort | lexicographic 1MB | 0.0075s | 0.0029s | **2.6x** |
| sort | lexicographic 10MB random | 0.0520s | 0.0057s | **9.1x** |
| sort | already sorted 10MB | 0.0248s | 0.0053s | **4.7x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0047s | **5.2x** |
| sort | -n numeric 10MB | 0.0717s | 0.0215s | **3.3x** |
| sort | -r reverse 10MB | 0.0519s | 0.0062s | **8.4x** |
| sort | -u unique 10MB | 0.0550s | 0.0131s | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0710s | 0.0191s | **3.7x** |
| sort | repetitive 10MB | 0.0436s | 0.0120s | **3.6x** |
| sort | --parallel=4 10MB | 0.0526s | 0.0058s | **9.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0020s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0071s | **1.2x** |
| tr | -d digits 10MB | 0.0113s | 0.0133s | **0.8x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0205s | **0.9x** |
| tr | -s spaces 10MB | 0.0168s | 0.0075s | **2.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0092s | 0.0075s | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0133s | **0.9x** |
| tr | translate binary 10MB | 0.0096s | 0.0097s | **1.0x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0048s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0032s | **5.0x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0048s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0067s | **4.3x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0043s | **3.8x** |
| uniq | repetitive 10MB | 0.0474s | 0.0045s | **10.6x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0090s | 0.0046s | **2.0x** |
| tac | reverse 100MB text | 0.0781s | 0.0373s | **2.1x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0045s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0177s | 0.0094s | **1.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0042s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0028s | **2.0x** |
| wc | default 10MB text | 0.0546s | 0.0030s | **18.0x** |
| wc | default 100MB text | 0.4828s | 0.0135s | **35.7x** |
| wc | -l 10MB text | 0.0020s | 0.0026s | **0.8x** |
| wc | -w 10MB text | 0.0545s | 0.0108s | **5.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0542s | 0.0030s | **18.4x** |
| wc | -L 10MB text | 0.0542s | 0.0098s | **5.6x** |
| wc | default 10MB binary | 0.3169s | 0.0277s | **11.4x** |
| wc | default 10MB repetitive | 0.0728s | 0.0043s | **16.8x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0034s | **6.6x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0034s | **6.6x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0048s | **3.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0068s | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0051s | **4.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0073s | **4.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0096s | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0099s | **0.9x** |
| sha256sum | single 100MB text | 0.0747s | 0.0751s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0171s | 0.0174s | **1.0x** |
| md5sum | single 10MB binary | 0.0183s | 0.0181s | **1.0x** |
| md5sum | single 100MB text | 0.1610s | 0.1534s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | **0.8x** |
| b2sum | single 100KB text | 0.0011s | 0.0014s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0156s | 0.0127s | **1.2x** |
| b2sum | single 100MB text | 0.1425s | 0.1118s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0122s | **1.2x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0122s | 0.0046s | **2.7x** |
| base64 | encode 10MB binary | 0.0131s | 0.0050s | **2.6x** |
| base64 | decode 1MB | 0.0040s | 0.0020s | **2.0x** |
| base64 | decode 10MB | 0.0329s | 0.0104s | **3.2x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0048s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0038s | **2.3x** |
| sort | lexicographic 1MB | 0.0086s | 0.0038s | **2.2x** |
| sort | lexicographic 10MB random | 0.0552s | 0.0085s | **6.5x** |
| sort | already sorted 10MB | 0.0274s | 0.0068s | **4.0x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0069s | **4.0x** |
| sort | -n numeric 10MB | 0.0739s | 0.0306s | **2.4x** |
| sort | -r reverse 10MB | 0.0547s | 0.0090s | **6.1x** |
| sort | -u unique 10MB | 0.0579s | 0.0126s | **4.6x** |
| sort | -t, -k2 CSV 10MB | 0.0668s | 0.0247s | **2.7x** |
| sort | repetitive 10MB | 0.0555s | 0.0156s | **3.6x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0085s | **6.4x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0020s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0133s | 0.0059s | **2.2x** |
| tr | -d digits 10MB | 0.0169s | 0.0123s | **1.4x** |
| tr | -d lowercase 10MB | 0.0294s | 0.0119s | **2.5x** |
| tr | -s spaces 10MB | 0.0259s | 0.0059s | **4.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0127s | 0.0059s | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0124s | **1.4x** |
| tr | translate binary 10MB | 0.0114s | 0.0081s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0049s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0037s | **3.7x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0048s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0083s | **3.5x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0047s | **2.6x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0050s | **2.8x** |
| uniq | repetitive 10MB | 0.0420s | 0.0052s | **8.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0019s | 0.0016s | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0046s | **2.3x** |
| tac | reverse 100MB text | 0.1039s | 0.0388s | **2.7x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0049s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0225s | 0.0096s | **2.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0040s | **1.5x** |
