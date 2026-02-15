# fcoreutils v0.1.4 — Detailed Results

Generated: 2026-02-15 08:51:34 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0345s | 0.0063s | 0.0252s | **5.5x** | **4.0x** |
| wc | default 100MB text | 0.2988s | 0.0451s | 0.2209s | **6.6x** | **4.9x** |
| wc | -l 10MB text | 0.0044s | 0.0022s | 0.0028s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0343s | 0.0063s | 0.0216s | **5.4x** | **3.4x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0343s | 0.0025s | 0.0031s | **13.6x** | **1.2x** |
| wc | -L 10MB text | 0.0343s | 0.0063s | 0.0177s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2340s | 0.0169s | 0.1142s | **13.8x** | **6.8x** |
| wc | default 10MB repetitive | 0.0542s | 0.0084s | 0.0380s | **6.4x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0017s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0035s | 0.0065s | **5.4x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0035s | 0.0065s | **5.3x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0043s | 0.0072s | **4.5x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0055s | 0.0167s | **3.9x** | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0038s | 0.0128s | **6.2x** | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0035s | 0.0164s | **7.6x** | **4.7x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | 0.0019s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0027s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0076s | 0.0074s | 0.0275s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0075s | 0.0076s | 0.0287s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0684s | 0.0565s | 0.2629s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0012s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0025s | 0.0017s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0012s | **0.6x** | **0.5x** |
| md5sum | single 1MB text | 0.0032s | 0.0038s | 0.0029s | **0.8x** | **0.7x** |
| md5sum | single 10MB text | 0.0213s | 0.0163s | 0.0178s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0221s | 0.0169s | 0.0184s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2005s | 0.1440s | 0.1661s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0021s | 0.0012s | **0.5x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0026s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | 0.0013s | **0.7x** | **1.0x** |
| b2sum | single 1MB text | 0.0022s | 0.0024s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0143s | 0.0126s | 0.0140s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0148s | 0.0130s | 0.0145s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1351s | 0.1162s | 0.1294s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0126s | 0.0139s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0126s | 0.0140s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0015s | 0.0017s | **1.1x** | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0100s | 0.0053s | 0.0071s | **1.9x** | **1.3x** |
| base64 | encode 10MB binary | 0.0102s | 0.0056s | 0.0074s | **1.8x** | **1.3x** |
| base64 | decode 1MB | 0.0039s | 0.0019s | 0.0035s | **2.0x** | **1.8x** |
| base64 | decode 10MB | 0.0308s | 0.0114s | 0.0263s | **2.7x** | **2.3x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0055s | 0.0071s | **1.8x** | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0045s | 0.0073s | **1.8x** | **1.6x** |
| sort | lexicographic 1MB | 0.0076s | 0.0028s | 0.0043s | **2.7x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0528s | 0.0108s | 0.0311s | **4.9x** | **2.9x** |
| sort | already sorted 10MB | 0.0254s | 0.0038s | 0.0139s | **6.6x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0254s | 0.0057s | 0.0145s | **4.4x** | **2.6x** |
| sort | -n numeric 10MB | 0.0716s | 0.0041s | 0.0676s | **17.3x** | **16.4x** |
| sort | -r reverse 10MB | 0.0533s | 0.0104s | 0.0314s | **5.1x** | **3.0x** |
| sort | -u unique 10MB | 0.0554s | 0.0101s | 0.0385s | **5.5x** | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0729s | 0.0518s | 0.0726s | **1.4x** | **1.4x** |
| sort | repetitive 10MB | 0.0468s | 0.0105s | 0.0381s | **4.4x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0581s | 0.0101s | 0.0292s | **5.7x** | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0019s | 0.0019s | **1.0x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0073s | 0.0068s | **1.2x** | **0.9x** |
| tr | -d digits 10MB | 0.0110s | 0.0133s | 0.0108s | **0.8x** | **0.8x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0201s | 0.0173s | **1.0x** | **0.9x** |
| tr | -s spaces 10MB | 0.0168s | 0.0071s | 0.0114s | **2.3x** | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0072s | 0.0069s | **1.2x** | **1.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0136s | 0.0105s | **0.8x** | **0.8x** |
| tr | translate binary 10MB | 0.0091s | 0.0074s | 0.0079s | **1.2x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0028s | 0.0089s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0165s | 0.0029s | 0.0102s | **5.6x** | **3.5x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0031s | 0.0090s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0071s | 0.0120s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0028s | 0.0090s | **3.4x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0028s | 0.0091s | **3.2x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0041s | 0.0102s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0489s | 0.0034s | 0.0155s | **14.4x** | **4.6x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.8x** | **0.9x** |
| tac | reverse 1MB text | 0.0017s | 0.0016s | 0.0015s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0086s | 0.0045s | 0.0049s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0855s | 0.0403s | 0.0430s | **2.1x** | **1.1x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0046s | 0.0045s | **1.8x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0193s | 0.0095s | 0.0087s | **2.0x** | **0.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0038s | 0.0039s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0030s | 0.0044s | **1.9x** | **1.5x** |
| wc | default 10MB text | 0.0544s | 0.0032s | 0.0363s | **17.2x** | **11.5x** |
| wc | default 100MB text | 0.4834s | 0.0145s | 0.3159s | **33.2x** | **21.7x** |
| wc | -l 10MB text | 0.0023s | 0.0027s | 0.0026s | **0.9x** | **0.9x** |
| wc | -w 10MB text | 0.0549s | 0.0093s | 0.0277s | **5.9x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0013s | 0.0013s | **0.7x** | **1.0x** |
| wc | -m 10MB text | 0.0549s | 0.0035s | 0.0027s | **15.9x** | **0.8x** |
| wc | -L 10MB text | 0.0550s | 0.0104s | 0.0171s | **5.3x** | **1.7x** |
| wc | default 10MB binary | 0.3181s | 0.0275s | 0.1587s | **11.6x** | **5.8x** |
| wc | default 10MB repetitive | 0.0738s | 0.0053s | 0.0530s | **13.9x** | **10.0x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0015s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0239s | 0.0059s | 0.0078s | **4.0x** | **1.3x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0055s | 0.0076s | **4.1x** | **1.4x** |
| cut | -d, -f1 10MB CSV | 0.0169s | 0.0052s | 0.0094s | **3.3x** | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0224s | 0.0084s | 0.0180s | **2.7x** | **2.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0245s | 0.0055s | 0.0138s | **4.5x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0308s | 0.0049s | 0.0168s | **6.3x** | **3.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0031s | 0.0020s | **1.1x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0025s | 0.0014s | **0.6x** | **0.5x** |
| sha256sum | single 1MB text | 0.0021s | 0.0031s | 0.0021s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0089s | 0.0098s | 0.0089s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0094s | 0.0106s | 0.0093s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0764s | 0.0764s | 0.0762s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0025s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0032s | 0.0024s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0026s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0040s | 0.0033s | **0.8x** | **0.8x** |
| md5sum | single 10MB text | 0.0179s | 0.0179s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0183s | 0.0185s | 0.0227s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1621s | 0.1540s | 0.2043s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0015s | 0.0025s | 0.0014s | **0.6x** | **0.5x** |
| md5sum | 100 files | 0.0024s | 0.0032s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | 0.0014s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0023s | 0.0024s | **1.0x** | **1.0x** |
| b2sum | single 10MB text | 0.0152s | 0.0125s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0160s | 0.0128s | 0.0131s | **1.3x** | **1.0x** |
| b2sum | single 100MB text | 0.1437s | 0.1128s | 0.1136s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0123s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0124s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0023s | 0.0020s | 0.0024s | **1.2x** | **1.2x** |
| base64 | encode 100KB text | 0.0011s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0128s | 0.0061s | 0.0084s | **2.1x** | **1.4x** |
| base64 | encode 10MB binary | 0.0133s | 0.0064s | 0.0088s | **2.1x** | **1.4x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0044s | **1.9x** | **2.0x** |
| base64 | decode 10MB | 0.0326s | 0.0112s | 0.0339s | **2.9x** | **3.0x** |
| base64 | encode -w 76 10MB | 0.0127s | 0.0063s | 0.0085s | **2.0x** | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0092s | 0.0040s | 0.0076s | **2.3x** | **1.9x** |
| sort | lexicographic 1MB | 0.0089s | 0.0035s | 0.0058s | **2.5x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0563s | 0.0122s | 0.0360s | **4.6x** | **3.0x** |
| sort | already sorted 10MB | 0.0264s | 0.0049s | 0.0178s | **5.4x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0282s | 0.0086s | 0.0190s | **3.3x** | **2.2x** |
| sort | -n numeric 10MB | 0.0767s | 0.0063s | 0.0775s | **12.1x** | **12.2x** |
| sort | -r reverse 10MB | 0.0543s | 0.0116s | 0.0359s | **4.7x** | **3.1x** |
| sort | -u unique 10MB | 0.0578s | 0.0119s | 0.0395s | **4.8x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0662s | 0.0387s | 0.0818s | **1.7x** | **2.1x** |
| sort | repetitive 10MB | 0.0565s | 0.0127s | 0.0393s | **4.4x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0573s | 0.0138s | 0.0377s | **4.2x** | **2.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0020s | 0.0020s | **1.2x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0149s | 0.0077s | 0.0077s | **1.9x** | **1.0x** |
| tr | -d digits 10MB | 0.0173s | 0.0141s | 0.0141s | **1.2x** | **1.0x** |
| tr | -d lowercase 10MB | 0.0302s | 0.0138s | 0.0216s | **2.2x** | **1.6x** |
| tr | -s spaces 10MB | 0.0290s | 0.0101s | 0.0297s | **2.9x** | **3.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0072s | 0.0083s | **1.8x** | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0171s | 0.0142s | 0.0148s | **1.2x** | **1.0x** |
| tr | translate binary 10MB | 0.0119s | 0.0075s | 0.0082s | **1.6x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0038s | 0.0121s | **3.1x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0146s | 0.0040s | 0.0134s | **3.7x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0130s | 0.0038s | 0.0116s | **3.4x** | **3.1x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0099s | 0.0161s | **3.0x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0037s | 0.0115s | **3.3x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0036s | 0.0114s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0144s | 0.0048s | 0.0134s | **3.0x** | **2.8x** |
| uniq | repetitive 10MB | 0.0425s | 0.0045s | 0.0173s | **9.5x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0021s | 0.0017s | 0.0018s | **1.2x** | **1.0x** |
| tac | reverse 10MB text | 0.0109s | 0.0049s | 0.0060s | **2.2x** | **1.2x** |
| tac | reverse 100MB text | 0.1059s | 0.0415s | 0.0532s | **2.6x** | **1.3x** |
| tac | reverse CSV 10MB | 0.0100s | 0.0052s | 0.0059s | **1.9x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0244s | 0.0109s | 0.0110s | **2.2x** | **1.0x** |
| tac | custom separator 1MB | 0.0061s | 0.0049s | 0.0059s | **1.2x** | **1.2x** |
