# fcoreutils v0.5.7 — Detailed Results

Generated: 2026-02-18 22:30:44 UTC

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
| wc | default 100KB text | 0.0010s | 0.0010s | 0.0011s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0036s | 0.0024s | 0.0031s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0333s | 0.0059s | 0.0248s | **5.6x** | **4.2x** |
| wc | default 100MB text | 0.2967s | 0.0426s | 0.2234s | **7.0x** | **5.2x** |
| wc | -l 10MB text | 0.0037s | 0.0020s | 0.0019s | **1.9x** | **1.0x** |
| wc | -w 10MB text | 0.0335s | 0.0059s | 0.0222s | **5.7x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | 0.0009s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0335s | 0.0020s | 0.0019s | **16.4x** | **0.9x** |
| wc | -L 10MB text | 0.0337s | 0.0057s | 0.0170s | **5.9x** | **3.0x** |
| wc | default 10MB binary | 0.2345s | 0.0166s | 0.1171s | **14.1x** | **7.0x** |
| wc | default 10MB repetitive | 0.0522s | 0.0080s | 0.0359s | **6.5x** | **4.5x** |
| wc | 10 files | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0015s | 0.0015s | **0.8x** | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0176s | 0.0027s | 0.0057s | **6.4x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0177s | 0.0026s | 0.0056s | **6.9x** | **2.2x** |
| cut | -d, -f1 10MB CSV | 0.0179s | 0.0042s | 0.0063s | **4.2x** | **1.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0204s | 0.0047s | 0.0155s | **4.3x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0223s | 0.0043s | 0.0119s | **5.2x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0255s | 0.0042s | 0.0153s | **6.1x** | **3.7x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0032s | 0.0025s | 0.0016s | **1.3x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.6x** | **0.9x** |
| sha256sum | single 100KB text | 0.0010s | 0.0019s | 0.0012s | **0.5x** | **0.7x** |
| sha256sum | single 1MB text | 0.0015s | 0.0024s | 0.0036s | **0.6x** | **1.5x** |
| sha256sum | single 10MB text | 0.0068s | 0.0078s | 0.0263s | **0.9x** | **3.4x** |
| sha256sum | single 10MB binary | 0.0070s | 0.0081s | 0.0274s | **0.9x** | **3.4x** |
| sha256sum | single 100MB text | 0.0651s | 0.0542s | 0.2601s | **1.2x** | **4.8x** |
| sha256sum | 10 files | 0.0010s | 0.0016s | 0.0010s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0016s | 0.0019s | 0.0015s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0032s | 0.0025s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0202s | 0.0166s | 0.0166s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0208s | 0.0172s | 0.0174s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1983s | 0.1418s | 0.1640s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0016s | 0.0010s | **0.7x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0019s | 0.0015s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0022s | **1.0x** | **1.0x** |
| b2sum | single 10MB text | 0.0132s | 0.0131s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0137s | 0.0134s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1334s | 0.1140s | 0.1262s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0132s | 0.0130s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0129s | 0.0128s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0016s | 0.0015s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0015s | 0.0014s | 0.0014s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0088s | 0.0030s | 0.0064s | **2.9x** | **2.1x** |
| base64 | encode 10MB binary | 0.0092s | 0.0033s | 0.0070s | **2.8x** | **2.1x** |
| base64 | decode 1MB | 0.0036s | 0.0016s | 0.0033s | **2.2x** | **2.0x** |
| base64 | decode 10MB | 0.0294s | 0.0039s | 0.0258s | **7.5x** | **6.6x** |
| base64 | encode -w 76 10MB | 0.0088s | 0.0030s | 0.0067s | **3.0x** | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0068s | 0.0028s | 0.0068s | **2.4x** | **2.4x** |
| sort | lexicographic 1MB | 0.0074s | 0.0030s | 0.0039s | **2.4x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0505s | 0.0088s | 0.0278s | **5.8x** | **3.2x** |
| sort | already sorted 10MB | 0.0251s | 0.0033s | 0.0135s | **7.6x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0048s | 0.0137s | **5.2x** | **2.9x** |
| sort | -n numeric 10MB | 0.0688s | 0.0037s | 0.0615s | **18.5x** | **16.6x** |
| sort | -r reverse 10MB | 0.0519s | 0.0089s | 0.0283s | **5.8x** | **3.2x** |
| sort | -u unique 10MB | 0.0535s | 0.0094s | 0.0345s | **5.7x** | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0689s | 0.0138s | 0.0641s | **5.0x** | **4.6x** |
| sort | repetitive 10MB | 0.0449s | 0.0101s | 0.0347s | **4.4x** | **3.4x** |
| sort | --parallel=4 10MB | 0.0498s | 0.0087s | 0.0279s | **5.7x** | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0018s | **1.3x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0036s | 0.0068s | **2.5x** | **1.9x** |
| tr | -d digits 10MB | 0.0110s | 0.0050s | 0.0101s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0186s | 0.0066s | 0.0168s | **2.8x** | **2.6x** |
| tr | -s spaces 10MB | 0.0164s | 0.0037s | 0.0114s | **4.4x** | **3.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0037s | 0.0067s | **2.4x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0051s | 0.0101s | **2.2x** | **2.0x** |
| tr | translate binary 10MB | 0.0095s | 0.0037s | 0.0076s | **2.6x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0016s | 0.0086s | **5.6x** | **5.3x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0023s | 0.0095s | **6.9x** | **4.0x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0017s | 0.0086s | **5.5x** | **5.2x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0066s | 0.0113s | **4.4x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0016s | 0.0086s | **5.7x** | **5.4x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0016s | 0.0086s | **5.6x** | **5.2x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0039s | 0.0094s | **4.2x** | **2.5x** |
| uniq | repetitive 10MB | 0.0485s | 0.0027s | 0.0147s | **17.8x** | **5.4x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0080s | 0.0043s | 0.0048s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0835s | 0.0216s | 0.0425s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0041s | 0.0043s | **1.8x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0180s | 0.0088s | 0.0086s | **2.0x** | **1.0x** |
| tac | custom separator 1MB | 0.0042s | 0.0033s | 0.0036s | **1.3x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0018s | **1.1x** | **1.4x** |
| wc | default 1MB text | 0.0061s | 0.0031s | 0.0045s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0547s | 0.0030s | 0.0334s | **18.0x** | **11.0x** |
| wc | default 100MB text | 0.4831s | 0.0139s | 0.2917s | **34.8x** | **21.0x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0542s | 0.0087s | 0.0341s | **6.3x** | **3.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0542s | 0.0030s | 0.0021s | **17.8x** | **0.7x** |
| wc | -L 10MB text | 0.0542s | 0.0111s | 0.0163s | **4.9x** | **1.5x** |
| wc | default 10MB binary | 0.3176s | 0.0281s | 0.1559s | **11.3x** | **5.5x** |
| wc | default 10MB repetitive | 0.0731s | 0.0050s | 0.0482s | **14.6x** | **9.6x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0036s | 0.0070s | **6.2x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0036s | 0.0070s | **6.3x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0050s | 0.0083s | **3.3x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0079s | 0.0176s | **2.8x** | **2.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0238s | 0.0053s | 0.0133s | **4.5x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0054s | 0.0165s | **5.6x** | **3.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0097s | 0.0083s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0102s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0753s | 0.0749s | 0.0746s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0171s | 0.0176s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0183s | 0.0223s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1608s | 0.1531s | 0.2029s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0127s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0161s | 0.0140s | 0.0141s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1433s | 0.1116s | 0.1125s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0123s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0123s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0017s | 0.0018s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0122s | 0.0043s | 0.0081s | **2.9x** | **1.9x** |
| base64 | encode 10MB binary | 0.0129s | 0.0044s | 0.0084s | **2.9x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0044s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0324s | 0.0048s | 0.0336s | **6.8x** | **7.1x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0043s | 0.0082s | **2.8x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0040s | 0.0073s | **2.2x** | **1.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0035s | 0.0055s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0089s | 0.0356s | **6.0x** | **4.0x** |
| sort | already sorted 10MB | 0.0262s | 0.0048s | 0.0177s | **5.5x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0064s | 0.0175s | **4.2x** | **2.8x** |
| sort | -n numeric 10MB | 0.0735s | 0.0054s | 0.0836s | **13.6x** | **15.5x** |
| sort | -r reverse 10MB | 0.0632s | 0.0113s | 0.0382s | **5.6x** | **3.4x** |
| sort | -u unique 10MB | 0.0662s | 0.0091s | 0.0393s | **7.3x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0663s | 0.0194s | 0.0821s | **3.4x** | **4.2x** |
| sort | repetitive 10MB | 0.0569s | 0.0124s | 0.0371s | **4.6x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0086s | 0.0360s | **6.2x** | **4.2x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0037s | 0.0074s | **3.4x** | **2.0x** |
| tr | -d digits 10MB | 0.0179s | 0.0042s | 0.0137s | **4.3x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0303s | 0.0048s | 0.0210s | **6.3x** | **4.3x** |
| tr | -s spaces 10MB | 0.0259s | 0.0037s | 0.0265s | **7.0x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0038s | 0.0074s | **3.3x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0042s | 0.0135s | **3.8x** | **3.2x** |
| tr | translate binary 10MB | 0.0111s | 0.0041s | 0.0082s | **2.7x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | 0.0112s | **6.1x** | **5.8x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0031s | 0.0129s | **4.6x** | **4.2x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | 0.0112s | **6.4x** | **6.0x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0078s | 0.0153s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0019s | 0.0112s | **6.4x** | **6.0x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | 0.0112s | **6.4x** | **6.0x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0044s | 0.0129s | **3.2x** | **2.9x** |
| uniq | repetitive 10MB | 0.0418s | 0.0036s | 0.0160s | **11.6x** | **4.5x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0045s | 0.0058s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1040s | 0.0263s | 0.0518s | **4.0x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0048s | 0.0057s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0229s | 0.0097s | 0.0110s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0060s | 0.0042s | 0.0054s | **1.4x** | **1.3x** |
