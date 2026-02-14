# fcoreutils v0.0.63 — Detailed Results

Generated: 2026-02-14 21:38:47 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | **0.9x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0335s | 0.0063s | **5.3x** |
| wc | default 100MB text | 0.2890s | 0.0417s | **6.9x** |
| wc | -l 10MB text | 0.0035s | 0.0019s | **1.8x** |
| wc | -w 10MB text | 0.0335s | 0.0059s | **5.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0335s | 0.0021s | **15.8x** |
| wc | -L 10MB text | 0.0335s | 0.0060s | **5.6x** |
| wc | default 10MB binary | 0.2353s | 0.0172s | **13.6x** |
| wc | default 10MB repetitive | 0.0504s | 0.0078s | **6.5x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.7x** |
| wc | 100 files | 0.0014s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0033s | **5.7x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0032s | **5.9x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0044s | **4.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0048s | **4.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0036s | **6.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0049s | **5.4x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | **0.5x** |
| sha256sum | single 1MB text | 0.0018s | 0.0026s | **0.7x** |
| sha256sum | single 10MB text | 0.0068s | 0.0072s | **0.9x** |
| sha256sum | single 10MB binary | 0.0071s | 0.0074s | **1.0x** |
| sha256sum | single 100MB text | 0.0577s | 0.0534s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0025s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | **0.9x** |
| md5sum | single 10MB text | 0.0202s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0214s | 0.0168s | **1.3x** |
| md5sum | single 100MB text | 0.1905s | 0.1412s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0025s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0021s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0132s | 0.0123s | **1.1x** |
| b2sum | single 10MB binary | 0.0140s | 0.0129s | **1.1x** |
| b2sum | single 100MB text | 0.1238s | 0.1132s | **1.1x** |
| b2sum | -l 256 10MB | 0.0132s | 0.0123s | **1.1x** |
| b2sum | -l 128 10MB | 0.0132s | 0.0123s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | **1.1x** |
| base64 | encode 10MB text | 0.0092s | 0.0048s | **1.9x** |
| base64 | encode 10MB binary | 0.0097s | 0.0050s | **1.9x** |
| base64 | decode 1MB | 0.0038s | 0.0022s | **1.7x** |
| base64 | decode 10MB | 0.0306s | 0.0118s | **2.6x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0050s | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0070s | 0.0043s | **1.6x** |
| sort | lexicographic 1MB | 0.0074s | 0.0027s | **2.8x** |
| sort | lexicographic 10MB random | 0.0507s | 0.0064s | **7.9x** |
| sort | already sorted 10MB | 0.0247s | 0.0050s | **4.9x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0051s | **4.8x** |
| sort | -n numeric 10MB | 0.0685s | 0.0520s | **1.3x** |
| sort | -r reverse 10MB | 0.0519s | 0.0064s | **8.1x** |
| sort | -u unique 10MB | 0.0531s | 0.0132s | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0701s | 0.0180s | **3.9x** |
| sort | repetitive 10MB | 0.0421s | 0.0077s | **5.5x** |
| sort | --parallel=4 10MB | 0.0499s | 0.0061s | **8.1x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0029s | **0.6x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0185s | **0.5x** |
| tr | -d digits 10MB | 0.0110s | 0.0136s | **0.8x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0192s | **1.0x** |
| tr | -s spaces 10MB | 0.0168s | 0.0057s | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0184s | **0.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0134s | **0.8x** |
| tr | translate binary 10MB | 0.0095s | 0.0160s | **0.6x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0165s | 0.0030s | **5.4x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0067s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0043s | **3.9x** |
| uniq | repetitive 10MB | 0.0462s | 0.0041s | **11.4x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0080s | 0.0046s | **1.7x** |
| tac | reverse 100MB text | 0.0761s | 0.0376s | **2.0x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0047s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0169s | 0.0094s | **1.8x** |
| tac | custom separator 1MB | 0.0043s | 0.0041s | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0030s | **1.9x** |
| wc | default 10MB text | 0.0548s | 0.0034s | **16.2x** |
| wc | default 100MB text | 0.4835s | 0.0143s | **33.9x** |
| wc | -l 10MB text | 0.0019s | 0.0025s | **0.8x** |
| wc | -w 10MB text | 0.0538s | 0.0088s | **6.1x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0544s | 0.0031s | **17.5x** |
| wc | -L 10MB text | 0.0543s | 0.0099s | **5.5x** |
| wc | default 10MB binary | 0.3176s | 0.0281s | **11.3x** |
| wc | default 10MB repetitive | 0.0731s | 0.0047s | **15.5x** |
| wc | 10 files | 0.0010s | 0.0013s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0045s | **5.0x** |
| cut | -c1-100 10MB CSV | 0.0231s | 0.0047s | **4.9x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0065s | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0220s | 0.0079s | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0059s | **4.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0307s | 0.0086s | **3.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0031s | **1.1x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0021s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0096s | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0100s | **0.9x** |
| sha256sum | single 100MB text | 0.0755s | 0.0756s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0174s | 0.0175s | **1.0x** |
| md5sum | single 10MB binary | 0.0181s | 0.0183s | **1.0x** |
| md5sum | single 100MB text | 0.1614s | 0.1533s | **1.1x** |
| md5sum | 10 files | 0.0014s | 0.0022s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0030s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0151s | 0.0122s | **1.2x** |
| b2sum | single 10MB binary | 0.0156s | 0.0128s | **1.2x** |
| b2sum | single 100MB text | 0.1426s | 0.1119s | **1.3x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0127s | **1.2x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0122s | **1.2x** |
| b2sum | 100 files | 0.0023s | 0.0020s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0124s | 0.0053s | **2.3x** |
| base64 | encode 10MB binary | 0.0131s | 0.0053s | **2.5x** |
| base64 | decode 1MB | 0.0040s | 0.0024s | **1.7x** |
| base64 | decode 10MB | 0.0326s | 0.0143s | **2.3x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0050s | **2.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0041s | **2.2x** |
| sort | lexicographic 1MB | 0.0086s | 0.0036s | **2.4x** |
| sort | lexicographic 10MB random | 0.0543s | 0.0095s | **5.7x** |
| sort | already sorted 10MB | 0.0267s | 0.0059s | **4.6x** |
| sort | reverse sorted 10MB | 0.0275s | 0.0079s | **3.5x** |
| sort | -n numeric 10MB | 0.0771s | 0.0531s | **1.5x** |
| sort | -r reverse 10MB | 0.0550s | 0.0097s | **5.7x** |
| sort | -u unique 10MB | 0.0594s | 0.0135s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0667s | 0.0244s | **2.7x** |
| sort | repetitive 10MB | 0.0554s | 0.0103s | **5.4x** |
| sort | --parallel=4 10MB | 0.0549s | 0.0098s | **5.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0067s | **1.9x** |
| tr | -d digits 10MB | 0.0166s | 0.0131s | **1.3x** |
| tr | -d lowercase 10MB | 0.0293s | 0.0128s | **2.3x** |
| tr | -s spaces 10MB | 0.0287s | 0.0067s | **4.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0134s | 0.0068s | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0161s | 0.0131s | **1.2x** |
| tr | translate binary 10MB | 0.0119s | 0.0064s | **1.9x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0061s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0041s | **3.4x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0061s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0090s | **3.2x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0061s | **2.0x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0061s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0059s | **2.4x** |
| uniq | repetitive 10MB | 0.0420s | 0.0060s | **7.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0019s | **1.1x** |
| tac | reverse 10MB text | 0.0106s | 0.0055s | **1.9x** |
| tac | reverse 100MB text | 0.1046s | 0.0462s | **2.3x** |
| tac | reverse CSV 10MB | 0.0095s | 0.0057s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0234s | 0.0111s | **2.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0046s | **1.3x** |
