# fcoreutils v0.6.0 — Detailed Results

Generated: 2026-02-16 22:08:23 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 410 | 3 | 99.3% |
| Linux_x86_64 | 413 | 410 | 3 | 99.3% |

**Overall: 820/826 (99.3%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0345s | 0.0066s | 0.0260s | **5.2x** | **3.9x** |
| wc | default 100MB text | 0.2986s | 0.0455s | 0.2266s | **6.6x** | **5.0x** |
| wc | -l 10MB text | 0.0045s | 0.0021s | 0.0029s | **2.1x** | **1.4x** |
| wc | -w 10MB text | 0.0345s | 0.0064s | 0.0235s | **5.4x** | **3.7x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0344s | 0.0025s | 0.0030s | **13.6x** | **1.2x** |
| wc | -L 10MB text | 0.0345s | 0.0062s | 0.0179s | **5.6x** | **2.9x** |
| wc | default 10MB binary | 0.2352s | 0.0175s | 0.1181s | **13.4x** | **6.7x** |
| wc | default 10MB repetitive | 0.0532s | 0.0081s | 0.0362s | **6.5x** | **4.4x** |
| wc | 10 files | 0.0011s | 0.0011s | 0.0011s | **1.0x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0031s | 0.0062s | **6.0x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0030s | 0.0061s | **6.1x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0184s | 0.0045s | 0.0070s | **4.1x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0051s | 0.0162s | **4.1x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0045s | 0.0126s | **5.1x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0050s | 0.0162s | **5.3x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | 0.0019s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.8x** |
| sha256sum | single 100KB text | 0.0011s | 0.0024s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0031s | 0.0038s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0078s | 0.0089s | 0.0276s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0080s | 0.0090s | 0.0289s | **0.9x** | **3.2x** |
| sha256sum | single 100MB text | 0.0684s | 0.0677s | 0.2622s | **1.0x** | **3.9x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0018s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0036s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0211s | 0.0177s | 0.0177s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0183s | 0.0184s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2001s | 0.1438s | 0.1656s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0018s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0024s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | 0.0023s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0142s | 0.0139s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0148s | 0.0144s | 0.0144s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1349s | 0.1164s | 0.1282s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0142s | 0.0141s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0140s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0018s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0010s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0095s | 0.0035s | 0.0071s | **2.7x** | **2.1x** |
| base64 | encode 10MB binary | 0.0102s | 0.0035s | 0.0074s | **2.9x** | **2.1x** |
| base64 | decode 1MB | 0.0038s | 0.0020s | 0.0036s | **1.9x** | **1.8x** |
| base64 | decode 10MB | 0.0308s | 0.0039s | 0.0268s | **7.9x** | **6.9x** |
| base64 | encode -w 76 10MB | 0.0098s | 0.0033s | 0.0072s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0077s | 0.0033s | 0.0075s | **2.3x** | **2.3x** |
| sort | lexicographic 1MB | 0.0077s | 0.0032s | 0.0043s | **2.4x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0526s | 0.0095s | 0.0304s | **5.5x** | **3.2x** |
| sort | already sorted 10MB | 0.0257s | 0.0037s | 0.0142s | **6.9x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0254s | 0.0049s | 0.0144s | **5.2x** | **2.9x** |
| sort | -n numeric 10MB | 0.0711s | 0.0043s | 0.0650s | **16.4x** | **15.0x** |
| sort | -r reverse 10MB | 0.0536s | 0.0096s | 0.0311s | **5.6x** | **3.2x** |
| sort | -u unique 10MB | 0.0558s | 0.0109s | 0.0379s | **5.1x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0725s | 0.0153s | 0.0714s | **4.7x** | **4.7x** |
| sort | repetitive 10MB | 0.0461s | 0.0100s | 0.0369s | **4.6x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0525s | 0.0102s | 0.0307s | **5.1x** | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0015s | 0.0019s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0085s | 0.0043s | 0.0068s | **2.0x** | **1.6x** |
| tr | -d digits 10MB | 0.0112s | 0.0053s | 0.0104s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0187s | 0.0068s | 0.0173s | **2.8x** | **2.6x** |
| tr | -s spaces 10MB | 0.0166s | 0.0046s | 0.0114s | **3.6x** | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0085s | 0.0046s | 0.0068s | **1.8x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0053s | 0.0103s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0089s | 0.0044s | 0.0078s | **2.0x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0017s | 0.0088s | **5.3x** | **5.1x** |
| uniq | default 10MB sorted (low dup) | 0.0167s | 0.0028s | 0.0099s | **6.1x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0016s | 0.0087s | **5.6x** | **5.3x** |
| uniq | -c count 10MB sorted | 0.0299s | 0.0070s | 0.0118s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0017s | 0.0088s | **5.4x** | **5.1x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0017s | 0.0088s | **5.3x** | **5.0x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0041s | 0.0099s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0477s | 0.0028s | 0.0148s | **17.0x** | **5.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0014s | 0.0017s | **1.2x** | **1.2x** |
| tac | reverse 10MB text | 0.0086s | 0.0044s | 0.0049s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0853s | 0.0235s | 0.0438s | **3.6x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0043s | 0.0045s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0175s | 0.0088s | 0.0086s | **2.0x** | **1.0x** |
| tac | custom separator 1MB | 0.0045s | 0.0036s | 0.0039s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0030s | 0.0044s | **1.9x** | **1.5x** |
| wc | default 10MB text | 0.0546s | 0.0031s | 0.0337s | **17.7x** | **10.9x** |
| wc | default 100MB text | 0.4783s | 0.0144s | 0.2914s | **33.3x** | **20.3x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0547s | 0.0092s | 0.0344s | **6.0x** | **3.8x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0543s | 0.0030s | 0.0021s | **18.2x** | **0.7x** |
| wc | -L 10MB text | 0.0545s | 0.0100s | 0.0166s | **5.5x** | **1.7x** |
| wc | default 10MB binary | 0.3159s | 0.0279s | 0.1554s | **11.3x** | **5.6x** |
| wc | default 10MB repetitive | 0.0730s | 0.0046s | 0.0478s | **15.8x** | **10.3x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0023s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0227s | 0.0037s | 0.0071s | **6.2x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0036s | 0.0071s | **6.3x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0051s | 0.0085s | **3.2x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0073s | 0.0177s | **3.0x** | **2.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0053s | 0.0134s | **4.5x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0307s | 0.0055s | 0.0166s | **5.5x** | **3.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0013s | 0.0027s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0033s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0086s | 0.0100s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0103s | 0.0087s | **0.9x** | **0.8x** |
| sha256sum | single 100MB text | 0.0761s | 0.0755s | 0.0756s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.7x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0173s | 0.0179s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0180s | 0.0188s | 0.0228s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1619s | 0.1537s | 0.2039s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0034s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0127s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0157s | 0.0134s | 0.0131s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1439s | 0.1127s | 0.1140s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0154s | 0.0125s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0127s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0023s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0013s | 0.0012s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0018s | 0.0018s | **1.2x** | **1.0x** |
| base64 | encode 10MB text | 0.0124s | 0.0044s | 0.0083s | **2.8x** | **1.9x** |
| base64 | encode 10MB binary | 0.0130s | 0.0046s | 0.0086s | **2.8x** | **1.9x** |
| base64 | decode 1MB | 0.0041s | 0.0022s | 0.0044s | **1.9x** | **2.0x** |
| base64 | decode 10MB | 0.0327s | 0.0050s | 0.0342s | **6.5x** | **6.8x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0045s | 0.0084s | **2.8x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0044s | 0.0077s | **2.0x** | **1.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0035s | 0.0055s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0549s | 0.0092s | 0.0364s | **6.0x** | **3.9x** |
| sort | already sorted 10MB | 0.0269s | 0.0049s | 0.0183s | **5.5x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0065s | 0.0182s | **4.2x** | **2.8x** |
| sort | -n numeric 10MB | 0.0737s | 0.0054s | 0.0762s | **13.6x** | **14.0x** |
| sort | -r reverse 10MB | 0.0548s | 0.0088s | 0.0363s | **6.3x** | **4.1x** |
| sort | -u unique 10MB | 0.0601s | 0.0108s | 0.0404s | **5.6x** | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0666s | 0.0204s | 0.0827s | **3.3x** | **4.1x** |
| sort | repetitive 10MB | 0.0550s | 0.0127s | 0.0373s | **4.3x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0552s | 0.0093s | 0.0362s | **5.9x** | **3.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0040s | 0.0081s | **3.1x** | **2.0x** |
| tr | -d digits 10MB | 0.0166s | 0.0044s | 0.0133s | **3.8x** | **3.0x** |
| tr | -d lowercase 10MB | 0.0287s | 0.0049s | 0.0206s | **5.8x** | **4.2x** |
| tr | -s spaces 10MB | 0.0270s | 0.0037s | 0.0266s | **7.3x** | **7.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0039s | 0.0075s | **3.4x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0162s | 0.0043s | 0.0134s | **3.8x** | **3.1x** |
| tr | translate binary 10MB | 0.0120s | 0.0040s | 0.0085s | **3.0x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | 0.0112s | **6.3x** | **6.0x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0030s | 0.0129s | **4.6x** | **4.3x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | 0.0111s | **6.4x** | **6.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0078s | 0.0154s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0019s | 0.0112s | **6.3x** | **5.9x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | 0.0111s | **6.2x** | **5.8x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0046s | 0.0131s | **3.0x** | **2.9x** |
| uniq | repetitive 10MB | 0.0423s | 0.0037s | 0.0164s | **11.4x** | **4.4x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0019s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0107s | 0.0046s | 0.0058s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1043s | 0.0276s | 0.0523s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0048s | 0.0057s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0099s | 0.0110s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | 0.0054s | **1.4x** | **1.3x** |
