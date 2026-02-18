# fcoreutils v0.8.4 — Detailed Results

Generated: 2026-02-18 22:30:44 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0035s | **1.5x** | **1.4x** |
| wc | default 10MB text | 0.0346s | 0.0066s | 0.0277s | **5.2x** | **4.2x** |
| wc | default 100MB text | 0.3011s | 0.0480s | 0.2448s | **6.3x** | **5.1x** |
| wc | -l 10MB text | 0.0042s | 0.0021s | 0.0029s | **2.0x** | **1.4x** |
| wc | -w 10MB text | 0.0345s | 0.0065s | 0.0231s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0345s | 0.0023s | 0.0028s | **15.0x** | **1.2x** |
| wc | -L 10MB text | 0.0344s | 0.0063s | 0.0176s | **5.5x** | **2.8x** |
| wc | default 10MB binary | 0.2349s | 0.0168s | 0.1159s | **14.0x** | **6.9x** |
| wc | default 10MB repetitive | 0.0531s | 0.0083s | 0.0433s | **6.4x** | **5.2x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0184s | 0.0034s | 0.0060s | **5.4x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0035s | 0.0061s | **5.2x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0184s | 0.0093s | 0.0069s | **2.0x** | **0.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0209s | 0.0115s | 0.0163s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0096s | 0.0127s | **2.4x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0099s | 0.0163s | **2.7x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | 0.0017s | **1.3x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0023s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0029s | 0.0038s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0078s | 0.0088s | 0.0277s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0095s | 0.0291s | **0.9x** | **3.1x** |
| sha256sum | single 100MB text | 0.0700s | 0.0695s | 0.2642s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0011s | 0.0018s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0017s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0022s | 0.0012s | **0.6x** | **0.5x** |
| md5sum | single 1MB text | 0.0031s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0213s | 0.0177s | 0.0179s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0224s | 0.0186s | 0.0187s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2023s | 0.1449s | 0.1726s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0018s | 0.0010s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0024s | 0.0018s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0021s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0144s | 0.0140s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0152s | 0.0148s | 0.0148s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1369s | 0.1177s | 0.1307s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0140s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0140s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0017s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0010s | **0.7x** | **0.8x** |
| base64 | encode 1MB text | 0.0017s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0099s | 0.0051s | 0.0073s | **1.9x** | **1.4x** |
| base64 | encode 10MB binary | 0.0107s | 0.0053s | 0.0077s | **2.0x** | **1.5x** |
| base64 | decode 1MB | 0.0038s | 0.0018s | 0.0036s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0309s | 0.0042s | 0.0265s | **7.4x** | **6.4x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0051s | 0.0074s | **2.0x** | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0079s | 0.0046s | 0.0074s | **1.7x** | **1.6x** |
| sort | lexicographic 1MB | 0.0075s | 0.0031s | 0.0041s | **2.4x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0517s | 0.0096s | 0.0314s | **5.4x** | **3.3x** |
| sort | already sorted 10MB | 0.0252s | 0.0036s | 0.0139s | **7.0x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0255s | 0.0048s | 0.0142s | **5.3x** | **3.0x** |
| sort | -n numeric 10MB | 0.0717s | 0.0042s | 0.0687s | **17.2x** | **16.5x** |
| sort | -r reverse 10MB | 0.0538s | 0.0099s | 0.0330s | **5.4x** | **3.3x** |
| sort | -u unique 10MB | 0.0552s | 0.0107s | 0.0374s | **5.2x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0708s | 0.0152s | 0.0722s | **4.7x** | **4.8x** |
| sort | repetitive 10MB | 0.0462s | 0.0104s | 0.0369s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0517s | 0.0095s | 0.0307s | **5.4x** | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0018s | **1.3x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0093s | 0.0043s | 0.0067s | **2.2x** | **1.6x** |
| tr | -d digits 10MB | 0.0111s | 0.0053s | 0.0102s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0068s | 0.0166s | **2.8x** | **2.4x** |
| tr | -s spaces 10MB | 0.0165s | 0.0046s | 0.0114s | **3.6x** | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0045s | 0.0068s | **2.0x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0053s | 0.0103s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0093s | 0.0046s | 0.0076s | **2.0x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0017s | 0.0089s | **5.4x** | **5.1x** |
| uniq | default 10MB sorted (low dup) | 0.0165s | 0.0027s | 0.0098s | **6.2x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0017s | 0.0089s | **5.4x** | **5.1x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0069s | 0.0117s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0017s | 0.0090s | **5.4x** | **5.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0017s | 0.0089s | **5.5x** | **5.3x** |
| uniq | -i case insensitive 10MB | 0.0165s | 0.0039s | 0.0099s | **4.2x** | **2.5x** |
| uniq | repetitive 10MB | 0.0480s | 0.0028s | 0.0152s | **17.0x** | **5.4x** |
| tac | reverse 100KB text | 0.0008s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | 0.0015s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0089s | 0.0053s | 0.0050s | **1.7x** | **1.0x** |
| tac | reverse 100MB text | 0.0870s | 0.0219s | 0.0456s | **4.0x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0048s | 0.0045s | **1.7x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0182s | 0.0095s | 0.0086s | **1.9x** | **0.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0039s | 0.0039s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0039s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0541s | 0.0031s | 0.0311s | **17.7x** | **10.2x** |
| wc | default 100MB text | 0.4829s | 0.0143s | 0.2659s | **33.7x** | **18.5x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0546s | 0.0092s | 0.0255s | **5.9x** | **2.8x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0547s | 0.0030s | 0.0020s | **18.1x** | **0.7x** |
| wc | -L 10MB text | 0.0548s | 0.0111s | 0.0168s | **4.9x** | **1.5x** |
| wc | default 10MB binary | 0.3182s | 0.0272s | 0.1558s | **11.7x** | **5.7x** |
| wc | default 10MB repetitive | 0.0733s | 0.0046s | 0.0424s | **16.0x** | **9.3x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0040s | 0.0072s | **5.7x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0040s | 0.0073s | **5.7x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0094s | 0.0085s | **1.8x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0220s | 0.0115s | 0.0182s | **1.9x** | **1.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0104s | 0.0137s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0336s | 0.0111s | 0.0168s | **3.0x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0029s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0027s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0035s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0085s | 0.0104s | 0.0088s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0105s | 0.0087s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0763s | 0.0749s | 0.0753s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.7x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0174s | 0.0180s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0180s | 0.0187s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1618s | 0.1534s | 0.2057s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0126s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0158s | 0.0132s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1433s | 0.1124s | 0.1136s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0128s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0125s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.1x** | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | 0.0019s | **1.3x** | **1.2x** |
| base64 | encode 10MB text | 0.0124s | 0.0056s | 0.0083s | **2.2x** | **1.5x** |
| base64 | encode 10MB binary | 0.0128s | 0.0056s | 0.0086s | **2.3x** | **1.5x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | 0.0043s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0328s | 0.0051s | 0.0340s | **6.5x** | **6.7x** |
| base64 | encode -w 76 10MB | 0.0125s | 0.0054s | 0.0083s | **2.3x** | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0043s | 0.0073s | **2.0x** | **1.7x** |
| sort | lexicographic 1MB | 0.0086s | 0.0036s | 0.0055s | **2.4x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0546s | 0.0092s | 0.0361s | **6.0x** | **3.9x** |
| sort | already sorted 10MB | 0.0265s | 0.0051s | 0.0179s | **5.2x** | **3.5x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0065s | 0.0184s | **4.2x** | **2.8x** |
| sort | -n numeric 10MB | 0.0736s | 0.0053s | 0.0769s | **13.8x** | **14.4x** |
| sort | -r reverse 10MB | 0.0548s | 0.0093s | 0.0366s | **5.9x** | **3.9x** |
| sort | -u unique 10MB | 0.0578s | 0.0094s | 0.0400s | **6.1x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0669s | 0.0200s | 0.0828s | **3.3x** | **4.1x** |
| sort | repetitive 10MB | 0.0575s | 0.0127s | 0.0373s | **4.5x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0094s | 0.0365s | **5.8x** | **3.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0039s | 0.0078s | **3.3x** | **2.0x** |
| tr | -d digits 10MB | 0.0169s | 0.0044s | 0.0138s | **3.8x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0297s | 0.0051s | 0.0212s | **5.8x** | **4.1x** |
| tr | -s spaces 10MB | 0.0296s | 0.0038s | 0.0279s | **7.7x** | **7.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0038s | 0.0077s | **3.3x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0167s | 0.0043s | 0.0137s | **3.9x** | **3.2x** |
| tr | translate binary 10MB | 0.0116s | 0.0039s | 0.0084s | **3.0x** | **2.2x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | 0.0110s | **6.4x** | **5.9x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0031s | 0.0129s | **4.5x** | **4.2x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0019s | 0.0111s | **6.4x** | **5.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0077s | 0.0155s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0019s | 0.0110s | **6.5x** | **5.9x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | 0.0115s | **6.3x** | **6.0x** |
| uniq | -i case insensitive 10MB | 0.0143s | 0.0046s | 0.0130s | **3.1x** | **2.8x** |
| uniq | repetitive 10MB | 0.0423s | 0.0037s | 0.0161s | **11.3x** | **4.3x** |
| tac | reverse 100KB text | 0.0010s | 0.0015s | 0.0013s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0106s | 0.0061s | 0.0059s | **1.7x** | **1.0x** |
| tac | reverse 100MB text | 0.1048s | 0.0274s | 0.0521s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0058s | 0.0057s | **1.6x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0108s | 0.0112s | **2.1x** | **1.0x** |
| tac | custom separator 1MB | 0.0060s | 0.0050s | 0.0054s | **1.2x** | **1.1x** |
