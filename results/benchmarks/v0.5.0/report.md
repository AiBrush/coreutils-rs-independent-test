# fcoreutils v0.5.0 — Detailed Results

Generated: 2026-02-15 22:32:53 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 410 | 3 | 99.3% |
| Linux_x86_64 | 413 | 410 | 3 | 99.3% |

**Overall: 820/826 (99.3%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0343s | 0.0064s | 0.0256s | **5.3x** | **4.0x** |
| wc | default 100MB text | 0.2997s | 0.0439s | 0.2276s | **6.8x** | **5.2x** |
| wc | -l 10MB text | 0.0040s | 0.0020s | 0.0023s | **2.0x** | **1.2x** |
| wc | -w 10MB text | 0.0343s | 0.0060s | 0.0231s | **5.7x** | **3.8x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0339s | 0.0022s | 0.0027s | **15.4x** | **1.2x** |
| wc | -L 10MB text | 0.0342s | 0.0064s | 0.0173s | **5.3x** | **2.7x** |
| wc | default 10MB binary | 0.2355s | 0.0169s | 0.1179s | **13.9x** | **7.0x** |
| wc | default 10MB repetitive | 0.0551s | 0.0081s | 0.0373s | **6.8x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0011s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0012s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0034s | 0.0063s | **5.5x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0033s | 0.0061s | **5.7x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0029s | 0.0071s | **6.4x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0050s | 0.0161s | **4.3x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0033s | 0.0127s | **7.1x** | **3.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0045s | 0.0162s | **5.9x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0014s | 0.0018s | **2.4x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0011s | 0.0022s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0073s | 0.0084s | 0.0273s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0078s | 0.0086s | 0.0286s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0689s | 0.0493s | 0.2628s | **1.4x** | **5.3x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0017s | 0.0021s | 0.0016s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0208s | 0.0175s | 0.0173s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0183s | 0.0184s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2007s | 0.1368s | 0.1661s | **1.5x** | **1.2x** |
| md5sum | 10 files | 0.0014s | 0.0019s | 0.0011s | **0.7x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0020s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0140s | 0.0135s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0148s | 0.0144s | 0.0144s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1355s | 0.1168s | 0.1296s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0139s | 0.0134s | 0.0135s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0136s | 0.0133s | 0.0133s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0094s | 0.0037s | 0.0069s | **2.5x** | **1.9x** |
| base64 | encode 10MB binary | 0.0098s | 0.0034s | 0.0074s | **2.9x** | **2.2x** |
| base64 | decode 1MB | 0.0037s | 0.0015s | 0.0035s | **2.5x** | **2.4x** |
| base64 | decode 10MB | 0.0304s | 0.0040s | 0.0269s | **7.6x** | **6.7x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0035s | 0.0072s | **2.7x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0028s | 0.0071s | **2.6x** | **2.5x** |
| sort | lexicographic 1MB | 0.0075s | 0.0031s | 0.0040s | **2.4x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0518s | 0.0095s | 0.0290s | **5.4x** | **3.1x** |
| sort | already sorted 10MB | 0.0249s | 0.0035s | 0.0133s | **7.1x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0247s | 0.0048s | 0.0139s | **5.1x** | **2.9x** |
| sort | -n numeric 10MB | 0.0689s | 0.0038s | 0.0610s | **18.0x** | **16.0x** |
| sort | -r reverse 10MB | 0.0519s | 0.0091s | 0.0290s | **5.7x** | **3.2x** |
| sort | -u unique 10MB | 0.0546s | 0.0103s | 0.0350s | **5.3x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0703s | 0.0144s | 0.0704s | **4.9x** | **4.9x** |
| sort | repetitive 10MB | 0.0478s | 0.0104s | 0.0360s | **4.6x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0514s | 0.0095s | 0.0288s | **5.4x** | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0018s | 0.0017s | **1.0x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0074s | 0.0069s | **1.2x** | **0.9x** |
| tr | -d digits 10MB | 0.0111s | 0.0069s | 0.0102s | **1.6x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0088s | 0.0168s | **2.2x** | **1.9x** |
| tr | -s spaces 10MB | 0.0167s | 0.0073s | 0.0115s | **2.3x** | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0075s | 0.0073s | **1.2x** | **1.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0067s | 0.0102s | **1.7x** | **1.5x** |
| tr | translate binary 10MB | 0.0093s | 0.0074s | 0.0077s | **1.3x** | **1.0x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0033s | 0.0088s | **2.8x** | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0167s | 0.0027s | 0.0098s | **6.2x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0029s | 0.0092s | **3.2x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0067s | 0.0115s | **4.4x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0028s | 0.0088s | **3.3x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0029s | 0.0088s | **3.2x** | **3.0x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0040s | 0.0097s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0488s | 0.0036s | 0.0155s | **13.7x** | **4.3x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| tac | reverse 10MB text | 0.0086s | 0.0037s | 0.0050s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.0856s | 0.0233s | 0.0434s | **3.7x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0038s | 0.0047s | **2.2x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0194s | 0.0075s | 0.0091s | **2.6x** | **1.2x** |
| tac | custom separator 1MB | 0.0045s | 0.0036s | 0.0040s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0029s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0548s | 0.0032s | 0.0304s | **17.3x** | **9.6x** |
| wc | default 100MB text | 0.4841s | 0.0153s | 0.2550s | **31.6x** | **16.7x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0549s | 0.0088s | 0.0260s | **6.2x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0549s | 0.0030s | 0.0020s | **18.2x** | **0.7x** |
| wc | -L 10MB text | 0.0548s | 0.0111s | 0.0202s | **4.9x** | **1.8x** |
| wc | default 10MB binary | 0.3178s | 0.0272s | 0.1543s | **11.7x** | **5.7x** |
| wc | default 10MB repetitive | 0.0732s | 0.0046s | 0.0400s | **15.9x** | **8.7x** |
| wc | 10 files | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0230s | 0.0036s | 0.0077s | **6.4x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0036s | 0.0076s | **6.4x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0037s | 0.0087s | **4.5x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0066s | 0.0178s | **3.3x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0047s | 0.0137s | **5.1x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0051s | 0.0167s | **6.1x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0087s | 0.0103s | 0.0086s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0091s | 0.0106s | 0.0089s | **0.9x** | **0.8x** |
| sha256sum | single 100MB text | 0.0762s | 0.0665s | 0.0759s | **1.1x** | **1.1x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.7x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0025s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0176s | 0.0182s | 0.0218s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0183s | 0.0190s | 0.0227s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1617s | 0.1443s | 0.2040s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0151s | 0.0128s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0161s | 0.0134s | 0.0133s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1438s | 0.1112s | 0.1138s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0156s | 0.0131s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0126s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0013s | 0.0018s | **1.5x** | **1.4x** |
| base64 | encode 10MB text | 0.0126s | 0.0043s | 0.0085s | **3.0x** | **2.0x** |
| base64 | encode 10MB binary | 0.0133s | 0.0042s | 0.0090s | **3.1x** | **2.1x** |
| base64 | decode 1MB | 0.0041s | 0.0014s | 0.0045s | **3.0x** | **3.3x** |
| base64 | decode 10MB | 0.0325s | 0.0048s | 0.0345s | **6.8x** | **7.2x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0042s | 0.0084s | **3.0x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0037s | 0.0077s | **2.4x** | **2.1x** |
| sort | lexicographic 1MB | 0.0086s | 0.0034s | 0.0056s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0548s | 0.0092s | 0.0363s | **6.0x** | **3.9x** |
| sort | already sorted 10MB | 0.0263s | 0.0048s | 0.0179s | **5.5x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0064s | 0.0185s | **4.3x** | **2.9x** |
| sort | -n numeric 10MB | 0.0741s | 0.0054s | 0.0778s | **13.6x** | **14.3x** |
| sort | -r reverse 10MB | 0.0548s | 0.0098s | 0.0365s | **5.6x** | **3.7x** |
| sort | -u unique 10MB | 0.0584s | 0.0097s | 0.0402s | **6.0x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0673s | 0.0206s | 0.0832s | **3.3x** | **4.0x** |
| sort | repetitive 10MB | 0.0548s | 0.0127s | 0.0368s | **4.3x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0548s | 0.0096s | 0.0360s | **5.7x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0021s | 0.0020s | **1.1x** | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0107s | 0.0074s | **1.2x** | **0.7x** |
| tr | -d digits 10MB | 0.0172s | 0.0091s | 0.0140s | **1.9x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0295s | 0.0118s | 0.0226s | **2.5x** | **1.9x** |
| tr | -s spaces 10MB | 0.0272s | 0.0094s | 0.0271s | **2.9x** | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0174s | 0.0107s | 0.0073s | **1.6x** | **0.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0173s | 0.0096s | 0.0141s | **1.8x** | **1.5x** |
| tr | translate binary 10MB | 0.0121s | 0.0110s | 0.0083s | **1.1x** | **0.8x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0036s | 0.0112s | **3.4x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0031s | 0.0136s | **4.6x** | **4.4x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0036s | 0.0115s | **3.3x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0077s | 0.0159s | **3.8x** | **2.1x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0034s | 0.0117s | **3.6x** | **3.5x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0035s | 0.0120s | **3.5x** | **3.4x** |
| uniq | -i case insensitive 10MB | 0.0144s | 0.0049s | 0.0140s | **3.0x** | **2.9x** |
| uniq | repetitive 10MB | 0.0424s | 0.0041s | 0.0167s | **10.3x** | **4.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0108s | 0.0044s | 0.0059s | **2.5x** | **1.4x** |
| tac | reverse 100MB text | 0.1040s | 0.0288s | 0.0530s | **3.6x** | **1.8x** |
| tac | reverse CSV 10MB | 0.0097s | 0.0044s | 0.0057s | **2.2x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0236s | 0.0086s | 0.0110s | **2.8x** | **1.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | 0.0053s | **1.4x** | **1.3x** |
