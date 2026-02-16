# fcoreutils v0.0.62 — Detailed Results

Generated: 2026-02-16 06:06:15 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 412 | 1 | 99.8% |

**Overall: 825/826 (99.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0012s | **1.0x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0346s | 0.0066s | **5.3x** |
| wc | default 100MB text | 0.2899s | 0.0423s | **6.9x** |
| wc | -l 10MB text | 0.0042s | 0.0021s | **2.0x** |
| wc | -w 10MB text | 0.0345s | 0.0061s | **5.7x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0348s | 0.0026s | **13.6x** |
| wc | -L 10MB text | 0.0345s | 0.0061s | **5.6x** |
| wc | default 10MB binary | 0.2363s | 0.0172s | **13.7x** |
| wc | default 10MB repetitive | 0.0504s | 0.0079s | **6.4x** |
| wc | 10 files | 0.0009s | 0.0011s | **0.8x** |
| wc | 100 files | 0.0014s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0033s | **5.7x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0030s | **6.1x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0044s | **4.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0044s | **4.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0036s | **6.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0052s | **5.1x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | **0.6x** |
| sha256sum | single 10MB text | 0.0076s | 0.0074s | **1.0x** |
| sha256sum | single 10MB binary | 0.0078s | 0.0074s | **1.1x** |
| sha256sum | single 100MB text | 0.0584s | 0.0536s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0024s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0023s | **0.5x** |
| md5sum | single 1MB text | 0.0030s | 0.0035s | **0.8x** |
| md5sum | single 10MB text | 0.0215s | 0.0166s | **1.3x** |
| md5sum | single 10MB binary | 0.0223s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1904s | 0.1412s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0026s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0021s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0139s | 0.0130s | **1.1x** |
| b2sum | single 10MB binary | 0.0151s | 0.0134s | **1.1x** |
| b2sum | single 100MB text | 0.1249s | 0.1168s | **1.1x** |
| b2sum | -l 256 10MB | 0.0145s | 0.0130s | **1.1x** |
| b2sum | -l 128 10MB | 0.0145s | 0.0129s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0014s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 10MB text | 0.0102s | 0.0049s | **2.1x** |
| base64 | encode 10MB binary | 0.0103s | 0.0051s | **2.0x** |
| base64 | decode 1MB | 0.0038s | 0.0022s | **1.7x** |
| base64 | decode 10MB | 0.0309s | 0.0110s | **2.8x** |
| base64 | encode -w 76 10MB | 0.0098s | 0.0049s | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0075s | 0.0044s | **1.7x** |
| sort | lexicographic 1MB | 0.0076s | 0.0028s | **2.7x** |
| sort | lexicographic 10MB random | 0.0519s | 0.0060s | **8.6x** |
| sort | already sorted 10MB | 0.0244s | 0.0041s | **5.9x** |
| sort | reverse sorted 10MB | 0.0241s | 0.0051s | **4.8x** |
| sort | -n numeric 10MB | 0.0706s | 0.0542s | **1.3x** |
| sort | -r reverse 10MB | 0.0531s | 0.0063s | **8.5x** |
| sort | -u unique 10MB | 0.0546s | 0.0135s | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0714s | 0.0194s | **3.7x** |
| sort | repetitive 10MB | 0.0429s | 0.0077s | **5.5x** |
| sort | --parallel=4 10MB | 0.0515s | 0.0063s | **8.2x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0019s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0069s | **1.3x** |
| tr | -d digits 10MB | 0.0111s | 0.0133s | **0.8x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0206s | **0.9x** |
| tr | -s spaces 10MB | 0.0169s | 0.0075s | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0070s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0135s | **0.8x** |
| tr | translate binary 10MB | 0.0092s | 0.0072s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0047s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0033s | **5.0x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0048s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0066s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0043s | **3.7x** |
| uniq | repetitive 10MB | 0.0463s | 0.0043s | **10.9x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.7x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | **0.9x** |
| tac | reverse 10MB text | 0.0084s | 0.0048s | **1.8x** |
| tac | reverse 100MB text | 0.0769s | 0.0382s | **2.0x** |
| tac | reverse CSV 10MB | 0.0079s | 0.0048s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0168s | 0.0095s | **1.8x** |
| tac | custom separator 1MB | 0.0043s | 0.0041s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0058s | 0.0031s | **1.9x** |
| wc | default 10MB text | 0.0550s | 0.0035s | **15.7x** |
| wc | default 100MB text | 0.4831s | 0.0155s | **31.2x** |
| wc | -l 10MB text | 0.0020s | 0.0027s | **0.7x** |
| wc | -w 10MB text | 0.0546s | 0.0121s | **4.5x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0559s | 0.0032s | **17.6x** |
| wc | -L 10MB text | 0.0544s | 0.0147s | **3.7x** |
| wc | default 10MB binary | 0.3162s | 0.0395s | **8.0x** |
| wc | default 10MB repetitive | 0.0732s | 0.0051s | **14.4x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.9x** |
| wc | 100 files | 0.0020s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0227s | 0.0050s | **4.6x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0052s | **4.4x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0068s | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0220s | 0.0102s | **2.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0244s | 0.0068s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0104s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0028s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0021s | 0.0031s | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0097s | **0.9x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0100s | **0.9x** |
| sha256sum | single 100MB text | 0.0753s | 0.0756s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0033s | **0.8x** |
| md5sum | single 100KB text | 0.0016s | 0.0026s | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0040s | **0.7x** |
| md5sum | single 10MB text | 0.0176s | 0.0176s | **1.0x** |
| md5sum | single 10MB binary | 0.0181s | 0.0182s | **1.0x** |
| md5sum | single 100MB text | 0.1610s | 0.1542s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0023s | **1.0x** |
| b2sum | single 10MB text | 0.0152s | 0.0122s | **1.3x** |
| b2sum | single 10MB binary | 0.0163s | 0.0135s | **1.2x** |
| b2sum | single 100MB text | 0.1431s | 0.1118s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0124s | **1.2x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0122s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | **1.5x** |
| base64 | encode 10MB text | 0.0126s | 0.0049s | **2.6x** |
| base64 | encode 10MB binary | 0.0131s | 0.0048s | **2.7x** |
| base64 | decode 1MB | 0.0040s | 0.0023s | **1.8x** |
| base64 | decode 10MB | 0.0332s | 0.0140s | **2.4x** |
| base64 | encode -w 76 10MB | 0.0125s | 0.0047s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0040s | **2.2x** |
| sort | lexicographic 1MB | 0.0088s | 0.0038s | **2.3x** |
| sort | lexicographic 10MB random | 0.0730s | 0.0117s | **6.3x** |
| sort | already sorted 10MB | 0.0358s | 0.0065s | **5.5x** |
| sort | reverse sorted 10MB | 0.0372s | 0.0090s | **4.1x** |
| sort | -n numeric 10MB | 0.1060s | 0.0552s | **1.9x** |
| sort | -r reverse 10MB | 0.0733s | 0.0117s | **6.3x** |
| sort | -u unique 10MB | 0.0744s | 0.0146s | **5.1x** |
| sort | -t, -k2 CSV 10MB | 0.0914s | 0.0324s | **2.8x** |
| sort | repetitive 10MB | 0.0679s | 0.0104s | **6.5x** |
| sort | --parallel=4 10MB | 0.0713s | 0.0117s | **6.1x** |
| tr | a-z to A-Z 1MB | 0.0032s | 0.0023s | **1.4x** |
| tr | a-z to A-Z 10MB | 0.0180s | 0.0077s | **2.3x** |
| tr | -d digits 10MB | 0.0231s | 0.0154s | **1.5x** |
| tr | -d lowercase 10MB | 0.0346s | 0.0140s | **2.5x** |
| tr | -s spaces 10MB | 0.0384s | 0.0072s | **5.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0180s | 0.0078s | **2.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0237s | 0.0147s | **1.6x** |
| tr | translate binary 10MB | 0.0156s | 0.0078s | **2.0x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0049s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0144s | 0.0043s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0049s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0086s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0047s | **2.6x** |
| uniq | -u unique only 10MB | 0.0126s | 0.0047s | **2.7x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0050s | **2.8x** |
| uniq | repetitive 10MB | 0.0421s | 0.0063s | **6.7x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0018s | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0051s | **2.1x** |
| tac | reverse 100MB text | 0.1045s | 0.0435s | **2.4x** |
| tac | reverse CSV 10MB | 0.0100s | 0.0061s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0110s | **2.1x** |
| tac | custom separator 1MB | 0.0085s | 0.0062s | **1.4x** |
