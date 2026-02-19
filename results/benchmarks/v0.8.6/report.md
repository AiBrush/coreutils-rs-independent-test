# fcoreutils v0.8.6 — Detailed Results

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| wc | default 1MB text | 0.0038s | 0.0027s | 0.0033s | **1.4x** | **1.2x** |
| wc | default 10MB text | 0.0341s | 0.0066s | 0.0250s | **5.2x** | **3.8x** |
| wc | default 100MB text | 0.3003s | 0.0483s | 0.2222s | **6.2x** | **4.6x** |
| wc | -l 10MB text | 0.0039s | 0.0024s | 0.0024s | **1.6x** | **1.0x** |
| wc | -w 10MB text | 0.0341s | 0.0063s | 0.0228s | **5.4x** | **3.6x** |
| wc | -c 10MB text | 0.0007s | 0.0010s | 0.0011s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0341s | 0.0024s | 0.0025s | **14.4x** | **1.1x** |
| wc | -L 10MB text | 0.0340s | 0.0065s | 0.0175s | **5.2x** | **2.7x** |
| wc | default 10MB binary | 0.2359s | 0.0173s | 0.1140s | **13.6x** | **6.6x** |
| wc | default 10MB repetitive | 0.0527s | 0.0084s | 0.0365s | **6.2x** | **4.3x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0035s | 0.0063s | **5.4x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0037s | 0.0065s | **5.2x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0095s | 0.0072s | **2.0x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0117s | 0.0168s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0098s | 0.0130s | **2.4x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0269s | 0.0101s | 0.0166s | **2.7x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0027s | 0.0018s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0024s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0030s | 0.0038s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0072s | 0.0086s | 0.0273s | **0.8x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0097s | 0.0290s | **0.9x** | **3.0x** |
| sha256sum | single 100MB text | 0.0706s | 0.0695s | 0.2641s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0018s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0209s | 0.0174s | 0.0173s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0223s | 0.0183s | 0.0186s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2018s | 0.1447s | 0.1673s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0025s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0139s | 0.0134s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0150s | 0.0143s | 0.0145s | **1.1x** | **1.0x** |
| b2sum | single 100MB text | 0.1366s | 0.1160s | 0.1309s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0141s | 0.0135s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0140s | 0.0135s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0018s | 0.0018s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0017s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0098s | 0.0052s | 0.0071s | **1.9x** | **1.4x** |
| base64 | encode 10MB binary | 0.0105s | 0.0055s | 0.0080s | **1.9x** | **1.5x** |
| base64 | decode 1MB | 0.0039s | 0.0020s | 0.0037s | **2.0x** | **1.9x** |
| base64 | decode 10MB | 0.0309s | 0.0043s | 0.0266s | **7.1x** | **6.2x** |
| base64 | encode -w 76 10MB | 0.0097s | 0.0052s | 0.0072s | **1.9x** | **1.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0076s | 0.0047s | 0.0073s | **1.6x** | **1.6x** |
| sort | lexicographic 1MB | 0.0078s | 0.0033s | 0.0045s | **2.3x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0533s | 0.0101s | 0.0324s | **5.3x** | **3.2x** |
| sort | already sorted 10MB | 0.0254s | 0.0038s | 0.0139s | **6.6x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0249s | 0.0048s | 0.0143s | **5.2x** | **3.0x** |
| sort | -n numeric 10MB | 0.0707s | 0.0041s | 0.0650s | **17.1x** | **15.7x** |
| sort | -r reverse 10MB | 0.0531s | 0.0097s | 0.0297s | **5.5x** | **3.1x** |
| sort | -u unique 10MB | 0.0560s | 0.0108s | 0.0360s | **5.2x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0728s | 0.0153s | 0.0728s | **4.7x** | **4.7x** |
| sort | repetitive 10MB | 0.0472s | 0.0100s | 0.0364s | **4.7x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0531s | 0.0111s | 0.0364s | **4.8x** | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0017s | 0.0019s | **1.1x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0043s | 0.0071s | **2.1x** | **1.7x** |
| tr | -d digits 10MB | 0.0117s | 0.0055s | 0.0107s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0070s | 0.0171s | **2.8x** | **2.4x** |
| tr | -s spaces 10MB | 0.0172s | 0.0045s | 0.0122s | **3.8x** | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0093s | 0.0045s | 0.0071s | **2.1x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0054s | 0.0106s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0093s | 0.0049s | 0.0078s | **1.9x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0095s | 0.0018s | 0.0089s | **5.4x** | **5.1x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0026s | 0.0100s | **6.3x** | **3.9x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0017s | 0.0089s | **5.4x** | **5.2x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0071s | 0.0122s | **4.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0095s | 0.0018s | 0.0092s | **5.2x** | **5.0x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0019s | 0.0092s | **5.1x** | **4.9x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0041s | 0.0103s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0485s | 0.0033s | 0.0154s | **14.9x** | **4.7x** |
| tac | reverse 100KB text | 0.0009s | 0.0013s | 0.0011s | **0.7x** | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | 0.0015s | **0.9x** | **0.9x** |
| tac | reverse 10MB text | 0.0084s | 0.0052s | 0.0049s | **1.6x** | **1.0x** |
| tac | reverse 100MB text | 0.0865s | 0.0219s | 0.0446s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0049s | 0.0046s | **1.7x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0190s | 0.0104s | 0.0090s | **1.8x** | **0.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0041s | 0.0039s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0046s | 0.0031s | 0.0042s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0433s | 0.0027s | 0.0377s | **16.0x** | **14.0x** |
| wc | default 100MB text | 0.3788s | 0.0115s | 0.3253s | **33.0x** | **28.3x** |
| wc | -l 10MB text | 0.0015s | 0.0022s | 0.0018s | **0.7x** | **0.8x** |
| wc | -w 10MB text | 0.0431s | 0.0098s | 0.0302s | **4.4x** | **3.1x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| wc | -m 10MB text | 0.0432s | 0.0024s | 0.0017s | **17.8x** | **0.7x** |
| wc | -L 10MB text | 0.0432s | 0.0106s | 0.0164s | **4.1x** | **1.5x** |
| wc | default 10MB binary | 0.3232s | 0.0321s | 0.1590s | **10.1x** | **5.0x** |
| wc | default 10MB repetitive | 0.0557s | 0.0037s | 0.0505s | **15.1x** | **13.6x** |
| wc | 10 files | 0.0007s | 0.0013s | 0.0012s | **0.6x** | **1.0x** |
| wc | 100 files | 0.0011s | 0.0016s | 0.0021s | **0.7x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0199s | 0.0037s | 0.0056s | **5.4x** | **1.5x** |
| cut | -c1-100 10MB CSV | 0.0199s | 0.0035s | 0.0058s | **5.7x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0212s | 0.0095s | 0.0075s | **2.2x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0243s | 0.0117s | 0.0162s | **2.1x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0267s | 0.0106s | 0.0124s | **2.5x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0300s | 0.0113s | 0.0155s | **2.7x** | **1.4x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0012s | 0.0009s | **0.5x** | **0.7x** |
| cut | -d, -f1 1MB text | 0.0040s | 0.0029s | 0.0017s | **1.4x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0012s | 0.0008s | **0.5x** | **0.7x** |
| sha256sum | single 100KB text | 0.0010s | 0.0029s | 0.0010s | **0.4x** | **0.4x** |
| sha256sum | single 1MB text | 0.0018s | 0.0040s | 0.0018s | **0.5x** | **0.4x** |
| sha256sum | single 10MB text | 0.0102s | 0.0123s | 0.0102s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0103s | 0.0128s | 0.0105s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0902s | 0.0932s | 0.0893s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0019s | 0.0010s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0015s | 0.0021s | 0.0014s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0011s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0024s | 0.0033s | 0.0029s | **0.7x** | **0.9x** |
| md5sum | single 10MB text | 0.0166s | 0.0183s | 0.0209s | **0.9x** | **1.1x** |
| md5sum | single 10MB binary | 0.0174s | 0.0186s | 0.0216s | **0.9x** | **1.2x** |
| md5sum | single 100MB text | 0.1516s | 0.1389s | 0.1943s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0010s | 0.0021s | 0.0010s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0015s | 0.0027s | 0.0015s | **0.6x** | **0.6x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0019s | 0.0020s | **1.1x** | **1.0x** |
| b2sum | single 10MB text | 0.0149s | 0.0129s | 0.0115s | **1.2x** | **0.9x** |
| b2sum | single 10MB binary | 0.0152s | 0.0130s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1363s | 0.0974s | 0.1043s | **1.4x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0126s | 0.0112s | **1.2x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0130s | 0.0116s | **1.1x** | **0.9x** |
| b2sum | 100 files | 0.0014s | 0.0018s | 0.0015s | **0.7x** | **0.8x** |
| base64 | encode 100KB text | 0.0008s | 0.0014s | 0.0009s | **0.6x** | **0.6x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0012s | **1.2x** | **0.9x** |
| base64 | encode 10MB text | 0.0111s | 0.0058s | 0.0049s | **1.9x** | **0.8x** |
| base64 | encode 10MB binary | 0.0113s | 0.0066s | 0.0053s | **1.7x** | **0.8x** |
| base64 | decode 1MB | 0.0037s | 0.0027s | 0.0034s | **1.4x** | **1.3x** |
| base64 | decode 10MB | 0.0306s | 0.0046s | 0.0264s | **6.7x** | **5.8x** |
| base64 | encode -w 76 10MB | 0.0109s | 0.0059s | 0.0051s | **1.8x** | **0.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0048s | 0.0053s | **1.8x** | **1.1x** |
| sort | lexicographic 1MB | 0.0085s | 0.0038s | 0.0047s | **2.2x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0520s | 0.0104s | 0.0318s | **5.0x** | **3.1x** |
| sort | already sorted 10MB | 0.0232s | 0.0052s | 0.0140s | **4.5x** | **2.7x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0064s | 0.0145s | **3.8x** | **2.3x** |
| sort | -n numeric 10MB | 0.0736s | 0.0068s | 0.0690s | **10.9x** | **10.2x** |
| sort | -r reverse 10MB | 0.0544s | 0.0110s | 0.0319s | **4.9x** | **2.9x** |
| sort | -u unique 10MB | 0.0569s | 0.0113s | 0.0392s | **5.0x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0708s | 0.0234s | 0.0810s | **3.0x** | **3.5x** |
| sort | repetitive 10MB | 0.0503s | 0.0135s | 0.0326s | **3.7x** | **2.4x** |
| sort | --parallel=4 10MB | 0.0529s | 0.0112s | 0.0323s | **4.7x** | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0016s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0097s | 0.0040s | 0.0065s | **2.4x** | **1.6x** |
| tr | -d digits 10MB | 0.0161s | 0.0043s | 0.0134s | **3.8x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0283s | 0.0049s | 0.0236s | **5.7x** | **4.8x** |
| tr | -s spaces 10MB | 0.0242s | 0.0041s | 0.0290s | **5.9x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0081s | 0.0042s | 0.0064s | **1.9x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0162s | 0.0041s | 0.0134s | **3.9x** | **3.2x** |
| tr | translate binary 10MB | 0.0088s | 0.0041s | 0.0073s | **2.2x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0087s | 0.0015s | 0.0101s | **5.8x** | **6.7x** |
| uniq | default 10MB sorted (low dup) | 0.0189s | 0.0031s | 0.0127s | **6.1x** | **4.1x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0014s | 0.0102s | **6.6x** | **7.1x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0070s | 0.0138s | **4.2x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0015s | 0.0102s | **6.5x** | **7.0x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0015s | 0.0106s | **6.5x** | **7.2x** |
| uniq | -i case insensitive 10MB | 0.0191s | 0.0050s | 0.0125s | **3.8x** | **2.5x** |
| uniq | repetitive 10MB | 0.0491s | 0.0032s | 0.0154s | **15.5x** | **4.9x** |
| tac | reverse 100KB text | 0.0007s | 0.0014s | 0.0009s | **0.5x** | **0.7x** |
| tac | reverse 1MB text | 0.0015s | 0.0019s | 0.0014s | **0.8x** | **0.7x** |
| tac | reverse 10MB text | 0.0085s | 0.0070s | 0.0047s | **1.2x** | **0.7x** |
| tac | reverse 100MB text | 0.0807s | 0.0275s | 0.0434s | **2.9x** | **1.6x** |
| tac | reverse CSV 10MB | 0.0077s | 0.0063s | 0.0045s | **1.2x** | **0.7x** |
| tac | reverse repetitive 10MB | 0.0154s | 0.0134s | 0.0087s | **1.1x** | **0.7x** |
| tac | custom separator 1MB | 0.0049s | 0.0050s | 0.0041s | **1.0x** | **0.8x** |
