# fcoreutils v0.2.3 — Detailed Results

Generated: 2026-02-14 22:35:44 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 826/826 (100.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0339s | 0.0061s | 0.0251s | **5.6x** | **4.1x** |
| wc | default 100MB text | 0.2989s | 0.0432s | 0.2269s | **6.9x** | **5.2x** |
| wc | -l 10MB text | 0.0037s | 0.0020s | 0.0023s | **1.8x** | **1.1x** |
| wc | -w 10MB text | 0.0339s | 0.0062s | 0.0224s | **5.5x** | **3.6x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0339s | 0.0021s | 0.0021s | **16.1x** | **1.0x** |
| wc | -L 10MB text | 0.0338s | 0.0061s | 0.0171s | **5.5x** | **2.8x** |
| wc | default 10MB binary | 0.2351s | 0.0167s | 0.1181s | **14.0x** | **7.1x** |
| wc | default 10MB repetitive | 0.0540s | 0.0080s | 0.0370s | **6.8x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0039s | 0.0058s | **4.7x** | **1.5x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0039s | 0.0061s | **4.6x** | **1.5x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0042s | 0.0068s | **4.4x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0049s | 0.0162s | **4.3x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0228s | 0.0034s | 0.0126s | **6.8x** | **3.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0261s | 0.0034s | 0.0159s | **7.7x** | **4.7x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0021s | 0.0017s | **1.6x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0009s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0025s | 0.0036s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0070s | 0.0071s | 0.0270s | **1.0x** | **3.8x** |
| sha256sum | single 10MB binary | 0.0074s | 0.0075s | 0.0284s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0682s | 0.0553s | 0.2628s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0012s | 0.0018s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0016s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0203s | 0.0159s | 0.0169s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0215s | 0.0168s | 0.0180s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2005s | 0.1434s | 0.1659s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0018s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0020s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | 0.0023s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0133s | 0.0123s | 0.0132s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0140s | 0.0130s | 0.0139s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1350s | 0.1154s | 0.1288s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0136s | 0.0124s | 0.0129s | **1.1x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0124s | 0.0132s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0018s | 0.0017s | **0.9x** | **0.9x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0009s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0093s | 0.0033s | 0.0068s | **2.9x** | **2.1x** |
| base64 | encode 10MB binary | 0.0098s | 0.0036s | 0.0073s | **2.7x** | **2.0x** |
| base64 | decode 1MB | 0.0037s | 0.0016s | 0.0035s | **2.3x** | **2.1x** |
| base64 | decode 10MB | 0.0302s | 0.0053s | 0.0262s | **5.6x** | **4.9x** |
| base64 | encode -w 76 10MB | 0.0092s | 0.0033s | 0.0069s | **2.8x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0069s | 0.0029s | 0.0068s | **2.4x** | **2.3x** |
| sort | lexicographic 1MB | 0.0074s | 0.0026s | 0.0042s | **2.9x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0512s | 0.0061s | 0.0283s | **8.4x** | **4.6x** |
| sort | already sorted 10MB | 0.0242s | 0.0033s | 0.0129s | **7.4x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0045s | 0.0136s | **5.5x** | **3.0x** |
| sort | -n numeric 10MB | 0.0696s | 0.0038s | 0.0611s | **18.2x** | **15.9x** |
| sort | -r reverse 10MB | 0.0527s | 0.0064s | 0.0288s | **8.2x** | **4.5x** |
| sort | -u unique 10MB | 0.0547s | 0.0083s | 0.0349s | **6.6x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0711s | 0.0144s | 0.0682s | **5.0x** | **4.7x** |
| sort | repetitive 10MB | 0.0457s | 0.0102s | 0.0360s | **4.5x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0510s | 0.0064s | 0.0287s | **8.0x** | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0051s | 0.0069s | **1.8x** | **1.4x** |
| tr | -d digits 10MB | 0.0114s | 0.0067s | 0.0101s | **1.7x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0086s | 0.0174s | **2.2x** | **2.0x** |
| tr | -s spaces 10MB | 0.0169s | 0.0049s | 0.0115s | **3.5x** | **2.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0048s | 0.0068s | **1.8x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0068s | 0.0102s | **1.7x** | **1.5x** |
| tr | translate binary 10MB | 0.0092s | 0.0050s | 0.0078s | **1.8x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0027s | 0.0087s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0031s | 0.0095s | **5.3x** | **3.1x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0030s | 0.0085s | **3.0x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0068s | 0.0112s | **4.3x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0027s | 0.0086s | **3.3x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0027s | 0.0086s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0040s | 0.0094s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0482s | 0.0038s | 0.0144s | **12.7x** | **3.8x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0020s | 0.0015s | **0.8x** | **0.8x** |
| tac | reverse 10MB text | 0.0083s | 0.0030s | 0.0049s | **2.7x** | **1.6x** |
| tac | reverse 100MB text | 0.0847s | 0.0198s | 0.0426s | **4.3x** | **2.2x** |
| tac | reverse CSV 10MB | 0.0079s | 0.0030s | 0.0045s | **2.7x** | **1.5x** |
| tac | reverse repetitive 10MB | 0.0184s | 0.0051s | 0.0086s | **3.6x** | **1.7x** |
| tac | custom separator 1MB | 0.0043s | 0.0028s | 0.0038s | **1.5x** | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0045s | 0.0031s | 0.0039s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0428s | 0.0026s | 0.0340s | **16.4x** | **13.1x** |
| wc | default 100MB text | 0.3789s | 0.0113s | 0.2915s | **33.4x** | **25.7x** |
| wc | -l 10MB text | 0.0014s | 0.0021s | 0.0018s | **0.7x** | **0.8x** |
| wc | -w 10MB text | 0.0430s | 0.0096s | 0.0297s | **4.5x** | **3.1x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0009s | **0.7x** | **1.0x** |
| wc | -m 10MB text | 0.0430s | 0.0023s | 0.0016s | **18.4x** | **0.7x** |
| wc | -L 10MB text | 0.0428s | 0.0103s | 0.0157s | **4.2x** | **1.5x** |
| wc | default 10MB binary | 0.3213s | 0.0309s | 0.1560s | **10.4x** | **5.0x** |
| wc | default 10MB repetitive | 0.0560s | 0.0036s | 0.0388s | **15.5x** | **10.7x** |
| wc | 10 files | 0.0007s | 0.0010s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0011s | 0.0013s | 0.0014s | **0.8x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0192s | 0.0041s | 0.0055s | **4.6x** | **1.3x** |
| cut | -c1-100 10MB CSV | 0.0193s | 0.0042s | 0.0054s | **4.6x** | **1.3x** |
| cut | -d, -f1 10MB CSV | 0.0207s | 0.0050s | 0.0069s | **4.1x** | **1.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0239s | 0.0070s | 0.0153s | **3.4x** | **2.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0263s | 0.0052s | 0.0117s | **5.0x** | **2.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0298s | 0.0046s | 0.0147s | **6.4x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0010s | 0.0008s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0039s | 0.0027s | 0.0016s | **1.4x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0010s | 0.0008s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0010s | 0.0021s | 0.0010s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0018s | 0.0028s | 0.0018s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0093s | 0.0100s | 0.0093s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0100s | 0.0104s | 0.0096s | **1.0x** | **0.9x** |
| sha256sum | single 100MB text | 0.0894s | 0.0845s | 0.0887s | **1.1x** | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0019s | 0.0010s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0015s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 100KB text | 0.0011s | 0.0021s | 0.0011s | **0.5x** | **0.5x** |
| md5sum | single 1MB text | 0.0025s | 0.0035s | 0.0029s | **0.7x** | **0.8x** |
| md5sum | single 10MB text | 0.0159s | 0.0156s | 0.0200s | **1.0x** | **1.3x** |
| md5sum | single 10MB binary | 0.0168s | 0.0168s | 0.0213s | **1.0x** | **1.3x** |
| md5sum | single 100MB text | 0.1510s | 0.1388s | 0.1935s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0010s | 0.0021s | 0.0010s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0020s | 0.0020s | **1.0x** | **1.0x** |
| b2sum | single 10MB text | 0.0141s | 0.0105s | 0.0113s | **1.3x** | **1.1x** |
| b2sum | single 10MB binary | 0.0146s | 0.0109s | 0.0115s | **1.3x** | **1.0x** |
| b2sum | single 100MB text | 0.1361s | 0.0974s | 0.1042s | **1.4x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0106s | 0.0110s | **1.4x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0105s | 0.0109s | **1.4x** | **1.0x** |
| b2sum | 100 files | 0.0014s | 0.0020s | 0.0014s | **0.7x** | **0.7x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0009s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0012s | **1.1x** | **0.9x** |
| base64 | encode 10MB text | 0.0106s | 0.0046s | 0.0047s | **2.3x** | **1.0x** |
| base64 | encode 10MB binary | 0.0108s | 0.0048s | 0.0047s | **2.2x** | **1.0x** |
| base64 | decode 1MB | 0.0036s | 0.0014s | 0.0034s | **2.6x** | **2.5x** |
| base64 | decode 10MB | 0.0302s | 0.0068s | 0.0270s | **4.4x** | **4.0x** |
| base64 | encode -w 76 10MB | 0.0104s | 0.0048s | 0.0046s | **2.2x** | **1.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0084s | 0.0038s | 0.0047s | **2.2x** | **1.3x** |
| sort | lexicographic 1MB | 0.0074s | 0.0034s | 0.0045s | **2.2x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0519s | 0.0107s | 0.0315s | **4.8x** | **2.9x** |
| sort | already sorted 10MB | 0.0231s | 0.0044s | 0.0139s | **5.3x** | **3.2x** |
| sort | reverse sorted 10MB | 0.0233s | 0.0075s | 0.0140s | **3.1x** | **1.9x** |
| sort | -n numeric 10MB | 0.0712s | 0.0066s | 0.0654s | **10.9x** | **10.0x** |
| sort | -r reverse 10MB | 0.0512s | 0.0104s | 0.0320s | **4.9x** | **3.1x** |
| sort | -u unique 10MB | 0.0551s | 0.0109s | 0.0383s | **5.1x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0659s | 0.0205s | 0.0775s | **3.2x** | **3.8x** |
| sort | repetitive 10MB | 0.0502s | 0.0128s | 0.0325s | **3.9x** | **2.5x** |
| sort | --parallel=4 10MB | 0.0514s | 0.0110s | 0.0318s | **4.7x** | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0015s | 0.0015s | 0.0016s | **1.0x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0080s | 0.0052s | 0.0063s | **1.5x** | **1.2x** |
| tr | -d digits 10MB | 0.0157s | 0.0084s | 0.0132s | **1.9x** | **1.6x** |
| tr | -d lowercase 10MB | 0.0277s | 0.0100s | 0.0230s | **2.8x** | **2.3x** |
| tr | -s spaces 10MB | 0.0235s | 0.0051s | 0.0281s | **4.6x** | **5.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0076s | 0.0054s | 0.0062s | **1.4x** | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0156s | 0.0081s | 0.0133s | **1.9x** | **1.7x** |
| tr | translate binary 10MB | 0.0080s | 0.0055s | 0.0077s | **1.4x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0086s | 0.0027s | 0.0094s | **3.2x** | **3.5x** |
| uniq | default 10MB sorted (low dup) | 0.0186s | 0.0043s | 0.0124s | **4.4x** | **2.9x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0028s | 0.0094s | **3.3x** | **3.4x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0090s | 0.0136s | **3.3x** | **1.5x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0030s | 0.0094s | **3.0x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0028s | 0.0094s | **3.3x** | **3.4x** |
| uniq | -i case insensitive 10MB | 0.0185s | 0.0044s | 0.0125s | **4.2x** | **2.8x** |
| uniq | repetitive 10MB | 0.0494s | 0.0038s | 0.0141s | **13.1x** | **3.7x** |
| tac | reverse 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0014s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| tac | reverse 10MB text | 0.0079s | 0.0041s | 0.0045s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0809s | 0.0260s | 0.0429s | **3.1x** | **1.6x** |
| tac | reverse CSV 10MB | 0.0076s | 0.0036s | 0.0044s | **2.1x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0147s | 0.0076s | 0.0084s | **1.9x** | **1.1x** |
| tac | custom separator 1MB | 0.0049s | 0.0036s | 0.0037s | **1.3x** | **1.0x** |
