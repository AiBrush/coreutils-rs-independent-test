# fcoreutils v0.4.3 — Detailed Results

Generated: 2026-02-18 22:30:44 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0013s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0063s | 0.0255s | **5.4x** | **4.0x** |
| wc | default 100MB text | 0.3003s | 0.0427s | 0.2280s | **7.0x** | **5.3x** |
| wc | -l 10MB text | 0.0041s | 0.0020s | 0.0024s | **2.1x** | **1.2x** |
| wc | -w 10MB text | 0.0343s | 0.0061s | 0.0232s | **5.6x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0344s | 0.0021s | 0.0025s | **16.6x** | **1.2x** |
| wc | -L 10MB text | 0.0343s | 0.0063s | 0.0175s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2349s | 0.0168s | 0.1178s | **14.0x** | **7.0x** |
| wc | default 10MB repetitive | 0.0526s | 0.0078s | 0.0371s | **6.8x** | **4.8x** |
| wc | 10 files | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0037s | 0.0063s | **5.0x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0037s | 0.0060s | **4.9x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0031s | 0.0072s | **6.0x** | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0053s | 0.0163s | **4.1x** | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0035s | 0.0126s | **6.7x** | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0046s | 0.0162s | **5.7x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0012s | 0.0009s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0015s | 0.0017s | **2.3x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.8x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0026s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0074s | 0.0083s | 0.0273s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0086s | 0.0284s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0697s | 0.0558s | 0.2636s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0013s | 0.0011s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0019s | 0.0016s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0034s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0210s | 0.0175s | 0.0175s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0181s | 0.0182s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2016s | 0.1442s | 0.1671s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0012s | 0.0011s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0015s | 0.0018s | 0.0015s | **0.9x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0140s | 0.0135s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0144s | 0.0143s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1366s | 0.1172s | 0.1301s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0138s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0140s | 0.0138s | 0.0135s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0016s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0094s | 0.0033s | 0.0071s | **2.8x** | **2.1x** |
| base64 | encode 10MB binary | 0.0099s | 0.0035s | 0.0074s | **2.9x** | **2.1x** |
| base64 | decode 1MB | 0.0037s | 0.0014s | 0.0035s | **2.6x** | **2.4x** |
| base64 | decode 10MB | 0.0307s | 0.0037s | 0.0268s | **8.2x** | **7.2x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0036s | 0.0072s | **2.6x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0076s | 0.0026s | 0.0072s | **2.9x** | **2.7x** |
| sort | lexicographic 1MB | 0.0075s | 0.0026s | 0.0044s | **2.9x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0514s | 0.0064s | 0.0286s | **8.0x** | **4.5x** |
| sort | already sorted 10MB | 0.0247s | 0.0035s | 0.0135s | **7.1x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0249s | 0.0042s | 0.0137s | **5.9x** | **3.2x** |
| sort | -n numeric 10MB | 0.0690s | 0.0038s | 0.0606s | **18.1x** | **15.9x** |
| sort | -r reverse 10MB | 0.0519s | 0.0063s | 0.0287s | **8.2x** | **4.6x** |
| sort | -u unique 10MB | 0.0541s | 0.0081s | 0.0356s | **6.7x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0702s | 0.0156s | 0.0693s | **4.5x** | **4.5x** |
| sort | repetitive 10MB | 0.0465s | 0.0100s | 0.0372s | **4.7x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0508s | 0.0062s | 0.0289s | **8.1x** | **4.6x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0018s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0038s | 0.0067s | **2.3x** | **1.8x** |
| tr | -d digits 10MB | 0.0111s | 0.0052s | 0.0103s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0067s | 0.0173s | **2.8x** | **2.6x** |
| tr | -s spaces 10MB | 0.0166s | 0.0038s | 0.0114s | **4.4x** | **3.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0086s | 0.0039s | 0.0069s | **2.2x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0109s | 0.0051s | 0.0103s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0094s | 0.0040s | 0.0077s | **2.4x** | **1.9x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0165s | 0.0030s | 0.0096s | **5.5x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0033s | 0.0089s | **2.9x** | **2.7x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0069s | 0.0113s | **4.3x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0026s | 0.0087s | **3.5x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0027s | 0.0089s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0039s | 0.0094s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0486s | 0.0037s | 0.0153s | **13.1x** | **4.1x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0016s | 0.0014s | 0.0019s | **1.1x** | **1.3x** |
| tac | reverse 10MB text | 0.0087s | 0.0028s | 0.0050s | **3.1x** | **1.8x** |
| tac | reverse 100MB text | 0.0864s | 0.0157s | 0.0445s | **5.5x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0025s | 0.0045s | **3.2x** | **1.8x** |
| tac | reverse repetitive 10MB | 0.0186s | 0.0039s | 0.0090s | **4.7x** | **2.3x** |
| tac | custom separator 1MB | 0.0044s | 0.0032s | 0.0038s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0038s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0543s | 0.0025s | 0.0298s | **21.5x** | **11.8x** |
| wc | default 100MB text | 0.4829s | 0.0095s | 0.2542s | **50.9x** | **26.8x** |
| wc | -l 10MB text | 0.0022s | 0.0026s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0546s | 0.0089s | 0.0261s | **6.2x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0549s | 0.0026s | 0.0021s | **21.0x** | **0.8x** |
| wc | -L 10MB text | 0.0548s | 0.0094s | 0.0203s | **5.8x** | **2.2x** |
| wc | default 10MB binary | 0.3178s | 0.0270s | 0.1542s | **11.8x** | **5.7x** |
| wc | default 10MB repetitive | 0.0736s | 0.0040s | 0.0399s | **18.6x** | **10.1x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0039s | 0.0073s | **5.8x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0039s | 0.0079s | **5.7x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0034s | 0.0086s | **5.0x** | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0065s | 0.0175s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0046s | 0.0134s | **5.2x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0054s | 0.0166s | **5.6x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0015s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0099s | 0.0084s | **0.9x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0102s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0751s | 0.0754s | 0.0755s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0172s | 0.0179s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0186s | 0.0223s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1608s | 0.1535s | 0.2027s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **0.9x** | **1.0x** |
| md5sum | 100 files | 0.0023s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0126s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0129s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1427s | 0.1117s | 0.1127s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0125s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0126s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0013s | 0.0018s | **1.5x** | **1.4x** |
| base64 | encode 10MB text | 0.0122s | 0.0038s | 0.0080s | **3.2x** | **2.1x** |
| base64 | encode 10MB binary | 0.0133s | 0.0039s | 0.0084s | **3.4x** | **2.2x** |
| base64 | decode 1MB | 0.0040s | 0.0013s | 0.0043s | **3.0x** | **3.3x** |
| base64 | decode 10MB | 0.0326s | 0.0040s | 0.0338s | **8.2x** | **8.5x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0039s | 0.0082s | **3.1x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0032s | 0.0072s | **2.7x** | **2.2x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0544s | 0.0096s | 0.0355s | **5.7x** | **3.7x** |
| sort | already sorted 10MB | 0.0261s | 0.0045s | 0.0181s | **5.8x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0270s | 0.0065s | 0.0179s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0735s | 0.0057s | 0.0748s | **12.9x** | **13.1x** |
| sort | -r reverse 10MB | 0.0547s | 0.0096s | 0.0360s | **5.7x** | **3.8x** |
| sort | -u unique 10MB | 0.0585s | 0.0101s | 0.0399s | **5.8x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0672s | 0.0214s | 0.0867s | **3.1x** | **4.1x** |
| sort | repetitive 10MB | 0.0559s | 0.0121s | 0.0380s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0548s | 0.0099s | 0.0365s | **5.5x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.4x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0040s | 0.0076s | **3.2x** | **1.9x** |
| tr | -d digits 10MB | 0.0167s | 0.0042s | 0.0143s | **3.9x** | **3.4x** |
| tr | -d lowercase 10MB | 0.0284s | 0.0050s | 0.0225s | **5.7x** | **4.5x** |
| tr | -s spaces 10MB | 0.0266s | 0.0036s | 0.0270s | **7.3x** | **7.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0130s | 0.0039s | 0.0074s | **3.3x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0176s | 0.0043s | 0.0143s | **4.2x** | **3.4x** |
| tr | translate binary 10MB | 0.0116s | 0.0039s | 0.0082s | **3.0x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0036s | 0.0112s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0036s | 0.0134s | **3.9x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0092s | 0.0158s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0036s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0036s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0052s | 0.0135s | **2.7x** | **2.6x** |
| uniq | repetitive 10MB | 0.0422s | 0.0042s | 0.0163s | **10.0x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0036s | 0.0058s | **2.9x** | **1.6x** |
| tac | reverse 100MB text | 0.1037s | 0.0194s | 0.0521s | **5.3x** | **2.7x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0032s | 0.0057s | **3.0x** | **1.8x** |
| tac | reverse repetitive 10MB | 0.0231s | 0.0051s | 0.0112s | **4.5x** | **2.2x** |
| tac | custom separator 1MB | 0.0060s | 0.0035s | 0.0053s | **1.7x** | **1.5x** |
