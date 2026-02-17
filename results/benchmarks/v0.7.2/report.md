# fcoreutils v0.7.2 — Detailed Results

Generated: 2026-02-17 02:19:53 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0014s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0026s | 0.0035s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0065s | 0.0258s | **5.3x** | **3.9x** |
| wc | default 100MB text | 0.2995s | 0.0456s | 0.2278s | **6.6x** | **5.0x** |
| wc | -l 10MB text | 0.0044s | 0.0023s | 0.0031s | **1.9x** | **1.4x** |
| wc | -w 10MB text | 0.0342s | 0.0066s | 0.0235s | **5.2x** | **3.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0344s | 0.0025s | 0.0028s | **13.9x** | **1.1x** |
| wc | -L 10MB text | 0.0343s | 0.0064s | 0.0179s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2357s | 0.0171s | 0.1180s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0529s | 0.0083s | 0.0374s | **6.4x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0012s | 0.0012s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0017s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0032s | 0.0068s | **5.9x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0188s | 0.0034s | 0.0065s | **5.6x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0047s | 0.0074s | **4.0x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0050s | 0.0166s | **4.3x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0236s | 0.0046s | 0.0132s | **5.1x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0268s | 0.0051s | 0.0166s | **5.3x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0013s | 0.0011s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0027s | 0.0019s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0010s | **0.7x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0026s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0031s | 0.0039s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0080s | 0.0089s | 0.0275s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0092s | 0.0290s | **0.9x** | **3.1x** |
| sha256sum | single 100MB text | 0.0690s | 0.0677s | 0.2628s | **1.0x** | **3.9x** |
| sha256sum | 10 files | 0.0013s | 0.0020s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0023s | 0.0018s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0022s | 0.0014s | **0.7x** | **0.6x** |
| md5sum | single 1MB text | 0.0033s | 0.0037s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0213s | 0.0176s | 0.0177s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0226s | 0.0185s | 0.0188s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2010s | 0.1437s | 0.1662s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0025s | 0.0018s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0025s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0143s | 0.0139s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0150s | 0.0146s | 0.0147s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1353s | 0.1167s | 0.1288s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0139s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0139s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0018s | 0.0019s | 0.0019s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0010s | 0.0013s | 0.0011s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0018s | 0.0018s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0101s | 0.0038s | 0.0075s | **2.6x** | **2.0x** |
| base64 | encode 10MB binary | 0.0108s | 0.0037s | 0.0080s | **2.9x** | **2.2x** |
| base64 | decode 1MB | 0.0039s | 0.0020s | 0.0038s | **1.9x** | **1.9x** |
| base64 | decode 10MB | 0.0311s | 0.0041s | 0.0273s | **7.6x** | **6.7x** |
| base64 | encode -w 76 10MB | 0.0102s | 0.0038s | 0.0076s | **2.7x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0037s | 0.0077s | **2.2x** | **2.1x** |
| sort | lexicographic 1MB | 0.0080s | 0.0036s | 0.0050s | **2.2x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0568s | 0.0112s | 0.0353s | **5.1x** | **3.2x** |
| sort | already sorted 10MB | 0.0260s | 0.0037s | 0.0148s | **7.1x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0259s | 0.0051s | 0.0152s | **5.0x** | **3.0x** |
| sort | -n numeric 10MB | 0.0746s | 0.0043s | 0.0736s | **17.5x** | **17.2x** |
| sort | -r reverse 10MB | 0.0560s | 0.0109s | 0.0351s | **5.1x** | **3.2x** |
| sort | -u unique 10MB | 0.0586s | 0.0134s | 0.0423s | **4.4x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0767s | 0.0173s | 0.0787s | **4.4x** | **4.6x** |
| sort | repetitive 10MB | 0.0482s | 0.0114s | 0.0389s | **4.2x** | **3.4x** |
| sort | --parallel=4 10MB | 0.0559s | 0.0108s | 0.0350s | **5.2x** | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0046s | 0.0070s | **2.0x** | **1.5x** |
| tr | -d digits 10MB | 0.0115s | 0.0055s | 0.0104s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0070s | 0.0172s | **2.7x** | **2.5x** |
| tr | -s spaces 10MB | 0.0168s | 0.0046s | 0.0116s | **3.7x** | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0047s | 0.0069s | **1.9x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0055s | 0.0101s | **2.0x** | **1.8x** |
| tr | translate binary 10MB | 0.0093s | 0.0049s | 0.0077s | **1.9x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0096s | 0.0019s | 0.0091s | **5.2x** | **4.9x** |
| uniq | default 10MB sorted (low dup) | 0.0170s | 0.0029s | 0.0102s | **5.9x** | **3.5x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0018s | 0.0092s | **5.2x** | **5.0x** |
| uniq | -c count 10MB sorted | 0.0299s | 0.0071s | 0.0120s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0018s | 0.0091s | **5.3x** | **5.0x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0018s | 0.0091s | **5.3x** | **5.0x** |
| uniq | -i case insensitive 10MB | 0.0170s | 0.0041s | 0.0103s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0490s | 0.0034s | 0.0162s | **14.5x** | **4.8x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0091s | 0.0046s | 0.0052s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0854s | 0.0234s | 0.0447s | **3.7x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0086s | 0.0045s | 0.0046s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0195s | 0.0095s | 0.0090s | **2.1x** | **0.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0038s | 0.0041s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0031s | 0.0040s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0547s | 0.0031s | 0.0311s | **17.7x** | **10.1x** |
| wc | default 100MB text | 0.4843s | 0.0140s | 0.2667s | **34.5x** | **19.0x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0543s | 0.0092s | 0.0264s | **5.9x** | **2.9x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.3x** |
| wc | -m 10MB text | 0.0549s | 0.0031s | 0.0020s | **17.5x** | **0.6x** |
| wc | -L 10MB text | 0.0545s | 0.0101s | 0.0168s | **5.4x** | **1.7x** |
| wc | default 10MB binary | 0.3171s | 0.0272s | 0.1560s | **11.6x** | **5.7x** |
| wc | default 10MB repetitive | 0.0735s | 0.0046s | 0.0424s | **15.9x** | **9.2x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0035s | 0.0075s | **6.5x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0233s | 0.0037s | 0.0078s | **6.4x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0052s | 0.0091s | **3.2x** | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0221s | 0.0072s | 0.0181s | **3.1x** | **2.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0245s | 0.0052s | 0.0137s | **4.7x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0054s | 0.0166s | **5.7x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0013s | 0.0012s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0028s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0034s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0088s | 0.0107s | 0.0085s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0093s | 0.0109s | 0.0088s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0762s | 0.0764s | 0.0768s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0026s | 0.0029s | 0.0024s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0040s | 0.0034s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0181s | 0.0188s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0182s | 0.0187s | 0.0227s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1621s | 0.1540s | 0.2048s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0015s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0035s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0025s | **1.1x** | **1.2x** |
| b2sum | single 10MB text | 0.0151s | 0.0128s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0161s | 0.0134s | 0.0132s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1441s | 0.1126s | 0.1149s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0134s | 0.0131s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0159s | 0.0131s | 0.0131s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0011s | 0.0013s | 0.0012s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0018s | 0.0018s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0126s | 0.0043s | 0.0082s | **2.9x** | **1.9x** |
| base64 | encode 10MB binary | 0.0131s | 0.0044s | 0.0084s | **3.0x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0023s | 0.0044s | **1.8x** | **1.9x** |
| base64 | decode 10MB | 0.0328s | 0.0049s | 0.0338s | **6.8x** | **7.0x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0045s | 0.0083s | **2.8x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0090s | 0.0043s | 0.0072s | **2.1x** | **1.7x** |
| sort | lexicographic 1MB | 0.0087s | 0.0036s | 0.0057s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0545s | 0.0092s | 0.0368s | **6.0x** | **4.0x** |
| sort | already sorted 10MB | 0.0268s | 0.0051s | 0.0192s | **5.2x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0282s | 0.0070s | 0.0194s | **4.0x** | **2.8x** |
| sort | -n numeric 10MB | 0.0763s | 0.0057s | 0.0773s | **13.4x** | **13.6x** |
| sort | -r reverse 10MB | 0.0553s | 0.0095s | 0.0375s | **5.8x** | **3.9x** |
| sort | -u unique 10MB | 0.0578s | 0.0094s | 0.0399s | **6.2x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0677s | 0.0197s | 0.0895s | **3.4x** | **4.5x** |
| sort | repetitive 10MB | 0.0575s | 0.0129s | 0.0397s | **4.5x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0691s | 0.0120s | 0.0371s | **5.8x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0027s | 0.0021s | 0.0021s | **1.3x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0147s | 0.0039s | 0.0075s | **3.7x** | **1.9x** |
| tr | -d digits 10MB | 0.0168s | 0.0043s | 0.0139s | **4.0x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0311s | 0.0051s | 0.0214s | **6.1x** | **4.2x** |
| tr | -s spaces 10MB | 0.0258s | 0.0041s | 0.0284s | **6.3x** | **6.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0141s | 0.0041s | 0.0076s | **3.5x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0043s | 0.0145s | **3.9x** | **3.4x** |
| tr | translate binary 10MB | 0.0110s | 0.0041s | 0.0084s | **2.7x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0122s | 0.0020s | 0.0127s | **6.1x** | **6.4x** |
| uniq | default 10MB sorted (low dup) | 0.0149s | 0.0035s | 0.0140s | **4.3x** | **4.0x** |
| uniq | -c count 10MB many dups | 0.0122s | 0.0020s | 0.0125s | **6.1x** | **6.2x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0082s | 0.0163s | **3.6x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0124s | 0.0022s | 0.0129s | **5.6x** | **5.8x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0020s | 0.0125s | **6.2x** | **6.3x** |
| uniq | -i case insensitive 10MB | 0.0144s | 0.0051s | 0.0136s | **2.8x** | **2.7x** |
| uniq | repetitive 10MB | 0.0424s | 0.0038s | 0.0184s | **11.1x** | **4.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0108s | 0.0047s | 0.0059s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1052s | 0.0277s | 0.0520s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0050s | 0.0058s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0233s | 0.0100s | 0.0110s | **2.3x** | **1.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0043s | 0.0053s | **1.4x** | **1.2x** |
