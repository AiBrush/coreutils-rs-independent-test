# fcoreutils v0.7.6 — Detailed Results

Generated: 2026-02-17 03:06:13 UTC

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
| wc | default 100KB text | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0040s | 0.0027s | 0.0036s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0346s | 0.0072s | 0.0260s | **4.8x** | **3.6x** |
| wc | default 100MB text | 0.3001s | 0.0482s | 0.2284s | **6.2x** | **4.7x** |
| wc | -l 10MB text | 0.0049s | 0.0025s | 0.0033s | **1.9x** | **1.3x** |
| wc | -w 10MB text | 0.0347s | 0.0068s | 0.0236s | **5.1x** | **3.5x** |
| wc | -c 10MB text | 0.0008s | 0.0011s | 0.0012s | **0.7x** | **1.1x** |
| wc | -m 10MB text | 0.0345s | 0.0026s | 0.0036s | **13.1x** | **1.4x** |
| wc | -L 10MB text | 0.0346s | 0.0063s | 0.0180s | **5.5x** | **2.8x** |
| wc | default 10MB binary | 0.2359s | 0.0175s | 0.1184s | **13.5x** | **6.8x** |
| wc | default 10MB repetitive | 0.0542s | 0.0089s | 0.0376s | **6.1x** | **4.2x** |
| wc | 10 files | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0015s | 0.0017s | 0.0019s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0036s | 0.0066s | **5.1x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0037s | 0.0065s | **5.0x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0097s | 0.0078s | **1.9x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0118s | 0.0162s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0099s | 0.0129s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0102s | 0.0162s | **2.6x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0028s | 0.0019s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0027s | 0.0015s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0019s | 0.0032s | 0.0039s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0082s | 0.0094s | 0.0276s | **0.9x** | **2.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0099s | 0.0293s | **0.9x** | **3.0x** |
| sha256sum | single 100MB text | 0.0702s | 0.0689s | 0.2636s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0019s | 0.0025s | 0.0019s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0026s | 0.0014s | **0.6x** | **0.5x** |
| md5sum | single 1MB text | 0.0034s | 0.0039s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0216s | 0.0181s | 0.0180s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0226s | 0.0191s | 0.0191s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2015s | 0.1454s | 0.1672s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0021s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0019s | 0.0028s | 0.0019s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0024s | 0.0026s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0145s | 0.0142s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0150s | 0.0151s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1361s | 0.1178s | 0.1293s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0141s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0143s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0018s | 0.0020s | 0.0019s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0010s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0018s | 0.0018s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0104s | 0.0038s | 0.0078s | **2.7x** | **2.0x** |
| base64 | encode 10MB binary | 0.0110s | 0.0040s | 0.0084s | **2.8x** | **2.1x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | 0.0038s | **1.9x** | **1.8x** |
| base64 | decode 10MB | 0.0310s | 0.0047s | 0.0273s | **6.6x** | **5.8x** |
| base64 | encode -w 76 10MB | 0.0103s | 0.0038s | 0.0079s | **2.7x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0083s | 0.0036s | 0.0080s | **2.3x** | **2.2x** |
| sort | lexicographic 1MB | 0.0080s | 0.0036s | 0.0048s | **2.2x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0577s | 0.0116s | 0.0359s | **5.0x** | **3.1x** |
| sort | already sorted 10MB | 0.0258s | 0.0041s | 0.0149s | **6.3x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0261s | 0.0053s | 0.0149s | **5.0x** | **2.8x** |
| sort | -n numeric 10MB | 0.0786s | 0.0045s | 0.0763s | **17.6x** | **17.1x** |
| sort | -r reverse 10MB | 0.0587s | 0.0114s | 0.0372s | **5.2x** | **3.3x** |
| sort | -u unique 10MB | 0.0616s | 0.0139s | 0.0442s | **4.4x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0782s | 0.0186s | 0.0790s | **4.2x** | **4.3x** |
| sort | repetitive 10MB | 0.0472s | 0.0111s | 0.0386s | **4.2x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0109s | 0.0356s | **5.0x** | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0017s | 0.0019s | **1.2x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0050s | 0.0070s | **1.8x** | **1.4x** |
| tr | -d digits 10MB | 0.0112s | 0.0055s | 0.0104s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0068s | 0.0174s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0168s | 0.0051s | 0.0117s | **3.3x** | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0049s | 0.0070s | **1.8x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0055s | 0.0104s | **2.0x** | **1.9x** |
| tr | translate binary 10MB | 0.0092s | 0.0052s | 0.0078s | **1.8x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0096s | 0.0018s | 0.0091s | **5.3x** | **5.0x** |
| uniq | default 10MB sorted (low dup) | 0.0170s | 0.0028s | 0.0103s | **6.0x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0018s | 0.0091s | **5.3x** | **5.1x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0074s | 0.0121s | **4.0x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0018s | 0.0092s | **5.2x** | **5.0x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0020s | 0.0092s | **4.8x** | **4.6x** |
| uniq | -i case insensitive 10MB | 0.0170s | 0.0043s | 0.0104s | **4.0x** | **2.4x** |
| uniq | repetitive 10MB | 0.0489s | 0.0031s | 0.0163s | **15.5x** | **5.2x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | 0.0012s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0018s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0092s | 0.0052s | 0.0052s | **1.8x** | **1.0x** |
| tac | reverse 100MB text | 0.0861s | 0.0220s | 0.0456s | **3.9x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0047s | 0.0047s | **1.7x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0195s | 0.0104s | 0.0094s | **1.9x** | **0.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0038s | 0.0041s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0058s | 0.0029s | 0.0039s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0540s | 0.0031s | 0.0307s | **17.7x** | **10.0x** |
| wc | default 100MB text | 0.4816s | 0.0139s | 0.2634s | **34.6x** | **18.9x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0539s | 0.0086s | 0.0256s | **6.2x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0539s | 0.0029s | 0.0019s | **18.6x** | **0.7x** |
| wc | -L 10MB text | 0.0540s | 0.0101s | 0.0164s | **5.3x** | **1.6x** |
| wc | default 10MB binary | 0.3163s | 0.0294s | 0.1560s | **10.8x** | **5.3x** |
| wc | default 10MB repetitive | 0.0726s | 0.0045s | 0.0415s | **16.2x** | **9.3x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0039s | 0.0072s | **5.7x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0038s | 0.0072s | **5.8x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0094s | 0.0084s | **1.7x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0112s | 0.0178s | **1.9x** | **1.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0104s | 0.0135s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0303s | 0.0106s | 0.0163s | **2.9x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0013s | 0.0026s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0034s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0083s | 0.0097s | 0.0083s | **0.9x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0101s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0746s | 0.0738s | 0.0743s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.7x** | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0175s | 0.0211s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0177s | 0.0181s | 0.0221s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1600s | 0.1524s | 0.2022s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0032s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0123s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0127s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1418s | 0.1116s | 0.1124s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0124s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0120s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0018s | 0.0019s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0122s | 0.0042s | 0.0080s | **2.9x** | **1.9x** |
| base64 | encode 10MB binary | 0.0128s | 0.0044s | 0.0084s | **2.9x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0043s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0322s | 0.0048s | 0.0331s | **6.6x** | **6.8x** |
| base64 | encode -w 76 10MB | 0.0121s | 0.0043s | 0.0080s | **2.8x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0040s | 0.0071s | **2.2x** | **1.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0034s | 0.0066s | **2.5x** | **1.9x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0090s | 0.0353s | **6.0x** | **3.9x** |
| sort | already sorted 10MB | 0.0265s | 0.0048s | 0.0176s | **5.6x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0270s | 0.0062s | 0.0177s | **4.4x** | **2.9x** |
| sort | -n numeric 10MB | 0.0727s | 0.0052s | 0.0743s | **14.1x** | **14.4x** |
| sort | -r reverse 10MB | 0.0552s | 0.0089s | 0.0359s | **6.2x** | **4.0x** |
| sort | -u unique 10MB | 0.0570s | 0.0088s | 0.0391s | **6.4x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0655s | 0.0189s | 0.0827s | **3.5x** | **4.4x** |
| sort | repetitive 10MB | 0.0550s | 0.0124s | 0.0363s | **4.4x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0540s | 0.0088s | 0.0357s | **6.1x** | **4.1x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0037s | 0.0075s | **3.4x** | **2.0x** |
| tr | -d digits 10MB | 0.0186s | 0.0043s | 0.0135s | **4.3x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0295s | 0.0050s | 0.0212s | **5.9x** | **4.2x** |
| tr | -s spaces 10MB | 0.0279s | 0.0037s | 0.0291s | **7.5x** | **7.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0131s | 0.0037s | 0.0074s | **3.5x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0174s | 0.0043s | 0.0135s | **4.1x** | **3.2x** |
| tr | translate binary 10MB | 0.0116s | 0.0039s | 0.0085s | **3.0x** | **2.2x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | 0.0121s | **6.1x** | **6.3x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0030s | 0.0131s | **4.7x** | **4.4x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | 0.0121s | **6.2x** | **6.3x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0078s | 0.0155s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0019s | 0.0121s | **6.3x** | **6.3x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | 0.0121s | **6.2x** | **6.3x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0043s | 0.0131s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0416s | 0.0036s | 0.0173s | **11.6x** | **4.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0052s | 0.0058s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.1024s | 0.0265s | 0.0513s | **3.9x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0048s | 0.0056s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0227s | 0.0100s | 0.0105s | **2.3x** | **1.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | 0.0053s | **1.4x** | **1.3x** |
