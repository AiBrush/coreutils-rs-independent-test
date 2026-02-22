# fcoreutils v0.9.0 — Detailed Results

Generated: 2026-02-22 17:19:07 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 325 | 220 | 105 | 67.7% |
| Linux_aarch64 | 436 | 417 | 19 | 95.6% |
| Linux_x86_64 | 436 | 417 | 19 | 95.6% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

**Overall: 1054/1197 (88.1%)**

## Performance

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0013s | 0.0012s | 0.0014s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0060s | 0.0031s | 0.0038s | **1.9x** | **1.2x** |
| wc | default 10MB text | 0.0545s | 0.0036s | 0.0310s | **15.2x** | **8.6x** |
| wc | default 100MB text | 0.4805s | 0.0154s | 0.2605s | **31.2x** | **16.9x** |
| wc | -l 10MB text | 0.0018s | 0.0029s | 0.0021s | **0.6x** | **0.7x** |
| wc | -w 10MB text | 0.0545s | 0.0097s | 0.0256s | **5.6x** | **2.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0546s | 0.0032s | 0.0020s | **17.2x** | **0.6x** |
| wc | -L 10MB text | 0.0544s | 0.0100s | 0.0164s | **5.5x** | **1.6x** |
| wc | default 10MB binary | 0.3170s | 0.0273s | 0.1571s | **11.6x** | **5.7x** |
| wc | default 10MB repetitive | 0.0732s | 0.0048s | 0.0425s | **15.4x** | **8.9x** |
| wc | 10 files | 0.0009s | 0.0012s | 0.0013s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0016s | 0.0017s | 0.0021s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0216s | 0.0040s | 0.0067s | **5.3x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0214s | 0.0040s | 0.0065s | **5.4x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0158s | 0.0095s | 0.0081s | **1.7x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0209s | 0.0118s | 0.0172s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0104s | 0.0130s | **2.2x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0296s | 0.0112s | 0.0162s | **2.7x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0032s | 0.0029s | 0.0019s | **1.1x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0029s | 0.0013s | **0.4x** | **0.4x** |
| sha256sum | single 1MB text | 0.0018s | 0.0035s | 0.0019s | **0.5x** | **0.5x** |
| sha256sum | single 10MB text | 0.0085s | 0.0104s | 0.0083s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0106s | 0.0090s | **0.8x** | **0.9x** |
| sha256sum | single 100MB text | 0.0744s | 0.0747s | 0.0743s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0024s | 0.0013s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0021s | 0.0027s | 0.0021s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0027s | 0.0035s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0174s | 0.0184s | 0.0215s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0182s | 0.0191s | 0.0224s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1600s | 0.1536s | 0.2021s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0024s | 0.0013s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0020s | 0.0031s | 0.0021s | **0.6x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0024s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0151s | 0.0129s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0137s | 0.0131s | **1.1x** | **1.0x** |
| b2sum | single 100MB text | 0.1418s | 0.1124s | 0.1131s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0133s | 0.0123s | **1.1x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0131s | 0.0122s | **1.2x** | **0.9x** |
| b2sum | 100 files | 0.0019s | 0.0022s | 0.0021s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0019s | 0.0015s | 0.0016s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0112s | 0.0060s | 0.0069s | **1.9x** | **1.1x** |
| base64 | encode 10MB binary | 0.0118s | 0.0061s | 0.0070s | **1.9x** | **1.1x** |
| base64 | decode 1MB | 0.0037s | 0.0023s | 0.0040s | **1.6x** | **1.7x** |
| base64 | decode 10MB | 0.0323s | 0.0056s | 0.0314s | **5.7x** | **5.6x** |
| base64 | encode -w 76 10MB | 0.0114s | 0.0060s | 0.0069s | **1.9x** | **1.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0084s | 0.0049s | 0.0059s | **1.7x** | **1.2x** |
| sort | lexicographic 1MB | 0.0088s | 0.0037s | 0.0052s | **2.3x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0546s | 0.0101s | 0.0337s | **5.4x** | **3.3x** |
| sort | already sorted 10MB | 0.0265s | 0.0054s | 0.0159s | **5.0x** | **3.0x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0067s | 0.0160s | **4.1x** | **2.4x** |
| sort | -n numeric 10MB | 0.0737s | 0.0059s | 0.0732s | **12.6x** | **12.5x** |
| sort | -r reverse 10MB | 0.0546s | 0.0097s | 0.0336s | **5.6x** | **3.5x** |
| sort | -u unique 10MB | 0.0581s | 0.0108s | 0.0372s | **5.4x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0673s | 0.0216s | 0.0826s | **3.1x** | **3.8x** |
| sort | repetitive 10MB | 0.0555s | 0.0134s | 0.0351s | **4.1x** | **2.6x** |
| sort | --parallel=4 10MB | 0.0547s | 0.0108s | 0.0341s | **5.1x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0021s | 0.0015s | 0.0018s | **1.4x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0111s | 0.0040s | 0.0071s | **2.7x** | **1.8x** |
| tr | -d digits 10MB | 0.0155s | 0.0043s | 0.0137s | **3.6x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0312s | 0.0050s | 0.0207s | **6.3x** | **4.2x** |
| tr | -s spaces 10MB | 0.0262s | 0.0040s | 0.0265s | **6.5x** | **6.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0109s | 0.0040s | 0.0071s | **2.7x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0043s | 0.0133s | **3.9x** | **3.1x** |
| tr | translate binary 10MB | 0.0095s | 0.0041s | 0.0083s | **2.3x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0115s | 0.0019s | 0.0120s | **6.2x** | **6.4x** |
| uniq | default 10MB sorted (low dup) | 0.0131s | 0.0033s | 0.0132s | **4.0x** | **4.0x** |
| uniq | -c count 10MB many dups | 0.0117s | 0.0018s | 0.0119s | **6.4x** | **6.6x** |
| uniq | -c count 10MB sorted | 0.0278s | 0.0070s | 0.0159s | **3.9x** | **2.3x** |
| uniq | -d duplicates only 10MB | 0.0117s | 0.0019s | 0.0119s | **6.3x** | **6.4x** |
| uniq | -u unique only 10MB | 0.0116s | 0.0018s | 0.0119s | **6.4x** | **6.6x** |
| uniq | -i case insensitive 10MB | 0.0131s | 0.0047s | 0.0131s | **2.8x** | **2.8x** |
| uniq | repetitive 10MB | 0.0407s | 0.0039s | 0.0171s | **10.4x** | **4.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0014s | 0.0011s | **0.7x** | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0020s | 0.0016s | **0.8x** | **0.8x** |
| tac | reverse 10MB text | 0.0093s | 0.0065s | 0.0054s | **1.4x** | **0.8x** |
| tac | reverse 100MB text | 0.0905s | 0.0285s | 0.0486s | **3.2x** | **1.7x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0062s | 0.0053s | **1.3x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0203s | 0.0117s | 0.0102s | **1.7x** | **0.9x** |
| tac | custom separator 1MB | 0.0055s | 0.0053s | 0.0050s | **1.1x** | **0.9x** |
| head | - | - | - | - | N/A | N/A |
| tail | - | - | - | - | N/A | N/A |
| cat | - | - | - | - | N/A | N/A |
| rev | - | - | - | - | N/A | N/A |
| expand | - | - | - | - | N/A | N/A |
| unexpand | - | - | - | - | N/A | N/A |
| fold | - | - | - | - | N/A | N/A |
| paste | - | - | - | - | N/A | N/A |
| nl | - | - | - | - | N/A | N/A |
| comm | - | - | - | - | N/A | N/A |
| join | - | - | - | - | N/A | N/A |
| basenc | - | - | - | - | N/A | N/A |
| base32 | - | - | - | - | N/A | N/A |
| ln | - | - | - | - | N/A | N/A |
| touch | - | - | - | - | N/A | N/A |
| truncate | - | - | - | - | N/A | N/A |
| mkdir | - | - | - | - | N/A | N/A |
| rmdir | - | - | - | - | N/A | N/A |
| mknod | - | - | - | - | N/A | N/A |
| mkfifo | - | - | - | - | N/A | N/A |
| mktemp | - | - | - | - | N/A | N/A |
| seq | - | - | - | - | N/A | N/A |
| tsort | - | - | - | - | N/A | N/A |
| tee | - | - | - | - | N/A | N/A |
| sum | - | - | - | - | N/A | N/A |
| cksum | - | - | - | - | N/A | N/A |
| sha1sum | - | - | - | - | N/A | N/A |
| sha224sum | - | - | - | - | N/A | N/A |
| sha384sum | - | - | - | - | N/A | N/A |
| sha512sum | - | - | - | - | N/A | N/A |
| id | - | - | - | - | N/A | N/A |
| groups | - | - | - | - | N/A | N/A |
| whoami | - | - | - | - | N/A | N/A |
| logname | - | - | - | - | N/A | N/A |
| uname | - | - | - | - | N/A | N/A |
| arch | - | - | - | - | N/A | N/A |
| hostid | - | - | - | - | N/A | N/A |
| tty | - | - | - | - | N/A | N/A |
| nproc | - | - | - | - | N/A | N/A |
| pwd | - | - | - | - | N/A | N/A |
| env | - | - | - | - | N/A | N/A |
| nice | - | - | - | - | N/A | N/A |
| nohup | - | - | - | - | N/A | N/A |
| sleep | - | - | - | - | N/A | N/A |
| sync | - | - | - | - | N/A | N/A |
| true | - | - | - | - | N/A | N/A |
| false | - | - | - | - | N/A | N/A |
| link | - | - | - | - | N/A | N/A |
| unlink | - | - | - | - | N/A | N/A |
| basename | - | - | - | - | N/A | N/A |
| dirname | - | - | - | - | N/A | N/A |
| pathchk | - | - | - | - | N/A | N/A |
| realpath | - | - | - | - | N/A | N/A |
| readlink | - | - | - | - | N/A | N/A |
| echo | - | - | - | - | N/A | N/A |
| factor | - | - | - | - | N/A | N/A |
| expr | - | - | - | - | N/A | N/A |
| test | - | - | - | - | N/A | N/A |
| cp | - | - | - | - | N/A | N/A |
| mv | - | - | - | - | N/A | N/A |
| rm | - | - | - | - | N/A | N/A |
| dd | - | - | - | - | N/A | N/A |
| split | - | - | - | - | N/A | N/A |
| csplit | - | - | - | - | N/A | N/A |
| install | - | - | - | - | N/A | N/A |
| shred | - | - | - | - | N/A | N/A |
| chmod | - | - | - | - | N/A | N/A |
| chown | - | - | - | - | N/A | N/A |
| chgrp | - | - | - | - | N/A | N/A |
| yes | startup --help | 0.0008s | 0.0002s | N/A | **3.8x** | N/A |
| yes | startup --version | 0.0008s | 0.0002s | N/A | **3.9x** | N/A |
| yes | throughput 1M lines | 0.0028s | 0.0030s | N/A | **0.9x** | N/A |
| yes | throughput 10M lines | 0.0236s | 0.0188s | N/A | **1.3x** | N/A |
| yes | throughput hello 1M lines | 0.0061s | 0.0058s | N/A | **1.1x** | N/A |
| yes | throughput hello 10M lines | 0.0477s | 0.0508s | N/A | **0.9x** | N/A |
| yes | throughput 100MB | 0.0237s | 0.0350s | N/A | **0.7x** | N/A |
