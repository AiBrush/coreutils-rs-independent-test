# fcoreutils v0.6.3 — Detailed Results

Generated: 2026-02-16 22:08:23 UTC

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
| wc | default 1MB text | 0.0037s | 0.0024s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0336s | 0.0061s | 0.0249s | **5.5x** | **4.1x** |
| wc | default 100MB text | 0.2983s | 0.0428s | 0.2251s | **7.0x** | **5.3x** |
| wc | -l 10MB text | 0.0037s | 0.0019s | 0.0019s | **1.9x** | **1.0x** |
| wc | -w 10MB text | 0.0336s | 0.0060s | 0.0226s | **5.6x** | **3.7x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0337s | 0.0023s | 0.0026s | **14.6x** | **1.1x** |
| wc | -L 10MB text | 0.0334s | 0.0058s | 0.0171s | **5.8x** | **3.0x** |
| wc | default 10MB binary | 0.2347s | 0.0167s | 0.1174s | **14.0x** | **7.0x** |
| wc | default 10MB repetitive | 0.0515s | 0.0086s | 0.0360s | **6.0x** | **4.2x** |
| wc | 10 files | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0027s | 0.0058s | **6.7x** | **2.2x** |
| cut | -c1-100 10MB CSV | 0.0180s | 0.0027s | 0.0059s | **6.7x** | **2.2x** |
| cut | -d, -f1 10MB CSV | 0.0181s | 0.0042s | 0.0067s | **4.3x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0207s | 0.0050s | 0.0159s | **4.2x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0226s | 0.0045s | 0.0123s | **5.1x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0258s | 0.0043s | 0.0156s | **6.0x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0011s | 0.0009s | **0.6x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | 0.0016s | **1.3x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0010s | 0.0021s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0016s | 0.0028s | 0.0035s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0068s | 0.0082s | 0.0264s | **0.8x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0084s | 0.0279s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0661s | 0.0650s | 0.2613s | **1.0x** | **4.0x** |
| sha256sum | 10 files | 0.0011s | 0.0016s | 0.0010s | **0.7x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0020s | 0.0016s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0011s | 0.0019s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0033s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0201s | 0.0167s | 0.0167s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0217s | 0.0178s | 0.0176s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1992s | 0.1417s | 0.1637s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0022s | 0.0015s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0022s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0134s | 0.0130s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0141s | 0.0136s | 0.0135s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1330s | 0.1129s | 0.1270s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0130s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0127s | 0.0129s | **1.1x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0016s | 0.0015s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0090s | 0.0032s | 0.0068s | **2.8x** | **2.1x** |
| base64 | encode 10MB binary | 0.0095s | 0.0032s | 0.0069s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0036s | 0.0017s | 0.0033s | **2.2x** | **2.0x** |
| base64 | decode 10MB | 0.0298s | 0.0038s | 0.0259s | **7.9x** | **6.8x** |
| base64 | encode -w 76 10MB | 0.0090s | 0.0036s | 0.0066s | **2.5x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0068s | 0.0029s | 0.0068s | **2.3x** | **2.3x** |
| sort | lexicographic 1MB | 0.0074s | 0.0030s | 0.0039s | **2.5x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0498s | 0.0083s | 0.0264s | **6.0x** | **3.2x** |
| sort | already sorted 10MB | 0.0243s | 0.0035s | 0.0126s | **6.9x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0239s | 0.0045s | 0.0134s | **5.3x** | **3.0x** |
| sort | -n numeric 10MB | 0.0681s | 0.0037s | 0.0568s | **18.3x** | **15.3x** |
| sort | -r reverse 10MB | 0.0509s | 0.0080s | 0.0275s | **6.3x** | **3.4x** |
| sort | -u unique 10MB | 0.0529s | 0.0092s | 0.0333s | **5.7x** | **3.6x** |
| sort | -t, -k2 CSV 10MB | 0.0698s | 0.0137s | 0.0646s | **5.1x** | **4.7x** |
| sort | repetitive 10MB | 0.0438s | 0.0100s | 0.0338s | **4.4x** | **3.4x** |
| sort | --parallel=4 10MB | 0.0497s | 0.0084s | 0.0271s | **5.9x** | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0017s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0085s | 0.0035s | 0.0067s | **2.4x** | **1.9x** |
| tr | -d digits 10MB | 0.0110s | 0.0051s | 0.0102s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0067s | 0.0172s | **2.8x** | **2.6x** |
| tr | -s spaces 10MB | 0.0166s | 0.0035s | 0.0113s | **4.7x** | **3.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0038s | 0.0068s | **2.3x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0050s | 0.0100s | **2.2x** | **2.0x** |
| tr | translate binary 10MB | 0.0096s | 0.0061s | 0.0088s | **1.6x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0016s | 0.0086s | **5.7x** | **5.4x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0024s | 0.0095s | **6.7x** | **3.9x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0017s | 0.0086s | **5.4x** | **5.1x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0067s | 0.0114s | **4.4x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0017s | 0.0087s | **5.4x** | **5.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0017s | 0.0087s | **5.4x** | **5.0x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0040s | 0.0096s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0482s | 0.0029s | 0.0148s | **16.8x** | **5.1x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| tac | reverse 1MB text | 0.0015s | 0.0014s | 0.0015s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0081s | 0.0042s | 0.0048s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0835s | 0.0214s | 0.0420s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0076s | 0.0041s | 0.0043s | **1.8x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0182s | 0.0090s | 0.0085s | **2.0x** | **0.9x** |
| tac | custom separator 1MB | 0.0042s | 0.0034s | 0.0036s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0048s | 0.0032s | 0.0041s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0432s | 0.0029s | 0.0352s | **15.0x** | **12.2x** |
| wc | default 100MB text | 0.3795s | 0.0128s | 0.3121s | **29.6x** | **24.3x** |
| wc | -l 10MB text | 0.0018s | 0.0026s | 0.0020s | **0.7x** | **0.8x** |
| wc | -w 10MB text | 0.0432s | 0.0102s | 0.0326s | **4.2x** | **3.2x** |
| wc | -c 10MB text | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| wc | -m 10MB text | 0.0431s | 0.0029s | 0.0017s | **14.8x** | **0.6x** |
| wc | -L 10MB text | 0.0431s | 0.0110s | 0.0161s | **3.9x** | **1.5x** |
| wc | default 10MB binary | 0.3215s | 0.0316s | 0.1589s | **10.2x** | **5.0x** |
| wc | default 10MB repetitive | 0.0568s | 0.0039s | 0.0478s | **14.7x** | **12.4x** |
| wc | 10 files | 0.0007s | 0.0011s | 0.0010s | **0.6x** | **0.9x** |
| wc | 100 files | 0.0011s | 0.0014s | 0.0014s | **0.8x** | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0199s | 0.0033s | 0.0060s | **6.1x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0199s | 0.0035s | 0.0060s | **5.7x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0213s | 0.0049s | 0.0073s | **4.3x** | **1.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0245s | 0.0076s | 0.0162s | **3.2x** | **2.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0269s | 0.0053s | 0.0123s | **5.1x** | **2.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0304s | 0.0054s | 0.0157s | **5.6x** | **2.9x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0012s | 0.0009s | **0.6x** | **0.7x** |
| cut | -d, -f1 1MB text | 0.0039s | 0.0028s | 0.0016s | **1.4x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0013s | 0.0008s | **0.5x** | **0.6x** |
| sha256sum | single 100KB text | 0.0010s | 0.0031s | 0.0011s | **0.3x** | **0.4x** |
| sha256sum | single 1MB text | 0.0019s | 0.0040s | 0.0018s | **0.5x** | **0.5x** |
| sha256sum | single 10MB text | 0.0103s | 0.0127s | 0.0104s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0108s | 0.0134s | 0.0108s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0903s | 0.0943s | 0.0899s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0021s | 0.0011s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0016s | 0.0024s | 0.0015s | **0.7x** | **0.6x** |
| md5sum | single 100KB text | 0.0011s | 0.0021s | 0.0011s | **0.5x** | **0.5x** |
| md5sum | single 1MB text | 0.0025s | 0.0037s | 0.0030s | **0.7x** | **0.8x** |
| md5sum | single 10MB text | 0.0167s | 0.0183s | 0.0209s | **0.9x** | **1.1x** |
| md5sum | single 10MB binary | 0.0173s | 0.0193s | 0.0218s | **0.9x** | **1.1x** |
| md5sum | single 100MB text | 0.1522s | 0.1395s | 0.1941s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0010s | 0.0021s | 0.0010s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0015s | 0.0028s | 0.0015s | **0.5x** | **0.5x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0019s | 0.0019s | **1.1x** | **1.0x** |
| b2sum | single 10MB text | 0.0150s | 0.0133s | 0.0120s | **1.1x** | **0.9x** |
| b2sum | single 10MB binary | 0.0154s | 0.0140s | 0.0123s | **1.1x** | **0.9x** |
| b2sum | single 100MB text | 0.1371s | 0.0976s | 0.1050s | **1.4x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0134s | 0.0119s | **1.1x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0133s | 0.0118s | **1.1x** | **0.9x** |
| b2sum | 100 files | 0.0015s | 0.0022s | 0.0016s | **0.7x** | **0.7x** |
| base64 | encode 100KB text | 0.0007s | 0.0012s | 0.0009s | **0.6x** | **0.7x** |
| base64 | encode 1MB text | 0.0016s | 0.0022s | 0.0015s | **0.7x** | **0.7x** |
| base64 | encode 10MB text | 0.0110s | 0.0046s | 0.0054s | **2.4x** | **1.2x** |
| base64 | encode 10MB binary | 0.0116s | 0.0047s | 0.0056s | **2.5x** | **1.2x** |
| base64 | decode 1MB | 0.0037s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| base64 | decode 10MB | 0.0307s | 0.0051s | 0.0258s | **6.1x** | **5.1x** |
| base64 | encode -w 76 10MB | 0.0112s | 0.0050s | 0.0055s | **2.2x** | **1.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0042s | 0.0055s | **2.1x** | **1.3x** |
| sort | lexicographic 1MB | 0.0081s | 0.0040s | 0.0049s | **2.0x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0548s | 0.0115s | 0.0321s | **4.7x** | **2.8x** |
| sort | already sorted 10MB | 0.0234s | 0.0049s | 0.0145s | **4.8x** | **3.0x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0064s | 0.0144s | **3.8x** | **2.2x** |
| sort | -n numeric 10MB | 0.0730s | 0.0064s | 0.0670s | **11.4x** | **10.5x** |
| sort | -r reverse 10MB | 0.0530s | 0.0107s | 0.0326s | **4.9x** | **3.0x** |
| sort | -u unique 10MB | 0.0600s | 0.0117s | 0.0391s | **5.1x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0715s | 0.0235s | 0.0831s | **3.0x** | **3.5x** |
| sort | repetitive 10MB | 0.0512s | 0.0139s | 0.0340s | **3.7x** | **2.4x** |
| sort | --parallel=4 10MB | 0.0548s | 0.0118s | 0.0330s | **4.6x** | **2.8x** |
| tr | a-z to A-Z 1MB | 0.0016s | 0.0014s | 0.0016s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0086s | 0.0043s | 0.0065s | **2.0x** | **1.5x** |
| tr | -d digits 10MB | 0.0171s | 0.0042s | 0.0133s | **4.0x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0304s | 0.0049s | 0.0238s | **6.2x** | **4.8x** |
| tr | -s spaces 10MB | 0.0245s | 0.0044s | 0.0275s | **5.6x** | **6.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0081s | 0.0041s | 0.0066s | **2.0x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0164s | 0.0045s | 0.0135s | **3.6x** | **3.0x** |
| tr | translate binary 10MB | 0.0085s | 0.0046s | 0.0075s | **1.9x** | **1.7x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0014s | 0.0101s | **6.3x** | **7.0x** |
| uniq | default 10MB sorted (low dup) | 0.0190s | 0.0030s | 0.0130s | **6.3x** | **4.3x** |
| uniq | -c count 10MB many dups | 0.0097s | 0.0016s | 0.0099s | **6.2x** | **6.3x** |
| uniq | -c count 10MB sorted | 0.0299s | 0.0073s | 0.0145s | **4.1x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0014s | 0.0099s | **6.6x** | **6.9x** |
| uniq | -u unique only 10MB | 0.0098s | 0.0015s | 0.0100s | **6.5x** | **6.6x** |
| uniq | -i case insensitive 10MB | 0.0190s | 0.0049s | 0.0130s | **3.9x** | **2.6x** |
| uniq | repetitive 10MB | 0.0494s | 0.0035s | 0.0148s | **14.1x** | **4.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0015s | 0.0014s | 0.0014s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0088s | 0.0044s | 0.0051s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0820s | 0.0233s | 0.0437s | **3.5x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0046s | 0.0046s | **1.8x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0159s | 0.0094s | 0.0088s | **1.7x** | **0.9x** |
| tac | custom separator 1MB | 0.0050s | 0.0042s | 0.0040s | **1.2x** | **1.0x** |
