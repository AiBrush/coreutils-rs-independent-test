# fcoreutils v0.0.10 — Detailed Results

Generated: 2026-02-13 08:51:35 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 400 | 13 | 96.9% |
| Linux_aarch64 | 413 | 400 | 13 | 96.9% |
| Linux_x86_64 | 413 | 400 | 13 | 96.9% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |

**Overall: 1200/1239 (96.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0008s | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0012s | **3.0x** |
| wc | default 10MB text | 0.0343s | 0.0026s | **13.3x** |
| wc | default 100MB text | 0.2914s | 0.0137s | **21.2x** |
| wc | -l 10MB text | 0.0040s | 0.0019s | **2.1x** |
| wc | -w 10MB text | 0.0343s | 0.0025s | **13.5x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0345s | 0.0032s | **10.9x** |
| wc | -L 10MB text | 0.0342s | 0.0154s | **2.2x** |
| wc | default 10MB binary | 0.2338s | 0.0026s | **88.9x** |
| wc | default 10MB repetitive | 0.0521s | 0.0043s | **12.3x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0012s | 0.0013s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0038s | **4.9x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0035s | **5.3x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0028s | **6.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0210s | 0.0043s | **4.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0045s | **5.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0055s | **4.8x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0012s | **2.8x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0008s | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0008s | **1.3x** |
| sha256sum | single 1MB text | 0.0017s | 0.0014s | **1.2x** |
| sha256sum | single 10MB text | 0.0074s | 0.0071s | **1.0x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0071s | **1.0x** |
| sha256sum | single 100MB text | 0.0606s | 0.0604s | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0012s | **1.0x** |
| sha256sum | 100 files | 0.0017s | 0.0018s | **1.0x** |
| md5sum | single 100KB text | 0.0012s | 0.0010s | **1.3x** |
| md5sum | single 1MB text | 0.0030s | 0.0023s | **1.3x** |
| md5sum | single 10MB text | 0.0208s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0214s | 0.0164s | **1.3x** |
| md5sum | single 100MB text | 0.1927s | 0.1498s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0012s | **0.9x** |
| md5sum | 100 files | 0.0016s | 0.0017s | **1.0x** |
| b2sum | single 100KB text | 0.0008s | 0.0009s | **0.9x** |
| b2sum | single 1MB text | 0.0020s | 0.0020s | **1.0x** |
| b2sum | single 10MB text | 0.0138s | 0.0128s | **1.1x** |
| b2sum | single 10MB binary | 0.0142s | 0.0131s | **1.1x** |
| b2sum | single 100MB text | 0.1276s | 0.1185s | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0128s | **1.1x** |
| b2sum | -l 128 10MB | 0.0137s | 0.0128s | **1.1x** |
| b2sum | 100 files | 0.0015s | 0.0017s | **0.9x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0018s | **0.9x** |
| base64 | encode 10MB text | 0.0094s | 0.0074s | **1.3x** |
| base64 | encode 10MB binary | 0.0095s | 0.0075s | **1.3x** |
| base64 | decode 1MB | 0.0036s | 0.0025s | **1.5x** |
| base64 | decode 10MB | 0.0301s | 0.0178s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0094s | 0.0074s | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0054s | **1.4x** |
| sort | lexicographic 1MB | 0.0073s | 0.0040s | **1.8x** |
| sort | lexicographic 10MB random | 0.0503s | 0.0175s | **2.9x** |
| sort | already sorted 10MB | 0.0239s | 0.0083s | **2.9x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0082s | **2.9x** |
| sort | -n numeric 10MB | 0.0683s | 0.0321s | **2.1x** |
| sort | -r reverse 10MB | 0.0514s | 0.0182s | **2.8x** |
| sort | -u unique 10MB | 0.0533s | 0.0193s | **2.8x** |
| sort | -t, -k2 CSV 10MB | 0.0703s | 0.0319s | **2.2x** |
| sort | repetitive 10MB | 0.0426s | 0.0208s | **2.0x** |
| sort | --parallel=4 10MB | 0.0499s | 0.0179s | **2.8x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0025s | **0.7x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0114s | **0.8x** |
| tr | -d digits 10MB | 0.0111s | 0.0150s | **0.7x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0227s | **0.8x** |
| tr | -s spaces 10MB | 0.0167s | 0.0268s | **0.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0115s | **0.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0149s | **0.7x** |
| tr | translate binary 10MB | 0.0090s | 0.0123s | **0.7x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0159s | 0.0041s | **3.9x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0289s | 0.0053s | **5.5x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0045s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0159s | 0.0045s | **3.5x** |
| uniq | repetitive 10MB | 0.0457s | 0.0069s | **6.7x** |
| tac | reverse 100KB text | 0.0008s | 0.0009s | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0083s | 0.0050s | **1.7x** |
| tac | reverse 100MB text | 0.0792s | 0.0425s | **1.9x** |
| tac | reverse CSV 10MB | 0.0077s | 0.0047s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0163s | 0.0092s | **1.8x** |
| tac | custom separator 1MB | 0.0042s | 0.0038s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0009s | **1.6x** |
| wc | default 1MB text | 0.0059s | 0.0010s | **5.8x** |
| wc | default 10MB text | 0.0551s | 0.0026s | **21.3x** |
| wc | default 100MB text | 0.5916s | 0.0121s | **49.1x** |
| wc | -l 10MB text | 0.0022s | 0.0022s | **1.0x** |
| wc | -w 10MB text | 0.0554s | 0.0022s | **24.7x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0545s | 0.0038s | **14.3x** |
| wc | -L 10MB text | 0.0551s | 0.0154s | **3.6x** |
| wc | default 10MB binary | 0.3171s | 0.0024s | **131.1x** |
| wc | default 10MB repetitive | 0.0731s | 0.0039s | **18.6x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0020s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0231s | 0.0060s | **3.9x** |
| cut | -c1-100 10MB CSV | 0.0230s | 0.0060s | **3.8x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0044s | **3.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0092s | **2.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0244s | 0.0087s | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0132s | **2.3x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0014s | **2.5x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0008s | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0022s | 0.0016s | **1.4x** |
| sha256sum | single 10MB text | 0.0088s | 0.0080s | **1.1x** |
| sha256sum | single 10MB binary | 0.0091s | 0.0083s | **1.1x** |
| sha256sum | single 100MB text | 0.0749s | 0.0720s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0015s | **1.0x** |
| sha256sum | 100 files | 0.0025s | 0.0025s | **1.0x** |
| md5sum | single 100KB text | 0.0015s | 0.0011s | **1.4x** |
| md5sum | single 1MB text | 0.0029s | 0.0028s | **1.0x** |
| md5sum | single 10MB text | 0.0178s | 0.0202s | **0.9x** |
| md5sum | single 10MB binary | 0.0185s | 0.0213s | **0.9x** |
| md5sum | single 100MB text | 0.1609s | 0.1918s | **0.8x** |
| md5sum | 10 files | 0.0015s | 0.0015s | **1.0x** |
| md5sum | 100 files | 0.0025s | 0.0026s | **1.0x** |
| b2sum | single 100KB text | 0.0011s | 0.0010s | **1.1x** |
| b2sum | single 1MB text | 0.0024s | 0.0020s | **1.2x** |
| b2sum | single 10MB text | 0.0155s | 0.0120s | **1.3x** |
| b2sum | single 10MB binary | 0.0162s | 0.0126s | **1.3x** |
| b2sum | single 100MB text | 0.1425s | 0.1110s | **1.3x** |
| b2sum | -l 256 10MB | 0.0154s | 0.0123s | **1.3x** |
| b2sum | -l 128 10MB | 0.0156s | 0.0120s | **1.3x** |
| b2sum | 100 files | 0.0024s | 0.0026s | **0.9x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0022s | 0.0023s | **0.9x** |
| base64 | encode 10MB text | 0.0127s | 0.0056s | **2.3x** |
| base64 | encode 10MB binary | 0.0133s | 0.0057s | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0033s | **1.2x** |
| base64 | decode 10MB | 0.0333s | 0.0214s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0127s | 0.0055s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0090s | 0.0036s | **2.5x** |
| sort | lexicographic 1MB | 0.0087s | 0.0046s | **1.9x** |
| sort | lexicographic 10MB random | 0.0726s | 0.0195s | **3.7x** |
| sort | already sorted 10MB | 0.0358s | 0.0107s | **3.4x** |
| sort | reverse sorted 10MB | 0.0374s | 0.0109s | **3.4x** |
| sort | -n numeric 10MB | 0.1074s | 0.0459s | **2.3x** |
| sort | -r reverse 10MB | 0.0725s | 0.0238s | **3.0x** |
| sort | -u unique 10MB | 0.0765s | 0.0208s | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0909s | 0.0389s | **2.3x** |
| sort | repetitive 10MB | 0.0657s | 0.0195s | **3.4x** |
| sort | --parallel=4 10MB | 0.0732s | 0.0248s | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0033s | 0.0034s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0182s | 0.0213s | **0.9x** |
| tr | -d digits 10MB | 0.0242s | 0.0237s | **1.0x** |
| tr | -d lowercase 10MB | 0.0369s | 0.0392s | **0.9x** |
| tr | -s spaces 10MB | 0.0349s | 0.0449s | **0.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0182s | 0.0203s | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0243s | 0.0228s | **1.1x** |
| tr | translate binary 10MB | 0.0158s | 0.0210s | **0.8x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0046s | **2.6x** |
| uniq | default 10MB sorted (low dup) | 0.0143s | 0.0054s | **2.7x** |
| uniq | -c count 10MB many dups | 0.0124s | 0.0047s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0073s | **4.0x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0047s | **2.6x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0058s | **2.4x** |
| uniq | repetitive 10MB | 0.0424s | 0.0068s | **6.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0021s | **1.0x** |
| tac | reverse 10MB text | 0.0113s | 0.0059s | **1.9x** |
| tac | reverse 100MB text | 0.1037s | 0.0451s | **2.3x** |
| tac | reverse CSV 10MB | 0.0095s | 0.0056s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0237s | 0.0108s | **2.2x** |
| tac | custom separator 1MB | 0.0082s | 0.0070s | **1.2x** |
