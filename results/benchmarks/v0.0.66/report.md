# fcoreutils v0.0.66 — Detailed Results

Generated: 2026-02-14 15:18:55 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 397 | 16 | 96.1% |
| Linux_x86_64 | 413 | 397 | 16 | 96.1% |

**Overall: 794/826 (96.1%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0037s | 0.0026s | **1.4x** |
| wc | default 10MB text | 0.0347s | 0.0068s | **5.1x** |
| wc | default 100MB text | 0.2933s | 0.0426s | **6.9x** |
| wc | -l 10MB text | 0.0044s | 0.0023s | **1.9x** |
| wc | -w 10MB text | 0.0343s | 0.0062s | **5.5x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0341s | 0.0023s | **14.6x** |
| wc | -L 10MB text | 0.0346s | 0.0060s | **5.8x** |
| wc | default 10MB binary | 0.2339s | 0.0173s | **13.5x** |
| wc | default 10MB repetitive | 0.0515s | 0.0082s | **6.3x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.8x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0036s | **5.3x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0033s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0046s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0048s | **4.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0039s | **6.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0051s | **5.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0022s | **1.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | **0.8x** |
| sha256sum | single 100KB text | 0.0013s | 0.0022s | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | **0.6x** |
| sha256sum | single 10MB text | 0.0076s | 0.0074s | **1.0x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0077s | **1.0x** |
| sha256sum | single 100MB text | 0.0623s | 0.0547s | **1.1x** |
| sha256sum | 10 files | 0.0012s | 0.0020s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0036s | **0.9x** |
| md5sum | single 10MB text | 0.0214s | 0.0164s | **1.3x** |
| md5sum | single 10MB binary | 0.0215s | 0.0169s | **1.3x** |
| md5sum | single 100MB text | 0.1936s | 0.1419s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0026s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0021s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0141s | 0.0125s | **1.1x** |
| b2sum | single 10MB binary | 0.0140s | 0.0129s | **1.1x** |
| b2sum | single 100MB text | 0.1284s | 0.1143s | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0126s | **1.1x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0125s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 10MB text | 0.0099s | 0.0034s | **2.9x** |
| base64 | encode 10MB binary | 0.0098s | 0.0031s | **3.1x** |
| base64 | decode 1MB | 0.0038s | 0.0023s | **1.7x** |
| base64 | decode 10MB | 0.0308s | 0.0111s | **2.8x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0034s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0032s | **2.4x** |
| sort | lexicographic 1MB | 0.0074s | 0.0027s | **2.7x** |
| sort | lexicographic 10MB random | 0.0523s | 0.0065s | **8.1x** |
| sort | already sorted 10MB | 0.0244s | 0.0035s | **7.0x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0055s | **4.4x** |
| sort | -n numeric 10MB | 0.0709s | 0.0499s | **1.4x** |
| sort | -r reverse 10MB | 0.0545s | 0.0072s | **7.6x** |
| sort | -u unique 10MB | 0.0562s | 0.0134s | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0721s | 0.0179s | **4.0x** |
| sort | repetitive 10MB | 0.0423s | 0.0077s | **5.5x** |
| sort | --parallel=4 10MB | 0.0523s | 0.0062s | **8.4x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0029s | **0.6x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0200s | **0.4x** |
| tr | -d digits 10MB | 0.0112s | 0.0135s | **0.8x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0205s | **0.9x** |
| tr | -s spaces 10MB | 0.0167s | 0.0073s | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0202s | **0.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0134s | **0.8x** |
| tr | translate binary 10MB | 0.0096s | 0.0165s | **0.6x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0031s | **5.2x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0049s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0059s | **4.9x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0043s | **3.7x** |
| uniq | repetitive 10MB | 0.0464s | 0.0041s | **11.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0019s | **0.9x** |
| tac | reverse 10MB text | 0.0091s | 0.0056s | **1.6x** |
| tac | reverse 100MB text | 0.0799s | 0.0378s | **2.1x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0051s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0093s | **1.8x** |
| tac | custom separator 1MB | 0.0044s | 0.0036s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0544s | 0.0031s | **17.3x** |
| wc | default 100MB text | 0.4819s | 0.0140s | **34.5x** |
| wc | -l 10MB text | 0.0022s | 0.0026s | **0.8x** |
| wc | -w 10MB text | 0.0545s | 0.0094s | **5.8x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.9x** |
| wc | -m 10MB text | 0.0571s | 0.0030s | **19.2x** |
| wc | -L 10MB text | 0.0542s | 0.0097s | **5.6x** |
| wc | default 10MB binary | 0.3169s | 0.0278s | **11.4x** |
| wc | default 10MB repetitive | 0.0729s | 0.0046s | **15.9x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0042s | **5.4x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0042s | **5.4x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0050s | **3.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0074s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0055s | **4.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0094s | **3.3x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0096s | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0099s | **0.9x** |
| sha256sum | single 100MB text | 0.0741s | 0.0748s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | **0.8x** |
| md5sum | single 10MB text | 0.0171s | 0.0173s | **1.0x** |
| md5sum | single 10MB binary | 0.0179s | 0.0182s | **1.0x** |
| md5sum | single 100MB text | 0.1596s | 0.1526s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0148s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0157s | 0.0129s | **1.2x** |
| b2sum | single 100MB text | 0.1423s | 0.1120s | **1.3x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0123s | **1.2x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0123s | **1.2x** |
| b2sum | 100 files | 0.0023s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | **1.4x** |
| base64 | encode 10MB text | 0.0124s | 0.0051s | **2.4x** |
| base64 | encode 10MB binary | 0.0132s | 0.0050s | **2.6x** |
| base64 | decode 1MB | 0.0040s | 0.0026s | **1.5x** |
| base64 | decode 10MB | 0.0328s | 0.0171s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0049s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0037s | **2.3x** |
| sort | lexicographic 1MB | 0.0086s | 0.0036s | **2.4x** |
| sort | lexicographic 10MB random | 0.0550s | 0.0093s | **5.9x** |
| sort | already sorted 10MB | 0.0264s | 0.0049s | **5.4x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0072s | **3.9x** |
| sort | -n numeric 10MB | 0.0740s | 0.0499s | **1.5x** |
| sort | -r reverse 10MB | 0.0543s | 0.0095s | **5.7x** |
| sort | -u unique 10MB | 0.0582s | 0.0129s | **4.5x** |
| sort | -t, -k2 CSV 10MB | 0.0665s | 0.0242s | **2.8x** |
| sort | repetitive 10MB | 0.0551s | 0.0101s | **5.4x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0093s | **5.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0134s | 0.0060s | **2.2x** |
| tr | -d digits 10MB | 0.0161s | 0.0134s | **1.2x** |
| tr | -d lowercase 10MB | 0.0311s | 0.0129s | **2.4x** |
| tr | -s spaces 10MB | 0.0288s | 0.0066s | **4.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0133s | 0.0057s | **2.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0184s | 0.0131s | **1.4x** |
| tr | translate binary 10MB | 0.0110s | 0.0069s | **1.6x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0050s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0036s | **3.9x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0047s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0077s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0049s | **2.5x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0049s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0051s | **2.8x** |
| uniq | repetitive 10MB | 0.0425s | 0.0055s | **7.7x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | **1.0x** |
| tac | reverse 10MB text | 0.0107s | 0.0064s | **1.7x** |
| tac | reverse 100MB text | 0.1045s | 0.0439s | **2.4x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0063s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0229s | 0.0113s | **2.0x** |
| tac | custom separator 1MB | 0.0060s | 0.0040s | **1.5x** |
