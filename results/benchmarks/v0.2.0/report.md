# fcoreutils v0.2.0 — Detailed Results

Generated: 2026-02-16 09:50:00 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0036s | 0.0024s | 0.0033s | **1.5x** | **1.4x** |
| wc | default 10MB text | 0.0340s | 0.0066s | 0.0252s | **5.1x** | **3.8x** |
| wc | default 100MB text | 0.2953s | 0.0428s | 0.2238s | **6.9x** | **5.2x** |
| wc | -l 10MB text | 0.0039s | 0.0019s | 0.0024s | **2.0x** | **1.2x** |
| wc | -w 10MB text | 0.0338s | 0.0060s | 0.0226s | **5.6x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0340s | 0.0022s | 0.0024s | **15.5x** | **1.1x** |
| wc | -L 10MB text | 0.0340s | 0.0057s | 0.0173s | **5.9x** | **3.0x** |
| wc | default 10MB binary | 0.2355s | 0.0167s | 0.1180s | **14.1x** | **7.1x** |
| wc | default 10MB repetitive | 0.0522s | 0.0080s | 0.0362s | **6.6x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0180s | 0.0032s | 0.0060s | **5.6x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0181s | 0.0030s | 0.0059s | **6.1x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0182s | 0.0040s | 0.0068s | **4.5x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0048s | 0.0159s | **4.4x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0228s | 0.0032s | 0.0123s | **7.1x** | **3.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0259s | 0.0030s | 0.0159s | **8.6x** | **5.3x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0010s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0021s | 0.0017s | **1.6x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0016s | 0.0026s | 0.0036s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0072s | 0.0073s | 0.0270s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0076s | 0.0285s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0657s | 0.0549s | 0.2594s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0026s | 0.0011s | **0.4x** | **0.4x** |
| sha256sum | 100 files | 0.0018s | 0.0028s | 0.0016s | **0.6x** | **0.6x** |
| md5sum | single 100KB text | 0.0013s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0034s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0208s | 0.0160s | 0.0171s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0214s | 0.0167s | 0.0181s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.1972s | 0.1425s | 0.1626s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0011s | 0.0025s | 0.0011s | **0.4x** | **0.4x** |
| md5sum | 100 files | 0.0016s | 0.0028s | 0.0016s | **0.6x** | **0.6x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0023s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0138s | 0.0124s | 0.0133s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0146s | 0.0130s | 0.0141s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1322s | 0.1150s | 0.1256s | **1.1x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0136s | 0.0123s | 0.0133s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0137s | 0.0124s | 0.0132s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0009s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0017s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0093s | 0.0030s | 0.0069s | **3.1x** | **2.3x** |
| base64 | encode 10MB binary | 0.0100s | 0.0030s | 0.0072s | **3.3x** | **2.4x** |
| base64 | decode 1MB | 0.0037s | 0.0019s | 0.0035s | **1.9x** | **1.8x** |
| base64 | decode 10MB | 0.0303s | 0.0080s | 0.0265s | **3.8x** | **3.3x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0032s | 0.0069s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0031s | 0.0070s | **2.4x** | **2.2x** |
| sort | lexicographic 1MB | 0.0074s | 0.0026s | 0.0041s | **2.8x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0503s | 0.0064s | 0.0281s | **7.8x** | **4.4x** |
| sort | already sorted 10MB | 0.0248s | 0.0033s | 0.0132s | **7.6x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0246s | 0.0043s | 0.0135s | **5.7x** | **3.1x** |
| sort | -n numeric 10MB | 0.0684s | 0.0039s | 0.0617s | **17.6x** | **15.8x** |
| sort | -r reverse 10MB | 0.0516s | 0.0061s | 0.0288s | **8.4x** | **4.7x** |
| sort | -u unique 10MB | 0.0534s | 0.0078s | 0.0345s | **6.9x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0688s | 0.0137s | 0.0674s | **5.0x** | **4.9x** |
| sort | repetitive 10MB | 0.0455s | 0.0100s | 0.0349s | **4.5x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0499s | 0.0061s | 0.0279s | **8.2x** | **4.6x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0015s | 0.0017s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0038s | 0.0069s | **2.3x** | **1.8x** |
| tr | -d digits 10MB | 0.0111s | 0.0052s | 0.0101s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0066s | 0.0168s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0165s | 0.0038s | 0.0114s | **4.4x** | **3.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0038s | 0.0067s | **2.4x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0052s | 0.0102s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0092s | 0.0040s | 0.0077s | **2.3x** | **1.9x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0027s | 0.0085s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0029s | 0.0097s | **5.7x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0029s | 0.0088s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0068s | 0.0112s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0026s | 0.0087s | **3.5x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0026s | 0.0086s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0040s | 0.0094s | **4.1x** | **2.3x** |
| uniq | repetitive 10MB | 0.0476s | 0.0034s | 0.0142s | **14.1x** | **4.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0018s | 0.0015s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0080s | 0.0035s | 0.0047s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.0818s | 0.0219s | 0.0416s | **3.7x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0034s | 0.0043s | **2.2x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0179s | 0.0067s | 0.0085s | **2.7x** | **1.3x** |
| tac | custom separator 1MB | 0.0042s | 0.0032s | 0.0037s | **1.3x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0015s | 0.0012s | 0.0016s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0550s | 0.0037s | 0.0299s | **15.0x** | **8.2x** |
| wc | default 100MB text | 0.4833s | 0.0139s | 0.2560s | **34.7x** | **18.4x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0542s | 0.0090s | 0.0258s | **6.0x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0544s | 0.0030s | 0.0021s | **18.1x** | **0.7x** |
| wc | -L 10MB text | 0.0547s | 0.0099s | 0.0199s | **5.5x** | **2.0x** |
| wc | default 10MB binary | 0.3181s | 0.0275s | 0.1542s | **11.6x** | **5.6x** |
| wc | default 10MB repetitive | 0.0729s | 0.0045s | 0.0398s | **16.2x** | **8.9x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0047s | 0.0073s | **4.8x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0228s | 0.0047s | 0.0073s | **4.8x** | **1.5x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0052s | 0.0085s | **3.2x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0223s | 0.0067s | 0.0176s | **3.3x** | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0052s | 0.0133s | **4.6x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0046s | 0.0163s | **6.6x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0095s | 0.0084s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0099s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0764s | 0.0756s | 0.0755s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0034s | 0.0014s | **0.4x** | **0.4x** |
| sha256sum | 100 files | 0.0024s | 0.0037s | 0.0023s | **0.7x** | **0.6x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0038s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0173s | 0.0174s | 0.0214s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0181s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1627s | 0.1527s | 0.2036s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0033s | 0.0014s | **0.4x** | **0.4x** |
| md5sum | 100 files | 0.0023s | 0.0037s | 0.0024s | **0.6x** | **0.6x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | 0.0014s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0024s | 0.0023s | 0.0024s | **1.0x** | **1.0x** |
| b2sum | single 10MB text | 0.0152s | 0.0121s | 0.0122s | **1.3x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0126s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1436s | 0.1116s | 0.1131s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0121s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0121s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0025s | 0.0024s | **0.9x** | **0.9x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0123s | 0.0048s | 0.0082s | **2.6x** | **1.7x** |
| base64 | encode 10MB binary | 0.0128s | 0.0052s | 0.0088s | **2.5x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0020s | 0.0044s | **2.0x** | **2.2x** |
| base64 | decode 10MB | 0.0323s | 0.0104s | 0.0337s | **3.1x** | **3.2x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0048s | 0.0082s | **2.5x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0038s | 0.0071s | **2.3x** | **1.9x** |
| sort | lexicographic 1MB | 0.0086s | 0.0032s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0540s | 0.0096s | 0.0355s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0261s | 0.0042s | 0.0177s | **6.2x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0065s | 0.0174s | **4.2x** | **2.7x** |
| sort | -n numeric 10MB | 0.0731s | 0.0056s | 0.0751s | **13.0x** | **13.4x** |
| sort | -r reverse 10MB | 0.0550s | 0.0095s | 0.0359s | **5.8x** | **3.8x** |
| sort | -u unique 10MB | 0.0578s | 0.0097s | 0.0394s | **6.0x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0663s | 0.0189s | 0.0831s | **3.5x** | **4.4x** |
| sort | repetitive 10MB | 0.0560s | 0.0120s | 0.0373s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0542s | 0.0097s | 0.0368s | **5.6x** | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0017s | 0.0020s | **1.4x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0039s | 0.0077s | **3.2x** | **2.0x** |
| tr | -d digits 10MB | 0.0168s | 0.0043s | 0.0141s | **3.9x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0321s | 0.0056s | 0.0227s | **5.7x** | **4.1x** |
| tr | -s spaces 10MB | 0.0263s | 0.0039s | 0.0283s | **6.8x** | **7.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0039s | 0.0072s | **3.4x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0046s | 0.0143s | **3.7x** | **3.1x** |
| tr | translate binary 10MB | 0.0114s | 0.0041s | 0.0080s | **2.8x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0036s | 0.0113s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0036s | 0.0133s | **3.9x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0093s | 0.0156s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0034s | 0.0112s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0044s | 0.0134s | **3.2x** | **3.1x** |
| uniq | repetitive 10MB | 0.0418s | 0.0041s | 0.0161s | **10.2x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0024s | 0.0018s | **0.8x** | **0.8x** |
| tac | reverse 10MB text | 0.0104s | 0.0043s | 0.0058s | **2.4x** | **1.4x** |
| tac | reverse 100MB text | 0.1041s | 0.0267s | 0.0520s | **3.9x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0046s | 0.0057s | **2.0x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0233s | 0.0085s | 0.0116s | **2.7x** | **1.4x** |
| tac | custom separator 1MB | 0.0061s | 0.0044s | 0.0053s | **1.4x** | **1.2x** |
