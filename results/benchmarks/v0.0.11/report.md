# fcoreutils v0.0.11 — Detailed Results

Generated: 2026-02-13 07:08:10 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 351 | 62 | 85.0% |
| Linux_aarch64 | 413 | 355 | 58 | 86.0% |
| Linux_x86_64 | 354 | 332 | 22 | 93.8% |

**Overall: 1038/1180 (88.0%)**

## Performance

### Darwin_arm64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| sha256sum | single 100KB text | 0.0029s | 0.0003s | **10.6x** |
| sha256sum | single 1MB text | 0.0039s | 0.0010s | **4.0x** |
| sha256sum | single 10MB text | 0.0388s | 0.0074s | **5.3x** |
| sha256sum | single 10MB binary | 0.0428s | 0.0064s | **6.7x** |
| sha256sum | single 100MB text | 0.3693s | 0.0678s | **5.4x** |
| sha256sum | 10 files | 0.0044s | 0.0005s | **9.7x** |
| sha256sum | 100 files | 0.0075s | 0.0016s | **4.8x** |
| md5sum | single 100KB text | 0.0051s | 0.0012s | **4.2x** |
| md5sum | single 1MB text | 0.0024s | 0.0024s | **1.0x** |
| md5sum | single 10MB text | 0.0230s | 0.0236s | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0243s | **0.9x** |
| md5sum | single 100MB text | 0.1817s | 0.1706s | **1.1x** |
| md5sum | 10 files | 0.0005s | 0.0000s | **95.6x** |
| md5sum | 100 files | 0.0079s | 0.0016s | **4.9x** |
| b2sum | single 100KB text | 0.0008s | 0.0055s | **0.1x** |
| b2sum | single 1MB text | 0.0041s | 0.0000s | **100.6x** |
| b2sum | single 10MB text | 0.0304s | 0.0187s | **1.6x** |
| b2sum | single 10MB binary | 0.0232s | 0.0151s | **1.5x** |
| b2sum | single 100MB text | 0.1737s | 0.1219s | **1.4x** |
| b2sum | -l 256 10MB | 0.0195s | 0.0153s | **1.3x** |
| b2sum | -l 128 10MB | 0.0193s | 0.0152s | **1.3x** |
| b2sum | 100 files | 0.0032s | 0.0021s | **1.5x** |
| base64 | encode 100KB text | 0.0057s | 0.0025s | **2.3x** |
| base64 | encode 1MB text | 0.0041s | 0.0000s | **141.8x** |
| base64 | encode 10MB text | 0.0164s | 0.0041s | **4.0x** |
| base64 | encode 10MB binary | 0.0158s | 0.0060s | **2.6x** |
| base64 | decode 1MB | 0.0033s | 0.0008s | **3.9x** |
| base64 | decode 10MB | 0.0276s | 0.0126s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0158s | 0.0051s | **3.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0084s | 0.0043s | **1.9x** |
| sort | lexicographic 1MB | 0.1003s | 0.0116s | **8.7x** |
| sort | lexicographic 10MB random | 0.4086s | 0.0240s | **17.1x** |
| sort | already sorted 10MB | 0.1903s | 0.0094s | **20.4x** |
| sort | reverse sorted 10MB | 0.2069s | 0.0121s | **17.1x** |
| sort | -n numeric 10MB | 0.4444s | 0.0709s | **6.3x** |
| sort | -r reverse 10MB | 0.4090s | 0.0257s | **15.9x** |
| sort | -u unique 10MB | 0.4663s | 0.0463s | **10.1x** |
| sort | -t, -k2 CSV 10MB | 0.5532s | 0.0482s | **11.5x** |
| sort | repetitive 10MB | 0.0739s | 0.0390s | **1.9x** |
| sort | --parallel=4 10MB | 0.4216s | 0.0243s | **17.4x** |
| tr | a-z to A-Z 1MB | 0.0004s | 0.0007s | **0.6x** |
| tr | a-z to A-Z 10MB | 0.0182s | 0.0152s | **1.2x** |
| tr | -d digits 10MB | 0.0319s | 0.0263s | **1.2x** |
| tr | -d lowercase 10MB | 0.0284s | 0.0267s | **1.1x** |
| tr | -s spaces 10MB | 0.0514s | 0.0366s | **1.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0277s | 0.0210s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0296s | 0.0191s | **1.6x** |
| tr | translate binary 10MB | 0.0328s | 0.0320s | **1.0x** |
| uniq | default 10MB many duplicates | 0.0149s | 0.0133s | **1.1x** |
| uniq | default 10MB sorted (low dup) | 0.0356s | 0.0002s | **235.9x** |
| uniq | -c count 10MB many dups | 0.0284s | 0.0105s | **2.7x** |
| uniq | -c count 10MB sorted | 0.0406s | 0.0059s | **6.8x** |
| uniq | -d duplicates only 10MB | 0.0133s | 0.0077s | **1.7x** |
| uniq | -u unique only 10MB | 0.0200s | 0.0067s | **3.0x** |
| uniq | -i case insensitive 10MB | 0.0307s | 0.0070s | **4.4x** |
| uniq | repetitive 10MB | 0.0463s | 0.0047s | **9.8x** |
| tac | reverse 100KB text | 0.0015s | 0.0006s | **2.6x** |
| tac | reverse 1MB text | 0.0252s | 0.0018s | **14.0x** |
| tac | reverse 10MB text | 0.0132s | 0.0184s | **0.7x** |
| tac | reverse 100MB text | 0.1540s | 0.0631s | **2.4x** |
| tac | reverse CSV 10MB | 0.0287s | 0.0065s | **4.4x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0082s | **2.9x** |
| tac | custom separator 1MB | 0.0074s | 0.0060s | **1.2x** |

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0010s | **1.0x** |
| wc | default 1MB text | 0.0036s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0331s | 0.0193s | **1.7x** |
| wc | default 100MB text | 0.2885s | 0.1533s | **1.9x** |
| wc | -l 10MB text | 0.0033s | 0.0017s | **1.9x** |
| wc | -w 10MB text | 0.0330s | 0.0172s | **1.9x** |
| wc | -c 10MB text | 0.0007s | 0.0007s | **0.9x** |
| wc | -m 10MB text | 0.0330s | 0.0031s | **10.7x** |
| wc | -L 10MB text | 0.0329s | 0.0145s | **2.3x** |
| wc | default 10MB binary | 0.2346s | 0.0540s | **4.3x** |
| wc | default 10MB repetitive | 0.0518s | 0.0228s | **2.3x** |
| wc | 10 files | 0.0007s | 0.0008s | **0.9x** |
| wc | 100 files | 0.0011s | 0.0013s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0033s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0180s | 0.0032s | **5.6x** |
| cut | -d, -f1 10MB CSV | 0.0181s | 0.0023s | **7.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0207s | 0.0041s | **5.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0226s | 0.0042s | **5.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0261s | 0.0056s | **4.7x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0012s | **2.7x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0007s | **0.9x** |
| sha256sum | single 100KB text | 0.0010s | 0.0008s | **1.3x** |
| sha256sum | single 1MB text | 0.0016s | 0.0014s | **1.1x** |
| sha256sum | single 10MB text | 0.0066s | 0.0067s | **1.0x** |
| sha256sum | single 10MB binary | 0.0071s | 0.0072s | **1.0x** |
| sha256sum | single 100MB text | 0.0563s | 0.0595s | **0.9x** |
| sha256sum | 10 files | 0.0011s | 0.0011s | **0.9x** |
| sha256sum | 100 files | 0.0016s | 0.0016s | **1.0x** |
| md5sum | single 100KB text | 0.0012s | 0.0009s | **1.4x** |
| md5sum | single 1MB text | 0.0029s | 0.0022s | **1.3x** |
| md5sum | single 10MB text | 0.0198s | 0.0157s | **1.3x** |
| md5sum | single 10MB binary | 0.0212s | 0.0164s | **1.3x** |
| md5sum | single 100MB text | 0.1884s | 0.1488s | **1.3x** |
| md5sum | 10 files | 0.0010s | 0.0011s | **0.9x** |
| md5sum | 100 files | 0.0015s | 0.0016s | **0.9x** |
| b2sum | single 100KB text | 0.0008s | 0.0008s | **0.9x** |
| b2sum | single 1MB text | 0.0019s | 0.0020s | **1.0x** |
| b2sum | single 10MB text | 0.0130s | 0.0126s | **1.0x** |
| b2sum | single 10MB binary | 0.0140s | 0.0133s | **1.1x** |
| b2sum | single 100MB text | 0.1226s | 0.1186s | **1.0x** |
| b2sum | -l 256 10MB | 0.0130s | 0.0126s | **1.0x** |
| b2sum | -l 128 10MB | 0.0130s | 0.0126s | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0016s | **0.9x** |
| base64 | encode 100KB text | 0.0008s | 0.0008s | **0.9x** |
| base64 | encode 1MB text | 0.0015s | 0.0017s | **0.9x** |
| base64 | encode 10MB text | 0.0086s | 0.0071s | **1.2x** |
| base64 | encode 10MB binary | 0.0093s | 0.0074s | **1.3x** |
| base64 | decode 1MB | 0.0036s | 0.0024s | **1.5x** |
| base64 | decode 10MB | 0.0297s | 0.0170s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0084s | 0.0069s | **1.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0065s | 0.0050s | **1.3x** |
| sort | lexicographic 1MB | 0.0071s | 0.0042s | **1.7x** |
| sort | lexicographic 10MB random | 0.0492s | 0.0147s | **3.3x** |
| sort | already sorted 10MB | 0.0239s | 0.0086s | **2.8x** |
| sort | reverse sorted 10MB | 0.0235s | 0.0088s | **2.7x** |
| sort | -n numeric 10MB | 0.0665s | 0.0288s | **2.3x** |
| sort | -r reverse 10MB | 0.0502s | 0.0147s | **3.4x** |
| sort | -u unique 10MB | 0.0521s | 0.0156s | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0679s | 0.0283s | **2.4x** |
| sort | repetitive 10MB | 0.0404s | 0.0192s | **2.1x** |
| sort | --parallel=4 10MB | 0.0486s | 0.0147s | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0024s | **0.7x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0102s | **0.9x** |
| tr | -d digits 10MB | 0.0109s | 0.0141s | **0.8x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0213s | **0.9x** |
| tr | -s spaces 10MB | 0.0165s | 0.0253s | **0.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0103s | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0108s | 0.0142s | **0.8x** |
| tr | translate binary 10MB | 0.0092s | 0.0122s | **0.8x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0045s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0053s | **3.1x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0045s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0061s | **4.8x** |
| uniq | -d duplicates only 10MB | 0.0088s | 0.0045s | **2.0x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0044s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0054s | **3.0x** |
| uniq | repetitive 10MB | 0.0459s | 0.0067s | **6.9x** |
| tac | reverse 100KB text | 0.0007s | 0.0008s | **0.9x** |
| tac | reverse 1MB text | 0.0015s | 0.0015s | **1.0x** |
| tac | reverse 10MB text | 0.0077s | 0.0048s | **1.6x** |
| tac | reverse 100MB text | 0.0760s | 0.0424s | **1.8x** |
| tac | reverse CSV 10MB | 0.0074s | 0.0046s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0161s | 0.0091s | **1.8x** |
| tac | custom separator 1MB | 0.0040s | 0.0037s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0030s | **1.9x** |
| wc | default 10MB text | 0.0543s | 0.0244s | **2.2x** |
| wc | default 100MB text | 0.4823s | 0.2017s | **2.4x** |
| wc | -l 10MB text | 0.0020s | 0.0019s | **1.1x** |
| wc | -w 10MB text | 0.0541s | 0.0222s | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0541s | 0.0032s | **16.8x** |
| wc | -L 10MB text | 0.0541s | 0.0150s | **3.6x** |
| wc | default 10MB binary | 0.3164s | 0.0816s | **3.9x** |
| wc | default 10MB repetitive | 0.0727s | 0.0268s | **2.7x** |
| wc | 10 files | 0.0010s | 0.0009s | **1.1x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0046s | **4.9x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0045s | **5.0x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0032s | **5.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0072s | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0063s | **3.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0095s | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0008s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0014s | **2.4x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0008s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0009s | **1.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.3x** |
| sha256sum | single 10MB text | 0.0085s | 0.0078s | **1.1x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0082s | **1.1x** |
| sha256sum | single 100MB text | 0.0741s | 0.0711s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0024s | **1.0x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.4x** |
| md5sum | single 1MB text | 0.0028s | 0.0027s | **1.0x** |
| md5sum | single 10MB text | 0.0170s | 0.0199s | **0.9x** |
| md5sum | single 10MB binary | 0.0176s | 0.0208s | **0.8x** |
| md5sum | single 100MB text | 0.1600s | 0.1911s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0014s | **1.0x** |
| md5sum | 100 files | 0.0023s | 0.0024s | **1.0x** |
| b2sum | single 100KB text | 0.0010s | 0.0010s | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0019s | **1.2x** |
| b2sum | single 10MB text | 0.0148s | 0.0116s | **1.3x** |
| b2sum | single 10MB binary | 0.0154s | 0.0121s | **1.3x** |
| b2sum | single 100MB text | 0.1416s | 0.1087s | **1.3x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0116s | **1.3x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0117s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0024s | **0.9x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0020s | **1.0x** |
| base64 | encode 10MB text | 0.0122s | 0.0053s | **2.3x** |
| base64 | encode 10MB binary | 0.0127s | 0.0055s | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0032s | **1.2x** |
| base64 | decode 10MB | 0.0326s | 0.0204s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0054s | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0035s | **2.5x** |
| sort | lexicographic 1MB | 0.0085s | 0.0049s | **1.7x** |
| sort | lexicographic 10MB random | 0.0537s | 0.0169s | **3.2x** |
| sort | already sorted 10MB | 0.0262s | 0.0111s | **2.4x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0109s | **2.5x** |
| sort | -n numeric 10MB | 0.0730s | 0.0381s | **1.9x** |
| sort | -r reverse 10MB | 0.0552s | 0.0171s | **3.2x** |
| sort | -u unique 10MB | 0.0572s | 0.0171s | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0659s | 0.0320s | **2.1x** |
| sort | repetitive 10MB | 0.0545s | 0.0181s | **3.0x** |
| sort | --parallel=4 10MB | 0.0538s | 0.0170s | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0024s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0123s | 0.0145s | **0.8x** |
| tr | -d digits 10MB | 0.0161s | 0.0175s | **0.9x** |
| tr | -d lowercase 10MB | 0.0305s | 0.0297s | **1.0x** |
| tr | -s spaces 10MB | 0.0295s | 0.0380s | **0.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0122s | 0.0145s | **0.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0184s | 0.0175s | **1.1x** |
| tr | translate binary 10MB | 0.0124s | 0.0157s | **0.8x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0043s | **2.8x** |
| uniq | default 10MB sorted (low dup) | 0.0138s | 0.0065s | **2.1x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0045s | **2.7x** |
| uniq | -c count 10MB sorted | 0.0289s | 0.0065s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0044s | **2.7x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0046s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0138s | 0.0051s | **2.7x** |
| uniq | repetitive 10MB | 0.0424s | 0.0064s | **6.7x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | **1.0x** |
| tac | reverse 10MB text | 0.0105s | 0.0054s | **2.0x** |
| tac | reverse 100MB text | 0.1023s | 0.0446s | **2.3x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0055s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0229s | 0.0105s | **2.2x** |
| tac | custom separator 1MB | 0.0060s | 0.0054s | **1.1x** |
