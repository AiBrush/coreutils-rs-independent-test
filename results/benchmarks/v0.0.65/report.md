# fcoreutils v0.0.65 — Detailed Results

Generated: 2026-02-14 12:25:10 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 397 | 16 | 96.1% |
| Linux_x86_64 | 413 | 397 | 16 | 96.1% |

**Overall: 794/826 (96.1%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0037s | 0.0025s | **1.5x** |
| wc | default 10MB text | 0.0342s | 0.0071s | **4.9x** |
| wc | default 100MB text | 0.2936s | 0.0446s | **6.6x** |
| wc | -l 10MB text | 0.0043s | 0.0022s | **2.0x** |
| wc | -w 10MB text | 0.0346s | 0.0060s | **5.8x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0342s | 0.0023s | **15.0x** |
| wc | -L 10MB text | 0.0341s | 0.0063s | **5.4x** |
| wc | default 10MB binary | 0.2342s | 0.0169s | **13.8x** |
| wc | default 10MB repetitive | 0.0503s | 0.0079s | **6.4x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.8x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0032s | **5.7x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0031s | **5.9x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0044s | **4.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0042s | **5.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0036s | **6.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0048s | **5.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | **0.8x** |
| sha256sum | single 100KB text | 0.0010s | 0.0021s | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | **0.6x** |
| sha256sum | single 10MB text | 0.0075s | 0.0074s | **1.0x** |
| sha256sum | single 10MB binary | 0.0071s | 0.0074s | **1.0x** |
| sha256sum | single 100MB text | 0.0621s | 0.0543s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0035s | **0.9x** |
| md5sum | single 10MB text | 0.0212s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0211s | 0.0166s | **1.3x** |
| md5sum | single 100MB text | 0.1941s | 0.1418s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0025s | **0.7x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | **0.8x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | **0.9x** |
| b2sum | single 10MB text | 0.0137s | 0.0124s | **1.1x** |
| b2sum | single 10MB binary | 0.0137s | 0.0129s | **1.1x** |
| b2sum | single 100MB text | 0.1277s | 0.1137s | **1.1x** |
| b2sum | -l 256 10MB | 0.0134s | 0.0125s | **1.1x** |
| b2sum | -l 128 10MB | 0.0138s | 0.0124s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0014s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0015s | 0.0013s | **1.1x** |
| base64 | encode 10MB text | 0.0093s | 0.0049s | **1.9x** |
| base64 | encode 10MB binary | 0.0094s | 0.0049s | **1.9x** |
| base64 | decode 1MB | 0.0036s | 0.0022s | **1.7x** |
| base64 | decode 10MB | 0.0302s | 0.0111s | **2.7x** |
| base64 | encode -w 76 10MB | 0.0094s | 0.0050s | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0046s | **1.6x** |
| sort | lexicographic 1MB | 0.0075s | 0.0026s | **2.9x** |
| sort | lexicographic 10MB random | 0.0515s | 0.0061s | **8.4x** |
| sort | already sorted 10MB | 0.0238s | 0.0037s | **6.4x** |
| sort | reverse sorted 10MB | 0.0237s | 0.0051s | **4.6x** |
| sort | -n numeric 10MB | 0.0692s | 0.0487s | **1.4x** |
| sort | -r reverse 10MB | 0.0520s | 0.0063s | **8.2x** |
| sort | -u unique 10MB | 0.0538s | 0.0126s | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0699s | 0.0169s | **4.1x** |
| sort | repetitive 10MB | 0.0411s | 0.0077s | **5.3x** |
| sort | --parallel=4 10MB | 0.0506s | 0.0060s | **8.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0028s | **0.6x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0191s | **0.5x** |
| tr | -d digits 10MB | 0.0112s | 0.0131s | **0.9x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0203s | **0.9x** |
| tr | -s spaces 10MB | 0.0168s | 0.0070s | **2.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0197s | **0.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0136s | **0.8x** |
| tr | translate binary 10MB | 0.0094s | 0.0161s | **0.6x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0160s | 0.0027s | **6.0x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0048s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0288s | 0.0058s | **5.0x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0047s | **1.9x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0159s | 0.0042s | **3.8x** |
| uniq | repetitive 10MB | 0.0462s | 0.0040s | **11.6x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0018s | **0.9x** |
| tac | reverse 10MB text | 0.0083s | 0.0052s | **1.6x** |
| tac | reverse 100MB text | 0.0797s | 0.0372s | **2.1x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0050s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0168s | 0.0093s | **1.8x** |
| tac | custom separator 1MB | 0.0043s | 0.0034s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0541s | 0.0031s | **17.7x** |
| wc | default 100MB text | 0.4823s | 0.0139s | **34.7x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | **0.9x** |
| wc | -w 10MB text | 0.0543s | 0.0109s | **5.0x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0545s | 0.0031s | **17.8x** |
| wc | -L 10MB text | 0.0547s | 0.0103s | **5.3x** |
| wc | default 10MB binary | 0.3154s | 0.0277s | **11.4x** |
| wc | default 10MB repetitive | 0.0733s | 0.0047s | **15.7x** |
| wc | 10 files | 0.0010s | 0.0013s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0232s | 0.0045s | **5.1x** |
| cut | -c1-100 10MB CSV | 0.0231s | 0.0046s | **5.0x** |
| cut | -d, -f1 10MB CSV | 0.0170s | 0.0051s | **3.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0225s | 0.0073s | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0055s | **4.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0081s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0025s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0031s | **0.6x** |
| sha256sum | single 10MB text | 0.0086s | 0.0099s | **0.9x** |
| sha256sum | single 10MB binary | 0.0094s | 0.0102s | **0.9x** |
| sha256sum | single 100MB text | 0.0744s | 0.0755s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0172s | 0.0173s | **1.0x** |
| md5sum | single 10MB binary | 0.0180s | 0.0182s | **1.0x** |
| md5sum | single 100MB text | 0.1597s | 0.1530s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0151s | 0.0124s | **1.2x** |
| b2sum | single 10MB binary | 0.0164s | 0.0131s | **1.3x** |
| b2sum | single 100MB text | 0.1419s | 0.1117s | **1.3x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0122s | **1.2x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0121s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | **1.4x** |
| base64 | encode 10MB text | 0.0124s | 0.0046s | **2.7x** |
| base64 | encode 10MB binary | 0.0128s | 0.0049s | **2.6x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | **1.8x** |
| base64 | decode 10MB | 0.0329s | 0.0133s | **2.5x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0046s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0037s | **2.3x** |
| sort | lexicographic 1MB | 0.0086s | 0.0034s | **2.5x** |
| sort | lexicographic 10MB random | 0.0540s | 0.0089s | **6.1x** |
| sort | already sorted 10MB | 0.0262s | 0.0048s | **5.4x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0072s | **3.8x** |
| sort | -n numeric 10MB | 0.0747s | 0.0488s | **1.5x** |
| sort | -r reverse 10MB | 0.0546s | 0.0092s | **5.9x** |
| sort | -u unique 10MB | 0.0574s | 0.0126s | **4.5x** |
| sort | -t, -k2 CSV 10MB | 0.0662s | 0.0235s | **2.8x** |
| sort | repetitive 10MB | 0.0552s | 0.0098s | **5.6x** |
| sort | --parallel=4 10MB | 0.0539s | 0.0091s | **5.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0137s | 0.0057s | **2.4x** |
| tr | -d digits 10MB | 0.0168s | 0.0127s | **1.3x** |
| tr | -d lowercase 10MB | 0.0310s | 0.0119s | **2.6x** |
| tr | -s spaces 10MB | 0.0260s | 0.0061s | **4.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0140s | 0.0056s | **2.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0160s | 0.0130s | **1.2x** |
| tr | translate binary 10MB | 0.0117s | 0.0067s | **1.8x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0047s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0036s | **3.9x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0047s | **2.5x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0074s | **3.9x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0047s | **2.5x** |
| uniq | -u unique only 10MB | 0.0124s | 0.0047s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0050s | **2.8x** |
| uniq | repetitive 10MB | 0.0423s | 0.0053s | **8.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | **1.0x** |
| tac | reverse 10MB text | 0.0105s | 0.0064s | **1.6x** |
| tac | reverse 100MB text | 0.1036s | 0.0442s | **2.3x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0062s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0231s | 0.0113s | **2.0x** |
| tac | custom separator 1MB | 0.0060s | 0.0039s | **1.5x** |
