# fcoreutils v0.4.4 — Detailed Results

Generated: 2026-02-17 06:30:17 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 825/826 (99.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0036s | 0.0024s | 0.0032s | **1.5x** | **1.4x** |
| wc | default 10MB text | 0.0339s | 0.0060s | 0.0251s | **5.6x** | **4.2x** |
| wc | default 100MB text | 0.2956s | 0.0408s | 0.2237s | **7.2x** | **5.5x** |
| wc | -l 10MB text | 0.0038s | 0.0022s | 0.0023s | **1.8x** | **1.1x** |
| wc | -w 10MB text | 0.0345s | 0.0064s | 0.0226s | **5.4x** | **3.5x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | 0.0010s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0337s | 0.0021s | 0.0023s | **16.2x** | **1.1x** |
| wc | -L 10MB text | 0.0338s | 0.0059s | 0.0170s | **5.8x** | **2.9x** |
| wc | default 10MB binary | 0.2349s | 0.0169s | 0.1173s | **13.9x** | **7.0x** |
| wc | default 10MB repetitive | 0.0520s | 0.0083s | 0.0365s | **6.2x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0179s | 0.0036s | 0.0058s | **4.9x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0180s | 0.0035s | 0.0056s | **5.2x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0180s | 0.0030s | 0.0066s | **6.0x** | **2.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0207s | 0.0047s | 0.0157s | **4.4x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0227s | 0.0033s | 0.0121s | **6.9x** | **3.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0259s | 0.0044s | 0.0156s | **5.9x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | 0.0009s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0014s | 0.0016s | **2.3x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0024s | 0.0035s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0071s | 0.0081s | 0.0266s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0071s | 0.0084s | 0.0277s | **0.8x** | **3.3x** |
| sha256sum | single 100MB text | 0.0650s | 0.0543s | 0.2597s | **1.2x** | **4.8x** |
| sha256sum | 10 files | 0.0010s | 0.0012s | 0.0010s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0019s | 0.0016s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0011s | 0.0019s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0033s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0204s | 0.0169s | 0.0170s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0213s | 0.0176s | 0.0177s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1974s | 0.1418s | 0.1633s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0012s | 0.0011s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0016s | 0.0019s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0008s | 0.0009s | 0.0011s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0022s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0133s | 0.0132s | 0.0131s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0139s | 0.0138s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1320s | 0.1144s | 0.1254s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0133s | 0.0131s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0132s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0016s | 0.0015s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0009s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0015s | 0.0015s | 0.0015s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0091s | 0.0033s | 0.0068s | **2.7x** | **2.0x** |
| base64 | encode 10MB binary | 0.0094s | 0.0034s | 0.0069s | **2.7x** | **2.0x** |
| base64 | decode 1MB | 0.0036s | 0.0014s | 0.0034s | **2.6x** | **2.4x** |
| base64 | decode 10MB | 0.0298s | 0.0034s | 0.0263s | **8.8x** | **7.8x** |
| base64 | encode -w 76 10MB | 0.0090s | 0.0030s | 0.0069s | **3.0x** | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0070s | 0.0026s | 0.0069s | **2.7x** | **2.6x** |
| sort | lexicographic 1MB | 0.0073s | 0.0026s | 0.0040s | **2.9x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0501s | 0.0061s | 0.0275s | **8.2x** | **4.5x** |
| sort | already sorted 10MB | 0.0243s | 0.0031s | 0.0130s | **7.8x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0238s | 0.0043s | 0.0131s | **5.6x** | **3.1x** |
| sort | -n numeric 10MB | 0.0685s | 0.0038s | 0.0572s | **18.1x** | **15.1x** |
| sort | -r reverse 10MB | 0.0514s | 0.0063s | 0.0277s | **8.2x** | **4.4x** |
| sort | -u unique 10MB | 0.0531s | 0.0077s | 0.0335s | **6.9x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0692s | 0.0136s | 0.0637s | **5.1x** | **4.7x** |
| sort | repetitive 10MB | 0.0445s | 0.0096s | 0.0338s | **4.6x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0498s | 0.0060s | 0.0273s | **8.3x** | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0018s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0086s | 0.0037s | 0.0067s | **2.3x** | **1.8x** |
| tr | -d digits 10MB | 0.0110s | 0.0052s | 0.0102s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0185s | 0.0066s | 0.0171s | **2.8x** | **2.6x** |
| tr | -s spaces 10MB | 0.0165s | 0.0037s | 0.0114s | **4.5x** | **3.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0085s | 0.0042s | 0.0066s | **2.0x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0051s | 0.0101s | **2.2x** | **2.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0037s | 0.0076s | **2.5x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0027s | 0.0084s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0029s | 0.0094s | **5.6x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0029s | 0.0085s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0068s | 0.0112s | **4.3x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0026s | 0.0085s | **3.4x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0027s | 0.0085s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0038s | 0.0094s | **4.2x** | **2.5x** |
| uniq | repetitive 10MB | 0.0473s | 0.0035s | 0.0140s | **13.4x** | **4.0x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0015s | 0.0013s | 0.0014s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0081s | 0.0026s | 0.0048s | **3.1x** | **1.8x** |
| tac | reverse 100MB text | 0.0806s | 0.0149s | 0.0415s | **5.4x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0023s | 0.0043s | **3.3x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0172s | 0.0038s | 0.0085s | **4.6x** | **2.2x** |
| tac | custom separator 1MB | 0.0042s | 0.0031s | 0.0037s | **1.3x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0540s | 0.0026s | 0.0300s | **21.2x** | **11.8x** |
| wc | default 100MB text | 0.4842s | 0.0089s | 0.2552s | **54.3x** | **28.6x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0536s | 0.0082s | 0.0252s | **6.5x** | **3.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0542s | 0.0024s | 0.0020s | **22.6x** | **0.8x** |
| wc | -L 10MB text | 0.0542s | 0.0105s | 0.0195s | **5.1x** | **1.9x** |
| wc | default 10MB binary | 0.3173s | 0.0262s | 0.1534s | **12.1x** | **5.8x** |
| wc | default 10MB repetitive | 0.0731s | 0.0035s | 0.0401s | **21.0x** | **11.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0023s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0038s | 0.0073s | **5.9x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0038s | 0.0073s | **5.9x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0033s | 0.0085s | **5.0x** | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0066s | 0.0173s | **3.3x** | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0238s | 0.0046s | 0.0133s | **5.1x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0052s | 0.0164s | **5.9x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0099s | 0.0085s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0104s | 0.0090s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0749s | 0.0757s | 0.0747s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0015s | 0.0014s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0175s | 0.0178s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0185s | 0.0185s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1607s | 0.1532s | 0.2048s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0015s | 0.0013s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0125s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0130s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1431s | 0.1119s | 0.1128s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0126s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0127s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0014s | 0.0019s | **1.5x** | **1.4x** |
| base64 | encode 10MB text | 0.0125s | 0.0037s | 0.0082s | **3.3x** | **2.2x** |
| base64 | encode 10MB binary | 0.0130s | 0.0036s | 0.0088s | **3.6x** | **2.4x** |
| base64 | decode 1MB | 0.0040s | 0.0013s | 0.0043s | **3.0x** | **3.3x** |
| base64 | decode 10MB | 0.0328s | 0.0041s | 0.0343s | **8.1x** | **8.4x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0037s | 0.0082s | **3.3x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0104s | 0.0032s | 0.0071s | **3.3x** | **2.2x** |
| sort | lexicographic 1MB | 0.0085s | 0.0033s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0549s | 0.0100s | 0.0360s | **5.5x** | **3.6x** |
| sort | already sorted 10MB | 0.0267s | 0.0046s | 0.0178s | **5.8x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0279s | 0.0068s | 0.0180s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0746s | 0.0057s | 0.0772s | **13.0x** | **13.5x** |
| sort | -r reverse 10MB | 0.0550s | 0.0099s | 0.0368s | **5.5x** | **3.7x** |
| sort | -u unique 10MB | 0.0581s | 0.0104s | 0.0393s | **5.6x** | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0668s | 0.0200s | 0.0826s | **3.3x** | **4.1x** |
| sort | repetitive 10MB | 0.0548s | 0.0115s | 0.0368s | **4.7x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0558s | 0.0099s | 0.0360s | **5.6x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0132s | 0.0038s | 0.0075s | **3.5x** | **2.0x** |
| tr | -d digits 10MB | 0.0169s | 0.0044s | 0.0143s | **3.8x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0307s | 0.0050s | 0.0228s | **6.1x** | **4.5x** |
| tr | -s spaces 10MB | 0.0281s | 0.0041s | 0.0274s | **6.8x** | **6.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0138s | 0.0038s | 0.0075s | **3.6x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0163s | 0.0044s | 0.0144s | **3.7x** | **3.3x** |
| tr | translate binary 10MB | 0.0119s | 0.0041s | 0.0083s | **2.9x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0122s | 0.0036s | 0.0116s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0143s | 0.0042s | 0.0138s | **3.4x** | **3.3x** |
| uniq | -c count 10MB many dups | 0.0125s | 0.0036s | 0.0117s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0094s | 0.0159s | **3.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0036s | 0.0113s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0036s | 0.0115s | **3.5x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0046s | 0.0137s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0422s | 0.0041s | 0.0165s | **10.3x** | **4.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.1x** |
| tac | reverse 10MB text | 0.0113s | 0.0034s | 0.0060s | **3.3x** | **1.8x** |
| tac | reverse 100MB text | 0.1050s | 0.0189s | 0.0533s | **5.5x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0030s | 0.0057s | **3.1x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0051s | 0.0117s | **4.6x** | **2.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0036s | 0.0053s | **1.7x** | **1.5x** |
