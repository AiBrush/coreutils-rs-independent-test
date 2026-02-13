# fcoreutils v0.0.22 — Detailed Results

Generated: 2026-02-13 07:08:10 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 396 | 17 | 95.9% |
| Linux_aarch64 | 413 | 402 | 11 | 97.3% |
| Linux_x86_64 | 413 | 402 | 11 | 97.3% |

**Overall: 1200/1239 (96.9%)**

## Performance

### Darwin_arm64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| cut | -b1-100 10MB CSV | 0.0424s | 0.0077s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0376s | 0.0194s | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0246s | 0.0168s | **1.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0544s | 0.0425s | **1.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0481s | 0.0002s | **233.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0709s | 0.0159s | **4.4x** |
| cut | -d, -f1 100KB text | 0.0019s | 0.0019s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0099s | 0.0054s | **1.8x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0003s | **2.8x** |
| sha256sum | single 100KB text | 0.0027s | 0.0014s | **1.9x** |
| sha256sum | single 1MB text | 0.0132s | 0.0054s | **2.4x** |
| sha256sum | single 10MB text | 0.0559s | 0.0072s | **7.8x** |
| sha256sum | single 10MB binary | 0.0665s | 0.0306s | **2.2x** |
| sha256sum | single 100MB text | 0.5560s | 0.1033s | **5.4x** |
| sha256sum | 10 files | 0.0084s | 0.0219s | **0.4x** |
| sha256sum | 100 files | 0.0134s | 0.0040s | **3.4x** |
| md5sum | single 100KB text | 0.0100s | 0.0099s | **1.0x** |
| md5sum | single 1MB text | 0.0227s | 0.0036s | **6.3x** |
| md5sum | single 10MB text | 0.0137s | 0.0139s | **1.0x** |
| md5sum | single 10MB binary | 0.0495s | 0.0323s | **1.5x** |
| md5sum | single 100MB text | 0.2049s | 0.1892s | **1.1x** |
| md5sum | 10 files | 0.0035s | 0.0087s | **0.4x** |
| md5sum | 100 files | 0.0022s | 0.0008s | **2.8x** |
| sort | lexicographic 1MB | 0.1253s | 0.0047s | **26.4x** |
| sort | lexicographic 10MB random | 0.4714s | 0.0455s | **10.4x** |
| sort | already sorted 10MB | 0.2274s | 0.0205s | **11.1x** |
| sort | reverse sorted 10MB | 0.2372s | 0.0220s | **10.8x** |
| sort | -n numeric 10MB | 0.5443s | 0.0628s | **8.7x** |
| sort | -r reverse 10MB | 0.4921s | 0.0363s | **13.5x** |
| sort | -u unique 10MB | 0.5470s | 0.0375s | **14.6x** |
| sort | -t, -k2 CSV 10MB | 0.6265s | 0.0586s | **10.7x** |
| sort | repetitive 10MB | 0.0731s | 0.0355s | **2.1x** |
| sort | --parallel=4 10MB | 0.4374s | 0.0548s | **8.0x** |
| tr | a-z to A-Z 1MB | 0.0150s | 0.0022s | **6.9x** |
| tr | a-z to A-Z 10MB | 0.0186s | 0.0053s | **3.5x** |
| tr | -d digits 10MB | 0.0135s | 0.0150s | **0.9x** |
| tr | -d lowercase 10MB | 0.0450s | 0.0364s | **1.2x** |
| tr | -s spaces 10MB | 0.0573s | 0.0217s | **2.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0426s | 0.0285s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0299s | 0.0261s | **1.1x** |
| tr | translate binary 10MB | 0.0328s | 0.0144s | **2.3x** |
| uniq | default 10MB many duplicates | 0.0151s | 0.0038s | **4.0x** |
| uniq | default 10MB sorted (low dup) | 0.0220s | 0.0072s | **3.1x** |
| uniq | -c count 10MB many dups | 0.0110s | 0.0090s | **1.2x** |
| uniq | -c count 10MB sorted | 0.0406s | 0.0165s | **2.5x** |
| uniq | -d duplicates only 10MB | 0.0102s | 0.0054s | **1.9x** |
| uniq | -u unique only 10MB | 0.0117s | 0.0091s | **1.3x** |
| uniq | -i case insensitive 10MB | 0.0207s | 0.0118s | **1.7x** |
| uniq | repetitive 10MB | 0.0378s | 0.0101s | **3.7x** |

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0010s | **1.0x** |
| wc | default 1MB text | 0.0039s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0335s | 0.0169s | **2.0x** |
| wc | default 100MB text | 0.2898s | 0.0400s | **7.2x** |
| wc | -l 10MB text | 0.0035s | 0.0023s | **1.5x** |
| wc | -w 10MB text | 0.0335s | 0.0167s | **2.0x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0335s | 0.0018s | **18.4x** |
| wc | -L 10MB text | 0.0334s | 0.0168s | **2.0x** |
| wc | default 10MB binary | 0.2358s | 0.0596s | **4.0x** |
| wc | default 10MB repetitive | 0.0504s | 0.0067s | **7.5x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0012s | 0.0013s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0049s | **3.8x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0047s | **3.9x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0033s | **5.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0059s | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0051s | **4.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0066s | **4.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0018s | **1.8x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0010s | **1.2x** |
| sha256sum | single 1MB text | 0.0017s | 0.0017s | **1.0x** |
| sha256sum | single 10MB text | 0.0067s | 0.0069s | **1.0x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0072s | **1.0x** |
| sha256sum | single 100MB text | 0.0605s | 0.0600s | **1.0x** |
| sha256sum | 10 files | 0.0011s | 0.0009s | **1.3x** |
| sha256sum | 100 files | 0.0018s | 0.0013s | **1.3x** |
| md5sum | single 100KB text | 0.0012s | 0.0010s | **1.2x** |
| md5sum | single 1MB text | 0.0030s | 0.0027s | **1.1x** |
| md5sum | single 10MB text | 0.0202s | 0.0158s | **1.3x** |
| md5sum | single 10MB binary | 0.0216s | 0.0167s | **1.3x** |
| md5sum | single 100MB text | 0.1928s | 0.1490s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0008s | **1.3x** |
| md5sum | 100 files | 0.0018s | 0.0014s | **1.3x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | **0.9x** |
| b2sum | single 1MB text | 0.0020s | 0.0024s | **0.8x** |
| b2sum | single 10MB text | 0.0132s | 0.0129s | **1.0x** |
| b2sum | single 10MB binary | 0.0144s | 0.0135s | **1.1x** |
| b2sum | single 100MB text | 0.1266s | 0.1193s | **1.1x** |
| b2sum | -l 256 10MB | 0.0130s | 0.0129s | **1.0x** |
| b2sum | -l 128 10MB | 0.0132s | 0.0130s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0013s | **1.3x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0026s | **0.6x** |
| base64 | encode 10MB text | 0.0090s | 0.0060s | **1.5x** |
| base64 | encode 10MB binary | 0.0098s | 0.0063s | **1.6x** |
| base64 | decode 1MB | 0.0037s | 0.0030s | **1.3x** |
| base64 | decode 10MB | 0.0307s | 0.0191s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0091s | 0.0061s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0068s | 0.0047s | **1.4x** |
| sort | lexicographic 1MB | 0.0076s | 0.0040s | **1.9x** |
| sort | lexicographic 10MB random | 0.0518s | 0.0179s | **2.9x** |
| sort | already sorted 10MB | 0.0245s | 0.0100s | **2.4x** |
| sort | reverse sorted 10MB | 0.0244s | 0.0101s | **2.4x** |
| sort | -n numeric 10MB | 0.0698s | 0.0342s | **2.0x** |
| sort | -r reverse 10MB | 0.0522s | 0.0176s | **3.0x** |
| sort | -u unique 10MB | 0.0545s | 0.0184s | **3.0x** |
| sort | -t, -k2 CSV 10MB | 0.0735s | 0.0338s | **2.2x** |
| sort | repetitive 10MB | 0.0420s | 0.0228s | **1.8x** |
| sort | --parallel=4 10MB | 0.0504s | 0.0170s | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0016s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0093s | 0.0064s | **1.5x** |
| tr | -d digits 10MB | 0.0112s | 0.0097s | **1.1x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0167s | **1.1x** |
| tr | -s spaces 10MB | 0.0171s | 0.0140s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0063s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0098s | **1.1x** |
| tr | translate binary 10MB | 0.0090s | 0.0064s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0051s | **1.8x** |
| uniq | default 10MB sorted (low dup) | 0.0161s | 0.0066s | **2.5x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0051s | **1.8x** |
| uniq | -c count 10MB sorted | 0.0289s | 0.0095s | **3.0x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0052s | **1.8x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0052s | **1.8x** |
| uniq | -i case insensitive 10MB | 0.0160s | 0.0073s | **2.2x** |
| uniq | repetitive 10MB | 0.0464s | 0.0074s | **6.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0012s | **0.7x** |
| tac | reverse 1MB text | 0.0017s | 0.0021s | **0.8x** |
| tac | reverse 10MB text | 0.0080s | 0.0067s | **1.2x** |
| tac | reverse 100MB text | 0.0769s | 0.0552s | **1.4x** |
| tac | reverse CSV 10MB | 0.0079s | 0.0069s | **1.1x** |
| tac | reverse repetitive 10MB | 0.0169s | 0.0142s | **1.2x** |
| tac | custom separator 1MB | 0.0044s | 0.0052s | **0.8x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0033s | **1.7x** |
| wc | default 10MB text | 0.0543s | 0.0201s | **2.7x** |
| wc | default 100MB text | 0.4830s | 0.0789s | **6.1x** |
| wc | -l 10MB text | 0.0020s | 0.0018s | **1.1x** |
| wc | -w 10MB text | 0.0541s | 0.0197s | **2.7x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.0x** |
| wc | -m 10MB text | 0.0543s | 0.0018s | **30.2x** |
| wc | -L 10MB text | 0.0536s | 0.0229s | **2.3x** |
| wc | default 10MB binary | 0.3160s | 0.0820s | **3.9x** |
| wc | default 10MB repetitive | 0.0728s | 0.0132s | **5.5x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0051s | **4.4x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0051s | **4.4x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0036s | **4.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0074s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0065s | **3.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0101s | **3.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0022s | **1.5x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0008s | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0010s | **1.3x** |
| sha256sum | single 1MB text | 0.0021s | 0.0023s | **0.9x** |
| sha256sum | single 10MB text | 0.0086s | 0.0079s | **1.1x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0082s | **1.1x** |
| sha256sum | single 100MB text | 0.0744s | 0.0712s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| md5sum | single 100KB text | 0.0015s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0035s | **0.8x** |
| md5sum | single 10MB text | 0.0173s | 0.0201s | **0.9x** |
| md5sum | single 10MB binary | 0.0178s | 0.0208s | **0.9x** |
| md5sum | single 100MB text | 0.1606s | 0.1916s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0009s | **1.4x** |
| md5sum | 100 files | 0.0024s | 0.0019s | **1.3x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0027s | **0.9x** |
| b2sum | single 10MB text | 0.0148s | 0.0117s | **1.3x** |
| b2sum | single 10MB binary | 0.0155s | 0.0122s | **1.3x** |
| b2sum | single 100MB text | 0.1425s | 0.1091s | **1.3x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0116s | **1.3x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0117s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0018s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0030s | **0.7x** |
| base64 | encode 10MB text | 0.0124s | 0.0056s | **2.2x** |
| base64 | encode 10MB binary | 0.0128s | 0.0056s | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0030s | **1.4x** |
| base64 | decode 10MB | 0.0325s | 0.0172s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0055s | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0032s | **2.7x** |
| sort | lexicographic 1MB | 0.0085s | 0.0039s | **2.2x** |
| sort | lexicographic 10MB random | 0.0540s | 0.0173s | **3.1x** |
| sort | already sorted 10MB | 0.0260s | 0.0121s | **2.1x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0121s | **2.3x** |
| sort | -n numeric 10MB | 0.0733s | 0.0383s | **1.9x** |
| sort | -r reverse 10MB | 0.0546s | 0.0173s | **3.2x** |
| sort | -u unique 10MB | 0.0576s | 0.0178s | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0666s | 0.0324s | **2.1x** |
| sort | repetitive 10MB | 0.0549s | 0.0221s | **2.5x** |
| sort | --parallel=4 10MB | 0.0540s | 0.0178s | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0132s | 0.0090s | **1.5x** |
| tr | -d digits 10MB | 0.0180s | 0.0149s | **1.2x** |
| tr | -d lowercase 10MB | 0.0313s | 0.0251s | **1.2x** |
| tr | -s spaces 10MB | 0.0265s | 0.0166s | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0124s | 0.0090s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0170s | 0.0150s | **1.1x** |
| tr | translate binary 10MB | 0.0115s | 0.0087s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0053s | **2.2x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0066s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0052s | **2.3x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0100s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0052s | **2.3x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0052s | **2.3x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0070s | **2.0x** |
| uniq | repetitive 10MB | 0.0420s | 0.0068s | **6.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0024s | **0.8x** |
| tac | reverse 10MB text | 0.0104s | 0.0065s | **1.6x** |
| tac | reverse 100MB text | 0.1029s | 0.0482s | **2.1x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0073s | **1.3x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0121s | **1.9x** |
| tac | custom separator 1MB | 0.0059s | 0.0065s | **0.9x** |
