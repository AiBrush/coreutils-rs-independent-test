# fcoreutils v0.0.9 — Detailed Results

Generated: 2026-02-13 01:41:50 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 400 | 13 | 96.9% |
| Linux_aarch64 | 413 | 401 | 12 | 97.1% |
| Linux_x86_64 | 236 | 21 | 215 | 8.9% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |

**Overall: 822/1062 (77.4%)**

## Performance

### Darwin_arm64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| cut | -b1-100 10MB CSV | 0.0284s | 0.0046s | **6.2x** |
| cut | -c1-100 10MB CSV | 0.0297s | 0.0036s | **8.3x** |
| cut | -d, -f1 10MB CSV | 0.0179s | 0.0054s | **3.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0259s | 0.0066s | **3.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0329s | 0.0128s | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0455s | 0.0073s | **6.2x** |
| cut | -d, -f1 100KB text | 0.0017s | 0.0012s | **1.4x** |
| cut | -d, -f1 1MB text | 0.0023s | 0.0003s | **9.2x** |
| cut | -d: -f1 colon file | N/A | 0.0008s | - |
| sha256sum | single 100KB text | 0.0011s | 0.0001s | **11.3x** |
| sha256sum | single 1MB text | 0.0040s | 0.0055s | **0.7x** |
| sha256sum | single 10MB text | 0.0382s | 0.0337s | **1.1x** |
| sha256sum | single 10MB binary | 0.0403s | 0.0385s | **1.0x** |
| sha256sum | single 100MB text | 0.3581s | 0.3376s | **1.1x** |
| sha256sum | 10 files | 0.0021s | 0.0022s | **0.9x** |
| sha256sum | 100 files | 0.0044s | 0.0049s | **0.9x** |
| md5sum | single 100KB text | 0.0017s | 0.0023s | **0.8x** |
| md5sum | single 1MB text | 0.0039s | 0.0056s | **0.7x** |
| md5sum | single 10MB text | 0.0202s | 0.0209s | **1.0x** |
| md5sum | single 10MB binary | 0.0199s | 0.0193s | **1.0x** |
| md5sum | single 100MB text | 0.1748s | 0.1722s | **1.0x** |
| md5sum | 10 files | 0.0023s | 0.0023s | **1.0x** |
| md5sum | 100 files | 0.0059s | 0.0054s | **1.1x** |
| b2sum | single 100KB text | 0.0026s | 0.0006s | **4.2x** |
| b2sum | single 1MB text | 0.0037s | 0.0027s | **1.4x** |
| b2sum | single 10MB text | 0.0178s | 0.0124s | **1.4x** |
| b2sum | single 10MB binary | 0.0185s | 0.0131s | **1.4x** |
| b2sum | single 100MB text | 0.1615s | 0.1119s | **1.4x** |
| b2sum | -l 256 10MB | 0.0186s | 0.0137s | **1.4x** |
| b2sum | -l 128 10MB | 0.0203s | 0.0342s | **0.6x** |
| b2sum | 100 files | 0.0047s | 0.0034s | **1.4x** |
| base64 | encode 100KB text | 0.0013s | 0.0019s | **0.7x** |
| base64 | encode 1MB text | 0.0033s | 0.0023s | **1.5x** |
| base64 | encode 10MB text | 0.0158s | 0.0062s | **2.6x** |
| base64 | encode 10MB binary | 0.0161s | 0.0084s | **1.9x** |
| base64 | decode 1MB | 0.0048s | 0.0023s | **2.1x** |
| base64 | decode 10MB | 0.0307s | 0.0140s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0154s | 0.0059s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0071s | 0.0046s | **1.6x** |
| sort | lexicographic 1MB | 0.0989s | 0.0043s | **23.1x** |
| sort | lexicographic 10MB random | 0.3966s | 0.0211s | **18.8x** |
| sort | already sorted 10MB | 0.2189s | 0.0111s | **19.8x** |
| sort | reverse sorted 10MB | 0.2001s | 0.0098s | **20.5x** |
| sort | -n numeric 10MB | 0.4086s | 0.0271s | **15.1x** |
| sort | -r reverse 10MB | 0.4007s | 0.0181s | **22.1x** |
| sort | -u unique 10MB | 0.4283s | 0.0157s | **27.2x** |
| sort | -t, -k2 CSV 10MB | 0.5420s | 0.0327s | **16.6x** |
| sort | repetitive 10MB | 0.0545s | 0.0207s | **2.6x** |
| sort | --parallel=4 10MB | 0.3769s | 0.0174s | **21.6x** |
| tr | a-z to A-Z 1MB | 0.0030s | 0.0034s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0099s | **1.3x** |
| tr | -d digits 10MB | 0.0158s | 0.0152s | **1.0x** |
| tr | -d lowercase 10MB | 0.0280s | 0.0245s | **1.1x** |
| tr | -s spaces 10MB | 0.0436s | 0.0293s | **1.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0109s | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0177s | 0.0159s | **1.1x** |
| tr | translate binary 10MB | 0.0145s | 0.0118s | **1.2x** |
| uniq | default 10MB many duplicates | 0.0108s | 0.0062s | **1.7x** |
| uniq | default 10MB sorted (low dup) | 0.0181s | 0.0073s | **2.5x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0071s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0321s | 0.0094s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0110s | 0.0064s | **1.7x** |
| uniq | -u unique only 10MB | 0.0109s | 0.0061s | **1.8x** |
| uniq | -i case insensitive 10MB | 0.0184s | 0.0086s | **2.1x** |
| uniq | repetitive 10MB | 0.0355s | 0.0083s | **4.3x** |
| tac | reverse 100KB text | 0.0019s | 0.0018s | **1.1x** |
| tac | reverse 1MB text | 0.0029s | 0.0021s | **1.4x** |
| tac | reverse 10MB text | 0.0136s | 0.0067s | **2.0x** |
| tac | reverse 100MB text | 0.1257s | 0.0679s | **1.9x** |
| tac | reverse CSV 10MB | 0.0137s | 0.0069s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0263s | 0.0113s | **2.3x** |
| tac | custom separator 1MB | 0.0116s | 0.0057s | **2.0x** |

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0008s | **1.2x** |
| wc | default 1MB text | 0.0037s | 0.0012s | **3.1x** |
| wc | default 10MB text | 0.0342s | 0.0028s | **12.2x** |
| wc | default 100MB text | 0.2912s | 0.0139s | **20.9x** |
| wc | -l 10MB text | 0.0038s | 0.0018s | **2.1x** |
| wc | -w 10MB text | 0.0343s | 0.0025s | **13.6x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0338s | 0.0030s | **11.2x** |
| wc | -L 10MB text | 0.0341s | 0.0153s | **2.2x** |
| wc | default 10MB binary | 0.2343s | 0.0029s | **81.1x** |
| wc | default 10MB repetitive | 0.0499s | 0.0040s | **12.6x** |
| wc | 10 files | 0.0007s | 0.0008s | **0.9x** |
| wc | 100 files | 0.0012s | 0.0013s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0033s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0181s | 0.0035s | **5.1x** |
| cut | -d, -f1 10MB CSV | 0.0184s | 0.0026s | **7.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0042s | **5.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0228s | 0.0043s | **5.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0262s | 0.0055s | **4.7x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0012s | **2.8x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0011s | **1.0x** |
| sha256sum | single 1MB text | 0.0016s | 0.0038s | **0.4x** |
| sha256sum | single 10MB text | 0.0070s | 0.0298s | **0.2x** |
| sha256sum | single 10MB binary | 0.0071s | 0.0312s | **0.2x** |
| sha256sum | single 100MB text | 0.0601s | 0.2891s | **0.2x** |
| sha256sum | 10 files | 0.0011s | 0.0012s | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0017s | **1.0x** |
| md5sum | single 100KB text | 0.0012s | 0.0009s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0023s | **1.2x** |
| md5sum | single 10MB text | 0.0204s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0211s | 0.0164s | **1.3x** |
| md5sum | single 100MB text | 0.1925s | 0.1496s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0011s | **0.9x** |
| md5sum | 100 files | 0.0016s | 0.0016s | **1.0x** |
| b2sum | single 100KB text | 0.0008s | 0.0009s | **0.9x** |
| b2sum | single 1MB text | 0.0020s | 0.0020s | **1.0x** |
| b2sum | single 10MB text | 0.0139s | 0.0134s | **1.0x** |
| b2sum | single 10MB binary | 0.0140s | 0.0139s | **1.0x** |
| b2sum | single 100MB text | 0.1269s | 0.1248s | **1.0x** |
| b2sum | -l 256 10MB | 0.0138s | 0.0133s | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0134s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | **0.9x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0018s | **0.9x** |
| base64 | encode 10MB text | 0.0091s | 0.0074s | **1.2x** |
| base64 | encode 10MB binary | 0.0091s | 0.0075s | **1.2x** |
| base64 | decode 1MB | 0.0036s | 0.0024s | **1.5x** |
| base64 | decode 10MB | 0.0296s | 0.0173s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0094s | 0.0075s | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0053s | **1.3x** |
| sort | lexicographic 1MB | 0.0072s | 0.0039s | **1.8x** |
| sort | lexicographic 10MB random | 0.0499s | 0.0168s | **3.0x** |
| sort | already sorted 10MB | 0.0235s | 0.0081s | **2.9x** |
| sort | reverse sorted 10MB | 0.0236s | 0.0082s | **2.9x** |
| sort | -n numeric 10MB | 0.0675s | 0.0315s | **2.1x** |
| sort | -r reverse 10MB | 0.0506s | 0.0172s | **2.9x** |
| sort | -u unique 10MB | 0.0527s | 0.0194s | **2.7x** |
| sort | -t, -k2 CSV 10MB | 0.0693s | 0.0300s | **2.3x** |
| sort | repetitive 10MB | 0.0420s | 0.0208s | **2.0x** |
| sort | --parallel=4 10MB | 0.0502s | 0.0166s | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0017s | 0.0025s | **0.7x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0114s | **0.8x** |
| tr | -d digits 10MB | 0.0110s | 0.0148s | **0.7x** |
| tr | -d lowercase 10MB | 0.0195s | 0.0253s | **0.8x** |
| tr | -s spaces 10MB | 0.0164s | 0.0262s | **0.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0114s | **0.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0146s | **0.8x** |
| tr | translate binary 10MB | 0.0092s | 0.0124s | **0.7x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0160s | 0.0040s | **4.0x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0287s | 0.0053s | **5.5x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0045s | **2.0x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0160s | 0.0045s | **3.6x** |
| uniq | repetitive 10MB | 0.0458s | 0.0068s | **6.7x** |
| tac | reverse 100KB text | 0.0008s | 0.0009s | **0.9x** |
| tac | reverse 1MB text | 0.0015s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0081s | 0.0051s | **1.6x** |
| tac | reverse 100MB text | 0.0792s | 0.0430s | **1.8x** |
| tac | reverse CSV 10MB | 0.0078s | 0.0047s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0162s | 0.0091s | **1.8x** |
| tac | custom separator 1MB | 0.0041s | 0.0039s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | N/A | - | - |
| wc | default 1MB text | N/A | - | - |
| wc | default 10MB text | N/A | - | - |
| wc | default 100MB text | N/A | - | - |
| wc | -l 10MB text | N/A | - | - |
| wc | -w 10MB text | N/A | - | - |
| wc | -c 10MB text | N/A | - | - |
| wc | -m 10MB text | N/A | - | - |
| wc | -L 10MB text | N/A | - | - |
| wc | default 10MB binary | N/A | - | - |
| wc | default 10MB repetitive | N/A | - | - |
| wc | 10 files | N/A | - | - |
| wc | 100 files | N/A | - | - |
| cut | -b1-100 10MB CSV | N/A | - | - |
| cut | -c1-100 10MB CSV | N/A | - | - |
| cut | -d, -f1 10MB CSV | N/A | - | - |
| cut | -d, -f1,3,5 10MB CSV | N/A | - | - |
| cut | -d, -f2-4 10MB CSV | N/A | - | - |
| cut | --complement -d, -f1 10MB CSV | N/A | - | - |
| cut | -d, -f1 100KB text | N/A | - | - |
| cut | -d, -f1 1MB text | N/A | - | - |
| cut | -d: -f1 colon file | N/A | - | - |
| sha256sum | single 100KB text | N/A | - | - |
| sha256sum | single 1MB text | N/A | - | - |
| sha256sum | single 10MB text | N/A | - | - |
| sha256sum | single 10MB binary | N/A | - | - |
| sha256sum | single 100MB text | N/A | - | - |
| sha256sum | 10 files | N/A | - | - |
| sha256sum | 100 files | N/A | - | - |
| md5sum | single 100KB text | N/A | - | - |
| md5sum | single 1MB text | N/A | - | - |
| md5sum | single 10MB text | N/A | - | - |
| md5sum | single 10MB binary | N/A | - | - |
| md5sum | single 100MB text | N/A | - | - |
| md5sum | 10 files | N/A | - | - |
| md5sum | 100 files | N/A | - | - |
| b2sum | single 100KB text | N/A | - | - |
| b2sum | single 1MB text | N/A | - | - |
| b2sum | single 10MB text | N/A | - | - |
| b2sum | single 10MB binary | N/A | - | - |
| b2sum | single 100MB text | N/A | - | - |
| b2sum | -l 256 10MB | N/A | - | - |
| b2sum | -l 128 10MB | N/A | - | - |
| b2sum | 100 files | N/A | - | - |
| base64 | encode 100KB text | N/A | - | - |
| base64 | encode 1MB text | N/A | - | - |
| base64 | encode 10MB text | N/A | - | - |
| base64 | encode 10MB binary | N/A | - | - |
| base64 | decode 1MB | N/A | - | - |
| base64 | decode 10MB | N/A | - | - |
| base64 | encode -w 76 10MB | N/A | - | - |
| base64 | encode -w 0 (no wrap) 10MB | N/A | - | - |
| sort | lexicographic 1MB | N/A | - | - |
| sort | lexicographic 10MB random | N/A | - | - |
| sort | already sorted 10MB | N/A | - | - |
| sort | reverse sorted 10MB | N/A | - | - |
| sort | -n numeric 10MB | N/A | - | - |
| sort | -r reverse 10MB | N/A | - | - |
| sort | -u unique 10MB | N/A | - | - |
| sort | -t, -k2 CSV 10MB | N/A | - | - |
| sort | repetitive 10MB | N/A | - | - |
| sort | --parallel=4 10MB | N/A | - | - |
| tr | a-z to A-Z 1MB | N/A | - | - |
| tr | a-z to A-Z 10MB | N/A | - | - |
| tr | -d digits 10MB | N/A | - | - |
| tr | -d lowercase 10MB | N/A | - | - |
| tr | -s spaces 10MB | N/A | - | - |
| tr | [:lower:] to [:upper:] 10MB | N/A | - | - |
| tr | -d [:digit:] 10MB CSV | N/A | - | - |
| tr | translate binary 10MB | N/A | - | - |
| uniq | default 10MB many duplicates | N/A | - | - |
| uniq | default 10MB sorted (low dup) | N/A | - | - |
| uniq | -c count 10MB many dups | N/A | - | - |
| uniq | -c count 10MB sorted | N/A | - | - |
| uniq | -d duplicates only 10MB | N/A | - | - |
| uniq | -u unique only 10MB | N/A | - | - |
| uniq | -i case insensitive 10MB | N/A | - | - |
| uniq | repetitive 10MB | N/A | - | - |
| tac | reverse 100KB text | N/A | - | - |
| tac | reverse 1MB text | N/A | - | - |
| tac | reverse 10MB text | N/A | - | - |
| tac | reverse 100MB text | N/A | - | - |
| tac | reverse CSV 10MB | N/A | - | - |
| tac | reverse repetitive 10MB | N/A | - | - |
| tac | custom separator 1MB | N/A | - | - |
