# fcoreutils v0.0.25 — Detailed Results

Generated: 2026-02-19 02:02:07 UTC

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
| wc | default 100KB text | 0.0010s | 0.0010s | **1.0x** |
| wc | default 1MB text | 0.0038s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0335s | 0.0171s | **2.0x** |
| wc | default 100MB text | 0.2920s | 0.0390s | **7.5x** |
| wc | -l 10MB text | 0.0036s | 0.0020s | **1.7x** |
| wc | -w 10MB text | 0.0336s | 0.0168s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0335s | 0.0019s | **17.8x** |
| wc | -L 10MB text | 0.0336s | 0.0170s | **2.0x** |
| wc | default 10MB binary | 0.2357s | 0.0594s | **4.0x** |
| wc | default 10MB repetitive | 0.0516s | 0.0076s | **6.8x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0013s | 0.0013s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0050s | **3.7x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0050s | **3.8x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0033s | **5.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0060s | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0053s | **4.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0068s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0016s | **2.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0010s | **1.2x** |
| sha256sum | single 1MB text | 0.0017s | 0.0018s | **1.0x** |
| sha256sum | single 10MB text | 0.0067s | 0.0070s | **1.0x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0072s | **1.0x** |
| sha256sum | single 100MB text | 0.0604s | 0.0595s | **1.0x** |
| sha256sum | 10 files | 0.0011s | 0.0008s | **1.3x** |
| sha256sum | 100 files | 0.0018s | 0.0014s | **1.3x** |
| md5sum | single 100KB text | 0.0013s | 0.0011s | **1.2x** |
| md5sum | single 1MB text | 0.0033s | 0.0027s | **1.2x** |
| md5sum | single 10MB text | 0.0202s | 0.0159s | **1.3x** |
| md5sum | single 10MB binary | 0.0218s | 0.0167s | **1.3x** |
| md5sum | single 100MB text | 0.1921s | 0.1490s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0009s | **1.3x** |
| md5sum | 100 files | 0.0017s | 0.0014s | **1.2x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | **1.0x** |
| b2sum | single 1MB text | 0.0021s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0132s | 0.0129s | **1.0x** |
| b2sum | single 10MB binary | 0.0143s | 0.0134s | **1.1x** |
| b2sum | single 100MB text | 0.1264s | 0.1188s | **1.1x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0129s | **1.0x** |
| b2sum | -l 128 10MB | 0.0132s | 0.0129s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0013s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0026s | **0.6x** |
| base64 | encode 10MB text | 0.0091s | 0.0061s | **1.5x** |
| base64 | encode 10MB binary | 0.0100s | 0.0064s | **1.6x** |
| base64 | decode 1MB | 0.0038s | 0.0029s | **1.3x** |
| base64 | decode 10MB | 0.0307s | 0.0189s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0090s | 0.0060s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0067s | 0.0046s | **1.4x** |
| sort | lexicographic 1MB | 0.0075s | 0.0039s | **1.9x** |
| sort | lexicographic 10MB random | 0.0519s | 0.0160s | **3.2x** |
| sort | already sorted 10MB | 0.0248s | 0.0065s | **3.8x** |
| sort | reverse sorted 10MB | 0.0246s | 0.0087s | **2.8x** |
| sort | -n numeric 10MB | 0.0702s | 0.0063s | **11.2x** |
| sort | -r reverse 10MB | 0.0531s | 0.0163s | **3.3x** |
| sort | -u unique 10MB | 0.0550s | 0.0174s | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0708s | 0.0317s | **2.2x** |
| sort | repetitive 10MB | 0.0437s | 0.0146s | **3.0x** |
| sort | --parallel=4 10MB | 0.0511s | 0.0165s | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0017s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0062s | **1.4x** |
| tr | -d digits 10MB | 0.0111s | 0.0099s | **1.1x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0167s | **1.2x** |
| tr | -s spaces 10MB | 0.0170s | 0.0139s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0064s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0098s | **1.1x** |
| tr | translate binary 10MB | 0.0091s | 0.0066s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0051s | **1.8x** |
| uniq | default 10MB sorted (low dup) | 0.0160s | 0.0065s | **2.5x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0052s | **1.8x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0094s | **3.1x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0052s | **1.8x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0051s | **1.8x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0072s | **2.2x** |
| uniq | repetitive 10MB | 0.0464s | 0.0073s | **6.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0080s | 0.0042s | **1.9x** |
| tac | reverse 100MB text | 0.0770s | 0.0372s | **2.1x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0042s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0168s | 0.0090s | **1.9x** |
| tac | custom separator 1MB | 0.0043s | 0.0036s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0033s | **1.8x** |
| wc | default 10MB text | 0.0542s | 0.0201s | **2.7x** |
| wc | default 100MB text | 0.4828s | 0.0780s | **6.2x** |
| wc | -l 10MB text | 0.0020s | 0.0017s | **1.2x** |
| wc | -w 10MB text | 0.0541s | 0.0193s | **2.8x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0543s | 0.0017s | **31.4x** |
| wc | -L 10MB text | 0.0542s | 0.0227s | **2.4x** |
| wc | default 10MB binary | 0.3180s | 0.0814s | **3.9x** |
| wc | default 10MB repetitive | 0.0729s | 0.0134s | **5.5x** |
| wc | 10 files | 0.0010s | 0.0009s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0051s | **4.4x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0050s | **4.5x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0033s | **5.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0072s | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0238s | 0.0067s | **3.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0311s | 0.0099s | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0022s | **1.5x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0008s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0020s | 0.0023s | **0.9x** |
| sha256sum | single 10MB text | 0.0083s | 0.0079s | **1.1x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0082s | **1.1x** |
| sha256sum | single 100MB text | 0.0743s | 0.0713s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0010s | **1.5x** |
| sha256sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| md5sum | single 100KB text | 0.0015s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0035s | **0.8x** |
| md5sum | single 10MB text | 0.0171s | 0.0199s | **0.9x** |
| md5sum | single 10MB binary | 0.0177s | 0.0208s | **0.9x** |
| md5sum | single 100MB text | 0.1606s | 0.1912s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0009s | **1.5x** |
| md5sum | 100 files | 0.0023s | 0.0018s | **1.3x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0027s | **0.9x** |
| b2sum | single 10MB text | 0.0149s | 0.0116s | **1.3x** |
| b2sum | single 10MB binary | 0.0155s | 0.0121s | **1.3x** |
| b2sum | single 100MB text | 0.1427s | 0.1091s | **1.3x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0117s | **1.3x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0116s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0033s | **0.6x** |
| base64 | encode 10MB text | 0.0122s | 0.0054s | **2.3x** |
| base64 | encode 10MB binary | 0.0127s | 0.0056s | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0030s | **1.3x** |
| base64 | decode 10MB | 0.0323s | 0.0172s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0056s | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0031s | **2.7x** |
| sort | lexicographic 1MB | 0.0085s | 0.0043s | **2.0x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0161s | **3.4x** |
| sort | already sorted 10MB | 0.0263s | 0.0068s | **3.9x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0104s | **2.6x** |
| sort | -n numeric 10MB | 0.0733s | 0.0063s | **11.7x** |
| sort | -r reverse 10MB | 0.0545s | 0.0164s | **3.3x** |
| sort | -u unique 10MB | 0.0575s | 0.0167s | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0664s | 0.0311s | **2.1x** |
| sort | repetitive 10MB | 0.0550s | 0.0130s | **4.2x** |
| sort | --parallel=4 10MB | 0.0540s | 0.0162s | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0020s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0088s | **1.4x** |
| tr | -d digits 10MB | 0.0158s | 0.0147s | **1.1x** |
| tr | -d lowercase 10MB | 0.0300s | 0.0251s | **1.2x** |
| tr | -s spaces 10MB | 0.0254s | 0.0167s | **1.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0091s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0157s | 0.0149s | **1.1x** |
| tr | translate binary 10MB | 0.0119s | 0.0087s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0053s | **2.2x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0066s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0053s | **2.3x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0100s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0052s | **2.3x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0053s | **2.3x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0072s | **2.0x** |
| uniq | repetitive 10MB | 0.0423s | 0.0068s | **6.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0021s | **0.9x** |
| tac | reverse 10MB text | 0.0107s | 0.0042s | **2.5x** |
| tac | reverse 100MB text | 0.1038s | 0.0377s | **2.8x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0047s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0234s | 0.0093s | **2.5x** |
| tac | custom separator 1MB | 0.0060s | 0.0043s | **1.4x** |
