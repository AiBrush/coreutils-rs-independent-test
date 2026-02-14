# fcoreutils v0.0.30 — Detailed Results

Generated: 2026-02-14 12:39:17 UTC

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
| wc | default 1MB text | 0.0039s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0343s | 0.0174s | **2.0x** |
| wc | default 100MB text | 0.2958s | 0.0438s | **6.8x** |
| wc | -l 10MB text | 0.0045s | 0.0022s | **2.0x** |
| wc | -w 10MB text | 0.0343s | 0.0168s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0342s | 0.0021s | **16.6x** |
| wc | -L 10MB text | 0.0343s | 0.0172s | **2.0x** |
| wc | default 10MB binary | 0.2345s | 0.0601s | **3.9x** |
| wc | default 10MB repetitive | 0.0509s | 0.0071s | **7.2x** |
| wc | 10 files | 0.0009s | 0.0010s | **0.9x** |
| wc | 100 files | 0.0013s | 0.0016s | **0.8x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0051s | **3.6x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0053s | **3.5x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0049s | **3.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0061s | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0052s | **4.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0078s | **3.4x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | **0.9x** |
| sha256sum | single 100KB text | 0.0013s | 0.0010s | **1.3x** |
| sha256sum | single 1MB text | 0.0019s | 0.0018s | **1.0x** |
| sha256sum | single 10MB text | 0.0080s | 0.0078s | **1.0x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0081s | **1.0x** |
| sha256sum | single 100MB text | 0.0663s | 0.0644s | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0009s | **1.3x** |
| sha256sum | 100 files | 0.0019s | 0.0015s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0032s | 0.0029s | **1.1x** |
| md5sum | single 10MB text | 0.0212s | 0.0176s | **1.2x** |
| md5sum | single 10MB binary | 0.0221s | 0.0183s | **1.2x** |
| md5sum | single 100MB text | 0.1978s | 0.1621s | **1.2x** |
| md5sum | 10 files | 0.0013s | 0.0010s | **1.3x** |
| md5sum | 100 files | 0.0018s | 0.0015s | **1.2x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0026s | **0.9x** |
| b2sum | single 10MB text | 0.0143s | 0.0150s | **0.9x** |
| b2sum | single 10MB binary | 0.0149s | 0.0157s | **1.0x** |
| b2sum | single 100MB text | 0.1325s | 0.1367s | **1.0x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0151s | **0.9x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0150s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0028s | **0.6x** |
| base64 | encode 10MB text | 0.0101s | 0.0064s | **1.6x** |
| base64 | encode 10MB binary | 0.0106s | 0.0065s | **1.6x** |
| base64 | decode 1MB | 0.0039s | 0.0031s | **1.3x** |
| base64 | decode 10MB | 0.0309s | 0.0194s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0064s | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0079s | 0.0049s | **1.6x** |
| sort | lexicographic 1MB | 0.0080s | 0.0048s | **1.7x** |
| sort | lexicographic 10MB random | 0.0552s | 0.0209s | **2.6x** |
| sort | already sorted 10MB | 0.0251s | 0.0065s | **3.9x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0113s | **2.2x** |
| sort | -n numeric 10MB | 0.0738s | 0.0062s | **12.0x** |
| sort | -r reverse 10MB | 0.0555s | 0.0204s | **2.7x** |
| sort | -u unique 10MB | 0.0578s | 0.0211s | **2.7x** |
| sort | -t, -k2 CSV 10MB | 0.0755s | 0.0566s | **1.3x** |
| sort | repetitive 10MB | 0.0436s | 0.0139s | **3.1x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0197s | **2.8x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0017s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0062s | **1.5x** |
| tr | -d digits 10MB | 0.0111s | 0.0097s | **1.1x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0169s | **1.1x** |
| tr | -s spaces 10MB | 0.0167s | 0.0140s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0092s | 0.0063s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0098s | **1.1x** |
| tr | translate binary 10MB | 0.0095s | 0.0065s | **1.5x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0054s | **1.7x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0068s | **2.4x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0054s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0097s | **3.0x** |
| uniq | -d duplicates only 10MB | 0.0095s | 0.0054s | **1.7x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0055s | **1.7x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0074s | **2.2x** |
| uniq | repetitive 10MB | 0.0467s | 0.0078s | **6.0x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0020s | **0.9x** |
| tac | reverse 10MB text | 0.0091s | 0.0072s | **1.3x** |
| tac | reverse 100MB text | 0.0829s | 0.0394s | **2.1x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0061s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0173s | 0.0092s | **1.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0032s | **1.4x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0059s | 0.0035s | **1.7x** |
| wc | default 10MB text | 0.0548s | 0.0212s | **2.6x** |
| wc | default 100MB text | 0.4849s | 0.1006s | **4.8x** |
| wc | -l 10MB text | 0.0024s | 0.0019s | **1.2x** |
| wc | -w 10MB text | 0.0549s | 0.0206s | **2.7x** |
| wc | -c 10MB text | 0.0009s | 0.0009s | **1.0x** |
| wc | -m 10MB text | 0.0548s | 0.0022s | **24.5x** |
| wc | -L 10MB text | 0.0549s | 0.0235s | **2.3x** |
| wc | default 10MB binary | 0.3184s | 0.0821s | **3.9x** |
| wc | default 10MB repetitive | 0.0736s | 0.0170s | **4.3x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.1x** |
| wc | 100 files | 0.0020s | 0.0019s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0233s | 0.0074s | **3.2x** |
| cut | -c1-100 10MB CSV | 0.0232s | 0.0074s | **3.1x** |
| cut | -d, -f1 10MB CSV | 0.0171s | 0.0065s | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0228s | 0.0105s | **2.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0097s | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0123s | **2.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0034s | **1.0x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0021s | 0.0024s | **0.9x** |
| sha256sum | single 10MB text | 0.0090s | 0.0121s | **0.7x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0125s | **0.7x** |
| sha256sum | single 100MB text | 0.0757s | 0.1049s | **0.7x** |
| sha256sum | 10 files | 0.0015s | 0.0010s | **1.5x** |
| sha256sum | 100 files | 0.0025s | 0.0019s | **1.3x** |
| md5sum | single 100KB text | 0.0015s | 0.0011s | **1.4x** |
| md5sum | single 1MB text | 0.0030s | 0.0036s | **0.8x** |
| md5sum | single 10MB text | 0.0178s | 0.0244s | **0.7x** |
| md5sum | single 10MB binary | 0.0185s | 0.0252s | **0.7x** |
| md5sum | single 100MB text | 0.1616s | 0.2280s | **0.7x** |
| md5sum | 10 files | 0.0014s | 0.0010s | **1.5x** |
| md5sum | 100 files | 0.0025s | 0.0020s | **1.2x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | **1.0x** |
| b2sum | single 1MB text | 0.0024s | 0.0027s | **0.9x** |
| b2sum | single 10MB text | 0.0155s | 0.0160s | **1.0x** |
| b2sum | single 10MB binary | 0.0162s | 0.0165s | **1.0x** |
| b2sum | single 100MB text | 0.1433s | 0.1427s | **1.0x** |
| b2sum | -l 256 10MB | 0.0156s | 0.0161s | **1.0x** |
| b2sum | -l 128 10MB | 0.0155s | 0.0160s | **1.0x** |
| b2sum | 100 files | 0.0023s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0011s | 0.0012s | **0.9x** |
| base64 | encode 1MB text | 0.0023s | 0.0035s | **0.6x** |
| base64 | encode 10MB text | 0.0129s | 0.0060s | **2.1x** |
| base64 | encode 10MB binary | 0.0133s | 0.0061s | **2.2x** |
| base64 | decode 1MB | 0.0041s | 0.0032s | **1.3x** |
| base64 | decode 10MB | 0.0332s | 0.0184s | **1.8x** |
| base64 | encode -w 76 10MB | 0.0128s | 0.0060s | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0092s | 0.0036s | **2.6x** |
| sort | lexicographic 1MB | 0.0090s | 0.0053s | **1.7x** |
| sort | lexicographic 10MB random | 0.0729s | 0.0195s | **3.7x** |
| sort | already sorted 10MB | 0.0367s | 0.0090s | **4.1x** |
| sort | reverse sorted 10MB | 0.0378s | 0.0150s | **2.5x** |
| sort | -n numeric 10MB | 0.1073s | 0.0087s | **12.4x** |
| sort | -r reverse 10MB | 0.0747s | 0.0205s | **3.6x** |
| sort | -u unique 10MB | 0.0776s | 0.0241s | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0933s | 0.0546s | **1.7x** |
| sort | repetitive 10MB | 0.0671s | 0.0189s | **3.6x** |
| sort | --parallel=4 10MB | 0.0732s | 0.0194s | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0032s | 0.0026s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0183s | 0.0124s | **1.5x** |
| tr | -d digits 10MB | 0.0231s | 0.0207s | **1.1x** |
| tr | -d lowercase 10MB | 0.0363s | 0.0318s | **1.1x** |
| tr | -s spaces 10MB | 0.0370s | 0.0204s | **1.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0180s | 0.0124s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0244s | 0.0210s | **1.2x** |
| tr | translate binary 10MB | 0.0154s | 0.0132s | **1.2x** |
| uniq | default 10MB many duplicates | 0.0122s | 0.0056s | **2.2x** |
| uniq | default 10MB sorted (low dup) | 0.0144s | 0.0070s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0126s | 0.0055s | **2.3x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0106s | **2.8x** |
| uniq | -d duplicates only 10MB | 0.0124s | 0.0057s | **2.2x** |
| uniq | -u unique only 10MB | 0.0124s | 0.0056s | **2.2x** |
| uniq | -i case insensitive 10MB | 0.0144s | 0.0076s | **1.9x** |
| uniq | repetitive 10MB | 0.0424s | 0.0069s | **6.1x** |
| tac | reverse 100KB text | 0.0011s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0021s | 0.0028s | **0.7x** |
| tac | reverse 10MB text | 0.0114s | 0.0057s | **2.0x** |
| tac | reverse 100MB text | 0.1040s | 0.0402s | **2.6x** |
| tac | reverse CSV 10MB | 0.0097s | 0.0050s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0100s | **2.4x** |
| tac | custom separator 1MB | 0.0083s | 0.0056s | **1.5x** |
