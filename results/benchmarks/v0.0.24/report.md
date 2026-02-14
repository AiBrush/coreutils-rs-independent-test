# fcoreutils v0.0.24 — Detailed Results

Generated: 2026-02-14 19:51:29 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 397 | 16 | 96.1% |
| Linux_aarch64 | 413 | 402 | 11 | 97.3% |
| Linux_x86_64 | 413 | 402 | 11 | 97.3% |

**Overall: 1201/1239 (96.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0010s | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0025s | **1.5x** |
| wc | default 10MB text | 0.0335s | 0.0166s | **2.0x** |
| wc | default 100MB text | 0.2906s | 0.0394s | **7.4x** |
| wc | -l 10MB text | 0.0034s | 0.0019s | **1.8x** |
| wc | -w 10MB text | 0.0335s | 0.0166s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0335s | 0.0018s | **18.5x** |
| wc | -L 10MB text | 0.0335s | 0.0170s | **2.0x** |
| wc | default 10MB binary | 0.2349s | 0.0596s | **3.9x** |
| wc | default 10MB repetitive | 0.0514s | 0.0070s | **7.3x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0050s | **3.7x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0049s | **3.8x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0030s | **6.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0056s | **3.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0231s | 0.0052s | **4.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0066s | **4.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0016s | **2.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0009s | **1.3x** |
| sha256sum | single 1MB text | 0.0017s | 0.0017s | **1.0x** |
| sha256sum | single 10MB text | 0.0066s | 0.0069s | **1.0x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0072s | **1.0x** |
| sha256sum | single 100MB text | 0.0602s | 0.0598s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0009s | **1.6x** |
| sha256sum | 100 files | 0.0018s | 0.0013s | **1.3x** |
| md5sum | single 100KB text | 0.0013s | 0.0010s | **1.2x** |
| md5sum | single 1MB text | 0.0030s | 0.0026s | **1.2x** |
| md5sum | single 10MB text | 0.0202s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0215s | 0.0166s | **1.3x** |
| md5sum | single 100MB text | 0.1916s | 0.1489s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0009s | **1.3x** |
| md5sum | 100 files | 0.0017s | 0.0013s | **1.3x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | **0.8x** |
| b2sum | single 1MB text | 0.0021s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0133s | 0.0129s | **1.0x** |
| b2sum | single 10MB binary | 0.0144s | 0.0134s | **1.1x** |
| b2sum | single 100MB text | 0.1266s | 0.1191s | **1.1x** |
| b2sum | -l 256 10MB | 0.0132s | 0.0129s | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0129s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0013s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0027s | **0.6x** |
| base64 | encode 10MB text | 0.0092s | 0.0061s | **1.5x** |
| base64 | encode 10MB binary | 0.0100s | 0.0063s | **1.6x** |
| base64 | decode 1MB | 0.0038s | 0.0030s | **1.3x** |
| base64 | decode 10MB | 0.0307s | 0.0192s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0091s | 0.0061s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0068s | 0.0047s | **1.4x** |
| sort | lexicographic 1MB | 0.0076s | 0.0040s | **1.9x** |
| sort | lexicographic 10MB random | 0.0514s | 0.0166s | **3.1x** |
| sort | already sorted 10MB | 0.0243s | 0.0094s | **2.6x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0093s | **2.7x** |
| sort | -n numeric 10MB | 0.0702s | 0.0090s | **7.8x** |
| sort | -r reverse 10MB | 0.0524s | 0.0179s | **2.9x** |
| sort | -u unique 10MB | 0.0556s | 0.0187s | **3.0x** |
| sort | -t, -k2 CSV 10MB | 0.0740s | 0.0329s | **2.2x** |
| sort | repetitive 10MB | 0.0436s | 0.0171s | **2.5x** |
| sort | --parallel=4 10MB | 0.0519s | 0.0170s | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0016s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0062s | **1.4x** |
| tr | -d digits 10MB | 0.0112s | 0.0099s | **1.1x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0167s | **1.1x** |
| tr | -s spaces 10MB | 0.0170s | 0.0137s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0063s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0098s | **1.1x** |
| tr | translate binary 10MB | 0.0090s | 0.0063s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0053s | **1.7x** |
| uniq | default 10MB sorted (low dup) | 0.0161s | 0.0066s | **2.4x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0052s | **1.8x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0095s | **3.1x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0053s | **1.8x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0052s | **1.8x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0073s | **2.2x** |
| uniq | repetitive 10MB | 0.0464s | 0.0074s | **6.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0081s | 0.0042s | **2.0x** |
| tac | reverse 100MB text | 0.0772s | 0.0373s | **2.1x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0042s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0091s | **1.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0035s | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0033s | **1.8x** |
| wc | default 10MB text | 0.0543s | 0.0201s | **2.7x** |
| wc | default 100MB text | 0.4825s | 0.0790s | **6.1x** |
| wc | -l 10MB text | 0.0020s | 0.0017s | **1.1x** |
| wc | -w 10MB text | 0.0546s | 0.0198s | **2.8x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0543s | 0.0018s | **30.2x** |
| wc | -L 10MB text | 0.0544s | 0.0229s | **2.4x** |
| wc | default 10MB binary | 0.3174s | 0.0823s | **3.9x** |
| wc | default 10MB repetitive | 0.0732s | 0.0132s | **5.6x** |
| wc | 10 files | 0.0010s | 0.0009s | **1.1x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0051s | **4.4x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0051s | **4.5x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0033s | **5.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0071s | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0068s | **3.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0100s | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0021s | **1.5x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0008s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.3x** |
| sha256sum | single 1MB text | 0.0020s | 0.0023s | **0.9x** |
| sha256sum | single 10MB text | 0.0084s | 0.0079s | **1.1x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0082s | **1.1x** |
| sha256sum | single 100MB text | 0.0742s | 0.0713s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0010s | **1.5x** |
| sha256sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| md5sum | single 100KB text | 0.0015s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0028s | 0.0035s | **0.8x** |
| md5sum | single 10MB text | 0.0170s | 0.0199s | **0.9x** |
| md5sum | single 10MB binary | 0.0178s | 0.0207s | **0.9x** |
| md5sum | single 100MB text | 0.1604s | 0.1913s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0009s | **1.4x** |
| md5sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| b2sum | single 100KB text | 0.0010s | 0.0010s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0027s | **0.9x** |
| b2sum | single 10MB text | 0.0148s | 0.0116s | **1.3x** |
| b2sum | single 10MB binary | 0.0157s | 0.0122s | **1.3x** |
| b2sum | single 100MB text | 0.1417s | 0.1090s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0116s | **1.3x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0116s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0018s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0033s | **0.6x** |
| base64 | encode 10MB text | 0.0123s | 0.0055s | **2.2x** |
| base64 | encode 10MB binary | 0.0128s | 0.0056s | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0030s | **1.3x** |
| base64 | decode 10MB | 0.0321s | 0.0171s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0054s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0031s | **2.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0041s | **2.1x** |
| sort | lexicographic 10MB random | 0.0540s | 0.0168s | **3.2x** |
| sort | already sorted 10MB | 0.0261s | 0.0103s | **2.5x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0113s | **2.4x** |
| sort | -n numeric 10MB | 0.0732s | 0.0096s | **7.7x** |
| sort | -r reverse 10MB | 0.0545s | 0.0173s | **3.1x** |
| sort | -u unique 10MB | 0.0574s | 0.0174s | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0665s | 0.0317s | **2.1x** |
| sort | repetitive 10MB | 0.0548s | 0.0171s | **3.2x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0169s | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0090s | **1.4x** |
| tr | -d digits 10MB | 0.0172s | 0.0152s | **1.1x** |
| tr | -d lowercase 10MB | 0.0286s | 0.0247s | **1.2x** |
| tr | -s spaces 10MB | 0.0267s | 0.0169s | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0091s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0167s | 0.0150s | **1.1x** |
| tr | translate binary 10MB | 0.0115s | 0.0085s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0053s | **2.2x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0067s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0054s | **2.3x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0101s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0052s | **2.3x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0052s | **2.3x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0071s | **2.0x** |
| uniq | repetitive 10MB | 0.0421s | 0.0068s | **6.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0021s | **0.9x** |
| tac | reverse 10MB text | 0.0105s | 0.0042s | **2.5x** |
| tac | reverse 100MB text | 0.1025s | 0.0368s | **2.8x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0045s | **2.1x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0092s | **2.5x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | **1.4x** |
