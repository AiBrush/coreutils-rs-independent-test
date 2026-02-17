# fcoreutils v0.7.7 — Detailed Results

Generated: 2026-02-17 03:37:34 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0065s | 0.0259s | **5.3x** | **4.0x** |
| wc | default 100MB text | 0.3002s | 0.0452s | 0.2281s | **6.6x** | **5.1x** |
| wc | -l 10MB text | 0.0042s | 0.0021s | 0.0025s | **2.0x** | **1.2x** |
| wc | -w 10MB text | 0.0342s | 0.0060s | 0.0233s | **5.7x** | **3.9x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0343s | 0.0023s | 0.0028s | **15.0x** | **1.2x** |
| wc | -L 10MB text | 0.0345s | 0.0064s | 0.0173s | **5.4x** | **2.7x** |
| wc | default 10MB binary | 0.2355s | 0.0169s | 0.1178s | **13.9x** | **7.0x** |
| wc | default 10MB repetitive | 0.0554s | 0.0081s | 0.0371s | **6.9x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0044s | 0.0062s | **4.2x** | **1.4x** |
| cut | -c1-100 10MB CSV | 0.0183s | 0.0041s | 0.0062s | **4.4x** | **1.5x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0103s | 0.0069s | **1.8x** | **0.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0210s | 0.0121s | 0.0162s | **1.7x** | **1.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0105s | 0.0124s | **2.2x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0108s | 0.0160s | **2.4x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0026s | 0.0018s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | 0.0009s | **0.7x** | **0.8x** |
| sha256sum | single 100KB text | 0.0010s | 0.0024s | 0.0013s | **0.4x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0029s | 0.0036s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0073s | 0.0085s | 0.0272s | **0.9x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0086s | 0.0284s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0694s | 0.0683s | 0.2635s | **1.0x** | **3.9x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.7x** | **0.7x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0017s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0210s | 0.0174s | 0.0174s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0218s | 0.0180s | 0.0181s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2016s | 0.1443s | 0.1670s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0023s | 0.0015s | **0.7x** | **0.6x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | 0.0024s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0140s | 0.0135s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0143s | 0.0139s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1364s | 0.1152s | 0.1298s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0132s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0135s | 0.0134s | **1.1x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0094s | 0.0039s | 0.0071s | **2.4x** | **1.8x** |
| base64 | encode 10MB binary | 0.0099s | 0.0040s | 0.0074s | **2.4x** | **1.8x** |
| base64 | decode 1MB | 0.0037s | 0.0018s | 0.0036s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0303s | 0.0054s | 0.0271s | **5.6x** | **5.0x** |
| base64 | encode -w 76 10MB | 0.0096s | 0.0040s | 0.0069s | **2.4x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0044s | 0.0074s | **1.8x** | **1.7x** |
| sort | lexicographic 1MB | 0.0074s | 0.0032s | 0.0046s | **2.3x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0519s | 0.0091s | 0.0290s | **5.7x** | **3.2x** |
| sort | already sorted 10MB | 0.0249s | 0.0034s | 0.0130s | **7.3x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0047s | 0.0140s | **5.2x** | **3.0x** |
| sort | -n numeric 10MB | 0.0699s | 0.0039s | 0.0611s | **17.9x** | **15.6x** |
| sort | -r reverse 10MB | 0.0513s | 0.0088s | 0.0299s | **5.8x** | **3.4x** |
| sort | -u unique 10MB | 0.0536s | 0.0104s | 0.0346s | **5.1x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0704s | 0.0149s | 0.0694s | **4.7x** | **4.6x** |
| sort | repetitive 10MB | 0.0466s | 0.0106s | 0.0376s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0514s | 0.0094s | 0.0288s | **5.5x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0016s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0041s | 0.0070s | **2.1x** | **1.7x** |
| tr | -d digits 10MB | 0.0112s | 0.0051s | 0.0102s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0067s | 0.0174s | **2.8x** | **2.6x** |
| tr | -s spaces 10MB | 0.0168s | 0.0041s | 0.0117s | **4.1x** | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0086s | 0.0041s | 0.0069s | **2.1x** | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0052s | 0.0104s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0042s | 0.0078s | **2.2x** | **1.9x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0017s | 0.0088s | **5.5x** | **5.2x** |
| uniq | default 10MB sorted (low dup) | 0.0167s | 0.0026s | 0.0099s | **6.3x** | **3.8x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0016s | 0.0087s | **5.8x** | **5.5x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0069s | 0.0115s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0017s | 0.0088s | **5.5x** | **5.2x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0017s | 0.0087s | **5.5x** | **5.2x** |
| uniq | -i case insensitive 10MB | 0.0165s | 0.0039s | 0.0097s | **4.3x** | **2.5x** |
| uniq | repetitive 10MB | 0.0489s | 0.0028s | 0.0152s | **17.3x** | **5.4x** |
| tac | reverse 100KB text | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | 0.0016s | **0.9x** | **0.9x** |
| tac | reverse 10MB text | 0.0084s | 0.0042s | 0.0050s | **2.0x** | **1.2x** |
| tac | reverse 100MB text | 0.0869s | 0.0369s | 0.0439s | **2.4x** | **1.2x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0058s | 0.0045s | **1.4x** | **0.8x** |
| tac | reverse repetitive 10MB | 0.0186s | 0.0077s | 0.0087s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0043s | 0.0038s | 0.0038s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0016s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0039s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0548s | 0.0032s | 0.0313s | **17.4x** | **9.9x** |
| wc | default 100MB text | 0.4844s | 0.0142s | 0.2656s | **34.2x** | **18.7x** |
| wc | -l 10MB text | 0.0021s | 0.0026s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0547s | 0.0091s | 0.0260s | **6.0x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0547s | 0.0031s | 0.0020s | **17.5x** | **0.6x** |
| wc | -L 10MB text | 0.0547s | 0.0112s | 0.0169s | **4.9x** | **1.5x** |
| wc | default 10MB binary | 0.3181s | 0.0269s | 0.1584s | **11.8x** | **5.9x** |
| wc | default 10MB repetitive | 0.0732s | 0.0046s | 0.0424s | **15.8x** | **9.2x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0231s | 0.0048s | 0.0075s | **4.8x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0231s | 0.0050s | 0.0076s | **4.6x** | **1.5x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0103s | 0.0088s | **1.6x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0221s | 0.0125s | 0.0183s | **1.8x** | **1.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0115s | 0.0137s | **2.1x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0311s | 0.0119s | 0.0166s | **2.6x** | **1.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0029s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0036s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0087s | 0.0104s | 0.0087s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0105s | 0.0089s | **0.9x** | **0.8x** |
| sha256sum | single 100MB text | 0.0763s | 0.0758s | 0.0760s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0028s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0174s | 0.0183s | 0.0218s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0181s | 0.0189s | 0.0227s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1614s | 0.1532s | 0.2036s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0033s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0127s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0158s | 0.0132s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1432s | 0.1123s | 0.1134s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0127s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0153s | 0.0127s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0013s | 0.0012s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0019s | 0.0018s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0124s | 0.0052s | 0.0082s | **2.4x** | **1.6x** |
| base64 | encode 10MB binary | 0.0131s | 0.0051s | 0.0087s | **2.6x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0024s | 0.0043s | **1.7x** | **1.8x** |
| base64 | decode 10MB | 0.0331s | 0.0060s | 0.0340s | **5.5x** | **5.6x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0051s | 0.0083s | **2.5x** | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0050s | 0.0074s | **1.8x** | **1.5x** |
| sort | lexicographic 1MB | 0.0086s | 0.0036s | 0.0055s | **2.4x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0548s | 0.0101s | 0.0360s | **5.4x** | **3.6x** |
| sort | already sorted 10MB | 0.0266s | 0.0051s | 0.0181s | **5.2x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0064s | 0.0180s | **4.3x** | **2.8x** |
| sort | -n numeric 10MB | 0.0738s | 0.0057s | 0.0770s | **13.0x** | **13.5x** |
| sort | -r reverse 10MB | 0.0551s | 0.0098s | 0.0368s | **5.6x** | **3.7x** |
| sort | -u unique 10MB | 0.0588s | 0.0103s | 0.0405s | **5.7x** | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0674s | 0.0208s | 0.0855s | **3.2x** | **4.1x** |
| sort | repetitive 10MB | 0.0562s | 0.0132s | 0.0393s | **4.3x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0552s | 0.0098s | 0.0371s | **5.6x** | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0143s | 0.0041s | 0.0077s | **3.5x** | **1.9x** |
| tr | -d digits 10MB | 0.0167s | 0.0043s | 0.0142s | **3.9x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0313s | 0.0051s | 0.0212s | **6.1x** | **4.2x** |
| tr | -s spaces 10MB | 0.0280s | 0.0041s | 0.0280s | **6.9x** | **6.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0037s | 0.0075s | **3.4x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0161s | 0.0045s | 0.0138s | **3.6x** | **3.1x** |
| tr | translate binary 10MB | 0.0114s | 0.0041s | 0.0081s | **2.8x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0019s | 0.0122s | **6.1x** | **6.3x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0031s | 0.0132s | **4.6x** | **4.3x** |
| uniq | -c count 10MB many dups | 0.0122s | 0.0019s | 0.0123s | **6.3x** | **6.4x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0079s | 0.0157s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0019s | 0.0122s | **6.3x** | **6.3x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0019s | 0.0122s | **6.3x** | **6.4x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0047s | 0.0133s | **3.0x** | **2.8x** |
| uniq | repetitive 10MB | 0.0425s | 0.0039s | 0.0182s | **10.9x** | **4.7x** |
| tac | reverse 100KB text | 0.0010s | 0.0014s | 0.0013s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0021s | 0.0018s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0111s | 0.0053s | 0.0059s | **2.1x** | **1.1x** |
| tac | reverse 100MB text | 0.1048s | 0.0376s | 0.0528s | **2.8x** | **1.4x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0069s | 0.0056s | **1.4x** | **0.8x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0085s | 0.0110s | **2.7x** | **1.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0050s | 0.0053s | **1.2x** | **1.1x** |
