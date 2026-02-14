# fcoreutils v0.0.20 — Detailed Results

Generated: 2026-02-14 13:41:02 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 1233/1239 (99.5%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0012s | 0.0011s | **1.1x** |
| wc | default 1MB text | 0.0040s | 0.0029s | **1.4x** |
| wc | default 10MB text | 0.0335s | 0.0172s | **2.0x** |
| wc | default 100MB text | 0.2924s | 0.0396s | **7.4x** |
| wc | -l 10MB text | 0.0039s | 0.0025s | **1.6x** |
| wc | -w 10MB text | 0.0336s | 0.0167s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0336s | 0.0020s | **17.2x** |
| wc | -L 10MB text | 0.0335s | 0.0170s | **2.0x** |
| wc | default 10MB binary | 0.2361s | 0.0604s | **3.9x** |
| wc | default 10MB repetitive | 0.0528s | 0.0073s | **7.2x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.9x** |
| wc | 100 files | 0.0014s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0051s | **3.7x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0052s | **3.7x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0034s | **5.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0060s | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0057s | **4.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0073s | **3.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0018s | **2.0x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0009s | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0010s | **1.2x** |
| sha256sum | single 1MB text | 0.0018s | 0.0019s | **0.9x** |
| sha256sum | single 10MB text | 0.0070s | 0.0070s | **1.0x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0074s | **1.1x** |
| sha256sum | single 100MB text | 0.0615s | 0.0601s | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0009s | **1.3x** |
| sha256sum | 100 files | 0.0019s | 0.0014s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.2x** |
| md5sum | single 1MB text | 0.0032s | 0.0028s | **1.1x** |
| md5sum | single 10MB text | 0.0205s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0224s | 0.0169s | **1.3x** |
| md5sum | single 100MB text | 0.1933s | 0.1494s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0010s | **1.2x** |
| md5sum | 100 files | 0.0018s | 0.0014s | **1.3x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0026s | **0.8x** |
| b2sum | single 10MB text | 0.0136s | 0.0136s | **1.0x** |
| b2sum | single 10MB binary | 0.0152s | 0.0142s | **1.1x** |
| b2sum | single 100MB text | 0.1279s | 0.1252s | **1.0x** |
| b2sum | -l 256 10MB | 0.0136s | 0.0135s | **1.0x** |
| b2sum | -l 128 10MB | 0.0135s | 0.0136s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0027s | **0.6x** |
| base64 | encode 10MB text | 0.0093s | 0.0061s | **1.5x** |
| base64 | encode 10MB binary | 0.0104s | 0.0065s | **1.6x** |
| base64 | decode 1MB | 0.0038s | 0.0031s | **1.2x** |
| base64 | decode 10MB | 0.0309s | 0.0196s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0094s | 0.0063s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0047s | **1.5x** |
| sort | lexicographic 1MB | 0.0077s | 0.0040s | **1.9x** |
| sort | lexicographic 10MB random | 0.0547s | 0.0202s | **2.7x** |
| sort | already sorted 10MB | 0.0250s | 0.0103s | **2.4x** |
| sort | reverse sorted 10MB | 0.0250s | 0.0104s | **2.4x** |
| sort | -n numeric 10MB | 0.0746s | 0.0377s | **2.0x** |
| sort | -r reverse 10MB | 0.0547s | 0.0200s | **2.7x** |
| sort | -u unique 10MB | 0.0574s | 0.0198s | **2.9x** |
| sort | -t, -k2 CSV 10MB | 0.0762s | 0.0386s | **2.0x** |
| sort | repetitive 10MB | 0.0442s | 0.0241s | **1.8x** |
| sort | --parallel=4 10MB | 0.0524s | 0.0185s | **2.8x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0020s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0070s | **1.3x** |
| tr | -d digits 10MB | 0.0111s | 0.0116s | **1.0x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0197s | **1.0x** |
| tr | -s spaces 10MB | 0.0169s | 0.0160s | **1.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0069s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0117s | **1.0x** |
| tr | translate binary 10MB | 0.0090s | 0.0074s | **1.2x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0048s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0055s | **2.9x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0048s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0075s | **3.9x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0061s | **2.7x** |
| uniq | repetitive 10MB | 0.0464s | 0.0072s | **6.5x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0021s | **0.8x** |
| tac | reverse 10MB text | 0.0081s | 0.0062s | **1.3x** |
| tac | reverse 100MB text | 0.0788s | 0.0567s | **1.4x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0066s | **1.3x** |
| tac | reverse repetitive 10MB | 0.0172s | 0.0141s | **1.2x** |
| tac | custom separator 1MB | 0.0045s | 0.0053s | **0.8x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0033s | **1.7x** |
| wc | default 10MB text | 0.0545s | 0.0204s | **2.7x** |
| wc | default 100MB text | 0.4826s | 0.0649s | **7.4x** |
| wc | -l 10MB text | 0.0020s | 0.0017s | **1.2x** |
| wc | -w 10MB text | 0.0542s | 0.0217s | **2.5x** |
| wc | -c 10MB text | 0.0009s | 0.0009s | **1.0x** |
| wc | -m 10MB text | 0.0544s | 0.0019s | **29.2x** |
| wc | -L 10MB text | 0.0543s | 0.0233s | **2.3x** |
| wc | default 10MB binary | 0.3165s | 0.0825s | **3.8x** |
| wc | default 10MB repetitive | 0.0732s | 0.0116s | **6.3x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0051s | **4.4x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0054s | **4.2x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0036s | **4.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0071s | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0067s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0102s | **3.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0023s | **1.5x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0020s | 0.0023s | **0.9x** |
| sha256sum | single 10MB text | 0.0087s | 0.0079s | **1.1x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0083s | **1.0x** |
| sha256sum | single 100MB text | 0.0749s | 0.0718s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | 100 files | 0.0024s | 0.0019s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0035s | **0.8x** |
| md5sum | single 10MB text | 0.0171s | 0.0199s | **0.9x** |
| md5sum | single 10MB binary | 0.0180s | 0.0209s | **0.9x** |
| md5sum | single 100MB text | 0.1608s | 0.1917s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0010s | **1.5x** |
| md5sum | 100 files | 0.0024s | 0.0019s | **1.3x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0027s | **0.9x** |
| b2sum | single 10MB text | 0.0151s | 0.0117s | **1.3x** |
| b2sum | single 10MB binary | 0.0156s | 0.0122s | **1.3x** |
| b2sum | single 100MB text | 0.1428s | 0.1094s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0117s | **1.3x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0117s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0029s | **0.7x** |
| base64 | encode 10MB text | 0.0124s | 0.0056s | **2.2x** |
| base64 | encode 10MB binary | 0.0128s | 0.0056s | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0029s | **1.3x** |
| base64 | decode 10MB | 0.0330s | 0.0176s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0055s | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0032s | **2.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0040s | **2.1x** |
| sort | lexicographic 10MB random | 0.0550s | 0.0182s | **3.0x** |
| sort | already sorted 10MB | 0.0266s | 0.0128s | **2.1x** |
| sort | reverse sorted 10MB | 0.0280s | 0.0122s | **2.3x** |
| sort | -n numeric 10MB | 0.0736s | 0.0391s | **1.9x** |
| sort | -r reverse 10MB | 0.0549s | 0.0188s | **2.9x** |
| sort | -u unique 10MB | 0.0580s | 0.0186s | **3.1x** |
| sort | -t, -k2 CSV 10MB | 0.0666s | 0.0331s | **2.0x** |
| sort | repetitive 10MB | 0.0549s | 0.0221s | **2.5x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0187s | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0022s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0091s | **1.4x** |
| tr | -d digits 10MB | 0.0169s | 0.0152s | **1.1x** |
| tr | -d lowercase 10MB | 0.0304s | 0.0266s | **1.1x** |
| tr | -s spaces 10MB | 0.0277s | 0.0253s | **1.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0086s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0171s | 0.0150s | **1.1x** |
| tr | translate binary 10MB | 0.0119s | 0.0093s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0043s | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0042s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0046s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0067s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0046s | **2.6x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0046s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0052s | **2.7x** |
| uniq | repetitive 10MB | 0.0422s | 0.0066s | **6.4x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0025s | **0.8x** |
| tac | reverse 10MB text | 0.0106s | 0.0067s | **1.6x** |
| tac | reverse 100MB text | 0.1048s | 0.0507s | **2.1x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0069s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0236s | 0.0141s | **1.7x** |
| tac | custom separator 1MB | 0.0060s | 0.0069s | **0.9x** |
