# fcoreutils v0.0.56 — Detailed Results

Generated: 2026-02-15 03:20:09 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0039s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0339s | 0.0062s | **5.5x** |
| wc | default 100MB text | 0.2960s | 0.0404s | **7.3x** |
| wc | -l 10MB text | 0.0039s | 0.0021s | **1.9x** |
| wc | -w 10MB text | 0.0338s | 0.0069s | **4.9x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0338s | 0.0024s | **14.1x** |
| wc | -L 10MB text | 0.0339s | 0.0063s | **5.4x** |
| wc | default 10MB binary | 0.2347s | 0.0171s | **13.7x** |
| wc | default 10MB repetitive | 0.0503s | 0.0066s | **7.6x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0012s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0031s | **6.1x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0026s | **7.3x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0041s | **4.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0043s | **4.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0231s | 0.0034s | **6.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0045s | **5.8x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | **0.7x** |
| sha256sum | single 100KB text | 0.0010s | 0.0020s | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | **0.6x** |
| sha256sum | single 10MB text | 0.0071s | 0.0072s | **1.0x** |
| sha256sum | single 10MB binary | 0.0080s | 0.0076s | **1.1x** |
| sha256sum | single 100MB text | 0.0646s | 0.0544s | **1.2x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0025s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0035s | **0.9x** |
| md5sum | single 10MB text | 0.0204s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0219s | 0.0167s | **1.3x** |
| md5sum | single 100MB text | 0.1989s | 0.1434s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0022s | **0.5x** |
| md5sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0021s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0137s | 0.0129s | **1.1x** |
| b2sum | single 10MB binary | 0.0149s | 0.0136s | **1.1x** |
| b2sum | single 100MB text | 0.1311s | 0.1193s | **1.1x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0129s | **1.1x** |
| b2sum | -l 128 10MB | 0.0138s | 0.0129s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 10MB text | 0.0096s | 0.0035s | **2.8x** |
| base64 | encode 10MB binary | 0.0103s | 0.0033s | **3.1x** |
| base64 | decode 1MB | 0.0037s | 0.0023s | **1.6x** |
| base64 | decode 10MB | 0.0306s | 0.0140s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0091s | 0.0032s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0027s | **2.7x** |
| sort | lexicographic 1MB | 0.0075s | 0.0029s | **2.6x** |
| sort | lexicographic 10MB random | 0.0509s | 0.0053s | **9.6x** |
| sort | already sorted 10MB | 0.0241s | 0.0051s | **4.7x** |
| sort | reverse sorted 10MB | 0.0239s | 0.0047s | **5.1x** |
| sort | -n numeric 10MB | 0.0730s | 0.0523s | **1.4x** |
| sort | -r reverse 10MB | 0.0505s | 0.0060s | **8.4x** |
| sort | -u unique 10MB | 0.0532s | 0.0121s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0699s | 0.0167s | **4.2x** |
| sort | repetitive 10MB | 0.0413s | 0.0121s | **3.4x** |
| sort | --parallel=4 10MB | 0.0527s | 0.0058s | **9.0x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0023s | **0.8x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0069s | **1.3x** |
| tr | -d digits 10MB | 0.0110s | 0.0136s | **0.8x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0198s | **0.9x** |
| tr | -s spaces 10MB | 0.0167s | 0.0071s | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0066s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0137s | **0.8x** |
| tr | translate binary 10MB | 0.0094s | 0.0111s | **0.8x** |
| uniq | default 10MB many duplicates | 0.0096s | 0.0048s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0034s | **4.8x** |
| uniq | -c count 10MB many dups | 0.0097s | 0.0049s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0068s | **4.3x** |
| uniq | -d duplicates only 10MB | 0.0095s | 0.0047s | **2.0x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0047s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0044s | **3.7x** |
| uniq | repetitive 10MB | 0.0463s | 0.0043s | **10.8x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0018s | **1.0x** |
| tac | reverse 10MB text | 0.0087s | 0.0051s | **1.7x** |
| tac | reverse 100MB text | 0.0832s | 0.0382s | **2.2x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0045s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0083s | **2.0x** |
| tac | custom separator 1MB | 0.0043s | 0.0035s | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0031s | **1.9x** |
| wc | default 10MB text | 0.0545s | 0.0030s | **18.1x** |
| wc | default 100MB text | 0.4840s | 0.0137s | **35.3x** |
| wc | -l 10MB text | 0.0022s | 0.0025s | **0.9x** |
| wc | -w 10MB text | 0.0550s | 0.0092s | **6.0x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0544s | 0.0031s | **17.3x** |
| wc | -L 10MB text | 0.0545s | 0.0107s | **5.1x** |
| wc | default 10MB binary | 0.3187s | 0.0276s | **11.5x** |
| wc | default 10MB repetitive | 0.0733s | 0.0046s | **16.1x** |
| wc | 10 files | 0.0010s | 0.0013s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0229s | 0.0036s | **6.4x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0035s | **6.5x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0049s | **3.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0223s | 0.0072s | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0245s | 0.0054s | **4.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0310s | 0.0074s | **4.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0028s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0025s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0031s | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0097s | **0.9x** |
| sha256sum | single 10MB binary | 0.0093s | 0.0102s | **0.9x** |
| sha256sum | single 100MB text | 0.0751s | 0.0758s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0026s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0040s | **0.7x** |
| md5sum | single 10MB text | 0.0175s | 0.0175s | **1.0x** |
| md5sum | single 10MB binary | 0.0183s | 0.0184s | **1.0x** |
| md5sum | single 100MB text | 0.1607s | 0.1535s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0033s | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0151s | 0.0122s | **1.2x** |
| b2sum | single 10MB binary | 0.0159s | 0.0129s | **1.2x** |
| b2sum | single 100MB text | 0.1427s | 0.1120s | **1.3x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0123s | **1.2x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0123s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | **1.3x** |
| base64 | encode 10MB text | 0.0125s | 0.0047s | **2.7x** |
| base64 | encode 10MB binary | 0.0133s | 0.0052s | **2.6x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | **1.9x** |
| base64 | decode 10MB | 0.0333s | 0.0105s | **3.2x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0046s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0038s | **2.3x** |
| sort | lexicographic 1MB | 0.0088s | 0.0039s | **2.2x** |
| sort | lexicographic 10MB random | 0.0554s | 0.0087s | **6.4x** |
| sort | already sorted 10MB | 0.0266s | 0.0070s | **3.8x** |
| sort | reverse sorted 10MB | 0.0278s | 0.0068s | **4.1x** |
| sort | -n numeric 10MB | 0.0746s | 0.0550s | **1.4x** |
| sort | -r reverse 10MB | 0.0563s | 0.0098s | **5.7x** |
| sort | -u unique 10MB | 0.0590s | 0.0154s | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0676s | 0.0238s | **2.8x** |
| sort | repetitive 10MB | 0.0553s | 0.0161s | **3.4x** |
| sort | --parallel=4 10MB | 0.0553s | 0.0089s | **6.2x** |
| tr | a-z to A-Z 1MB | 0.0029s | 0.0023s | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0062s | **2.1x** |
| tr | -d digits 10MB | 0.0160s | 0.0131s | **1.2x** |
| tr | -d lowercase 10MB | 0.0309s | 0.0122s | **2.5x** |
| tr | -s spaces 10MB | 0.0279s | 0.0066s | **4.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0134s | 0.0065s | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0168s | 0.0133s | **1.3x** |
| tr | translate binary 10MB | 0.0115s | 0.0089s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0048s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0037s | **3.8x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0048s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0085s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0049s | **2.5x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0048s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0051s | **2.8x** |
| uniq | repetitive 10MB | 0.0422s | 0.0053s | **8.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0107s | 0.0056s | **1.9x** |
| tac | reverse 100MB text | 0.1048s | 0.0394s | **2.7x** |
| tac | reverse CSV 10MB | 0.0095s | 0.0052s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0100s | **2.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0039s | **1.5x** |
