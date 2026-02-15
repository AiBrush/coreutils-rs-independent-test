# fcoreutils v0.3.9 — Detailed Results

Generated: 2026-02-15 07:58:43 UTC

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
| wc | default 1MB text | 0.0039s | 0.0027s | 0.0035s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0339s | 0.0065s | 0.0253s | **5.2x** | **3.9x** |
| wc | default 100MB text | 0.2978s | 0.0430s | 0.2262s | **6.9x** | **5.3x** |
| wc | -l 10MB text | 0.0040s | 0.0021s | 0.0025s | **1.9x** | **1.2x** |
| wc | -w 10MB text | 0.0338s | 0.0066s | 0.0227s | **5.1x** | **3.4x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0338s | 0.0022s | 0.0026s | **15.3x** | **1.2x** |
| wc | -L 10MB text | 0.0338s | 0.0059s | 0.0173s | **5.7x** | **2.9x** |
| wc | default 10MB binary | 0.2344s | 0.0170s | 0.1179s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0536s | 0.0081s | 0.0375s | **6.6x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0014s | 0.0016s | 0.0018s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0038s | 0.0067s | **4.9x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0188s | 0.0039s | 0.0066s | **4.8x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0033s | 0.0074s | **5.8x** | **2.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0051s | 0.0167s | **4.3x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0038s | 0.0131s | **6.2x** | **3.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0050s | 0.0166s | **5.3x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0017s | 0.0018s | **2.2x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0012s | 0.0022s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0019s | 0.0030s | 0.0040s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0077s | 0.0085s | 0.0272s | **0.9x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0084s | 0.0094s | 0.0289s | **0.9x** | **3.1x** |
| sha256sum | single 100MB text | 0.0686s | 0.0566s | 0.2622s | **1.2x** | **4.6x** |
| sha256sum | 10 files | 0.0013s | 0.0014s | 0.0012s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0019s | 0.0022s | 0.0019s | **0.8x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0033s | 0.0038s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0210s | 0.0174s | 0.0175s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0226s | 0.0189s | 0.0190s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2003s | 0.1437s | 0.1656s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0013s | 0.0013s | **0.9x** | **1.0x** |
| md5sum | 100 files | 0.0018s | 0.0023s | 0.0019s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0024s | 0.0025s | **1.0x** | **1.0x** |
| b2sum | single 10MB text | 0.0141s | 0.0134s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0151s | 0.0147s | 0.0148s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1346s | 0.1161s | 0.1282s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0135s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0141s | 0.0135s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0018s | 0.0018s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0018s | 0.0015s | 0.0017s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0098s | 0.0033s | 0.0072s | **2.9x** | **2.2x** |
| base64 | encode 10MB binary | 0.0105s | 0.0036s | 0.0079s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0039s | 0.0016s | 0.0036s | **2.4x** | **2.3x** |
| base64 | decode 10MB | 0.0309s | 0.0036s | 0.0273s | **8.7x** | **7.7x** |
| base64 | encode -w 76 10MB | 0.0098s | 0.0031s | 0.0072s | **3.1x** | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0077s | 0.0027s | 0.0073s | **2.9x** | **2.7x** |
| sort | lexicographic 1MB | 0.0078s | 0.0028s | 0.0046s | **2.8x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0545s | 0.0065s | 0.0331s | **8.3x** | **5.1x** |
| sort | already sorted 10MB | 0.0258s | 0.0036s | 0.0145s | **7.2x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0252s | 0.0046s | 0.0143s | **5.5x** | **3.1x** |
| sort | -n numeric 10MB | 0.0725s | 0.0041s | 0.0702s | **17.7x** | **17.2x** |
| sort | -r reverse 10MB | 0.0546s | 0.0066s | 0.0346s | **8.2x** | **5.2x** |
| sort | -u unique 10MB | 0.0575s | 0.0091s | 0.0416s | **6.4x** | **4.6x** |
| sort | -t, -k2 CSV 10MB | 0.0754s | 0.0177s | 0.0758s | **4.3x** | **4.3x** |
| sort | repetitive 10MB | 0.0463s | 0.0107s | 0.0376s | **4.3x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0535s | 0.0067s | 0.0325s | **8.0x** | **4.8x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0042s | 0.0072s | **2.1x** | **1.7x** |
| tr | -d digits 10MB | 0.0111s | 0.0053s | 0.0103s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0068s | 0.0172s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0170s | 0.0042s | 0.0116s | **4.1x** | **2.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0041s | 0.0071s | **2.1x** | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0052s | 0.0104s | **2.2x** | **2.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0046s | 0.0079s | **2.0x** | **1.7x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0028s | 0.0091s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0169s | 0.0031s | 0.0102s | **5.4x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0030s | 0.0090s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0071s | 0.0120s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0028s | 0.0091s | **3.3x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0028s | 0.0089s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0042s | 0.0102s | **4.0x** | **2.4x** |
| uniq | repetitive 10MB | 0.0486s | 0.0038s | 0.0157s | **12.8x** | **4.2x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0082s | 0.0034s | 0.0050s | **2.4x** | **1.5x** |
| tac | reverse 100MB text | 0.0841s | 0.0209s | 0.0444s | **4.0x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0040s | 0.0046s | **2.1x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0192s | 0.0070s | 0.0089s | **2.8x** | **1.3x** |
| tac | custom separator 1MB | 0.0045s | 0.0033s | 0.0040s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0038s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0547s | 0.0026s | 0.0306s | **21.1x** | **11.8x** |
| wc | default 100MB text | 0.4775s | 0.0090s | 0.2541s | **53.2x** | **28.3x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0543s | 0.0085s | 0.0254s | **6.4x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0544s | 0.0025s | 0.0020s | **22.2x** | **0.8x** |
| wc | -L 10MB text | 0.0542s | 0.0095s | 0.0196s | **5.7x** | **2.1x** |
| wc | default 10MB binary | 0.3173s | 0.0263s | 0.1544s | **12.0x** | **5.9x** |
| wc | default 10MB repetitive | 0.0729s | 0.0034s | 0.0395s | **21.3x** | **11.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0043s | 0.0076s | **5.3x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0038s | 0.0073s | **5.9x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0034s | 0.0085s | **4.9x** | **2.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0067s | 0.0181s | **3.2x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0048s | 0.0135s | **5.1x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0055s | 0.0163s | **5.6x** | **3.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0016s | 0.0020s | **2.2x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0098s | 0.0083s | **0.9x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0103s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0745s | 0.0752s | 0.0748s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **0.9x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0024s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0169s | 0.0180s | 0.0213s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0186s | 0.0221s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1608s | 0.1530s | 0.2029s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| md5sum | 100 files | 0.0024s | 0.0025s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0123s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0128s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1419s | 0.1129s | 0.1125s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0124s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0124s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0013s | 0.0018s | **1.5x** | **1.4x** |
| base64 | encode 10MB text | 0.0122s | 0.0037s | 0.0081s | **3.3x** | **2.2x** |
| base64 | encode 10MB binary | 0.0129s | 0.0038s | 0.0084s | **3.4x** | **2.2x** |
| base64 | decode 1MB | 0.0040s | 0.0014s | 0.0044s | **2.9x** | **3.2x** |
| base64 | decode 10MB | 0.0321s | 0.0039s | 0.0338s | **8.2x** | **8.7x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0037s | 0.0080s | **3.3x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0032s | 0.0071s | **2.6x** | **2.2x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0098s | 0.0351s | **5.6x** | **3.6x** |
| sort | already sorted 10MB | 0.0262s | 0.0042s | 0.0176s | **6.3x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0066s | 0.0181s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0744s | 0.0059s | 0.0765s | **12.6x** | **13.0x** |
| sort | -r reverse 10MB | 0.0554s | 0.0099s | 0.0360s | **5.6x** | **3.6x** |
| sort | -u unique 10MB | 0.0573s | 0.0097s | 0.0393s | **5.9x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0705s | 0.0263s | 0.0914s | **2.7x** | **3.5x** |
| sort | repetitive 10MB | 0.0547s | 0.0122s | 0.0389s | **4.5x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0554s | 0.0109s | 0.0365s | **5.1x** | **3.4x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0040s | 0.0074s | **3.1x** | **1.9x** |
| tr | -d digits 10MB | 0.0161s | 0.0043s | 0.0143s | **3.7x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0304s | 0.0058s | 0.0235s | **5.2x** | **4.0x** |
| tr | -s spaces 10MB | 0.0273s | 0.0039s | 0.0274s | **7.0x** | **7.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0129s | 0.0039s | 0.0073s | **3.3x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0165s | 0.0042s | 0.0140s | **4.0x** | **3.4x** |
| tr | translate binary 10MB | 0.0125s | 0.0039s | 0.0083s | **3.2x** | **2.2x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0036s | 0.0112s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0037s | 0.0133s | **3.8x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0038s | 0.0122s | **3.1x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0288s | 0.0091s | 0.0156s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0035s | 0.0111s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0045s | 0.0134s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0419s | 0.0042s | 0.0162s | **10.0x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0039s | 0.0058s | **2.7x** | **1.5x** |
| tac | reverse 100MB text | 0.1025s | 0.0221s | 0.0519s | **4.6x** | **2.3x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0042s | 0.0057s | **2.2x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0229s | 0.0072s | 0.0113s | **3.2x** | **1.6x** |
| tac | custom separator 1MB | 0.0059s | 0.0035s | 0.0053s | **1.7x** | **1.5x** |
