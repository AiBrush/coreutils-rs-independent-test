# fcoreutils v0.8.8 — Detailed Results

Generated: 2026-02-24 05:57:47 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_x86_64 | 436 | 417 | 19 | 95.6% |

**Overall: 417/436 (95.6%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| b2sum | single 100KB text | 0.0011s | 0.0013s | 0.0013s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0024s | 0.0027s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0144s | 0.0146s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0145s | 0.0148s | **1.1x** | **1.0x** |
| b2sum | single 100MB text | 0.1376s | 0.1147s | 0.1311s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0147s | 0.0148s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0147s | 0.0147s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0020s | 0.0020s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0010s | 0.0014s | 0.0012s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0018s | 0.0018s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0109s | 0.0059s | 0.0082s | **1.8x** | **1.4x** |
| base64 | encode 10MB binary | 0.0110s | 0.0059s | 0.0082s | **1.9x** | **1.4x** |
| base64 | decode 1MB | 0.0040s | 0.0023s | 0.0040s | **1.8x** | **1.8x** |
| base64 | decode 10MB | 0.0312s | 0.0048s | 0.0268s | **6.5x** | **5.6x** |
| base64 | encode -w 76 10MB | 0.0107s | 0.0057s | 0.0083s | **1.9x** | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0053s | 0.0083s | **1.7x** | **1.6x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0037s | 0.0069s | **5.1x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0039s | 0.0070s | **4.9x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0098s | 0.0077s | **1.9x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0121s | 0.0169s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0236s | 0.0101s | 0.0132s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0270s | 0.0104s | 0.0169s | **2.6x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0034s | 0.0040s | 0.0031s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0219s | 0.0186s | 0.0184s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0226s | 0.0187s | 0.0189s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2018s | 0.1435s | 0.1672s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0030s | 0.0020s | **0.6x** | **0.7x** |
| sha256sum | single 100KB text | 0.0013s | 0.0025s | 0.0015s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0033s | 0.0040s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0087s | 0.0098s | 0.0282s | **0.9x** | **2.9x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0096s | 0.0290s | **0.9x** | **3.0x** |
| sha256sum | single 100MB text | 0.0692s | 0.0686s | 0.2642s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0012s | 0.0020s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0019s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| sort | lexicographic 1MB | 0.0079s | 0.0037s | 0.0052s | **2.1x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0639s | 0.0130s | 0.0413s | **4.9x** | **3.2x** |
| sort | already sorted 10MB | 0.0260s | 0.0040s | 0.0148s | **6.4x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0258s | 0.0055s | 0.0152s | **4.7x** | **2.8x** |
| sort | -n numeric 10MB | 0.0844s | 0.0048s | 0.0861s | **17.6x** | **18.0x** |
| sort | -r reverse 10MB | 0.0658s | 0.0126s | 0.0395s | **5.2x** | **3.1x** |
| sort | -u unique 10MB | 0.0664s | 0.0149s | 0.0475s | **4.4x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0859s | 0.0204s | 0.0884s | **4.2x** | **4.3x** |
| sort | repetitive 10MB | 0.0495s | 0.0116s | 0.0402s | **4.3x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0611s | 0.0130s | 0.0412s | **4.7x** | **3.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0015s | 0.0013s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0021s | 0.0017s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0095s | 0.0058s | 0.0054s | **1.7x** | **0.9x** |
| tac | reverse 100MB text | 0.0843s | 0.0215s | 0.0442s | **3.9x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0089s | 0.0056s | 0.0048s | **1.6x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0197s | 0.0109s | 0.0096s | **1.8x** | **0.9x** |
| tac | custom separator 1MB | 0.0048s | 0.0045s | 0.0044s | **1.1x** | **1.0x** |
| tr | a-z to A-Z 1MB | 0.0021s | 0.0019s | 0.0022s | **1.1x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0059s | 0.0081s | **1.6x** | **1.4x** |
| tr | -d digits 10MB | 0.0113s | 0.0055s | 0.0107s | **2.0x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0071s | 0.0174s | **2.7x** | **2.5x** |
| tr | -s spaces 10MB | 0.0168s | 0.0059s | 0.0121s | **2.8x** | **2.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0057s | 0.0078s | **1.6x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0056s | 0.0108s | **2.0x** | **1.9x** |
| tr | translate binary 10MB | 0.0094s | 0.0057s | 0.0081s | **1.7x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0099s | 0.0022s | 0.0094s | **4.5x** | **4.3x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0029s | 0.0106s | **5.7x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0098s | 0.0021s | 0.0095s | **4.6x** | **4.5x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0075s | 0.0124s | **3.9x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0098s | 0.0022s | 0.0094s | **4.6x** | **4.4x** |
| uniq | -u unique only 10MB | 0.0097s | 0.0019s | 0.0093s | **5.1x** | **4.9x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0042s | 0.0105s | **4.0x** | **2.5x** |
| uniq | repetitive 10MB | 0.0490s | 0.0036s | 0.0163s | **13.5x** | **4.5x** |
| wc | default 100KB text | 0.0013s | 0.0014s | 0.0016s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0041s | 0.0029s | 0.0037s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0351s | 0.0075s | 0.0261s | **4.7x** | **3.5x** |
| wc | default 100MB text | 0.2989s | 0.0464s | 0.2213s | **6.4x** | **4.8x** |
| wc | -l 10MB text | 0.0052s | 0.0026s | 0.0038s | **2.0x** | **1.4x** |
| wc | -w 10MB text | 0.0349s | 0.0068s | 0.0235s | **5.1x** | **3.4x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0350s | 0.0029s | 0.0039s | **12.1x** | **1.4x** |
| wc | -L 10MB text | 0.0350s | 0.0067s | 0.0186s | **5.2x** | **2.8x** |
| wc | default 10MB binary | 0.2348s | 0.0179s | 0.1140s | **13.1x** | **6.4x** |
| wc | default 10MB repetitive | 0.0536s | 0.0090s | 0.0381s | **6.0x** | **4.2x** |
| wc | 10 files | 0.0009s | 0.0013s | 0.0013s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0015s | 0.0017s | 0.0020s | **0.9x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| arch | - | - | - | - | N/A | N/A |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0021s | 0.0022s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0151s | 0.0129s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0159s | 0.0136s | 0.0132s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1424s | 0.1125s | 0.1135s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0127s | 0.0121s | **1.2x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0125s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0019s | 0.0022s | 0.0021s | **0.9x** | **0.9x** |
| base32 | - | - | - | - | N/A | N/A |
| base64 | encode 100KB text | 0.0009s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0015s | 0.0016s | **1.2x** | **1.0x** |
| base64 | encode 10MB text | 0.0112s | 0.0061s | 0.0070s | **1.8x** | **1.1x** |
| base64 | encode 10MB binary | 0.0116s | 0.0060s | 0.0069s | **1.9x** | **1.1x** |
| base64 | decode 1MB | 0.0037s | 0.0024s | 0.0040s | **1.5x** | **1.7x** |
| base64 | decode 10MB | 0.0306s | 0.0055s | 0.0315s | **5.5x** | **5.7x** |
| base64 | encode -w 76 10MB | 0.0115s | 0.0063s | 0.0071s | **1.8x** | **1.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0050s | 0.0058s | **1.7x** | **1.2x** |
| basename | - | - | - | - | N/A | N/A |
| basenc | - | - | - | - | N/A | N/A |
| cat | - | - | - | - | N/A | N/A |
| chgrp | - | - | - | - | N/A | N/A |
| chmod | - | - | - | - | N/A | N/A |
| chown | - | - | - | - | N/A | N/A |
| cksum | - | - | - | - | N/A | N/A |
| comm | - | - | - | - | N/A | N/A |
| cp | - | - | - | - | N/A | N/A |
| csplit | - | - | - | - | N/A | N/A |
| cut | -b1-100 10MB CSV | 0.0215s | 0.0039s | 0.0064s | **5.5x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0212s | 0.0040s | 0.0065s | **5.4x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0157s | 0.0095s | 0.0081s | **1.7x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0123s | 0.0176s | **1.7x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0238s | 0.0106s | 0.0133s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0297s | 0.0112s | 0.0164s | **2.7x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0032s | 0.0029s | 0.0019s | **1.1x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.9x** |
| dd | - | - | - | - | N/A | N/A |
| dirname | - | - | - | - | N/A | N/A |
| echo | - | - | - | - | N/A | N/A |
| env | - | - | - | - | N/A | N/A |
| expand | - | - | - | - | N/A | N/A |
| expr | - | - | - | - | N/A | N/A |
| factor | - | - | - | - | N/A | N/A |
| false | - | - | - | - | N/A | N/A |
| fold | - | - | - | - | N/A | N/A |
| groups | - | - | - | - | N/A | N/A |
| head | - | - | - | - | N/A | N/A |
| hostid | - | - | - | - | N/A | N/A |
| id | - | - | - | - | N/A | N/A |
| install | - | - | - | - | N/A | N/A |
| join | - | - | - | - | N/A | N/A |
| link | - | - | - | - | N/A | N/A |
| ln | - | - | - | - | N/A | N/A |
| logname | - | - | - | - | N/A | N/A |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0035s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0183s | 0.0213s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0180s | 0.0194s | 0.0226s | **0.9x** | **1.2x** |
| md5sum | single 100MB text | 0.1605s | 0.1535s | 0.2026s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0025s | 0.0012s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0020s | 0.0032s | 0.0021s | **0.6x** | **0.7x** |
| mkdir | - | - | - | - | N/A | N/A |
| mkfifo | - | - | - | - | N/A | N/A |
| mknod | - | - | - | - | N/A | N/A |
| mktemp | - | - | - | - | N/A | N/A |
| mv | - | - | - | - | N/A | N/A |
| nice | - | - | - | - | N/A | N/A |
| nl | - | - | - | - | N/A | N/A |
| nohup | - | - | - | - | N/A | N/A |
| nproc | - | - | - | - | N/A | N/A |
| paste | - | - | - | - | N/A | N/A |
| pathchk | - | - | - | - | N/A | N/A |
| pwd | - | - | - | - | N/A | N/A |
| readlink | - | - | - | - | N/A | N/A |
| realpath | - | - | - | - | N/A | N/A |
| rev | - | - | - | - | N/A | N/A |
| rm | - | - | - | - | N/A | N/A |
| rmdir | - | - | - | - | N/A | N/A |
| seq | - | - | - | - | N/A | N/A |
| sha1sum | - | - | - | - | N/A | N/A |
| sha224sum | - | - | - | - | N/A | N/A |
| sha256sum | single 100KB text | 0.0012s | 0.0028s | 0.0012s | **0.4x** | **0.4x** |
| sha256sum | single 1MB text | 0.0019s | 0.0037s | 0.0019s | **0.5x** | **0.5x** |
| sha256sum | single 10MB text | 0.0086s | 0.0107s | 0.0085s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0107s | 0.0089s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0747s | 0.0751s | 0.0748s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0023s | 0.0012s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0021s | 0.0027s | 0.0020s | **0.8x** | **0.7x** |
| sha384sum | - | - | - | - | N/A | N/A |
| sha512sum | - | - | - | - | N/A | N/A |
| shred | - | - | - | - | N/A | N/A |
| sleep | - | - | - | - | N/A | N/A |
| sort | lexicographic 1MB | 0.0087s | 0.0039s | 0.0052s | **2.3x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0563s | 0.0099s | 0.0335s | **5.7x** | **3.4x** |
| sort | already sorted 10MB | 0.0267s | 0.0053s | 0.0156s | **5.0x** | **2.9x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0069s | 0.0155s | **4.0x** | **2.2x** |
| sort | -n numeric 10MB | 0.0764s | 0.0064s | 0.0759s | **11.9x** | **11.8x** |
| sort | -r reverse 10MB | 0.0564s | 0.0107s | 0.0350s | **5.3x** | **3.3x** |
| sort | -u unique 10MB | 0.0596s | 0.0102s | 0.0376s | **5.8x** | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0687s | 0.0220s | 0.0818s | **3.1x** | **3.7x** |
| sort | repetitive 10MB | 0.0560s | 0.0139s | 0.0349s | **4.0x** | **2.5x** |
| sort | --parallel=4 10MB | 0.0553s | 0.0098s | 0.0343s | **5.6x** | **3.5x** |
| split | - | - | - | - | N/A | N/A |
| sum | - | - | - | - | N/A | N/A |
| sync | - | - | - | - | N/A | N/A |
| tac | reverse 100KB text | 0.0009s | 0.0014s | 0.0012s | **0.6x** | **0.9x** |
| tac | reverse 1MB text | 0.0017s | 0.0020s | 0.0016s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0091s | 0.0064s | 0.0054s | **1.4x** | **0.8x** |
| tac | reverse 100MB text | 0.0912s | 0.0285s | 0.0489s | **3.2x** | **1.7x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0061s | 0.0053s | **1.4x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0200s | 0.0117s | 0.0104s | **1.7x** | **0.9x** |
| tac | custom separator 1MB | 0.0056s | 0.0051s | 0.0049s | **1.1x** | **1.0x** |
| tail | - | - | - | - | N/A | N/A |
| tee | - | - | - | - | N/A | N/A |
| test | - | - | - | - | N/A | N/A |
| touch | - | - | - | - | N/A | N/A |
| tr | a-z to A-Z 1MB | 0.0022s | 0.0015s | 0.0019s | **1.4x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0111s | 0.0039s | 0.0072s | **2.8x** | **1.8x** |
| tr | -d digits 10MB | 0.0170s | 0.0044s | 0.0131s | **3.9x** | **3.0x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0052s | 0.0214s | **5.7x** | **4.1x** |
| tr | -s spaces 10MB | 0.0252s | 0.0039s | 0.0269s | **6.5x** | **6.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0111s | 0.0038s | 0.0071s | **2.9x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0045s | 0.0135s | **3.6x** | **3.0x** |
| tr | translate binary 10MB | 0.0102s | 0.0040s | 0.0079s | **2.6x** | **2.0x** |
| true | - | - | - | - | N/A | N/A |
| truncate | - | - | - | - | N/A | N/A |
| tsort | - | - | - | - | N/A | N/A |
| tty | - | - | - | - | N/A | N/A |
| uname | - | - | - | - | N/A | N/A |
| unexpand | - | - | - | - | N/A | N/A |
| uniq | default 10MB many duplicates | 0.0115s | 0.0019s | 0.0119s | **6.1x** | **6.3x** |
| uniq | default 10MB sorted (low dup) | 0.0132s | 0.0032s | 0.0132s | **4.2x** | **4.1x** |
| uniq | -c count 10MB many dups | 0.0117s | 0.0019s | 0.0119s | **6.3x** | **6.4x** |
| uniq | -c count 10MB sorted | 0.0281s | 0.0071s | 0.0172s | **4.0x** | **2.4x** |
| uniq | -d duplicates only 10MB | 0.0116s | 0.0018s | 0.0119s | **6.3x** | **6.5x** |
| uniq | -u unique only 10MB | 0.0116s | 0.0019s | 0.0119s | **6.2x** | **6.3x** |
| uniq | -i case insensitive 10MB | 0.0130s | 0.0045s | 0.0128s | **2.9x** | **2.9x** |
| uniq | repetitive 10MB | 0.0404s | 0.0038s | 0.0168s | **10.6x** | **4.4x** |
| unlink | - | - | - | - | N/A | N/A |
| wc | default 100KB text | 0.0013s | 0.0012s | 0.0014s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0056s | 0.0029s | 0.0038s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0544s | 0.0034s | 0.0309s | **16.1x** | **9.1x** |
| wc | default 100MB text | 0.4809s | 0.0155s | 0.2659s | **31.0x** | **17.2x** |
| wc | -l 10MB text | 0.0017s | 0.0025s | 0.0018s | **0.7x** | **0.7x** |
| wc | -w 10MB text | 0.0543s | 0.0089s | 0.0250s | **6.1x** | **2.8x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0538s | 0.0031s | 0.0018s | **17.5x** | **0.6x** |
| wc | -L 10MB text | 0.0541s | 0.0101s | 0.0161s | **5.4x** | **1.6x** |
| wc | default 10MB binary | 0.3181s | 0.0275s | 0.1584s | **11.6x** | **5.8x** |
| wc | default 10MB repetitive | 0.0728s | 0.0047s | 0.0414s | **15.5x** | **8.8x** |
| wc | 10 files | 0.0009s | 0.0012s | 0.0013s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0016s | 0.0018s | 0.0021s | **0.9x** | **1.2x** |
| whoami | - | - | - | - | N/A | N/A |
| yes | startup --help | 0.0008s | 0.0002s | N/A | **4.1x** | N/A |
| yes | startup --version | 0.0008s | 0.0002s | N/A | **4.2x** | N/A |
| yes | throughput 1M lines | 0.0030s | 0.0041s | N/A | **0.7x** | N/A |
| yes | throughput 10M lines | 0.0232s | 0.0214s | N/A | **1.1x** | N/A |
| yes | throughput hello 1M lines | 0.0057s | 0.0062s | N/A | **0.9x** | N/A |
| yes | throughput hello 10M lines | 0.0473s | 0.0574s | N/A | **0.8x** | N/A |
| yes | throughput 100MB | 0.0272s | 0.0338s | N/A | **0.8x** | N/A |
