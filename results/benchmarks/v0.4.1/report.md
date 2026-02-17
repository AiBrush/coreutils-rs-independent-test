# fcoreutils v0.4.1 — Detailed Results

Generated: 2026-02-17 06:30:17 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0028s | 0.0035s | **1.4x** | **1.2x** |
| wc | default 10MB text | 0.0348s | 0.0071s | 0.0261s | **4.9x** | **3.7x** |
| wc | default 100MB text | 0.2966s | 0.0424s | 0.2252s | **7.0x** | **5.3x** |
| wc | -l 10MB text | 0.0046s | 0.0025s | 0.0029s | **1.8x** | **1.2x** |
| wc | -w 10MB text | 0.0348s | 0.0067s | 0.0238s | **5.2x** | **3.5x** |
| wc | -c 10MB text | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0347s | 0.0022s | 0.0031s | **15.7x** | **1.4x** |
| wc | -L 10MB text | 0.0347s | 0.0060s | 0.0181s | **5.7x** | **3.0x** |
| wc | default 10MB binary | 0.2355s | 0.0178s | 0.1182s | **13.2x** | **6.6x** |
| wc | default 10MB repetitive | 0.0534s | 0.0080s | 0.0370s | **6.7x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0012s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0014s | 0.0015s | 0.0017s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0039s | 0.0064s | **4.8x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0039s | 0.0064s | **4.8x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0031s | 0.0073s | **6.0x** | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0050s | 0.0166s | **4.3x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0038s | 0.0130s | **6.1x** | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0046s | 0.0164s | **5.8x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0016s | 0.0018s | **2.2x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0015s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0018s | 0.0028s | 0.0039s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0081s | 0.0091s | 0.0278s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0084s | 0.0097s | 0.0292s | **0.9x** | **3.0x** |
| sha256sum | single 100MB text | 0.0667s | 0.0559s | 0.2606s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0012s | 0.0014s | 0.0012s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0018s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0037s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0218s | 0.0181s | 0.0182s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0226s | 0.0189s | 0.0189s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1984s | 0.1431s | 0.1641s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0012s | 0.0014s | 0.0012s | **0.8x** | **0.8x** |
| md5sum | 100 files | 0.0018s | 0.0022s | 0.0020s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0023s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0147s | 0.0142s | 0.0144s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0150s | 0.0151s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1333s | 0.1157s | 0.1271s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0144s | 0.0144s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0144s | 0.0144s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0020s | 0.0019s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0011s | **1.0x** | **1.0x** |
| base64 | encode 1MB text | 0.0018s | 0.0016s | 0.0018s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0106s | 0.0035s | 0.0081s | **3.0x** | **2.3x** |
| base64 | encode 10MB binary | 0.0111s | 0.0043s | 0.0084s | **2.6x** | **2.0x** |
| base64 | decode 1MB | 0.0039s | 0.0016s | 0.0037s | **2.5x** | **2.3x** |
| base64 | decode 10MB | 0.0308s | 0.0040s | 0.0271s | **7.6x** | **6.7x** |
| base64 | encode -w 76 10MB | 0.0106s | 0.0037s | 0.0081s | **2.8x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0030s | 0.0082s | **2.9x** | **2.8x** |
| sort | lexicographic 1MB | 0.0079s | 0.0028s | 0.0046s | **2.8x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0552s | 0.0070s | 0.0346s | **7.8x** | **4.9x** |
| sort | already sorted 10MB | 0.0260s | 0.0036s | 0.0145s | **7.2x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0261s | 0.0052s | 0.0152s | **5.0x** | **2.9x** |
| sort | -n numeric 10MB | 0.0749s | 0.0043s | 0.0721s | **17.5x** | **16.8x** |
| sort | -r reverse 10MB | 0.0567s | 0.0075s | 0.0352s | **7.5x** | **4.7x** |
| sort | -u unique 10MB | 0.0594s | 0.0100s | 0.0428s | **6.0x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0761s | 0.0177s | 0.0773s | **4.3x** | **4.4x** |
| sort | repetitive 10MB | 0.0475s | 0.0110s | 0.0391s | **4.3x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0545s | 0.0067s | 0.0341s | **8.1x** | **5.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0017s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0051s | 0.0070s | **1.8x** | **1.4x** |
| tr | -d digits 10MB | 0.0112s | 0.0054s | 0.0102s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0069s | 0.0175s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0167s | 0.0052s | 0.0116s | **3.2x** | **2.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0054s | 0.0073s | **1.6x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0055s | 0.0103s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0093s | 0.0053s | 0.0079s | **1.8x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0096s | 0.0029s | 0.0091s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0170s | 0.0035s | 0.0103s | **4.8x** | **2.9x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0031s | 0.0091s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0072s | 0.0121s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0028s | 0.0090s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0029s | 0.0090s | **3.3x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0042s | 0.0101s | **4.0x** | **2.4x** |
| uniq | repetitive 10MB | 0.0485s | 0.0040s | 0.0156s | **12.2x** | **3.9x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0018s | 0.0015s | 0.0016s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0094s | 0.0031s | 0.0052s | **3.0x** | **1.7x** |
| tac | reverse 100MB text | 0.0835s | 0.0156s | 0.0436s | **5.4x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0027s | 0.0046s | **3.1x** | **1.7x** |
| tac | reverse repetitive 10MB | 0.0187s | 0.0043s | 0.0089s | **4.3x** | **2.1x** |
| tac | custom separator 1MB | 0.0045s | 0.0034s | 0.0040s | **1.3x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0029s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0545s | 0.0026s | 0.0301s | **20.9x** | **11.5x** |
| wc | default 100MB text | 0.4836s | 0.0090s | 0.2561s | **53.5x** | **28.3x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0545s | 0.0102s | 0.0259s | **5.4x** | **2.6x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0543s | 0.0025s | 0.0021s | **21.7x** | **0.8x** |
| wc | -L 10MB text | 0.0543s | 0.0099s | 0.0197s | **5.5x** | **2.0x** |
| wc | default 10MB binary | 0.3232s | 0.0268s | 0.1546s | **12.0x** | **5.8x** |
| wc | default 10MB repetitive | 0.0731s | 0.0034s | 0.0396s | **21.2x** | **11.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.1x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0039s | 0.0072s | **5.8x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0039s | 0.0073s | **5.8x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0032s | 0.0087s | **5.2x** | **2.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0065s | 0.0175s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0045s | 0.0134s | **5.3x** | **3.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0052s | 0.0164s | **5.9x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0099s | 0.0085s | **0.8x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0102s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0756s | 0.0756s | 0.0754s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0015s | 0.0014s | **0.9x** | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0178s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0184s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1620s | 0.1530s | 0.2037s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **0.9x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0123s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0129s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1431s | 0.1115s | 0.1134s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0125s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0124s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0014s | 0.0018s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0124s | 0.0037s | 0.0082s | **3.4x** | **2.2x** |
| base64 | encode 10MB binary | 0.0131s | 0.0040s | 0.0087s | **3.3x** | **2.2x** |
| base64 | decode 1MB | 0.0040s | 0.0014s | 0.0043s | **2.9x** | **3.2x** |
| base64 | decode 10MB | 0.0328s | 0.0040s | 0.0338s | **8.1x** | **8.4x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0037s | 0.0081s | **3.3x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0031s | 0.0073s | **2.8x** | **2.3x** |
| sort | lexicographic 1MB | 0.0087s | 0.0032s | 0.0055s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0543s | 0.0095s | 0.0356s | **5.7x** | **3.7x** |
| sort | already sorted 10MB | 0.0265s | 0.0042s | 0.0174s | **6.3x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0065s | 0.0176s | **4.2x** | **2.7x** |
| sort | -n numeric 10MB | 0.0749s | 0.0057s | 0.0761s | **13.1x** | **13.3x** |
| sort | -r reverse 10MB | 0.0543s | 0.0097s | 0.0367s | **5.6x** | **3.8x** |
| sort | -u unique 10MB | 0.0575s | 0.0096s | 0.0402s | **6.0x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0667s | 0.0192s | 0.0812s | **3.5x** | **4.2x** |
| sort | repetitive 10MB | 0.0553s | 0.0119s | 0.0367s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0097s | 0.0353s | **5.6x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0122s | 0.0037s | 0.0077s | **3.3x** | **2.1x** |
| tr | -d digits 10MB | 0.0178s | 0.0042s | 0.0140s | **4.3x** | **3.4x** |
| tr | -d lowercase 10MB | 0.0301s | 0.0049s | 0.0227s | **6.2x** | **4.7x** |
| tr | -s spaces 10MB | 0.0266s | 0.0038s | 0.0274s | **7.1x** | **7.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0127s | 0.0038s | 0.0072s | **3.4x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0162s | 0.0042s | 0.0139s | **3.9x** | **3.3x** |
| tr | translate binary 10MB | 0.0114s | 0.0038s | 0.0086s | **3.0x** | **2.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0035s | 0.0112s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0037s | 0.0133s | **3.8x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0035s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0091s | 0.0157s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0035s | 0.0111s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0045s | 0.0133s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0418s | 0.0041s | 0.0162s | **10.1x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0106s | 0.0035s | 0.0059s | **3.1x** | **1.7x** |
| tac | reverse 100MB text | 0.1029s | 0.0200s | 0.0520s | **5.1x** | **2.6x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0031s | 0.0057s | **3.0x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0231s | 0.0052s | 0.0113s | **4.4x** | **2.2x** |
| tac | custom separator 1MB | 0.0059s | 0.0035s | 0.0053s | **1.7x** | **1.5x** |
