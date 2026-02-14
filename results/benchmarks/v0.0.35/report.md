# fcoreutils v0.0.35 — Detailed Results

Generated: 2026-02-14 12:25:10 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 408 | 5 | 98.8% |
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 412 | 1 | 99.8% |

**Overall: 1232/1239 (99.4%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0012s | **0.9x** |
| wc | default 1MB text | 0.0040s | 0.0027s | **1.5x** |
| wc | default 10MB text | 0.0346s | 0.0064s | **5.4x** |
| wc | default 100MB text | 0.2919s | 0.0406s | **7.2x** |
| wc | -l 10MB text | 0.0047s | 0.0025s | **1.9x** |
| wc | -w 10MB text | 0.0347s | 0.0172s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0011s | **0.7x** |
| wc | -m 10MB text | 0.0345s | 0.0026s | **13.5x** |
| wc | -L 10MB text | 0.0345s | 0.0170s | **2.0x** |
| wc | default 10MB binary | 0.2342s | 0.0597s | **3.9x** |
| wc | default 10MB repetitive | 0.0536s | 0.0075s | **7.2x** |
| wc | 10 files | 0.0009s | 0.0013s | **0.7x** |
| wc | 100 files | 0.0014s | 0.0017s | **0.8x** |
| cut | -b1-100 10MB CSV | 0.0190s | 0.0036s | **5.3x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0036s | **5.3x** |
| cut | -d, -f1 10MB CSV | 0.0193s | 0.0047s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0052s | **4.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0237s | 0.0048s | **5.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0270s | 0.0056s | **4.9x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0012s | **1.0x** |
| sha256sum | single 1MB text | 0.0019s | 0.0017s | **1.1x** |
| sha256sum | single 10MB text | 0.0083s | 0.0066s | **1.3x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0067s | **1.1x** |
| sha256sum | single 100MB text | 0.0621s | 0.0531s | **1.2x** |
| sha256sum | 10 files | 0.0013s | 0.0020s | **0.6x** |
| sha256sum | 100 files | 0.0020s | 0.0030s | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0013s | **1.1x** |
| md5sum | single 1MB text | 0.0034s | 0.0028s | **1.2x** |
| md5sum | single 10MB text | 0.0217s | 0.0166s | **1.3x** |
| md5sum | single 10MB binary | 0.0215s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1938s | 0.1499s | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0019s | **0.7x** |
| md5sum | 100 files | 0.0019s | 0.0030s | **0.6x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | **1.0x** |
| b2sum | single 10MB text | 0.0147s | 0.0127s | **1.2x** |
| b2sum | single 10MB binary | 0.0142s | 0.0129s | **1.1x** |
| b2sum | single 100MB text | 0.1283s | 0.1123s | **1.1x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0127s | **1.2x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0127s | **1.2x** |
| b2sum | 100 files | 0.0018s | 0.0030s | **0.6x** |
| base64 | encode 100KB text | 0.0010s | 0.0013s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0019s | **0.9x** |
| base64 | encode 10MB text | 0.0104s | 0.0039s | **2.6x** |
| base64 | encode 10MB binary | 0.0099s | 0.0036s | **2.7x** |
| base64 | decode 1MB | 0.0039s | 0.0025s | **1.6x** |
| base64 | decode 10MB | 0.0309s | 0.0142s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0104s | 0.0038s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0083s | 0.0033s | **2.5x** |
| sort | lexicographic 1MB | 0.0078s | 0.0035s | **2.2x** |
| sort | lexicographic 10MB random | 0.0534s | 0.0083s | **6.5x** |
| sort | already sorted 10MB | 0.0251s | 0.0054s | **4.6x** |
| sort | reverse sorted 10MB | 0.0250s | 0.0047s | **5.3x** |
| sort | -n numeric 10MB | 0.0755s | 0.0244s | **3.1x** |
| sort | -r reverse 10MB | 0.0562s | 0.0087s | **6.5x** |
| sort | -u unique 10MB | 0.0579s | 0.0148s | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0761s | 0.0215s | **3.5x** |
| sort | repetitive 10MB | 0.0464s | 0.0133s | **3.5x** |
| sort | --parallel=4 10MB | 0.0524s | 0.0082s | **6.4x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0022s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0067s | **1.3x** |
| tr | -d digits 10MB | 0.0112s | 0.0100s | **1.1x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0171s | **1.1x** |
| tr | -s spaces 10MB | 0.0168s | 0.0140s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0066s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0099s | **1.2x** |
| tr | translate binary 10MB | 0.0095s | 0.0069s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0048s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0047s | **3.4x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0064s | **1.5x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0077s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0049s | **1.9x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0049s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0059s | **2.8x** |
| uniq | repetitive 10MB | 0.0490s | 0.0076s | **6.5x** |
| tac | reverse 100KB text | 0.0009s | 0.0013s | **0.7x** |
| tac | reverse 1MB text | 0.0017s | 0.0019s | **0.9x** |
| tac | reverse 10MB text | 0.0092s | 0.0057s | **1.6x** |
| tac | reverse 100MB text | 0.0792s | 0.0389s | **2.0x** |
| tac | reverse CSV 10MB | 0.0087s | 0.0057s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0195s | 0.0110s | **1.8x** |
| tac | custom separator 1MB | 0.0046s | 0.0042s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0058s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0549s | 0.0097s | **5.6x** |
| wc | default 100MB text | 0.4826s | 0.0708s | **6.8x** |
| wc | -l 10MB text | 0.0023s | 0.0032s | **0.7x** |
| wc | -w 10MB text | 0.0548s | 0.0209s | **2.6x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0548s | 0.0031s | **17.4x** |
| wc | -L 10MB text | 0.0547s | 0.0237s | **2.3x** |
| wc | default 10MB binary | 0.3167s | 0.0824s | **3.8x** |
| wc | default 10MB repetitive | 0.0735s | 0.0132s | **5.6x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0233s | 0.0045s | **5.2x** |
| cut | -c1-100 10MB CSV | 0.0232s | 0.0043s | **5.4x** |
| cut | -d, -f1 10MB CSV | 0.0170s | 0.0064s | **2.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0225s | 0.0083s | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0249s | 0.0079s | **3.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0095s | **3.3x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0032s | **1.1x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0012s | **1.2x** |
| sha256sum | single 1MB text | 0.0021s | 0.0019s | **1.1x** |
| sha256sum | single 10MB text | 0.0091s | 0.0087s | **1.0x** |
| sha256sum | single 10MB binary | 0.0093s | 0.0090s | **1.0x** |
| sha256sum | single 100MB text | 0.0755s | 0.0744s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0050s | **0.5x** |
| md5sum | single 100KB text | 0.0015s | 0.0013s | **1.2x** |
| md5sum | single 1MB text | 0.0030s | 0.0031s | **1.0x** |
| md5sum | single 10MB text | 0.0177s | 0.0210s | **0.8x** |
| md5sum | single 10MB binary | 0.0184s | 0.0220s | **0.8x** |
| md5sum | single 100MB text | 0.1615s | 0.1940s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| md5sum | 100 files | 0.0026s | 0.0053s | **0.5x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0024s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0153s | 0.0123s | **1.2x** |
| b2sum | single 10MB binary | 0.0161s | 0.0133s | **1.2x** |
| b2sum | single 100MB text | 0.1430s | 0.1124s | **1.3x** |
| b2sum | -l 256 10MB | 0.0154s | 0.0125s | **1.2x** |
| b2sum | -l 128 10MB | 0.0153s | 0.0126s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0052s | **0.4x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0017s | **1.2x** |
| base64 | encode 10MB text | 0.0127s | 0.0054s | **2.3x** |
| base64 | encode 10MB binary | 0.0133s | 0.0057s | **2.3x** |
| base64 | decode 1MB | 0.0041s | 0.0024s | **1.8x** |
| base64 | decode 10MB | 0.0331s | 0.0113s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0128s | 0.0055s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0092s | 0.0043s | **2.1x** |
| sort | lexicographic 1MB | 0.0087s | 0.0041s | **2.1x** |
| sort | lexicographic 10MB random | 0.0561s | 0.0127s | **4.4x** |
| sort | already sorted 10MB | 0.0271s | 0.0077s | **3.5x** |
| sort | reverse sorted 10MB | 0.0279s | 0.0072s | **3.9x** |
| sort | -n numeric 10MB | 0.0758s | 0.0317s | **2.4x** |
| sort | -r reverse 10MB | 0.0559s | 0.0127s | **4.4x** |
| sort | -u unique 10MB | 0.0596s | 0.0156s | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0677s | 0.0266s | **2.5x** |
| sort | repetitive 10MB | 0.0563s | 0.0168s | **3.4x** |
| sort | --parallel=4 10MB | 0.0553s | 0.0127s | **4.3x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0022s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0060s | **2.2x** |
| tr | -d digits 10MB | 0.0161s | 0.0128s | **1.3x** |
| tr | -d lowercase 10MB | 0.0296s | 0.0215s | **1.4x** |
| tr | -s spaces 10MB | 0.0273s | 0.0149s | **1.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0128s | 0.0061s | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0162s | 0.0128s | **1.3x** |
| tr | translate binary 10MB | 0.0115s | 0.0061s | **1.9x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0063s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0145s | 0.0067s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0077s | **1.6x** |
| uniq | -c count 10MB sorted | 0.0299s | 0.0105s | **2.8x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0062s | **2.0x** |
| uniq | -u unique only 10MB | 0.0122s | 0.0061s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0077s | **1.9x** |
| uniq | repetitive 10MB | 0.0425s | 0.0085s | **5.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0014s | **0.7x** |
| tac | reverse 1MB text | 0.0020s | 0.0019s | **1.0x** |
| tac | reverse 10MB text | 0.0122s | 0.0079s | **1.5x** |
| tac | reverse 100MB text | 0.1044s | 0.0520s | **2.0x** |
| tac | reverse CSV 10MB | 0.0097s | 0.0074s | **1.3x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0136s | **1.8x** |
| tac | custom separator 1MB | 0.0062s | 0.0050s | **1.3x** |
