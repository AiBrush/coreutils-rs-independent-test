# fcoreutils v0.0.31 — Detailed Results

Generated: 2026-02-15 21:12:39 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 396 | 17 | 95.9% |
| Linux_aarch64 | 413 | 402 | 11 | 97.3% |
| Linux_x86_64 | 413 | 402 | 11 | 97.3% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |

**Overall: 1200/1239 (96.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0013s | **0.9x** |
| wc | default 1MB text | 0.0039s | 0.0028s | **1.4x** |
| wc | default 10MB text | 0.0343s | 0.0175s | **2.0x** |
| wc | default 100MB text | 0.2966s | 0.0442s | **6.7x** |
| wc | -l 10MB text | 0.0044s | 0.0025s | **1.7x** |
| wc | -w 10MB text | 0.0343s | 0.0171s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0343s | 0.0023s | **15.1x** |
| wc | -L 10MB text | 0.0342s | 0.0172s | **2.0x** |
| wc | default 10MB binary | 0.2348s | 0.0600s | **3.9x** |
| wc | default 10MB repetitive | 0.0525s | 0.0072s | **7.3x** |
| wc | 10 files | 0.0009s | 0.0012s | **0.7x** |
| wc | 100 files | 0.0014s | 0.0016s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0034s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0036s | **5.2x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0047s | **3.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0047s | **4.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0042s | **5.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0053s | **5.0x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0012s | **1.0x** |
| sha256sum | single 1MB text | 0.0020s | 0.0018s | **1.1x** |
| sha256sum | single 10MB text | 0.0080s | 0.0079s | **1.0x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0081s | **1.0x** |
| sha256sum | single 100MB text | 0.0662s | 0.0642s | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0012s | **1.0x** |
| sha256sum | 100 files | 0.0019s | 0.0016s | **1.2x** |
| md5sum | single 100KB text | 0.0014s | 0.0012s | **1.1x** |
| md5sum | single 1MB text | 0.0032s | 0.0033s | **1.0x** |
| md5sum | single 10MB text | 0.0212s | 0.0175s | **1.2x** |
| md5sum | single 10MB binary | 0.0222s | 0.0182s | **1.2x** |
| md5sum | single 100MB text | 0.1979s | 0.1615s | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0011s | **1.0x** |
| md5sum | 100 files | 0.0018s | 0.0016s | **1.1x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0022s | 0.0026s | **0.8x** |
| b2sum | single 10MB text | 0.0143s | 0.0150s | **1.0x** |
| b2sum | single 10MB binary | 0.0149s | 0.0156s | **1.0x** |
| b2sum | single 100MB text | 0.1328s | 0.1357s | **1.0x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0149s | **1.0x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0149s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0017s | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0018s | **1.0x** |
| base64 | encode 10MB text | 0.0101s | 0.0050s | **2.0x** |
| base64 | encode 10MB binary | 0.0105s | 0.0052s | **2.0x** |
| base64 | decode 1MB | 0.0039s | 0.0027s | **1.4x** |
| base64 | decode 10MB | 0.0311s | 0.0161s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0051s | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0044s | **1.8x** |
| sort | lexicographic 1MB | 0.0077s | 0.0046s | **1.7x** |
| sort | lexicographic 10MB random | 0.0550s | 0.0157s | **3.5x** |
| sort | already sorted 10MB | 0.0252s | 0.0057s | **4.4x** |
| sort | reverse sorted 10MB | 0.0249s | 0.0077s | **3.3x** |
| sort | -n numeric 10MB | 0.0747s | 0.0050s | **15.0x** |
| sort | -r reverse 10MB | 0.0557s | 0.0157s | **3.5x** |
| sort | -u unique 10MB | 0.0578s | 0.0159s | **3.6x** |
| sort | -t, -k2 CSV 10MB | 0.0757s | 0.0500s | **1.5x** |
| sort | repetitive 10MB | 0.0439s | 0.0111s | **4.0x** |
| sort | --parallel=4 10MB | 0.0549s | 0.0160s | **3.4x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0019s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0066s | **1.3x** |
| tr | -d digits 10MB | 0.0112s | 0.0098s | **1.1x** |
| tr | -d lowercase 10MB | 0.0196s | 0.0167s | **1.2x** |
| tr | -s spaces 10MB | 0.0166s | 0.0137s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0064s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0109s | 0.0098s | **1.1x** |
| tr | translate binary 10MB | 0.0093s | 0.0067s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0049s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0053s | **3.1x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0049s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0078s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0051s | **1.9x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0050s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0059s | **2.8x** |
| uniq | repetitive 10MB | 0.0466s | 0.0070s | **6.6x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.7x** |
| tac | reverse 1MB text | 0.0017s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0090s | 0.0047s | **1.9x** |
| tac | reverse 100MB text | 0.0832s | 0.0397s | **2.1x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0042s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0173s | 0.0095s | **1.8x** |
| tac | custom separator 1MB | 0.0045s | 0.0031s | **1.5x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0015s | 0.0013s | **1.2x** |
| wc | default 1MB text | 0.0060s | 0.0033s | **1.8x** |
| wc | default 10MB text | 0.0548s | 0.0216s | **2.5x** |
| wc | default 100MB text | 0.4796s | 0.1014s | **4.7x** |
| wc | -l 10MB text | 0.0024s | 0.0022s | **1.1x** |
| wc | -w 10MB text | 0.0548s | 0.0208s | **2.6x** |
| wc | -c 10MB text | 0.0010s | 0.0011s | **0.9x** |
| wc | -m 10MB text | 0.0549s | 0.0025s | **21.8x** |
| wc | -L 10MB text | 0.0550s | 0.0239s | **2.3x** |
| wc | default 10MB binary | 0.3185s | 0.0823s | **3.9x** |
| wc | default 10MB repetitive | 0.0734s | 0.0177s | **4.2x** |
| wc | 10 files | 0.0010s | 0.0013s | **0.8x** |
| wc | 100 files | 0.0020s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0232s | 0.0050s | **4.6x** |
| cut | -c1-100 10MB CSV | 0.0231s | 0.0049s | **4.7x** |
| cut | -d, -f1 10MB CSV | 0.0172s | 0.0070s | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0228s | 0.0099s | **2.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0248s | 0.0092s | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0112s | **2.8x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0030s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0012s | **1.2x** |
| sha256sum | single 1MB text | 0.0021s | 0.0020s | **1.1x** |
| sha256sum | single 10MB text | 0.0090s | 0.0087s | **1.0x** |
| sha256sum | single 10MB binary | 0.0093s | 0.0090s | **1.0x** |
| sha256sum | single 100MB text | 0.0757s | 0.0737s | **1.0x** |
| sha256sum | 10 files | 0.0015s | 0.0012s | **1.3x** |
| sha256sum | 100 files | 0.0025s | 0.0021s | **1.2x** |
| md5sum | single 100KB text | 0.0015s | 0.0013s | **1.2x** |
| md5sum | single 1MB text | 0.0030s | 0.0032s | **0.9x** |
| md5sum | single 10MB text | 0.0178s | 0.0210s | **0.8x** |
| md5sum | single 10MB binary | 0.0184s | 0.0218s | **0.8x** |
| md5sum | single 100MB text | 0.1619s | 0.1937s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0012s | **1.2x** |
| md5sum | 100 files | 0.0024s | 0.0020s | **1.2x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0024s | 0.0023s | **1.0x** |
| b2sum | single 10MB text | 0.0155s | 0.0127s | **1.2x** |
| b2sum | single 10MB binary | 0.0161s | 0.0130s | **1.2x** |
| b2sum | single 100MB text | 0.1435s | 0.1124s | **1.3x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0127s | **1.2x** |
| b2sum | -l 128 10MB | 0.0155s | 0.0128s | **1.2x** |
| b2sum | 100 files | 0.0023s | 0.0020s | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.9x** |
| base64 | encode 1MB text | 0.0022s | 0.0018s | **1.2x** |
| base64 | encode 10MB text | 0.0130s | 0.0051s | **2.6x** |
| base64 | encode 10MB binary | 0.0132s | 0.0051s | **2.6x** |
| base64 | decode 1MB | 0.0041s | 0.0024s | **1.7x** |
| base64 | decode 10MB | 0.0336s | 0.0125s | **2.7x** |
| base64 | encode -w 76 10MB | 0.0129s | 0.0049s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0091s | 0.0035s | **2.6x** |
| sort | lexicographic 1MB | 0.0089s | 0.0052s | **1.7x** |
| sort | lexicographic 10MB random | 0.0742s | 0.0147s | **5.0x** |
| sort | already sorted 10MB | 0.0369s | 0.0074s | **5.0x** |
| sort | reverse sorted 10MB | 0.0379s | 0.0110s | **3.5x** |
| sort | -n numeric 10MB | 0.1077s | 0.0069s | **15.7x** |
| sort | -r reverse 10MB | 0.0735s | 0.0147s | **5.0x** |
| sort | -u unique 10MB | 0.0761s | 0.0148s | **5.1x** |
| sort | -t, -k2 CSV 10MB | 0.0928s | 0.0496s | **1.9x** |
| sort | repetitive 10MB | 0.0658s | 0.0147s | **4.5x** |
| sort | --parallel=4 10MB | 0.0730s | 0.0151s | **4.8x** |
| tr | a-z to A-Z 1MB | 0.0031s | 0.0023s | **1.4x** |
| tr | a-z to A-Z 10MB | 0.0186s | 0.0068s | **2.7x** |
| tr | -d digits 10MB | 0.0243s | 0.0173s | **1.4x** |
| tr | -d lowercase 10MB | 0.0396s | 0.0263s | **1.5x** |
| tr | -s spaces 10MB | 0.0359s | 0.0143s | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0183s | 0.0065s | **2.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0221s | 0.0168s | **1.3x** |
| tr | translate binary 10MB | 0.0159s | 0.0070s | **2.3x** |
| uniq | default 10MB many duplicates | 0.0123s | 0.0050s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0145s | 0.0069s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0124s | 0.0052s | **2.4x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0104s | **2.8x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0050s | **2.5x** |
| uniq | -u unique only 10MB | 0.0124s | 0.0051s | **2.4x** |
| uniq | -i case insensitive 10MB | 0.0144s | 0.0075s | **1.9x** |
| uniq | repetitive 10MB | 0.0424s | 0.0065s | **6.5x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | **0.8x** |
| tac | reverse 1MB text | 0.0021s | 0.0018s | **1.2x** |
| tac | reverse 10MB text | 0.0112s | 0.0050s | **2.3x** |
| tac | reverse 100MB text | 0.1040s | 0.0403s | **2.6x** |
| tac | reverse CSV 10MB | 0.0098s | 0.0048s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0108s | **2.2x** |
| tac | custom separator 1MB | 0.0086s | 0.0043s | **2.0x** |
