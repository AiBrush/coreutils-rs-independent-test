# fcoreutils v0.0.13 — Detailed Results

Generated: 2026-02-16 21:59:13 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 402 | 11 | 97.3% |
| Linux_aarch64 | 413 | 406 | 7 | 98.3% |
| Linux_x86_64 | 413 | 406 | 7 | 98.3% |

**Overall: 1214/1239 (98.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0037s | 0.0030s | **1.2x** |
| wc | default 10MB text | 0.0335s | 0.0224s | **1.5x** |
| wc | default 100MB text | 0.2918s | 0.1786s | **1.6x** |
| wc | -l 10MB text | 0.0036s | 0.0019s | **1.9x** |
| wc | -w 10MB text | 0.0337s | 0.0203s | **1.7x** |
| wc | -c 10MB text | 0.0006s | 0.0007s | **0.9x** |
| wc | -m 10MB text | 0.0338s | 0.0036s | **9.5x** |
| wc | -L 10MB text | 0.0334s | 0.0146s | **2.3x** |
| wc | default 10MB binary | 0.2343s | 0.0578s | **4.1x** |
| wc | default 10MB repetitive | 0.0506s | 0.0237s | **2.1x** |
| wc | 10 files | 0.0008s | 0.0008s | **0.9x** |
| wc | 100 files | 0.0012s | 0.0017s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0182s | 0.0046s | **3.9x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0046s | **3.9x** |
| cut | -d, -f1 10MB CSV | 0.0184s | 0.0029s | **6.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0209s | 0.0058s | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0045s | **5.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0260s | 0.0061s | **4.3x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0014s | **2.4x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0009s | **1.3x** |
| sha256sum | single 1MB text | 0.0016s | 0.0014s | **1.1x** |
| sha256sum | single 10MB text | 0.0066s | 0.0067s | **1.0x** |
| sha256sum | single 10MB binary | 0.0069s | 0.0071s | **1.0x** |
| sha256sum | single 100MB text | 0.0600s | 0.0601s | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0012s | **0.9x** |
| sha256sum | 100 files | 0.0016s | 0.0021s | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0010s | **1.2x** |
| md5sum | single 1MB text | 0.0030s | 0.0023s | **1.3x** |
| md5sum | single 10MB text | 0.0203s | 0.0157s | **1.3x** |
| md5sum | single 10MB binary | 0.0210s | 0.0166s | **1.3x** |
| md5sum | single 100MB text | 0.1924s | 0.1491s | **1.3x** |
| md5sum | 10 files | 0.0010s | 0.0013s | **0.8x** |
| md5sum | 100 files | 0.0016s | 0.0022s | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0009s | **0.9x** |
| b2sum | single 1MB text | 0.0020s | 0.0020s | **1.0x** |
| b2sum | single 10MB text | 0.0131s | 0.0132s | **1.0x** |
| b2sum | single 10MB binary | 0.0137s | 0.0138s | **1.0x** |
| b2sum | single 100MB text | 0.1269s | 0.1246s | **1.0x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0132s | **1.0x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0132s | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0021s | **0.7x** |
| base64 | encode 100KB text | 0.0008s | 0.0008s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0018s | **0.9x** |
| base64 | encode 10MB text | 0.0090s | 0.0094s | **1.0x** |
| base64 | encode 10MB binary | 0.0091s | 0.0097s | **0.9x** |
| base64 | decode 1MB | 0.0036s | 0.0024s | **1.5x** |
| base64 | decode 10MB | 0.0290s | 0.0167s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0088s | 0.0099s | **0.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0068s | 0.0062s | **1.1x** |
| sort | lexicographic 1MB | 0.0073s | 0.0042s | **1.7x** |
| sort | lexicographic 10MB random | 0.0485s | 0.0152s | **3.2x** |
| sort | already sorted 10MB | 0.0243s | 0.0089s | **2.7x** |
| sort | reverse sorted 10MB | 0.0237s | 0.0087s | **2.7x** |
| sort | -n numeric 10MB | 0.0663s | 0.0295s | **2.2x** |
| sort | -r reverse 10MB | 0.0496s | 0.0148s | **3.3x** |
| sort | -u unique 10MB | 0.0515s | 0.0158s | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0680s | 0.0287s | **2.4x** |
| sort | repetitive 10MB | 0.0410s | 0.0189s | **2.2x** |
| sort | --parallel=4 10MB | 0.0485s | 0.0149s | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0023s | **0.8x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0102s | **0.9x** |
| tr | -d digits 10MB | 0.0110s | 0.0163s | **0.7x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0223s | **0.8x** |
| tr | -s spaces 10MB | 0.0167s | 0.0278s | **0.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0101s | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0109s | 0.0170s | **0.6x** |
| tr | translate binary 10MB | 0.0098s | 0.0109s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0044s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0054s | **3.0x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0045s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0069s | **4.2x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0046s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0058s | **2.8x** |
| uniq | repetitive 10MB | 0.0461s | 0.0068s | **6.8x** |
| tac | reverse 100KB text | 0.0008s | 0.0009s | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0015s | **1.1x** |
| tac | reverse 10MB text | 0.0080s | 0.0051s | **1.6x** |
| tac | reverse 100MB text | 0.0781s | 0.0444s | **1.8x** |
| tac | reverse CSV 10MB | 0.0078s | 0.0057s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0163s | 0.0099s | **1.7x** |
| tac | custom separator 1MB | 0.0041s | 0.0048s | **0.9x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0032s | **1.8x** |
| wc | default 10MB text | 0.0540s | 0.0266s | **2.0x** |
| wc | default 100MB text | 0.4823s | 0.2233s | **2.2x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | **0.8x** |
| wc | -w 10MB text | 0.0540s | 0.0243s | **2.2x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0543s | 0.0039s | **13.8x** |
| wc | -L 10MB text | 0.0545s | 0.0153s | **3.6x** |
| wc | default 10MB binary | 0.3159s | 0.0886s | **3.6x** |
| wc | default 10MB repetitive | 0.0727s | 0.0281s | **2.6x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0026s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0055s | **4.1x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0055s | **4.1x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0038s | **4.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0077s | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0072s | **3.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0107s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0017s | **2.0x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0009s | **1.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.2x** |
| sha256sum | single 10MB text | 0.0083s | 0.0081s | **1.0x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0084s | **1.0x** |
| sha256sum | single 100MB text | 0.0747s | 0.0732s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0016s | **0.9x** |
| sha256sum | 100 files | 0.0024s | 0.0042s | **0.6x** |
| md5sum | single 100KB text | 0.0015s | 0.0010s | **1.4x** |
| md5sum | single 1MB text | 0.0028s | 0.0028s | **1.0x** |
| md5sum | single 10MB text | 0.0169s | 0.0201s | **0.8x** |
| md5sum | single 10MB binary | 0.0177s | 0.0210s | **0.8x** |
| md5sum | single 100MB text | 0.1602s | 0.1930s | **0.8x** |
| md5sum | 10 files | 0.0013s | 0.0016s | **0.9x** |
| md5sum | 100 files | 0.0023s | 0.0041s | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0010s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0020s | **1.2x** |
| b2sum | single 10MB text | 0.0149s | 0.0119s | **1.3x** |
| b2sum | single 10MB binary | 0.0153s | 0.0124s | **1.2x** |
| b2sum | single 100MB text | 0.1419s | 0.1107s | **1.3x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0119s | **1.2x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0119s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0042s | **0.5x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0021s | **1.0x** |
| base64 | encode 10MB text | 0.0121s | 0.0066s | **1.8x** |
| base64 | encode 10MB binary | 0.0127s | 0.0068s | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0028s | **1.4x** |
| base64 | decode 10MB | 0.0323s | 0.0162s | **2.0x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0066s | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0037s | **2.3x** |
| sort | lexicographic 1MB | 0.0085s | 0.0046s | **1.8x** |
| sort | lexicographic 10MB random | 0.0563s | 0.0169s | **3.3x** |
| sort | already sorted 10MB | 0.0260s | 0.0109s | **2.4x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0109s | **2.5x** |
| sort | -n numeric 10MB | 0.0731s | 0.0381s | **1.9x** |
| sort | -r reverse 10MB | 0.0541s | 0.0169s | **3.2x** |
| sort | -u unique 10MB | 0.0578s | 0.0170s | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0670s | 0.0313s | **2.1x** |
| sort | repetitive 10MB | 0.0547s | 0.0183s | **3.0x** |
| sort | --parallel=4 10MB | 0.0537s | 0.0168s | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0022s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0100s | **1.2x** |
| tr | -d digits 10MB | 0.0168s | 0.0247s | **0.7x** |
| tr | -d lowercase 10MB | 0.0296s | 0.0389s | **0.8x** |
| tr | -s spaces 10MB | 0.0272s | 0.0392s | **0.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0176s | 0.0099s | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0166s | 0.0248s | **0.7x** |
| tr | translate binary 10MB | 0.0122s | 0.0143s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0044s | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0042s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0048s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0289s | 0.0069s | **4.2x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0048s | **2.5x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0048s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0138s | 0.0052s | **2.6x** |
| uniq | repetitive 10MB | 0.0416s | 0.0070s | **5.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0010s | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0064s | **1.6x** |
| tac | reverse 100MB text | 0.1033s | 0.0468s | **2.2x** |
| tac | reverse CSV 10MB | 0.0095s | 0.0065s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0229s | 0.0118s | **1.9x** |
| tac | custom separator 1MB | 0.0059s | 0.0067s | **0.9x** |
