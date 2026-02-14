# fcoreutils v0.0.67 — Detailed Results

Generated: 2026-02-14 13:59:11 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 826/826 (100.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0014s | **0.8x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0335s | 0.0063s | **5.4x** |
| wc | default 100MB text | 0.2895s | 0.0421s | **6.9x** |
| wc | -l 10MB text | 0.0036s | 0.0021s | **1.7x** |
| wc | -w 10MB text | 0.0336s | 0.0061s | **5.5x** |
| wc | -c 10MB text | 0.0007s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0335s | 0.0021s | **16.0x** |
| wc | -L 10MB text | 0.0335s | 0.0065s | **5.1x** |
| wc | default 10MB binary | 0.2348s | 0.0181s | **13.0x** |
| wc | default 10MB repetitive | 0.0500s | 0.0079s | **6.3x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0031s | **5.9x** |
| cut | -c1-100 10MB CSV | 0.0181s | 0.0032s | **5.7x** |
| cut | -d, -f1 10MB CSV | 0.0182s | 0.0043s | **4.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0207s | 0.0045s | **4.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0226s | 0.0036s | **6.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0259s | 0.0057s | **4.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0022s | **1.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0010s | 0.0023s | **0.4x** |
| sha256sum | single 1MB text | 0.0017s | 0.0028s | **0.6x** |
| sha256sum | single 10MB text | 0.0066s | 0.0072s | **0.9x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0075s | **1.0x** |
| sha256sum | single 100MB text | 0.0583s | 0.0533s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0022s | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0036s | **0.9x** |
| md5sum | single 10MB text | 0.0203s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0220s | 0.0170s | **1.3x** |
| md5sum | single 100MB text | 0.1891s | 0.1410s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.5x** |
| md5sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0021s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0133s | 0.0123s | **1.1x** |
| b2sum | single 10MB binary | 0.0148s | 0.0130s | **1.1x** |
| b2sum | single 100MB text | 0.1237s | 0.1112s | **1.1x** |
| b2sum | -l 256 10MB | 0.0130s | 0.0124s | **1.1x** |
| b2sum | -l 128 10MB | 0.0132s | 0.0123s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 10MB text | 0.0093s | 0.0034s | **2.7x** |
| base64 | encode 10MB binary | 0.0102s | 0.0033s | **3.1x** |
| base64 | decode 1MB | 0.0038s | 0.0022s | **1.7x** |
| base64 | decode 10MB | 0.0305s | 0.0110s | **2.8x** |
| base64 | encode -w 76 10MB | 0.0092s | 0.0032s | **2.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0069s | 0.0028s | **2.4x** |
| sort | lexicographic 1MB | 0.0076s | 0.0026s | **2.9x** |
| sort | lexicographic 10MB random | 0.0507s | 0.0060s | **8.5x** |
| sort | already sorted 10MB | 0.0246s | 0.0036s | **6.9x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0051s | **4.8x** |
| sort | -n numeric 10MB | 0.0686s | 0.0476s | **1.4x** |
| sort | -r reverse 10MB | 0.0510s | 0.0063s | **8.1x** |
| sort | -u unique 10MB | 0.0531s | 0.0128s | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0688s | 0.0166s | **4.1x** |
| sort | repetitive 10MB | 0.0414s | 0.0078s | **5.3x** |
| sort | --parallel=4 10MB | 0.0504s | 0.0056s | **8.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0029s | **0.8x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0185s | **0.5x** |
| tr | -d digits 10MB | 0.0111s | 0.0124s | **0.9x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0190s | **1.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0061s | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0191s | **0.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0121s | **0.9x** |
| tr | translate binary 10MB | 0.0092s | 0.0170s | **0.5x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0028s | **5.9x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0048s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0058s | **5.0x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0047s | **1.9x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0047s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0043s | **3.8x** |
| uniq | repetitive 10MB | 0.0463s | 0.0039s | **11.7x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.7x** |
| tac | reverse 1MB text | 0.0016s | 0.0019s | **0.9x** |
| tac | reverse 10MB text | 0.0081s | 0.0051s | **1.6x** |
| tac | reverse 100MB text | 0.0762s | 0.0362s | **2.1x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0048s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0169s | 0.0094s | **1.8x** |
| tac | custom separator 1MB | 0.0044s | 0.0036s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0547s | 0.0032s | **17.0x** |
| wc | default 100MB text | 0.4832s | 0.0151s | **32.0x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | **0.8x** |
| wc | -w 10MB text | 0.0545s | 0.0109s | **5.0x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0545s | 0.0031s | **17.7x** |
| wc | -L 10MB text | 0.0546s | 0.0104s | **5.3x** |
| wc | default 10MB binary | 0.3179s | 0.0277s | **11.5x** |
| wc | default 10MB repetitive | 0.0734s | 0.0048s | **15.3x** |
| wc | 10 files | 0.0010s | 0.0012s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0230s | 0.0044s | **5.2x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0045s | **5.1x** |
| cut | -d, -f1 10MB CSV | 0.0169s | 0.0054s | **3.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0223s | 0.0083s | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0057s | **4.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0310s | 0.0083s | **3.7x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0087s | 0.0097s | **0.9x** |
| sha256sum | single 10MB binary | 0.0091s | 0.0102s | **0.9x** |
| sha256sum | single 100MB text | 0.0757s | 0.0761s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0032s | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0026s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | **0.8x** |
| md5sum | single 10MB text | 0.0176s | 0.0176s | **1.0x** |
| md5sum | single 10MB binary | 0.0182s | 0.0184s | **1.0x** |
| md5sum | single 100MB text | 0.1610s | 0.1533s | **1.1x** |
| md5sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0031s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.9x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0152s | 0.0123s | **1.2x** |
| b2sum | single 10MB binary | 0.0159s | 0.0129s | **1.2x** |
| b2sum | single 100MB text | 0.1430s | 0.1122s | **1.3x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0124s | **1.2x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0123s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0128s | 0.0051s | **2.5x** |
| base64 | encode 10MB binary | 0.0130s | 0.0053s | **2.4x** |
| base64 | decode 1MB | 0.0040s | 0.0027s | **1.5x** |
| base64 | decode 10MB | 0.0329s | 0.0172s | **1.9x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0050s | **2.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0038s | **2.3x** |
| sort | lexicographic 1MB | 0.0086s | 0.0036s | **2.4x** |
| sort | lexicographic 10MB random | 0.0549s | 0.0095s | **5.8x** |
| sort | already sorted 10MB | 0.0266s | 0.0053s | **5.0x** |
| sort | reverse sorted 10MB | 0.0278s | 0.0077s | **3.6x** |
| sort | -n numeric 10MB | 0.0743s | 0.0489s | **1.5x** |
| sort | -r reverse 10MB | 0.0554s | 0.0096s | **5.8x** |
| sort | -u unique 10MB | 0.0589s | 0.0147s | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0675s | 0.0240s | **2.8x** |
| sort | repetitive 10MB | 0.0551s | 0.0102s | **5.4x** |
| sort | --parallel=4 10MB | 0.0552s | 0.0098s | **5.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0137s | 0.0066s | **2.1x** |
| tr | -d digits 10MB | 0.0161s | 0.0134s | **1.2x** |
| tr | -d lowercase 10MB | 0.0292s | 0.0130s | **2.2x** |
| tr | -s spaces 10MB | 0.0280s | 0.0071s | **4.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0134s | 0.0067s | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0162s | 0.0135s | **1.2x** |
| tr | translate binary 10MB | 0.0117s | 0.0069s | **1.7x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0049s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0038s | **3.8x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0048s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0076s | **3.9x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0048s | **2.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0048s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0153s | 0.0052s | **2.9x** |
| uniq | repetitive 10MB | 0.0424s | 0.0055s | **7.7x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | **0.8x** |
| tac | reverse 1MB text | 0.0019s | 0.0019s | **1.0x** |
| tac | reverse 10MB text | 0.0109s | 0.0068s | **1.6x** |
| tac | reverse 100MB text | 0.1051s | 0.0455s | **2.3x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0066s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0116s | **2.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0041s | **1.4x** |
