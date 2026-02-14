# fcoreutils v0.0.38 — Detailed Results

Generated: 2026-02-14 12:39:17 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 411 | 2 | 99.5% |

**Overall: 1230/1239 (99.3%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0010s | **0.9x** |
| wc | default 1MB text | 0.0036s | 0.0024s | **1.5x** |
| wc | default 10MB text | 0.0330s | 0.0059s | **5.6x** |
| wc | default 100MB text | 0.2883s | 0.0407s | **7.1x** |
| wc | -l 10MB text | 0.0033s | 0.0020s | **1.6x** |
| wc | -w 10MB text | 0.0329s | 0.0165s | **2.0x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | **0.8x** |
| wc | -m 10MB text | 0.0328s | 0.0020s | **16.5x** |
| wc | -L 10MB text | 0.0331s | 0.0163s | **2.0x** |
| wc | default 10MB binary | 0.2351s | 0.0586s | **4.0x** |
| wc | default 10MB repetitive | 0.0501s | 0.0065s | **7.8x** |
| wc | 10 files | 0.0007s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0012s | 0.0013s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0178s | 0.0029s | **6.1x** |
| cut | -c1-100 10MB CSV | 0.0179s | 0.0028s | **6.4x** |
| cut | -d, -f1 10MB CSV | 0.0178s | 0.0039s | **4.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0204s | 0.0044s | **4.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0225s | 0.0039s | **5.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0258s | 0.0047s | **5.5x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0010s | 0.0010s | **1.0x** |
| sha256sum | single 1MB text | 0.0015s | 0.0014s | **1.1x** |
| sha256sum | single 10MB text | 0.0064s | 0.0062s | **1.0x** |
| sha256sum | single 10MB binary | 0.0070s | 0.0065s | **1.1x** |
| sha256sum | single 100MB text | 0.0553s | 0.0522s | **1.1x** |
| sha256sum | 10 files | 0.0010s | 0.0014s | **0.7x** |
| sha256sum | 100 files | 0.0017s | 0.0022s | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0011s | **1.1x** |
| md5sum | single 1MB text | 0.0031s | 0.0026s | **1.2x** |
| md5sum | single 10MB text | 0.0197s | 0.0158s | **1.2x** |
| md5sum | single 10MB binary | 0.0208s | 0.0167s | **1.3x** |
| md5sum | single 100MB text | 0.1884s | 0.1492s | **1.3x** |
| md5sum | 10 files | 0.0010s | 0.0015s | **0.7x** |
| md5sum | 100 files | 0.0016s | 0.0022s | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | **1.0x** |
| b2sum | single 10MB text | 0.0129s | 0.0120s | **1.1x** |
| b2sum | single 10MB binary | 0.0140s | 0.0128s | **1.1x** |
| b2sum | single 100MB text | 0.1236s | 0.1117s | **1.1x** |
| b2sum | -l 256 10MB | 0.0128s | 0.0120s | **1.1x** |
| b2sum | -l 128 10MB | 0.0128s | 0.0120s | **1.1x** |
| b2sum | 100 files | 0.0015s | 0.0022s | **0.7x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | **1.0x** |
| base64 | encode 10MB text | 0.0085s | 0.0046s | **1.9x** |
| base64 | encode 10MB binary | 0.0093s | 0.0050s | **1.9x** |
| base64 | decode 1MB | 0.0035s | 0.0021s | **1.7x** |
| base64 | decode 10MB | 0.0292s | 0.0124s | **2.3x** |
| base64 | encode -w 76 10MB | 0.0085s | 0.0045s | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0065s | 0.0041s | **1.6x** |
| sort | lexicographic 1MB | 0.0072s | 0.0029s | **2.5x** |
| sort | lexicographic 10MB random | 0.0484s | 0.0070s | **6.9x** |
| sort | already sorted 10MB | 0.0234s | 0.0050s | **4.7x** |
| sort | reverse sorted 10MB | 0.0237s | 0.0040s | **5.9x** |
| sort | -n numeric 10MB | 0.0667s | 0.0202s | **3.3x** |
| sort | -r reverse 10MB | 0.0501s | 0.0071s | **7.1x** |
| sort | -u unique 10MB | 0.0521s | 0.0106s | **4.9x** |
| sort | -t, -k2 CSV 10MB | 0.0679s | 0.0171s | **4.0x** |
| sort | repetitive 10MB | 0.0412s | 0.0116s | **3.5x** |
| sort | --parallel=4 10MB | 0.0491s | 0.0072s | **6.9x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0018s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0065s | **1.4x** |
| tr | -d digits 10MB | 0.0110s | 0.0095s | **1.2x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0162s | **1.2x** |
| tr | -s spaces 10MB | 0.0167s | 0.0135s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0094s | 0.0064s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0094s | **1.2x** |
| tr | translate binary 10MB | 0.0090s | 0.0065s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0088s | 0.0046s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0159s | 0.0029s | **5.5x** |
| uniq | -c count 10MB many dups | 0.0089s | 0.0060s | **1.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0075s | **3.9x** |
| uniq | -d duplicates only 10MB | 0.0088s | 0.0047s | **1.9x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0046s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0057s | **2.8x** |
| uniq | repetitive 10MB | 0.0455s | 0.0035s | **13.1x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0015s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0076s | 0.0044s | **1.7x** |
| tac | reverse 100MB text | 0.0758s | 0.0379s | **2.0x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0048s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0162s | 0.0094s | **1.7x** |
| tac | custom separator 1MB | 0.0041s | 0.0039s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0059s | 0.0028s | **2.1x** |
| wc | default 10MB text | 0.0542s | 0.0031s | **17.5x** |
| wc | default 100MB text | 0.4819s | 0.0142s | **33.9x** |
| wc | -l 10MB text | 0.0020s | 0.0029s | **0.7x** |
| wc | -w 10MB text | 0.0544s | 0.0197s | **2.8x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0541s | 0.0030s | **18.1x** |
| wc | -L 10MB text | 0.0543s | 0.0231s | **2.4x** |
| wc | default 10MB binary | 0.3159s | 0.0828s | **3.8x** |
| wc | default 10MB repetitive | 0.0728s | 0.0046s | **15.7x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.9x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0041s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0041s | **5.5x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0063s | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0079s | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0072s | **3.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0307s | 0.0087s | **3.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0011s | **1.2x** |
| sha256sum | single 1MB text | 0.0020s | 0.0017s | **1.2x** |
| sha256sum | single 10MB text | 0.0083s | 0.0080s | **1.0x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0084s | **1.0x** |
| sha256sum | single 100MB text | 0.0742s | 0.0715s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0037s | **0.7x** |
| md5sum | single 100KB text | 0.0015s | 0.0013s | **1.2x** |
| md5sum | single 1MB text | 0.0029s | 0.0030s | **1.0x** |
| md5sum | single 10MB text | 0.0170s | 0.0201s | **0.8x** |
| md5sum | single 10MB binary | 0.0177s | 0.0210s | **0.8x** |
| md5sum | single 100MB text | 0.1603s | 0.1910s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0020s | **0.7x** |
| md5sum | 100 files | 0.0024s | 0.0037s | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | **1.1x** |
| b2sum | single 10MB text | 0.0147s | 0.0118s | **1.2x** |
| b2sum | single 10MB binary | 0.0155s | 0.0124s | **1.2x** |
| b2sum | single 100MB text | 0.1416s | 0.1091s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0119s | **1.3x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0118s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0036s | **0.6x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0020s | 0.0017s | **1.2x** |
| base64 | encode 10MB text | 0.0122s | 0.0044s | **2.8x** |
| base64 | encode 10MB binary | 0.0127s | 0.0046s | **2.8x** |
| base64 | decode 1MB | 0.0040s | 0.0020s | **2.0x** |
| base64 | decode 10MB | 0.0323s | 0.0106s | **3.0x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0045s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0035s | **2.5x** |
| sort | lexicographic 1MB | 0.0086s | 0.0040s | **2.1x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0119s | **4.5x** |
| sort | already sorted 10MB | 0.0261s | 0.0070s | **3.7x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0072s | **3.8x** |
| sort | -n numeric 10MB | 0.0732s | 0.0306s | **2.4x** |
| sort | -r reverse 10MB | 0.0544s | 0.0120s | **4.5x** |
| sort | -u unique 10MB | 0.0570s | 0.0130s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0659s | 0.0258s | **2.6x** |
| sort | repetitive 10MB | 0.0545s | 0.0162s | **3.4x** |
| sort | --parallel=4 10MB | 0.0538s | 0.0119s | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0021s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0130s | 0.0076s | **1.7x** |
| tr | -d digits 10MB | 0.0180s | 0.0120s | **1.5x** |
| tr | -d lowercase 10MB | 0.0291s | 0.0212s | **1.4x** |
| tr | -s spaces 10MB | 0.0257s | 0.0143s | **1.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0069s | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0174s | 0.0122s | **1.4x** |
| tr | translate binary 10MB | 0.0124s | 0.0072s | **1.7x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0065s | **1.8x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0037s | **3.8x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0071s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0289s | 0.0098s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0058s | **2.1x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0058s | **2.1x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0073s | **1.9x** |
| uniq | repetitive 10MB | 0.0421s | 0.0057s | **7.4x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0105s | 0.0051s | **2.0x** |
| tac | reverse 100MB text | 0.1029s | 0.0453s | **2.3x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0055s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0108s | **2.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0043s | **1.4x** |
