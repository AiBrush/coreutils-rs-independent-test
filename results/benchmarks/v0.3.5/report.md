# fcoreutils v0.3.5 — Detailed Results

Generated: 2026-02-16 21:45:21 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 826/826 (100.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0343s | 0.0065s | 0.0256s | **5.3x** | **3.9x** |
| wc | default 100MB text | 0.2982s | 0.0415s | 0.2262s | **7.2x** | **5.4x** |
| wc | -l 10MB text | 0.0041s | 0.0020s | 0.0025s | **2.0x** | **1.2x** |
| wc | -w 10MB text | 0.0341s | 0.0063s | 0.0231s | **5.4x** | **3.6x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0343s | 0.0021s | 0.0025s | **16.5x** | **1.2x** |
| wc | -L 10MB text | 0.0344s | 0.0060s | 0.0175s | **5.7x** | **2.9x** |
| wc | default 10MB binary | 0.2342s | 0.0173s | 0.1174s | **13.5x** | **6.8x** |
| wc | default 10MB repetitive | 0.0541s | 0.0076s | 0.0376s | **7.1x** | **4.9x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0017s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0039s | 0.0062s | **4.9x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0038s | 0.0065s | **4.9x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0031s | 0.0073s | **6.2x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0050s | 0.0162s | **4.3x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0036s | 0.0126s | **6.5x** | **3.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0046s | 0.0162s | **5.7x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0015s | 0.0017s | **2.3x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0075s | 0.0085s | 0.0274s | **0.9x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0074s | 0.0083s | 0.0282s | **0.9x** | **3.4x** |
| sha256sum | single 100MB text | 0.0685s | 0.0555s | 0.2615s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0012s | 0.0010s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0018s | 0.0019s | 0.0017s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0211s | 0.0175s | 0.0173s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0215s | 0.0178s | 0.0177s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1995s | 0.1430s | 0.1650s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0012s | 0.0011s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0017s | 0.0020s | 0.0017s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0140s | 0.0138s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0142s | 0.0141s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1344s | 0.1160s | 0.1283s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0138s | 0.0137s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0139s | 0.0135s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0095s | 0.0035s | 0.0071s | **2.7x** | **2.0x** |
| base64 | encode 10MB binary | 0.0098s | 0.0032s | 0.0072s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0037s | 0.0015s | 0.0035s | **2.5x** | **2.3x** |
| base64 | decode 10MB | 0.0304s | 0.0032s | 0.0263s | **9.4x** | **8.1x** |
| base64 | encode -w 76 10MB | 0.0092s | 0.0034s | 0.0071s | **2.7x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0070s | 0.0025s | 0.0070s | **2.8x** | **2.7x** |
| sort | lexicographic 1MB | 0.0076s | 0.0026s | 0.0041s | **2.9x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0509s | 0.0062s | 0.0284s | **8.2x** | **4.6x** |
| sort | already sorted 10MB | 0.0248s | 0.0033s | 0.0136s | **7.6x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0044s | 0.0138s | **5.5x** | **3.1x** |
| sort | -n numeric 10MB | 0.0694s | 0.0037s | 0.0610s | **18.7x** | **16.4x** |
| sort | -r reverse 10MB | 0.0518s | 0.0062s | 0.0290s | **8.3x** | **4.7x** |
| sort | -u unique 10MB | 0.0541s | 0.0079s | 0.0348s | **6.8x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0706s | 0.0139s | 0.0680s | **5.1x** | **4.9x** |
| sort | repetitive 10MB | 0.0468s | 0.0101s | 0.0370s | **4.6x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0513s | 0.0064s | 0.0285s | **8.1x** | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | 0.0017s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0086s | 0.0053s | 0.0069s | **1.6x** | **1.3x** |
| tr | -d digits 10MB | 0.0112s | 0.0066s | 0.0102s | **1.7x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0086s | 0.0171s | **2.2x** | **2.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0050s | 0.0115s | **3.3x** | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0092s | 0.0054s | 0.0069s | **1.7x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0068s | 0.0103s | **1.7x** | **1.5x** |
| tr | translate binary 10MB | 0.0094s | 0.0056s | 0.0080s | **1.7x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0027s | 0.0088s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0165s | 0.0028s | 0.0098s | **5.9x** | **3.5x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0030s | 0.0087s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0069s | 0.0114s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0088s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0040s | 0.0096s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0486s | 0.0034s | 0.0151s | **14.2x** | **4.4x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0085s | 0.0030s | 0.0050s | **2.8x** | **1.7x** |
| tac | reverse 100MB text | 0.0838s | 0.0148s | 0.0428s | **5.6x** | **2.9x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0024s | 0.0045s | **3.3x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0186s | 0.0040s | 0.0089s | **4.6x** | **2.2x** |
| tac | custom separator 1MB | 0.0043s | 0.0031s | 0.0038s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0038s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0547s | 0.0027s | 0.0300s | **20.3x** | **11.1x** |
| wc | default 100MB text | 0.4828s | 0.0095s | 0.2531s | **50.7x** | **26.6x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0086s | 0.0256s | **6.3x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0541s | 0.0024s | 0.0020s | **22.5x** | **0.8x** |
| wc | -L 10MB text | 0.0543s | 0.0093s | 0.0199s | **5.9x** | **2.1x** |
| wc | default 10MB binary | 0.3234s | 0.0266s | 0.1542s | **12.2x** | **5.8x** |
| wc | default 10MB repetitive | 0.0728s | 0.0034s | 0.0393s | **21.5x** | **11.6x** |
| wc | 10 files | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0039s | 0.0072s | **5.7x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0038s | 0.0072s | **5.9x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0033s | 0.0085s | **4.9x** | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0064s | 0.0173s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0046s | 0.0134s | **5.2x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0055s | 0.0162s | **5.5x** | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0083s | 0.0096s | 0.0084s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0104s | 0.0088s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0748s | 0.0753s | 0.0743s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0023s | **1.0x** | **1.0x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0179s | 0.0212s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0185s | 0.0224s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1606s | 0.1531s | 0.2026s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0014s | 0.0014s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0023s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.2x** |
| b2sum | single 10MB text | 0.0147s | 0.0124s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0129s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1424s | 0.1115s | 0.1122s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0122s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0124s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0014s | 0.0018s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0122s | 0.0040s | 0.0080s | **3.0x** | **2.0x** |
| base64 | encode 10MB binary | 0.0129s | 0.0041s | 0.0085s | **3.1x** | **2.0x** |
| base64 | decode 1MB | 0.0040s | 0.0013s | 0.0043s | **3.0x** | **3.2x** |
| base64 | decode 10MB | 0.0324s | 0.0040s | 0.0337s | **8.2x** | **8.5x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0043s | 0.0081s | **2.8x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0030s | 0.0072s | **2.8x** | **2.4x** |
| sort | lexicographic 1MB | 0.0085s | 0.0033s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0096s | 0.0353s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0261s | 0.0041s | 0.0174s | **6.3x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0064s | 0.0175s | **4.2x** | **2.7x** |
| sort | -n numeric 10MB | 0.0735s | 0.0056s | 0.0743s | **13.1x** | **13.3x** |
| sort | -r reverse 10MB | 0.0600s | 0.0096s | 0.0358s | **6.2x** | **3.7x** |
| sort | -u unique 10MB | 0.0574s | 0.0098s | 0.0393s | **5.9x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0666s | 0.0187s | 0.0810s | **3.6x** | **4.3x** |
| sort | repetitive 10MB | 0.0552s | 0.0117s | 0.0364s | **4.7x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0540s | 0.0097s | 0.0357s | **5.6x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0057s | 0.0077s | **2.2x** | **1.4x** |
| tr | -d digits 10MB | 0.0158s | 0.0055s | 0.0140s | **2.9x** | **2.6x** |
| tr | -d lowercase 10MB | 0.0313s | 0.0068s | 0.0227s | **4.6x** | **3.3x** |
| tr | -s spaces 10MB | 0.0286s | 0.0043s | 0.0270s | **6.6x** | **6.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0124s | 0.0057s | 0.0073s | **2.2x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0173s | 0.0055s | 0.0143s | **3.2x** | **2.6x** |
| tr | translate binary 10MB | 0.0119s | 0.0062s | 0.0082s | **1.9x** | **1.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0138s | 0.0043s | 0.0133s | **3.2x** | **3.1x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0113s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0090s | 0.0158s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0044s | 0.0133s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0417s | 0.0042s | 0.0160s | **10.0x** | **3.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0034s | 0.0058s | **3.0x** | **1.7x** |
| tac | reverse 100MB text | 0.1033s | 0.0193s | 0.0529s | **5.4x** | **2.7x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0031s | 0.0058s | **3.0x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0236s | 0.0053s | 0.0114s | **4.4x** | **2.1x** |
| tac | custom separator 1MB | 0.0061s | 0.0036s | 0.0055s | **1.7x** | **1.5x** |
