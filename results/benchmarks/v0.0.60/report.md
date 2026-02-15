# fcoreutils v0.0.60 — Detailed Results

Generated: 2026-02-15 05:12:34 UTC

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
| wc | default 100KB text | 0.0010s | 0.0010s | **1.0x** |
| wc | default 1MB text | 0.0037s | 0.0025s | **1.5x** |
| wc | default 10MB text | 0.0332s | 0.0061s | **5.4x** |
| wc | default 100MB text | 0.2885s | 0.0415s | **7.0x** |
| wc | -l 10MB text | 0.0035s | 0.0019s | **1.8x** |
| wc | -w 10MB text | 0.0335s | 0.0060s | **5.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0333s | 0.0020s | **16.5x** |
| wc | -L 10MB text | 0.0332s | 0.0058s | **5.7x** |
| wc | default 10MB binary | 0.2338s | 0.0171s | **13.7x** |
| wc | default 10MB repetitive | 0.0521s | 0.0075s | **6.9x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0012s | 0.0013s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0178s | 0.0029s | **6.2x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0028s | **6.4x** |
| cut | -d, -f1 10MB CSV | 0.0181s | 0.0043s | **4.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0206s | 0.0045s | **4.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0224s | 0.0032s | **7.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0261s | 0.0048s | **5.4x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0010s | 0.0019s | **0.5x** |
| sha256sum | single 1MB text | 0.0015s | 0.0024s | **0.6x** |
| sha256sum | single 10MB text | 0.0068s | 0.0071s | **1.0x** |
| sha256sum | single 10MB binary | 0.0068s | 0.0074s | **0.9x** |
| sha256sum | single 100MB text | 0.0570s | 0.0534s | **1.1x** |
| sha256sum | 10 files | 0.0010s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0020s | 0.0027s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0035s | **0.9x** |
| md5sum | single 10MB text | 0.0203s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0208s | 0.0165s | **1.3x** |
| md5sum | single 100MB text | 0.1887s | 0.1404s | **1.3x** |
| md5sum | 10 files | 0.0010s | 0.0019s | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0023s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | **0.9x** |
| b2sum | single 10MB text | 0.0131s | 0.0128s | **1.0x** |
| b2sum | single 10MB binary | 0.0136s | 0.0133s | **1.0x** |
| b2sum | single 100MB text | 0.1239s | 0.1173s | **1.1x** |
| b2sum | -l 256 10MB | 0.0134s | 0.0126s | **1.1x** |
| b2sum | -l 128 10MB | 0.0131s | 0.0127s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0016s | **1.0x** |
| base64 | encode 10MB text | 0.0090s | 0.0030s | **3.0x** |
| base64 | encode 10MB binary | 0.0099s | 0.0032s | **3.1x** |
| base64 | decode 1MB | 0.0036s | 0.0022s | **1.6x** |
| base64 | decode 10MB | 0.0300s | 0.0143s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0038s | **2.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0073s | 0.0029s | **2.5x** |
| sort | lexicographic 1MB | 0.0074s | 0.0027s | **2.8x** |
| sort | lexicographic 10MB random | 0.0498s | 0.0056s | **8.9x** |
| sort | already sorted 10MB | 0.0241s | 0.0041s | **5.9x** |
| sort | reverse sorted 10MB | 0.0236s | 0.0048s | **4.9x** |
| sort | -n numeric 10MB | 0.0679s | 0.0502s | **1.4x** |
| sort | -r reverse 10MB | 0.0503s | 0.0059s | **8.6x** |
| sort | -u unique 10MB | 0.0531s | 0.0115s | **4.6x** |
| sort | -t, -k2 CSV 10MB | 0.0678s | 0.0169s | **4.0x** |
| sort | repetitive 10MB | 0.0404s | 0.0074s | **5.5x** |
| sort | --parallel=4 10MB | 0.0522s | 0.0063s | **8.3x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0017s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0062s | **1.5x** |
| tr | -d digits 10MB | 0.0111s | 0.0065s | **1.7x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0091s | **2.1x** |
| tr | -s spaces 10MB | 0.0167s | 0.0056s | **3.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0059s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0065s | **1.7x** |
| tr | translate binary 10MB | 0.0096s | 0.0068s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0031s | **5.2x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0066s | **4.5x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0042s | **3.9x** |
| uniq | repetitive 10MB | 0.0461s | 0.0040s | **11.6x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.7x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0080s | 0.0051s | **1.6x** |
| tac | reverse 100MB text | 0.0760s | 0.0421s | **1.8x** |
| tac | reverse CSV 10MB | 0.0079s | 0.0046s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0164s | 0.0089s | **1.8x** |
| tac | custom separator 1MB | 0.0041s | 0.0034s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0028s | **2.0x** |
| wc | default 10MB text | 0.0545s | 0.0030s | **17.9x** |
| wc | default 100MB text | 0.4819s | 0.0143s | **33.6x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | **0.8x** |
| wc | -w 10MB text | 0.0545s | 0.0108s | **5.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0545s | 0.0029s | **18.8x** |
| wc | -L 10MB text | 0.0545s | 0.0097s | **5.6x** |
| wc | default 10MB binary | 0.3185s | 0.0270s | **11.8x** |
| wc | default 10MB repetitive | 0.0730s | 0.0052s | **14.2x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.9x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0043s | **5.2x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0040s | **5.6x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0051s | **3.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0072s | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0052s | **4.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0308s | 0.0084s | **3.7x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0095s | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0100s | **0.9x** |
| sha256sum | single 100MB text | 0.0743s | 0.0755s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | **0.8x** |
| md5sum | single 10MB text | 0.0172s | 0.0176s | **1.0x** |
| md5sum | single 10MB binary | 0.0179s | 0.0182s | **1.0x** |
| md5sum | single 100MB text | 0.1601s | 0.1531s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0031s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0023s | **1.0x** |
| b2sum | single 10MB text | 0.0150s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0160s | 0.0127s | **1.3x** |
| b2sum | single 100MB text | 0.1422s | 0.1116s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0122s | **1.2x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0018s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | **1.3x** |
| base64 | encode 10MB text | 0.0125s | 0.0047s | **2.7x** |
| base64 | encode 10MB binary | 0.0130s | 0.0048s | **2.7x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | **1.8x** |
| base64 | decode 10MB | 0.0328s | 0.0131s | **2.5x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0048s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0036s | **2.4x** |
| sort | lexicographic 1MB | 0.0086s | 0.0037s | **2.3x** |
| sort | lexicographic 10MB random | 0.0543s | 0.0089s | **6.1x** |
| sort | already sorted 10MB | 0.0285s | 0.0058s | **4.9x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0072s | **3.8x** |
| sort | -n numeric 10MB | 0.0734s | 0.0528s | **1.4x** |
| sort | -r reverse 10MB | 0.0547s | 0.0093s | **5.9x** |
| sort | -u unique 10MB | 0.0577s | 0.0139s | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0667s | 0.0228s | **2.9x** |
| sort | repetitive 10MB | 0.0548s | 0.0096s | **5.7x** |
| sort | --parallel=4 10MB | 0.0547s | 0.0093s | **5.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0077s | **1.7x** |
| tr | -d digits 10MB | 0.0168s | 0.0095s | **1.8x** |
| tr | -d lowercase 10MB | 0.0296s | 0.0094s | **3.2x** |
| tr | -s spaces 10MB | 0.0282s | 0.0061s | **4.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0124s | 0.0074s | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0181s | 0.0089s | **2.0x** |
| tr | translate binary 10MB | 0.0120s | 0.0084s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0048s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0035s | **4.0x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0047s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0083s | **3.5x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0047s | **2.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0049s | **2.8x** |
| uniq | repetitive 10MB | 0.0424s | 0.0051s | **8.3x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0018s | **1.1x** |
| tac | reverse 10MB text | 0.0105s | 0.0059s | **1.8x** |
| tac | reverse 100MB text | 0.1039s | 0.0493s | **2.1x** |
| tac | reverse CSV 10MB | 0.0095s | 0.0051s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0105s | **2.2x** |
| tac | custom separator 1MB | 0.0059s | 0.0039s | **1.5x** |
