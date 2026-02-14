# fcoreutils v0.1.2 — Detailed Results

Generated: 2026-02-14 13:41:02 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 826/826 (100.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0010s | **1.0x** |
| wc | default 1MB text | 0.0037s | 0.0024s | **1.5x** |
| wc | default 10MB text | 0.0336s | 0.0065s | **5.1x** |
| wc | default 100MB text | 0.2938s | 0.0455s | **6.5x** |
| wc | -l 10MB text | 0.0038s | 0.0021s | **1.8x** |
| wc | -w 10MB text | 0.0338s | 0.0062s | **5.4x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0338s | 0.0022s | **15.5x** |
| wc | -L 10MB text | 0.0338s | 0.0058s | **5.8x** |
| wc | default 10MB binary | 0.2350s | 0.0170s | **13.8x** |
| wc | default 10MB repetitive | 0.0504s | 0.0076s | **6.7x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0012s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0179s | 0.0031s | **5.8x** |
| cut | -c1-100 10MB CSV | 0.0177s | 0.0033s | **5.4x** |
| cut | -d, -f1 10MB CSV | 0.0180s | 0.0039s | **4.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0205s | 0.0045s | **4.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0224s | 0.0034s | **6.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0257s | 0.0030s | **8.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0020s | **1.7x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | single 1MB text | 0.0016s | 0.0024s | **0.7x** |
| sha256sum | single 10MB text | 0.0069s | 0.0072s | **1.0x** |
| sha256sum | single 10MB binary | 0.0070s | 0.0074s | **0.9x** |
| sha256sum | single 100MB text | 0.0602s | 0.0537s | **1.1x** |
| sha256sum | 10 files | 0.0010s | 0.0018s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0033s | **0.9x** |
| md5sum | single 10MB text | 0.0202s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0209s | 0.0167s | **1.3x** |
| md5sum | single 100MB text | 0.1927s | 0.1412s | **1.4x** |
| md5sum | 10 files | 0.0010s | 0.0019s | **0.5x** |
| md5sum | 100 files | 0.0016s | 0.0023s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | **0.9x** |
| b2sum | single 10MB text | 0.0135s | 0.0124s | **1.1x** |
| b2sum | single 10MB binary | 0.0138s | 0.0129s | **1.1x** |
| b2sum | single 100MB text | 0.1268s | 0.1138s | **1.1x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0123s | **1.1x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0124s | **1.1x** |
| b2sum | 100 files | 0.0015s | 0.0013s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0015s | 0.0014s | **1.1x** |
| base64 | encode 10MB text | 0.0091s | 0.0052s | **1.8x** |
| base64 | encode 10MB binary | 0.0092s | 0.0052s | **1.8x** |
| base64 | decode 1MB | 0.0036s | 0.0017s | **2.1x** |
| base64 | decode 10MB | 0.0295s | 0.0090s | **3.3x** |
| base64 | encode -w 76 10MB | 0.0089s | 0.0052s | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0071s | 0.0043s | **1.6x** |
| sort | lexicographic 1MB | 0.0072s | 0.0036s | **2.0x** |
| sort | lexicographic 10MB random | 0.0493s | 0.0057s | **8.7x** |
| sort | already sorted 10MB | 0.0237s | 0.0036s | **6.6x** |
| sort | reverse sorted 10MB | 0.0233s | 0.0043s | **5.4x** |
| sort | -n numeric 10MB | 0.0673s | 0.0037s | **18.2x** |
| sort | -r reverse 10MB | 0.0501s | 0.0059s | **8.5x** |
| sort | -u unique 10MB | 0.0524s | 0.0088s | **5.9x** |
| sort | -t, -k2 CSV 10MB | 0.0685s | 0.0381s | **1.8x** |
| sort | repetitive 10MB | 0.0414s | 0.0095s | **4.4x** |
| sort | --parallel=4 10MB | 0.0492s | 0.0058s | **8.4x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0027s | **0.7x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0190s | **0.5x** |
| tr | -d digits 10MB | 0.0110s | 0.0126s | **0.9x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0198s | **1.0x** |
| tr | -s spaces 10MB | 0.0166s | 0.0066s | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0086s | 0.0187s | **0.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0126s | **0.9x** |
| tr | translate binary 10MB | 0.0092s | 0.0161s | **0.6x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0027s | **3.3x** |
| uniq | default 10MB sorted (low dup) | 0.0160s | 0.0031s | **5.1x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0026s | **3.4x** |
| uniq | -c count 10MB sorted | 0.0289s | 0.0047s | **6.1x** |
| uniq | -d duplicates only 10MB | 0.0089s | 0.0027s | **3.3x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0026s | **3.4x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0039s | **4.1x** |
| uniq | repetitive 10MB | 0.0455s | 0.0031s | **14.5x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0015s | 0.0014s | **1.1x** |
| tac | reverse 10MB text | 0.0081s | 0.0043s | **1.9x** |
| tac | reverse 100MB text | 0.0772s | 0.0357s | **2.2x** |
| tac | reverse CSV 10MB | 0.0074s | 0.0037s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0161s | 0.0074s | **2.2x** |
| tac | custom separator 1MB | 0.0041s | 0.0028s | **1.5x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.2x** |
| wc | default 1MB text | 0.0058s | 0.0028s | **2.1x** |
| wc | default 10MB text | 0.0540s | 0.0031s | **17.2x** |
| wc | default 100MB text | 0.4828s | 0.0140s | **34.5x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | **0.8x** |
| wc | -w 10MB text | 0.0540s | 0.0088s | **6.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0541s | 0.0030s | **17.9x** |
| wc | -L 10MB text | 0.0542s | 0.0110s | **4.9x** |
| wc | default 10MB binary | 0.3146s | 0.0270s | **11.6x** |
| wc | default 10MB repetitive | 0.0732s | 0.0045s | **16.2x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.9x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0052s | **4.4x** |
| cut | -c1-100 10MB CSV | 0.0223s | 0.0053s | **4.2x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0050s | **3.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0059s | **3.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0238s | 0.0052s | **4.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0333s | 0.0045s | **7.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0025s | **0.6x** |
| sha256sum | single 1MB text | 0.0021s | 0.0029s | **0.7x** |
| sha256sum | single 10MB text | 0.0083s | 0.0095s | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0099s | **0.9x** |
| sha256sum | single 100MB text | 0.0747s | 0.0750s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0039s | **0.7x** |
| md5sum | single 10MB text | 0.0169s | 0.0173s | **1.0x** |
| md5sum | single 10MB binary | 0.0177s | 0.0180s | **1.0x** |
| md5sum | single 100MB text | 0.1604s | 0.1528s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0030s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0156s | 0.0126s | **1.2x** |
| b2sum | single 100MB text | 0.1420s | 0.1117s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0121s | **1.2x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0011s | 0.0011s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0121s | 0.0055s | **2.2x** |
| base64 | encode 10MB binary | 0.0128s | 0.0058s | **2.2x** |
| base64 | decode 1MB | 0.0040s | 0.0020s | **2.0x** |
| base64 | decode 10MB | 0.0324s | 0.0110s | **3.0x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0056s | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0037s | **2.3x** |
| sort | lexicographic 1MB | 0.0087s | 0.0044s | **2.0x** |
| sort | lexicographic 10MB random | 0.0540s | 0.0094s | **5.7x** |
| sort | already sorted 10MB | 0.0263s | 0.0050s | **5.3x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0071s | **3.8x** |
| sort | -n numeric 10MB | 0.0734s | 0.0057s | **13.0x** |
| sort | -r reverse 10MB | 0.0547s | 0.0101s | **5.4x** |
| sort | -u unique 10MB | 0.0576s | 0.0115s | **5.0x** |
| sort | -t, -k2 CSV 10MB | 0.0699s | 0.0384s | **1.8x** |
| sort | repetitive 10MB | 0.0562s | 0.0120s | **4.7x** |
| sort | --parallel=4 10MB | 0.0546s | 0.0096s | **5.7x** |
| tr | a-z to A-Z 1MB | 0.0025s | 0.0019s | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0148s | 0.0067s | **2.2x** |
| tr | -d digits 10MB | 0.0163s | 0.0128s | **1.3x** |
| tr | -d lowercase 10MB | 0.0308s | 0.0123s | **2.5x** |
| tr | -s spaces 10MB | 0.0272s | 0.0062s | **4.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0143s | 0.0058s | **2.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0172s | 0.0129s | **1.3x** |
| tr | translate binary 10MB | 0.0129s | 0.0063s | **2.0x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0037s | **3.3x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0037s | **3.8x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | **3.4x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0060s | **4.8x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0035s | **3.4x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0036s | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0046s | **3.1x** |
| uniq | repetitive 10MB | 0.0418s | 0.0043s | **9.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | **1.3x** |
| tac | reverse 10MB text | 0.0105s | 0.0047s | **2.2x** |
| tac | reverse 100MB text | 0.1038s | 0.0412s | **2.5x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0044s | **2.2x** |
| tac | reverse repetitive 10MB | 0.0233s | 0.0092s | **2.5x** |
| tac | custom separator 1MB | 0.0059s | 0.0033s | **1.8x** |
