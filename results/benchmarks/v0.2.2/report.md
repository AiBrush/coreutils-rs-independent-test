# fcoreutils v0.2.2 — Detailed Results

Generated: 2026-02-15 07:16:48 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0339s | 0.0059s | 0.0253s | **5.7x** | **4.3x** |
| wc | default 100MB text | 0.2977s | 0.0432s | 0.2253s | **6.9x** | **5.2x** |
| wc | -l 10MB text | 0.0039s | 0.0020s | 0.0022s | **2.0x** | **1.1x** |
| wc | -w 10MB text | 0.0339s | 0.0059s | 0.0227s | **5.8x** | **3.9x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0339s | 0.0022s | 0.0023s | **15.2x** | **1.0x** |
| wc | -L 10MB text | 0.0340s | 0.0058s | 0.0172s | **5.8x** | **2.9x** |
| wc | default 10MB binary | 0.2344s | 0.0169s | 0.1178s | **13.8x** | **7.0x** |
| wc | default 10MB repetitive | 0.0539s | 0.0079s | 0.0359s | **6.9x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0012s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0180s | 0.0038s | 0.0059s | **4.7x** | **1.5x** |
| cut | -c1-100 10MB CSV | 0.0181s | 0.0038s | 0.0058s | **4.8x** | **1.5x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0043s | 0.0068s | **4.2x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0207s | 0.0048s | 0.0160s | **4.3x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0226s | 0.0034s | 0.0122s | **6.7x** | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0260s | 0.0030s | 0.0156s | **8.6x** | **5.2x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0021s | 0.0016s | **1.5x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | 0.0013s | **0.5x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0025s | 0.0037s | **0.7x** | **1.5x** |
| sha256sum | single 10MB text | 0.0071s | 0.0073s | 0.0271s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0074s | 0.0074s | 0.0283s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0667s | 0.0751s | 0.2614s | **0.9x** | **3.5x** |
| sha256sum | 10 files | 0.0011s | 0.0018s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0019s | 0.0016s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0033s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0206s | 0.0160s | 0.0172s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0214s | 0.0167s | 0.0178s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.1992s | 0.1424s | 0.1651s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.7x** |
| md5sum | 100 files | 0.0017s | 0.0021s | 0.0016s | **0.8x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0021s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0139s | 0.0123s | 0.0136s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0145s | 0.0128s | 0.0142s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1337s | 0.1131s | 0.1279s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0139s | 0.0125s | 0.0136s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0136s | 0.0123s | 0.0134s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0016s | 0.0015s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0093s | 0.0054s | 0.0069s | **1.7x** | **1.3x** |
| base64 | encode 10MB binary | 0.0098s | 0.0055s | 0.0071s | **1.8x** | **1.3x** |
| base64 | decode 1MB | 0.0036s | 0.0016s | 0.0034s | **2.3x** | **2.2x** |
| base64 | decode 10MB | 0.0301s | 0.0047s | 0.0264s | **6.4x** | **5.7x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0053s | 0.0070s | **1.8x** | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0045s | 0.0071s | **1.6x** | **1.6x** |
| sort | lexicographic 1MB | 0.0075s | 0.0026s | 0.0042s | **2.8x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0518s | 0.0063s | 0.0291s | **8.3x** | **4.6x** |
| sort | already sorted 10MB | 0.0248s | 0.0033s | 0.0135s | **7.5x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0243s | 0.0046s | 0.0131s | **5.3x** | **2.9x** |
| sort | -n numeric 10MB | 0.0691s | 0.0039s | 0.0593s | **17.6x** | **15.1x** |
| sort | -r reverse 10MB | 0.0516s | 0.0064s | 0.0284s | **8.0x** | **4.4x** |
| sort | -u unique 10MB | 0.0539s | 0.0078s | 0.0339s | **6.9x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0698s | 0.0141s | 0.0660s | **5.0x** | **4.7x** |
| sort | repetitive 10MB | 0.0452s | 0.0099s | 0.0357s | **4.6x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0504s | 0.0061s | 0.0278s | **8.3x** | **4.6x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0016s | 0.0018s | **1.1x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0085s | 0.0051s | 0.0069s | **1.7x** | **1.4x** |
| tr | -d digits 10MB | 0.0112s | 0.0067s | 0.0101s | **1.7x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0087s | 0.0168s | **2.2x** | **1.9x** |
| tr | -s spaces 10MB | 0.0166s | 0.0049s | 0.0115s | **3.4x** | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0084s | 0.0049s | 0.0069s | **1.7x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0066s | 0.0103s | **1.7x** | **1.6x** |
| tr | translate binary 10MB | 0.0089s | 0.0052s | 0.0078s | **1.7x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0027s | 0.0085s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0030s | 0.0095s | **5.4x** | **3.1x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0029s | 0.0085s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0068s | 0.0113s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0089s | 0.0026s | 0.0085s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0026s | 0.0086s | **3.4x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0039s | 0.0094s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0474s | 0.0036s | 0.0143s | **13.2x** | **4.0x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0019s | 0.0015s | **0.8x** | **0.8x** |
| tac | reverse 10MB text | 0.0083s | 0.0032s | 0.0049s | **2.5x** | **1.5x** |
| tac | reverse 100MB text | 0.0833s | 0.0183s | 0.0422s | **4.5x** | **2.3x** |
| tac | reverse CSV 10MB | 0.0077s | 0.0031s | 0.0044s | **2.5x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0175s | 0.0052s | 0.0088s | **3.4x** | **1.7x** |
| tac | custom separator 1MB | 0.0042s | 0.0026s | 0.0038s | **1.6x** | **1.4x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0540s | 0.0031s | 0.0298s | **17.6x** | **9.7x** |
| wc | default 100MB text | 0.4832s | 0.0139s | 0.2539s | **34.8x** | **18.3x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0106s | 0.0257s | **5.1x** | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0538s | 0.0030s | 0.0019s | **18.0x** | **0.6x** |
| wc | -L 10MB text | 0.0538s | 0.0101s | 0.0194s | **5.3x** | **1.9x** |
| wc | default 10MB binary | 0.3179s | 0.0273s | 0.1533s | **11.6x** | **5.6x** |
| wc | default 10MB repetitive | 0.0728s | 0.0046s | 0.0402s | **15.9x** | **8.8x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0227s | 0.0041s | 0.0072s | **5.5x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0042s | 0.0072s | **5.4x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0050s | 0.0085s | **3.3x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0221s | 0.0065s | 0.0177s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0053s | 0.0134s | **4.5x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0045s | 0.0163s | **6.8x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0095s | 0.0084s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0100s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0754s | 0.0760s | 0.0759s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0027s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0039s | 0.0033s | **0.7x** | **0.8x** |
| md5sum | single 10MB text | 0.0175s | 0.0174s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0183s | 0.0184s | 0.0228s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1622s | 0.1538s | 0.2042s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0122s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0127s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1435s | 0.1114s | 0.1130s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0121s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0121s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0023s | 0.0023s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0122s | 0.0056s | 0.0081s | **2.2x** | **1.4x** |
| base64 | encode 10MB binary | 0.0129s | 0.0058s | 0.0086s | **2.2x** | **1.5x** |
| base64 | decode 1MB | 0.0041s | 0.0016s | 0.0044s | **2.6x** | **2.8x** |
| base64 | decode 10MB | 0.0325s | 0.0062s | 0.0339s | **5.2x** | **5.4x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0056s | 0.0082s | **2.2x** | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0039s | 0.0071s | **2.3x** | **1.9x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0544s | 0.0097s | 0.0352s | **5.6x** | **3.6x** |
| sort | already sorted 10MB | 0.0268s | 0.0042s | 0.0176s | **6.4x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0270s | 0.0067s | 0.0181s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0733s | 0.0057s | 0.0754s | **12.8x** | **13.2x** |
| sort | -r reverse 10MB | 0.0543s | 0.0097s | 0.0357s | **5.6x** | **3.7x** |
| sort | -u unique 10MB | 0.0579s | 0.0100s | 0.0417s | **5.8x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0676s | 0.0191s | 0.0824s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0561s | 0.0119s | 0.0377s | **4.7x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0098s | 0.0359s | **5.5x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0019s | 0.0020s | **1.3x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0132s | 0.0050s | 0.0075s | **2.6x** | **1.5x** |
| tr | -d digits 10MB | 0.0164s | 0.0085s | 0.0143s | **1.9x** | **1.7x** |
| tr | -d lowercase 10MB | 0.0333s | 0.0110s | 0.0235s | **3.0x** | **2.1x** |
| tr | -s spaces 10MB | 0.0288s | 0.0047s | 0.0277s | **6.1x** | **5.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0045s | 0.0079s | **2.8x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0160s | 0.0086s | 0.0145s | **1.9x** | **1.7x** |
| tr | translate binary 10MB | 0.0117s | 0.0051s | 0.0080s | **2.3x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0036s | 0.0133s | **4.0x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0036s | 0.0114s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0094s | 0.0160s | **3.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0044s | 0.0134s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0418s | 0.0041s | 0.0160s | **10.3x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0019s | 0.0023s | 0.0018s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0105s | 0.0046s | 0.0058s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1037s | 0.0256s | 0.0523s | **4.1x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0040s | 0.0057s | **2.3x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0231s | 0.0072s | 0.0113s | **3.2x** | **1.6x** |
| tac | custom separator 1MB | 0.0059s | 0.0035s | 0.0053s | **1.7x** | **1.5x** |
