# fcoreutils v0.6.4 — Detailed Results

Generated: 2026-02-17 02:19:53 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0027s | 0.0034s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0066s | 0.0259s | **5.2x** | **3.9x** |
| wc | default 100MB text | 0.2998s | 0.0465s | 0.2281s | **6.4x** | **4.9x** |
| wc | -l 10MB text | 0.0047s | 0.0024s | 0.0031s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0345s | 0.0062s | 0.0234s | **5.5x** | **3.8x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.7x** | **1.1x** |
| wc | -m 10MB text | 0.0345s | 0.0024s | 0.0031s | **14.7x** | **1.3x** |
| wc | -L 10MB text | 0.0344s | 0.0063s | 0.0180s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2355s | 0.0177s | 0.1179s | **13.3x** | **6.7x** |
| wc | default 10MB repetitive | 0.0530s | 0.0087s | 0.0379s | **6.1x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0014s | 0.0015s | 0.0017s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0033s | 0.0066s | **5.6x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0191s | 0.0032s | 0.0068s | **6.0x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0047s | 0.0075s | **4.0x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0055s | 0.0166s | **3.9x** | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0044s | 0.0131s | **5.3x** | **3.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0049s | 0.0165s | **5.5x** | **3.4x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | 0.0018s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0011s | 0.0023s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0031s | 0.0038s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0081s | 0.0092s | 0.0277s | **0.9x** | **3.0x** |
| sha256sum | single 10MB binary | 0.0084s | 0.0094s | 0.0289s | **0.9x** | **3.1x** |
| sha256sum | single 100MB text | 0.0696s | 0.0685s | 0.2635s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0012s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0023s | 0.0019s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0214s | 0.0177s | 0.0180s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0223s | 0.0185s | 0.0187s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2015s | 0.1443s | 0.1670s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0026s | 0.0018s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0145s | 0.0141s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0151s | 0.0146s | 0.0147s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1359s | 0.1167s | 0.1292s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0145s | 0.0142s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0140s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0018s | 0.0018s | 0.0019s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0018s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0102s | 0.0034s | 0.0076s | **3.0x** | **2.2x** |
| base64 | encode 10MB binary | 0.0107s | 0.0037s | 0.0080s | **2.9x** | **2.1x** |
| base64 | decode 1MB | 0.0039s | 0.0020s | 0.0037s | **2.0x** | **1.8x** |
| base64 | decode 10MB | 0.0310s | 0.0048s | 0.0272s | **6.4x** | **5.6x** |
| base64 | encode -w 76 10MB | 0.0102s | 0.0033s | 0.0076s | **3.1x** | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0034s | 0.0078s | **2.4x** | **2.3x** |
| sort | lexicographic 1MB | 0.0077s | 0.0033s | 0.0044s | **2.3x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0537s | 0.0104s | 0.0336s | **5.2x** | **3.2x** |
| sort | already sorted 10MB | 0.0257s | 0.0035s | 0.0151s | **7.4x** | **4.4x** |
| sort | reverse sorted 10MB | 0.0256s | 0.0053s | 0.0148s | **4.9x** | **2.8x** |
| sort | -n numeric 10MB | 0.0731s | 0.0044s | 0.0704s | **16.7x** | **16.0x** |
| sort | -r reverse 10MB | 0.0552s | 0.0112s | 0.0346s | **4.9x** | **3.1x** |
| sort | -u unique 10MB | 0.0584s | 0.0123s | 0.0421s | **4.7x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0795s | 0.0175s | 0.0749s | **4.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0474s | 0.0108s | 0.0386s | **4.4x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0538s | 0.0104s | 0.0331s | **5.2x** | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0016s | 0.0019s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0047s | 0.0067s | **1.9x** | **1.4x** |
| tr | -d digits 10MB | 0.0113s | 0.0052s | 0.0103s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0069s | 0.0169s | **2.8x** | **2.4x** |
| tr | -s spaces 10MB | 0.0168s | 0.0047s | 0.0117s | **3.6x** | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0046s | 0.0069s | **1.9x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0053s | 0.0104s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0090s | 0.0049s | 0.0078s | **1.9x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0095s | 0.0018s | 0.0091s | **5.3x** | **5.0x** |
| uniq | default 10MB sorted (low dup) | 0.0169s | 0.0029s | 0.0104s | **5.9x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0018s | 0.0091s | **5.3x** | **5.0x** |
| uniq | -c count 10MB sorted | 0.0299s | 0.0071s | 0.0120s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0095s | 0.0017s | 0.0090s | **5.5x** | **5.2x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0017s | 0.0091s | **5.5x** | **5.2x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0041s | 0.0103s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0489s | 0.0034s | 0.0163s | **14.4x** | **4.8x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0090s | 0.0045s | 0.0050s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0860s | 0.0242s | 0.0453s | **3.6x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0085s | 0.0045s | 0.0046s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0193s | 0.0095s | 0.0091s | **2.0x** | **1.0x** |
| tac | custom separator 1MB | 0.0045s | 0.0037s | 0.0039s | **1.2x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0017s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0059s | 0.0030s | 0.0043s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0549s | 0.0034s | 0.0343s | **16.2x** | **10.1x** |
| wc | default 100MB text | 0.4847s | 0.0151s | 0.2910s | **32.2x** | **19.3x** |
| wc | -l 10MB text | 0.0024s | 0.0026s | 0.0022s | **0.9x** | **0.9x** |
| wc | -w 10MB text | 0.0549s | 0.0094s | 0.0347s | **5.8x** | **3.7x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0549s | 0.0033s | 0.0025s | **16.5x** | **0.8x** |
| wc | -L 10MB text | 0.0548s | 0.0115s | 0.0173s | **4.8x** | **1.5x** |
| wc | default 10MB binary | 0.3174s | 0.0276s | 0.1563s | **11.5x** | **5.7x** |
| wc | default 10MB repetitive | 0.0738s | 0.0048s | 0.0482s | **15.3x** | **10.0x** |
| wc | 10 files | 0.0010s | 0.0014s | 0.0014s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0020s | 0.0021s | 0.0024s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0234s | 0.0038s | 0.0076s | **6.2x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0233s | 0.0037s | 0.0076s | **6.2x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0173s | 0.0053s | 0.0089s | **3.3x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0229s | 0.0075s | 0.0186s | **3.1x** | **2.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0248s | 0.0055s | 0.0141s | **4.5x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0311s | 0.0057s | 0.0175s | **5.4x** | **3.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0013s | 0.0012s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0030s | 0.0021s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0013s | 0.0012s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0032s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0021s | 0.0038s | 0.0021s | **0.6x** | **0.5x** |
| sha256sum | single 10MB text | 0.0089s | 0.0109s | 0.0091s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0096s | 0.0116s | 0.0096s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0756s | 0.0759s | 0.0755s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0026s | 0.0028s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0040s | 0.0035s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0180s | 0.0189s | 0.0222s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0188s | 0.0197s | 0.0233s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1616s | 0.1540s | 0.2032s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0034s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0024s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0156s | 0.0131s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0163s | 0.0136s | 0.0138s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1434s | 0.1130s | 0.1136s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0130s | 0.0128s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0155s | 0.0131s | 0.0128s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0023s | 0.0025s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0022s | 0.0021s | 0.0019s | **1.0x** | **0.9x** |
| base64 | encode 10MB text | 0.0128s | 0.0044s | 0.0085s | **2.9x** | **1.9x** |
| base64 | encode 10MB binary | 0.0136s | 0.0048s | 0.0090s | **2.8x** | **1.9x** |
| base64 | decode 1MB | 0.0044s | 0.0023s | 0.0045s | **1.9x** | **1.9x** |
| base64 | decode 10MB | 0.0334s | 0.0050s | 0.0344s | **6.7x** | **6.9x** |
| base64 | encode -w 76 10MB | 0.0130s | 0.0047s | 0.0085s | **2.8x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0092s | 0.0044s | 0.0077s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0093s | 0.0038s | 0.0058s | **2.4x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0577s | 0.0104s | 0.0380s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0270s | 0.0050s | 0.0188s | **5.4x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0279s | 0.0066s | 0.0189s | **4.2x** | **2.8x** |
| sort | -n numeric 10MB | 0.0759s | 0.0058s | 0.0824s | **13.0x** | **14.1x** |
| sort | -r reverse 10MB | 0.0601s | 0.0109s | 0.0384s | **5.5x** | **3.5x** |
| sort | -u unique 10MB | 0.0623s | 0.0113s | 0.0428s | **5.5x** | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0697s | 0.0228s | 0.0878s | **3.1x** | **3.9x** |
| sort | repetitive 10MB | 0.0554s | 0.0131s | 0.0378s | **4.2x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0559s | 0.0100s | 0.0368s | **5.6x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0021s | **1.4x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0138s | 0.0043s | 0.0076s | **3.2x** | **1.8x** |
| tr | -d digits 10MB | 0.0162s | 0.0045s | 0.0136s | **3.6x** | **3.0x** |
| tr | -d lowercase 10MB | 0.0317s | 0.0054s | 0.0217s | **5.9x** | **4.0x** |
| tr | -s spaces 10MB | 0.0274s | 0.0042s | 0.0272s | **6.6x** | **6.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0154s | 0.0042s | 0.0078s | **3.7x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0163s | 0.0045s | 0.0136s | **3.6x** | **3.0x** |
| tr | translate binary 10MB | 0.0114s | 0.0042s | 0.0086s | **2.7x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0122s | 0.0020s | 0.0113s | **6.1x** | **5.7x** |
| uniq | default 10MB sorted (low dup) | 0.0145s | 0.0034s | 0.0131s | **4.3x** | **3.9x** |
| uniq | -c count 10MB many dups | 0.0124s | 0.0020s | 0.0113s | **6.3x** | **5.7x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0078s | 0.0158s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0019s | 0.0113s | **6.3x** | **5.9x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0019s | 0.0111s | **6.5x** | **6.0x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0045s | 0.0133s | **3.1x** | **2.9x** |
| uniq | repetitive 10MB | 0.0423s | 0.0036s | 0.0167s | **11.7x** | **4.6x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0110s | 0.0047s | 0.0063s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1044s | 0.0272s | 0.0529s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0048s | 0.0058s | **2.0x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0242s | 0.0102s | 0.0116s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0061s | 0.0045s | 0.0055s | **1.4x** | **1.2x** |
