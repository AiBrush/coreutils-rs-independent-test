# fcoreutils v0.2.8 — Detailed Results

Generated: 2026-02-15 16:21:32 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0026s | 0.0035s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0347s | 0.0065s | 0.0261s | **5.4x** | **4.0x** |
| wc | default 100MB text | 0.2998s | 0.0450s | 0.2280s | **6.7x** | **5.1x** |
| wc | -l 10MB text | 0.0047s | 0.0024s | 0.0028s | **2.0x** | **1.2x** |
| wc | -w 10MB text | 0.0347s | 0.0066s | 0.0236s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0347s | 0.0024s | 0.0032s | **14.3x** | **1.3x** |
| wc | -L 10MB text | 0.0347s | 0.0064s | 0.0182s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2356s | 0.0174s | 0.1181s | **13.5x** | **6.8x** |
| wc | default 10MB repetitive | 0.0539s | 0.0081s | 0.0379s | **6.7x** | **4.7x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0017s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0040s | 0.0063s | **4.6x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0037s | 0.0061s | **5.0x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0046s | 0.0071s | **4.1x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0052s | 0.0163s | **4.1x** | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0035s | 0.0127s | **6.6x** | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0032s | 0.0163s | **8.3x** | **5.1x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0016s | 0.0018s | **2.2x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0012s | 0.0020s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0018s | 0.0027s | 0.0038s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0079s | 0.0089s | 0.0277s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0080s | 0.0095s | 0.0291s | **0.8x** | **3.0x** |
| sha256sum | single 100MB text | 0.0697s | 0.0572s | 0.2639s | **1.2x** | **4.6x** |
| sha256sum | 10 files | 0.0012s | 0.0013s | 0.0012s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0018s | 0.0020s | 0.0017s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0036s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0214s | 0.0179s | 0.0177s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0224s | 0.0187s | 0.0185s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2016s | 0.1443s | 0.1671s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0013s | 0.0012s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0017s | 0.0020s | 0.0017s | **0.8x** | **0.9x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0140s | 0.0139s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0151s | 0.0146s | 0.0147s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1361s | 0.1173s | 0.1299s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0146s | 0.0141s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0142s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0010s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0099s | 0.0033s | 0.0073s | **3.0x** | **2.2x** |
| base64 | encode 10MB binary | 0.0103s | 0.0033s | 0.0076s | **3.1x** | **2.3x** |
| base64 | decode 1MB | 0.0038s | 0.0017s | 0.0036s | **2.3x** | **2.2x** |
| base64 | decode 10MB | 0.0308s | 0.0054s | 0.0270s | **5.7x** | **5.0x** |
| base64 | encode -w 76 10MB | 0.0099s | 0.0033s | 0.0073s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0079s | 0.0030s | 0.0073s | **2.6x** | **2.4x** |
| sort | lexicographic 1MB | 0.0075s | 0.0027s | 0.0042s | **2.8x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0569s | 0.0080s | 0.0292s | **7.1x** | **3.6x** |
| sort | already sorted 10MB | 0.0249s | 0.0034s | 0.0131s | **7.4x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0249s | 0.0045s | 0.0138s | **5.5x** | **3.0x** |
| sort | -n numeric 10MB | 0.0694s | 0.0039s | 0.0623s | **17.7x** | **15.9x** |
| sort | -r reverse 10MB | 0.0526s | 0.0063s | 0.0295s | **8.4x** | **4.7x** |
| sort | -u unique 10MB | 0.0546s | 0.0089s | 0.0359s | **6.2x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0703s | 0.0142s | 0.0690s | **4.9x** | **4.9x** |
| sort | repetitive 10MB | 0.0464s | 0.0105s | 0.0371s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0515s | 0.0064s | 0.0296s | **8.1x** | **4.7x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0043s | 0.0068s | **2.1x** | **1.6x** |
| tr | -d digits 10MB | 0.0112s | 0.0052s | 0.0102s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0066s | 0.0171s | **2.9x** | **2.6x** |
| tr | -s spaces 10MB | 0.0166s | 0.0041s | 0.0114s | **4.1x** | **2.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0046s | 0.0068s | **1.9x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0051s | 0.0104s | **2.2x** | **2.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0044s | 0.0081s | **2.1x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0028s | 0.0088s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0165s | 0.0032s | 0.0097s | **5.1x** | **3.0x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0032s | 0.0087s | **2.9x** | **2.7x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0069s | 0.0116s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0027s | 0.0087s | **3.5x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0088s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0040s | 0.0095s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0490s | 0.0036s | 0.0154s | **13.8x** | **4.3x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0090s | 0.0045s | 0.0049s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0858s | 0.0220s | 0.0436s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0078s | 0.0045s | 0.0045s | **1.7x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0191s | 0.0069s | 0.0089s | **2.8x** | **1.3x** |
| tac | custom separator 1MB | 0.0044s | 0.0035s | 0.0039s | **1.3x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0015s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0038s | **2.1x** | **1.4x** |
| wc | default 10MB text | 0.0545s | 0.0031s | 0.0298s | **17.7x** | **9.7x** |
| wc | default 100MB text | 0.4832s | 0.0140s | 0.2558s | **34.6x** | **18.3x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0543s | 0.0088s | 0.0258s | **6.2x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0545s | 0.0030s | 0.0020s | **18.1x** | **0.7x** |
| wc | -L 10MB text | 0.0545s | 0.0118s | 0.0199s | **4.6x** | **1.7x** |
| wc | default 10MB binary | 0.3172s | 0.0269s | 0.1537s | **11.8x** | **5.7x** |
| wc | default 10MB repetitive | 0.0730s | 0.0046s | 0.0401s | **15.8x** | **8.7x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0015s | **0.9x** | **1.3x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0041s | 0.0075s | **5.5x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0039s | 0.0073s | **5.8x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0055s | 0.0085s | **3.1x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0071s | 0.0175s | **3.0x** | **2.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0052s | 0.0135s | **4.6x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0046s | 0.0163s | **6.7x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0016s | 0.0020s | **2.2x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0100s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0102s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0753s | 0.0753s | 0.0755s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0024s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0178s | 0.0219s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0184s | 0.0223s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1616s | 0.1536s | 0.2036s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| md5sum | 100 files | 0.0024s | 0.0026s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0126s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0129s | 0.0128s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1431s | 0.1118s | 0.1131s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0124s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0123s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | 0.0018s | **1.4x** | **1.3x** |
| base64 | encode 10MB text | 0.0122s | 0.0048s | 0.0081s | **2.5x** | **1.7x** |
| base64 | encode 10MB binary | 0.0129s | 0.0051s | 0.0087s | **2.5x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0014s | 0.0044s | **2.9x** | **3.1x** |
| base64 | decode 10MB | 0.0327s | 0.0055s | 0.0341s | **5.9x** | **6.1x** |
| base64 | encode -w 76 10MB | 0.0128s | 0.0049s | 0.0083s | **2.6x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0039s | 0.0075s | **2.2x** | **1.9x** |
| sort | lexicographic 1MB | 0.0087s | 0.0033s | 0.0056s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0552s | 0.0097s | 0.0362s | **5.7x** | **3.7x** |
| sort | already sorted 10MB | 0.0264s | 0.0046s | 0.0180s | **5.8x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0067s | 0.0185s | **4.0x** | **2.7x** |
| sort | -n numeric 10MB | 0.0739s | 0.0057s | 0.0774s | **13.0x** | **13.6x** |
| sort | -r reverse 10MB | 0.0552s | 0.0099s | 0.0364s | **5.6x** | **3.7x** |
| sort | -u unique 10MB | 0.0577s | 0.0098s | 0.0400s | **5.9x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0668s | 0.0197s | 0.0836s | **3.4x** | **4.2x** |
| sort | repetitive 10MB | 0.0555s | 0.0117s | 0.0369s | **4.7x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0098s | 0.0360s | **5.5x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0038s | 0.0078s | **3.3x** | **2.1x** |
| tr | -d digits 10MB | 0.0188s | 0.0043s | 0.0143s | **4.4x** | **3.4x** |
| tr | -d lowercase 10MB | 0.0321s | 0.0049s | 0.0226s | **6.6x** | **4.6x** |
| tr | -s spaces 10MB | 0.0299s | 0.0039s | 0.0272s | **7.7x** | **7.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0128s | 0.0039s | 0.0075s | **3.3x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0173s | 0.0043s | 0.0160s | **4.0x** | **3.7x** |
| tr | translate binary 10MB | 0.0112s | 0.0039s | 0.0081s | **2.9x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0036s | 0.0111s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0036s | 0.0133s | **3.8x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0111s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0092s | 0.0158s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0036s | 0.0112s | **3.4x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0036s | 0.0113s | **3.3x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0045s | 0.0133s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0419s | 0.0041s | 0.0162s | **10.2x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0047s | 0.0059s | **2.2x** | **1.3x** |
| tac | reverse 100MB text | 0.1048s | 0.0269s | 0.0527s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0050s | 0.0057s | **1.9x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0233s | 0.0082s | 0.0114s | **2.8x** | **1.4x** |
| tac | custom separator 1MB | 0.0060s | 0.0039s | 0.0054s | **1.5x** | **1.4x** |
