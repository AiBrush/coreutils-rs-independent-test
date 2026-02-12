# fcoreutils v0.0.26 — Detailed Results

Generated: 2026-02-12 20:15:42 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 397 | 16 | 96.1% |
| Linux_aarch64 | 413 | 402 | 11 | 97.3% |
| Linux_x86_64 | 413 | 402 | 11 | 97.3% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |

**Overall: 1201/1239 (96.9%)**

## Performance

### Darwin_arm64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0040s | 0.0027s | **1.5x** |
| wc | default 1MB text | 0.0083s | 0.0045s | **1.8x** |
| wc | default 10MB text | 0.0307s | 0.0214s | **1.4x** |
| wc | default 100MB text | 0.2425s | 0.0645s | **3.8x** |
| wc | -l 10MB text | 0.0064s | 0.0047s | **1.4x** |
| wc | -w 10MB text | 0.0289s | 0.0212s | **1.4x** |
| wc | -c 10MB text | 0.0029s | 0.0021s | **1.4x** |
| wc | -m 10MB text | 0.0290s | 0.0033s | **8.8x** |
| wc | -L 10MB text | 0.0308s | 0.0199s | **1.6x** |
| wc | default 10MB binary | 0.1319s | 0.0994s | **1.3x** |
| wc | default 10MB repetitive | 0.0494s | 0.0137s | **3.6x** |
| wc | 10 files | 0.0026s | 0.0047s | **0.5x** |
| wc | 100 files | 0.0102s | 0.0060s | **1.7x** |
| cut | -b1-100 10MB CSV | 0.0378s | 0.0116s | **3.3x** |
| cut | -c1-100 10MB CSV | 0.0258s | 0.0118s | **2.2x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0045s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0304s | 0.0079s | **3.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0333s | 0.0077s | **4.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0473s | 0.0103s | **4.6x** |
| cut | -d, -f1 100KB text | 0.0014s | 0.0024s | **0.6x** |
| cut | -d, -f1 1MB text | 0.0046s | 0.0024s | **2.0x** |
| cut | -d: -f1 colon file | 0.0024s | 0.0019s | **1.3x** |
| sha256sum | single 100KB text | 0.0024s | 0.0022s | **1.1x** |
| sha256sum | single 1MB text | 0.0072s | 0.0028s | **2.6x** |
| sha256sum | single 10MB text | 0.0371s | 0.0071s | **5.2x** |
| sha256sum | single 10MB binary | 0.0402s | 0.0091s | **4.4x** |
| sha256sum | single 100MB text | 0.4034s | 0.0675s | **6.0x** |
| sha256sum | 10 files | 0.0035s | 0.0045s | **0.8x** |
| sha256sum | 100 files | 0.0103s | 0.0075s | **1.4x** |
| md5sum | single 100KB text | 0.0042s | 0.0062s | **0.7x** |
| md5sum | single 1MB text | 0.0026s | 0.0032s | **0.8x** |
| md5sum | single 10MB text | 0.0232s | 0.0220s | **1.1x** |
| md5sum | single 10MB binary | 0.0199s | 0.0212s | **0.9x** |
| md5sum | single 100MB text | 0.1755s | 0.1773s | **1.0x** |
| md5sum | 10 files | 0.0021s | 0.0023s | **0.9x** |
| md5sum | 100 files | 0.0036s | 0.0049s | **0.7x** |
| b2sum | single 100KB text | 0.0014s | 0.0040s | **0.3x** |
| b2sum | single 1MB text | 0.0040s | 0.0029s | **1.4x** |
| b2sum | single 10MB text | 0.0208s | 0.0142s | **1.5x** |
| b2sum | single 10MB binary | 0.0196s | 0.0212s | **0.9x** |
| b2sum | single 100MB text | 0.1755s | 0.1488s | **1.2x** |
| b2sum | -l 256 10MB | 0.0207s | 0.0146s | **1.4x** |
| b2sum | -l 128 10MB | 0.0242s | 0.0162s | **1.5x** |
| b2sum | 100 files | 0.0090s | 0.0055s | **1.6x** |
| base64 | encode 100KB text | 0.0026s | 0.0019s | **1.4x** |
| base64 | encode 1MB text | 0.0049s | 0.0033s | **1.5x** |
| base64 | encode 10MB text | 0.0169s | 0.0030s | **5.6x** |
| base64 | encode 10MB binary | 0.0153s | 0.0051s | **3.0x** |
| base64 | decode 1MB | 0.0040s | 0.0024s | **1.7x** |
| base64 | decode 10MB | 0.0299s | 0.0129s | **2.3x** |
| base64 | encode -w 76 10MB | 0.0152s | 0.0055s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0040s | **2.0x** |
| sort | lexicographic 1MB | 0.1018s | 0.0039s | **26.0x** |
| sort | lexicographic 10MB random | 0.4813s | 0.0258s | **18.7x** |
| sort | already sorted 10MB | 0.2749s | 0.0086s | **32.0x** |
| sort | reverse sorted 10MB | 0.2271s | 0.0095s | **24.0x** |
| sort | -n numeric 10MB | 0.4566s | 0.0074s | **61.8x** |
| sort | -r reverse 10MB | 0.5087s | 0.0203s | **25.1x** |
| sort | -u unique 10MB | 0.4855s | 0.0148s | **32.8x** |
| sort | -t, -k2 CSV 10MB | 0.7269s | 0.0516s | **14.1x** |
| sort | repetitive 10MB | 0.0825s | 0.0170s | **4.8x** |
| sort | --parallel=4 10MB | 0.4836s | 0.0278s | **17.4x** |
| tr | a-z to A-Z 1MB | 0.0046s | 0.0037s | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0213s | 0.0110s | **1.9x** |
| tr | -d digits 10MB | 0.0272s | 0.0131s | **2.1x** |
| tr | -d lowercase 10MB | 0.0494s | 0.0296s | **1.7x** |
| tr | -s spaces 10MB | 0.0556s | 0.0202s | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0250s | 0.0101s | **2.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0283s | 0.0143s | **2.0x** |
| tr | translate binary 10MB | 0.0309s | 0.0149s | **2.1x** |
| uniq | default 10MB many duplicates | 0.0166s | 0.0106s | **1.6x** |
| uniq | default 10MB sorted (low dup) | 0.0305s | 0.0134s | **2.3x** |
| uniq | -c count 10MB many dups | 0.0130s | 0.0084s | **1.6x** |
| uniq | -c count 10MB sorted | 0.0350s | 0.0125s | **2.8x** |
| uniq | -d duplicates only 10MB | 0.0116s | 0.0100s | **1.2x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0092s | **1.3x** |
| uniq | -i case insensitive 10MB | 0.0194s | 0.0108s | **1.8x** |
| uniq | repetitive 10MB | 0.0385s | 0.0081s | **4.7x** |
| tac | reverse 100KB text | 0.0029s | 0.0029s | **1.0x** |
| tac | reverse 1MB text | 0.0047s | 0.0028s | **1.7x** |
| tac | reverse 10MB text | 0.0153s | 0.0082s | **1.9x** |
| tac | reverse 100MB text | 0.1321s | 0.0615s | **2.1x** |
| tac | reverse CSV 10MB | 0.0149s | 0.0091s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0312s | 0.0191s | **1.6x** |
| tac | custom separator 1MB | 0.0111s | 0.0089s | **1.2x** |

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0010s | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0026s | **1.4x** |
| wc | default 10MB text | 0.0335s | 0.0167s | **2.0x** |
| wc | default 100MB text | 0.2912s | 0.0394s | **7.4x** |
| wc | -l 10MB text | 0.0035s | 0.0020s | **1.8x** |
| wc | -w 10MB text | 0.0335s | 0.0166s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0334s | 0.0018s | **18.7x** |
| wc | -L 10MB text | 0.0335s | 0.0169s | **2.0x** |
| wc | default 10MB binary | 0.2344s | 0.0596s | **3.9x** |
| wc | default 10MB repetitive | 0.0512s | 0.0067s | **7.7x** |
| wc | 10 files | 0.0008s | 0.0008s | **0.9x** |
| wc | 100 files | 0.0013s | 0.0013s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0048s | **3.8x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0047s | **4.0x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0032s | **5.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0054s | **3.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0231s | 0.0050s | **4.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0068s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0016s | **2.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0009s | **1.2x** |
| sha256sum | single 1MB text | 0.0017s | 0.0018s | **0.9x** |
| sha256sum | single 10MB text | 0.0067s | 0.0083s | **0.8x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0088s | **0.8x** |
| sha256sum | single 100MB text | 0.0604s | 0.0661s | **0.9x** |
| sha256sum | 10 files | 0.0011s | 0.0009s | **1.3x** |
| sha256sum | 100 files | 0.0018s | 0.0013s | **1.3x** |
| md5sum | single 100KB text | 0.0013s | 0.0010s | **1.2x** |
| md5sum | single 1MB text | 0.0031s | 0.0026s | **1.2x** |
| md5sum | single 10MB text | 0.0202s | 0.0174s | **1.2x** |
| md5sum | single 10MB binary | 0.0218s | 0.0185s | **1.2x** |
| md5sum | single 100MB text | 0.1917s | 0.1555s | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0009s | **1.3x** |
| md5sum | 100 files | 0.0017s | 0.0014s | **1.3x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | **0.9x** |
| b2sum | single 1MB text | 0.0021s | 0.0024s | **0.8x** |
| b2sum | single 10MB text | 0.0132s | 0.0144s | **0.9x** |
| b2sum | single 10MB binary | 0.0143s | 0.0159s | **0.9x** |
| b2sum | single 100MB text | 0.1262s | 0.1299s | **1.0x** |
| b2sum | -l 256 10MB | 0.0132s | 0.0149s | **0.9x** |
| b2sum | -l 128 10MB | 0.0132s | 0.0148s | **0.9x** |
| b2sum | 100 files | 0.0016s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0027s | **0.6x** |
| base64 | encode 10MB text | 0.0093s | 0.0063s | **1.5x** |
| base64 | encode 10MB binary | 0.0100s | 0.0064s | **1.6x** |
| base64 | decode 1MB | 0.0038s | 0.0031s | **1.2x** |
| base64 | decode 10MB | 0.0310s | 0.0193s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0092s | 0.0060s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0070s | 0.0046s | **1.5x** |
| sort | lexicographic 1MB | 0.0074s | 0.0039s | **1.9x** |
| sort | lexicographic 10MB random | 0.0520s | 0.0163s | **3.2x** |
| sort | already sorted 10MB | 0.0246s | 0.0065s | **3.8x** |
| sort | reverse sorted 10MB | 0.0244s | 0.0089s | **2.7x** |
| sort | -n numeric 10MB | 0.0706s | 0.0061s | **11.5x** |
| sort | -r reverse 10MB | 0.0521s | 0.0163s | **3.2x** |
| sort | -u unique 10MB | 0.0549s | 0.0182s | **3.0x** |
| sort | -t, -k2 CSV 10MB | 0.0716s | 0.0312s | **2.3x** |
| sort | repetitive 10MB | 0.0435s | 0.0144s | **3.0x** |
| sort | --parallel=4 10MB | 0.0516s | 0.0162s | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0062s | **1.5x** |
| tr | -d digits 10MB | 0.0113s | 0.0099s | **1.1x** |
| tr | -d lowercase 10MB | 0.0194s | 0.0167s | **1.2x** |
| tr | -s spaces 10MB | 0.0170s | 0.0139s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0062s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0099s | **1.1x** |
| tr | translate binary 10MB | 0.0092s | 0.0064s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0053s | **1.8x** |
| uniq | default 10MB sorted (low dup) | 0.0161s | 0.0066s | **2.4x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0053s | **1.8x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0096s | **3.0x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0053s | **1.8x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0053s | **1.8x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0073s | **2.2x** |
| uniq | repetitive 10MB | 0.0465s | 0.0078s | **6.0x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0082s | 0.0044s | **1.9x** |
| tac | reverse 100MB text | 0.0771s | 0.0372s | **2.1x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0042s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0092s | **1.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0036s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0010s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0033s | **1.7x** |
| wc | default 10MB text | 0.0541s | 0.0204s | **2.7x** |
| wc | default 100MB text | 0.4829s | 0.0660s | **7.3x** |
| wc | -l 10MB text | 0.0021s | 0.0017s | **1.2x** |
| wc | -w 10MB text | 0.0541s | 0.0216s | **2.5x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0541s | 0.0017s | **31.1x** |
| wc | -L 10MB text | 0.0541s | 0.0227s | **2.4x** |
| wc | default 10MB binary | 0.3172s | 0.0823s | **3.9x** |
| wc | default 10MB repetitive | 0.0759s | 0.0113s | **6.7x** |
| wc | 10 files | 0.0010s | 0.0009s | **1.1x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0052s | **4.3x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0050s | **4.5x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0033s | **5.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0073s | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0067s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0100s | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0022s | **1.5x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0020s | 0.0023s | **0.9x** |
| sha256sum | single 10MB text | 0.0084s | 0.0111s | **0.8x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0115s | **0.8x** |
| sha256sum | single 100MB text | 0.0747s | 0.1028s | **0.7x** |
| sha256sum | 10 files | 0.0014s | 0.0009s | **1.5x** |
| sha256sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0035s | **0.8x** |
| md5sum | single 10MB text | 0.0170s | 0.0233s | **0.7x** |
| md5sum | single 10MB binary | 0.0177s | 0.0242s | **0.7x** |
| md5sum | single 100MB text | 0.1605s | 0.2227s | **0.7x** |
| md5sum | 10 files | 0.0014s | 0.0010s | **1.4x** |
| md5sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0027s | **0.9x** |
| b2sum | single 10MB text | 0.0151s | 0.0149s | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0155s | **1.0x** |
| b2sum | single 100MB text | 0.1423s | 0.1405s | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0149s | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0150s | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0018s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0032s | **0.6x** |
| base64 | encode 10MB text | 0.0122s | 0.0054s | **2.3x** |
| base64 | encode 10MB binary | 0.0127s | 0.0056s | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0034s | **1.2x** |
| base64 | decode 10MB | 0.0323s | 0.0216s | **1.5x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0054s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0031s | **2.7x** |
| sort | lexicographic 1MB | 0.0085s | 0.0043s | **2.0x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0161s | **3.3x** |
| sort | already sorted 10MB | 0.0262s | 0.0068s | **3.8x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0104s | **2.6x** |
| sort | -n numeric 10MB | 0.0735s | 0.0062s | **11.8x** |
| sort | -r reverse 10MB | 0.0547s | 0.0164s | **3.3x** |
| sort | -u unique 10MB | 0.0576s | 0.0162s | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0665s | 0.0310s | **2.1x** |
| sort | repetitive 10MB | 0.0550s | 0.0127s | **4.3x** |
| sort | --parallel=4 10MB | 0.0538s | 0.0160s | **3.4x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0020s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0088s | **1.4x** |
| tr | -d digits 10MB | 0.0162s | 0.0148s | **1.1x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0252s | **1.2x** |
| tr | -s spaces 10MB | 0.0264s | 0.0167s | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0085s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0158s | 0.0148s | **1.1x** |
| tr | translate binary 10MB | 0.0119s | 0.0084s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0053s | **2.3x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0067s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0054s | **2.2x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0095s | **3.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0053s | **2.3x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0053s | **2.3x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0071s | **2.0x** |
| uniq | repetitive 10MB | 0.0419s | 0.0066s | **6.3x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0021s | **0.9x** |
| tac | reverse 10MB text | 0.0107s | 0.0043s | **2.5x** |
| tac | reverse 100MB text | 0.1031s | 0.0373s | **2.8x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0046s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0094s | **2.5x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | **1.4x** |
