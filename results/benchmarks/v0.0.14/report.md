# fcoreutils v0.0.14 — Detailed Results

Generated: 2026-02-14 18:08:12 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 401 | 12 | 97.1% |
| Linux_aarch64 | 413 | 406 | 7 | 98.3% |
| Linux_x86_64 | 413 | 406 | 7 | 98.3% |

**Overall: 1213/1239 (97.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0010s | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0336s | 0.0221s | **1.5x** |
| wc | default 100MB text | 0.2926s | 0.1825s | **1.6x** |
| wc | -l 10MB text | 0.0037s | 0.0020s | **1.9x** |
| wc | -w 10MB text | 0.0336s | 0.0206s | **1.6x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0336s | 0.0036s | **9.4x** |
| wc | -L 10MB text | 0.0337s | 0.0155s | **2.2x** |
| wc | default 10MB binary | 0.2359s | 0.0563s | **4.2x** |
| wc | default 10MB repetitive | 0.0539s | 0.0242s | **2.2x** |
| wc | 10 files | 0.0009s | 0.0009s | **1.0x** |
| wc | 100 files | 0.0013s | 0.0018s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0052s | **3.6x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0051s | **3.7x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0030s | **6.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0057s | **3.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0051s | **4.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0068s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0014s | **2.5x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0009s | **1.2x** |
| sha256sum | single 1MB text | 0.0017s | 0.0015s | **1.1x** |
| sha256sum | single 10MB text | 0.0069s | 0.0069s | **1.0x** |
| sha256sum | single 10MB binary | 0.0080s | 0.0074s | **1.1x** |
| sha256sum | single 100MB text | 0.0627s | 0.0607s | **1.0x** |
| sha256sum | 10 files | 0.0011s | 0.0013s | **0.8x** |
| sha256sum | 100 files | 0.0017s | 0.0022s | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0010s | **1.3x** |
| md5sum | single 1MB text | 0.0031s | 0.0024s | **1.3x** |
| md5sum | single 10MB text | 0.0206s | 0.0159s | **1.3x** |
| md5sum | single 10MB binary | 0.0222s | 0.0168s | **1.3x** |
| md5sum | single 100MB text | 0.1944s | 0.1501s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0013s | **0.8x** |
| md5sum | 100 files | 0.0017s | 0.0023s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0021s | **1.0x** |
| b2sum | single 10MB text | 0.0134s | 0.0128s | **1.1x** |
| b2sum | single 10MB binary | 0.0149s | 0.0134s | **1.1x** |
| b2sum | single 100MB text | 0.1290s | 0.1187s | **1.1x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0128s | **1.0x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0128s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0022s | **0.7x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0020s | **0.8x** |
| base64 | encode 10MB text | 0.0092s | 0.0102s | **0.9x** |
| base64 | encode 10MB binary | 0.0104s | 0.0106s | **1.0x** |
| base64 | decode 1MB | 0.0037s | 0.0026s | **1.4x** |
| base64 | decode 10MB | 0.0298s | 0.0178s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0103s | **0.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0073s | 0.0068s | **1.1x** |
| sort | lexicographic 1MB | 0.0074s | 0.0044s | **1.7x** |
| sort | lexicographic 10MB random | 0.0502s | 0.0170s | **3.0x** |
| sort | already sorted 10MB | 0.0239s | 0.0091s | **2.6x** |
| sort | reverse sorted 10MB | 0.0239s | 0.0090s | **2.7x** |
| sort | -n numeric 10MB | 0.0676s | 0.0323s | **2.1x** |
| sort | -r reverse 10MB | 0.0514s | 0.0162s | **3.2x** |
| sort | -u unique 10MB | 0.0543s | 0.0190s | **2.9x** |
| sort | -t, -k2 CSV 10MB | 0.0716s | 0.0346s | **2.1x** |
| sort | repetitive 10MB | 0.0444s | 0.0209s | **2.1x** |
| sort | --parallel=4 10MB | 0.0504s | 0.0168s | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0016s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0062s | **1.5x** |
| tr | -d digits 10MB | 0.0110s | 0.0112s | **1.0x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0183s | **1.1x** |
| tr | -s spaces 10MB | 0.0168s | 0.0209s | **0.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0061s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0110s | **1.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0064s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0046s | **2.1x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0054s | **3.0x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0047s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0070s | **4.2x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0048s | **2.0x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0048s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0060s | **2.7x** |
| uniq | repetitive 10MB | 0.0486s | 0.0072s | **6.7x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | **0.9x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | **1.1x** |
| tac | reverse 10MB text | 0.0084s | 0.0053s | **1.6x** |
| tac | reverse 100MB text | 0.0803s | 0.0457s | **1.8x** |
| tac | reverse CSV 10MB | 0.0085s | 0.0060s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0188s | 0.0109s | **1.7x** |
| tac | custom separator 1MB | 0.0043s | 0.0052s | **0.8x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0015s | 0.0012s | **1.2x** |
| wc | default 1MB text | 0.0055s | 0.0036s | **1.5x** |
| wc | default 10MB text | 0.0493s | 0.0322s | **1.5x** |
| wc | default 100MB text | 0.4430s | 0.2582s | **1.7x** |
| wc | -l 10MB text | 0.0023s | 0.0025s | **0.9x** |
| wc | -w 10MB text | 0.0493s | 0.0279s | **1.8x** |
| wc | -c 10MB text | 0.0010s | 0.0010s | **1.0x** |
| wc | -m 10MB text | 0.0493s | 0.0037s | **13.3x** |
| wc | -L 10MB text | 0.0492s | 0.0153s | **3.2x** |
| wc | default 10MB binary | 0.3233s | 0.0966s | **3.3x** |
| wc | default 10MB repetitive | 0.0709s | 0.0338s | **2.1x** |
| wc | 10 files | 0.0011s | 0.0012s | **1.0x** |
| wc | 100 files | 0.0022s | 0.0030s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0238s | 0.0062s | **3.8x** |
| cut | -c1-100 10MB CSV | 0.0238s | 0.0060s | **4.0x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0040s | **4.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0236s | 0.0080s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0257s | 0.0075s | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0108s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0010s | 0.0010s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0038s | 0.0018s | **2.1x** |
| cut | -d: -f1 colon file | 0.0010s | 0.0010s | **1.0x** |
| sha256sum | single 100KB text | 0.0015s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0023s | 0.0018s | **1.3x** |
| sha256sum | single 10MB text | 0.0101s | 0.0093s | **1.1x** |
| sha256sum | single 10MB binary | 0.0101s | 0.0095s | **1.1x** |
| sha256sum | single 100MB text | 0.0855s | 0.0832s | **1.0x** |
| sha256sum | 10 files | 0.0015s | 0.0017s | **0.9x** |
| sha256sum | 100 files | 0.0028s | 0.0041s | **0.7x** |
| md5sum | single 100KB text | 0.0016s | 0.0012s | **1.4x** |
| md5sum | single 1MB text | 0.0033s | 0.0032s | **1.0x** |
| md5sum | single 10MB text | 0.0200s | 0.0231s | **0.9x** |
| md5sum | single 10MB binary | 0.0206s | 0.0239s | **0.9x** |
| md5sum | single 100MB text | 0.1837s | 0.2184s | **0.8x** |
| md5sum | 10 files | 0.0015s | 0.0017s | **0.9x** |
| md5sum | 100 files | 0.0027s | 0.0042s | **0.7x** |
| b2sum | single 100KB text | 0.0012s | 0.0011s | **1.1x** |
| b2sum | single 1MB text | 0.0025s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0159s | 0.0130s | **1.2x** |
| b2sum | single 10MB binary | 0.0170s | 0.0137s | **1.2x** |
| b2sum | single 100MB text | 0.1527s | 0.1210s | **1.3x** |
| b2sum | -l 256 10MB | 0.0161s | 0.0130s | **1.2x** |
| b2sum | -l 128 10MB | 0.0161s | 0.0130s | **1.2x** |
| b2sum | 100 files | 0.0025s | 0.0041s | **0.6x** |
| base64 | encode 100KB text | 0.0011s | 0.0011s | **1.0x** |
| base64 | encode 1MB text | 0.0024s | 0.0023s | **1.0x** |
| base64 | encode 10MB text | 0.0147s | 0.0067s | **2.2x** |
| base64 | encode 10MB binary | 0.0150s | 0.0071s | **2.1x** |
| base64 | decode 1MB | 0.0041s | 0.0032s | **1.3x** |
| base64 | decode 10MB | 0.0331s | 0.0180s | **1.8x** |
| base64 | encode -w 76 10MB | 0.0148s | 0.0069s | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0102s | 0.0037s | **2.7x** |
| sort | lexicographic 1MB | 0.0089s | 0.0054s | **1.6x** |
| sort | lexicographic 10MB random | 0.0575s | 0.0197s | **2.9x** |
| sort | already sorted 10MB | 0.0251s | 0.0123s | **2.0x** |
| sort | reverse sorted 10MB | 0.0266s | 0.0121s | **2.2x** |
| sort | -n numeric 10MB | 0.0753s | 0.0377s | **2.0x** |
| sort | -r reverse 10MB | 0.0566s | 0.0189s | **3.0x** |
| sort | -u unique 10MB | 0.0601s | 0.0191s | **3.1x** |
| sort | -t, -k2 CSV 10MB | 0.0703s | 0.0350s | **2.0x** |
| sort | repetitive 10MB | 0.0471s | 0.0194s | **2.4x** |
| sort | --parallel=4 10MB | 0.0561s | 0.0187s | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0025s | 0.0017s | **1.4x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0056s | **2.2x** |
| tr | -d digits 10MB | 0.0193s | 0.0135s | **1.4x** |
| tr | -d lowercase 10MB | 0.0319s | 0.0251s | **1.3x** |
| tr | -s spaces 10MB | 0.0305s | 0.0290s | **1.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0056s | **2.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0204s | 0.0138s | **1.5x** |
| tr | translate binary 10MB | 0.0135s | 0.0084s | **1.6x** |
| uniq | default 10MB many duplicates | 0.0115s | 0.0048s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0149s | 0.0046s | **3.2x** |
| uniq | -c count 10MB many dups | 0.0115s | 0.0048s | **2.4x** |
| uniq | -c count 10MB sorted | 0.0259s | 0.0071s | **3.6x** |
| uniq | -d duplicates only 10MB | 0.0115s | 0.0047s | **2.4x** |
| uniq | -u unique only 10MB | 0.0114s | 0.0047s | **2.4x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0055s | **2.6x** |
| uniq | repetitive 10MB | 0.0312s | 0.0073s | **4.3x** |
| tac | reverse 100KB text | 0.0011s | 0.0011s | **1.0x** |
| tac | reverse 1MB text | 0.0022s | 0.0019s | **1.2x** |
| tac | reverse 10MB text | 0.0129s | 0.0067s | **1.9x** |
| tac | reverse 100MB text | 0.1274s | 0.0509s | **2.5x** |
| tac | reverse CSV 10MB | 0.0111s | 0.0073s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0247s | 0.0125s | **2.0x** |
| tac | custom separator 1MB | 0.0066s | 0.0069s | **1.0x** |
