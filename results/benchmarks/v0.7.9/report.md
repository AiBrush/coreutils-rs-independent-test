# fcoreutils v0.7.9 — Detailed Results

Generated: 2026-02-17 06:30:17 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0340s | 0.0072s | 0.0255s | **4.7x** | **3.5x** |
| wc | default 100MB text | 0.3012s | 0.0480s | 0.2289s | **6.3x** | **4.8x** |
| wc | -l 10MB text | 0.0043s | 0.0021s | 0.0028s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0341s | 0.0065s | 0.0231s | **5.2x** | **3.5x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0341s | 0.0024s | 0.0028s | **14.1x** | **1.1x** |
| wc | -L 10MB text | 0.0341s | 0.0060s | 0.0176s | **5.7x** | **2.9x** |
| wc | default 10MB binary | 0.2352s | 0.0171s | 0.1180s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0564s | 0.0083s | 0.0374s | **6.8x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0044s | 0.0063s | **4.2x** | **1.4x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0045s | 0.0063s | **4.1x** | **1.4x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0106s | 0.0071s | **1.8x** | **0.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0128s | 0.0164s | **1.6x** | **1.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0108s | 0.0127s | **2.2x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0110s | 0.0162s | **2.4x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | 0.0018s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0024s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0029s | 0.0038s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0077s | 0.0086s | 0.0274s | **0.9x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0095s | 0.0290s | **0.9x** | **3.1x** |
| sha256sum | single 100MB text | 0.0703s | 0.0697s | 0.2641s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0022s | 0.0018s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0211s | 0.0174s | 0.0176s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0224s | 0.0186s | 0.0188s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2024s | 0.1445s | 0.1675s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0025s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0142s | 0.0135s | 0.0138s | **1.1x** | **1.0x** |
| b2sum | single 10MB binary | 0.0151s | 0.0145s | 0.0148s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1367s | 0.1154s | 0.1304s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0141s | 0.0135s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0136s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0018s | 0.0018s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0098s | 0.0041s | 0.0072s | **2.4x** | **1.8x** |
| base64 | encode 10MB binary | 0.0107s | 0.0045s | 0.0080s | **2.4x** | **1.8x** |
| base64 | decode 1MB | 0.0038s | 0.0019s | 0.0037s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0310s | 0.0057s | 0.0273s | **5.5x** | **4.8x** |
| base64 | encode -w 76 10MB | 0.0099s | 0.0042s | 0.0073s | **2.4x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0079s | 0.0041s | 0.0073s | **1.9x** | **1.8x** |
| sort | lexicographic 1MB | 0.0077s | 0.0032s | 0.0043s | **2.4x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0527s | 0.0101s | 0.0330s | **5.2x** | **3.3x** |
| sort | already sorted 10MB | 0.0254s | 0.0034s | 0.0142s | **7.5x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0249s | 0.0049s | 0.0143s | **5.1x** | **2.9x** |
| sort | -n numeric 10MB | 0.0712s | 0.0039s | 0.0682s | **18.1x** | **17.3x** |
| sort | -r reverse 10MB | 0.0543s | 0.0104s | 0.0335s | **5.2x** | **3.2x** |
| sort | -u unique 10MB | 0.0558s | 0.0116s | 0.0390s | **4.8x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0733s | 0.0166s | 0.0740s | **4.4x** | **4.5x** |
| sort | repetitive 10MB | 0.0475s | 0.0107s | 0.0383s | **4.4x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0525s | 0.0101s | 0.0326s | **5.2x** | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0041s | 0.0068s | **2.1x** | **1.6x** |
| tr | -d digits 10MB | 0.0111s | 0.0053s | 0.0102s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0068s | 0.0172s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0168s | 0.0042s | 0.0115s | **4.0x** | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0042s | 0.0067s | **2.1x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0052s | 0.0103s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0047s | 0.0077s | **1.9x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0095s | 0.0018s | 0.0090s | **5.4x** | **5.1x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0030s | 0.0102s | **5.6x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0018s | 0.0090s | **5.2x** | **4.9x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0071s | 0.0118s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0017s | 0.0090s | **5.5x** | **5.2x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0017s | 0.0089s | **5.5x** | **5.3x** |
| uniq | -i case insensitive 10MB | 0.0168s | 0.0041s | 0.0100s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0487s | 0.0031s | 0.0160s | **15.6x** | **5.1x** |
| tac | reverse 100KB text | 0.0009s | 0.0013s | 0.0012s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0018s | 0.0016s | **0.9x** | **0.9x** |
| tac | reverse 10MB text | 0.0085s | 0.0041s | 0.0049s | **2.1x** | **1.2x** |
| tac | reverse 100MB text | 0.0867s | 0.0374s | 0.0456s | **2.3x** | **1.2x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0058s | 0.0046s | **1.4x** | **0.8x** |
| tac | reverse repetitive 10MB | 0.0190s | 0.0086s | 0.0089s | **2.2x** | **1.0x** |
| tac | custom separator 1MB | 0.0045s | 0.0039s | 0.0040s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0015s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0039s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0542s | 0.0030s | 0.0307s | **17.9x** | **10.1x** |
| wc | default 100MB text | 0.4837s | 0.0142s | 0.2657s | **34.1x** | **18.7x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0542s | 0.0087s | 0.0254s | **6.3x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0538s | 0.0029s | 0.0019s | **18.2x** | **0.6x** |
| wc | -L 10MB text | 0.0545s | 0.0100s | 0.0164s | **5.4x** | **1.6x** |
| wc | default 10MB binary | 0.3195s | 0.0270s | 0.1553s | **11.8x** | **5.7x** |
| wc | default 10MB repetitive | 0.0732s | 0.0045s | 0.0420s | **16.3x** | **9.4x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0023s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0046s | 0.0073s | **4.9x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0047s | 0.0075s | **4.8x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0101s | 0.0084s | **1.6x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0121s | 0.0181s | **1.8x** | **1.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0112s | 0.0135s | **2.2x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0308s | 0.0115s | 0.0163s | **2.7x** | **1.4x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0029s | 0.0013s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0035s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0085s | 0.0099s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0103s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0763s | 0.0753s | 0.0754s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0021s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0172s | 0.0178s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0184s | 0.0224s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1617s | 0.1534s | 0.2044s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0033s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0126s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0130s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1437s | 0.1125s | 0.1141s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0125s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0125s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0017s | 0.0018s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0124s | 0.0049s | 0.0083s | **2.5x** | **1.7x** |
| base64 | encode 10MB binary | 0.0129s | 0.0051s | 0.0086s | **2.5x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0024s | 0.0043s | **1.7x** | **1.8x** |
| base64 | decode 10MB | 0.0325s | 0.0057s | 0.0337s | **5.7x** | **5.9x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0052s | 0.0082s | **2.4x** | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0046s | 0.0073s | **1.9x** | **1.6x** |
| sort | lexicographic 1MB | 0.0086s | 0.0035s | 0.0055s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0546s | 0.0093s | 0.0362s | **5.9x** | **3.9x** |
| sort | already sorted 10MB | 0.0266s | 0.0050s | 0.0181s | **5.4x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0281s | 0.0065s | 0.0182s | **4.3x** | **2.8x** |
| sort | -n numeric 10MB | 0.0741s | 0.0054s | 0.0757s | **13.8x** | **14.1x** |
| sort | -r reverse 10MB | 0.0552s | 0.0095s | 0.0366s | **5.8x** | **3.9x** |
| sort | -u unique 10MB | 0.0583s | 0.0099s | 0.0406s | **5.9x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0678s | 0.0206s | 0.0834s | **3.3x** | **4.0x** |
| sort | repetitive 10MB | 0.0555s | 0.0127s | 0.0378s | **4.4x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0090s | 0.0364s | **6.0x** | **4.0x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.4x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0040s | 0.0076s | **3.3x** | **1.9x** |
| tr | -d digits 10MB | 0.0166s | 0.0043s | 0.0135s | **3.9x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0306s | 0.0049s | 0.0212s | **6.3x** | **4.3x** |
| tr | -s spaces 10MB | 0.0298s | 0.0039s | 0.0280s | **7.7x** | **7.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0038s | 0.0075s | **3.3x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0172s | 0.0043s | 0.0135s | **4.0x** | **3.1x** |
| tr | translate binary 10MB | 0.0111s | 0.0039s | 0.0084s | **2.9x** | **2.2x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0019s | 0.0122s | **6.2x** | **6.3x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0032s | 0.0132s | **4.4x** | **4.1x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | 0.0121s | **6.3x** | **6.3x** |
| uniq | -c count 10MB sorted | 0.0289s | 0.0078s | 0.0156s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0019s | 0.0121s | **6.2x** | **6.3x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0020s | 0.0121s | **6.1x** | **6.1x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0045s | 0.0132s | **3.1x** | **2.9x** |
| uniq | repetitive 10MB | 0.0420s | 0.0037s | 0.0177s | **11.5x** | **4.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | 0.0012s | **0.8x** | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0106s | 0.0049s | 0.0058s | **2.2x** | **1.2x** |
| tac | reverse 100MB text | 0.1055s | 0.0361s | 0.0518s | **2.9x** | **1.4x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0065s | 0.0057s | **1.4x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0086s | 0.0109s | **2.7x** | **1.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0049s | 0.0053s | **1.2x** | **1.1x** |
