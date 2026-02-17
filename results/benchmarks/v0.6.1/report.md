# fcoreutils v0.6.1 — Detailed Results

Generated: 2026-02-17 02:54:04 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0025s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0068s | 0.0259s | **5.1x** | **3.8x** |
| wc | default 100MB text | 0.2989s | 0.0454s | 0.2269s | **6.6x** | **5.0x** |
| wc | -l 10MB text | 0.0044s | 0.0021s | 0.0029s | **2.1x** | **1.4x** |
| wc | -w 10MB text | 0.0345s | 0.0063s | 0.0235s | **5.4x** | **3.7x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0345s | 0.0025s | 0.0031s | **13.8x** | **1.2x** |
| wc | -L 10MB text | 0.0346s | 0.0064s | 0.0181s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2351s | 0.0172s | 0.1179s | **13.7x** | **6.9x** |
| wc | default 10MB repetitive | 0.0527s | 0.0083s | 0.0368s | **6.4x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0017s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0028s | 0.0064s | **6.6x** | **2.3x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0031s | 0.0063s | **6.0x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0044s | 0.0072s | **4.3x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0051s | 0.0164s | **4.1x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0047s | 0.0127s | **5.0x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0043s | 0.0162s | **6.1x** | **3.7x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0015s | 0.0010s | **0.5x** | **0.7x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0030s | 0.0018s | **1.2x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0025s | 0.0015s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0031s | 0.0039s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0076s | 0.0089s | 0.0277s | **0.8x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0079s | 0.0091s | 0.0289s | **0.9x** | **3.2x** |
| sha256sum | single 100MB text | 0.0687s | 0.0679s | 0.2627s | **1.0x** | **3.9x** |
| sha256sum | 10 files | 0.0012s | 0.0020s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0023s | 0.0018s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0216s | 0.0180s | 0.0180s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0223s | 0.0186s | 0.0186s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2006s | 0.1440s | 0.1659s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0025s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0025s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0145s | 0.0141s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0151s | 0.0147s | 0.0147s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1352s | 0.1165s | 0.1286s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0141s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0141s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0018s | 0.0018s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0017s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0102s | 0.0036s | 0.0074s | **2.9x** | **2.1x** |
| base64 | encode 10MB binary | 0.0106s | 0.0036s | 0.0078s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0039s | 0.0018s | 0.0036s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0310s | 0.0042s | 0.0273s | **7.4x** | **6.5x** |
| base64 | encode -w 76 10MB | 0.0103s | 0.0037s | 0.0077s | **2.7x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0032s | 0.0076s | **2.5x** | **2.4x** |
| sort | lexicographic 1MB | 0.0077s | 0.0032s | 0.0045s | **2.4x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0535s | 0.0101s | 0.0330s | **5.3x** | **3.3x** |
| sort | already sorted 10MB | 0.0256s | 0.0036s | 0.0141s | **7.1x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0252s | 0.0050s | 0.0147s | **5.1x** | **3.0x** |
| sort | -n numeric 10MB | 0.0710s | 0.0042s | 0.0649s | **17.0x** | **15.6x** |
| sort | -r reverse 10MB | 0.0535s | 0.0097s | 0.0302s | **5.5x** | **3.1x** |
| sort | -u unique 10MB | 0.0563s | 0.0117s | 0.0403s | **4.8x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0741s | 0.0164s | 0.0760s | **4.5x** | **4.6x** |
| sort | repetitive 10MB | 0.0469s | 0.0102s | 0.0370s | **4.6x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0530s | 0.0102s | 0.0325s | **5.2x** | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0043s | 0.0067s | **2.0x** | **1.6x** |
| tr | -d digits 10MB | 0.0111s | 0.0053s | 0.0104s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0070s | 0.0169s | **2.7x** | **2.4x** |
| tr | -s spaces 10MB | 0.0166s | 0.0045s | 0.0115s | **3.7x** | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0086s | 0.0044s | 0.0069s | **1.9x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0053s | 0.0102s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0089s | 0.0045s | 0.0078s | **2.0x** | **1.7x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0017s | 0.0089s | **5.6x** | **5.4x** |
| uniq | default 10MB sorted (low dup) | 0.0169s | 0.0026s | 0.0102s | **6.5x** | **3.9x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0018s | 0.0088s | **5.3x** | **5.0x** |
| uniq | -c count 10MB sorted | 0.0299s | 0.0071s | 0.0122s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0017s | 0.0088s | **5.4x** | **5.1x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0021s | 0.0088s | **4.5x** | **4.3x** |
| uniq | -i case insensitive 10MB | 0.0168s | 0.0041s | 0.0099s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0476s | 0.0029s | 0.0148s | **16.1x** | **5.0x** |
| tac | reverse 100KB text | 0.0008s | 0.0012s | 0.0012s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0089s | 0.0045s | 0.0050s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0849s | 0.0227s | 0.0444s | **3.7x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0043s | 0.0045s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0178s | 0.0090s | 0.0086s | **2.0x** | **1.0x** |
| tac | custom separator 1MB | 0.0044s | 0.0036s | 0.0039s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0042s | **1.9x** | **1.4x** |
| wc | default 10MB text | 0.0546s | 0.0031s | 0.0338s | **17.7x** | **11.0x** |
| wc | default 100MB text | 0.4837s | 0.0146s | 0.2920s | **33.2x** | **20.0x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0545s | 0.0091s | 0.0344s | **6.0x** | **3.8x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0012s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0546s | 0.0030s | 0.0021s | **18.1x** | **0.7x** |
| wc | -L 10MB text | 0.0546s | 0.0098s | 0.0166s | **5.5x** | **1.7x** |
| wc | default 10MB binary | 0.3160s | 0.0273s | 0.1559s | **11.6x** | **5.7x** |
| wc | default 10MB repetitive | 0.0732s | 0.0046s | 0.0477s | **16.0x** | **10.4x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0229s | 0.0035s | 0.0070s | **6.5x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0035s | 0.0071s | **6.4x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0051s | 0.0085s | **3.3x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0073s | 0.0178s | **3.0x** | **2.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0053s | 0.0134s | **4.5x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0307s | 0.0054s | 0.0167s | **5.7x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0027s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0033s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0085s | 0.0100s | 0.0085s | **0.8x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0100s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0762s | 0.0756s | 0.0756s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0027s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0173s | 0.0180s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0180s | 0.0185s | 0.0226s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1620s | 0.1537s | 0.2039s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0033s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0126s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0131s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1435s | 0.1128s | 0.1139s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0127s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0129s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0017s | 0.0018s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0123s | 0.0044s | 0.0082s | **2.8x** | **1.9x** |
| base64 | encode 10MB binary | 0.0128s | 0.0045s | 0.0083s | **2.9x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0043s | **1.8x** | **1.9x** |
| base64 | decode 10MB | 0.0327s | 0.0050s | 0.0339s | **6.6x** | **6.8x** |
| base64 | encode -w 76 10MB | 0.0125s | 0.0044s | 0.0082s | **2.8x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0090s | 0.0045s | 0.0077s | **2.0x** | **1.7x** |
| sort | lexicographic 1MB | 0.0086s | 0.0035s | 0.0055s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0543s | 0.0089s | 0.0358s | **6.1x** | **4.0x** |
| sort | already sorted 10MB | 0.0264s | 0.0047s | 0.0179s | **5.6x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0064s | 0.0179s | **4.3x** | **2.8x** |
| sort | -n numeric 10MB | 0.0734s | 0.0055s | 0.0742s | **13.4x** | **13.6x** |
| sort | -r reverse 10MB | 0.0549s | 0.0089s | 0.0363s | **6.2x** | **4.1x** |
| sort | -u unique 10MB | 0.0584s | 0.0094s | 0.0399s | **6.2x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0667s | 0.0200s | 0.0826s | **3.3x** | **4.1x** |
| sort | repetitive 10MB | 0.0549s | 0.0127s | 0.0373s | **4.3x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0088s | 0.0364s | **6.2x** | **4.1x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0040s | 0.0074s | **3.1x** | **1.9x** |
| tr | -d digits 10MB | 0.0179s | 0.0044s | 0.0135s | **4.1x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0318s | 0.0050s | 0.0206s | **6.4x** | **4.2x** |
| tr | -s spaces 10MB | 0.0255s | 0.0040s | 0.0269s | **6.4x** | **6.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0040s | 0.0076s | **3.1x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0044s | 0.0133s | **3.8x** | **3.0x** |
| tr | translate binary 10MB | 0.0126s | 0.0039s | 0.0082s | **3.2x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | 0.0112s | **6.3x** | **6.0x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0031s | 0.0129s | **4.5x** | **4.2x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | 0.0111s | **6.3x** | **5.9x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0077s | 0.0154s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0019s | 0.0111s | **6.4x** | **5.9x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0019s | 0.0112s | **6.3x** | **5.9x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0045s | 0.0128s | **3.1x** | **2.8x** |
| uniq | repetitive 10MB | 0.0421s | 0.0036s | 0.0163s | **11.8x** | **4.6x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0046s | 0.0059s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1043s | 0.0281s | 0.0523s | **3.7x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0048s | 0.0057s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0234s | 0.0097s | 0.0111s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | 0.0054s | **1.4x** | **1.3x** |
