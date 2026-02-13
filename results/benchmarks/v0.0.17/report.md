# fcoreutils v0.0.17 — Detailed Results

Generated: 2026-02-13 01:41:50 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 405 | 8 | 98.1% |
| Linux_aarch64 | 413 | 409 | 4 | 99.0% |
| Linux_x86_64 | 413 | 409 | 4 | 99.0% |

**Overall: 1223/1239 (98.7%)**

## Performance

### Darwin_arm64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| cut | -b1-100 10MB CSV | 0.0546s | 0.0034s | **15.9x** |
| cut | -c1-100 10MB CSV | 0.0356s | 0.0068s | **5.3x** |
| cut | -d, -f1 10MB CSV | 0.0229s | 0.0005s | **49.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0356s | 0.0156s | **2.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0465s | 0.0123s | **3.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.1040s | 0.0210s | **4.9x** |
| cut | -d, -f1 100KB text | 0.0100s | 0.0048s | **2.1x** |
| cut | -d, -f1 1MB text | 0.0013s | 0.0066s | **0.2x** |
| cut | -d: -f1 colon file | 0.0055s | 0.0067s | **0.8x** |
| sha256sum | single 100KB text | 0.0082s | 0.0068s | **1.2x** |
| sha256sum | single 1MB text | 0.0078s | 0.0013s | **6.2x** |
| sha256sum | single 10MB text | 0.0481s | 0.0117s | **4.1x** |
| sha256sum | single 10MB binary | 0.0462s | 0.0084s | **5.5x** |
| sha256sum | single 100MB text | 0.3913s | 0.0693s | **5.6x** |
| sha256sum | 10 files | 0.0044s | 0.0020s | **2.2x** |
| sha256sum | 100 files | 0.0078s | 0.0108s | **0.7x** |
| md5sum | single 100KB text | 0.0022s | 0.0025s | **0.9x** |
| md5sum | single 1MB text | 0.0205s | 0.0071s | **2.9x** |
| md5sum | single 10MB text | 0.0264s | 0.0191s | **1.4x** |
| md5sum | single 10MB binary | 0.0242s | 0.0224s | **1.1x** |
| md5sum | single 100MB text | 0.1962s | 0.1786s | **1.1x** |
| md5sum | 10 files | 0.0015s | 0.0021s | **0.7x** |
| md5sum | 100 files | 0.0039s | 0.0057s | **0.7x** |
| b2sum | single 100KB text | 0.0050s | 0.0034s | **1.5x** |
| b2sum | single 1MB text | 0.0032s | 0.0032s | **1.0x** |
| b2sum | single 10MB text | 0.0198s | 0.0126s | **1.6x** |
| b2sum | single 10MB binary | 0.0198s | 0.0141s | **1.4x** |
| b2sum | single 100MB text | 0.1665s | 0.1293s | **1.3x** |
| b2sum | -l 256 10MB | 0.0212s | 0.0161s | **1.3x** |
| b2sum | -l 128 10MB | 0.0233s | 0.0162s | **1.4x** |
| b2sum | 100 files | 0.0052s | 0.0060s | **0.9x** |
| base64 | encode 100KB text | 0.0015s | 0.0020s | **0.7x** |
| base64 | encode 1MB text | 0.0033s | 0.0040s | **0.8x** |
| base64 | encode 10MB text | 0.0191s | 0.0109s | **1.7x** |
| base64 | encode 10MB binary | 0.0162s | 0.0094s | **1.7x** |
| base64 | decode 1MB | 0.0079s | 0.0072s | **1.1x** |
| base64 | decode 10MB | 0.0321s | 0.0154s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0262s | 0.0096s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0099s | **0.8x** |
| sort | lexicographic 1MB | 0.1462s | 0.0114s | **12.8x** |
| sort | lexicographic 10MB random | 0.6110s | 0.0404s | **15.1x** |
| sort | already sorted 10MB | 0.2996s | 0.0101s | **29.7x** |
| sort | reverse sorted 10MB | 0.2612s | 0.0114s | **22.8x** |
| sort | -n numeric 10MB | 0.5487s | 0.0315s | **17.4x** |
| sort | -r reverse 10MB | 0.4636s | 0.0220s | **21.1x** |
| sort | -u unique 10MB | 0.5918s | 0.0242s | **24.4x** |
| sort | -t, -k2 CSV 10MB | 0.7344s | 0.0521s | **14.1x** |
| sort | repetitive 10MB | 0.0855s | 0.0279s | **3.1x** |
| sort | --parallel=4 10MB | 0.8484s | 0.0618s | **13.7x** |
| tr | a-z to A-Z 1MB | 0.0153s | 0.0106s | **1.4x** |
| tr | a-z to A-Z 10MB | 0.0211s | 0.0096s | **2.2x** |
| tr | -d digits 10MB | 0.0257s | 0.0211s | **1.2x** |
| tr | -d lowercase 10MB | 0.0489s | 0.0220s | **2.2x** |
| tr | -s spaces 10MB | 0.0541s | 0.0262s | **2.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0221s | 0.0114s | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0200s | 0.0146s | **1.4x** |
| tr | translate binary 10MB | 0.0152s | 0.0121s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0157s | 0.0061s | **2.6x** |
| uniq | default 10MB sorted (low dup) | 0.0203s | 0.0067s | **3.0x** |
| uniq | -c count 10MB many dups | 0.0106s | 0.0059s | **1.8x** |
| uniq | -c count 10MB sorted | 0.0350s | 0.0094s | **3.7x** |
| uniq | -d duplicates only 10MB | 0.0137s | 0.0064s | **2.1x** |
| uniq | -u unique only 10MB | 0.0114s | 0.0067s | **1.7x** |
| uniq | -i case insensitive 10MB | 0.0197s | 0.0092s | **2.2x** |
| uniq | repetitive 10MB | 0.0398s | 0.0089s | **4.5x** |
| tac | reverse 100KB text | 0.0027s | 0.0054s | **0.5x** |
| tac | reverse 1MB text | 0.0046s | 0.0033s | **1.4x** |
| tac | reverse 10MB text | 0.0150s | 0.0061s | **2.5x** |
| tac | reverse 100MB text | 0.1655s | 0.0637s | **2.6x** |
| tac | reverse CSV 10MB | 0.0171s | 0.0073s | **2.3x** |
| tac | reverse repetitive 10MB | 0.0282s | 0.0140s | **2.0x** |
| tac | custom separator 1MB | 0.0089s | 0.0134s | **0.7x** |

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0040s | 0.0028s | **1.4x** |
| wc | default 10MB text | 0.0336s | 0.0219s | **1.5x** |
| wc | default 100MB text | 0.2923s | 0.1797s | **1.6x** |
| wc | -l 10MB text | 0.0038s | 0.0021s | **1.8x** |
| wc | -w 10MB text | 0.0336s | 0.0203s | **1.7x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0337s | 0.0034s | **9.8x** |
| wc | -L 10MB text | 0.0336s | 0.0155s | **2.2x** |
| wc | default 10MB binary | 0.2355s | 0.0562s | **4.2x** |
| wc | default 10MB repetitive | 0.0524s | 0.0237s | **2.2x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.9x** |
| wc | 100 files | 0.0014s | 0.0019s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0057s | **3.3x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0053s | **3.5x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0034s | **5.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0056s | **3.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0056s | **4.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0067s | **4.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0015s | **2.4x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0009s | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0009s | **1.3x** |
| sha256sum | single 1MB text | 0.0017s | 0.0015s | **1.2x** |
| sha256sum | single 10MB text | 0.0073s | 0.0070s | **1.0x** |
| sha256sum | single 10MB binary | 0.0085s | 0.0075s | **1.1x** |
| sha256sum | single 100MB text | 0.0619s | 0.0600s | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0016s | **0.8x** |
| sha256sum | 100 files | 0.0019s | 0.0025s | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0010s | **1.3x** |
| md5sum | single 1MB text | 0.0033s | 0.0025s | **1.3x** |
| md5sum | single 10MB text | 0.0206s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0224s | 0.0171s | **1.3x** |
| md5sum | single 100MB text | 0.1930s | 0.1492s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0014s | **0.8x** |
| md5sum | 100 files | 0.0018s | 0.0024s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0023s | **1.0x** |
| b2sum | single 10MB text | 0.0136s | 0.0134s | **1.0x** |
| b2sum | single 10MB binary | 0.0151s | 0.0143s | **1.1x** |
| b2sum | single 100MB text | 0.1283s | 0.1238s | **1.0x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0134s | **1.0x** |
| b2sum | -l 128 10MB | 0.0136s | 0.0134s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0021s | **0.8x** |
| base64 | encode 10MB text | 0.0095s | 0.0068s | **1.4x** |
| base64 | encode 10MB binary | 0.0108s | 0.0070s | **1.5x** |
| base64 | decode 1MB | 0.0039s | 0.0027s | **1.4x** |
| base64 | decode 10MB | 0.0296s | 0.0178s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0066s | **1.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0046s | **1.6x** |
| sort | lexicographic 1MB | 0.0079s | 0.0044s | **1.8x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0241s | **2.2x** |
| sort | already sorted 10MB | 0.0243s | 0.0103s | **2.4x** |
| sort | reverse sorted 10MB | 0.0247s | 0.0104s | **2.4x** |
| sort | -n numeric 10MB | 0.0745s | 0.0443s | **1.7x** |
| sort | -r reverse 10MB | 0.0560s | 0.0269s | **2.1x** |
| sort | -u unique 10MB | 0.0597s | 0.0268s | **2.2x** |
| sort | -t, -k2 CSV 10MB | 0.0760s | 0.0436s | **1.7x** |
| sort | repetitive 10MB | 0.0436s | 0.0303s | **1.4x** |
| sort | --parallel=4 10MB | 0.0700s | 0.0375s | **1.9x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0023s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0094s | 0.0063s | **1.5x** |
| tr | -d digits 10MB | 0.0112s | 0.0111s | **1.0x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0183s | **1.0x** |
| tr | -s spaces 10MB | 0.0170s | 0.0211s | **0.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0065s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0112s | **1.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0065s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0045s | **2.1x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0057s | **2.8x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0048s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0073s | **4.0x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0048s | **2.0x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0049s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0060s | **2.7x** |
| uniq | repetitive 10MB | 0.0464s | 0.0070s | **6.6x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | **0.9x** |
| tac | reverse 1MB text | 0.0017s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0085s | 0.0067s | **1.3x** |
| tac | reverse 100MB text | 0.0790s | 0.0367s | **2.2x** |
| tac | reverse CSV 10MB | 0.0085s | 0.0061s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0171s | 0.0101s | **1.7x** |
| tac | custom separator 1MB | 0.0045s | 0.0037s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0059s | 0.0031s | **1.9x** |
| wc | default 10MB text | 0.0543s | 0.0273s | **2.0x** |
| wc | default 100MB text | 0.4789s | 0.2295s | **2.1x** |
| wc | -l 10MB text | 0.0021s | 0.0024s | **0.9x** |
| wc | -w 10MB text | 0.0545s | 0.0252s | **2.2x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0546s | 0.0039s | **14.2x** |
| wc | -L 10MB text | 0.0546s | 0.0138s | **3.9x** |
| wc | default 10MB binary | 0.3197s | 0.0859s | **3.7x** |
| wc | default 10MB repetitive | 0.0730s | 0.0322s | **2.3x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0026s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0057s | **4.0x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0054s | **4.2x** |
| cut | -d, -f1 10MB CSV | 0.0175s | 0.0040s | **4.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0075s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0244s | 0.0073s | **3.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0307s | 0.0106s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0017s | **2.0x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0009s | **1.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.2x** |
| sha256sum | single 10MB text | 0.0087s | 0.0082s | **1.1x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0084s | **1.0x** |
| sha256sum | single 100MB text | 0.0752s | 0.0738s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0016s | **0.9x** |
| sha256sum | 100 files | 0.0024s | 0.0042s | **0.6x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.4x** |
| md5sum | single 1MB text | 0.0029s | 0.0028s | **1.0x** |
| md5sum | single 10MB text | 0.0171s | 0.0202s | **0.8x** |
| md5sum | single 10MB binary | 0.0181s | 0.0211s | **0.9x** |
| md5sum | single 100MB text | 0.1610s | 0.1935s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0016s | **0.8x** |
| md5sum | 100 files | 0.0024s | 0.0042s | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0010s | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0020s | **1.2x** |
| b2sum | single 10MB text | 0.0153s | 0.0119s | **1.3x** |
| b2sum | single 10MB binary | 0.0156s | 0.0124s | **1.3x** |
| b2sum | single 100MB text | 0.1426s | 0.1113s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0119s | **1.3x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0119s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0043s | **0.5x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0021s | **1.0x** |
| base64 | encode 10MB text | 0.0124s | 0.0081s | **1.5x** |
| base64 | encode 10MB binary | 0.0127s | 0.0083s | **1.5x** |
| base64 | decode 1MB | 0.0040s | 0.0032s | **1.2x** |
| base64 | decode 10MB | 0.0326s | 0.0209s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0084s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0052s | **1.6x** |
| sort | lexicographic 1MB | 0.0085s | 0.0041s | **2.1x** |
| sort | lexicographic 10MB random | 0.0543s | 0.0180s | **3.0x** |
| sort | already sorted 10MB | 0.0266s | 0.0121s | **2.2x** |
| sort | reverse sorted 10MB | 0.0280s | 0.0126s | **2.2x** |
| sort | -n numeric 10MB | 0.0745s | 0.0390s | **1.9x** |
| sort | -r reverse 10MB | 0.0546s | 0.0180s | **3.0x** |
| sort | -u unique 10MB | 0.0579s | 0.0185s | **3.1x** |
| sort | -t, -k2 CSV 10MB | 0.0667s | 0.0338s | **2.0x** |
| sort | repetitive 10MB | 0.0550s | 0.0223s | **2.5x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0184s | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0085s | **1.5x** |
| tr | -d digits 10MB | 0.0180s | 0.0146s | **1.2x** |
| tr | -d lowercase 10MB | 0.0314s | 0.0262s | **1.2x** |
| tr | -s spaces 10MB | 0.0264s | 0.0296s | **0.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0083s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0174s | 0.0147s | **1.2x** |
| tr | translate binary 10MB | 0.0120s | 0.0105s | **1.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0043s | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0138s | 0.0042s | **3.3x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0045s | **2.7x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0070s | **4.1x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0046s | **2.6x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0046s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0053s | **2.7x** |
| uniq | repetitive 10MB | 0.0422s | 0.0069s | **6.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0018s | **1.1x** |
| tac | reverse 10MB text | 0.0106s | 0.0044s | **2.4x** |
| tac | reverse 100MB text | 0.1045s | 0.0368s | **2.8x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0047s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0083s | **2.8x** |
| tac | custom separator 1MB | 0.0059s | 0.0043s | **1.4x** |
