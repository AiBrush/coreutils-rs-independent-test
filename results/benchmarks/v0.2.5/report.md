# fcoreutils v0.2.5 — Detailed Results

Generated: 2026-02-16 08:50:07 UTC

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
| wc | default 100KB text | 0.0011s | 0.0013s | 0.0014s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0040s | 0.0028s | 0.0036s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0347s | 0.0069s | 0.0262s | **5.0x** | **3.8x** |
| wc | default 100MB text | 0.2984s | 0.0447s | 0.2272s | **6.7x** | **5.1x** |
| wc | -l 10MB text | 0.0050s | 0.0024s | 0.0035s | **2.1x** | **1.5x** |
| wc | -w 10MB text | 0.0347s | 0.0064s | 0.0236s | **5.4x** | **3.7x** |
| wc | -c 10MB text | 0.0008s | 0.0011s | 0.0012s | **0.7x** | **1.1x** |
| wc | -m 10MB text | 0.0347s | 0.0027s | 0.0036s | **12.9x** | **1.3x** |
| wc | -L 10MB text | 0.0347s | 0.0065s | 0.0181s | **5.3x** | **2.8x** |
| wc | default 10MB binary | 0.2349s | 0.0176s | 0.1180s | **13.3x** | **6.7x** |
| wc | default 10MB repetitive | 0.0540s | 0.0086s | 0.0379s | **6.3x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0012s | 0.0012s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0014s | 0.0015s | 0.0018s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0040s | 0.0066s | **4.7x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0188s | 0.0040s | 0.0065s | **4.7x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0044s | 0.0075s | **4.3x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0053s | 0.0165s | **4.1x** | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0036s | 0.0130s | **6.4x** | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0036s | 0.0165s | **7.3x** | **4.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0023s | 0.0019s | **1.6x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0018s | 0.0028s | 0.0039s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0083s | 0.0077s | 0.0280s | **1.1x** | **3.6x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0079s | 0.0290s | **1.1x** | **3.7x** |
| sha256sum | single 100MB text | 0.0688s | 0.0564s | 0.2627s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0012s | 0.0023s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | 100 files | 0.0019s | 0.0023s | 0.0019s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0033s | 0.0037s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0216s | 0.0167s | 0.0181s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0225s | 0.0173s | 0.0188s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2005s | 0.1437s | 0.1660s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0022s | 0.0018s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0026s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0147s | 0.0128s | 0.0145s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0152s | 0.0133s | 0.0150s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1353s | 0.1160s | 0.1288s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0129s | 0.0144s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0127s | 0.0144s | **1.2x** | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0019s | 0.0020s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0011s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0018s | 0.0016s | 0.0017s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0105s | 0.0036s | 0.0079s | **2.9x** | **2.2x** |
| base64 | encode 10MB binary | 0.0108s | 0.0037s | 0.0081s | **2.9x** | **2.2x** |
| base64 | decode 1MB | 0.0039s | 0.0021s | 0.0038s | **1.9x** | **1.8x** |
| base64 | decode 10MB | 0.0311s | 0.0063s | 0.0272s | **5.0x** | **4.3x** |
| base64 | encode -w 76 10MB | 0.0105s | 0.0037s | 0.0081s | **2.9x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0084s | 0.0035s | 0.0080s | **2.4x** | **2.3x** |
| sort | lexicographic 1MB | 0.0079s | 0.0030s | 0.0047s | **2.6x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0553s | 0.0073s | 0.0359s | **7.6x** | **4.9x** |
| sort | already sorted 10MB | 0.0254s | 0.0037s | 0.0141s | **6.9x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0257s | 0.0049s | 0.0148s | **5.3x** | **3.0x** |
| sort | -n numeric 10MB | 0.0735s | 0.0041s | 0.0725s | **18.1x** | **17.9x** |
| sort | -r reverse 10MB | 0.0579s | 0.0072s | 0.0361s | **8.1x** | **5.0x** |
| sort | -u unique 10MB | 0.0595s | 0.0099s | 0.0427s | **6.0x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0773s | 0.0182s | 0.0802s | **4.2x** | **4.4x** |
| sort | repetitive 10MB | 0.0479s | 0.0109s | 0.0386s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0549s | 0.0070s | 0.0352s | **7.8x** | **5.0x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0052s | 0.0071s | **1.7x** | **1.4x** |
| tr | -d digits 10MB | 0.0113s | 0.0056s | 0.0102s | **2.0x** | **1.8x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0072s | 0.0173s | **2.6x** | **2.4x** |
| tr | -s spaces 10MB | 0.0168s | 0.0052s | 0.0115s | **3.2x** | **2.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0050s | 0.0069s | **1.8x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0055s | 0.0103s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0091s | 0.0050s | 0.0077s | **1.8x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0096s | 0.0029s | 0.0092s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0165s | 0.0034s | 0.0098s | **4.8x** | **2.9x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0032s | 0.0091s | **3.0x** | **2.8x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0072s | 0.0117s | **4.1x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0029s | 0.0091s | **3.3x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0028s | 0.0092s | **3.4x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0165s | 0.0041s | 0.0098s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0485s | 0.0039s | 0.0156s | **12.4x** | **4.0x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0017s | 0.0021s | 0.0016s | **0.8x** | **0.8x** |
| tac | reverse 10MB text | 0.0094s | 0.0039s | 0.0053s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.0843s | 0.0258s | 0.0443s | **3.3x** | **1.7x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0045s | 0.0046s | **1.8x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0191s | 0.0075s | 0.0090s | **2.6x** | **1.2x** |
| tac | custom separator 1MB | 0.0045s | 0.0038s | 0.0040s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0029s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0541s | 0.0031s | 0.0297s | **17.5x** | **9.6x** |
| wc | default 100MB text | 0.4814s | 0.0140s | 0.2552s | **34.4x** | **18.2x** |
| wc | -l 10MB text | 0.0019s | 0.0024s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0109s | 0.0255s | **5.0x** | **2.3x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0543s | 0.0029s | 0.0019s | **18.5x** | **0.7x** |
| wc | -L 10MB text | 0.0544s | 0.0100s | 0.0195s | **5.4x** | **1.9x** |
| wc | default 10MB binary | 0.3191s | 0.0275s | 0.1551s | **11.6x** | **5.6x** |
| wc | default 10MB repetitive | 0.0729s | 0.0045s | 0.0395s | **16.2x** | **8.8x** |
| wc | 10 files | 0.0010s | 0.0013s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0041s | 0.0073s | **5.6x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0041s | 0.0073s | **5.6x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0047s | 0.0085s | **3.5x** | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0063s | 0.0172s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0049s | 0.0134s | **4.9x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0304s | 0.0044s | 0.0164s | **6.9x** | **3.7x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0024s | 0.0020s | **1.4x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0095s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0100s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0758s | 0.0762s | 0.0756s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0023s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0173s | 0.0171s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0177s | 0.0179s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1617s | 0.1545s | 0.2034s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0121s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0126s | 0.0128s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1431s | 0.1127s | 0.1136s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0120s | 0.0122s | **1.3x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0122s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.0x** | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0020s | 0.0014s | 0.0018s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0122s | 0.0047s | 0.0081s | **2.6x** | **1.7x** |
| base64 | encode 10MB binary | 0.0127s | 0.0049s | 0.0083s | **2.6x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0044s | **1.9x** | **2.0x** |
| base64 | decode 10MB | 0.0324s | 0.0057s | 0.0340s | **5.7x** | **6.0x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0048s | 0.0081s | **2.5x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0038s | 0.0071s | **2.2x** | **1.9x** |
| sort | lexicographic 1MB | 0.0086s | 0.0032s | 0.0054s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0540s | 0.0097s | 0.0354s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0261s | 0.0041s | 0.0174s | **6.3x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0067s | 0.0178s | **4.1x** | **2.6x** |
| sort | -n numeric 10MB | 0.0730s | 0.0057s | 0.0752s | **12.9x** | **13.2x** |
| sort | -r reverse 10MB | 0.0547s | 0.0098s | 0.0358s | **5.6x** | **3.7x** |
| sort | -u unique 10MB | 0.0574s | 0.0096s | 0.0397s | **6.0x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0659s | 0.0185s | 0.0816s | **3.6x** | **4.4x** |
| sort | repetitive 10MB | 0.0549s | 0.0117s | 0.0366s | **4.7x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0538s | 0.0097s | 0.0355s | **5.6x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.4x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0039s | 0.0074s | **3.4x** | **1.9x** |
| tr | -d digits 10MB | 0.0167s | 0.0045s | 0.0146s | **3.7x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0317s | 0.0052s | 0.0225s | **6.1x** | **4.4x** |
| tr | -s spaces 10MB | 0.0263s | 0.0038s | 0.0270s | **6.9x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0133s | 0.0037s | 0.0075s | **3.6x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0168s | 0.0044s | 0.0141s | **3.8x** | **3.2x** |
| tr | translate binary 10MB | 0.0112s | 0.0038s | 0.0079s | **2.9x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0034s | 0.0133s | **4.1x** | **3.9x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0091s | 0.0157s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0034s | 0.0112s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0043s | 0.0134s | **3.2x** | **3.1x** |
| uniq | repetitive 10MB | 0.0417s | 0.0054s | 0.0163s | **7.7x** | **3.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0019s | 0.0024s | 0.0018s | **0.8x** | **0.7x** |
| tac | reverse 10MB text | 0.0104s | 0.0044s | 0.0059s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1042s | 0.0289s | 0.0518s | **3.6x** | **1.8x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0047s | 0.0057s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0229s | 0.0086s | 0.0112s | **2.7x** | **1.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0043s | 0.0053s | **1.4x** | **1.2x** |
