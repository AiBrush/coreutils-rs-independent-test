# fcoreutils v0.0.36 — Detailed Results

Generated: 2026-02-13 00:00:28 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 412 | 1 | 99.8% |

**Overall: 1231/1239 (99.4%)**

## Performance

### Darwin_arm64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| cut | -b1-100 10MB CSV | 0.0274s | 0.0064s | **4.3x** |
| cut | -c1-100 10MB CSV | 0.0263s | 0.0075s | **3.5x** |
| cut | -d, -f1 10MB CSV | 0.0169s | 0.0069s | **2.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0276s | 0.0071s | **3.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0307s | 0.0059s | **5.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0482s | 0.0077s | **6.3x** |
| cut | -d, -f1 100KB text | 0.0015s | 0.0034s | **0.5x** |
| cut | -d, -f1 1MB text | 0.0003s | 0.0048s | **0.1x** |
| cut | -d: -f1 colon file | 0.0014s | 0.0016s | **0.9x** |
| md5sum | single 100KB text | 0.0024s | 0.0035s | **0.7x** |
| md5sum | single 1MB text | 0.0036s | 0.0042s | **0.9x** |
| md5sum | single 10MB text | 0.0200s | 0.0213s | **0.9x** |
| md5sum | single 10MB binary | 0.0207s | 0.0197s | **1.0x** |
| md5sum | single 100MB text | 0.1843s | 0.1990s | **0.9x** |
| md5sum | 10 files | 0.0092s | 0.0043s | **2.1x** |
| md5sum | 100 files | 0.0054s | 0.0059s | **0.9x** |
| b2sum | single 100KB text | 0.0044s | 0.0008s | **5.8x** |
| b2sum | single 1MB text | 0.0054s | 0.0045s | **1.2x** |
| b2sum | single 10MB text | 0.0225s | 0.0188s | **1.2x** |
| b2sum | single 10MB binary | 0.0336s | 0.0173s | **1.9x** |
| b2sum | single 100MB text | 0.1664s | 0.1143s | **1.5x** |
| b2sum | -l 256 10MB | 0.0287s | 0.0161s | **1.8x** |
| b2sum | -l 128 10MB | 0.0203s | 0.0123s | **1.7x** |
| b2sum | 100 files | 0.0052s | 0.0046s | **1.1x** |
| base64 | encode 100KB text | 0.0032s | 0.0023s | **1.4x** |
| base64 | encode 1MB text | 0.0026s | 0.0022s | **1.2x** |
| base64 | encode 10MB text | 0.0171s | 0.0058s | **2.9x** |
| base64 | encode 10MB binary | 0.0194s | 0.0071s | **2.8x** |
| base64 | decode 1MB | 0.0057s | 0.0040s | **1.4x** |
| base64 | decode 10MB | 0.0301s | 0.0144s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0187s | 0.0082s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0064s | 0.0032s | **2.0x** |
| sort | lexicographic 1MB | 0.1187s | 0.0085s | **13.9x** |
| sort | lexicographic 10MB random | 0.4269s | 0.0140s | **30.5x** |
| sort | already sorted 10MB | 0.2156s | 0.0083s | **25.9x** |
| sort | reverse sorted 10MB | 0.2513s | 0.0108s | **23.3x** |
| sort | -n numeric 10MB | 0.4356s | 0.0280s | **15.6x** |
| sort | -r reverse 10MB | 0.4093s | 0.0240s | **17.1x** |
| sort | -u unique 10MB | 0.4707s | 0.0168s | **28.1x** |
| sort | -t, -k2 CSV 10MB | 0.5769s | 0.0501s | **11.5x** |
| sort | repetitive 10MB | 0.0584s | 0.0121s | **4.8x** |
| sort | --parallel=4 10MB | 0.3823s | 0.0170s | **22.5x** |
| tr | a-z to A-Z 1MB | 0.0034s | 0.0038s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0206s | 0.0112s | **1.8x** |
| tr | -d digits 10MB | 0.0342s | 0.0113s | **3.0x** |
| tr | -d lowercase 10MB | 0.0342s | 0.0210s | **1.6x** |
| tr | -s spaces 10MB | 0.0468s | 0.0166s | **2.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0270s | 0.0139s | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0278s | 0.0132s | **2.1x** |
| tr | translate binary 10MB | 0.0206s | 0.0061s | **3.4x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0072s | **1.6x** |
| uniq | default 10MB sorted (low dup) | 0.0187s | 0.0092s | **2.0x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0116s | **1.0x** |
| uniq | -c count 10MB sorted | 0.0337s | 0.0126s | **2.7x** |
| uniq | -d duplicates only 10MB | 0.0114s | 0.0073s | **1.5x** |
| uniq | -u unique only 10MB | 0.0106s | 0.0057s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0199s | 0.0147s | **1.4x** |
| uniq | repetitive 10MB | 0.0352s | 0.0082s | **4.3x** |
| tac | reverse 100KB text | 0.0010s | 0.0006s | **1.8x** |
| tac | reverse 1MB text | 0.0035s | 0.0029s | **1.2x** |
| tac | reverse 10MB text | 0.0142s | 0.0069s | **2.1x** |
| tac | reverse 100MB text | 0.1288s | 0.0573s | **2.2x** |
| tac | reverse CSV 10MB | 0.0122s | 0.0083s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0271s | 0.0154s | **1.8x** |
| tac | custom separator 1MB | 0.0069s | 0.0066s | **1.0x** |

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0013s | **0.9x** |
| wc | default 1MB text | 0.0039s | 0.0028s | **1.4x** |
| wc | default 10MB text | 0.0347s | 0.0066s | **5.2x** |
| wc | default 100MB text | 0.2921s | 0.0406s | **7.2x** |
| wc | -l 10MB text | 0.0047s | 0.0026s | **1.8x** |
| wc | -w 10MB text | 0.0346s | 0.0171s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0347s | 0.0026s | **13.3x** |
| wc | -L 10MB text | 0.0346s | 0.0170s | **2.0x** |
| wc | default 10MB binary | 0.2339s | 0.0591s | **4.0x** |
| wc | default 10MB repetitive | 0.0535s | 0.0075s | **7.2x** |
| wc | 10 files | 0.0009s | 0.0012s | **0.7x** |
| wc | 100 files | 0.0014s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0190s | 0.0036s | **5.2x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0036s | **5.2x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0048s | **3.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0046s | **4.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0041s | **5.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0269s | 0.0055s | **4.9x** |
| cut | -d, -f1 100KB text | 0.0010s | 0.0011s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0011s | **1.1x** |
| sha256sum | single 1MB text | 0.0018s | 0.0016s | **1.1x** |
| sha256sum | single 10MB text | 0.0081s | 0.0066s | **1.2x** |
| sha256sum | single 10MB binary | 0.0074s | 0.0067s | **1.1x** |
| sha256sum | single 100MB text | 0.0618s | 0.0529s | **1.2x** |
| sha256sum | 10 files | 0.0012s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0019s | 0.0026s | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0012s | **1.1x** |
| md5sum | single 1MB text | 0.0033s | 0.0028s | **1.2x** |
| md5sum | single 10MB text | 0.0215s | 0.0165s | **1.3x** |
| md5sum | single 10MB binary | 0.0214s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1934s | 0.1500s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0017s | **0.7x** |
| md5sum | 100 files | 0.0017s | 0.0026s | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0022s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0146s | 0.0127s | **1.1x** |
| b2sum | single 10MB binary | 0.0142s | 0.0130s | **1.1x** |
| b2sum | single 100MB text | 0.1283s | 0.1128s | **1.1x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0128s | **1.2x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0127s | **1.2x** |
| b2sum | 100 files | 0.0018s | 0.0026s | **0.7x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0018s | **1.0x** |
| base64 | encode 10MB text | 0.0102s | 0.0049s | **2.1x** |
| base64 | encode 10MB binary | 0.0100s | 0.0051s | **2.0x** |
| base64 | decode 1MB | 0.0038s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0310s | 0.0141s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0104s | 0.0051s | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0045s | **1.8x** |
| sort | lexicographic 1MB | 0.0078s | 0.0036s | **2.2x** |
| sort | lexicographic 10MB random | 0.0538s | 0.0088s | **6.1x** |
| sort | already sorted 10MB | 0.0252s | 0.0055s | **4.6x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0044s | **5.6x** |
| sort | -n numeric 10MB | 0.0739s | 0.0236s | **3.1x** |
| sort | -r reverse 10MB | 0.0549s | 0.0083s | **6.7x** |
| sort | -u unique 10MB | 0.0573s | 0.0148s | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0755s | 0.0214s | **3.5x** |
| sort | repetitive 10MB | 0.0472s | 0.0133s | **3.6x** |
| sort | --parallel=4 10MB | 0.0531s | 0.0084s | **6.3x** |
| tr | a-z to A-Z 1MB | 0.0022s | 0.0021s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0066s | **1.3x** |
| tr | -d digits 10MB | 0.0112s | 0.0099s | **1.1x** |
| tr | -d lowercase 10MB | 0.0195s | 0.0167s | **1.2x** |
| tr | -s spaces 10MB | 0.0167s | 0.0139s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0069s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0098s | **1.1x** |
| tr | translate binary 10MB | 0.0092s | 0.0070s | **1.3x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0048s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0048s | **3.4x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0062s | **1.5x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0077s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0049s | **1.9x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0049s | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0060s | **2.7x** |
| uniq | repetitive 10MB | 0.0490s | 0.0076s | **6.5x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | **0.7x** |
| tac | reverse 1MB text | 0.0017s | 0.0018s | **1.0x** |
| tac | reverse 10MB text | 0.0091s | 0.0049s | **1.9x** |
| tac | reverse 100MB text | 0.0794s | 0.0398s | **2.0x** |
| tac | reverse CSV 10MB | 0.0086s | 0.0050s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0195s | 0.0107s | **1.8x** |
| tac | custom separator 1MB | 0.0046s | 0.0043s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0030s | **1.9x** |
| wc | default 10MB text | 0.0546s | 0.0108s | **5.1x** |
| wc | default 100MB text | 0.4824s | 0.0846s | **5.7x** |
| wc | -l 10MB text | 0.0024s | 0.0033s | **0.7x** |
| wc | -w 10MB text | 0.0547s | 0.0201s | **2.7x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.9x** |
| wc | -m 10MB text | 0.0547s | 0.0031s | **17.6x** |
| wc | -L 10MB text | 0.0540s | 0.0236s | **2.3x** |
| wc | default 10MB binary | 0.3167s | 0.0824s | **3.8x** |
| wc | default 10MB repetitive | 0.0736s | 0.0147s | **5.0x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0230s | 0.0043s | **5.4x** |
| cut | -c1-100 10MB CSV | 0.0231s | 0.0042s | **5.5x** |
| cut | -d, -f1 10MB CSV | 0.0169s | 0.0063s | **2.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0221s | 0.0083s | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0263s | 0.0079s | **3.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0092s | **3.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0011s | **1.2x** |
| sha256sum | single 1MB text | 0.0021s | 0.0018s | **1.2x** |
| sha256sum | single 10MB text | 0.0091s | 0.0084s | **1.1x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0086s | **1.1x** |
| sha256sum | single 100MB text | 0.0756s | 0.0727s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0037s | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0013s | **1.1x** |
| md5sum | single 1MB text | 0.0029s | 0.0030s | **1.0x** |
| md5sum | single 10MB text | 0.0176s | 0.0204s | **0.9x** |
| md5sum | single 10MB binary | 0.0183s | 0.0213s | **0.9x** |
| md5sum | single 100MB text | 0.1611s | 0.1917s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0020s | **0.7x** |
| md5sum | 100 files | 0.0024s | 0.0037s | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0024s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0120s | **1.3x** |
| b2sum | single 10MB binary | 0.0158s | 0.0125s | **1.3x** |
| b2sum | single 100MB text | 0.1426s | 0.1104s | **1.3x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0120s | **1.3x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0121s | **1.3x** |
| b2sum | 100 files | 0.0023s | 0.0038s | **0.6x** |
| base64 | encode 100KB text | 0.0011s | 0.0013s | **0.8x** |
| base64 | encode 1MB text | 0.0021s | 0.0018s | **1.2x** |
| base64 | encode 10MB text | 0.0126s | 0.0048s | **2.6x** |
| base64 | encode 10MB binary | 0.0133s | 0.0047s | **2.9x** |
| base64 | decode 1MB | 0.0041s | 0.0021s | **1.9x** |
| base64 | decode 10MB | 0.0329s | 0.0113s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0047s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0037s | **2.3x** |
| sort | lexicographic 1MB | 0.0086s | 0.0040s | **2.1x** |
| sort | lexicographic 10MB random | 0.0550s | 0.0123s | **4.5x** |
| sort | already sorted 10MB | 0.0266s | 0.0071s | **3.7x** |
| sort | reverse sorted 10MB | 0.0278s | 0.0072s | **3.9x** |
| sort | -n numeric 10MB | 0.0754s | 0.0310s | **2.4x** |
| sort | -r reverse 10MB | 0.0552s | 0.0128s | **4.3x** |
| sort | -u unique 10MB | 0.0597s | 0.0164s | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0677s | 0.0278s | **2.4x** |
| sort | repetitive 10MB | 0.0563s | 0.0167s | **3.4x** |
| sort | --parallel=4 10MB | 0.0559s | 0.0129s | **4.3x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0022s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0074s | **1.7x** |
| tr | -d digits 10MB | 0.0164s | 0.0126s | **1.3x** |
| tr | -d lowercase 10MB | 0.0292s | 0.0218s | **1.3x** |
| tr | -s spaces 10MB | 0.0257s | 0.0147s | **1.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0071s | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0163s | 0.0123s | **1.3x** |
| tr | translate binary 10MB | 0.0130s | 0.0074s | **1.7x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0063s | **1.9x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0063s | **2.3x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0075s | **1.6x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0103s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0060s | **2.0x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0060s | **2.1x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0078s | **1.8x** |
| uniq | repetitive 10MB | 0.0439s | 0.0083s | **5.3x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0018s | **1.1x** |
| tac | reverse 10MB text | 0.0108s | 0.0054s | **2.0x** |
| tac | reverse 100MB text | 0.1038s | 0.0456s | **2.3x** |
| tac | reverse CSV 10MB | 0.0098s | 0.0055s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0110s | **2.1x** |
| tac | custom separator 1MB | 0.0060s | 0.0044s | **1.4x** |
