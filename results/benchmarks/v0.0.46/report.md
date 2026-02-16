# fcoreutils v0.0.46 — Detailed Results

Generated: 2026-02-16 12:55:39 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 411 | 2 | 99.5% |

**Overall: 823/826 (99.6%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0012s | **0.9x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.5x** |
| wc | default 10MB text | 0.0337s | 0.0057s | **5.9x** |
| wc | default 100MB text | 0.2889s | 0.0389s | **7.4x** |
| wc | -l 10MB text | 0.0036s | 0.0019s | **1.9x** |
| wc | -w 10MB text | 0.0335s | 0.0059s | **5.7x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0338s | 0.0021s | **16.1x** |
| wc | -L 10MB text | 0.0339s | 0.0059s | **5.8x** |
| wc | default 10MB binary | 0.2342s | 0.0167s | **14.0x** |
| wc | default 10MB repetitive | 0.0546s | 0.0070s | **7.8x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0025s | **7.1x** |
| cut | -c1-100 10MB CSV | 0.0183s | 0.0026s | **6.9x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0041s | **4.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0041s | **5.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0227s | 0.0044s | **5.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0260s | 0.0046s | **5.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | single 1MB text | 0.0016s | 0.0025s | **0.6x** |
| sha256sum | single 10MB text | 0.0068s | 0.0070s | **1.0x** |
| sha256sum | single 10MB binary | 0.0068s | 0.0073s | **0.9x** |
| sha256sum | single 100MB text | 0.0574s | 0.0536s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0025s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0035s | **0.8x** |
| md5sum | single 10MB text | 0.0203s | 0.0159s | **1.3x** |
| md5sum | single 10MB binary | 0.0208s | 0.0167s | **1.2x** |
| md5sum | single 100MB text | 0.1892s | 0.1407s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.5x** |
| md5sum | 100 files | 0.0016s | 0.0025s | **0.6x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | **0.8x** |
| b2sum | single 1MB text | 0.0020s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0133s | 0.0128s | **1.0x** |
| b2sum | single 10MB binary | 0.0137s | 0.0133s | **1.0x** |
| b2sum | single 100MB text | 0.1240s | 0.1177s | **1.1x** |
| b2sum | -l 256 10MB | 0.0132s | 0.0127s | **1.0x** |
| b2sum | -l 128 10MB | 0.0133s | 0.0127s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0015s | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0015s | 0.0015s | **1.0x** |
| base64 | encode 10MB text | 0.0089s | 0.0031s | **2.9x** |
| base64 | encode 10MB binary | 0.0090s | 0.0030s | **3.0x** |
| base64 | decode 1MB | 0.0036s | 0.0022s | **1.6x** |
| base64 | decode 10MB | 0.0299s | 0.0139s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0089s | 0.0033s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0069s | 0.0028s | **2.5x** |
| sort | lexicographic 1MB | 0.0074s | 0.0027s | **2.7x** |
| sort | lexicographic 10MB random | 0.0502s | 0.0052s | **9.6x** |
| sort | already sorted 10MB | 0.0234s | 0.0050s | **4.7x** |
| sort | reverse sorted 10MB | 0.0236s | 0.0045s | **5.2x** |
| sort | -n numeric 10MB | 0.0678s | 0.0206s | **3.3x** |
| sort | -r reverse 10MB | 0.0509s | 0.0059s | **8.6x** |
| sort | -u unique 10MB | 0.0532s | 0.0120s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0687s | 0.0181s | **3.8x** |
| sort | repetitive 10MB | 0.0426s | 0.0119s | **3.6x** |
| sort | --parallel=4 10MB | 0.0488s | 0.0055s | **8.9x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0018s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0061s | **1.5x** |
| tr | -d digits 10MB | 0.0112s | 0.0120s | **0.9x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0187s | **1.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0132s | **1.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0058s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0108s | 0.0120s | **0.9x** |
| tr | translate binary 10MB | 0.0093s | 0.0090s | **1.0x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0159s | 0.0027s | **5.9x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0045s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0287s | 0.0064s | **4.5x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0045s | **2.0x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0044s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0159s | 0.0040s | **3.9x** |
| uniq | repetitive 10MB | 0.0477s | 0.0043s | **11.0x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0015s | 0.0015s | **1.0x** |
| tac | reverse 10MB text | 0.0080s | 0.0045s | **1.8x** |
| tac | reverse 100MB text | 0.0761s | 0.0376s | **2.0x** |
| tac | reverse CSV 10MB | 0.0076s | 0.0045s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0180s | 0.0097s | **1.9x** |
| tac | custom separator 1MB | 0.0041s | 0.0038s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0017s | 0.0013s | **1.3x** |
| wc | default 1MB text | 0.0059s | 0.0034s | **1.7x** |
| wc | default 10MB text | 0.0550s | 0.0034s | **16.3x** |
| wc | default 100MB text | 0.4846s | 0.0152s | **31.8x** |
| wc | -l 10MB text | 0.0027s | 0.0029s | **0.9x** |
| wc | -w 10MB text | 0.0557s | 0.0095s | **5.9x** |
| wc | -c 10MB text | 0.0009s | 0.0012s | **0.8x** |
| wc | -m 10MB text | 0.0544s | 0.0037s | **14.6x** |
| wc | -L 10MB text | 0.0555s | 0.0116s | **4.8x** |
| wc | default 10MB binary | 0.3196s | 0.0288s | **11.1x** |
| wc | default 10MB repetitive | 0.0739s | 0.0053s | **13.8x** |
| wc | 10 files | 0.0014s | 0.0018s | **0.8x** |
| wc | 100 files | 0.0021s | 0.0022s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0233s | 0.0036s | **6.5x** |
| cut | -c1-100 10MB CSV | 0.0234s | 0.0036s | **6.5x** |
| cut | -d, -f1 10MB CSV | 0.0174s | 0.0054s | **3.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0227s | 0.0071s | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0250s | 0.0073s | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0318s | 0.0077s | **4.1x** |
| cut | -d, -f1 100KB text | 0.0010s | 0.0011s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0026s | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0036s | **0.6x** |
| sha256sum | single 10MB text | 0.0090s | 0.0099s | **0.9x** |
| sha256sum | single 10MB binary | 0.0095s | 0.0104s | **0.9x** |
| sha256sum | single 100MB text | 0.0763s | 0.0766s | **1.0x** |
| sha256sum | 10 files | 0.0018s | 0.0026s | **0.7x** |
| sha256sum | 100 files | 0.0026s | 0.0037s | **0.7x** |
| md5sum | single 100KB text | 0.0021s | 0.0026s | **0.8x** |
| md5sum | single 1MB text | 0.0031s | 0.0042s | **0.7x** |
| md5sum | single 10MB text | 0.0181s | 0.0187s | **1.0x** |
| md5sum | single 10MB binary | 0.0189s | 0.0186s | **1.0x** |
| md5sum | single 100MB text | 0.1624s | 0.1540s | **1.1x** |
| md5sum | 10 files | 0.0017s | 0.0029s | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0037s | **0.7x** |
| b2sum | single 100KB text | 0.0012s | 0.0015s | **0.8x** |
| b2sum | single 1MB text | 0.0028s | 0.0024s | **1.2x** |
| b2sum | single 10MB text | 0.0155s | 0.0125s | **1.2x** |
| b2sum | single 10MB binary | 0.0163s | 0.0131s | **1.2x** |
| b2sum | single 100MB text | 0.1437s | 0.1122s | **1.3x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0127s | **1.2x** |
| b2sum | -l 128 10MB | 0.0156s | 0.0128s | **1.2x** |
| b2sum | 100 files | 0.0026s | 0.0024s | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0020s | 0.0016s | **1.3x** |
| base64 | encode 10MB text | 0.0128s | 0.0052s | **2.5x** |
| base64 | encode 10MB binary | 0.0139s | 0.0059s | **2.4x** |
| base64 | decode 1MB | 0.0041s | 0.0028s | **1.4x** |
| base64 | decode 10MB | 0.0334s | 0.0116s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0128s | 0.0054s | **2.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0095s | 0.0046s | **2.1x** |
| sort | lexicographic 1MB | 0.0089s | 0.0039s | **2.3x** |
| sort | lexicographic 10MB random | 0.0602s | 0.0090s | **6.7x** |
| sort | already sorted 10MB | 0.0279s | 0.0069s | **4.0x** |
| sort | reverse sorted 10MB | 0.0285s | 0.0074s | **3.9x** |
| sort | -n numeric 10MB | 0.0760s | 0.0313s | **2.4x** |
| sort | -r reverse 10MB | 0.0581s | 0.0109s | **5.3x** |
| sort | -u unique 10MB | 0.0649s | 0.0195s | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0756s | 0.0275s | **2.8x** |
| sort | repetitive 10MB | 0.0586s | 0.0165s | **3.5x** |
| sort | --parallel=4 10MB | 0.0592s | 0.0097s | **6.1x** |
| tr | a-z to A-Z 1MB | 0.0027s | 0.0024s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0129s | 0.0065s | **2.0x** |
| tr | -d digits 10MB | 0.0173s | 0.0117s | **1.5x** |
| tr | -d lowercase 10MB | 0.0292s | 0.0108s | **2.7x** |
| tr | -s spaces 10MB | 0.0260s | 0.0134s | **1.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0142s | 0.0074s | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0172s | 0.0132s | **1.3x** |
| tr | translate binary 10MB | 0.0124s | 0.0129s | **1.0x** |
| uniq | default 10MB many duplicates | 0.0122s | 0.0050s | **2.4x** |
| uniq | default 10MB sorted (low dup) | 0.0143s | 0.0040s | **3.6x** |
| uniq | -c count 10MB many dups | 0.0126s | 0.0048s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0088s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0048s | **2.5x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0049s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0054s | **2.6x** |
| uniq | repetitive 10MB | 0.0425s | 0.0060s | **7.1x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | **0.8x** |
| tac | reverse 1MB text | 0.0021s | 0.0018s | **1.2x** |
| tac | reverse 10MB text | 0.0112s | 0.0058s | **1.9x** |
| tac | reverse 100MB text | 0.1051s | 0.0415s | **2.5x** |
| tac | reverse CSV 10MB | 0.0097s | 0.0051s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0238s | 0.0103s | **2.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0043s | **1.4x** |
