# fcoreutils v0.0.69 — Detailed Results

Generated: 2026-02-14 22:22:11 UTC

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
| wc | default 100KB text | 0.0010s | 0.0010s | **1.0x** |
| wc | default 1MB text | 0.0038s | 0.0025s | **1.5x** |
| wc | default 10MB text | 0.0335s | 0.0068s | **4.9x** |
| wc | default 100MB text | 0.2957s | 0.0450s | **6.6x** |
| wc | -l 10MB text | 0.0037s | 0.0019s | **2.0x** |
| wc | -w 10MB text | 0.0336s | 0.0061s | **5.5x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0335s | 0.0020s | **16.4x** |
| wc | -L 10MB text | 0.0335s | 0.0058s | **5.8x** |
| wc | default 10MB binary | 0.2356s | 0.0168s | **14.0x** |
| wc | default 10MB repetitive | 0.0518s | 0.0082s | **6.3x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.8x** |
| wc | 100 files | 0.0012s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0035s | **5.4x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0035s | **5.3x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0047s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0048s | **4.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0040s | **5.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0050s | **5.4x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0021s | **1.7x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | **0.6x** |
| sha256sum | single 10MB text | 0.0068s | 0.0072s | **0.9x** |
| sha256sum | single 10MB binary | 0.0078s | 0.0075s | **1.0x** |
| sha256sum | single 100MB text | 0.0645s | 0.0555s | **1.2x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | **0.5x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0035s | **0.9x** |
| md5sum | single 10MB text | 0.0205s | 0.0162s | **1.3x** |
| md5sum | single 10MB binary | 0.0221s | 0.0171s | **1.3x** |
| md5sum | single 100MB text | 0.1958s | 0.1424s | **1.4x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0135s | 0.0124s | **1.1x** |
| b2sum | single 10MB binary | 0.0147s | 0.0131s | **1.1x** |
| b2sum | single 100MB text | 0.1307s | 0.1151s | **1.1x** |
| b2sum | -l 256 10MB | 0.0134s | 0.0123s | **1.1x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0124s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | **1.1x** |
| base64 | encode 10MB text | 0.0092s | 0.0032s | **2.9x** |
| base64 | encode 10MB binary | 0.0099s | 0.0032s | **3.1x** |
| base64 | decode 1MB | 0.0037s | 0.0025s | **1.5x** |
| base64 | decode 10MB | 0.0300s | 0.0145s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0092s | 0.0031s | **2.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0070s | 0.0029s | **2.5x** |
| sort | lexicographic 1MB | 0.0075s | 0.0036s | **2.1x** |
| sort | lexicographic 10MB random | 0.0493s | 0.0095s | **5.2x** |
| sort | already sorted 10MB | 0.0241s | 0.0036s | **6.8x** |
| sort | reverse sorted 10MB | 0.0241s | 0.0067s | **3.6x** |
| sort | -n numeric 10MB | 0.0671s | 0.0038s | **17.8x** |
| sort | -r reverse 10MB | 0.0507s | 0.0098s | **5.2x** |
| sort | -u unique 10MB | 0.0524s | 0.0128s | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0697s | 0.0220s | **3.2x** |
| sort | repetitive 10MB | 0.0416s | 0.0080s | **5.2x** |
| sort | --parallel=4 10MB | 0.0488s | 0.0093s | **5.2x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0028s | **0.7x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0188s | **0.5x** |
| tr | -d digits 10MB | 0.0109s | 0.0133s | **0.8x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0194s | **1.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0062s | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0188s | **0.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0109s | 0.0133s | **0.8x** |
| tr | translate binary 10MB | 0.0093s | 0.0171s | **0.5x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0027s | **3.4x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0031s | **5.4x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0053s | **1.8x** |
| uniq | -c count 10MB sorted | 0.0297s | 0.0067s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0043s | **3.8x** |
| uniq | repetitive 10MB | 0.0463s | 0.0032s | **14.6x** |
| tac | reverse 100KB text | 0.0008s | 0.0012s | **0.7x** |
| tac | reverse 1MB text | 0.0016s | 0.0019s | **0.8x** |
| tac | reverse 10MB text | 0.0082s | 0.0060s | **1.4x** |
| tac | reverse 100MB text | 0.0819s | 0.0491s | **1.7x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0052s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0168s | 0.0097s | **1.7x** |
| tac | custom separator 1MB | 0.0043s | 0.0035s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0029s | **2.0x** |
| wc | default 10MB text | 0.0553s | 0.0029s | **19.1x** |
| wc | default 100MB text | 0.4829s | 0.0139s | **34.7x** |
| wc | -l 10MB text | 0.0021s | 0.0024s | **0.9x** |
| wc | -w 10MB text | 0.0543s | 0.0090s | **6.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0547s | 0.0032s | **17.3x** |
| wc | -L 10MB text | 0.0562s | 0.0100s | **5.6x** |
| wc | default 10MB binary | 0.3204s | 0.0275s | **11.7x** |
| wc | default 10MB repetitive | 0.0730s | 0.0048s | **15.3x** |
| wc | 10 files | 0.0010s | 0.0013s | **0.8x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0053s | **4.3x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0053s | **4.2x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0051s | **3.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0239s | 0.0083s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0057s | **4.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0082s | **3.8x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | **0.7x** |
| sha256sum | single 10MB text | 0.0089s | 0.0098s | **0.9x** |
| sha256sum | single 10MB binary | 0.0091s | 0.0102s | **0.9x** |
| sha256sum | single 100MB text | 0.0749s | 0.0756s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0026s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0039s | **0.7x** |
| md5sum | single 10MB text | 0.0172s | 0.0176s | **1.0x** |
| md5sum | single 10MB binary | 0.0181s | 0.0183s | **1.0x** |
| md5sum | single 100MB text | 0.1609s | 0.1536s | **1.0x** |
| md5sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0033s | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | **1.1x** |
| b2sum | single 10MB text | 0.0151s | 0.0125s | **1.2x** |
| b2sum | single 10MB binary | 0.0158s | 0.0131s | **1.2x** |
| b2sum | single 100MB text | 0.1426s | 0.1128s | **1.3x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0123s | **1.2x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0122s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | **1.4x** |
| base64 | encode 10MB text | 0.0126s | 0.0048s | **2.6x** |
| base64 | encode 10MB binary | 0.0131s | 0.0051s | **2.5x** |
| base64 | decode 1MB | 0.0040s | 0.0030s | **1.3x** |
| base64 | decode 10MB | 0.0331s | 0.0221s | **1.5x** |
| base64 | encode -w 76 10MB | 0.0128s | 0.0050s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0092s | 0.0039s | **2.4x** |
| sort | lexicographic 1MB | 0.0093s | 0.0047s | **2.0x** |
| sort | lexicographic 10MB random | 0.0572s | 0.0126s | **4.5x** |
| sort | already sorted 10MB | 0.0269s | 0.0052s | **5.1x** |
| sort | reverse sorted 10MB | 0.0280s | 0.0104s | **2.7x** |
| sort | -n numeric 10MB | 0.0793s | 0.0056s | **14.1x** |
| sort | -r reverse 10MB | 0.0555s | 0.0114s | **4.9x** |
| sort | -u unique 10MB | 0.0599s | 0.0146s | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0686s | 0.0278s | **2.5x** |
| sort | repetitive 10MB | 0.0552s | 0.0098s | **5.6x** |
| sort | --parallel=4 10MB | 0.0554s | 0.0118s | **4.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0130s | 0.0069s | **1.9x** |
| tr | -d digits 10MB | 0.0169s | 0.0132s | **1.3x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0132s | **2.3x** |
| tr | -s spaces 10MB | 0.0288s | 0.0068s | **4.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0068s | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0132s | **1.3x** |
| tr | translate binary 10MB | 0.0113s | 0.0067s | **1.7x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0035s | **3.3x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0037s | **3.8x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0047s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0307s | 0.0084s | **3.6x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0046s | **2.6x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0046s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0049s | **2.9x** |
| uniq | repetitive 10MB | 0.0425s | 0.0043s | **9.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0014s | **0.7x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | **1.0x** |
| tac | reverse 10MB text | 0.0105s | 0.0076s | **1.4x** |
| tac | reverse 100MB text | 0.1036s | 0.0551s | **1.9x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0063s | **1.5x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0111s | **2.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0041s | **1.4x** |
