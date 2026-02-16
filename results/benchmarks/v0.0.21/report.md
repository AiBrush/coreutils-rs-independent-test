# fcoreutils v0.0.21 — Detailed Results

Generated: 2026-02-16 02:00:03 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |

**Overall: 1233/1239 (99.5%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0010s | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0335s | 0.0170s | **2.0x** |
| wc | default 100MB text | 0.2914s | 0.0395s | **7.4x** |
| wc | -l 10MB text | 0.0035s | 0.0023s | **1.5x** |
| wc | -w 10MB text | 0.0335s | 0.0166s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0335s | 0.0018s | **18.7x** |
| wc | -L 10MB text | 0.0334s | 0.0170s | **2.0x** |
| wc | default 10MB binary | 0.2360s | 0.0602s | **3.9x** |
| wc | default 10MB repetitive | 0.0507s | 0.0067s | **7.6x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0048s | **3.9x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0047s | **4.0x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0033s | **5.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0058s | **3.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0053s | **4.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0070s | **3.8x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0018s | **2.0x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0009s | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0010s | **1.2x** |
| sha256sum | single 1MB text | 0.0018s | 0.0019s | **1.0x** |
| sha256sum | single 10MB text | 0.0072s | 0.0070s | **1.0x** |
| sha256sum | single 10MB binary | 0.0084s | 0.0074s | **1.1x** |
| sha256sum | single 100MB text | 0.0615s | 0.0600s | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0009s | **1.3x** |
| sha256sum | 100 files | 0.0019s | 0.0013s | **1.4x** |
| md5sum | single 100KB text | 0.0013s | 0.0011s | **1.2x** |
| md5sum | single 1MB text | 0.0032s | 0.0029s | **1.1x** |
| md5sum | single 10MB text | 0.0204s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0223s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1930s | 0.1493s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0009s | **1.3x** |
| md5sum | 100 files | 0.0017s | 0.0013s | **1.2x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | **0.9x** |
| b2sum | single 1MB text | 0.0021s | 0.0025s | **0.8x** |
| b2sum | single 10MB text | 0.0134s | 0.0128s | **1.0x** |
| b2sum | single 10MB binary | 0.0144s | 0.0135s | **1.1x** |
| b2sum | single 100MB text | 0.1277s | 0.1194s | **1.1x** |
| b2sum | -l 256 10MB | 0.0134s | 0.0129s | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0130s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0028s | **0.6x** |
| base64 | encode 10MB text | 0.0095s | 0.0062s | **1.5x** |
| base64 | encode 10MB binary | 0.0105s | 0.0064s | **1.6x** |
| base64 | decode 1MB | 0.0038s | 0.0030s | **1.3x** |
| base64 | decode 10MB | 0.0306s | 0.0186s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0091s | 0.0060s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0068s | 0.0047s | **1.4x** |
| sort | lexicographic 1MB | 0.0074s | 0.0037s | **2.0x** |
| sort | lexicographic 10MB random | 0.0521s | 0.0180s | **2.9x** |
| sort | already sorted 10MB | 0.0247s | 0.0097s | **2.6x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0102s | **2.4x** |
| sort | -n numeric 10MB | 0.0698s | 0.0353s | **2.0x** |
| sort | -r reverse 10MB | 0.0534s | 0.0184s | **2.9x** |
| sort | -u unique 10MB | 0.0550s | 0.0183s | **3.0x** |
| sort | -t, -k2 CSV 10MB | 0.0720s | 0.0324s | **2.2x** |
| sort | repetitive 10MB | 0.0430s | 0.0226s | **1.9x** |
| sort | --parallel=4 10MB | 0.0515s | 0.0165s | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0016s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0061s | **1.5x** |
| tr | -d digits 10MB | 0.0112s | 0.0099s | **1.1x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0167s | **1.1x** |
| tr | -s spaces 10MB | 0.0170s | 0.0140s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0063s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0100s | **1.1x** |
| tr | translate binary 10MB | 0.0096s | 0.0067s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0053s | **3.1x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0053s | **1.8x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0084s | **3.5x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0053s | **1.8x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0053s | **1.8x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0059s | **2.8x** |
| uniq | repetitive 10MB | 0.0464s | 0.0071s | **6.5x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0021s | **0.8x** |
| tac | reverse 10MB text | 0.0083s | 0.0070s | **1.2x** |
| tac | reverse 100MB text | 0.0787s | 0.0563s | **1.4x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0071s | **1.1x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0141s | **1.2x** |
| tac | custom separator 1MB | 0.0043s | 0.0052s | **0.8x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0033s | **1.7x** |
| wc | default 10MB text | 0.0544s | 0.0205s | **2.7x** |
| wc | default 100MB text | 0.4828s | 0.0654s | **7.4x** |
| wc | -l 10MB text | 0.0020s | 0.0016s | **1.2x** |
| wc | -w 10MB text | 0.0541s | 0.0216s | **2.5x** |
| wc | -c 10MB text | 0.0009s | 0.0009s | **1.0x** |
| wc | -m 10MB text | 0.0544s | 0.0018s | **30.5x** |
| wc | -L 10MB text | 0.0544s | 0.0229s | **2.4x** |
| wc | default 10MB binary | 0.3170s | 0.0831s | **3.8x** |
| wc | default 10MB repetitive | 0.0730s | 0.0115s | **6.3x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.1x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0230s | 0.0053s | **4.4x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0050s | **4.5x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0036s | **4.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0072s | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0068s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0308s | 0.0101s | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0022s | **1.5x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0008s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0020s | 0.0023s | **0.9x** |
| sha256sum | single 10MB text | 0.0087s | 0.0079s | **1.1x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0083s | **1.1x** |
| sha256sum | single 100MB text | 0.0755s | 0.0719s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | 100 files | 0.0025s | 0.0018s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0035s | **0.8x** |
| md5sum | single 10MB text | 0.0172s | 0.0200s | **0.9x** |
| md5sum | single 10MB binary | 0.0181s | 0.0210s | **0.9x** |
| md5sum | single 100MB text | 0.1612s | 0.1916s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0010s | **1.5x** |
| md5sum | 100 files | 0.0024s | 0.0018s | **1.3x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0026s | **0.9x** |
| b2sum | single 10MB text | 0.0152s | 0.0117s | **1.3x** |
| b2sum | single 10MB binary | 0.0158s | 0.0122s | **1.3x** |
| b2sum | single 100MB text | 0.1428s | 0.1094s | **1.3x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0117s | **1.3x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0118s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0018s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0020s | 0.0031s | **0.7x** |
| base64 | encode 10MB text | 0.0126s | 0.0057s | **2.2x** |
| base64 | encode 10MB binary | 0.0131s | 0.0058s | **2.3x** |
| base64 | decode 1MB | 0.0039s | 0.0029s | **1.3x** |
| base64 | decode 10MB | 0.0329s | 0.0177s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0055s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0032s | **2.7x** |
| sort | lexicographic 1MB | 0.0086s | 0.0041s | **2.1x** |
| sort | lexicographic 10MB random | 0.0547s | 0.0183s | **3.0x** |
| sort | already sorted 10MB | 0.0265s | 0.0121s | **2.2x** |
| sort | reverse sorted 10MB | 0.0281s | 0.0125s | **2.2x** |
| sort | -n numeric 10MB | 0.0738s | 0.0390s | **1.9x** |
| sort | -r reverse 10MB | 0.0546s | 0.0178s | **3.1x** |
| sort | -u unique 10MB | 0.0573s | 0.0180s | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0666s | 0.0329s | **2.0x** |
| sort | repetitive 10MB | 0.0551s | 0.0220s | **2.5x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0175s | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0129s | 0.0084s | **1.5x** |
| tr | -d digits 10MB | 0.0166s | 0.0145s | **1.1x** |
| tr | -d lowercase 10MB | 0.0293s | 0.0252s | **1.2x** |
| tr | -s spaces 10MB | 0.0290s | 0.0166s | **1.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0133s | 0.0084s | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0160s | 0.0147s | **1.1x** |
| tr | translate binary 10MB | 0.0119s | 0.0082s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0044s | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0042s | **3.4x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0048s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0081s | **3.6x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0048s | **2.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0047s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0054s | **2.5x** |
| uniq | repetitive 10MB | 0.0421s | 0.0066s | **6.4x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0025s | **0.8x** |
| tac | reverse 10MB text | 0.0105s | 0.0065s | **1.6x** |
| tac | reverse 100MB text | 0.1049s | 0.0483s | **2.2x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0071s | **1.3x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0123s | **1.9x** |
| tac | custom separator 1MB | 0.0059s | 0.0066s | **0.9x** |
