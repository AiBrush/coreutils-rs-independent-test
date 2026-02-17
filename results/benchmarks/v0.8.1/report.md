# fcoreutils v0.8.1 — Detailed Results

Generated: 2026-02-17 04:11:24 UTC

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
| wc | default 100KB text | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.2x** |
| wc | default 1MB text | 0.0040s | 0.0029s | 0.0036s | **1.4x** | **1.2x** |
| wc | default 10MB text | 0.0346s | 0.0070s | 0.0264s | **4.9x** | **3.8x** |
| wc | default 100MB text | 0.3009s | 0.0468s | 0.2288s | **6.4x** | **4.9x** |
| wc | -l 10MB text | 0.0053s | 0.0028s | 0.0041s | **1.9x** | **1.5x** |
| wc | -w 10MB text | 0.0349s | 0.0068s | 0.0239s | **5.1x** | **3.5x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0349s | 0.0029s | 0.0039s | **11.9x** | **1.3x** |
| wc | -L 10MB text | 0.0351s | 0.0070s | 0.0184s | **5.0x** | **2.6x** |
| wc | default 10MB binary | 0.2348s | 0.0175s | 0.1178s | **13.4x** | **6.7x** |
| wc | default 10MB repetitive | 0.0533s | 0.0096s | 0.0378s | **5.5x** | **3.9x** |
| wc | 10 files | 0.0010s | 0.0013s | 0.0013s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0015s | 0.0016s | 0.0018s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0038s | 0.0067s | **4.9x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0038s | 0.0066s | **5.0x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0098s | 0.0075s | **1.9x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0123s | 0.0166s | **1.7x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0100s | 0.0129s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0101s | 0.0163s | **2.6x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | 0.0018s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0024s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0029s | 0.0037s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0078s | 0.0090s | 0.0279s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0091s | 0.0288s | **0.9x** | **3.2x** |
| sha256sum | single 100MB text | 0.0690s | 0.0706s | 0.2638s | **1.0x** | **3.7x** |
| sha256sum | 10 files | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0020s | 0.0026s | 0.0020s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0034s | 0.0038s | 0.0030s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0219s | 0.0183s | 0.0186s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0224s | 0.0186s | 0.0188s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2029s | 0.1442s | 0.1657s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0011s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0023s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0144s | 0.0139s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0144s | 0.0141s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1347s | 0.1169s | 0.1291s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0143s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0139s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.8x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0098s | 0.0034s | 0.0072s | **2.8x** | **2.1x** |
| base64 | encode 10MB binary | 0.0101s | 0.0035s | 0.0073s | **2.9x** | **2.1x** |
| base64 | decode 1MB | 0.0038s | 0.0017s | 0.0035s | **2.2x** | **2.1x** |
| base64 | decode 10MB | 0.0307s | 0.0043s | 0.0269s | **7.2x** | **6.3x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0034s | 0.0075s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0032s | 0.0077s | **2.5x** | **2.4x** |
| sort | lexicographic 1MB | 0.0074s | 0.0032s | 0.0043s | **2.3x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0516s | 0.0096s | 0.0289s | **5.4x** | **3.0x** |
| sort | already sorted 10MB | 0.0247s | 0.0035s | 0.0133s | **7.1x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0048s | 0.0137s | **5.1x** | **2.9x** |
| sort | -n numeric 10MB | 0.0690s | 0.0040s | 0.0639s | **17.2x** | **16.0x** |
| sort | -r reverse 10MB | 0.0517s | 0.0096s | 0.0290s | **5.4x** | **3.0x** |
| sort | -u unique 10MB | 0.0548s | 0.0107s | 0.0355s | **5.1x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0697s | 0.0149s | 0.0698s | **4.7x** | **4.7x** |
| sort | repetitive 10MB | 0.0461s | 0.0107s | 0.0365s | **4.3x** | **3.4x** |
| sort | --parallel=4 10MB | 0.0513s | 0.0100s | 0.0313s | **5.1x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0046s | 0.0067s | **2.0x** | **1.5x** |
| tr | -d digits 10MB | 0.0112s | 0.0052s | 0.0103s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0068s | 0.0169s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0166s | 0.0043s | 0.0114s | **3.9x** | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0041s | 0.0066s | **2.1x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0052s | 0.0102s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0041s | 0.0078s | **2.3x** | **1.9x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0017s | 0.0088s | **5.4x** | **5.1x** |
| uniq | default 10MB sorted (low dup) | 0.0166s | 0.0026s | 0.0098s | **6.5x** | **3.8x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0017s | 0.0088s | **5.4x** | **5.1x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0068s | 0.0115s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0016s | 0.0086s | **5.7x** | **5.3x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0016s | 0.0084s | **5.8x** | **5.3x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0040s | 0.0098s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0488s | 0.0031s | 0.0160s | **15.8x** | **5.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0013s | 0.0011s | **0.6x** | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | 0.0015s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0088s | 0.0046s | 0.0049s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0847s | 0.0211s | 0.0438s | **4.0x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0047s | 0.0044s | **1.7x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0191s | 0.0097s | 0.0087s | **2.0x** | **0.9x** |
| tac | custom separator 1MB | 0.0043s | 0.0042s | 0.0038s | **1.0x** | **0.9x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0015s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0039s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0543s | 0.0031s | 0.0311s | **17.6x** | **10.1x** |
| wc | default 100MB text | 0.4826s | 0.0148s | 0.2650s | **32.5x** | **17.9x** |
| wc | -l 10MB text | 0.0021s | 0.0024s | 0.0019s | **0.9x** | **0.8x** |
| wc | -w 10MB text | 0.0547s | 0.0091s | 0.0260s | **6.0x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0545s | 0.0032s | 0.0021s | **17.0x** | **0.7x** |
| wc | -L 10MB text | 0.0547s | 0.0098s | 0.0170s | **5.6x** | **1.7x** |
| wc | default 10MB binary | 0.3164s | 0.0271s | 0.1561s | **11.7x** | **5.8x** |
| wc | default 10MB repetitive | 0.0730s | 0.0045s | 0.0421s | **16.1x** | **9.3x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0227s | 0.0040s | 0.0075s | **5.7x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0230s | 0.0040s | 0.0079s | **5.7x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0169s | 0.0095s | 0.0089s | **1.8x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0113s | 0.0183s | **2.0x** | **1.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0105s | 0.0140s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0107s | 0.0166s | **2.9x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0028s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0033s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0085s | 0.0101s | 0.0087s | **0.8x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0104s | 0.0088s | **0.9x** | **0.8x** |
| sha256sum | single 100MB text | 0.0753s | 0.0746s | 0.0754s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0175s | 0.0183s | 0.0218s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0184s | 0.0191s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1611s | 0.1535s | 0.2032s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0032s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0156s | 0.0126s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0159s | 0.0134s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1427s | 0.1125s | 0.1132s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0127s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0129s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0013s | 0.0012s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0124s | 0.0044s | 0.0081s | **2.8x** | **1.9x** |
| base64 | encode 10MB binary | 0.0131s | 0.0044s | 0.0086s | **3.0x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0044s | **1.9x** | **2.0x** |
| base64 | decode 10MB | 0.0329s | 0.0051s | 0.0340s | **6.5x** | **6.7x** |
| base64 | encode -w 76 10MB | 0.0127s | 0.0044s | 0.0083s | **2.9x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0042s | 0.0075s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0087s | 0.0035s | 0.0055s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0546s | 0.0096s | 0.0364s | **5.7x** | **3.8x** |
| sort | already sorted 10MB | 0.0266s | 0.0049s | 0.0182s | **5.4x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0065s | 0.0187s | **4.2x** | **2.9x** |
| sort | -n numeric 10MB | 0.0739s | 0.0055s | 0.0757s | **13.4x** | **13.7x** |
| sort | -r reverse 10MB | 0.0561s | 0.0097s | 0.0368s | **5.8x** | **3.8x** |
| sort | -u unique 10MB | 0.0580s | 0.0100s | 0.0400s | **5.8x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0670s | 0.0196s | 0.0851s | **3.4x** | **4.3x** |
| sort | repetitive 10MB | 0.0575s | 0.0127s | 0.0371s | **4.5x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0552s | 0.0100s | 0.0363s | **5.5x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0039s | 0.0078s | **3.2x** | **2.0x** |
| tr | -d digits 10MB | 0.0172s | 0.0042s | 0.0135s | **4.1x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0295s | 0.0049s | 0.0212s | **6.0x** | **4.3x** |
| tr | -s spaces 10MB | 0.0270s | 0.0039s | 0.0283s | **7.0x** | **7.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0131s | 0.0037s | 0.0073s | **3.5x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0173s | 0.0042s | 0.0133s | **4.1x** | **3.1x** |
| tr | translate binary 10MB | 0.0121s | 0.0038s | 0.0080s | **3.2x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | 0.0122s | **6.2x** | **6.4x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0032s | 0.0133s | **4.4x** | **4.2x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0019s | 0.0123s | **6.4x** | **6.5x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0078s | 0.0158s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0019s | 0.0122s | **6.4x** | **6.4x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0019s | 0.0121s | **6.4x** | **6.4x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0045s | 0.0134s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0422s | 0.0036s | 0.0178s | **11.7x** | **4.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0014s | 0.0013s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0110s | 0.0051s | 0.0059s | **2.1x** | **1.1x** |
| tac | reverse 100MB text | 0.1034s | 0.0268s | 0.0523s | **3.9x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0054s | 0.0056s | **1.8x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0238s | 0.0102s | 0.0111s | **2.3x** | **1.1x** |
| tac | custom separator 1MB | 0.0060s | 0.0053s | 0.0052s | **1.2x** | **1.0x** |
