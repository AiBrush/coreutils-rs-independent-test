# fcoreutils v0.0.68 — Detailed Results

Generated: 2026-02-14 13:41:02 UTC

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
| wc | default 100KB text | 0.0010s | 0.0012s | **0.9x** |
| wc | default 1MB text | 0.0039s | 0.0029s | **1.4x** |
| wc | default 10MB text | 0.0339s | 0.0064s | **5.3x** |
| wc | default 100MB text | 0.2897s | 0.0429s | **6.8x** |
| wc | -l 10MB text | 0.0039s | 0.0019s | **2.0x** |
| wc | -w 10MB text | 0.0339s | 0.0063s | **5.4x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0339s | 0.0021s | **15.9x** |
| wc | -L 10MB text | 0.0338s | 0.0061s | **5.5x** |
| wc | default 10MB binary | 0.2359s | 0.0174s | **13.6x** |
| wc | default 10MB repetitive | 0.0506s | 0.0080s | **6.3x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0032s | **5.9x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0030s | **6.1x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0041s | **4.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0046s | **4.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0037s | **6.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0053s | **5.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0022s | **1.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0021s | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | **0.6x** |
| sha256sum | single 10MB text | 0.0070s | 0.0073s | **1.0x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0076s | **1.1x** |
| sha256sum | single 100MB text | 0.0585s | 0.0537s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | **0.9x** |
| md5sum | single 10MB text | 0.0207s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0224s | 0.0171s | **1.3x** |
| md5sum | single 100MB text | 0.1901s | 0.1407s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.5x** |
| md5sum | 100 files | 0.0016s | 0.0024s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0021s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0138s | 0.0124s | **1.1x** |
| b2sum | single 10MB binary | 0.0150s | 0.0132s | **1.1x** |
| b2sum | single 100MB text | 0.1246s | 0.1130s | **1.1x** |
| b2sum | -l 256 10MB | 0.0139s | 0.0124s | **1.1x** |
| b2sum | -l 128 10MB | 0.0139s | 0.0124s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | **1.1x** |
| base64 | encode 10MB text | 0.0091s | 0.0031s | **2.9x** |
| base64 | encode 10MB binary | 0.0102s | 0.0034s | **3.0x** |
| base64 | decode 1MB | 0.0037s | 0.0025s | **1.5x** |
| base64 | decode 10MB | 0.0306s | 0.0152s | **2.0x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0031s | **3.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0028s | **2.5x** |
| sort | lexicographic 1MB | 0.0076s | 0.0028s | **2.7x** |
| sort | lexicographic 10MB random | 0.0506s | 0.0094s | **5.4x** |
| sort | already sorted 10MB | 0.0240s | 0.0035s | **6.9x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0068s | **3.6x** |
| sort | -n numeric 10MB | 0.0686s | 0.0045s | **15.1x** |
| sort | -r reverse 10MB | 0.0509s | 0.0095s | **5.4x** |
| sort | -u unique 10MB | 0.0532s | 0.0125s | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0697s | 0.0233s | **3.0x** |
| sort | repetitive 10MB | 0.0418s | 0.0077s | **5.4x** |
| sort | --parallel=4 10MB | 0.0504s | 0.0093s | **5.4x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0029s | **0.7x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0193s | **0.5x** |
| tr | -d digits 10MB | 0.0110s | 0.0129s | **0.9x** |
| tr | -d lowercase 10MB | 0.0185s | 0.0201s | **0.9x** |
| tr | -s spaces 10MB | 0.0165s | 0.0070s | **2.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0193s | **0.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0132s | **0.8x** |
| tr | translate binary 10MB | 0.0090s | 0.0175s | **0.5x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0161s | 0.0032s | **5.0x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0047s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0065s | **4.5x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0048s | **1.9x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0045s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0042s | **3.8x** |
| uniq | repetitive 10MB | 0.0463s | 0.0041s | **11.3x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0019s | **0.9x** |
| tac | reverse 10MB text | 0.0083s | 0.0046s | **1.8x** |
| tac | reverse 100MB text | 0.0766s | 0.0378s | **2.0x** |
| tac | reverse CSV 10MB | 0.0078s | 0.0047s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0169s | 0.0095s | **1.8x** |
| tac | custom separator 1MB | 0.0043s | 0.0041s | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0060s | 0.0030s | **2.0x** |
| wc | default 10MB text | 0.0549s | 0.0032s | **17.0x** |
| wc | default 100MB text | 0.4842s | 0.0156s | **31.0x** |
| wc | -l 10MB text | 0.0022s | 0.0027s | **0.8x** |
| wc | -w 10MB text | 0.0551s | 0.0114s | **4.8x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | **0.8x** |
| wc | -m 10MB text | 0.0549s | 0.0032s | **17.0x** |
| wc | -L 10MB text | 0.0548s | 0.0105s | **5.2x** |
| wc | default 10MB binary | 0.3180s | 0.0281s | **11.3x** |
| wc | default 10MB repetitive | 0.0735s | 0.0049s | **14.9x** |
| wc | 10 files | 0.0015s | 0.0013s | **1.2x** |
| wc | 100 files | 0.0019s | 0.0020s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0234s | 0.0048s | **4.9x** |
| cut | -c1-100 10MB CSV | 0.0233s | 0.0048s | **4.8x** |
| cut | -d, -f1 10MB CSV | 0.0173s | 0.0060s | **2.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0227s | 0.0077s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0248s | 0.0065s | **3.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0089s | **3.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0013s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0031s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0026s | **0.5x** |
| sha256sum | single 1MB text | 0.0023s | 0.0036s | **0.6x** |
| sha256sum | single 10MB text | 0.0092s | 0.0106s | **0.9x** |
| sha256sum | single 10MB binary | 0.0096s | 0.0107s | **0.9x** |
| sha256sum | single 100MB text | 0.0758s | 0.0762s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0028s | 0.0038s | **0.7x** |
| md5sum | single 100KB text | 0.0018s | 0.0033s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0044s | **0.7x** |
| md5sum | single 10MB text | 0.0179s | 0.0186s | **1.0x** |
| md5sum | single 10MB binary | 0.0186s | 0.0194s | **1.0x** |
| md5sum | single 100MB text | 0.1617s | 0.1538s | **1.1x** |
| md5sum | 10 files | 0.0015s | 0.0030s | **0.5x** |
| md5sum | 100 files | 0.0024s | 0.0034s | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0025s | 0.0025s | **1.0x** |
| b2sum | single 10MB text | 0.0156s | 0.0127s | **1.2x** |
| b2sum | single 10MB binary | 0.0162s | 0.0133s | **1.2x** |
| b2sum | single 100MB text | 0.1434s | 0.1129s | **1.3x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0126s | **1.2x** |
| b2sum | -l 128 10MB | 0.0157s | 0.0128s | **1.2x** |
| b2sum | 100 files | 0.0024s | 0.0020s | **1.2x** |
| base64 | encode 100KB text | 0.0013s | 0.0011s | **1.1x** |
| base64 | encode 1MB text | 0.0025s | 0.0020s | **1.2x** |
| base64 | encode 10MB text | 0.0133s | 0.0052s | **2.6x** |
| base64 | encode 10MB binary | 0.0136s | 0.0056s | **2.4x** |
| base64 | decode 1MB | 0.0042s | 0.0032s | **1.3x** |
| base64 | decode 10MB | 0.0333s | 0.0222s | **1.5x** |
| base64 | encode -w 76 10MB | 0.0130s | 0.0060s | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0092s | 0.0039s | **2.3x** |
| sort | lexicographic 1MB | 0.0091s | 0.0039s | **2.3x** |
| sort | lexicographic 10MB random | 0.0570s | 0.0127s | **4.5x** |
| sort | already sorted 10MB | 0.0270s | 0.0052s | **5.2x** |
| sort | reverse sorted 10MB | 0.0278s | 0.0097s | **2.9x** |
| sort | -n numeric 10MB | 0.0750s | 0.0061s | **12.3x** |
| sort | -r reverse 10MB | 0.0560s | 0.0128s | **4.4x** |
| sort | -u unique 10MB | 0.0599s | 0.0162s | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0691s | 0.0297s | **2.3x** |
| sort | repetitive 10MB | 0.0563s | 0.0101s | **5.6x** |
| sort | --parallel=4 10MB | 0.0583s | 0.0124s | **4.7x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0020s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0134s | 0.0065s | **2.1x** |
| tr | -d digits 10MB | 0.0204s | 0.0137s | **1.5x** |
| tr | -d lowercase 10MB | 0.0300s | 0.0129s | **2.3x** |
| tr | -s spaces 10MB | 0.0278s | 0.0068s | **4.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0136s | 0.0067s | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0173s | 0.0134s | **1.3x** |
| tr | translate binary 10MB | 0.0110s | 0.0069s | **1.6x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0053s | **2.3x** |
| uniq | default 10MB sorted (low dup) | 0.0146s | 0.0039s | **3.7x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0048s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0086s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0125s | 0.0048s | **2.6x** |
| uniq | -u unique only 10MB | 0.0124s | 0.0049s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0146s | 0.0054s | **2.7x** |
| uniq | repetitive 10MB | 0.0425s | 0.0053s | **8.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | **0.8x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | **1.0x** |
| tac | reverse 10MB text | 0.0111s | 0.0054s | **2.0x** |
| tac | reverse 100MB text | 0.1048s | 0.0434s | **2.4x** |
| tac | reverse CSV 10MB | 0.0102s | 0.0060s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0114s | **2.1x** |
| tac | custom separator 1MB | 0.0064s | 0.0055s | **1.1x** |
