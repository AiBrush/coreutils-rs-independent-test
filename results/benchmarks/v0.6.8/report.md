# fcoreutils v0.6.8 — Detailed Results

Generated: 2026-02-17 03:18:07 UTC

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
| wc | default 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0333s | 0.0061s | 0.0248s | **5.4x** | **4.1x** |
| wc | default 100MB text | 0.2965s | 0.0438s | 0.2250s | **6.8x** | **5.1x** |
| wc | -l 10MB text | 0.0037s | 0.0019s | 0.0021s | **1.9x** | **1.1x** |
| wc | -w 10MB text | 0.0334s | 0.0061s | 0.0221s | **5.5x** | **3.6x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| wc | -m 10MB text | 0.0332s | 0.0021s | 0.0019s | **16.2x** | **0.9x** |
| wc | -L 10MB text | 0.0334s | 0.0058s | 0.0168s | **5.7x** | **2.9x** |
| wc | default 10MB binary | 0.2340s | 0.0170s | 0.1171s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0513s | 0.0082s | 0.0358s | **6.3x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0178s | 0.0028s | 0.0055s | **6.3x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0179s | 0.0028s | 0.0059s | **6.5x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0179s | 0.0043s | 0.0065s | **4.1x** | **1.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0207s | 0.0051s | 0.0156s | **4.0x** | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0223s | 0.0041s | 0.0120s | **5.4x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0258s | 0.0047s | 0.0153s | **5.5x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0011s | 0.0009s | **0.7x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | 0.0016s | **1.3x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | 0.0009s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0011s | 0.0023s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0015s | 0.0027s | 0.0036s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0068s | 0.0079s | 0.0263s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0072s | 0.0081s | 0.0279s | **0.9x** | **3.5x** |
| sha256sum | single 100MB text | 0.0652s | 0.0645s | 0.2605s | **1.0x** | **4.0x** |
| sha256sum | 10 files | 0.0011s | 0.0016s | 0.0010s | **0.7x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0020s | 0.0016s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0033s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0200s | 0.0165s | 0.0166s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0212s | 0.0173s | 0.0175s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1982s | 0.1417s | 0.1629s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0023s | 0.0016s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0022s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0131s | 0.0129s | 0.0129s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0139s | 0.0135s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1320s | 0.1142s | 0.1254s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0133s | 0.0132s | 0.0128s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0132s | 0.0129s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0017s | 0.0015s | **0.9x** | **0.9x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | 0.0009s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0014s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0090s | 0.0034s | 0.0066s | **2.6x** | **1.9x** |
| base64 | encode 10MB binary | 0.0094s | 0.0032s | 0.0069s | **2.9x** | **2.1x** |
| base64 | decode 1MB | 0.0036s | 0.0018s | 0.0034s | **2.0x** | **1.9x** |
| base64 | decode 10MB | 0.0295s | 0.0042s | 0.0257s | **7.1x** | **6.2x** |
| base64 | encode -w 76 10MB | 0.0088s | 0.0032s | 0.0065s | **2.7x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0069s | 0.0031s | 0.0066s | **2.2x** | **2.1x** |
| sort | lexicographic 1MB | 0.0073s | 0.0030s | 0.0040s | **2.4x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0514s | 0.0084s | 0.0278s | **6.1x** | **3.3x** |
| sort | already sorted 10MB | 0.0245s | 0.0040s | 0.0125s | **6.2x** | **3.2x** |
| sort | reverse sorted 10MB | 0.0237s | 0.0046s | 0.0132s | **5.2x** | **2.9x** |
| sort | -n numeric 10MB | 0.0690s | 0.0036s | 0.0596s | **19.1x** | **16.5x** |
| sort | -r reverse 10MB | 0.0519s | 0.0087s | 0.0282s | **6.0x** | **3.2x** |
| sort | -u unique 10MB | 0.0542s | 0.0092s | 0.0338s | **5.9x** | **3.7x** |
| sort | -t, -k2 CSV 10MB | 0.0701s | 0.0140s | 0.0644s | **5.0x** | **4.6x** |
| sort | repetitive 10MB | 0.0444s | 0.0101s | 0.0353s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0505s | 0.0084s | 0.0279s | **6.0x** | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0017s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0038s | 0.0068s | **2.3x** | **1.8x** |
| tr | -d digits 10MB | 0.0111s | 0.0051s | 0.0101s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0067s | 0.0170s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0169s | 0.0037s | 0.0116s | **4.6x** | **3.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0035s | 0.0069s | **2.5x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0051s | 0.0102s | **2.2x** | **2.0x** |
| tr | translate binary 10MB | 0.0094s | 0.0038s | 0.0077s | **2.4x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0016s | 0.0086s | **5.7x** | **5.5x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0026s | 0.0098s | **6.2x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0016s | 0.0084s | **5.7x** | **5.3x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0067s | 0.0112s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0089s | 0.0016s | 0.0084s | **5.6x** | **5.3x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0016s | 0.0085s | **5.6x** | **5.3x** |
| uniq | -i case insensitive 10MB | 0.0160s | 0.0038s | 0.0092s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0470s | 0.0029s | 0.0136s | **16.5x** | **4.8x** |
| tac | reverse 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0079s | 0.0041s | 0.0047s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0807s | 0.0212s | 0.0419s | **3.8x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0074s | 0.0040s | 0.0043s | **1.9x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0088s | 0.0085s | **1.9x** | **1.0x** |
| tac | custom separator 1MB | 0.0042s | 0.0033s | 0.0036s | **1.3x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0039s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0541s | 0.0031s | 0.0307s | **17.7x** | **10.0x** |
| wc | default 100MB text | 0.4834s | 0.0139s | 0.2643s | **34.9x** | **19.1x** |
| wc | -l 10MB text | 0.0019s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0106s | 0.0254s | **5.1x** | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0540s | 0.0030s | 0.0019s | **18.3x** | **0.7x** |
| wc | -L 10MB text | 0.0541s | 0.0100s | 0.0163s | **5.4x** | **1.6x** |
| wc | default 10MB binary | 0.3167s | 0.0272s | 0.1568s | **11.7x** | **5.8x** |
| wc | default 10MB repetitive | 0.0730s | 0.0045s | 0.0418s | **16.2x** | **9.3x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0023s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0035s | 0.0073s | **6.4x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0035s | 0.0072s | **6.4x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0051s | 0.0085s | **3.2x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0245s | 0.0073s | 0.0183s | **3.3x** | **2.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0254s | 0.0051s | 0.0135s | **5.0x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0053s | 0.0162s | **5.9x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0026s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0033s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0083s | 0.0099s | 0.0083s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0099s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0754s | 0.0746s | 0.0748s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.7x** | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0172s | 0.0176s | 0.0216s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0185s | 0.0224s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1616s | 0.1538s | 0.2035s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0147s | 0.0122s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0128s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1426s | 0.1124s | 0.1126s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0122s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0124s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0018s | 0.0018s | **1.2x** | **1.0x** |
| base64 | encode 10MB text | 0.0122s | 0.0043s | 0.0080s | **2.9x** | **1.9x** |
| base64 | encode 10MB binary | 0.0131s | 0.0043s | 0.0083s | **3.0x** | **1.9x** |
| base64 | decode 1MB | 0.0042s | 0.0022s | 0.0044s | **1.9x** | **2.0x** |
| base64 | decode 10MB | 0.0323s | 0.0047s | 0.0332s | **6.8x** | **7.0x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0045s | 0.0080s | **2.7x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0043s | 0.0072s | **2.0x** | **1.7x** |
| sort | lexicographic 1MB | 0.0085s | 0.0035s | 0.0055s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0540s | 0.0087s | 0.0358s | **6.2x** | **4.1x** |
| sort | already sorted 10MB | 0.0263s | 0.0049s | 0.0178s | **5.3x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0275s | 0.0065s | 0.0184s | **4.2x** | **2.8x** |
| sort | -n numeric 10MB | 0.0735s | 0.0054s | 0.0755s | **13.7x** | **14.0x** |
| sort | -r reverse 10MB | 0.0563s | 0.0089s | 0.0358s | **6.3x** | **4.0x** |
| sort | -u unique 10MB | 0.0578s | 0.0091s | 0.0397s | **6.3x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0664s | 0.0199s | 0.0827s | **3.3x** | **4.2x** |
| sort | repetitive 10MB | 0.0556s | 0.0129s | 0.0375s | **4.3x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0549s | 0.0096s | 0.0367s | **5.7x** | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0038s | 0.0079s | **3.4x** | **2.1x** |
| tr | -d digits 10MB | 0.0168s | 0.0044s | 0.0137s | **3.8x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0326s | 0.0048s | 0.0212s | **6.7x** | **4.4x** |
| tr | -s spaces 10MB | 0.0266s | 0.0038s | 0.0276s | **6.9x** | **7.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0037s | 0.0074s | **3.4x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0042s | 0.0137s | **3.8x** | **3.3x** |
| tr | translate binary 10MB | 0.0114s | 0.0040s | 0.0080s | **2.9x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0123s | 0.0019s | 0.0123s | **6.6x** | **6.6x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0030s | 0.0133s | **4.6x** | **4.4x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | 0.0121s | **6.5x** | **6.5x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0077s | 0.0155s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0019s | 0.0121s | **6.4x** | **6.4x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0019s | 0.0121s | **6.3x** | **6.4x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0045s | 0.0131s | **3.1x** | **2.9x** |
| uniq | repetitive 10MB | 0.0421s | 0.0036s | 0.0182s | **11.5x** | **5.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0105s | 0.0046s | 0.0058s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1040s | 0.0271s | 0.0516s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0048s | 0.0056s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0100s | 0.0109s | **2.3x** | **1.1x** |
| tac | custom separator 1MB | 0.0060s | 0.0042s | 0.0053s | **1.4x** | **1.2x** |
