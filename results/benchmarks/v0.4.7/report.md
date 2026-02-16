# fcoreutils v0.4.7 — Detailed Results

Generated: 2026-02-16 02:00:04 UTC

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
| wc | default 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0343s | 0.0064s | 0.0256s | **5.3x** | **4.0x** |
| wc | default 100MB text | 0.3001s | 0.0418s | 0.2270s | **7.2x** | **5.4x** |
| wc | -l 10MB text | 0.0041s | 0.0020s | 0.0025s | **2.1x** | **1.3x** |
| wc | -w 10MB text | 0.0346s | 0.0063s | 0.0237s | **5.5x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0010s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0345s | 0.0020s | 0.0026s | **16.9x** | **1.3x** |
| wc | -L 10MB text | 0.0345s | 0.0062s | 0.0176s | **5.6x** | **2.9x** |
| wc | default 10MB binary | 0.2343s | 0.0174s | 0.1181s | **13.5x** | **6.8x** |
| wc | default 10MB repetitive | 0.0519s | 0.0075s | 0.0366s | **6.9x** | **4.9x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0033s | 0.0061s | **5.6x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0033s | 0.0062s | **5.6x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0030s | 0.0069s | **6.2x** | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0044s | 0.0165s | **4.8x** | **3.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0031s | 0.0125s | **7.5x** | **4.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0042s | 0.0161s | **6.3x** | **3.9x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0008s | 0.0008s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0014s | 0.0017s | **2.5x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | 0.0009s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0023s | 0.0013s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0016s | 0.0026s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0074s | 0.0087s | 0.0273s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0087s | 0.0287s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0689s | 0.0559s | 0.2630s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0020s | 0.0016s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0021s | 0.0012s | **0.7x** | **0.6x** |
| md5sum | single 1MB text | 0.0034s | 0.0035s | 0.0026s | **1.0x** | **0.7x** |
| md5sum | single 10MB text | 0.0209s | 0.0177s | 0.0176s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0184s | 0.0188s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2008s | 0.1441s | 0.1664s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0019s | 0.0016s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0139s | 0.0139s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0148s | 0.0143s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1357s | 0.1166s | 0.1292s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0137s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0136s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0016s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0096s | 0.0031s | 0.0071s | **3.1x** | **2.3x** |
| base64 | encode 10MB binary | 0.0102s | 0.0033s | 0.0074s | **3.1x** | **2.3x** |
| base64 | decode 1MB | 0.0037s | 0.0014s | 0.0035s | **2.6x** | **2.4x** |
| base64 | decode 10MB | 0.0304s | 0.0033s | 0.0265s | **9.3x** | **8.1x** |
| base64 | encode -w 76 10MB | 0.0094s | 0.0033s | 0.0071s | **2.9x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0076s | 0.0029s | 0.0072s | **2.6x** | **2.5x** |
| sort | lexicographic 1MB | 0.0074s | 0.0034s | 0.0042s | **2.2x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0508s | 0.0077s | 0.0282s | **6.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0251s | 0.0034s | 0.0137s | **7.4x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0045s | 0.0140s | **5.5x** | **3.1x** |
| sort | -n numeric 10MB | 0.0686s | 0.0039s | 0.0605s | **17.8x** | **15.7x** |
| sort | -r reverse 10MB | 0.0512s | 0.0071s | 0.0284s | **7.2x** | **4.0x** |
| sort | -u unique 10MB | 0.0536s | 0.0092s | 0.0355s | **5.8x** | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0697s | 0.0142s | 0.0675s | **4.9x** | **4.7x** |
| sort | repetitive 10MB | 0.0455s | 0.0099s | 0.0366s | **4.6x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0502s | 0.0075s | 0.0284s | **6.7x** | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0018s | 0.0018s | **1.0x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0075s | 0.0069s | **1.2x** | **0.9x** |
| tr | -d digits 10MB | 0.0111s | 0.0068s | 0.0102s | **1.6x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0186s | 0.0084s | 0.0169s | **2.2x** | **2.0x** |
| tr | -s spaces 10MB | 0.0165s | 0.0073s | 0.0114s | **2.3x** | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0075s | 0.0068s | **1.2x** | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0067s | 0.0102s | **1.6x** | **1.5x** |
| tr | translate binary 10MB | 0.0093s | 0.0077s | 0.0079s | **1.2x** | **1.0x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0026s | 0.0088s | **3.5x** | **3.3x** |
| uniq | default 10MB sorted (low dup) | 0.0166s | 0.0030s | 0.0098s | **5.5x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0029s | 0.0087s | **3.2x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0063s | 0.0115s | **4.7x** | **1.8x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0027s | 0.0086s | **3.5x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0039s | 0.0098s | **4.3x** | **2.5x** |
| uniq | repetitive 10MB | 0.0479s | 0.0034s | 0.0146s | **14.2x** | **4.4x** |
| tac | reverse 100KB text | 0.0011s | 0.0011s | 0.0010s | **1.1x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0013s | 0.0014s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0087s | 0.0031s | 0.0050s | **2.9x** | **1.6x** |
| tac | reverse 100MB text | 0.0856s | 0.0187s | 0.0428s | **4.6x** | **2.3x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0027s | 0.0045s | **3.0x** | **1.7x** |
| tac | reverse repetitive 10MB | 0.0180s | 0.0044s | 0.0088s | **4.1x** | **2.0x** |
| tac | custom separator 1MB | 0.0043s | 0.0030s | 0.0037s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0038s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0536s | 0.0026s | 0.0298s | **20.8x** | **11.5x** |
| wc | default 100MB text | 0.4824s | 0.0089s | 0.2538s | **53.9x** | **28.4x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0082s | 0.0256s | **6.6x** | **3.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0541s | 0.0025s | 0.0019s | **21.7x** | **0.8x** |
| wc | -L 10MB text | 0.0542s | 0.0106s | 0.0195s | **5.1x** | **1.8x** |
| wc | default 10MB binary | 0.3177s | 0.0264s | 0.1541s | **12.0x** | **5.8x** |
| wc | default 10MB repetitive | 0.0738s | 0.0034s | 0.0400s | **21.5x** | **11.7x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.1x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0035s | 0.0073s | **6.4x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0035s | 0.0073s | **6.4x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0036s | 0.0085s | **4.6x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0066s | 0.0173s | **3.3x** | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0047s | 0.0134s | **5.1x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0051s | 0.0163s | **6.0x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0015s | 0.0020s | **2.2x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0098s | 0.0084s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0103s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0747s | 0.0754s | 0.0753s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0025s | 0.0023s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0177s | 0.0214s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0186s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1610s | 0.1532s | 0.2029s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0026s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0151s | 0.0129s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0160s | 0.0132s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1426s | 0.1118s | 0.1128s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0123s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0124s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0013s | 0.0019s | **1.6x** | **1.4x** |
| base64 | encode 10MB text | 0.0125s | 0.0037s | 0.0084s | **3.4x** | **2.3x** |
| base64 | encode 10MB binary | 0.0129s | 0.0038s | 0.0085s | **3.4x** | **2.2x** |
| base64 | decode 1MB | 0.0040s | 0.0014s | 0.0044s | **2.9x** | **3.2x** |
| base64 | decode 10MB | 0.0327s | 0.0041s | 0.0344s | **8.1x** | **8.5x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0036s | 0.0081s | **3.4x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0032s | 0.0071s | **2.7x** | **2.2x** |
| sort | lexicographic 1MB | 0.0086s | 0.0037s | 0.0055s | **2.4x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0094s | 0.0355s | **5.8x** | **3.8x** |
| sort | already sorted 10MB | 0.0268s | 0.0045s | 0.0179s | **6.0x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0067s | 0.0175s | **4.1x** | **2.6x** |
| sort | -n numeric 10MB | 0.0733s | 0.0058s | 0.0743s | **12.6x** | **12.7x** |
| sort | -r reverse 10MB | 0.0548s | 0.0096s | 0.0356s | **5.7x** | **3.7x** |
| sort | -u unique 10MB | 0.0573s | 0.0096s | 0.0394s | **6.0x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0663s | 0.0185s | 0.0817s | **3.6x** | **4.4x** |
| sort | repetitive 10MB | 0.0553s | 0.0120s | 0.0379s | **4.6x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0551s | 0.0098s | 0.0355s | **5.6x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0022s | 0.0020s | **1.1x** | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0138s | 0.0103s | 0.0078s | **1.3x** | **0.8x** |
| tr | -d digits 10MB | 0.0167s | 0.0089s | 0.0144s | **1.9x** | **1.6x** |
| tr | -d lowercase 10MB | 0.0322s | 0.0116s | 0.0232s | **2.8x** | **2.0x** |
| tr | -s spaces 10MB | 0.0269s | 0.0095s | 0.0277s | **2.8x** | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0102s | 0.0074s | **1.2x** | **0.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0090s | 0.0145s | **1.8x** | **1.6x** |
| tr | translate binary 10MB | 0.0116s | 0.0106s | 0.0084s | **1.1x** | **0.8x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0035s | 0.0112s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0035s | 0.0133s | **3.9x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0085s | 0.0156s | **3.4x** | **1.8x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0122s | 0.0035s | 0.0114s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0046s | 0.0137s | **3.0x** | **3.0x** |
| uniq | repetitive 10MB | 0.0424s | 0.0042s | 0.0165s | **10.0x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0108s | 0.0040s | 0.0059s | **2.7x** | **1.5x** |
| tac | reverse 100MB text | 0.1040s | 0.0240s | 0.0521s | **4.3x** | **2.2x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0034s | 0.0056s | **2.7x** | **1.7x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0059s | 0.0109s | **4.1x** | **1.9x** |
| tac | custom separator 1MB | 0.0060s | 0.0037s | 0.0053s | **1.6x** | **1.4x** |
