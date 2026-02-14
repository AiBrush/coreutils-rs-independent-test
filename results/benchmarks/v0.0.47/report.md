# fcoreutils v0.0.47 — Detailed Results

Generated: 2026-02-14 05:09:57 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0037s | 0.0025s | **1.5x** |
| wc | default 10MB text | 0.0334s | 0.0058s | **5.8x** |
| wc | default 100MB text | 0.2884s | 0.0404s | **7.1x** |
| wc | -l 10MB text | 0.0036s | 0.0019s | **1.9x** |
| wc | -w 10MB text | 0.0334s | 0.0062s | **5.4x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | **0.8x** |
| wc | -m 10MB text | 0.0334s | 0.0020s | **16.3x** |
| wc | -L 10MB text | 0.0335s | 0.0062s | **5.4x** |
| wc | default 10MB binary | 0.2345s | 0.0173s | **13.5x** |
| wc | default 10MB repetitive | 0.0530s | 0.0071s | **7.5x** |
| wc | 10 files | 0.0008s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0012s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0179s | 0.0027s | **6.7x** |
| cut | -c1-100 10MB CSV | 0.0181s | 0.0026s | **7.1x** |
| cut | -d, -f1 10MB CSV | 0.0181s | 0.0040s | **4.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0044s | **4.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0049s | **4.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0262s | 0.0044s | **6.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | **1.3x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | **0.8x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | single 1MB text | 0.0015s | 0.0024s | **0.6x** |
| sha256sum | single 10MB text | 0.0067s | 0.0071s | **0.9x** |
| sha256sum | single 10MB binary | 0.0067s | 0.0073s | **0.9x** |
| sha256sum | single 100MB text | 0.0575s | 0.0533s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0023s | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0033s | **0.9x** |
| md5sum | single 10MB text | 0.0202s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0207s | 0.0164s | **1.3x** |
| md5sum | single 100MB text | 0.1895s | 0.1407s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0024s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | **0.9x** |
| b2sum | single 10MB text | 0.0132s | 0.0128s | **1.0x** |
| b2sum | single 10MB binary | 0.0135s | 0.0133s | **1.0x** |
| b2sum | single 100MB text | 0.1238s | 0.1183s | **1.0x** |
| b2sum | -l 256 10MB | 0.0135s | 0.0129s | **1.0x** |
| b2sum | -l 128 10MB | 0.0135s | 0.0130s | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0013s | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | **0.8x** |
| base64 | encode 1MB text | 0.0015s | 0.0015s | **1.0x** |
| base64 | encode 10MB text | 0.0088s | 0.0030s | **3.0x** |
| base64 | encode 10MB binary | 0.0093s | 0.0032s | **2.9x** |
| base64 | decode 1MB | 0.0036s | 0.0023s | **1.6x** |
| base64 | decode 10MB | 0.0301s | 0.0136s | **2.2x** |
| base64 | encode -w 76 10MB | 0.0090s | 0.0031s | **2.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0069s | 0.0028s | **2.4x** |
| sort | lexicographic 1MB | 0.0074s | 0.0027s | **2.8x** |
| sort | lexicographic 10MB random | 0.0500s | 0.0053s | **9.4x** |
| sort | already sorted 10MB | 0.0238s | 0.0049s | **4.8x** |
| sort | reverse sorted 10MB | 0.0238s | 0.0049s | **4.9x** |
| sort | -n numeric 10MB | 0.0674s | 0.0207s | **3.2x** |
| sort | -r reverse 10MB | 0.0514s | 0.0060s | **8.6x** |
| sort | -u unique 10MB | 0.0529s | 0.0119s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0690s | 0.0177s | **3.9x** |
| sort | repetitive 10MB | 0.0436s | 0.0119s | **3.7x** |
| sort | --parallel=4 10MB | 0.0494s | 0.0052s | **9.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0019s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0058s | **1.6x** |
| tr | -d digits 10MB | 0.0111s | 0.0119s | **0.9x** |
| tr | -d lowercase 10MB | 0.0197s | 0.0186s | **1.1x** |
| tr | -s spaces 10MB | 0.0168s | 0.0133s | **1.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0085s | 0.0060s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0121s | **0.9x** |
| tr | translate binary 10MB | 0.0089s | 0.0089s | **1.0x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0159s | 0.0030s | **5.4x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0046s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0287s | 0.0066s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0045s | **2.0x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0159s | 0.0043s | **3.7x** |
| uniq | repetitive 10MB | 0.0478s | 0.0039s | **12.4x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0015s | **1.0x** |
| tac | reverse 10MB text | 0.0079s | 0.0046s | **1.7x** |
| tac | reverse 100MB text | 0.0763s | 0.0377s | **2.0x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0046s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0096s | **1.8x** |
| tac | custom separator 1MB | 0.0041s | 0.0038s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0015s | 0.0013s | **1.2x** |
| wc | default 1MB text | 0.0061s | 0.0032s | **1.9x** |
| wc | default 10MB text | 0.0552s | 0.0036s | **15.1x** |
| wc | default 100MB text | 0.4839s | 0.0155s | **31.2x** |
| wc | -l 10MB text | 0.0023s | 0.0029s | **0.8x** |
| wc | -w 10MB text | 0.0549s | 0.0119s | **4.6x** |
| wc | -c 10MB text | 0.0011s | 0.0014s | **0.7x** |
| wc | -m 10MB text | 0.0551s | 0.0032s | **17.5x** |
| wc | -L 10MB text | 0.0548s | 0.0100s | **5.5x** |
| wc | default 10MB binary | 0.3165s | 0.0278s | **11.4x** |
| wc | default 10MB repetitive | 0.0735s | 0.0051s | **14.4x** |
| wc | 10 files | 0.0010s | 0.0013s | **0.8x** |
| wc | 100 files | 0.0027s | 0.0021s | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0232s | 0.0037s | **6.2x** |
| cut | -c1-100 10MB CSV | 0.0233s | 0.0041s | **5.7x** |
| cut | -d, -f1 10MB CSV | 0.0172s | 0.0055s | **3.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0229s | 0.0072s | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0250s | 0.0067s | **3.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0316s | 0.0080s | **4.0x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0015s | **0.5x** |
| cut | -d, -f1 1MB text | 0.0037s | 0.0032s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0013s | **0.7x** |
| sha256sum | single 100KB text | 0.0015s | 0.0026s | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0035s | **0.6x** |
| sha256sum | single 10MB text | 0.0091s | 0.0102s | **0.9x** |
| sha256sum | single 10MB binary | 0.0094s | 0.0103s | **0.9x** |
| sha256sum | single 100MB text | 0.0764s | 0.0765s | **1.0x** |
| sha256sum | 10 files | 0.0021s | 0.0028s | **0.8x** |
| sha256sum | 100 files | 0.0027s | 0.0040s | **0.7x** |
| md5sum | single 100KB text | 0.0016s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0043s | **0.7x** |
| md5sum | single 10MB text | 0.0178s | 0.0185s | **1.0x** |
| md5sum | single 10MB binary | 0.0187s | 0.0190s | **1.0x** |
| md5sum | single 100MB text | 0.1620s | 0.1545s | **1.0x** |
| md5sum | 10 files | 0.0019s | 0.0025s | **0.8x** |
| md5sum | 100 files | 0.0029s | 0.0034s | **0.8x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | **0.8x** |
| b2sum | single 1MB text | 0.0027s | 0.0023s | **1.2x** |
| b2sum | single 10MB text | 0.0153s | 0.0125s | **1.2x** |
| b2sum | single 10MB binary | 0.0166s | 0.0139s | **1.2x** |
| b2sum | single 100MB text | 0.1442s | 0.1119s | **1.3x** |
| b2sum | -l 256 10MB | 0.0154s | 0.0126s | **1.2x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0125s | **1.2x** |
| b2sum | 100 files | 0.0028s | 0.0022s | **1.3x** |
| base64 | encode 100KB text | 0.0012s | 0.0013s | **0.9x** |
| base64 | encode 1MB text | 0.0024s | 0.0017s | **1.4x** |
| base64 | encode 10MB text | 0.0128s | 0.0058s | **2.2x** |
| base64 | encode 10MB binary | 0.0140s | 0.0073s | **1.9x** |
| base64 | decode 1MB | 0.0045s | 0.0024s | **1.8x** |
| base64 | decode 10MB | 0.0331s | 0.0114s | **2.9x** |
| base64 | encode -w 76 10MB | 0.0136s | 0.0065s | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0094s | 0.0051s | **1.9x** |
| sort | lexicographic 1MB | 0.0091s | 0.0040s | **2.3x** |
| sort | lexicographic 10MB random | 0.0578s | 0.0094s | **6.2x** |
| sort | already sorted 10MB | 0.0294s | 0.0078s | **3.8x** |
| sort | reverse sorted 10MB | 0.0300s | 0.0072s | **4.2x** |
| sort | -n numeric 10MB | 0.0848s | 0.0349s | **2.4x** |
| sort | -r reverse 10MB | 0.0678s | 0.0107s | **6.3x** |
| sort | -u unique 10MB | 0.0646s | 0.0171s | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0712s | 0.0281s | **2.5x** |
| sort | repetitive 10MB | 0.0574s | 0.0164s | **3.5x** |
| sort | --parallel=4 10MB | 0.0570s | 0.0096s | **6.0x** |
| tr | a-z to A-Z 1MB | 0.0025s | 0.0022s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0077s | **1.7x** |
| tr | -d digits 10MB | 0.0173s | 0.0113s | **1.5x** |
| tr | -d lowercase 10MB | 0.0291s | 0.0106s | **2.7x** |
| tr | -s spaces 10MB | 0.0296s | 0.0146s | **2.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0159s | 0.0087s | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0168s | 0.0133s | **1.3x** |
| tr | translate binary 10MB | 0.0124s | 0.0131s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0122s | 0.0060s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0151s | 0.0049s | **3.1x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0053s | **2.3x** |
| uniq | -c count 10MB sorted | 0.0300s | 0.0091s | **3.3x** |
| uniq | -d duplicates only 10MB | 0.0124s | 0.0048s | **2.6x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0053s | **2.3x** |
| uniq | -i case insensitive 10MB | 0.0145s | 0.0056s | **2.6x** |
| uniq | repetitive 10MB | 0.0425s | 0.0058s | **7.3x** |
| tac | reverse 100KB text | 0.0012s | 0.0015s | **0.8x** |
| tac | reverse 1MB text | 0.0022s | 0.0021s | **1.0x** |
| tac | reverse 10MB text | 0.0113s | 0.0056s | **2.0x** |
| tac | reverse 100MB text | 0.1055s | 0.0416s | **2.5x** |
| tac | reverse CSV 10MB | 0.0101s | 0.0061s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0240s | 0.0105s | **2.3x** |
| tac | custom separator 1MB | 0.0061s | 0.0047s | **1.3x** |
