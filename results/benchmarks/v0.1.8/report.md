# fcoreutils v0.1.8 — Detailed Results

Generated: 2026-02-16 18:46:36 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0341s | 0.0067s | 0.0260s | **5.1x** | **3.9x** |
| wc | default 100MB text | 0.2979s | 0.0456s | 0.2260s | **6.5x** | **5.0x** |
| wc | -l 10MB text | 0.0040s | 0.0021s | 0.0024s | **1.9x** | **1.2x** |
| wc | -w 10MB text | 0.0339s | 0.0059s | 0.0229s | **5.7x** | **3.9x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0340s | 0.0022s | 0.0022s | **15.4x** | **1.0x** |
| wc | -L 10MB text | 0.0338s | 0.0060s | 0.0171s | **5.7x** | **2.9x** |
| wc | default 10MB binary | 0.2347s | 0.0172s | 0.1180s | **13.7x** | **6.9x** |
| wc | default 10MB repetitive | 0.0527s | 0.0082s | 0.0365s | **6.4x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0032s | 0.0061s | **5.7x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0183s | 0.0031s | 0.0062s | **5.9x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0043s | 0.0068s | **4.3x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0050s | 0.0161s | **4.2x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0228s | 0.0033s | 0.0124s | **7.0x** | **3.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0262s | 0.0031s | 0.0159s | **8.3x** | **5.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0020s | 0.0018s | **1.7x** | **0.9x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0009s | **0.8x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0021s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0025s | 0.0037s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0069s | 0.0072s | 0.0269s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0075s | 0.0284s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0673s | 0.0549s | 0.2614s | **1.2x** | **4.8x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | 0.0017s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0036s | 0.0027s | **0.8x** | **0.8x** |
| md5sum | single 10MB text | 0.0205s | 0.0161s | 0.0169s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0217s | 0.0167s | 0.0179s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.1998s | 0.1433s | 0.1653s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0020s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0024s | 0.0016s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | 0.0023s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0134s | 0.0124s | 0.0132s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0141s | 0.0130s | 0.0138s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1354s | 0.1162s | 0.1279s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0134s | 0.0125s | 0.0133s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0136s | 0.0125s | 0.0132s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0014s | 0.0016s | **1.1x** | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0092s | 0.0032s | 0.0070s | **2.9x** | **2.2x** |
| base64 | encode 10MB binary | 0.0101s | 0.0033s | 0.0073s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0036s | 0.0019s | 0.0035s | **1.9x** | **1.8x** |
| base64 | decode 10MB | 0.0305s | 0.0080s | 0.0266s | **3.8x** | **3.3x** |
| base64 | encode -w 76 10MB | 0.0092s | 0.0033s | 0.0070s | **2.8x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0071s | 0.0031s | 0.0069s | **2.3x** | **2.2x** |
| sort | lexicographic 1MB | 0.0075s | 0.0026s | 0.0041s | **2.9x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0514s | 0.0062s | 0.0287s | **8.3x** | **4.6x** |
| sort | already sorted 10MB | 0.0246s | 0.0033s | 0.0130s | **7.4x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0043s | 0.0137s | **5.6x** | **3.2x** |
| sort | -n numeric 10MB | 0.0695s | 0.0039s | 0.0603s | **17.9x** | **15.5x** |
| sort | -r reverse 10MB | 0.0517s | 0.0063s | 0.0287s | **8.2x** | **4.5x** |
| sort | -u unique 10MB | 0.0541s | 0.0072s | 0.0337s | **7.5x** | **4.7x** |
| sort | -t, -k2 CSV 10MB | 0.0699s | 0.0141s | 0.0655s | **4.9x** | **4.6x** |
| sort | repetitive 10MB | 0.0449s | 0.0099s | 0.0362s | **4.5x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0507s | 0.0062s | 0.0288s | **8.2x** | **4.7x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0017s | 0.0018s | **1.1x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0067s | 0.0068s | **1.4x** | **1.0x** |
| tr | -d digits 10MB | 0.0112s | 0.0078s | 0.0102s | **1.4x** | **1.3x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0106s | 0.0168s | **1.8x** | **1.6x** |
| tr | -s spaces 10MB | 0.0169s | 0.0068s | 0.0115s | **2.5x** | **1.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0063s | 0.0068s | **1.4x** | **1.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0077s | 0.0102s | **1.4x** | **1.3x** |
| tr | translate binary 10MB | 0.0092s | 0.0069s | 0.0075s | **1.3x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0026s | 0.0086s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0029s | 0.0094s | **5.6x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0030s | 0.0085s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0069s | 0.0112s | **4.2x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0026s | 0.0086s | **3.4x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0038s | 0.0094s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0482s | 0.0035s | 0.0145s | **13.7x** | **4.1x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0018s | 0.0015s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0082s | 0.0032s | 0.0049s | **2.6x** | **1.5x** |
| tac | reverse 100MB text | 0.0835s | 0.0189s | 0.0421s | **4.4x** | **2.2x** |
| tac | reverse CSV 10MB | 0.0078s | 0.0033s | 0.0045s | **2.4x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0182s | 0.0053s | 0.0087s | **3.4x** | **1.6x** |
| tac | custom separator 1MB | 0.0042s | 0.0028s | 0.0037s | **1.5x** | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0044s | **2.0x** | **1.6x** |
| wc | default 10MB text | 0.0532s | 0.0031s | 0.0360s | **17.2x** | **11.6x** |
| wc | default 100MB text | 0.4830s | 0.0140s | 0.3163s | **34.6x** | **22.7x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0106s | 0.0266s | **5.1x** | **2.5x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0539s | 0.0030s | 0.0020s | **18.2x** | **0.7x** |
| wc | -L 10MB text | 0.0539s | 0.0103s | 0.0163s | **5.2x** | **1.6x** |
| wc | default 10MB binary | 0.3182s | 0.0271s | 0.1579s | **11.7x** | **5.8x** |
| wc | default 10MB repetitive | 0.0729s | 0.0045s | 0.0522s | **16.1x** | **11.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0023s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0047s | 0.0070s | **4.8x** | **1.5x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0045s | 0.0070s | **4.9x** | **1.5x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0049s | 0.0082s | **3.4x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0068s | 0.0177s | **3.2x** | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0052s | 0.0134s | **4.6x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0304s | 0.0046s | 0.0165s | **6.6x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0083s | 0.0095s | 0.0084s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0099s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0755s | 0.0749s | 0.0751s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0030s | 0.0023s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0025s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0173s | 0.0211s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0182s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1616s | 0.1526s | 0.2030s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0031s | 0.0024s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | 0.0014s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0127s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1434s | 0.1117s | 0.1126s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0018s | 0.0023s | **1.2x** | **1.3x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | 0.0018s | **1.4x** | **1.3x** |
| base64 | encode 10MB text | 0.0122s | 0.0049s | 0.0080s | **2.5x** | **1.7x** |
| base64 | encode 10MB binary | 0.0127s | 0.0052s | 0.0086s | **2.4x** | **1.6x** |
| base64 | decode 1MB | 0.0040s | 0.0019s | 0.0043s | **2.1x** | **2.2x** |
| base64 | decode 10MB | 0.0324s | 0.0102s | 0.0332s | **3.2x** | **3.2x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0048s | 0.0081s | **2.5x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0040s | 0.0072s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0086s | 0.0032s | 0.0054s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0542s | 0.0098s | 0.0355s | **5.5x** | **3.6x** |
| sort | already sorted 10MB | 0.0260s | 0.0042s | 0.0176s | **6.2x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0066s | 0.0180s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0729s | 0.0059s | 0.0746s | **12.4x** | **12.7x** |
| sort | -r reverse 10MB | 0.0543s | 0.0098s | 0.0359s | **5.6x** | **3.7x** |
| sort | -u unique 10MB | 0.0574s | 0.0098s | 0.0397s | **5.9x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0662s | 0.0192s | 0.0824s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0552s | 0.0117s | 0.0368s | **4.7x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0538s | 0.0099s | 0.0356s | **5.4x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0018s | 0.0020s | **1.3x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0139s | 0.0068s | 0.0076s | **2.0x** | **1.1x** |
| tr | -d digits 10MB | 0.0172s | 0.0104s | 0.0139s | **1.7x** | **1.3x** |
| tr | -d lowercase 10MB | 0.0294s | 0.0138s | 0.0209s | **2.1x** | **1.5x** |
| tr | -s spaces 10MB | 0.0286s | 0.0065s | 0.0268s | **4.4x** | **4.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0124s | 0.0067s | 0.0073s | **1.9x** | **1.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0170s | 0.0105s | 0.0133s | **1.6x** | **1.3x** |
| tr | translate binary 10MB | 0.0114s | 0.0064s | 0.0081s | **1.8x** | **1.3x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0036s | 0.0111s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0038s | 0.0127s | **3.7x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0288s | 0.0091s | 0.0152s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0035s | 0.0111s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0035s | 0.0111s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0138s | 0.0043s | 0.0128s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0417s | 0.0041s | 0.0161s | **10.2x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0019s | 0.0023s | 0.0018s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0104s | 0.0045s | 0.0058s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1047s | 0.0255s | 0.0516s | **4.1x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0040s | 0.0057s | **2.3x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0072s | 0.0108s | **3.2x** | **1.5x** |
| tac | custom separator 1MB | 0.0059s | 0.0038s | 0.0054s | **1.5x** | **1.4x** |
