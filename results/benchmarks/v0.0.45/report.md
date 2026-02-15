# fcoreutils v0.0.45 — Detailed Results

Generated: 2026-02-15 07:53:12 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 411 | 2 | 99.5% |

**Overall: 823/826 (99.6%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0012s | **0.9x** |
| wc | default 1MB text | 0.0039s | 0.0027s | **1.5x** |
| wc | default 10MB text | 0.0334s | 0.0060s | **5.6x** |
| wc | default 100MB text | 0.2910s | 0.0394s | **7.4x** |
| wc | -l 10MB text | 0.0042s | 0.0024s | **1.7x** |
| wc | -w 10MB text | 0.0336s | 0.0065s | **5.1x** |
| wc | -c 10MB text | 0.0009s | 0.0013s | **0.7x** |
| wc | -m 10MB text | 0.0335s | 0.0024s | **14.0x** |
| wc | -L 10MB text | 0.0337s | 0.0063s | **5.4x** |
| wc | default 10MB binary | 0.2362s | 0.0179s | **13.2x** |
| wc | default 10MB repetitive | 0.0513s | 0.0070s | **7.3x** |
| wc | 10 files | 0.0009s | 0.0011s | **0.8x** |
| wc | 100 files | 0.0018s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0031s | **5.9x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0029s | **6.4x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0047s | **4.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0050s | **4.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0047s | **5.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0048s | **5.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0028s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0021s | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0029s | **0.6x** |
| sha256sum | single 10MB text | 0.0072s | 0.0074s | **1.0x** |
| sha256sum | single 10MB binary | 0.0084s | 0.0078s | **1.1x** |
| sha256sum | single 100MB text | 0.0605s | 0.0537s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0022s | **0.5x** |
| sha256sum | 100 files | 0.0018s | 0.0027s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0023s | **0.6x** |
| md5sum | single 1MB text | 0.0033s | 0.0038s | **0.9x** |
| md5sum | single 10MB text | 0.0202s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0225s | 0.0175s | **1.3x** |
| md5sum | single 100MB text | 0.1912s | 0.1406s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0021s | **0.5x** |
| md5sum | 100 files | 0.0020s | 0.0033s | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0021s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0136s | 0.0130s | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0138s | **1.1x** |
| b2sum | single 100MB text | 0.1271s | 0.1180s | **1.1x** |
| b2sum | -l 256 10MB | 0.0134s | 0.0129s | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0129s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0017s | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0018s | **1.0x** |
| base64 | encode 10MB text | 0.0094s | 0.0033s | **2.8x** |
| base64 | encode 10MB binary | 0.0109s | 0.0040s | **2.7x** |
| base64 | decode 1MB | 0.0039s | 0.0026s | **1.5x** |
| base64 | decode 10MB | 0.0308s | 0.0156s | **2.0x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0034s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0031s | **2.3x** |
| sort | lexicographic 1MB | 0.0081s | 0.0034s | **2.4x** |
| sort | lexicographic 10MB random | 0.0525s | 0.0059s | **8.9x** |
| sort | already sorted 10MB | 0.0252s | 0.0051s | **4.9x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0050s | **4.9x** |
| sort | -n numeric 10MB | 0.0687s | 0.0208s | **3.3x** |
| sort | -r reverse 10MB | 0.0511s | 0.0062s | **8.3x** |
| sort | -u unique 10MB | 0.0547s | 0.0156s | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0716s | 0.0215s | **3.3x** |
| sort | repetitive 10MB | 0.0419s | 0.0125s | **3.4x** |
| sort | --parallel=4 10MB | 0.0516s | 0.0060s | **8.6x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0019s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0095s | 0.0060s | **1.6x** |
| tr | -d digits 10MB | 0.0111s | 0.0124s | **0.9x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0185s | **1.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0134s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0094s | 0.0056s | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0124s | **0.9x** |
| tr | translate binary 10MB | 0.0093s | 0.0104s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0095s | 0.0048s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0029s | **5.8x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0047s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0067s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0047s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0170s | 0.0046s | **3.7x** |
| uniq | repetitive 10MB | 0.0468s | 0.0043s | **10.8x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0081s | 0.0045s | **1.8x** |
| tac | reverse 100MB text | 0.0773s | 0.0381s | **2.0x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0047s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0174s | 0.0096s | **1.8x** |
| tac | custom separator 1MB | 0.0044s | 0.0042s | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0010s | **1.0x** |
| wc | default 1MB text | 0.0045s | 0.0031s | **1.4x** |
| wc | default 10MB text | 0.0419s | 0.0021s | **20.3x** |
| wc | default 100MB text | 0.3781s | 0.0092s | **41.1x** |
| wc | -l 10MB text | 0.0014s | 0.0019s | **0.7x** |
| wc | -w 10MB text | 0.0422s | 0.0096s | **4.4x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0419s | 0.0022s | **19.2x** |
| wc | -L 10MB text | 0.0419s | 0.0101s | **4.1x** |
| wc | default 10MB binary | 0.3214s | 0.0308s | **10.4x** |
| wc | default 10MB repetitive | 0.0539s | 0.0028s | **19.0x** |
| wc | 10 files | 0.0007s | 0.0010s | **0.7x** |
| wc | 100 files | 0.0011s | 0.0013s | **0.8x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0028s | **6.8x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0029s | **6.6x** |
| cut | -d, -f1 10MB CSV | 0.0204s | 0.0049s | **4.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0234s | 0.0062s | **3.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0260s | 0.0063s | **4.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0295s | 0.0066s | **4.4x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0008s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0039s | 0.0027s | **1.4x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0009s | **0.6x** |
| sha256sum | single 100KB text | 0.0010s | 0.0020s | **0.5x** |
| sha256sum | single 1MB text | 0.0018s | 0.0030s | **0.6x** |
| sha256sum | single 10MB text | 0.0092s | 0.0099s | **0.9x** |
| sha256sum | single 10MB binary | 0.0097s | 0.0103s | **0.9x** |
| sha256sum | single 100MB text | 0.0872s | 0.0826s | **1.1x** |
| sha256sum | 10 files | 0.0010s | 0.0019s | **0.5x** |
| sha256sum | 100 files | 0.0015s | 0.0024s | **0.6x** |
| md5sum | single 100KB text | 0.0011s | 0.0021s | **0.5x** |
| md5sum | single 1MB text | 0.0024s | 0.0035s | **0.7x** |
| md5sum | single 10MB text | 0.0154s | 0.0155s | **1.0x** |
| md5sum | single 10MB binary | 0.0162s | 0.0161s | **1.0x** |
| md5sum | single 100MB text | 0.1497s | 0.1371s | **1.1x** |
| md5sum | 10 files | 0.0010s | 0.0020s | **0.5x** |
| md5sum | 100 files | 0.0014s | 0.0025s | **0.6x** |
| b2sum | single 100KB text | 0.0008s | 0.0011s | **0.7x** |
| b2sum | single 1MB text | 0.0020s | 0.0023s | **0.8x** |
| b2sum | single 10MB text | 0.0137s | 0.0106s | **1.3x** |
| b2sum | single 10MB binary | 0.0144s | 0.0110s | **1.3x** |
| b2sum | single 100MB text | 0.1342s | 0.0973s | **1.4x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0106s | **1.3x** |
| b2sum | -l 128 10MB | 0.0137s | 0.0106s | **1.3x** |
| b2sum | 100 files | 0.0014s | 0.0014s | **1.0x** |
| base64 | encode 100KB text | 0.0007s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | **1.0x** |
| base64 | encode 10MB text | 0.0100s | 0.0044s | **2.3x** |
| base64 | encode 10MB binary | 0.0105s | 0.0046s | **2.3x** |
| base64 | decode 1MB | 0.0036s | 0.0021s | **1.7x** |
| base64 | decode 10MB | 0.0293s | 0.0102s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0048s | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0032s | **2.4x** |
| sort | lexicographic 1MB | 0.0073s | 0.0035s | **2.1x** |
| sort | lexicographic 10MB random | 0.0488s | 0.0087s | **5.6x** |
| sort | already sorted 10MB | 0.0211s | 0.0059s | **3.5x** |
| sort | reverse sorted 10MB | 0.0219s | 0.0073s | **3.0x** |
| sort | -n numeric 10MB | 0.0685s | 0.0259s | **2.6x** |
| sort | -r reverse 10MB | 0.0495s | 0.0096s | **5.1x** |
| sort | -u unique 10MB | 0.0530s | 0.0129s | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0640s | 0.0253s | **2.5x** |
| sort | repetitive 10MB | 0.0485s | 0.0147s | **3.3x** |
| sort | --parallel=4 10MB | 0.0491s | 0.0092s | **5.4x** |
| tr | a-z to A-Z 1MB | 0.0016s | 0.0016s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0076s | 0.0053s | **1.4x** |
| tr | -d digits 10MB | 0.0155s | 0.0086s | **1.8x** |
| tr | -d lowercase 10MB | 0.0275s | 0.0082s | **3.4x** |
| tr | -s spaces 10MB | 0.0244s | 0.0133s | **1.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0075s | 0.0053s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0157s | 0.0083s | **1.9x** |
| tr | translate binary 10MB | 0.0078s | 0.0091s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0088s | 0.0050s | **1.8x** |
| uniq | default 10MB sorted (low dup) | 0.0182s | 0.0037s | **4.9x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0048s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0074s | **4.0x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0047s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0181s | 0.0048s | **3.8x** |
| uniq | repetitive 10MB | 0.0474s | 0.0053s | **9.0x** |
| tac | reverse 100KB text | 0.0007s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0014s | 0.0014s | **1.0x** |
| tac | reverse 10MB text | 0.0076s | 0.0040s | **1.9x** |
| tac | reverse 100MB text | 0.0791s | 0.0350s | **2.3x** |
| tac | reverse CSV 10MB | 0.0074s | 0.0042s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0137s | 0.0083s | **1.6x** |
| tac | custom separator 1MB | 0.0048s | 0.0038s | **1.3x** |
