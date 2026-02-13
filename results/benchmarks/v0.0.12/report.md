# fcoreutils v0.0.12 — Detailed Results

Generated: 2026-02-13 23:31:14 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 351 | 62 | 85.0% |
| Linux_aarch64 | 413 | 355 | 58 | 86.0% |
| Linux_x86_64 | 354 | 332 | 22 | 93.8% |

**Overall: 1038/1180 (88.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0040s | 0.0031s | **1.3x** |
| wc | default 10MB text | 0.0336s | 0.0225s | **1.5x** |
| wc | default 100MB text | 0.2890s | 0.1772s | **1.6x** |
| wc | -l 10MB text | 0.0037s | 0.0021s | **1.7x** |
| wc | -w 10MB text | 0.0335s | 0.0206s | **1.6x** |
| wc | -c 10MB text | 0.0008s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0336s | 0.0034s | **10.0x** |
| wc | -L 10MB text | 0.0336s | 0.0151s | **2.2x** |
| wc | default 10MB binary | 0.2370s | 0.0584s | **4.1x** |
| wc | default 10MB repetitive | 0.0504s | 0.0243s | **2.1x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0013s | 0.0017s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0050s | **3.6x** |
| cut | -c1-100 10MB CSV | 0.0181s | 0.0051s | **3.5x** |
| cut | -d, -f1 10MB CSV | 0.0182s | 0.0034s | **5.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0058s | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0050s | **4.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0259s | 0.0070s | **3.7x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0015s | **2.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0009s | **1.2x** |
| sha256sum | single 1MB text | 0.0017s | 0.0015s | **1.1x** |
| sha256sum | single 10MB text | 0.0073s | 0.0069s | **1.1x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0073s | **1.1x** |
| sha256sum | single 100MB text | 0.0576s | 0.0596s | **1.0x** |
| sha256sum | 10 files | 0.0011s | 0.0013s | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0023s | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0009s | **1.4x** |
| md5sum | single 1MB text | 0.0031s | 0.0024s | **1.3x** |
| md5sum | single 10MB text | 0.0206s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0223s | 0.0171s | **1.3x** |
| md5sum | single 100MB text | 0.1892s | 0.1488s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0015s | **0.8x** |
| md5sum | 100 files | 0.0017s | 0.0023s | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0136s | 0.0134s | **1.0x** |
| b2sum | single 10MB binary | 0.0151s | 0.0142s | **1.1x** |
| b2sum | single 100MB text | 0.1244s | 0.1235s | **1.0x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0134s | **1.0x** |
| b2sum | -l 128 10MB | 0.0136s | 0.0134s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0023s | **0.7x** |
| base64 | encode 100KB text | 0.0009s | 0.0009s | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0020s | **0.8x** |
| base64 | encode 10MB text | 0.0095s | 0.0106s | **0.9x** |
| base64 | encode 10MB binary | 0.0107s | 0.0117s | **0.9x** |
| base64 | decode 1MB | 0.0038s | 0.0027s | **1.4x** |
| base64 | decode 10MB | 0.0308s | 0.0190s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0108s | **0.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0070s | 0.0070s | **1.0x** |
| sort | lexicographic 1MB | 0.0076s | 0.0045s | **1.7x** |
| sort | lexicographic 10MB random | 0.0518s | 0.0162s | **3.2x** |
| sort | already sorted 10MB | 0.0245s | 0.0092s | **2.7x** |
| sort | reverse sorted 10MB | 0.0244s | 0.0093s | **2.6x** |
| sort | -n numeric 10MB | 0.0689s | 0.0357s | **1.9x** |
| sort | -r reverse 10MB | 0.0520s | 0.0168s | **3.1x** |
| sort | -u unique 10MB | 0.0546s | 0.0178s | **3.1x** |
| sort | -t, -k2 CSV 10MB | 0.0703s | 0.0331s | **2.1x** |
| sort | repetitive 10MB | 0.0428s | 0.0206s | **2.1x** |
| sort | --parallel=4 10MB | 0.0510s | 0.0168s | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0024s | **0.8x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0109s | **0.8x** |
| tr | -d digits 10MB | 0.0112s | 0.0167s | **0.7x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0234s | **0.8x** |
| tr | -s spaces 10MB | 0.0167s | 0.0282s | **0.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0108s | **0.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0170s | **0.7x** |
| tr | translate binary 10MB | 0.0090s | 0.0121s | **0.7x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0045s | **2.1x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0055s | **3.0x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0048s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0071s | **4.1x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0059s | **2.8x** |
| uniq | repetitive 10MB | 0.0463s | 0.0070s | **6.6x** |
| tac | reverse 100KB text | 0.0008s | 0.0009s | **0.9x** |
| tac | reverse 1MB text | 0.0018s | 0.0016s | **1.1x** |
| tac | reverse 10MB text | 0.0084s | 0.0054s | **1.5x** |
| tac | reverse 100MB text | 0.0762s | 0.0444s | **1.7x** |
| tac | reverse CSV 10MB | 0.0077s | 0.0057s | **1.3x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0106s | **1.6x** |
| tac | custom separator 1MB | 0.0043s | 0.0050s | **0.9x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0032s | **1.8x** |
| wc | default 10MB text | 0.0552s | 0.0274s | **2.0x** |
| wc | default 100MB text | 0.4860s | 0.2243s | **2.2x** |
| wc | -l 10MB text | 0.0023s | 0.0025s | **0.9x** |
| wc | -w 10MB text | 0.0550s | 0.0250s | **2.2x** |
| wc | -c 10MB text | 0.0009s | 0.0009s | **1.0x** |
| wc | -m 10MB text | 0.0552s | 0.0038s | **14.5x** |
| wc | -L 10MB text | 0.0549s | 0.0160s | **3.4x** |
| wc | default 10MB binary | 0.3165s | 0.0892s | **3.5x** |
| wc | default 10MB repetitive | 0.0733s | 0.0282s | **2.6x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0020s | 0.0027s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0229s | 0.0057s | **4.0x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0059s | **3.9x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0039s | **4.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0075s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0248s | 0.0073s | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0110s | **2.8x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0017s | **1.9x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0009s | **1.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.3x** |
| sha256sum | single 10MB text | 0.0092s | 0.0082s | **1.1x** |
| sha256sum | single 10MB binary | 0.0096s | 0.0088s | **1.1x** |
| sha256sum | single 100MB text | 0.0754s | 0.0738s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0016s | **0.9x** |
| sha256sum | 100 files | 0.0026s | 0.0045s | **0.6x** |
| md5sum | single 100KB text | 0.0015s | 0.0011s | **1.4x** |
| md5sum | single 1MB text | 0.0029s | 0.0028s | **1.0x** |
| md5sum | single 10MB text | 0.0175s | 0.0205s | **0.9x** |
| md5sum | single 10MB binary | 0.0186s | 0.0213s | **0.9x** |
| md5sum | single 100MB text | 0.1612s | 0.1936s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0016s | **0.9x** |
| md5sum | 100 files | 0.0023s | 0.0044s | **0.5x** |
| b2sum | single 100KB text | 0.0011s | 0.0010s | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0020s | **1.2x** |
| b2sum | single 10MB text | 0.0155s | 0.0121s | **1.3x** |
| b2sum | single 10MB binary | 0.0163s | 0.0128s | **1.3x** |
| b2sum | single 100MB text | 0.1436s | 0.1115s | **1.3x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0121s | **1.3x** |
| b2sum | -l 128 10MB | 0.0153s | 0.0120s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0044s | **0.5x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0021s | **1.0x** |
| base64 | encode 10MB text | 0.0125s | 0.0068s | **1.8x** |
| base64 | encode 10MB binary | 0.0129s | 0.0069s | **1.9x** |
| base64 | decode 1MB | 0.0041s | 0.0029s | **1.4x** |
| base64 | decode 10MB | 0.0330s | 0.0161s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0129s | 0.0068s | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0038s | **2.3x** |
| sort | lexicographic 1MB | 0.0086s | 0.0052s | **1.7x** |
| sort | lexicographic 10MB random | 0.0550s | 0.0187s | **2.9x** |
| sort | already sorted 10MB | 0.0263s | 0.0110s | **2.4x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0117s | **2.4x** |
| sort | -n numeric 10MB | 0.0751s | 0.0392s | **1.9x** |
| sort | -r reverse 10MB | 0.0564s | 0.0182s | **3.1x** |
| sort | -u unique 10MB | 0.0657s | 0.0193s | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0679s | 0.0347s | **2.0x** |
| sort | repetitive 10MB | 0.0558s | 0.0186s | **3.0x** |
| sort | --parallel=4 10MB | 0.0552s | 0.0180s | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0021s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0104s | **1.2x** |
| tr | -d digits 10MB | 0.0160s | 0.0249s | **0.6x** |
| tr | -d lowercase 10MB | 0.0308s | 0.0391s | **0.8x** |
| tr | -s spaces 10MB | 0.0272s | 0.0392s | **0.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0127s | 0.0103s | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0174s | 0.0248s | **0.7x** |
| tr | translate binary 10MB | 0.0123s | 0.0143s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0044s | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0144s | 0.0045s | **3.2x** |
| uniq | -c count 10MB many dups | 0.0124s | 0.0047s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0071s | **4.1x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0047s | **2.6x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0145s | 0.0055s | **2.7x** |
| uniq | repetitive 10MB | 0.0425s | 0.0070s | **6.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0010s | **1.0x** |
| tac | reverse 1MB text | 0.0019s | 0.0017s | **1.1x** |
| tac | reverse 10MB text | 0.0110s | 0.0062s | **1.8x** |
| tac | reverse 100MB text | 0.1053s | 0.0466s | **2.3x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0068s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0238s | 0.0120s | **2.0x** |
| tac | custom separator 1MB | 0.0060s | 0.0067s | **0.9x** |
