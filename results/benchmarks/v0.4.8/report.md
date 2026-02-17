# fcoreutils v0.4.8 — Detailed Results

Generated: 2026-02-17 06:30:17 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 411 | 2 | 99.5% |
| Linux_x86_64 | 413 | 411 | 2 | 99.5% |

**Overall: 822/826 (99.5%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0347s | 0.0064s | 0.0258s | **5.4x** | **4.0x** |
| wc | default 100MB text | 0.2988s | 0.0417s | 0.2269s | **7.2x** | **5.4x** |
| wc | -l 10MB text | 0.0046s | 0.0022s | 0.0027s | **2.1x** | **1.3x** |
| wc | -w 10MB text | 0.0347s | 0.0066s | 0.0236s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0007s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0348s | 0.0020s | 0.0026s | **17.0x** | **1.3x** |
| wc | -L 10MB text | 0.0346s | 0.0061s | 0.0180s | **5.7x** | **3.0x** |
| wc | default 10MB binary | 0.2353s | 0.0175s | 0.1181s | **13.4x** | **6.7x** |
| wc | default 10MB repetitive | 0.0547s | 0.0080s | 0.0374s | **6.8x** | **4.7x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0034s | 0.0062s | **5.6x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0188s | 0.0035s | 0.0065s | **5.4x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0030s | 0.0076s | **6.3x** | **2.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0048s | 0.0167s | **4.4x** | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0033s | 0.0129s | **7.1x** | **3.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0043s | 0.0162s | **6.3x** | **3.8x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0014s | 0.0017s | **2.4x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0009s | 0.0010s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0078s | 0.0091s | 0.0278s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0080s | 0.0092s | 0.0290s | **0.9x** | **3.2x** |
| sha256sum | single 100MB text | 0.0684s | 0.0559s | 0.2624s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0012s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0018s | 0.0020s | 0.0018s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0216s | 0.0179s | 0.0175s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0223s | 0.0187s | 0.0189s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2004s | 0.1436s | 0.1660s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0019s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0025s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0142s | 0.0141s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0150s | 0.0148s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1347s | 0.1164s | 0.1287s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0139s | 0.0140s | **1.1x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0145s | 0.0139s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0102s | 0.0032s | 0.0072s | **3.1x** | **2.2x** |
| base64 | encode 10MB binary | 0.0104s | 0.0036s | 0.0079s | **2.9x** | **2.2x** |
| base64 | decode 1MB | 0.0037s | 0.0014s | 0.0034s | **2.6x** | **2.4x** |
| base64 | decode 10MB | 0.0309s | 0.0040s | 0.0272s | **7.7x** | **6.8x** |
| base64 | encode -w 76 10MB | 0.0098s | 0.0037s | 0.0075s | **2.7x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0029s | 0.0078s | **2.7x** | **2.7x** |
| sort | lexicographic 1MB | 0.0075s | 0.0033s | 0.0041s | **2.3x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0520s | 0.0072s | 0.0300s | **7.2x** | **4.1x** |
| sort | already sorted 10MB | 0.0254s | 0.0033s | 0.0133s | **7.7x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0252s | 0.0051s | 0.0147s | **5.0x** | **2.9x** |
| sort | -n numeric 10MB | 0.0702s | 0.0038s | 0.0645s | **18.6x** | **17.1x** |
| sort | -r reverse 10MB | 0.0525s | 0.0075s | 0.0303s | **7.0x** | **4.1x** |
| sort | -u unique 10MB | 0.0543s | 0.0100s | 0.0361s | **5.4x** | **3.6x** |
| sort | -t, -k2 CSV 10MB | 0.0704s | 0.0148s | 0.0712s | **4.7x** | **4.8x** |
| sort | repetitive 10MB | 0.0470s | 0.0107s | 0.0357s | **4.4x** | **3.3x** |
| sort | --parallel=4 10MB | 0.0507s | 0.0075s | 0.0297s | **6.8x** | **4.0x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0019s | 0.0019s | **1.0x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0073s | 0.0067s | **1.3x** | **0.9x** |
| tr | -d digits 10MB | 0.0112s | 0.0070s | 0.0101s | **1.6x** | **1.4x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0086s | 0.0168s | **2.2x** | **1.9x** |
| tr | -s spaces 10MB | 0.0166s | 0.0074s | 0.0116s | **2.3x** | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0072s | 0.0068s | **1.2x** | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0073s | 0.0103s | **1.5x** | **1.4x** |
| tr | translate binary 10MB | 0.0092s | 0.0078s | 0.0077s | **1.2x** | **1.0x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0031s | 0.0090s | **3.1x** | **2.9x** |
| uniq | default 10MB sorted (low dup) | 0.0169s | 0.0027s | 0.0101s | **6.4x** | **3.8x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0030s | 0.0089s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0063s | 0.0115s | **4.7x** | **1.8x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0027s | 0.0089s | **3.4x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0026s | 0.0089s | **3.5x** | **3.4x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0040s | 0.0097s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0486s | 0.0036s | 0.0152s | **13.6x** | **4.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0086s | 0.0031s | 0.0050s | **2.8x** | **1.6x** |
| tac | reverse 100MB text | 0.0847s | 0.0187s | 0.0443s | **4.5x** | **2.4x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0029s | 0.0047s | **2.8x** | **1.6x** |
| tac | reverse repetitive 10MB | 0.0186s | 0.0047s | 0.0090s | **4.0x** | **1.9x** |
| tac | custom separator 1MB | 0.0042s | 0.0029s | 0.0037s | **1.4x** | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0016s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0031s | 0.0038s | **1.9x** | **1.2x** |
| wc | default 10MB text | 0.0543s | 0.0026s | 0.0302s | **21.0x** | **11.7x** |
| wc | default 100MB text | 0.4832s | 0.0089s | 0.2594s | **54.3x** | **29.1x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0021s | **0.8x** | **0.9x** |
| wc | -w 10MB text | 0.0544s | 0.0083s | 0.0262s | **6.5x** | **3.1x** |
| wc | -c 10MB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| wc | -m 10MB text | 0.0543s | 0.0025s | 0.0020s | **21.6x** | **0.8x** |
| wc | -L 10MB text | 0.0542s | 0.0093s | 0.0205s | **5.8x** | **2.2x** |
| wc | default 10MB binary | 0.3192s | 0.0268s | 0.1565s | **11.9x** | **5.8x** |
| wc | default 10MB repetitive | 0.0729s | 0.0034s | 0.0408s | **21.4x** | **12.0x** |
| wc | 10 files | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0035s | 0.0074s | **6.4x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0035s | 0.0073s | **6.4x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0170s | 0.0034s | 0.0087s | **4.9x** | **2.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0064s | 0.0188s | **3.4x** | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0046s | 0.0136s | **5.3x** | **3.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0050s | 0.0163s | **6.2x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0016s | 0.0020s | **2.2x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.2x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0101s | 0.0084s | **0.9x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0104s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0747s | 0.0749s | 0.0745s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0024s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0171s | 0.0180s | 0.0214s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0180s | 0.0186s | 0.0223s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1607s | 0.1528s | 0.2026s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0015s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0125s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0130s | 0.0128s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1425s | 0.1116s | 0.1126s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0124s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0125s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0020s | 0.0013s | 0.0018s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0123s | 0.0041s | 0.0082s | **3.0x** | **2.0x** |
| base64 | encode 10MB binary | 0.0149s | 0.0046s | 0.0086s | **3.3x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0014s | 0.0044s | **2.9x** | **3.2x** |
| base64 | decode 10MB | 0.0325s | 0.0040s | 0.0338s | **8.2x** | **8.5x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0043s | 0.0082s | **2.9x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0031s | 0.0073s | **2.9x** | **2.4x** |
| sort | lexicographic 1MB | 0.0086s | 0.0037s | 0.0054s | **2.3x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0096s | 0.0353s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0264s | 0.0044s | 0.0177s | **6.0x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0068s | 0.0177s | **4.0x** | **2.6x** |
| sort | -n numeric 10MB | 0.0736s | 0.0058s | 0.0759s | **12.8x** | **13.2x** |
| sort | -r reverse 10MB | 0.0550s | 0.0095s | 0.0361s | **5.8x** | **3.8x** |
| sort | -u unique 10MB | 0.0576s | 0.0096s | 0.0396s | **6.0x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0662s | 0.0190s | 0.0814s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0556s | 0.0120s | 0.0372s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0541s | 0.0097s | 0.0358s | **5.6x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0021s | 0.0020s | **1.1x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0171s | 0.0103s | 0.0074s | **1.7x** | **0.7x** |
| tr | -d digits 10MB | 0.0169s | 0.0089s | 0.0141s | **1.9x** | **1.6x** |
| tr | -d lowercase 10MB | 0.0307s | 0.0115s | 0.0229s | **2.7x** | **2.0x** |
| tr | -s spaces 10MB | 0.0269s | 0.0094s | 0.0268s | **2.9x** | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0101s | 0.0074s | **1.2x** | **0.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0167s | 0.0090s | 0.0142s | **1.9x** | **1.6x** |
| tr | translate binary 10MB | 0.0112s | 0.0108s | 0.0083s | **1.0x** | **0.8x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0035s | 0.0112s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0029s | 0.0135s | **4.8x** | **4.7x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0035s | 0.0111s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0084s | 0.0156s | **3.5x** | **1.9x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0044s | 0.0135s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0421s | 0.0040s | 0.0162s | **10.5x** | **4.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0039s | 0.0058s | **2.7x** | **1.5x** |
| tac | reverse 100MB text | 0.1039s | 0.0240s | 0.0515s | **4.3x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0035s | 0.0056s | **2.7x** | **1.6x** |
| tac | reverse repetitive 10MB | 0.0236s | 0.0062s | 0.0110s | **3.8x** | **1.8x** |
| tac | custom separator 1MB | 0.0059s | 0.0036s | 0.0053s | **1.6x** | **1.5x** |
