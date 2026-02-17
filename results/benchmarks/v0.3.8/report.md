# fcoreutils v0.3.8 — Detailed Results

Generated: 2026-02-17 02:54:04 UTC

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
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0337s | 0.0060s | 0.0249s | **5.7x** | **4.2x** |
| wc | default 100MB text | 0.2980s | 0.0421s | 0.2261s | **7.1x** | **5.4x** |
| wc | -l 10MB text | 0.0037s | 0.0019s | 0.0019s | **2.0x** | **1.0x** |
| wc | -w 10MB text | 0.0337s | 0.0059s | 0.0225s | **5.8x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | 0.0009s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0340s | 0.0019s | 0.0021s | **17.6x** | **1.1x** |
| wc | -L 10MB text | 0.0336s | 0.0059s | 0.0172s | **5.7x** | **2.9x** |
| wc | default 10MB binary | 0.2349s | 0.0166s | 0.1176s | **14.2x** | **7.1x** |
| wc | default 10MB repetitive | 0.0518s | 0.0075s | 0.0362s | **6.9x** | **4.8x** |
| wc | 10 files | 0.0007s | 0.0010s | 0.0012s | **0.7x** | **1.2x** |
| wc | 100 files | 0.0012s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0182s | 0.0036s | 0.0056s | **5.1x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0179s | 0.0036s | 0.0058s | **5.0x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0182s | 0.0027s | 0.0066s | **6.7x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0205s | 0.0046s | 0.0160s | **4.5x** | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0226s | 0.0031s | 0.0122s | **7.3x** | **3.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0262s | 0.0045s | 0.0155s | **5.8x** | **3.4x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | 0.0009s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0014s | 0.0016s | **2.3x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0009s | 0.0009s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0010s | 0.0018s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0023s | 0.0035s | **0.7x** | **1.5x** |
| sha256sum | single 10MB text | 0.0068s | 0.0079s | 0.0266s | **0.9x** | **3.4x** |
| sha256sum | single 10MB binary | 0.0071s | 0.0080s | 0.0277s | **0.9x** | **3.4x** |
| sha256sum | single 100MB text | 0.0671s | 0.0547s | 0.2615s | **1.2x** | **4.8x** |
| sha256sum | 10 files | 0.0011s | 0.0012s | 0.0011s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0016s | 0.0018s | 0.0015s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0032s | 0.0025s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0204s | 0.0170s | 0.0164s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0214s | 0.0180s | 0.0175s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1994s | 0.1429s | 0.1652s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0013s | 0.0011s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0016s | 0.0019s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0137s | 0.0133s | 0.0133s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0143s | 0.0143s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1339s | 0.1149s | 0.1276s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0131s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0132s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0016s | 0.0017s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0009s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0015s | 0.0013s | 0.0015s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0092s | 0.0030s | 0.0067s | **3.1x** | **2.3x** |
| base64 | encode 10MB binary | 0.0092s | 0.0034s | 0.0071s | **2.7x** | **2.1x** |
| base64 | decode 1MB | 0.0036s | 0.0014s | 0.0034s | **2.5x** | **2.3x** |
| base64 | decode 10MB | 0.0298s | 0.0033s | 0.0265s | **9.0x** | **8.0x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0033s | 0.0069s | **2.8x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0070s | 0.0028s | 0.0069s | **2.5x** | **2.4x** |
| sort | lexicographic 1MB | 0.0073s | 0.0024s | 0.0038s | **3.0x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0494s | 0.0061s | 0.0266s | **8.0x** | **4.3x** |
| sort | already sorted 10MB | 0.0237s | 0.0032s | 0.0128s | **7.5x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0237s | 0.0042s | 0.0132s | **5.7x** | **3.2x** |
| sort | -n numeric 10MB | 0.0672s | 0.0037s | 0.0562s | **18.1x** | **15.1x** |
| sort | -r reverse 10MB | 0.0506s | 0.0061s | 0.0274s | **8.3x** | **4.5x** |
| sort | -u unique 10MB | 0.0533s | 0.0078s | 0.0329s | **6.8x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0689s | 0.0142s | 0.0698s | **4.9x** | **4.9x** |
| sort | repetitive 10MB | 0.0457s | 0.0104s | 0.0373s | **4.4x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0509s | 0.0061s | 0.0291s | **8.3x** | **4.8x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0055s | 0.0068s | **1.7x** | **1.2x** |
| tr | -d digits 10MB | 0.0111s | 0.0062s | 0.0101s | **1.8x** | **1.6x** |
| tr | -d lowercase 10MB | 0.0186s | 0.0085s | 0.0168s | **2.2x** | **2.0x** |
| tr | -s spaces 10MB | 0.0165s | 0.0046s | 0.0112s | **3.6x** | **2.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0049s | 0.0067s | **1.8x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0064s | 0.0100s | **1.7x** | **1.6x** |
| tr | translate binary 10MB | 0.0095s | 0.0050s | 0.0075s | **1.9x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0027s | 0.0086s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0027s | 0.0093s | **6.0x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0089s | 0.0029s | 0.0085s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0067s | 0.0113s | **4.4x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0089s | 0.0027s | 0.0085s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0026s | 0.0084s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0038s | 0.0094s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0474s | 0.0033s | 0.0142s | **14.5x** | **4.3x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0014s | 0.0014s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0079s | 0.0025s | 0.0048s | **3.2x** | **1.9x** |
| tac | reverse 100MB text | 0.0834s | 0.0152s | 0.0420s | **5.5x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0023s | 0.0044s | **3.2x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0176s | 0.0036s | 0.0085s | **4.9x** | **2.4x** |
| tac | custom separator 1MB | 0.0041s | 0.0029s | 0.0036s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0542s | 0.0026s | 0.0298s | **20.9x** | **11.5x** |
| wc | default 100MB text | 0.4785s | 0.0089s | 0.2556s | **53.5x** | **28.6x** |
| wc | -l 10MB text | 0.0021s | 0.0024s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0542s | 0.0100s | 0.0257s | **5.4x** | **2.6x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0542s | 0.0025s | 0.0020s | **22.0x** | **0.8x** |
| wc | -L 10MB text | 0.0543s | 0.0095s | 0.0195s | **5.7x** | **2.1x** |
| wc | default 10MB binary | 0.3172s | 0.0268s | 0.1538s | **11.8x** | **5.7x** |
| wc | default 10MB repetitive | 0.0729s | 0.0034s | 0.0394s | **21.2x** | **11.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0038s | 0.0072s | **5.9x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0038s | 0.0072s | **5.9x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0032s | 0.0085s | **5.1x** | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0068s | 0.0173s | **3.2x** | **2.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0046s | 0.0133s | **5.1x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0052s | 0.0163s | **5.9x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0016s | 0.0020s | **2.1x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0101s | 0.0085s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0101s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0755s | 0.0753s | 0.0757s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| sha256sum | 100 files | 0.0025s | 0.0025s | 0.0023s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0172s | 0.0177s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0177s | 0.0183s | 0.0221s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1619s | 0.1530s | 0.2038s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0128s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0128s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1437s | 0.1122s | 0.1141s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0125s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0127s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0013s | 0.0018s | **1.5x** | **1.4x** |
| base64 | encode 10MB text | 0.0124s | 0.0036s | 0.0081s | **3.5x** | **2.3x** |
| base64 | encode 10MB binary | 0.0127s | 0.0037s | 0.0084s | **3.5x** | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0013s | 0.0044s | **3.0x** | **3.2x** |
| base64 | decode 10MB | 0.0323s | 0.0040s | 0.0338s | **8.1x** | **8.5x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0037s | 0.0082s | **3.3x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0032s | 0.0072s | **2.7x** | **2.2x** |
| sort | lexicographic 1MB | 0.0086s | 0.0033s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0538s | 0.0096s | 0.0353s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0263s | 0.0043s | 0.0175s | **6.2x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0066s | 0.0183s | **4.2x** | **2.8x** |
| sort | -n numeric 10MB | 0.0732s | 0.0058s | 0.0746s | **12.6x** | **12.8x** |
| sort | -r reverse 10MB | 0.0544s | 0.0096s | 0.0355s | **5.7x** | **3.7x** |
| sort | -u unique 10MB | 0.0572s | 0.0098s | 0.0394s | **5.9x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0661s | 0.0188s | 0.0809s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0552s | 0.0119s | 0.0371s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0537s | 0.0097s | 0.0358s | **5.5x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0059s | 0.0076s | **2.1x** | **1.3x** |
| tr | -d digits 10MB | 0.0160s | 0.0056s | 0.0144s | **2.9x** | **2.6x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0071s | 0.0227s | **4.2x** | **3.2x** |
| tr | -s spaces 10MB | 0.0289s | 0.0044s | 0.0273s | **6.5x** | **6.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0131s | 0.0059s | 0.0076s | **2.2x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0166s | 0.0057s | 0.0141s | **2.9x** | **2.5x** |
| tr | translate binary 10MB | 0.0116s | 0.0057s | 0.0082s | **2.0x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0035s | 0.0112s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0037s | 0.0133s | **3.9x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0092s | 0.0156s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0036s | 0.0112s | **3.3x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0043s | 0.0133s | **3.2x** | **3.1x** |
| uniq | repetitive 10MB | 0.0418s | 0.0041s | 0.0163s | **10.3x** | **4.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0105s | 0.0035s | 0.0058s | **3.0x** | **1.7x** |
| tac | reverse 100MB text | 0.1040s | 0.0198s | 0.0524s | **5.3x** | **2.7x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0031s | 0.0057s | **3.0x** | **1.8x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0051s | 0.0112s | **4.5x** | **2.2x** |
| tac | custom separator 1MB | 0.0059s | 0.0035s | 0.0053s | **1.7x** | **1.5x** |
