# fcoreutils v0.0.58 — Detailed Results

Generated: 2026-02-14 19:07:48 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 411 | 2 | 99.5% |
| Linux_x86_64 | 413 | 411 | 2 | 99.5% |

**Overall: 822/826 (99.5%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0038s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0334s | 0.0065s | **5.1x** |
| wc | default 100MB text | 0.2895s | 0.0410s | **7.1x** |
| wc | -l 10MB text | 0.0035s | 0.0019s | **1.8x** |
| wc | -w 10MB text | 0.0334s | 0.0059s | **5.7x** |
| wc | -c 10MB text | 0.0007s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0334s | 0.0021s | **16.0x** |
| wc | -L 10MB text | 0.0334s | 0.0060s | **5.6x** |
| wc | default 10MB binary | 0.2346s | 0.0175s | **13.4x** |
| wc | default 10MB repetitive | 0.0505s | 0.0069s | **7.3x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0032s | **5.8x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0032s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0041s | **4.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0046s | **4.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0035s | **6.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0049s | **5.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | **0.5x** |
| sha256sum | single 1MB text | 0.0016s | 0.0025s | **0.6x** |
| sha256sum | single 10MB text | 0.0067s | 0.0072s | **0.9x** |
| sha256sum | single 10MB binary | 0.0079s | 0.0077s | **1.0x** |
| sha256sum | single 100MB text | 0.0576s | 0.0532s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0018s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0034s | **0.9x** |
| md5sum | single 10MB text | 0.0201s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0222s | 0.0169s | **1.3x** |
| md5sum | single 100MB text | 0.1891s | 0.1410s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0021s | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0026s | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0013s | **0.6x** |
| b2sum | single 1MB text | 0.0022s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0135s | 0.0133s | **1.0x** |
| b2sum | single 10MB binary | 0.0153s | 0.0136s | **1.1x** |
| b2sum | single 100MB text | 0.1241s | 0.1178s | **1.1x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0130s | **1.0x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0130s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0017s | **1.0x** |
| base64 | encode 10MB text | 0.0092s | 0.0030s | **3.0x** |
| base64 | encode 10MB binary | 0.0105s | 0.0036s | **3.0x** |
| base64 | decode 1MB | 0.0037s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0310s | 0.0150s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0092s | 0.0037s | **2.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0069s | 0.0030s | **2.3x** |
| sort | lexicographic 1MB | 0.0077s | 0.0031s | **2.5x** |
| sort | lexicographic 10MB random | 0.0510s | 0.0060s | **8.4x** |
| sort | already sorted 10MB | 0.0245s | 0.0046s | **5.4x** |
| sort | reverse sorted 10MB | 0.0246s | 0.0054s | **4.5x** |
| sort | -n numeric 10MB | 0.0685s | 0.0522s | **1.3x** |
| sort | -r reverse 10MB | 0.0507s | 0.0061s | **8.3x** |
| sort | -u unique 10MB | 0.0529s | 0.0124s | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0695s | 0.0176s | **4.0x** |
| sort | repetitive 10MB | 0.0409s | 0.0079s | **5.1x** |
| sort | --parallel=4 10MB | 0.0496s | 0.0059s | **8.4x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0019s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0095s | 0.0059s | **1.6x** |
| tr | -d digits 10MB | 0.0112s | 0.0075s | **1.5x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0097s | **2.0x** |
| tr | -s spaces 10MB | 0.0168s | 0.0058s | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0096s | 0.0061s | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0076s | **1.5x** |
| tr | translate binary 10MB | 0.0094s | 0.0083s | **1.1x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0030s | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0030s | **5.4x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0047s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0066s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0047s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0042s | **3.8x** |
| uniq | repetitive 10MB | 0.0462s | 0.0037s | **12.5x** |
| tac | reverse 100KB text | 0.0008s | 0.0013s | **0.7x** |
| tac | reverse 1MB text | 0.0016s | 0.0053s | **0.3x** |
| tac | reverse 10MB text | 0.0081s | 0.0306s | **0.3x** |
| tac | reverse 100MB text | 0.0765s | 0.3421s | **0.2x** |
| tac | reverse CSV 10MB | 0.0079s | 0.0441s | **0.2x** |
| tac | reverse repetitive 10MB | 0.0167s | 0.1074s | **0.2x** |
| tac | custom separator 1MB | 0.0043s | 0.0384s | **0.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0542s | 0.0029s | **18.4x** |
| wc | default 100MB text | 0.4834s | 0.0136s | **35.6x** |
| wc | -l 10MB text | 0.0022s | 0.0025s | **0.9x** |
| wc | -w 10MB text | 0.0542s | 0.0088s | **6.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0536s | 0.0030s | **17.8x** |
| wc | -L 10MB text | 0.0543s | 0.0104s | **5.2x** |
| wc | default 10MB binary | 0.3175s | 0.0275s | **11.5x** |
| wc | default 10MB repetitive | 0.0734s | 0.0044s | **16.8x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0040s | **5.7x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0040s | **5.7x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0049s | **3.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0074s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0052s | **4.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0078s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0039s | 0.0028s | **1.4x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0025s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0094s | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0098s | **0.9x** |
| sha256sum | single 100MB text | 0.0741s | 0.0750s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0030s | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0170s | 0.0173s | **1.0x** |
| md5sum | single 10MB binary | 0.0181s | 0.0180s | **1.0x** |
| md5sum | single 100MB text | 0.1595s | 0.1525s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0031s | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0148s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0159s | 0.0127s | **1.3x** |
| b2sum | single 100MB text | 0.1418s | 0.1112s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0122s | **1.2x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0123s | 0.0045s | **2.7x** |
| base64 | encode 10MB binary | 0.0129s | 0.0046s | **2.8x** |
| base64 | decode 1MB | 0.0040s | 0.0026s | **1.6x** |
| base64 | decode 10MB | 0.0323s | 0.0161s | **2.0x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0046s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0036s | **2.4x** |
| sort | lexicographic 1MB | 0.0085s | 0.0035s | **2.4x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0089s | **6.0x** |
| sort | already sorted 10MB | 0.0262s | 0.0056s | **4.7x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0073s | **3.7x** |
| sort | -n numeric 10MB | 0.0731s | 0.0527s | **1.4x** |
| sort | -r reverse 10MB | 0.0544s | 0.0090s | **6.0x** |
| sort | -u unique 10MB | 0.0574s | 0.0127s | **4.5x** |
| sort | -t, -k2 CSV 10MB | 0.0661s | 0.0229s | **2.9x** |
| sort | repetitive 10MB | 0.0565s | 0.0099s | **5.7x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0091s | **6.0x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0074s | **1.7x** |
| tr | -d digits 10MB | 0.0163s | 0.0085s | **1.9x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0093s | **3.2x** |
| tr | -s spaces 10MB | 0.0273s | 0.0059s | **4.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0139s | 0.0074s | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0171s | 0.0086s | **2.0x** |
| tr | translate binary 10MB | 0.0109s | 0.0086s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0035s | **3.3x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0034s | **4.1x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0048s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0081s | **3.6x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0047s | **2.5x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0048s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0049s | **2.9x** |
| uniq | repetitive 10MB | 0.0422s | 0.0052s | **8.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0018s | **0.6x** |
| tac | reverse 1MB text | 0.0020s | 0.0121s | **0.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0783s | **0.1x** |
| tac | reverse 100MB text | 0.1030s | 0.8970s | **0.1x** |
| tac | reverse CSV 10MB | 0.0095s | 0.1156s | **0.1x** |
| tac | reverse repetitive 10MB | 0.0231s | 0.2881s | **0.1x** |
| tac | custom separator 1MB | 0.0060s | 0.1008s | **0.1x** |
