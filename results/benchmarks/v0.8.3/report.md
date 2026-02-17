# fcoreutils v0.8.3 — Detailed Results

Generated: 2026-02-17 06:44:37 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0027s | 0.0034s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0061s | 0.0272s | **5.7x** | **4.5x** |
| wc | default 100MB text | 0.3010s | 0.0467s | 0.2457s | **6.4x** | **5.3x** |
| wc | -l 10MB text | 0.0044s | 0.0021s | 0.0028s | **2.1x** | **1.3x** |
| wc | -w 10MB text | 0.0345s | 0.0061s | 0.0232s | **5.6x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0346s | 0.0023s | 0.0028s | **15.2x** | **1.2x** |
| wc | -L 10MB text | 0.0345s | 0.0065s | 0.0178s | **5.3x** | **2.7x** |
| wc | default 10MB binary | 0.2349s | 0.0171s | 0.1160s | **13.7x** | **6.8x** |
| wc | default 10MB repetitive | 0.0525s | 0.0079s | 0.0431s | **6.6x** | **5.4x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0035s | 0.0063s | **5.3x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0035s | 0.0062s | **5.3x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0095s | 0.0070s | **2.0x** | **0.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0117s | 0.0165s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0097s | 0.0129s | **2.4x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0099s | 0.0164s | **2.7x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0011s | 0.0010s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | 0.0018s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0024s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0029s | 0.0038s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0080s | 0.0091s | 0.0278s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0095s | 0.0291s | **0.9x** | **3.1x** |
| sha256sum | single 100MB text | 0.0705s | 0.0697s | 0.2643s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0012s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0018s | 0.0020s | 0.0018s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0212s | 0.0175s | 0.0176s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0223s | 0.0184s | 0.0185s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2017s | 0.1449s | 0.1682s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0023s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0014s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0143s | 0.0139s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0152s | 0.0145s | 0.0148s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1369s | 0.1159s | 0.1307s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0139s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0139s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0017s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0102s | 0.0035s | 0.0075s | **2.9x** | **2.1x** |
| base64 | encode 10MB binary | 0.0108s | 0.0034s | 0.0080s | **3.1x** | **2.3x** |
| base64 | decode 1MB | 0.0038s | 0.0018s | 0.0035s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0307s | 0.0042s | 0.0263s | **7.4x** | **6.3x** |
| base64 | encode -w 76 10MB | 0.0099s | 0.0034s | 0.0074s | **2.9x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0079s | 0.0033s | 0.0075s | **2.4x** | **2.2x** |
| sort | lexicographic 1MB | 0.0076s | 0.0031s | 0.0044s | **2.5x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0521s | 0.0100s | 0.0312s | **5.2x** | **3.1x** |
| sort | already sorted 10MB | 0.0252s | 0.0034s | 0.0136s | **7.4x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0251s | 0.0050s | 0.0145s | **5.1x** | **2.9x** |
| sort | -n numeric 10MB | 0.0702s | 0.0040s | 0.0670s | **17.6x** | **16.8x** |
| sort | -r reverse 10MB | 0.0529s | 0.0097s | 0.0316s | **5.4x** | **3.2x** |
| sort | -u unique 10MB | 0.0554s | 0.0115s | 0.0370s | **4.8x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0734s | 0.0160s | 0.0684s | **4.6x** | **4.3x** |
| sort | repetitive 10MB | 0.0459s | 0.0099s | 0.0362s | **4.6x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0512s | 0.0092s | 0.0291s | **5.5x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | 0.0017s | **1.2x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0041s | 0.0069s | **2.2x** | **1.7x** |
| tr | -d digits 10MB | 0.0111s | 0.0051s | 0.0101s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0185s | 0.0066s | 0.0165s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0165s | 0.0040s | 0.0112s | **4.2x** | **2.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0039s | 0.0068s | **2.3x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0052s | 0.0102s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0093s | 0.0041s | 0.0077s | **2.3x** | **1.9x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0017s | 0.0088s | **5.4x** | **5.2x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0026s | 0.0098s | **6.3x** | **3.8x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0017s | 0.0089s | **5.5x** | **5.2x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0069s | 0.0117s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0017s | 0.0089s | **5.5x** | **5.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0017s | 0.0090s | **5.5x** | **5.3x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0040s | 0.0099s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0480s | 0.0029s | 0.0154s | **16.4x** | **5.3x** |
| tac | reverse 100KB text | 0.0008s | 0.0013s | 0.0011s | **0.6x** | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | 0.0015s | **0.9x** | **0.9x** |
| tac | reverse 10MB text | 0.0089s | 0.0052s | 0.0051s | **1.7x** | **1.0x** |
| tac | reverse 100MB text | 0.0871s | 0.0223s | 0.0451s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0047s | 0.0045s | **1.7x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0183s | 0.0095s | 0.0088s | **1.9x** | **0.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0039s | 0.0038s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0028s | 0.0039s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0547s | 0.0032s | 0.0313s | **17.1x** | **9.8x** |
| wc | default 100MB text | 0.4832s | 0.0140s | 0.2671s | **34.5x** | **19.1x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0020s | **0.9x** | **0.8x** |
| wc | -w 10MB text | 0.0549s | 0.0093s | 0.0257s | **5.9x** | **2.8x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0544s | 0.0030s | 0.0020s | **17.9x** | **0.6x** |
| wc | -L 10MB text | 0.0546s | 0.0110s | 0.0168s | **5.0x** | **1.5x** |
| wc | default 10MB binary | 0.3177s | 0.0273s | 0.1547s | **11.6x** | **5.7x** |
| wc | default 10MB repetitive | 0.0733s | 0.0047s | 0.0425s | **15.6x** | **9.1x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0227s | 0.0040s | 0.0072s | **5.7x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0040s | 0.0072s | **5.7x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0094s | 0.0085s | **1.8x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0117s | 0.0186s | **1.9x** | **1.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0106s | 0.0137s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0310s | 0.0108s | 0.0168s | **2.9x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0030s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0028s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0033s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0086s | 0.0103s | 0.0084s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0106s | 0.0090s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0759s | 0.0751s | 0.0756s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.7x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0027s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0173s | 0.0182s | 0.0215s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0182s | 0.0189s | 0.0226s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1616s | 0.1534s | 0.2036s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.2x** |
| b2sum | single 10MB text | 0.0151s | 0.0127s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0132s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1450s | 0.1126s | 0.1135s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0129s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0157s | 0.0127s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0024s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0011s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | 0.0018s | **1.3x** | **1.1x** |
| base64 | encode 10MB text | 0.0124s | 0.0047s | 0.0083s | **2.7x** | **1.8x** |
| base64 | encode 10MB binary | 0.0138s | 0.0047s | 0.0086s | **2.9x** | **1.8x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0044s | **1.8x** | **1.9x** |
| base64 | decode 10MB | 0.0326s | 0.0049s | 0.0340s | **6.6x** | **6.9x** |
| base64 | encode -w 76 10MB | 0.0125s | 0.0045s | 0.0082s | **2.8x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0041s | 0.0073s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0086s | 0.0034s | 0.0055s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0544s | 0.0092s | 0.0359s | **5.9x** | **3.9x** |
| sort | already sorted 10MB | 0.0266s | 0.0050s | 0.0177s | **5.3x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0065s | 0.0181s | **4.2x** | **2.8x** |
| sort | -n numeric 10MB | 0.0739s | 0.0055s | 0.0765s | **13.5x** | **14.0x** |
| sort | -r reverse 10MB | 0.0548s | 0.0092s | 0.0367s | **6.0x** | **4.0x** |
| sort | -u unique 10MB | 0.0574s | 0.0095s | 0.0395s | **6.1x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0667s | 0.0199s | 0.0832s | **3.3x** | **4.2x** |
| sort | repetitive 10MB | 0.0575s | 0.0126s | 0.0373s | **4.5x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0548s | 0.0093s | 0.0359s | **5.9x** | **3.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0017s | 0.0020s | **1.4x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0144s | 0.0038s | 0.0077s | **3.8x** | **2.0x** |
| tr | -d digits 10MB | 0.0172s | 0.0043s | 0.0135s | **4.0x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0296s | 0.0051s | 0.0213s | **5.8x** | **4.2x** |
| tr | -s spaces 10MB | 0.0281s | 0.0039s | 0.0281s | **7.1x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0039s | 0.0075s | **3.3x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0184s | 0.0043s | 0.0136s | **4.2x** | **3.1x** |
| tr | translate binary 10MB | 0.0124s | 0.0039s | 0.0081s | **3.2x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0019s | 0.0111s | **6.3x** | **6.0x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0031s | 0.0129s | **4.5x** | **4.2x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | 0.0111s | **6.4x** | **5.9x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0078s | 0.0153s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0020s | 0.0111s | **6.2x** | **5.7x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0019s | 0.0111s | **6.3x** | **5.8x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0043s | 0.0129s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0421s | 0.0038s | 0.0161s | **11.2x** | **4.3x** |
| tac | reverse 100KB text | 0.0010s | 0.0014s | 0.0013s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0019s | 0.0017s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0108s | 0.0059s | 0.0058s | **1.8x** | **1.0x** |
| tac | reverse 100MB text | 0.1047s | 0.0273s | 0.0524s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0058s | 0.0057s | **1.6x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0233s | 0.0109s | 0.0112s | **2.1x** | **1.0x** |
| tac | custom separator 1MB | 0.0059s | 0.0051s | 0.0054s | **1.2x** | **1.1x** |
