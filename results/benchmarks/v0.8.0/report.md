# fcoreutils v0.8.0 — Detailed Results

Generated: 2026-02-17 04:11:24 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.2x** |
| wc | default 1MB text | 0.0037s | 0.0024s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0337s | 0.0063s | 0.0249s | **5.4x** | **4.0x** |
| wc | default 100MB text | 0.2976s | 0.0429s | 0.2258s | **6.9x** | **5.3x** |
| wc | -l 10MB text | 0.0037s | 0.0020s | 0.0020s | **1.9x** | **1.0x** |
| wc | -w 10MB text | 0.0337s | 0.0060s | 0.0227s | **5.6x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0337s | 0.0021s | 0.0022s | **15.8x** | **1.0x** |
| wc | -L 10MB text | 0.0337s | 0.0057s | 0.0171s | **5.9x** | **3.0x** |
| wc | default 10MB binary | 0.2360s | 0.0174s | 0.1172s | **13.6x** | **6.8x** |
| wc | default 10MB repetitive | 0.0513s | 0.0076s | 0.0363s | **6.7x** | **4.8x** |
| wc | 10 files | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0035s | 0.0058s | **5.2x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0179s | 0.0034s | 0.0056s | **5.3x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0093s | 0.0066s | **2.0x** | **0.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0206s | 0.0113s | 0.0159s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0226s | 0.0093s | 0.0121s | **2.4x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0260s | 0.0096s | 0.0157s | **2.7x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | 0.0016s | **1.3x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0022s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0016s | 0.0027s | 0.0035s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0069s | 0.0080s | 0.0266s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0069s | 0.0082s | 0.0277s | **0.9x** | **3.4x** |
| sha256sum | single 100MB text | 0.0659s | 0.0653s | 0.2613s | **1.0x** | **4.0x** |
| sha256sum | 10 files | 0.0010s | 0.0015s | 0.0010s | **0.7x** | **0.7x** |
| sha256sum | 100 files | 0.0016s | 0.0019s | 0.0016s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0033s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0202s | 0.0168s | 0.0167s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0213s | 0.0173s | 0.0172s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1993s | 0.1420s | 0.1642s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0010s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0022s | 0.0017s | **0.7x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0021s | **1.0x** | **1.0x** |
| b2sum | single 10MB text | 0.0131s | 0.0129s | 0.0129s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0141s | 0.0135s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1335s | 0.1129s | 0.1261s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0132s | 0.0130s | 0.0131s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0131s | 0.0128s | 0.0128s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0015s | 0.0016s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0011s | 0.0009s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0015s | 0.0014s | 0.0014s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0089s | 0.0031s | 0.0066s | **2.8x** | **2.1x** |
| base64 | encode 10MB binary | 0.0094s | 0.0032s | 0.0070s | **2.9x** | **2.2x** |
| base64 | decode 1MB | 0.0036s | 0.0016s | 0.0033s | **2.2x** | **2.1x** |
| base64 | decode 10MB | 0.0297s | 0.0040s | 0.0260s | **7.5x** | **6.6x** |
| base64 | encode -w 76 10MB | 0.0090s | 0.0033s | 0.0066s | **2.7x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0071s | 0.0033s | 0.0069s | **2.1x** | **2.1x** |
| sort | lexicographic 1MB | 0.0073s | 0.0030s | 0.0039s | **2.5x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0502s | 0.0080s | 0.0272s | **6.2x** | **3.4x** |
| sort | already sorted 10MB | 0.0243s | 0.0034s | 0.0130s | **7.2x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0239s | 0.0047s | 0.0135s | **5.1x** | **2.9x** |
| sort | -n numeric 10MB | 0.0675s | 0.0034s | 0.0558s | **19.7x** | **16.3x** |
| sort | -r reverse 10MB | 0.0504s | 0.0081s | 0.0272s | **6.3x** | **3.4x** |
| sort | -u unique 10MB | 0.0527s | 0.0095s | 0.0330s | **5.5x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0690s | 0.0136s | 0.0630s | **5.1x** | **4.6x** |
| sort | repetitive 10MB | 0.0438s | 0.0095s | 0.0340s | **4.6x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0499s | 0.0082s | 0.0266s | **6.1x** | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0017s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0036s | 0.0067s | **2.4x** | **1.9x** |
| tr | -d digits 10MB | 0.0112s | 0.0050s | 0.0099s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0185s | 0.0065s | 0.0166s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0166s | 0.0037s | 0.0113s | **4.5x** | **3.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0034s | 0.0066s | **2.6x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0108s | 0.0051s | 0.0103s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0094s | 0.0035s | 0.0075s | **2.7x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0016s | 0.0085s | **5.7x** | **5.4x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0024s | 0.0093s | **6.7x** | **3.9x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0016s | 0.0085s | **5.5x** | **5.2x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0065s | 0.0112s | **4.5x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0089s | 0.0015s | 0.0086s | **5.8x** | **5.5x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0016s | 0.0085s | **5.5x** | **5.2x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0039s | 0.0095s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0473s | 0.0026s | 0.0138s | **17.9x** | **5.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | 0.0014s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0081s | 0.0050s | 0.0047s | **1.6x** | **0.9x** |
| tac | reverse 100MB text | 0.0825s | 0.0198s | 0.0421s | **4.2x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0044s | 0.0044s | **1.7x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0172s | 0.0089s | 0.0083s | **1.9x** | **0.9x** |
| tac | custom separator 1MB | 0.0041s | 0.0036s | 0.0037s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0039s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0543s | 0.0031s | 0.0314s | **17.7x** | **10.2x** |
| wc | default 100MB text | 0.4828s | 0.0139s | 0.2645s | **34.7x** | **19.0x** |
| wc | -l 10MB text | 0.0021s | 0.0024s | 0.0020s | **0.9x** | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0087s | 0.0254s | **6.2x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0543s | 0.0029s | 0.0021s | **18.5x** | **0.7x** |
| wc | -L 10MB text | 0.0541s | 0.0100s | 0.0164s | **5.4x** | **1.6x** |
| wc | default 10MB binary | 0.3174s | 0.0271s | 0.1589s | **11.7x** | **5.9x** |
| wc | default 10MB repetitive | 0.0727s | 0.0045s | 0.0417s | **16.2x** | **9.3x** |
| wc | 10 files | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0023s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0039s | 0.0073s | **5.7x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0039s | 0.0074s | **5.7x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0095s | 0.0089s | **1.7x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0112s | 0.0178s | **1.9x** | **1.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0103s | 0.0135s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0107s | 0.0165s | **2.9x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0026s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0032s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0086s | 0.0097s | 0.0083s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0103s | 0.0087s | **0.9x** | **0.8x** |
| sha256sum | single 100MB text | 0.0759s | 0.0746s | 0.0746s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.7x** | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0171s | 0.0180s | 0.0214s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0187s | 0.0226s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1613s | 0.1530s | 0.2029s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0024s | 0.0021s | 0.0023s | **1.2x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0124s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0130s | 0.0128s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1434s | 0.1120s | 0.1136s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0126s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0130s | 0.0121s | **1.2x** | **0.9x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | 0.0018s | **1.3x** | **1.1x** |
| base64 | encode 10MB text | 0.0123s | 0.0044s | 0.0081s | **2.8x** | **1.8x** |
| base64 | encode 10MB binary | 0.0131s | 0.0044s | 0.0084s | **3.0x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0043s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0322s | 0.0048s | 0.0336s | **6.7x** | **7.0x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0045s | 0.0084s | **2.8x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0042s | 0.0073s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0036s | 0.0056s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0547s | 0.0090s | 0.0357s | **6.1x** | **4.0x** |
| sort | already sorted 10MB | 0.0274s | 0.0048s | 0.0180s | **5.7x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0284s | 0.0064s | 0.0185s | **4.5x** | **2.9x** |
| sort | -n numeric 10MB | 0.0741s | 0.0055s | 0.0752s | **13.6x** | **13.8x** |
| sort | -r reverse 10MB | 0.0547s | 0.0092s | 0.0363s | **6.0x** | **4.0x** |
| sort | -u unique 10MB | 0.0600s | 0.0093s | 0.0399s | **6.4x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0663s | 0.0193s | 0.0831s | **3.4x** | **4.3x** |
| sort | repetitive 10MB | 0.0555s | 0.0126s | 0.0375s | **4.4x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0541s | 0.0089s | 0.0362s | **6.1x** | **4.1x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0037s | 0.0079s | **3.3x** | **2.1x** |
| tr | -d digits 10MB | 0.0171s | 0.0043s | 0.0139s | **3.9x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0296s | 0.0049s | 0.0216s | **6.0x** | **4.4x** |
| tr | -s spaces 10MB | 0.0280s | 0.0037s | 0.0285s | **7.6x** | **7.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0138s | 0.0038s | 0.0073s | **3.7x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0170s | 0.0042s | 0.0135s | **4.0x** | **3.2x** |
| tr | translate binary 10MB | 0.0115s | 0.0039s | 0.0081s | **2.9x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0019s | 0.0121s | **6.2x** | **6.4x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0032s | 0.0132s | **4.4x** | **4.1x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0020s | 0.0123s | **6.1x** | **6.2x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0077s | 0.0157s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0019s | 0.0121s | **6.4x** | **6.4x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | 0.0120s | **6.3x** | **6.4x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0043s | 0.0130s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0418s | 0.0037s | 0.0176s | **11.4x** | **4.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | 0.0012s | **0.8x** | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0105s | 0.0060s | 0.0058s | **1.8x** | **1.0x** |
| tac | reverse 100MB text | 0.1040s | 0.0275s | 0.0516s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0056s | 0.0056s | **1.7x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0108s | 0.0107s | **2.1x** | **1.0x** |
| tac | custom separator 1MB | 0.0059s | 0.0049s | 0.0053s | **1.2x** | **1.1x** |
