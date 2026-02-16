# fcoreutils v0.4.2 — Detailed Results

Generated: 2026-02-16 21:45:21 UTC

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
| wc | default 100KB text | 0.0009s | 0.0009s | 0.0011s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0341s | 0.0059s | 0.0252s | **5.8x** | **4.3x** |
| wc | default 100MB text | 0.2990s | 0.0420s | 0.2270s | **7.1x** | **5.4x** |
| wc | -l 10MB text | 0.0038s | 0.0020s | 0.0025s | **1.9x** | **1.2x** |
| wc | -w 10MB text | 0.0341s | 0.0060s | 0.0230s | **5.7x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0342s | 0.0020s | 0.0024s | **16.9x** | **1.2x** |
| wc | -L 10MB text | 0.0340s | 0.0064s | 0.0176s | **5.3x** | **2.8x** |
| wc | default 10MB binary | 0.2347s | 0.0169s | 0.1179s | **13.9x** | **7.0x** |
| wc | default 10MB repetitive | 0.0526s | 0.0077s | 0.0371s | **6.8x** | **4.8x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0036s | 0.0060s | **5.0x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0183s | 0.0037s | 0.0059s | **4.9x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0030s | 0.0070s | **6.2x** | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0047s | 0.0162s | **4.4x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0229s | 0.0036s | 0.0125s | **6.4x** | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0050s | 0.0162s | **5.3x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0015s | 0.0017s | **2.3x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0072s | 0.0083s | 0.0272s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0086s | 0.0288s | **0.9x** | **3.4x** |
| sha256sum | single 100MB text | 0.0680s | 0.0557s | 0.2626s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0013s | 0.0011s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0022s | 0.0017s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0021s | 0.0012s | **0.5x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0208s | 0.0171s | 0.0173s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0182s | 0.0184s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2002s | 0.1440s | 0.1658s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0013s | 0.0011s | **0.8x** | **0.8x** |
| md5sum | 100 files | 0.0016s | 0.0020s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0138s | 0.0135s | 0.0135s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0148s | 0.0142s | 0.0145s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1352s | 0.1165s | 0.1288s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0138s | 0.0135s | 0.0133s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0137s | 0.0134s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0095s | 0.0029s | 0.0070s | **3.2x** | **2.4x** |
| base64 | encode 10MB binary | 0.0100s | 0.0034s | 0.0074s | **2.9x** | **2.2x** |
| base64 | decode 1MB | 0.0038s | 0.0015s | 0.0035s | **2.5x** | **2.4x** |
| base64 | decode 10MB | 0.0307s | 0.0031s | 0.0267s | **9.7x** | **8.5x** |
| base64 | encode -w 76 10MB | 0.0096s | 0.0032s | 0.0071s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0025s | 0.0070s | **2.9x** | **2.8x** |
| sort | lexicographic 1MB | 0.0077s | 0.0025s | 0.0040s | **3.0x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0504s | 0.0062s | 0.0289s | **8.1x** | **4.7x** |
| sort | already sorted 10MB | 0.0250s | 0.0032s | 0.0133s | **7.7x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0045s | 0.0137s | **5.4x** | **3.0x** |
| sort | -n numeric 10MB | 0.0685s | 0.0038s | 0.0601s | **18.1x** | **15.9x** |
| sort | -r reverse 10MB | 0.0512s | 0.0063s | 0.0278s | **8.2x** | **4.5x** |
| sort | -u unique 10MB | 0.0533s | 0.0084s | 0.0354s | **6.4x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0702s | 0.0144s | 0.0683s | **4.9x** | **4.7x** |
| sort | repetitive 10MB | 0.0454s | 0.0101s | 0.0365s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0500s | 0.0062s | 0.0279s | **8.0x** | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | 0.0017s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0040s | 0.0069s | **2.3x** | **1.7x** |
| tr | -d digits 10MB | 0.0110s | 0.0051s | 0.0101s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0066s | 0.0172s | **2.9x** | **2.6x** |
| tr | -s spaces 10MB | 0.0166s | 0.0038s | 0.0115s | **4.3x** | **3.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0037s | 0.0069s | **2.3x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0053s | 0.0103s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0093s | 0.0045s | 0.0077s | **2.1x** | **1.7x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0167s | 0.0030s | 0.0098s | **5.5x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0030s | 0.0087s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0069s | 0.0114s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0027s | 0.0087s | **3.4x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0027s | 0.0089s | **3.4x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0040s | 0.0097s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0488s | 0.0036s | 0.0149s | **13.7x** | **4.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0014s | 0.0015s | **1.2x** | **1.0x** |
| tac | reverse 10MB text | 0.0083s | 0.0031s | 0.0049s | **2.7x** | **1.6x** |
| tac | reverse 100MB text | 0.0854s | 0.0155s | 0.0431s | **5.5x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0079s | 0.0024s | 0.0044s | **3.4x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0190s | 0.0039s | 0.0086s | **4.9x** | **2.2x** |
| tac | custom separator 1MB | 0.0043s | 0.0031s | 0.0038s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0011s | 0.0015s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0054s | 0.0026s | 0.0037s | **2.1x** | **1.4x** |
| wc | default 10MB text | 0.0532s | 0.0026s | 0.0294s | **20.8x** | **11.5x** |
| wc | default 100MB text | 0.4752s | 0.0086s | 0.2500s | **55.1x** | **29.0x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0536s | 0.0082s | 0.0254s | **6.6x** | **3.1x** |
| wc | -c 10MB text | 0.0009s | 0.0009s | 0.0013s | **0.9x** | **1.4x** |
| wc | -m 10MB text | 0.0542s | 0.0028s | 0.0020s | **19.0x** | **0.7x** |
| wc | -L 10MB text | 0.0531s | 0.0103s | 0.0189s | **5.1x** | **1.8x** |
| wc | default 10MB binary | 0.3160s | 0.0263s | 0.1535s | **12.0x** | **5.8x** |
| wc | default 10MB repetitive | 0.0717s | 0.0034s | 0.0388s | **21.3x** | **11.5x** |
| wc | 10 files | 0.0010s | 0.0011s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0221s | 0.0038s | 0.0073s | **5.8x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0038s | 0.0072s | **5.9x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0034s | 0.0084s | **4.8x** | **2.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0063s | 0.0173s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0044s | 0.0132s | **5.4x** | **3.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0052s | 0.0161s | **5.9x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | 0.0010s | **1.0x** | **1.2x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.2x** |
| sha256sum | single 100KB text | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0019s | 0.0028s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0080s | 0.0095s | 0.0080s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0084s | 0.0097s | 0.0082s | **0.9x** | **0.8x** |
| sha256sum | single 100MB text | 0.0724s | 0.0732s | 0.0733s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0024s | 0.0023s | **1.0x** | **1.0x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0026s | 0.0034s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0166s | 0.0173s | 0.0208s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0170s | 0.0179s | 0.0205s | **0.9x** | **1.1x** |
| md5sum | single 100MB text | 0.1574s | 0.1485s | 0.1977s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **0.9x** | **1.0x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0022s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| b2sum | single 1MB text | 0.0021s | 0.0019s | 0.0023s | **1.1x** | **1.2x** |
| b2sum | single 10MB text | 0.0148s | 0.0116s | 0.0117s | **1.3x** | **1.0x** |
| b2sum | single 10MB binary | 0.0145s | 0.0124s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1402s | 0.1102s | 0.1113s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0122s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0118s | 0.0115s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0019s | 0.0024s | **1.1x** | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0013s | 0.0018s | **1.5x** | **1.4x** |
| base64 | encode 10MB text | 0.0121s | 0.0035s | 0.0079s | **3.5x** | **2.3x** |
| base64 | encode 10MB binary | 0.0130s | 0.0036s | 0.0084s | **3.6x** | **2.4x** |
| base64 | decode 1MB | 0.0040s | 0.0013s | 0.0044s | **3.0x** | **3.3x** |
| base64 | decode 10MB | 0.0318s | 0.0038s | 0.0328s | **8.3x** | **8.6x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0036s | 0.0080s | **3.4x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0029s | 0.0071s | **2.9x** | **2.5x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0054s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0526s | 0.0094s | 0.0343s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0257s | 0.0042s | 0.0175s | **6.1x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0064s | 0.0179s | **4.3x** | **2.8x** |
| sort | -n numeric 10MB | 0.0712s | 0.0054s | 0.0715s | **13.2x** | **13.3x** |
| sort | -r reverse 10MB | 0.0529s | 0.0094s | 0.0354s | **5.6x** | **3.8x** |
| sort | -u unique 10MB | 0.0562s | 0.0091s | 0.0390s | **6.2x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0656s | 0.0182s | 0.0800s | **3.6x** | **4.4x** |
| sort | repetitive 10MB | 0.0541s | 0.0111s | 0.0355s | **4.9x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0521s | 0.0093s | 0.0351s | **5.6x** | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0022s | 0.0015s | 0.0020s | **1.4x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0134s | 0.0037s | 0.0077s | **3.6x** | **2.1x** |
| tr | -d digits 10MB | 0.0170s | 0.0042s | 0.0140s | **4.0x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0291s | 0.0049s | 0.0220s | **6.0x** | **4.5x** |
| tr | -s spaces 10MB | 0.0280s | 0.0036s | 0.0256s | **7.7x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0131s | 0.0036s | 0.0076s | **3.7x** | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0167s | 0.0042s | 0.0137s | **4.0x** | **3.3x** |
| tr | translate binary 10MB | 0.0109s | 0.0035s | 0.0078s | **3.1x** | **2.2x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0035s | 0.0113s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0035s | 0.0130s | **3.9x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0107s | **3.4x** | **3.1x** |
| uniq | -c count 10MB sorted | 0.0285s | 0.0090s | 0.0155s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0035s | 0.0108s | **3.4x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0116s | 0.0034s | 0.0107s | **3.4x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0043s | 0.0133s | **3.2x** | **3.1x** |
| uniq | repetitive 10MB | 0.0410s | 0.0040s | 0.0153s | **10.3x** | **3.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0018s | 0.0014s | 0.0016s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0104s | 0.0034s | 0.0056s | **3.1x** | **1.7x** |
| tac | reverse 100MB text | 0.1016s | 0.0182s | 0.0514s | **5.6x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0089s | 0.0030s | 0.0057s | **3.0x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0223s | 0.0048s | 0.0109s | **4.6x** | **2.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0034s | 0.0051s | **1.8x** | **1.5x** |
