# fcoreutils v0.1.7 — Detailed Results

Generated: 2026-02-16 21:59:13 UTC

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
| wc | default 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0037s | 0.0024s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0336s | 0.0063s | 0.0251s | **5.4x** | **4.0x** |
| wc | default 100MB text | 0.2959s | 0.0455s | 0.2243s | **6.5x** | **4.9x** |
| wc | -l 10MB text | 0.0038s | 0.0021s | 0.0024s | **1.8x** | **1.1x** |
| wc | -w 10MB text | 0.0341s | 0.0058s | 0.0231s | **5.9x** | **4.0x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0343s | 0.0021s | 0.0024s | **16.3x** | **1.1x** |
| wc | -L 10MB text | 0.0341s | 0.0059s | 0.0174s | **5.8x** | **3.0x** |
| wc | default 10MB binary | 0.2349s | 0.0176s | 0.1179s | **13.4x** | **6.7x** |
| wc | default 10MB repetitive | 0.0536s | 0.0080s | 0.0363s | **6.7x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0031s | 0.0061s | **5.9x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0029s | 0.0058s | **6.3x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0184s | 0.0042s | 0.0068s | **4.3x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0210s | 0.0048s | 0.0160s | **4.4x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0227s | 0.0036s | 0.0123s | **6.4x** | **3.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0258s | 0.0029s | 0.0159s | **9.0x** | **5.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0020s | 0.0016s | **1.6x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0016s | 0.0026s | 0.0036s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0072s | 0.0072s | 0.0268s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0072s | 0.0074s | 0.0282s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0657s | 0.0541s | 0.2596s | **1.2x** | **4.8x** |
| sha256sum | 10 files | 0.0011s | 0.0018s | 0.0010s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | 0.0016s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0011s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0036s | 0.0029s | **0.8x** | **0.8x** |
| md5sum | single 10MB text | 0.0211s | 0.0160s | 0.0171s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0216s | 0.0169s | 0.0179s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.1976s | 0.1425s | 0.1632s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0012s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0024s | 0.0015s | **0.7x** | **0.6x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | 0.0022s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0136s | 0.0123s | 0.0133s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0141s | 0.0129s | 0.0138s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1318s | 0.1147s | 0.1267s | **1.1x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0126s | 0.0139s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0126s | 0.0142s | **1.2x** | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0014s | 0.0018s | **1.2x** | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0104s | 0.0036s | 0.0078s | **2.9x** | **2.2x** |
| base64 | encode 10MB binary | 0.0109s | 0.0033s | 0.0082s | **3.3x** | **2.5x** |
| base64 | decode 1MB | 0.0038s | 0.0020s | 0.0036s | **1.9x** | **1.8x** |
| base64 | decode 10MB | 0.0307s | 0.0092s | 0.0270s | **3.3x** | **2.9x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0035s | 0.0077s | **2.9x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0081s | 0.0033s | 0.0077s | **2.5x** | **2.3x** |
| sort | lexicographic 1MB | 0.0076s | 0.0027s | 0.0043s | **2.8x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0519s | 0.0065s | 0.0330s | **8.0x** | **5.1x** |
| sort | already sorted 10MB | 0.0254s | 0.0035s | 0.0141s | **7.2x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0251s | 0.0048s | 0.0142s | **5.2x** | **3.0x** |
| sort | -n numeric 10MB | 0.0702s | 0.0040s | 0.0660s | **17.5x** | **16.4x** |
| sort | -r reverse 10MB | 0.0538s | 0.0069s | 0.0339s | **7.7x** | **4.9x** |
| sort | -u unique 10MB | 0.0556s | 0.0085s | 0.0388s | **6.5x** | **4.5x** |
| sort | -t, -k2 CSV 10MB | 0.0724s | 0.0150s | 0.0746s | **4.8x** | **5.0x** |
| sort | repetitive 10MB | 0.0459s | 0.0103s | 0.0373s | **4.4x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0519s | 0.0064s | 0.0325s | **8.1x** | **5.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0020s | 0.0019s | **1.0x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0074s | 0.0068s | **1.2x** | **0.9x** |
| tr | -d digits 10MB | 0.0113s | 0.0088s | 0.0103s | **1.3x** | **1.2x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0111s | 0.0172s | **1.7x** | **1.5x** |
| tr | -s spaces 10MB | 0.0165s | 0.0075s | 0.0115s | **2.2x** | **1.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0072s | 0.0067s | **1.2x** | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0087s | 0.0101s | **1.3x** | **1.2x** |
| tr | translate binary 10MB | 0.0097s | 0.0079s | 0.0078s | **1.2x** | **1.0x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0026s | 0.0090s | **3.5x** | **3.4x** |
| uniq | default 10MB sorted (low dup) | 0.0167s | 0.0032s | 0.0097s | **5.2x** | **3.0x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0028s | 0.0088s | **3.3x** | **3.1x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0069s | 0.0116s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0026s | 0.0089s | **3.6x** | **3.5x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0089s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0039s | 0.0099s | **4.3x** | **2.5x** |
| uniq | repetitive 10MB | 0.0479s | 0.0038s | 0.0150s | **12.8x** | **4.0x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0015s | 0.0016s | 0.0014s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0086s | 0.0031s | 0.0049s | **2.8x** | **1.6x** |
| tac | reverse 100MB text | 0.0830s | 0.0191s | 0.0435s | **4.3x** | **2.3x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0032s | 0.0046s | **2.6x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0182s | 0.0051s | 0.0087s | **3.6x** | **1.7x** |
| tac | custom separator 1MB | 0.0044s | 0.0040s | 0.0041s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0044s | **1.9x** | **1.5x** |
| wc | default 10MB text | 0.0539s | 0.0031s | 0.0358s | **17.6x** | **11.7x** |
| wc | default 100MB text | 0.4819s | 0.0140s | 0.3143s | **34.5x** | **22.5x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0089s | 0.0265s | **6.1x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0541s | 0.0030s | 0.0019s | **18.3x** | **0.7x** |
| wc | -L 10MB text | 0.0542s | 0.0103s | 0.0166s | **5.3x** | **1.6x** |
| wc | default 10MB binary | 0.3168s | 0.0271s | 0.1570s | **11.7x** | **5.8x** |
| wc | default 10MB repetitive | 0.0731s | 0.0048s | 0.0522s | **15.2x** | **10.9x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.1x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0046s | 0.0070s | **4.9x** | **1.5x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0047s | 0.0070s | **4.8x** | **1.5x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0049s | 0.0089s | **3.4x** | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0221s | 0.0065s | 0.0183s | **3.4x** | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0054s | 0.0150s | **4.5x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0301s | 0.0047s | 0.0163s | **6.4x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0083s | 0.0095s | 0.0083s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0098s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0747s | 0.0748s | 0.0743s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0020s | 0.0023s | 0.0014s | **0.9x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0030s | 0.0023s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0176s | 0.0235s | **1.0x** | **1.3x** |
| md5sum | single 10MB binary | 0.0179s | 0.0179s | 0.0220s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1602s | 0.1527s | 0.2034s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0015s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0031s | 0.0024s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0158s | 0.0128s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1433s | 0.1124s | 0.1123s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0121s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0019s | 0.0023s | **1.2x** | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0124s | 0.0048s | 0.0081s | **2.6x** | **1.7x** |
| base64 | encode 10MB binary | 0.0128s | 0.0051s | 0.0085s | **2.5x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0020s | 0.0043s | **2.0x** | **2.2x** |
| base64 | decode 10MB | 0.0324s | 0.0102s | 0.0336s | **3.2x** | **3.3x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0050s | 0.0082s | **2.5x** | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0039s | 0.0072s | **2.2x** | **1.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0055s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0544s | 0.0096s | 0.0364s | **5.7x** | **3.8x** |
| sort | already sorted 10MB | 0.0265s | 0.0044s | 0.0180s | **6.1x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0275s | 0.0068s | 0.0181s | **4.0x** | **2.7x** |
| sort | -n numeric 10MB | 0.0737s | 0.0057s | 0.0761s | **13.0x** | **13.5x** |
| sort | -r reverse 10MB | 0.0548s | 0.0097s | 0.0364s | **5.6x** | **3.8x** |
| sort | -u unique 10MB | 0.0581s | 0.0099s | 0.0400s | **5.9x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0677s | 0.0201s | 0.0865s | **3.4x** | **4.3x** |
| sort | repetitive 10MB | 0.0549s | 0.0120s | 0.0379s | **4.6x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0580s | 0.0102s | 0.0366s | **5.7x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | 0.0021s | **1.2x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0070s | 0.0077s | **1.8x** | **1.1x** |
| tr | -d digits 10MB | 0.0161s | 0.0102s | 0.0137s | **1.6x** | **1.3x** |
| tr | -d lowercase 10MB | 0.0288s | 0.0128s | 0.0213s | **2.3x** | **1.7x** |
| tr | -s spaces 10MB | 0.0271s | 0.0072s | 0.0270s | **3.8x** | **3.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0144s | 0.0073s | 0.0076s | **2.0x** | **1.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0175s | 0.0101s | 0.0136s | **1.7x** | **1.4x** |
| tr | translate binary 10MB | 0.0119s | 0.0071s | 0.0083s | **1.7x** | **1.2x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0036s | 0.0130s | **3.9x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0037s | 0.0116s | **3.3x** | **3.1x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0096s | 0.0156s | **3.1x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0037s | 0.0116s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0036s | 0.0115s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0049s | 0.0133s | **2.9x** | **2.7x** |
| uniq | repetitive 10MB | 0.0423s | 0.0043s | 0.0167s | **9.8x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0108s | 0.0045s | 0.0059s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1043s | 0.0252s | 0.0529s | **4.1x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0040s | 0.0057s | **2.4x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0073s | 0.0113s | **3.3x** | **1.6x** |
| tac | custom separator 1MB | 0.0060s | 0.0048s | 0.0054s | **1.3x** | **1.1x** |
