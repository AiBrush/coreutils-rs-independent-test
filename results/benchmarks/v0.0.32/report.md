# fcoreutils v0.0.32 — Detailed Results

Generated: 2026-02-15 04:16:27 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 412 | 1 | 99.8% |

**Overall: 1231/1239 (99.4%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0010s | **0.9x** |
| wc | default 1MB text | 0.0036s | 0.0024s | **1.5x** |
| wc | default 10MB text | 0.0331s | 0.0163s | **2.0x** |
| wc | default 100MB text | 0.2883s | 0.0394s | **7.3x** |
| wc | -l 10MB text | 0.0033s | 0.0019s | **1.7x** |
| wc | -w 10MB text | 0.0329s | 0.0166s | **2.0x** |
| wc | -c 10MB text | 0.0006s | 0.0008s | **0.8x** |
| wc | -m 10MB text | 0.0332s | 0.0019s | **17.8x** |
| wc | -L 10MB text | 0.0330s | 0.0164s | **2.0x** |
| wc | default 10MB binary | 0.2344s | 0.0595s | **3.9x** |
| wc | default 10MB repetitive | 0.0514s | 0.0063s | **8.2x** |
| wc | 10 files | 0.0007s | 0.0010s | **0.7x** |
| wc | 100 files | 0.0012s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0029s | **6.3x** |
| cut | -c1-100 10MB CSV | 0.0180s | 0.0030s | **6.1x** |
| cut | -d, -f1 10MB CSV | 0.0182s | 0.0042s | **4.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0043s | **4.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0228s | 0.0037s | **6.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0259s | 0.0046s | **5.7x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | **0.8x** |
| sha256sum | single 100KB text | 0.0011s | 0.0010s | **1.1x** |
| sha256sum | single 1MB text | 0.0016s | 0.0016s | **1.0x** |
| sha256sum | single 10MB text | 0.0065s | 0.0064s | **1.0x** |
| sha256sum | single 10MB binary | 0.0070s | 0.0069s | **1.0x** |
| sha256sum | single 100MB text | 0.0565s | 0.0549s | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0009s | **1.1x** |
| sha256sum | 100 files | 0.0016s | 0.0014s | **1.2x** |
| md5sum | single 100KB text | 0.0012s | 0.0010s | **1.1x** |
| md5sum | single 1MB text | 0.0029s | 0.0026s | **1.1x** |
| md5sum | single 10MB text | 0.0197s | 0.0163s | **1.2x** |
| md5sum | single 10MB binary | 0.0209s | 0.0176s | **1.2x** |
| md5sum | single 100MB text | 0.1883s | 0.1526s | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0010s | **1.1x** |
| md5sum | 100 files | 0.0015s | 0.0013s | **1.1x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | **0.9x** |
| b2sum | single 10MB text | 0.0128s | 0.0124s | **1.0x** |
| b2sum | single 10MB binary | 0.0136s | 0.0135s | **1.0x** |
| b2sum | single 100MB text | 0.1226s | 0.1164s | **1.1x** |
| b2sum | -l 256 10MB | 0.0129s | 0.0126s | **1.0x** |
| b2sum | -l 128 10MB | 0.0129s | 0.0126s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0014s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0015s | 0.0016s | **1.0x** |
| base64 | encode 10MB text | 0.0087s | 0.0046s | **1.9x** |
| base64 | encode 10MB binary | 0.0094s | 0.0049s | **1.9x** |
| base64 | decode 1MB | 0.0036s | 0.0023s | **1.5x** |
| base64 | decode 10MB | 0.0299s | 0.0134s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0088s | 0.0047s | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0067s | 0.0041s | **1.6x** |
| sort | lexicographic 1MB | 0.0074s | 0.0040s | **1.8x** |
| sort | lexicographic 10MB random | 0.0496s | 0.0105s | **4.7x** |
| sort | already sorted 10MB | 0.0248s | 0.0050s | **5.0x** |
| sort | reverse sorted 10MB | 0.0243s | 0.0071s | **3.4x** |
| sort | -n numeric 10MB | 0.0676s | 0.0218s | **3.1x** |
| sort | -r reverse 10MB | 0.0509s | 0.0111s | **4.6x** |
| sort | -u unique 10MB | 0.0525s | 0.0116s | **4.5x** |
| sort | -t, -k2 CSV 10MB | 0.0683s | 0.0358s | **1.9x** |
| sort | repetitive 10MB | 0.0418s | 0.0118s | **3.5x** |
| sort | --parallel=4 10MB | 0.0497s | 0.0107s | **4.7x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0017s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0063s | **1.5x** |
| tr | -d digits 10MB | 0.0110s | 0.0094s | **1.2x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0162s | **1.2x** |
| tr | -s spaces 10MB | 0.0166s | 0.0132s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0062s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0095s | **1.2x** |
| tr | translate binary 10MB | 0.0093s | 0.0062s | **1.5x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0059s | **1.5x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0050s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0059s | **1.5x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0075s | **3.9x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0059s | **1.5x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0059s | **1.5x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0057s | **2.8x** |
| uniq | repetitive 10MB | 0.0457s | 0.0083s | **5.5x** |
| tac | reverse 100KB text | 0.0007s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0015s | 0.0014s | **1.1x** |
| tac | reverse 10MB text | 0.0077s | 0.0042s | **1.8x** |
| tac | reverse 100MB text | 0.0757s | 0.0365s | **2.1x** |
| tac | reverse CSV 10MB | 0.0078s | 0.0040s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0162s | 0.0088s | **1.8x** |
| tac | custom separator 1MB | 0.0042s | 0.0029s | **1.5x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0028s | **2.1x** |
| wc | default 10MB text | 0.0541s | 0.0203s | **2.7x** |
| wc | default 100MB text | 0.4816s | 0.0699s | **6.9x** |
| wc | -l 10MB text | 0.0020s | 0.0020s | **1.0x** |
| wc | -w 10MB text | 0.0541s | 0.0197s | **2.8x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0540s | 0.0022s | **24.8x** |
| wc | -L 10MB text | 0.0542s | 0.0230s | **2.4x** |
| wc | default 10MB binary | 0.3172s | 0.0818s | **3.9x** |
| wc | default 10MB repetitive | 0.0728s | 0.0126s | **5.8x** |
| wc | 10 files | 0.0010s | 0.0011s | **0.9x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0041s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0041s | **5.5x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0061s | **2.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0080s | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0075s | **3.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0308s | 0.0087s | **3.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0030s | **1.1x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0011s | **1.2x** |
| sha256sum | single 1MB text | 0.0020s | 0.0018s | **1.1x** |
| sha256sum | single 10MB text | 0.0084s | 0.0081s | **1.0x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0084s | **1.0x** |
| sha256sum | single 100MB text | 0.0742s | 0.0721s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0011s | **1.2x** |
| sha256sum | 100 files | 0.0024s | 0.0019s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0012s | **1.2x** |
| md5sum | single 1MB text | 0.0029s | 0.0031s | **0.9x** |
| md5sum | single 10MB text | 0.0172s | 0.0203s | **0.8x** |
| md5sum | single 10MB binary | 0.0178s | 0.0211s | **0.8x** |
| md5sum | single 100MB text | 0.1600s | 0.1915s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0011s | **1.2x** |
| md5sum | 100 files | 0.0024s | 0.0019s | **1.3x** |
| b2sum | single 100KB text | 0.0010s | 0.0027s | **0.4x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0120s | **1.2x** |
| b2sum | single 10MB binary | 0.0154s | 0.0123s | **1.3x** |
| b2sum | single 100MB text | 0.1419s | 0.1095s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0119s | **1.2x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0119s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0020s | 0.0017s | **1.2x** |
| base64 | encode 10MB text | 0.0122s | 0.0044s | **2.8x** |
| base64 | encode 10MB binary | 0.0128s | 0.0047s | **2.7x** |
| base64 | decode 1MB | 0.0039s | 0.0022s | **1.8x** |
| base64 | decode 10MB | 0.0322s | 0.0112s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0045s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0033s | **2.6x** |
| sort | lexicographic 1MB | 0.0085s | 0.0049s | **1.8x** |
| sort | lexicographic 10MB random | 0.0538s | 0.0113s | **4.8x** |
| sort | already sorted 10MB | 0.0261s | 0.0067s | **3.9x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0102s | **2.7x** |
| sort | -n numeric 10MB | 0.0731s | 0.0293s | **2.5x** |
| sort | -r reverse 10MB | 0.0542s | 0.0114s | **4.7x** |
| sort | -u unique 10MB | 0.0575s | 0.0118s | **4.9x** |
| sort | -t, -k2 CSV 10MB | 0.0662s | 0.0373s | **1.8x** |
| sort | repetitive 10MB | 0.0546s | 0.0156s | **3.5x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0115s | **4.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0018s | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0051s | **2.4x** |
| tr | -d digits 10MB | 0.0158s | 0.0121s | **1.3x** |
| tr | -d lowercase 10MB | 0.0312s | 0.0210s | **1.5x** |
| tr | -s spaces 10MB | 0.0280s | 0.0138s | **2.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0129s | 0.0051s | **2.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0158s | 0.0119s | **1.3x** |
| tr | translate binary 10MB | 0.0117s | 0.0049s | **2.4x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0068s | **1.7x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0065s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0069s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0098s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0072s | **1.7x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0070s | **1.7x** |
| uniq | -i case insensitive 10MB | 0.0138s | 0.0073s | **1.9x** |
| uniq | repetitive 10MB | 0.0422s | 0.0085s | **5.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0052s | **2.0x** |
| tac | reverse 100MB text | 0.1045s | 0.0425s | **2.5x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0055s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0102s | **2.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0037s | **1.6x** |
