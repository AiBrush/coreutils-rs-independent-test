# fcoreutils v0.0.33 — Detailed Results

Generated: 2026-02-14 21:38:47 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 412 | 1 | 99.8% |

**Overall: 1231/1239 (99.4%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0013s | **0.9x** |
| wc | default 1MB text | 0.0040s | 0.0028s | **1.4x** |
| wc | default 10MB text | 0.0347s | 0.0178s | **1.9x** |
| wc | default 100MB text | 0.2928s | 0.0402s | **7.3x** |
| wc | -l 10MB text | 0.0049s | 0.0027s | **1.8x** |
| wc | -w 10MB text | 0.0347s | 0.0173s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0346s | 0.0023s | **15.3x** |
| wc | -L 10MB text | 0.0346s | 0.0170s | **2.0x** |
| wc | default 10MB binary | 0.2341s | 0.0593s | **3.9x** |
| wc | default 10MB repetitive | 0.0543s | 0.0072s | **7.6x** |
| wc | 10 files | 0.0008s | 0.0012s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0016s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0034s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0033s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0047s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0050s | **4.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0236s | 0.0041s | **5.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0268s | 0.0053s | **5.0x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0028s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0011s | **1.1x** |
| sha256sum | single 1MB text | 0.0019s | 0.0020s | **1.0x** |
| sha256sum | single 10MB text | 0.0083s | 0.0081s | **1.0x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0074s | **1.0x** |
| sha256sum | single 100MB text | 0.0616s | 0.0594s | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0012s | **1.0x** |
| sha256sum | 100 files | 0.0018s | 0.0016s | **1.1x** |
| md5sum | single 100KB text | 0.0013s | 0.0013s | **1.0x** |
| md5sum | single 1MB text | 0.0031s | 0.0028s | **1.1x** |
| md5sum | single 10MB text | 0.0215s | 0.0178s | **1.2x** |
| md5sum | single 10MB binary | 0.0214s | 0.0178s | **1.2x** |
| md5sum | single 100MB text | 0.1933s | 0.1562s | **1.2x** |
| md5sum | 10 files | 0.0013s | 0.0011s | **1.1x** |
| md5sum | 100 files | 0.0017s | 0.0016s | **1.1x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0022s | 0.0025s | **0.9x** |
| b2sum | single 10MB text | 0.0147s | 0.0142s | **1.0x** |
| b2sum | single 10MB binary | 0.0141s | 0.0138s | **1.0x** |
| b2sum | single 100MB text | 0.1279s | 0.1203s | **1.1x** |
| b2sum | -l 256 10MB | 0.0146s | 0.0141s | **1.0x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0142s | **1.0x** |
| b2sum | 100 files | 0.0018s | 0.0017s | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0018s | **1.0x** |
| base64 | encode 10MB text | 0.0104s | 0.0052s | **2.0x** |
| base64 | encode 10MB binary | 0.0100s | 0.0052s | **1.9x** |
| base64 | decode 1MB | 0.0038s | 0.0026s | **1.5x** |
| base64 | decode 10MB | 0.0309s | 0.0148s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0103s | 0.0050s | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0045s | **1.8x** |
| sort | lexicographic 1MB | 0.0076s | 0.0044s | **1.7x** |
| sort | lexicographic 10MB random | 0.0545s | 0.0138s | **4.0x** |
| sort | already sorted 10MB | 0.0250s | 0.0055s | **4.6x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0077s | **3.2x** |
| sort | -n numeric 10MB | 0.0737s | 0.0265s | **2.8x** |
| sort | -r reverse 10MB | 0.0547s | 0.0141s | **3.9x** |
| sort | -u unique 10MB | 0.0566s | 0.0145s | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0739s | 0.0468s | **1.6x** |
| sort | repetitive 10MB | 0.0461s | 0.0132s | **3.5x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0141s | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0021s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0066s | **1.3x** |
| tr | -d digits 10MB | 0.0112s | 0.0098s | **1.1x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0169s | **1.1x** |
| tr | -s spaces 10MB | 0.0166s | 0.0140s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0067s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0099s | **1.1x** |
| tr | translate binary 10MB | 0.0097s | 0.0070s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0048s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0047s | **3.5x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0062s | **1.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0077s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0049s | **1.9x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0049s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0059s | **2.8x** |
| uniq | repetitive 10MB | 0.0489s | 0.0076s | **6.5x** |
| tac | reverse 100KB text | 0.0009s | 0.0013s | **0.7x** |
| tac | reverse 1MB text | 0.0017s | 0.0018s | **0.9x** |
| tac | reverse 10MB text | 0.0093s | 0.0057s | **1.6x** |
| tac | reverse 100MB text | 0.0794s | 0.0396s | **2.0x** |
| tac | reverse CSV 10MB | 0.0086s | 0.0056s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0194s | 0.0114s | **1.7x** |
| tac | custom separator 1MB | 0.0046s | 0.0044s | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0059s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0575s | 0.0205s | **2.8x** |
| wc | default 100MB text | 0.4850s | 0.0735s | **6.6x** |
| wc | -l 10MB text | 0.0026s | 0.0025s | **1.0x** |
| wc | -w 10MB text | 0.0548s | 0.0205s | **2.7x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0549s | 0.0023s | **23.6x** |
| wc | -L 10MB text | 0.0550s | 0.0237s | **2.3x** |
| wc | default 10MB binary | 0.3162s | 0.0822s | **3.8x** |
| wc | default 10MB repetitive | 0.0735s | 0.0129s | **5.7x** |
| wc | 10 files | 0.0010s | 0.0013s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0231s | 0.0044s | **5.3x** |
| cut | -c1-100 10MB CSV | 0.0232s | 0.0043s | **5.3x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0064s | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0225s | 0.0084s | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0255s | 0.0076s | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0092s | **3.4x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0030s | **1.1x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0012s | **1.2x** |
| sha256sum | single 1MB text | 0.0021s | 0.0019s | **1.1x** |
| sha256sum | single 10MB text | 0.0087s | 0.0084s | **1.0x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0088s | **1.0x** |
| sha256sum | single 100MB text | 0.0758s | 0.0732s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0011s | **1.2x** |
| sha256sum | 100 files | 0.0025s | 0.0019s | **1.3x** |
| md5sum | single 100KB text | 0.0015s | 0.0013s | **1.1x** |
| md5sum | single 1MB text | 0.0030s | 0.0031s | **1.0x** |
| md5sum | single 10MB text | 0.0176s | 0.0207s | **0.9x** |
| md5sum | single 10MB binary | 0.0183s | 0.0217s | **0.8x** |
| md5sum | single 100MB text | 0.1615s | 0.1930s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0012s | **1.2x** |
| md5sum | 100 files | 0.0024s | 0.0020s | **1.2x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0023s | **1.0x** |
| b2sum | single 10MB text | 0.0153s | 0.0123s | **1.2x** |
| b2sum | single 10MB binary | 0.0160s | 0.0128s | **1.2x** |
| b2sum | single 100MB text | 0.1433s | 0.1110s | **1.3x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0123s | **1.2x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0123s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0021s | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0021s | 0.0017s | **1.2x** |
| base64 | encode 10MB text | 0.0127s | 0.0046s | **2.8x** |
| base64 | encode 10MB binary | 0.0131s | 0.0048s | **2.7x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | **1.8x** |
| base64 | decode 10MB | 0.0333s | 0.0123s | **2.7x** |
| base64 | encode -w 76 10MB | 0.0129s | 0.0047s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0091s | 0.0036s | **2.5x** |
| sort | lexicographic 1MB | 0.0086s | 0.0049s | **1.8x** |
| sort | lexicographic 10MB random | 0.0555s | 0.0120s | **4.6x** |
| sort | already sorted 10MB | 0.0277s | 0.0071s | **3.9x** |
| sort | reverse sorted 10MB | 0.0275s | 0.0102s | **2.7x** |
| sort | -n numeric 10MB | 0.0746s | 0.0301s | **2.5x** |
| sort | -r reverse 10MB | 0.0555s | 0.0122s | **4.6x** |
| sort | -u unique 10MB | 0.0580s | 0.0123s | **4.7x** |
| sort | -t, -k2 CSV 10MB | 0.0678s | 0.0404s | **1.7x** |
| sort | repetitive 10MB | 0.0572s | 0.0172s | **3.3x** |
| sort | --parallel=4 10MB | 0.0557s | 0.0121s | **4.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0020s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0135s | 0.0057s | **2.4x** |
| tr | -d digits 10MB | 0.0182s | 0.0125s | **1.5x** |
| tr | -d lowercase 10MB | 0.0300s | 0.0213s | **1.4x** |
| tr | -s spaces 10MB | 0.0258s | 0.0141s | **1.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0135s | 0.0057s | **2.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0161s | 0.0123s | **1.3x** |
| tr | translate binary 10MB | 0.0118s | 0.0057s | **2.1x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0062s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0064s | **2.2x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0075s | **1.6x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0102s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0059s | **2.1x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0059s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0075s | **1.9x** |
| uniq | repetitive 10MB | 0.0423s | 0.0084s | **5.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0019s | **1.1x** |
| tac | reverse 10MB text | 0.0106s | 0.0072s | **1.5x** |
| tac | reverse 100MB text | 0.1041s | 0.0501s | **2.1x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0072s | **1.3x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0131s | **1.8x** |
| tac | custom separator 1MB | 0.0060s | 0.0047s | **1.3x** |
