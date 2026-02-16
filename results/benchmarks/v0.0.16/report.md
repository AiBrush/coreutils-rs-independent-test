# fcoreutils v0.0.16 — Detailed Results

Generated: 2026-02-16 06:17:34 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 404 | 9 | 97.8% |
| Linux_aarch64 | 413 | 409 | 4 | 99.0% |
| Linux_x86_64 | 413 | 409 | 4 | 99.0% |

**Overall: 1222/1239 (98.6%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0009s | 0.0009s | **1.0x** |
| wc | default 1MB text | 0.0037s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0330s | 0.0218s | **1.5x** |
| wc | default 100MB text | 0.2886s | 0.1815s | **1.6x** |
| wc | -l 10MB text | 0.0033s | 0.0019s | **1.7x** |
| wc | -w 10MB text | 0.0331s | 0.0204s | **1.6x** |
| wc | -c 10MB text | 0.0007s | 0.0007s | **1.0x** |
| wc | -m 10MB text | 0.0330s | 0.0034s | **9.8x** |
| wc | -L 10MB text | 0.0329s | 0.0151s | **2.2x** |
| wc | default 10MB binary | 0.2347s | 0.0561s | **4.2x** |
| wc | default 10MB repetitive | 0.0506s | 0.0233s | **2.2x** |
| wc | 10 files | 0.0007s | 0.0008s | **0.9x** |
| wc | 100 files | 0.0012s | 0.0016s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0045s | **4.1x** |
| cut | -c1-100 10MB CSV | 0.0180s | 0.0046s | **3.9x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0030s | **6.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0206s | 0.0053s | **3.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0227s | 0.0045s | **5.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0260s | 0.0062s | **4.2x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0013s | **2.5x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0008s | **1.2x** |
| sha256sum | single 1MB text | 0.0016s | 0.0014s | **1.1x** |
| sha256sum | single 10MB text | 0.0066s | 0.0067s | **1.0x** |
| sha256sum | single 10MB binary | 0.0072s | 0.0072s | **1.0x** |
| sha256sum | single 100MB text | 0.0562s | 0.0593s | **0.9x** |
| sha256sum | 10 files | 0.0010s | 0.0012s | **0.8x** |
| sha256sum | 100 files | 0.0017s | 0.0021s | **0.8x** |
| md5sum | single 100KB text | 0.0011s | 0.0009s | **1.3x** |
| md5sum | single 1MB text | 0.0028s | 0.0023s | **1.2x** |
| md5sum | single 10MB text | 0.0197s | 0.0156s | **1.3x** |
| md5sum | single 10MB binary | 0.0211s | 0.0166s | **1.3x** |
| md5sum | single 100MB text | 0.1881s | 0.1487s | **1.3x** |
| md5sum | 10 files | 0.0010s | 0.0012s | **0.9x** |
| md5sum | 100 files | 0.0015s | 0.0020s | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0009s | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | **1.0x** |
| b2sum | single 10MB text | 0.0130s | 0.0132s | **1.0x** |
| b2sum | single 10MB binary | 0.0138s | 0.0140s | **1.0x** |
| b2sum | single 100MB text | 0.1226s | 0.1241s | **1.0x** |
| b2sum | -l 256 10MB | 0.0129s | 0.0133s | **1.0x** |
| b2sum | -l 128 10MB | 0.0129s | 0.0132s | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0021s | **0.7x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0015s | 0.0018s | **0.9x** |
| base64 | encode 10MB text | 0.0085s | 0.0058s | **1.5x** |
| base64 | encode 10MB binary | 0.0097s | 0.0062s | **1.6x** |
| base64 | decode 1MB | 0.0037s | 0.0024s | **1.5x** |
| base64 | decode 10MB | 0.0293s | 0.0171s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0085s | 0.0059s | **1.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0069s | 0.0042s | **1.6x** |
| sort | lexicographic 1MB | 0.0074s | 0.0037s | **2.0x** |
| sort | lexicographic 10MB random | 0.0490s | 0.0169s | **2.9x** |
| sort | already sorted 10MB | 0.0242s | 0.0098s | **2.5x** |
| sort | reverse sorted 10MB | 0.0237s | 0.0095s | **2.5x** |
| sort | -n numeric 10MB | 0.0670s | 0.0318s | **2.1x** |
| sort | -r reverse 10MB | 0.0502s | 0.0178s | **2.8x** |
| sort | -u unique 10MB | 0.0522s | 0.0181s | **2.9x** |
| sort | -t, -k2 CSV 10MB | 0.0681s | 0.0298s | **2.3x** |
| sort | repetitive 10MB | 0.0414s | 0.0225s | **1.8x** |
| sort | --parallel=4 10MB | 0.0489s | 0.0177s | **2.8x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0061s | **1.5x** |
| tr | -d digits 10MB | 0.0109s | 0.0107s | **1.0x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0181s | **1.1x** |
| tr | -s spaces 10MB | 0.0167s | 0.0206s | **0.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0060s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0108s | 0.0108s | **1.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0063s | **1.5x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0044s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0054s | **3.0x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0288s | 0.0069s | **4.2x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0045s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0160s | 0.0059s | **2.7x** |
| uniq | repetitive 10MB | 0.0461s | 0.0067s | **6.9x** |
| tac | reverse 100KB text | 0.0007s | 0.0009s | **0.8x** |
| tac | reverse 1MB text | 0.0015s | 0.0014s | **1.1x** |
| tac | reverse 10MB text | 0.0078s | 0.0060s | **1.3x** |
| tac | reverse 100MB text | 0.0757s | 0.0357s | **2.1x** |
| tac | reverse CSV 10MB | 0.0074s | 0.0053s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0162s | 0.0094s | **1.7x** |
| tac | custom separator 1MB | 0.0041s | 0.0032s | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0032s | **1.8x** |
| wc | default 10MB text | 0.0540s | 0.0272s | **2.0x** |
| wc | default 100MB text | 0.4820s | 0.2276s | **2.1x** |
| wc | -l 10MB text | 0.0021s | 0.0024s | **0.9x** |
| wc | -w 10MB text | 0.0542s | 0.0223s | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0539s | 0.0037s | **14.4x** |
| wc | -L 10MB text | 0.0541s | 0.0138s | **3.9x** |
| wc | default 10MB binary | 0.3165s | 0.0850s | **3.7x** |
| wc | default 10MB repetitive | 0.0729s | 0.0312s | **2.3x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0027s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0053s | **4.2x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0056s | **4.0x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0046s | **3.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0076s | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0072s | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0106s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0008s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0017s | **2.0x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0009s | **1.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.3x** |
| sha256sum | single 10MB text | 0.0084s | 0.0081s | **1.0x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0084s | **1.0x** |
| sha256sum | single 100MB text | 0.0741s | 0.0733s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0016s | **0.9x** |
| sha256sum | 100 files | 0.0024s | 0.0041s | **0.6x** |
| md5sum | single 100KB text | 0.0014s | 0.0010s | **1.4x** |
| md5sum | single 1MB text | 0.0029s | 0.0028s | **1.0x** |
| md5sum | single 10MB text | 0.0170s | 0.0202s | **0.8x** |
| md5sum | single 10MB binary | 0.0178s | 0.0210s | **0.8x** |
| md5sum | single 100MB text | 0.1602s | 0.1930s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0016s | **0.9x** |
| md5sum | 100 files | 0.0023s | 0.0042s | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0010s | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0020s | **1.2x** |
| b2sum | single 10MB text | 0.0149s | 0.0118s | **1.3x** |
| b2sum | single 10MB binary | 0.0155s | 0.0124s | **1.3x** |
| b2sum | single 100MB text | 0.1421s | 0.1110s | **1.3x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0119s | **1.2x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0119s | **1.3x** |
| b2sum | 100 files | 0.0022s | 0.0042s | **0.5x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0021s | **1.0x** |
| base64 | encode 10MB text | 0.0121s | 0.0082s | **1.5x** |
| base64 | encode 10MB binary | 0.0127s | 0.0082s | **1.6x** |
| base64 | decode 1MB | 0.0040s | 0.0032s | **1.2x** |
| base64 | decode 10MB | 0.0322s | 0.0198s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0079s | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0053s | **1.6x** |
| sort | lexicographic 1MB | 0.0085s | 0.0040s | **2.1x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0174s | **3.1x** |
| sort | already sorted 10MB | 0.0262s | 0.0122s | **2.2x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0122s | **2.2x** |
| sort | -n numeric 10MB | 0.0729s | 0.0388s | **1.9x** |
| sort | -r reverse 10MB | 0.0543s | 0.0175s | **3.1x** |
| sort | -u unique 10MB | 0.0575s | 0.0181s | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0662s | 0.0320s | **2.1x** |
| sort | repetitive 10MB | 0.0547s | 0.0218s | **2.5x** |
| sort | --parallel=4 10MB | 0.0540s | 0.0191s | **2.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0084s | **1.5x** |
| tr | -d digits 10MB | 0.0165s | 0.0149s | **1.1x** |
| tr | -d lowercase 10MB | 0.0303s | 0.0262s | **1.2x** |
| tr | -s spaces 10MB | 0.0269s | 0.0306s | **0.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0129s | 0.0084s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0147s | **1.1x** |
| tr | translate binary 10MB | 0.0122s | 0.0104s | **1.2x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0043s | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0043s | **3.2x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0044s | **2.7x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0066s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0044s | **2.7x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0044s | **2.7x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0051s | **2.7x** |
| uniq | repetitive 10MB | 0.0420s | 0.0068s | **6.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | **1.2x** |
| tac | reverse 10MB text | 0.0107s | 0.0045s | **2.4x** |
| tac | reverse 100MB text | 0.1024s | 0.0357s | **2.9x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0045s | **2.1x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0081s | **2.9x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | **1.4x** |
