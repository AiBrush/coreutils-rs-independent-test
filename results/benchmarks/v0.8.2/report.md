# fcoreutils v0.8.2 — Detailed Results

Generated: 2026-02-19 02:02:07 UTC

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
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0035s | **1.5x** | **1.4x** |
| wc | default 10MB text | 0.0344s | 0.0066s | 0.0275s | **5.2x** | **4.1x** |
| wc | default 100MB text | 0.3012s | 0.0458s | 0.2448s | **6.6x** | **5.3x** |
| wc | -l 10MB text | 0.0044s | 0.0024s | 0.0030s | **1.8x** | **1.3x** |
| wc | -w 10MB text | 0.0346s | 0.0062s | 0.0230s | **5.6x** | **3.7x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0343s | 0.0022s | 0.0025s | **15.4x** | **1.1x** |
| wc | -L 10MB text | 0.0343s | 0.0058s | 0.0172s | **5.9x** | **3.0x** |
| wc | default 10MB binary | 0.2348s | 0.0167s | 0.1159s | **14.0x** | **6.9x** |
| wc | default 10MB repetitive | 0.0522s | 0.0085s | 0.0436s | **6.1x** | **5.1x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0015s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0035s | 0.0060s | **5.4x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0035s | 0.0062s | **5.3x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0096s | 0.0074s | **1.9x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0118s | 0.0166s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0097s | 0.0129s | **2.4x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0100s | 0.0165s | **2.6x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0011s | 0.0009s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0026s | 0.0017s | **1.3x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | 0.0009s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0023s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0029s | 0.0037s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0076s | 0.0088s | 0.0277s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0081s | 0.0091s | 0.0290s | **0.9x** | **3.2x** |
| sha256sum | single 100MB text | 0.0702s | 0.0701s | 0.2652s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0012s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0023s | 0.0019s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0035s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0216s | 0.0180s | 0.0181s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0227s | 0.0188s | 0.0190s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2027s | 0.1452s | 0.1688s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0027s | 0.0018s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0024s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0147s | 0.0140s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0148s | 0.0149s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1379s | 0.1157s | 0.1310s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0145s | 0.0139s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0145s | 0.0140s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.1x** |
| base64 | encode 10MB text | 0.0102s | 0.0035s | 0.0076s | **2.9x** | **2.2x** |
| base64 | encode 10MB binary | 0.0106s | 0.0036s | 0.0080s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0038s | 0.0018s | 0.0035s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0308s | 0.0040s | 0.0263s | **7.7x** | **6.6x** |
| base64 | encode -w 76 10MB | 0.0099s | 0.0033s | 0.0078s | **3.0x** | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0084s | 0.0034s | 0.0079s | **2.5x** | **2.3x** |
| sort | lexicographic 1MB | 0.0078s | 0.0032s | 0.0045s | **2.4x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0103s | 0.0353s | **5.2x** | **3.4x** |
| sort | already sorted 10MB | 0.0254s | 0.0037s | 0.0143s | **6.9x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0257s | 0.0052s | 0.0147s | **4.9x** | **2.8x** |
| sort | -n numeric 10MB | 0.0720s | 0.0041s | 0.0693s | **17.6x** | **16.9x** |
| sort | -r reverse 10MB | 0.0543s | 0.0105s | 0.0350s | **5.2x** | **3.3x** |
| sort | -u unique 10MB | 0.0573s | 0.0123s | 0.0412s | **4.7x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0746s | 0.0168s | 0.0745s | **4.4x** | **4.4x** |
| sort | repetitive 10MB | 0.0472s | 0.0106s | 0.0378s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0547s | 0.0106s | 0.0346s | **5.2x** | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0050s | 0.0068s | **1.8x** | **1.4x** |
| tr | -d digits 10MB | 0.0112s | 0.0054s | 0.0103s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0068s | 0.0168s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0166s | 0.0049s | 0.0115s | **3.4x** | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0046s | 0.0067s | **1.9x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0053s | 0.0103s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0090s | 0.0050s | 0.0078s | **1.8x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0095s | 0.0017s | 0.0091s | **5.5x** | **5.3x** |
| uniq | default 10MB sorted (low dup) | 0.0166s | 0.0028s | 0.0100s | **6.0x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0018s | 0.0091s | **5.4x** | **5.2x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0072s | 0.0119s | **4.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0019s | 0.0092s | **5.0x** | **4.8x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0018s | 0.0092s | **5.2x** | **5.0x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0042s | 0.0102s | **4.0x** | **2.5x** |
| uniq | repetitive 10MB | 0.0485s | 0.0034s | 0.0158s | **14.4x** | **4.7x** |
| tac | reverse 100KB text | 0.0009s | 0.0013s | 0.0012s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0018s | 0.0020s | 0.0017s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0093s | 0.0056s | 0.0052s | **1.7x** | **0.9x** |
| tac | reverse 100MB text | 0.0882s | 0.0236s | 0.0469s | **3.7x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0048s | 0.0046s | **1.7x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0185s | 0.0100s | 0.0088s | **1.8x** | **0.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0038s | 0.0039s | **1.2x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0029s | 0.0039s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0545s | 0.0031s | 0.0312s | **17.4x** | **10.0x** |
| wc | default 100MB text | 0.4833s | 0.0148s | 0.2663s | **32.7x** | **18.0x** |
| wc | -l 10MB text | 0.0021s | 0.0026s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0550s | 0.0089s | 0.0256s | **6.2x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0545s | 0.0030s | 0.0020s | **18.2x** | **0.7x** |
| wc | -L 10MB text | 0.0546s | 0.0101s | 0.0167s | **5.4x** | **1.7x** |
| wc | default 10MB binary | 0.3165s | 0.0274s | 0.1547s | **11.5x** | **5.6x** |
| wc | default 10MB repetitive | 0.0731s | 0.0046s | 0.0425s | **15.9x** | **9.3x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0231s | 0.0039s | 0.0072s | **5.9x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0228s | 0.0040s | 0.0072s | **5.7x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0095s | 0.0085s | **1.8x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0220s | 0.0114s | 0.0183s | **1.9x** | **1.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0246s | 0.0103s | 0.0135s | **2.4x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0108s | 0.0170s | **2.9x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0030s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0027s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0033s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0085s | 0.0101s | 0.0085s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0102s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0758s | 0.0749s | 0.0752s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0027s | 0.0023s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.7x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0173s | 0.0180s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0180s | 0.0187s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1616s | 0.1534s | 0.2034s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0125s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0129s | 0.0128s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1433s | 0.1123s | 0.1135s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0127s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0126s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0016s | 0.0019s | **1.3x** | **1.2x** |
| base64 | encode 10MB text | 0.0125s | 0.0044s | 0.0081s | **2.8x** | **1.8x** |
| base64 | encode 10MB binary | 0.0131s | 0.0046s | 0.0085s | **2.9x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0043s | **1.8x** | **1.9x** |
| base64 | decode 10MB | 0.0329s | 0.0050s | 0.0340s | **6.6x** | **6.9x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0046s | 0.0083s | **2.7x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0042s | 0.0074s | **2.0x** | **1.7x** |
| sort | lexicographic 1MB | 0.0086s | 0.0035s | 0.0055s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0544s | 0.0092s | 0.0356s | **5.9x** | **3.9x** |
| sort | already sorted 10MB | 0.0265s | 0.0050s | 0.0179s | **5.4x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0064s | 0.0182s | **4.3x** | **2.9x** |
| sort | -n numeric 10MB | 0.0736s | 0.0054s | 0.0769s | **13.6x** | **14.2x** |
| sort | -r reverse 10MB | 0.0549s | 0.0097s | 0.0365s | **5.7x** | **3.8x** |
| sort | -u unique 10MB | 0.0598s | 0.0102s | 0.0405s | **5.9x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0668s | 0.0199s | 0.0829s | **3.4x** | **4.2x** |
| sort | repetitive 10MB | 0.0578s | 0.0128s | 0.0371s | **4.5x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0096s | 0.0366s | **5.6x** | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0133s | 0.0040s | 0.0076s | **3.4x** | **1.9x** |
| tr | -d digits 10MB | 0.0163s | 0.0042s | 0.0135s | **3.9x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0310s | 0.0050s | 0.0212s | **6.2x** | **4.2x** |
| tr | -s spaces 10MB | 0.0272s | 0.0038s | 0.0280s | **7.1x** | **7.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0136s | 0.0039s | 0.0074s | **3.5x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0166s | 0.0043s | 0.0137s | **3.8x** | **3.1x** |
| tr | translate binary 10MB | 0.0117s | 0.0039s | 0.0081s | **3.0x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0020s | 0.0110s | **6.0x** | **5.7x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0031s | 0.0129s | **4.6x** | **4.2x** |
| uniq | -c count 10MB many dups | 0.0125s | 0.0020s | 0.0112s | **6.2x** | **5.6x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0078s | 0.0156s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0020s | 0.0111s | **6.1x** | **5.6x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0020s | 0.0111s | **6.1x** | **5.7x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0045s | 0.0129s | **3.2x** | **2.9x** |
| uniq | repetitive 10MB | 0.0423s | 0.0037s | 0.0161s | **11.5x** | **4.4x** |
| tac | reverse 100KB text | 0.0010s | 0.0014s | 0.0013s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0108s | 0.0059s | 0.0059s | **1.8x** | **1.0x** |
| tac | reverse 100MB text | 0.1041s | 0.0271s | 0.0520s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0057s | 0.0057s | **1.6x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0109s | 0.0111s | **2.2x** | **1.0x** |
| tac | custom separator 1MB | 0.0060s | 0.0050s | 0.0054s | **1.2x** | **1.1x** |
