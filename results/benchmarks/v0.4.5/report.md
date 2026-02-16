# fcoreutils v0.4.5 — Detailed Results

Generated: 2026-02-16 22:08:23 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0338s | 0.0063s | 0.0251s | **5.3x** | **4.0x** |
| wc | default 100MB text | 0.2986s | 0.0410s | 0.2263s | **7.3x** | **5.5x** |
| wc | -l 10MB text | 0.0037s | 0.0019s | 0.0021s | **1.9x** | **1.1x** |
| wc | -w 10MB text | 0.0336s | 0.0063s | 0.0225s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | 0.0009s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0337s | 0.0020s | 0.0021s | **17.3x** | **1.1x** |
| wc | -L 10MB text | 0.0335s | 0.0057s | 0.0170s | **5.9x** | **3.0x** |
| wc | default 10MB binary | 0.2351s | 0.0171s | 0.1179s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0526s | 0.0078s | 0.0370s | **6.7x** | **4.7x** |
| wc | 10 files | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0037s | 0.0060s | **5.0x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0036s | 0.0061s | **5.1x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0029s | 0.0069s | **6.3x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0048s | 0.0162s | **4.4x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0034s | 0.0123s | **6.9x** | **3.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0261s | 0.0046s | 0.0160s | **5.6x** | **3.4x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0015s | 0.0016s | **2.3x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | 0.0012s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0026s | 0.0036s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0067s | 0.0079s | 0.0265s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0085s | 0.0280s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0677s | 0.0549s | 0.2623s | **1.2x** | **4.8x** |
| sha256sum | 10 files | 0.0011s | 0.0012s | 0.0011s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0018s | 0.0016s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0204s | 0.0170s | 0.0168s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0217s | 0.0180s | 0.0179s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2001s | 0.1433s | 0.1656s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0012s | 0.0011s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0016s | 0.0019s | 0.0016s | **0.9x** | **0.8x** |
| b2sum | single 100KB text | 0.0008s | 0.0009s | 0.0011s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0022s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0134s | 0.0131s | 0.0129s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0142s | 0.0141s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1344s | 0.1154s | 0.1282s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0135s | 0.0132s | 0.0131s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0132s | 0.0130s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0010s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0092s | 0.0033s | 0.0067s | **2.8x** | **2.0x** |
| base64 | encode 10MB binary | 0.0098s | 0.0032s | 0.0072s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0037s | 0.0015s | 0.0034s | **2.5x** | **2.3x** |
| base64 | decode 10MB | 0.0299s | 0.0033s | 0.0265s | **9.0x** | **8.0x** |
| base64 | encode -w 76 10MB | 0.0090s | 0.0029s | 0.0067s | **3.1x** | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0025s | 0.0068s | **2.8x** | **2.7x** |
| sort | lexicographic 1MB | 0.0074s | 0.0032s | 0.0039s | **2.3x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0502s | 0.0071s | 0.0275s | **7.0x** | **3.9x** |
| sort | already sorted 10MB | 0.0246s | 0.0032s | 0.0127s | **7.8x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0240s | 0.0043s | 0.0134s | **5.6x** | **3.1x** |
| sort | -n numeric 10MB | 0.0680s | 0.0036s | 0.0584s | **18.9x** | **16.3x** |
| sort | -r reverse 10MB | 0.0509s | 0.0071s | 0.0279s | **7.2x** | **3.9x** |
| sort | -u unique 10MB | 0.0531s | 0.0088s | 0.0333s | **6.0x** | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0688s | 0.0135s | 0.0641s | **5.1x** | **4.7x** |
| sort | repetitive 10MB | 0.0451s | 0.0102s | 0.0352s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0499s | 0.0069s | 0.0273s | **7.3x** | **4.0x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0015s | 0.0018s | **1.2x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0035s | 0.0067s | **2.6x** | **1.9x** |
| tr | -d digits 10MB | 0.0112s | 0.0050s | 0.0100s | **2.3x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0187s | 0.0064s | 0.0167s | **2.9x** | **2.6x** |
| tr | -s spaces 10MB | 0.0165s | 0.0034s | 0.0113s | **4.9x** | **3.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0092s | 0.0034s | 0.0067s | **2.7x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0051s | 0.0101s | **2.2x** | **2.0x** |
| tr | translate binary 10MB | 0.0093s | 0.0038s | 0.0076s | **2.4x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0028s | 0.0095s | **5.8x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0089s | 0.0029s | 0.0087s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0063s | 0.0111s | **4.6x** | **1.8x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0027s | 0.0086s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0027s | 0.0086s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0040s | 0.0095s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0482s | 0.0033s | 0.0141s | **14.8x** | **4.3x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0014s | 0.0014s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0080s | 0.0026s | 0.0049s | **3.1x** | **1.9x** |
| tac | reverse 100MB text | 0.0834s | 0.0148s | 0.0422s | **5.6x** | **2.9x** |
| tac | reverse CSV 10MB | 0.0077s | 0.0023s | 0.0044s | **3.4x** | **2.0x** |
| tac | reverse repetitive 10MB | 0.0179s | 0.0041s | 0.0085s | **4.4x** | **2.1x** |
| tac | custom separator 1MB | 0.0042s | 0.0031s | 0.0037s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0038s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0539s | 0.0025s | 0.0297s | **21.3x** | **11.8x** |
| wc | default 100MB text | 0.4833s | 0.0090s | 0.2527s | **53.7x** | **28.1x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0541s | 0.0087s | 0.0253s | **6.2x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0541s | 0.0023s | 0.0020s | **23.1x** | **0.8x** |
| wc | -L 10MB text | 0.0541s | 0.0094s | 0.0195s | **5.8x** | **2.1x** |
| wc | default 10MB binary | 0.3166s | 0.0270s | 0.1541s | **11.7x** | **5.7x** |
| wc | default 10MB repetitive | 0.0732s | 0.0034s | 0.0393s | **21.6x** | **11.6x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0023s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0224s | 0.0038s | 0.0072s | **6.0x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0223s | 0.0038s | 0.0073s | **5.8x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0032s | 0.0085s | **5.2x** | **2.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0063s | 0.0172s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0237s | 0.0048s | 0.0134s | **5.0x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0052s | 0.0165s | **5.8x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0083s | 0.0097s | 0.0083s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0099s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0741s | 0.0748s | 0.0741s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0023s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0171s | 0.0175s | 0.0212s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0184s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1602s | 0.1526s | 0.2019s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0014s | 0.0014s | **0.9x** | **1.0x** |
| md5sum | 100 files | 0.0023s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0124s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0127s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1417s | 0.1115s | 0.1123s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0013s | 0.0018s | **1.5x** | **1.4x** |
| base64 | encode 10MB text | 0.0121s | 0.0037s | 0.0079s | **3.3x** | **2.2x** |
| base64 | encode 10MB binary | 0.0127s | 0.0038s | 0.0084s | **3.4x** | **2.2x** |
| base64 | decode 1MB | 0.0039s | 0.0013s | 0.0043s | **2.9x** | **3.2x** |
| base64 | decode 10MB | 0.0320s | 0.0040s | 0.0337s | **8.0x** | **8.4x** |
| base64 | encode -w 76 10MB | 0.0121s | 0.0036s | 0.0080s | **3.4x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0031s | 0.0070s | **2.7x** | **2.2x** |
| sort | lexicographic 1MB | 0.0085s | 0.0037s | 0.0054s | **2.3x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0537s | 0.0096s | 0.0349s | **5.6x** | **3.6x** |
| sort | already sorted 10MB | 0.0262s | 0.0042s | 0.0175s | **6.2x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0065s | 0.0175s | **4.2x** | **2.7x** |
| sort | -n numeric 10MB | 0.0728s | 0.0057s | 0.0748s | **12.8x** | **13.1x** |
| sort | -r reverse 10MB | 0.0542s | 0.0094s | 0.0356s | **5.8x** | **3.8x** |
| sort | -u unique 10MB | 0.0572s | 0.0093s | 0.0393s | **6.1x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0659s | 0.0187s | 0.0812s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0571s | 0.0115s | 0.0364s | **5.0x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0535s | 0.0095s | 0.0353s | **5.7x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0038s | 0.0073s | **3.4x** | **1.9x** |
| tr | -d digits 10MB | 0.0168s | 0.0042s | 0.0142s | **4.0x** | **3.4x** |
| tr | -d lowercase 10MB | 0.0289s | 0.0048s | 0.0224s | **6.0x** | **4.7x** |
| tr | -s spaces 10MB | 0.0272s | 0.0037s | 0.0268s | **7.3x** | **7.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0129s | 0.0037s | 0.0073s | **3.5x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0041s | 0.0142s | **3.8x** | **3.4x** |
| tr | translate binary 10MB | 0.0119s | 0.0038s | 0.0086s | **3.1x** | **2.3x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0036s | 0.0112s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0035s | 0.0132s | **4.0x** | **3.8x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0035s | 0.0116s | **3.5x** | **3.3x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0084s | 0.0156s | **3.5x** | **1.9x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0034s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0034s | 0.0112s | **3.5x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0043s | 0.0133s | **3.2x** | **3.1x** |
| uniq | repetitive 10MB | 0.0418s | 0.0041s | 0.0158s | **10.2x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.1x** |
| tac | reverse 10MB text | 0.0104s | 0.0034s | 0.0057s | **3.0x** | **1.7x** |
| tac | reverse 100MB text | 0.1028s | 0.0195s | 0.0514s | **5.3x** | **2.6x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0032s | 0.0056s | **2.9x** | **1.7x** |
| tac | reverse repetitive 10MB | 0.0226s | 0.0053s | 0.0108s | **4.3x** | **2.0x** |
| tac | custom separator 1MB | 0.0059s | 0.0035s | 0.0052s | **1.7x** | **1.5x** |
