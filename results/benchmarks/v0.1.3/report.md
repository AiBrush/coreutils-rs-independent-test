# fcoreutils v0.1.3 — Detailed Results

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
| wc | default 1MB text | 0.0036s | 0.0025s | **1.5x** |
| wc | default 10MB text | 0.0337s | 0.0065s | **5.2x** |
| wc | default 100MB text | 0.2911s | 0.0428s | **6.8x** |
| wc | -l 10MB text | 0.0038s | 0.0020s | **1.9x** |
| wc | -w 10MB text | 0.0337s | 0.0063s | **5.4x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | **0.8x** |
| wc | -m 10MB text | 0.0338s | 0.0022s | **15.5x** |
| wc | -L 10MB text | 0.0335s | 0.0060s | **5.6x** |
| wc | default 10MB binary | 0.2350s | 0.0170s | **13.9x** |
| wc | default 10MB repetitive | 0.0524s | 0.0080s | **6.5x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0012s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0032s | **5.6x** |
| cut | -c1-100 10MB CSV | 0.0180s | 0.0030s | **5.9x** |
| cut | -d, -f1 10MB CSV | 0.0180s | 0.0041s | **4.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0207s | 0.0052s | **3.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0226s | 0.0034s | **6.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0260s | 0.0029s | **9.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0020s | **1.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | **0.8x** |
| sha256sum | single 100KB text | 0.0010s | 0.0019s | **0.6x** |
| sha256sum | single 1MB text | 0.0015s | 0.0024s | **0.7x** |
| sha256sum | single 10MB text | 0.0069s | 0.0071s | **1.0x** |
| sha256sum | single 10MB binary | 0.0069s | 0.0072s | **0.9x** |
| sha256sum | single 100MB text | 0.0596s | 0.0537s | **1.1x** |
| sha256sum | 10 files | 0.0010s | 0.0019s | **0.5x** |
| sha256sum | 100 files | 0.0016s | 0.0023s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0034s | **0.9x** |
| md5sum | single 10MB text | 0.0204s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0209s | 0.0167s | **1.2x** |
| md5sum | single 100MB text | 0.1915s | 0.1410s | **1.4x** |
| md5sum | 10 files | 0.0010s | 0.0019s | **0.5x** |
| md5sum | 100 files | 0.0016s | 0.0023s | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | **0.9x** |
| b2sum | single 10MB text | 0.0133s | 0.0123s | **1.1x** |
| b2sum | single 10MB binary | 0.0136s | 0.0128s | **1.1x** |
| b2sum | single 100MB text | 0.1258s | 0.1134s | **1.1x** |
| b2sum | -l 256 10MB | 0.0132s | 0.0124s | **1.1x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0123s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0013s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.8x** |
| base64 | encode 1MB text | 0.0015s | 0.0014s | **1.1x** |
| base64 | encode 10MB text | 0.0090s | 0.0050s | **1.8x** |
| base64 | encode 10MB binary | 0.0091s | 0.0054s | **1.7x** |
| base64 | decode 1MB | 0.0036s | 0.0017s | **2.1x** |
| base64 | decode 10MB | 0.0292s | 0.0089s | **3.3x** |
| base64 | encode -w 76 10MB | 0.0090s | 0.0051s | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0044s | **1.6x** |
| sort | lexicographic 1MB | 0.0072s | 0.0025s | **2.8x** |
| sort | lexicographic 10MB random | 0.0493s | 0.0085s | **5.8x** |
| sort | already sorted 10MB | 0.0232s | 0.0032s | **7.3x** |
| sort | reverse sorted 10MB | 0.0232s | 0.0051s | **4.5x** |
| sort | -n numeric 10MB | 0.0673s | 0.0036s | **18.8x** |
| sort | -r reverse 10MB | 0.0503s | 0.0086s | **5.9x** |
| sort | -u unique 10MB | 0.0523s | 0.0089s | **5.9x** |
| sort | -t, -k2 CSV 10MB | 0.0684s | 0.0410s | **1.7x** |
| sort | repetitive 10MB | 0.0423s | 0.0096s | **4.4x** |
| sort | --parallel=4 10MB | 0.0496s | 0.0084s | **5.9x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0016s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0064s | **1.4x** |
| tr | -d digits 10MB | 0.0110s | 0.0128s | **0.9x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0193s | **1.0x** |
| tr | -s spaces 10MB | 0.0166s | 0.0064s | **2.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0092s | 0.0064s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0127s | **0.9x** |
| tr | translate binary 10MB | 0.0096s | 0.0060s | **1.6x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0026s | **3.4x** |
| uniq | default 10MB sorted (low dup) | 0.0158s | 0.0028s | **5.8x** |
| uniq | -c count 10MB many dups | 0.0089s | 0.0029s | **3.1x** |
| uniq | -c count 10MB sorted | 0.0286s | 0.0067s | **4.2x** |
| uniq | -d duplicates only 10MB | 0.0089s | 0.0026s | **3.5x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0026s | **3.5x** |
| uniq | -i case insensitive 10MB | 0.0158s | 0.0038s | **4.2x** |
| uniq | repetitive 10MB | 0.0474s | 0.0035s | **13.6x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0015s | **1.1x** |
| tac | reverse 10MB text | 0.0081s | 0.0043s | **1.9x** |
| tac | reverse 100MB text | 0.0780s | 0.0373s | **2.1x** |
| tac | reverse CSV 10MB | 0.0076s | 0.0042s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0173s | 0.0090s | **1.9x** |
| tac | custom separator 1MB | 0.0041s | 0.0035s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0059s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0545s | 0.0032s | **17.2x** |
| wc | default 100MB text | 0.4848s | 0.0140s | **34.6x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0091s | **5.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0541s | 0.0030s | **18.0x** |
| wc | -L 10MB text | 0.0542s | 0.0097s | **5.6x** |
| wc | default 10MB binary | 0.3194s | 0.0277s | **11.5x** |
| wc | default 10MB repetitive | 0.0730s | 0.0045s | **16.1x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0227s | 0.0054s | **4.2x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0055s | **4.1x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0051s | **3.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0074s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0055s | **4.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0047s | **6.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0096s | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0099s | **0.9x** |
| sha256sum | single 100MB text | 0.0753s | 0.0751s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0030s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | **0.8x** |
| md5sum | single 10MB text | 0.0170s | 0.0173s | **1.0x** |
| md5sum | single 10MB binary | 0.0179s | 0.0181s | **1.0x** |
| md5sum | single 100MB text | 0.1612s | 0.1544s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0030s | **0.8x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0121s | **1.2x** |
| b2sum | single 10MB binary | 0.0158s | 0.0127s | **1.2x** |
| b2sum | single 100MB text | 0.1430s | 0.1119s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0121s | **1.2x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0122s | 0.0060s | **2.0x** |
| base64 | encode 10MB binary | 0.0131s | 0.0062s | **2.1x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | **1.9x** |
| base64 | decode 10MB | 0.0331s | 0.0113s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0125s | 0.0057s | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0039s | **2.2x** |
| sort | lexicographic 1MB | 0.0086s | 0.0033s | **2.6x** |
| sort | lexicographic 10MB random | 0.0555s | 0.0121s | **4.6x** |
| sort | already sorted 10MB | 0.0277s | 0.0049s | **5.7x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0083s | **3.3x** |
| sort | -n numeric 10MB | 0.0734s | 0.0056s | **13.2x** |
| sort | -r reverse 10MB | 0.0554s | 0.0118s | **4.7x** |
| sort | -u unique 10MB | 0.0581s | 0.0127s | **4.6x** |
| sort | -t, -k2 CSV 10MB | 0.0666s | 0.0449s | **1.5x** |
| sort | repetitive 10MB | 0.0558s | 0.0121s | **4.6x** |
| sort | --parallel=4 10MB | 0.0556s | 0.0123s | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0061s | **2.1x** |
| tr | -d digits 10MB | 0.0168s | 0.0132s | **1.3x** |
| tr | -d lowercase 10MB | 0.0302s | 0.0118s | **2.6x** |
| tr | -s spaces 10MB | 0.0263s | 0.0061s | **4.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0060s | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0165s | 0.0132s | **1.3x** |
| tr | translate binary 10MB | 0.0119s | 0.0068s | **1.8x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0038s | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0036s | **3.9x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0035s | **3.4x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0091s | **3.2x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0035s | **3.5x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0035s | **3.4x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0045s | **3.1x** |
| uniq | repetitive 10MB | 0.0422s | 0.0041s | **10.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0019s | 0.0016s | **1.2x** |
| tac | reverse 10MB text | 0.0107s | 0.0047s | **2.3x** |
| tac | reverse 100MB text | 0.1042s | 0.0403s | **2.6x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0050s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0236s | 0.0102s | **2.3x** |
| tac | custom separator 1MB | 0.0060s | 0.0041s | **1.5x** |
