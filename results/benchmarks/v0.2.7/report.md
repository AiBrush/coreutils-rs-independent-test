# fcoreutils v0.2.7 — Detailed Results

Generated: 2026-02-17 06:44:37 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 826/826 (100.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0065s | 0.0259s | **5.3x** | **4.0x** |
| wc | default 100MB text | 0.3002s | 0.0447s | 0.2278s | **6.7x** | **5.1x** |
| wc | -l 10MB text | 0.0042s | 0.0020s | 0.0026s | **2.1x** | **1.3x** |
| wc | -w 10MB text | 0.0346s | 0.0061s | 0.0233s | **5.7x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0344s | 0.0022s | 0.0027s | **15.4x** | **1.2x** |
| wc | -L 10MB text | 0.0345s | 0.0064s | 0.0175s | **5.4x** | **2.7x** |
| wc | default 10MB binary | 0.2345s | 0.0170s | 0.1179s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0517s | 0.0080s | 0.0366s | **6.5x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0037s | 0.0060s | **4.9x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0038s | 0.0060s | **4.8x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0046s | 0.0071s | **4.0x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0047s | 0.0162s | **4.5x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0231s | 0.0037s | 0.0125s | **6.2x** | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0033s | 0.0161s | **8.1x** | **5.0x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0020s | 0.0017s | **1.7x** | **0.9x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0076s | 0.0073s | 0.0274s | **1.0x** | **3.8x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0074s | 0.0289s | **1.0x** | **3.9x** |
| sha256sum | single 100MB text | 0.0693s | 0.0565s | 0.2635s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0018s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0019s | 0.0017s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0213s | 0.0161s | 0.0177s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0222s | 0.0169s | 0.0185s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2013s | 0.1446s | 0.1668s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0018s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0020s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0141s | 0.0124s | 0.0137s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0148s | 0.0129s | 0.0144s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1356s | 0.1171s | 0.1296s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0124s | 0.0139s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0141s | 0.0124s | 0.0134s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0009s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0094s | 0.0033s | 0.0073s | **2.8x** | **2.2x** |
| base64 | encode 10MB binary | 0.0103s | 0.0032s | 0.0074s | **3.2x** | **2.3x** |
| base64 | decode 1MB | 0.0037s | 0.0015s | 0.0035s | **2.4x** | **2.3x** |
| base64 | decode 10MB | 0.0306s | 0.0057s | 0.0269s | **5.3x** | **4.7x** |
| base64 | encode -w 76 10MB | 0.0096s | 0.0034s | 0.0072s | **2.8x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0029s | 0.0073s | **2.7x** | **2.5x** |
| sort | lexicographic 1MB | 0.0074s | 0.0025s | 0.0040s | **3.0x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0508s | 0.0063s | 0.0292s | **8.1x** | **4.6x** |
| sort | already sorted 10MB | 0.0246s | 0.0031s | 0.0136s | **7.9x** | **4.4x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0046s | 0.0139s | **5.3x** | **3.0x** |
| sort | -n numeric 10MB | 0.0686s | 0.0038s | 0.0606s | **17.9x** | **15.8x** |
| sort | -r reverse 10MB | 0.0511s | 0.0064s | 0.0299s | **8.0x** | **4.7x** |
| sort | -u unique 10MB | 0.0533s | 0.0082s | 0.0350s | **6.5x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0702s | 0.0145s | 0.0680s | **4.8x** | **4.7x** |
| sort | repetitive 10MB | 0.0450s | 0.0096s | 0.0355s | **4.7x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0501s | 0.0062s | 0.0290s | **8.1x** | **4.7x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | 0.0017s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0042s | 0.0067s | **2.2x** | **1.6x** |
| tr | -d digits 10MB | 0.0111s | 0.0052s | 0.0102s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0068s | 0.0169s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0165s | 0.0040s | 0.0113s | **4.2x** | **2.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0086s | 0.0038s | 0.0066s | **2.2x** | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0051s | 0.0101s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0093s | 0.0042s | 0.0078s | **2.2x** | **1.9x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0027s | 0.0088s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0030s | 0.0096s | **5.5x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0030s | 0.0088s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0068s | 0.0114s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0027s | 0.0087s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0039s | 0.0096s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0476s | 0.0036s | 0.0143s | **13.4x** | **4.0x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0015s | 0.0014s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0087s | 0.0038s | 0.0050s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.0859s | 0.0227s | 0.0434s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0037s | 0.0044s | **2.2x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0179s | 0.0068s | 0.0087s | **2.6x** | **1.3x** |
| tac | custom separator 1MB | 0.0043s | 0.0034s | 0.0037s | **1.3x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0015s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0058s | 0.0030s | 0.0039s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0547s | 0.0032s | 0.0307s | **16.9x** | **9.5x** |
| wc | default 100MB text | 0.4867s | 0.0153s | 0.2561s | **31.8x** | **16.7x** |
| wc | -l 10MB text | 0.0023s | 0.0026s | 0.0024s | **0.9x** | **0.9x** |
| wc | -w 10MB text | 0.0548s | 0.0111s | 0.0264s | **4.9x** | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0548s | 0.0032s | 0.0023s | **17.4x** | **0.7x** |
| wc | -L 10MB text | 0.0542s | 0.0105s | 0.0204s | **5.2x** | **1.9x** |
| wc | default 10MB binary | 0.3198s | 0.0277s | 0.1540s | **11.5x** | **5.6x** |
| wc | default 10MB repetitive | 0.0733s | 0.0049s | 0.0402s | **14.9x** | **8.2x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0022s | 0.0019s | 0.0023s | **1.2x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0232s | 0.0045s | 0.0078s | **5.2x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0234s | 0.0047s | 0.0080s | **4.9x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0171s | 0.0053s | 0.0093s | **3.2x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0225s | 0.0068s | 0.0180s | **3.3x** | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0053s | 0.0140s | **4.6x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0049s | 0.0170s | **6.4x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | 0.0021s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| sha256sum | single 100KB text | 0.0014s | 0.0025s | 0.0015s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0022s | 0.0033s | 0.0021s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0093s | 0.0104s | 0.0092s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0096s | 0.0106s | 0.0096s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0758s | 0.0761s | 0.0756s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0026s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0025s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0040s | 0.0034s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0177s | 0.0180s | 0.0219s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0184s | 0.0185s | 0.0229s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1612s | 0.1532s | 0.2028s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0153s | 0.0122s | 0.0128s | **1.3x** | **1.0x** |
| b2sum | single 10MB binary | 0.0160s | 0.0130s | 0.0132s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1431s | 0.1123s | 0.1128s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0123s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0124s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0023s | 0.0023s | 0.0024s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | 0.0019s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0130s | 0.0050s | 0.0086s | **2.6x** | **1.7x** |
| base64 | encode 10MB binary | 0.0134s | 0.0055s | 0.0089s | **2.4x** | **1.6x** |
| base64 | decode 1MB | 0.0040s | 0.0015s | 0.0044s | **2.8x** | **3.0x** |
| base64 | decode 10MB | 0.0333s | 0.0061s | 0.0345s | **5.5x** | **5.7x** |
| base64 | encode -w 76 10MB | 0.0127s | 0.0051s | 0.0085s | **2.5x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0090s | 0.0040s | 0.0077s | **2.2x** | **1.9x** |
| sort | lexicographic 1MB | 0.0112s | 0.0036s | 0.0056s | **3.1x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0560s | 0.0097s | 0.0362s | **5.8x** | **3.7x** |
| sort | already sorted 10MB | 0.0273s | 0.0048s | 0.0183s | **5.7x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0282s | 0.0069s | 0.0184s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0758s | 0.0060s | 0.0831s | **12.7x** | **13.9x** |
| sort | -r reverse 10MB | 0.0563s | 0.0097s | 0.0368s | **5.8x** | **3.8x** |
| sort | -u unique 10MB | 0.0600s | 0.0105s | 0.0405s | **5.7x** | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0686s | 0.0199s | 0.0866s | **3.5x** | **4.4x** |
| sort | repetitive 10MB | 0.0549s | 0.0119s | 0.0372s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0584s | 0.0099s | 0.0366s | **5.9x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0021s | **1.4x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0129s | 0.0041s | 0.0076s | **3.2x** | **1.9x** |
| tr | -d digits 10MB | 0.0181s | 0.0045s | 0.0143s | **4.0x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0309s | 0.0050s | 0.0232s | **6.1x** | **4.6x** |
| tr | -s spaces 10MB | 0.0260s | 0.0039s | 0.0273s | **6.6x** | **6.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0038s | 0.0079s | **3.3x** | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0168s | 0.0045s | 0.0143s | **3.7x** | **3.2x** |
| tr | translate binary 10MB | 0.0112s | 0.0042s | 0.0085s | **2.7x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0037s | 0.0117s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0143s | 0.0039s | 0.0138s | **3.7x** | **3.5x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0036s | 0.0113s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0094s | 0.0161s | **3.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0038s | 0.0116s | **3.2x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0038s | 0.0118s | **3.2x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0144s | 0.0049s | 0.0140s | **2.9x** | **2.8x** |
| uniq | repetitive 10MB | 0.0423s | 0.0041s | 0.0167s | **10.2x** | **4.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0113s | 0.0048s | 0.0062s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1040s | 0.0291s | 0.0536s | **3.6x** | **1.8x** |
| tac | reverse CSV 10MB | 0.0100s | 0.0052s | 0.0061s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0092s | 0.0119s | **2.6x** | **1.3x** |
| tac | custom separator 1MB | 0.0062s | 0.0044s | 0.0057s | **1.4x** | **1.3x** |
