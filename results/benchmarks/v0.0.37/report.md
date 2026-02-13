# fcoreutils v0.0.37 — Detailed Results

Generated: 2026-02-13 07:08:10 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 408 | 5 | 98.8% |
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 412 | 1 | 99.8% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |

**Overall: 1232/1239 (99.4%)**

## Performance

### Darwin_arm64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0033s | 0.0035s | **0.9x** |
| wc | default 1MB text | 0.0039s | 0.0036s | **1.1x** |
| wc | default 10MB text | 0.0292s | 0.0094s | **3.1x** |
| wc | default 100MB text | 0.2495s | 0.0724s | **3.4x** |
| wc | -l 10MB text | 0.0044s | 0.0015s | **2.9x** |
| wc | -w 10MB text | 0.0344s | 0.0229s | **1.5x** |
| wc | -c 10MB text | 0.0048s | 0.0011s | **4.2x** |
| wc | -m 10MB text | 0.0300s | 0.0064s | **4.7x** |
| wc | -L 10MB text | 0.0279s | 0.0215s | **1.3x** |
| wc | default 10MB binary | 0.1349s | 0.0808s | **1.7x** |
| wc | default 10MB repetitive | 0.0499s | 0.0235s | **2.1x** |
| wc | 10 files | 0.0025s | 0.0041s | **0.6x** |
| wc | 100 files | 0.0033s | 0.0036s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0313s | 0.0049s | **6.4x** |
| cut | -c1-100 10MB CSV | 0.0385s | 0.0088s | **4.4x** |
| cut | -d, -f1 10MB CSV | 0.0195s | 0.0104s | **1.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0335s | 0.0094s | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0361s | 0.0050s | **7.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0516s | 0.0102s | **5.0x** |
| cut | -d, -f1 100KB text | 0.0038s | 0.0029s | **1.3x** |
| cut | -d, -f1 1MB text | 0.0037s | 0.0045s | **0.8x** |
| cut | -d: -f1 colon file | 0.0016s | 0.0016s | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0007s | **1.5x** |
| sha256sum | single 1MB text | 0.0063s | 0.0028s | **2.2x** |
| sha256sum | single 10MB text | 0.0401s | 0.0100s | **4.0x** |
| sha256sum | single 10MB binary | 0.0411s | 0.0169s | **2.4x** |
| sha256sum | single 100MB text | 0.3858s | 0.0643s | **6.0x** |
| sha256sum | 10 files | 0.0019s | 0.0022s | **0.9x** |
| sha256sum | 100 files | 0.0079s | 0.0054s | **1.5x** |
| md5sum | single 100KB text | 0.0017s | 0.0023s | **0.7x** |
| md5sum | single 1MB text | 0.0045s | 0.0069s | **0.7x** |
| md5sum | single 10MB text | 0.0259s | 0.0241s | **1.1x** |
| md5sum | single 10MB binary | 0.0216s | 0.0186s | **1.2x** |
| md5sum | single 100MB text | 0.1767s | 0.1689s | **1.0x** |
| md5sum | 10 files | 0.0025s | 0.0053s | **0.5x** |
| md5sum | 100 files | 0.0031s | 0.0051s | **0.6x** |
| b2sum | single 100KB text | 0.0028s | 0.0019s | **1.4x** |
| b2sum | single 1MB text | 0.0041s | 0.0040s | **1.0x** |
| b2sum | single 10MB text | 0.0214s | 0.0215s | **1.0x** |
| b2sum | single 10MB binary | 0.0229s | 0.0213s | **1.1x** |
| b2sum | single 100MB text | 0.2128s | 0.1250s | **1.7x** |
| b2sum | -l 256 10MB | 0.0178s | 0.0130s | **1.4x** |
| b2sum | -l 128 10MB | 0.0184s | 0.0138s | **1.3x** |
| b2sum | 100 files | 0.0049s | 0.0056s | **0.9x** |
| base64 | encode 100KB text | 0.0016s | 0.0018s | **0.9x** |
| base64 | encode 1MB text | 0.0037s | 0.0031s | **1.2x** |
| base64 | encode 10MB text | 0.0155s | 0.0052s | **3.0x** |
| base64 | encode 10MB binary | 0.0157s | 0.0050s | **3.1x** |
| base64 | decode 1MB | 0.0047s | 0.0049s | **1.0x** |
| base64 | decode 10MB | 0.0290s | 0.0137s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0141s | 0.0053s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0044s | **1.7x** |
| sort | lexicographic 1MB | 0.0980s | 0.0038s | **25.7x** |
| sort | lexicographic 10MB random | 0.5110s | 0.0252s | **20.3x** |
| sort | already sorted 10MB | 0.2125s | 0.0018s | **118.9x** |
| sort | reverse sorted 10MB | 0.2003s | 0.0074s | **27.0x** |
| sort | -n numeric 10MB | 0.4144s | 0.0406s | **10.2x** |
| sort | -r reverse 10MB | 0.4578s | 0.0199s | **22.9x** |
| sort | -u unique 10MB | 0.4419s | 0.0157s | **28.1x** |
| sort | -t, -k2 CSV 10MB | 0.6236s | 0.0304s | **20.5x** |
| sort | repetitive 10MB | 0.0560s | 0.0111s | **5.0x** |
| sort | --parallel=4 10MB | 0.3894s | 0.0117s | **33.2x** |
| tr | a-z to A-Z 1MB | 0.0068s | 0.0021s | **3.2x** |
| tr | a-z to A-Z 10MB | 0.0170s | 0.0084s | **2.0x** |
| tr | -d digits 10MB | 0.0218s | 0.0121s | **1.8x** |
| tr | -d lowercase 10MB | 0.0346s | 0.0215s | **1.6x** |
| tr | -s spaces 10MB | 0.0467s | 0.0183s | **2.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0152s | 0.0095s | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0221s | 0.0224s | **1.0x** |
| tr | translate binary 10MB | 0.0242s | 0.0201s | **1.2x** |
| uniq | default 10MB many duplicates | 0.0102s | 0.0109s | **0.9x** |
| uniq | default 10MB sorted (low dup) | 0.0196s | 0.0074s | **2.6x** |
| uniq | -c count 10MB many dups | 0.0139s | 0.0125s | **1.1x** |
| uniq | -c count 10MB sorted | 0.0338s | 0.0124s | **2.7x** |
| uniq | -d duplicates only 10MB | 0.0126s | 0.0077s | **1.6x** |
| uniq | -u unique only 10MB | 0.0156s | 0.0084s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0272s | 0.0102s | **2.7x** |
| uniq | repetitive 10MB | 0.0366s | 0.0053s | **7.0x** |
| tac | reverse 100KB text | 0.0018s | 0.0019s | **1.0x** |
| tac | reverse 1MB text | 0.0033s | 0.0042s | **0.8x** |
| tac | reverse 10MB text | 0.0153s | 0.0076s | **2.0x** |
| tac | reverse 100MB text | 0.1275s | 0.0555s | **2.3x** |
| tac | reverse CSV 10MB | 0.0126s | 0.0080s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0270s | 0.0184s | **1.5x** |
| tac | custom separator 1MB | 0.0089s | 0.0077s | **1.2x** |

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0013s | **0.9x** |
| wc | default 1MB text | 0.0040s | 0.0028s | **1.4x** |
| wc | default 10MB text | 0.0347s | 0.0064s | **5.4x** |
| wc | default 100MB text | 0.2923s | 0.0392s | **7.5x** |
| wc | -l 10MB text | 0.0048s | 0.0027s | **1.8x** |
| wc | -w 10MB text | 0.0347s | 0.0173s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0347s | 0.0026s | **13.5x** |
| wc | -L 10MB text | 0.0345s | 0.0169s | **2.0x** |
| wc | default 10MB binary | 0.2344s | 0.0588s | **4.0x** |
| wc | default 10MB repetitive | 0.0530s | 0.0078s | **6.8x** |
| wc | 10 files | 0.0009s | 0.0012s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0016s | **0.8x** |
| cut | -b1-100 10MB CSV | 0.0190s | 0.0034s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0036s | **5.3x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0049s | **3.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0050s | **4.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0044s | **5.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0053s | **5.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0037s | 0.0030s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0011s | **1.1x** |
| sha256sum | single 1MB text | 0.0018s | 0.0016s | **1.1x** |
| sha256sum | single 10MB text | 0.0083s | 0.0066s | **1.3x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0067s | **1.1x** |
| sha256sum | single 100MB text | 0.0618s | 0.0528s | **1.2x** |
| sha256sum | 10 files | 0.0012s | 0.0017s | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0026s | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0013s | **1.0x** |
| md5sum | single 1MB text | 0.0033s | 0.0027s | **1.2x** |
| md5sum | single 10MB text | 0.0216s | 0.0165s | **1.3x** |
| md5sum | single 10MB binary | 0.0214s | 0.0169s | **1.3x** |
| md5sum | single 100MB text | 0.1934s | 0.1499s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0017s | **0.7x** |
| md5sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0013s | **0.7x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | **1.0x** |
| b2sum | single 10MB text | 0.0145s | 0.0126s | **1.2x** |
| b2sum | single 10MB binary | 0.0141s | 0.0129s | **1.1x** |
| b2sum | single 100MB text | 0.1282s | 0.1124s | **1.1x** |
| b2sum | -l 256 10MB | 0.0146s | 0.0127s | **1.1x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0126s | **1.2x** |
| b2sum | 100 files | 0.0017s | 0.0026s | **0.7x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0018s | **1.0x** |
| base64 | encode 10MB text | 0.0101s | 0.0051s | **2.0x** |
| base64 | encode 10MB binary | 0.0099s | 0.0051s | **2.0x** |
| base64 | decode 1MB | 0.0039s | 0.0024s | **1.7x** |
| base64 | decode 10MB | 0.0309s | 0.0143s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0103s | 0.0049s | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0045s | **1.8x** |
| sort | lexicographic 1MB | 0.0078s | 0.0035s | **2.2x** |
| sort | lexicographic 10MB random | 0.0545s | 0.0084s | **6.5x** |
| sort | already sorted 10MB | 0.0250s | 0.0054s | **4.6x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0046s | **5.3x** |
| sort | -n numeric 10MB | 0.0722s | 0.0241s | **3.0x** |
| sort | -r reverse 10MB | 0.0543s | 0.0083s | **6.5x** |
| sort | -u unique 10MB | 0.0566s | 0.0136s | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0746s | 0.0212s | **3.5x** |
| sort | repetitive 10MB | 0.0456s | 0.0132s | **3.5x** |
| sort | --parallel=4 10MB | 0.0526s | 0.0084s | **6.2x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0020s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0066s | **1.3x** |
| tr | -d digits 10MB | 0.0111s | 0.0097s | **1.1x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0166s | **1.1x** |
| tr | -s spaces 10MB | 0.0167s | 0.0138s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0067s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0098s | **1.2x** |
| tr | translate binary 10MB | 0.0093s | 0.0068s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0049s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0034s | **4.8x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0062s | **1.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0076s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0050s | **1.9x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0049s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0060s | **2.7x** |
| uniq | repetitive 10MB | 0.0490s | 0.0044s | **11.1x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0018s | **1.0x** |
| tac | reverse 10MB text | 0.0092s | 0.0049s | **1.9x** |
| tac | reverse 100MB text | 0.0792s | 0.0398s | **2.0x** |
| tac | reverse CSV 10MB | 0.0087s | 0.0051s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0195s | 0.0104s | **1.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0042s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0059s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0548s | 0.0033s | **16.7x** |
| wc | default 100MB text | 0.4826s | 0.0145s | **33.3x** |
| wc | -l 10MB text | 0.0021s | 0.0031s | **0.7x** |
| wc | -w 10MB text | 0.0547s | 0.0198s | **2.8x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0547s | 0.0032s | **17.2x** |
| wc | -L 10MB text | 0.0548s | 0.0239s | **2.3x** |
| wc | default 10MB binary | 0.3165s | 0.0822s | **3.8x** |
| wc | default 10MB repetitive | 0.0736s | 0.0049s | **15.0x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0045s | **5.0x** |
| cut | -c1-100 10MB CSV | 0.0230s | 0.0041s | **5.6x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0064s | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0221s | 0.0085s | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0245s | 0.0075s | **3.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0092s | **3.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0031s | **1.1x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0011s | **1.2x** |
| sha256sum | single 1MB text | 0.0020s | 0.0018s | **1.1x** |
| sha256sum | single 10MB text | 0.0088s | 0.0082s | **1.1x** |
| sha256sum | single 10MB binary | 0.0091s | 0.0086s | **1.1x** |
| sha256sum | single 100MB text | 0.0756s | 0.0730s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0038s | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0013s | **1.1x** |
| md5sum | single 1MB text | 0.0029s | 0.0036s | **0.8x** |
| md5sum | single 10MB text | 0.0178s | 0.0203s | **0.9x** |
| md5sum | single 10MB binary | 0.0183s | 0.0213s | **0.9x** |
| md5sum | single 100MB text | 0.1611s | 0.1926s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0021s | **0.7x** |
| md5sum | 100 files | 0.0024s | 0.0037s | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0120s | **1.3x** |
| b2sum | single 10MB binary | 0.0160s | 0.0126s | **1.3x** |
| b2sum | single 100MB text | 0.1431s | 0.1105s | **1.3x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0121s | **1.3x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0119s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0037s | **0.6x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0021s | 0.0017s | **1.2x** |
| base64 | encode 10MB text | 0.0126s | 0.0050s | **2.5x** |
| base64 | encode 10MB binary | 0.0131s | 0.0050s | **2.6x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | **1.9x** |
| base64 | decode 10MB | 0.0342s | 0.0112s | **3.1x** |
| base64 | encode -w 76 10MB | 0.0128s | 0.0046s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0037s | **2.4x** |
| sort | lexicographic 1MB | 0.0090s | 0.0041s | **2.2x** |
| sort | lexicographic 10MB random | 0.0545s | 0.0123s | **4.4x** |
| sort | already sorted 10MB | 0.0276s | 0.0071s | **3.9x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0072s | **3.8x** |
| sort | -n numeric 10MB | 0.0738s | 0.0311s | **2.4x** |
| sort | -r reverse 10MB | 0.0548s | 0.0123s | **4.5x** |
| sort | -u unique 10MB | 0.0581s | 0.0147s | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0668s | 0.0270s | **2.5x** |
| sort | repetitive 10MB | 0.0560s | 0.0166s | **3.4x** |
| sort | --parallel=4 10MB | 0.0550s | 0.0124s | **4.4x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0021s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0071s | **1.8x** |
| tr | -d digits 10MB | 0.0171s | 0.0125s | **1.4x** |
| tr | -d lowercase 10MB | 0.0301s | 0.0214s | **1.4x** |
| tr | -s spaces 10MB | 0.0257s | 0.0144s | **1.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0138s | 0.0075s | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0167s | 0.0123s | **1.4x** |
| tr | translate binary 10MB | 0.0112s | 0.0078s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0062s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0143s | 0.0045s | **3.1x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0071s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0100s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0060s | **2.0x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0061s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0077s | **1.8x** |
| uniq | repetitive 10MB | 0.0423s | 0.0055s | **7.7x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0019s | **1.1x** |
| tac | reverse 10MB text | 0.0109s | 0.0055s | **2.0x** |
| tac | reverse 100MB text | 0.1058s | 0.0459s | **2.3x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0056s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0110s | **2.1x** |
| tac | custom separator 1MB | 0.0060s | 0.0045s | **1.3x** |
