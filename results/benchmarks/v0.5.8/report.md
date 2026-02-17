# fcoreutils v0.5.8 — Detailed Results

Generated: 2026-02-17 04:11:24 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0014s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0039s | 0.0027s | 0.0035s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0348s | 0.0066s | 0.0261s | **5.2x** | **3.9x** |
| wc | default 100MB text | 0.2965s | 0.0436s | 0.2245s | **6.8x** | **5.2x** |
| wc | -l 10MB text | 0.0047s | 0.0024s | 0.0031s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0347s | 0.0065s | 0.0237s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0348s | 0.0025s | 0.0029s | **13.9x** | **1.2x** |
| wc | -L 10MB text | 0.0348s | 0.0065s | 0.0181s | **5.3x** | **2.8x** |
| wc | default 10MB binary | 0.2348s | 0.0171s | 0.1181s | **13.7x** | **6.9x** |
| wc | default 10MB repetitive | 0.0529s | 0.0086s | 0.0370s | **6.2x** | **4.3x** |
| wc | 10 files | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0017s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0032s | 0.0066s | **5.8x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0031s | 0.0066s | **6.1x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0048s | 0.0074s | **3.9x** | **1.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0060s | 0.0166s | **3.6x** | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0049s | 0.0130s | **4.7x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0046s | 0.0166s | **5.9x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | 0.0018s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0013s | 0.0010s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0024s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0031s | 0.0039s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0081s | 0.0091s | 0.0278s | **0.9x** | **3.0x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0096s | 0.0292s | **0.9x** | **3.0x** |
| sha256sum | single 100MB text | 0.0668s | 0.0655s | 0.2605s | **1.0x** | **4.0x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0019s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0017s | 0.0022s | 0.0012s | **0.8x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0215s | 0.0180s | 0.0180s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0227s | 0.0188s | 0.0193s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1982s | 0.1423s | 0.1635s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.7x** |
| md5sum | 100 files | 0.0018s | 0.0027s | 0.0018s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0144s | 0.0142s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0152s | 0.0148s | 0.0150s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1328s | 0.1146s | 0.1259s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0143s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0141s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0019s | 0.0018s | **0.9x** | **0.9x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0017s | 0.0017s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0100s | 0.0037s | 0.0076s | **2.7x** | **2.0x** |
| base64 | encode 10MB binary | 0.0104s | 0.0037s | 0.0080s | **2.8x** | **2.1x** |
| base64 | decode 1MB | 0.0043s | 0.0023s | 0.0037s | **1.9x** | **1.6x** |
| base64 | decode 10MB | 0.0309s | 0.0046s | 0.0272s | **6.8x** | **5.9x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0039s | 0.0076s | **2.6x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0036s | 0.0078s | **2.3x** | **2.2x** |
| sort | lexicographic 1MB | 0.0077s | 0.0034s | 0.0046s | **2.3x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0534s | 0.0100s | 0.0325s | **5.3x** | **3.2x** |
| sort | already sorted 10MB | 0.0255s | 0.0035s | 0.0135s | **7.2x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0255s | 0.0056s | 0.0145s | **4.6x** | **2.6x** |
| sort | -n numeric 10MB | 0.0719s | 0.0041s | 0.0675s | **17.7x** | **16.6x** |
| sort | -r reverse 10MB | 0.0546s | 0.0108s | 0.0334s | **5.1x** | **3.1x** |
| sort | -u unique 10MB | 0.0574s | 0.0122s | 0.0397s | **4.7x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0740s | 0.0169s | 0.0748s | **4.4x** | **4.4x** |
| sort | repetitive 10MB | 0.0476s | 0.0103s | 0.0384s | **4.6x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0534s | 0.0103s | 0.0322s | **5.2x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0015s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0046s | 0.0069s | **1.9x** | **1.5x** |
| tr | -d digits 10MB | 0.0113s | 0.0054s | 0.0107s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0197s | 0.0068s | 0.0170s | **2.9x** | **2.5x** |
| tr | -s spaces 10MB | 0.0169s | 0.0049s | 0.0116s | **3.5x** | **2.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0047s | 0.0070s | **1.9x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0054s | 0.0104s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0092s | 0.0052s | 0.0078s | **1.8x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0096s | 0.0018s | 0.0090s | **5.4x** | **5.0x** |
| uniq | default 10MB sorted (low dup) | 0.0166s | 0.0027s | 0.0099s | **6.1x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0019s | 0.0090s | **5.1x** | **4.9x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0075s | 0.0116s | **3.9x** | **1.5x** |
| uniq | -d duplicates only 10MB | 0.0095s | 0.0019s | 0.0091s | **5.0x** | **4.8x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0019s | 0.0091s | **5.1x** | **4.9x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0041s | 0.0102s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0483s | 0.0032s | 0.0159s | **14.9x** | **4.9x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0018s | 0.0015s | 0.0016s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0092s | 0.0045s | 0.0051s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0823s | 0.0217s | 0.0425s | **3.8x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0085s | 0.0045s | 0.0046s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0186s | 0.0095s | 0.0088s | **2.0x** | **0.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0037s | 0.0039s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.2x** | **1.4x** |
| wc | default 1MB text | 0.0058s | 0.0028s | 0.0042s | **2.1x** | **1.5x** |
| wc | default 10MB text | 0.0547s | 0.0032s | 0.0341s | **17.1x** | **10.7x** |
| wc | default 100MB text | 0.4835s | 0.0141s | 0.2921s | **34.2x** | **20.7x** |
| wc | -l 10MB text | 0.0021s | 0.0026s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0088s | 0.0344s | **6.2x** | **3.9x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0544s | 0.0030s | 0.0022s | **17.9x** | **0.7x** |
| wc | -L 10MB text | 0.0548s | 0.0111s | 0.0168s | **4.9x** | **1.5x** |
| wc | default 10MB binary | 0.3180s | 0.0272s | 0.1564s | **11.7x** | **5.8x** |
| wc | default 10MB repetitive | 0.0737s | 0.0046s | 0.0480s | **16.0x** | **10.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.1x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0037s | 0.0072s | **6.2x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0038s | 0.0072s | **6.1x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0052s | 0.0086s | **3.2x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0225s | 0.0076s | 0.0182s | **3.0x** | **2.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0055s | 0.0138s | **4.4x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0055s | 0.0173s | **5.6x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0031s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0030s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0021s | 0.0037s | 0.0020s | **0.6x** | **0.5x** |
| sha256sum | single 10MB text | 0.0088s | 0.0104s | 0.0089s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0107s | 0.0091s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0761s | 0.0756s | 0.0761s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0028s | 0.0024s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0039s | 0.0034s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0178s | 0.0179s | 0.0216s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0182s | 0.0188s | 0.0228s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1617s | 0.1541s | 0.2038s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0034s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0155s | 0.0128s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0161s | 0.0134s | 0.0132s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1434s | 0.1125s | 0.1138s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0127s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0126s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0023s | 0.0024s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0018s | 0.0018s | **1.2x** | **1.0x** |
| base64 | encode 10MB text | 0.0126s | 0.0044s | 0.0083s | **2.9x** | **1.9x** |
| base64 | encode 10MB binary | 0.0134s | 0.0048s | 0.0087s | **2.8x** | **1.8x** |
| base64 | decode 1MB | 0.0041s | 0.0022s | 0.0044s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0332s | 0.0051s | 0.0352s | **6.5x** | **6.9x** |
| base64 | encode -w 76 10MB | 0.0129s | 0.0048s | 0.0084s | **2.7x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0042s | 0.0074s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0092s | 0.0035s | 0.0056s | **2.6x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0552s | 0.0094s | 0.0364s | **5.9x** | **3.9x** |
| sort | already sorted 10MB | 0.0272s | 0.0051s | 0.0186s | **5.3x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0295s | 0.0067s | 0.0189s | **4.4x** | **2.8x** |
| sort | -n numeric 10MB | 0.0779s | 0.0057s | 0.0842s | **13.6x** | **14.7x** |
| sort | -r reverse 10MB | 0.0558s | 0.0097s | 0.0375s | **5.8x** | **3.9x** |
| sort | -u unique 10MB | 0.0603s | 0.0111s | 0.0420s | **5.5x** | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0701s | 0.0225s | 0.0854s | **3.1x** | **3.8x** |
| sort | repetitive 10MB | 0.0569s | 0.0130s | 0.0380s | **4.4x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0568s | 0.0098s | 0.0367s | **5.8x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0021s | **1.4x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0138s | 0.0042s | 0.0081s | **3.3x** | **1.9x** |
| tr | -d digits 10MB | 0.0171s | 0.0043s | 0.0136s | **4.0x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0292s | 0.0051s | 0.0226s | **5.7x** | **4.4x** |
| tr | -s spaces 10MB | 0.0272s | 0.0038s | 0.0269s | **7.2x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0038s | 0.0074s | **3.3x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0172s | 0.0044s | 0.0133s | **4.0x** | **3.1x** |
| tr | translate binary 10MB | 0.0114s | 0.0039s | 0.0085s | **2.9x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0020s | 0.0118s | **6.1x** | **5.9x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0030s | 0.0132s | **4.7x** | **4.4x** |
| uniq | -c count 10MB many dups | 0.0124s | 0.0020s | 0.0114s | **6.2x** | **5.7x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0081s | 0.0154s | **3.7x** | **1.9x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0020s | 0.0112s | **6.2x** | **5.8x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0019s | 0.0112s | **6.3x** | **5.8x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0047s | 0.0131s | **3.0x** | **2.8x** |
| uniq | repetitive 10MB | 0.0425s | 0.0036s | 0.0170s | **11.9x** | **4.7x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0112s | 0.0048s | 0.0060s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1045s | 0.0273s | 0.0533s | **3.8x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0095s | 0.0051s | 0.0058s | **1.9x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0105s | 0.0117s | **2.3x** | **1.1x** |
| tac | custom separator 1MB | 0.0060s | 0.0043s | 0.0054s | **1.4x** | **1.3x** |
