# fcoreutils v0.1.3 — Detailed Results

Generated: 2026-02-16 12:55:39 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0037s | 0.0024s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0343s | 0.0065s | 0.0252s | **5.3x** | **3.9x** |
| wc | default 100MB text | 0.2997s | 0.0453s | 0.2215s | **6.6x** | **4.9x** |
| wc | -l 10MB text | 0.0038s | 0.0021s | 0.0024s | **1.8x** | **1.1x** |
| wc | -w 10MB text | 0.0341s | 0.0062s | 0.0213s | **5.5x** | **3.5x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0340s | 0.0022s | 0.0025s | **15.4x** | **1.1x** |
| wc | -L 10MB text | 0.0342s | 0.0066s | 0.0177s | **5.2x** | **2.7x** |
| wc | default 10MB binary | 0.2350s | 0.0173s | 0.1145s | **13.6x** | **6.6x** |
| wc | default 10MB repetitive | 0.0519s | 0.0082s | 0.0370s | **6.3x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0012s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0017s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0035s | 0.0062s | **5.3x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0033s | 0.0064s | **5.5x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0041s | 0.0069s | **4.6x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0210s | 0.0053s | 0.0161s | **4.0x** | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0034s | 0.0122s | **6.7x** | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0262s | 0.0035s | 0.0164s | **7.5x** | **4.7x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0038s | 0.0026s | 0.0018s | **1.4x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0023s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0073s | 0.0074s | 0.0275s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0077s | 0.0291s | **1.1x** | **3.8x** |
| sha256sum | single 100MB text | 0.0711s | 0.0588s | 0.2661s | **1.2x** | **4.5x** |
| sha256sum | 10 files | 0.0012s | 0.0021s | 0.0011s | **0.6x** | **0.5x** |
| sha256sum | 100 files | 0.0018s | 0.0027s | 0.0018s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0217s | 0.0167s | 0.0179s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0227s | 0.0175s | 0.0192s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2018s | 0.1447s | 0.1666s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0019s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0024s | 0.0016s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0023s | 0.0022s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0137s | 0.0125s | 0.0135s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0144s | 0.0130s | 0.0140s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1362s | 0.1172s | 0.1305s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0126s | 0.0138s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0125s | 0.0141s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0014s | 0.0016s | **1.2x** | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0017s | 0.0015s | 0.0015s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0098s | 0.0054s | 0.0071s | **1.8x** | **1.3x** |
| base64 | encode 10MB binary | 0.0109s | 0.0057s | 0.0070s | **1.9x** | **1.2x** |
| base64 | decode 1MB | 0.0038s | 0.0018s | 0.0034s | **2.1x** | **1.9x** |
| base64 | decode 10MB | 0.0306s | 0.0105s | 0.0263s | **2.9x** | **2.5x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0053s | 0.0071s | **1.9x** | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0076s | 0.0045s | 0.0074s | **1.7x** | **1.6x** |
| sort | lexicographic 1MB | 0.0075s | 0.0028s | 0.0043s | **2.7x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0513s | 0.0107s | 0.0285s | **4.8x** | **2.7x** |
| sort | already sorted 10MB | 0.0247s | 0.0038s | 0.0134s | **6.5x** | **3.5x** |
| sort | reverse sorted 10MB | 0.0249s | 0.0055s | 0.0139s | **4.5x** | **2.5x** |
| sort | -n numeric 10MB | 0.0730s | 0.0040s | 0.0692s | **18.4x** | **17.5x** |
| sort | -r reverse 10MB | 0.0543s | 0.0109s | 0.0332s | **5.0x** | **3.0x** |
| sort | -u unique 10MB | 0.0578s | 0.0115s | 0.0409s | **5.0x** | **3.6x** |
| sort | -t, -k2 CSV 10MB | 0.0751s | 0.0534s | 0.0720s | **1.4x** | **1.3x** |
| sort | repetitive 10MB | 0.0455s | 0.0102s | 0.0361s | **4.5x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0514s | 0.0098s | 0.0305s | **5.2x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0018s | 0.0018s | **1.0x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0074s | 0.0068s | **1.2x** | **0.9x** |
| tr | -d digits 10MB | 0.0112s | 0.0136s | 0.0106s | **0.8x** | **0.8x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0207s | 0.0175s | **0.9x** | **0.8x** |
| tr | -s spaces 10MB | 0.0167s | 0.0074s | 0.0114s | **2.3x** | **1.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0073s | 0.0069s | **1.2x** | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0136s | 0.0106s | **0.8x** | **0.8x** |
| tr | translate binary 10MB | 0.0091s | 0.0076s | 0.0078s | **1.2x** | **1.0x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0027s | 0.0088s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0166s | 0.0030s | 0.0101s | **5.6x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0029s | 0.0087s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0297s | 0.0071s | 0.0121s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0095s | 0.0028s | 0.0091s | **3.5x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0028s | 0.0090s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0041s | 0.0103s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0476s | 0.0038s | 0.0149s | **12.6x** | **3.9x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | 0.0014s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0089s | 0.0045s | 0.0050s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0869s | 0.0396s | 0.0448s | **2.2x** | **1.1x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0045s | 0.0045s | **1.8x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0184s | 0.0091s | 0.0085s | **2.0x** | **0.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0038s | 0.0038s | **1.2x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0059s | 0.0031s | 0.0044s | **1.9x** | **1.5x** |
| wc | default 10MB text | 0.0540s | 0.0032s | 0.0365s | **16.9x** | **11.4x** |
| wc | default 100MB text | 0.4834s | 0.0154s | 0.3152s | **31.5x** | **20.5x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0548s | 0.0091s | 0.0271s | **6.0x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0547s | 0.0031s | 0.0020s | **17.5x** | **0.6x** |
| wc | -L 10MB text | 0.0548s | 0.0099s | 0.0167s | **5.6x** | **1.7x** |
| wc | default 10MB binary | 0.3160s | 0.0279s | 0.1581s | **11.3x** | **5.7x** |
| wc | default 10MB repetitive | 0.0737s | 0.0049s | 0.0527s | **15.1x** | **10.8x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0056s | 0.0075s | **4.1x** | **1.3x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0054s | 0.0074s | **4.3x** | **1.4x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0057s | 0.0089s | **2.9x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0275s | 0.0075s | 0.0178s | **3.7x** | **2.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0245s | 0.0054s | 0.0137s | **4.5x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0307s | 0.0049s | 0.0167s | **6.3x** | **3.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0027s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0087s | 0.0097s | 0.0091s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0100s | 0.0091s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0762s | 0.0759s | 0.0760s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0032s | 0.0024s | **0.8x** | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0039s | 0.0033s | **0.7x** | **0.9x** |
| md5sum | single 10MB text | 0.0177s | 0.0175s | 0.0218s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0183s | 0.0182s | 0.0228s | **1.0x** | **1.3x** |
| md5sum | single 100MB text | 0.1619s | 0.1536s | 0.2054s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0031s | 0.0024s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0024s | 0.0023s | 0.0024s | **1.0x** | **1.0x** |
| b2sum | single 10MB text | 0.0151s | 0.0127s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0160s | 0.0130s | 0.0133s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1440s | 0.1125s | 0.1142s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0122s | 0.0124s | **1.3x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0125s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0019s | 0.0024s | **1.2x** | **1.3x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | 0.0018s | **1.3x** | **1.1x** |
| base64 | encode 10MB text | 0.0124s | 0.0060s | 0.0086s | **2.1x** | **1.4x** |
| base64 | encode 10MB binary | 0.0136s | 0.0064s | 0.0085s | **2.1x** | **1.3x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0044s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0330s | 0.0116s | 0.0341s | **2.8x** | **2.9x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0065s | 0.0087s | **1.9x** | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0092s | 0.0040s | 0.0076s | **2.3x** | **1.9x** |
| sort | lexicographic 1MB | 0.0089s | 0.0037s | 0.0057s | **2.4x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0572s | 0.0125s | 0.0361s | **4.6x** | **2.9x** |
| sort | already sorted 10MB | 0.0267s | 0.0052s | 0.0185s | **5.1x** | **3.5x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0086s | 0.0185s | **3.2x** | **2.2x** |
| sort | -n numeric 10MB | 0.0735s | 0.0059s | 0.0773s | **12.5x** | **13.2x** |
| sort | -r reverse 10MB | 0.0550s | 0.0125s | 0.0364s | **4.4x** | **2.9x** |
| sort | -u unique 10MB | 0.0587s | 0.0127s | 0.0404s | **4.6x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0682s | 0.0452s | 0.0850s | **1.5x** | **1.9x** |
| sort | repetitive 10MB | 0.0556s | 0.0121s | 0.0383s | **4.6x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0546s | 0.0124s | 0.0362s | **4.4x** | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | 0.0020s | **1.2x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0071s | 0.0075s | **1.8x** | **1.1x** |
| tr | -d digits 10MB | 0.0159s | 0.0133s | 0.0142s | **1.2x** | **1.1x** |
| tr | -d lowercase 10MB | 0.0281s | 0.0132s | 0.0213s | **2.1x** | **1.6x** |
| tr | -s spaces 10MB | 0.0279s | 0.0069s | 0.0281s | **4.0x** | **4.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0071s | 0.0076s | **1.8x** | **1.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0165s | 0.0133s | 0.0138s | **1.2x** | **1.0x** |
| tr | translate binary 10MB | 0.0123s | 0.0073s | 0.0083s | **1.7x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0037s | 0.0114s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0038s | 0.0131s | **3.7x** | **3.5x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0035s | 0.0117s | **3.5x** | **3.3x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0093s | 0.0158s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0035s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0122s | 0.0035s | 0.0132s | **3.5x** | **3.8x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0046s | 0.0131s | **3.0x** | **2.8x** |
| uniq | repetitive 10MB | 0.0424s | 0.0043s | 0.0171s | **10.0x** | **4.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | 0.0018s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0113s | 0.0049s | 0.0060s | **2.3x** | **1.2x** |
| tac | reverse 100MB text | 0.1049s | 0.0409s | 0.0532s | **2.6x** | **1.3x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0051s | 0.0058s | **1.8x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0240s | 0.0106s | 0.0110s | **2.3x** | **1.0x** |
| tac | custom separator 1MB | 0.0060s | 0.0039s | 0.0054s | **1.5x** | **1.4x** |
