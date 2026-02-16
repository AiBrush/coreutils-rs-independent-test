# fcoreutils v0.3.7 — Detailed Results

Generated: 2026-02-16 09:50:00 UTC

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
| wc | default 100KB text | 0.0010s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0024s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0339s | 0.0062s | 0.0255s | **5.4x** | **4.1x** |
| wc | default 100MB text | 0.2988s | 0.0433s | 0.2266s | **6.9x** | **5.2x** |
| wc | -l 10MB text | 0.0037s | 0.0020s | 0.0024s | **1.8x** | **1.2x** |
| wc | -w 10MB text | 0.0339s | 0.0065s | 0.0227s | **5.2x** | **3.5x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0339s | 0.0019s | 0.0021s | **17.5x** | **1.1x** |
| wc | -L 10MB text | 0.0339s | 0.0065s | 0.0170s | **5.2x** | **2.6x** |
| wc | default 10MB binary | 0.2348s | 0.0170s | 0.1177s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0532s | 0.0079s | 0.0366s | **6.8x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0182s | 0.0035s | 0.0057s | **5.1x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0036s | 0.0060s | **5.0x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0031s | 0.0068s | **5.9x** | **2.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0208s | 0.0053s | 0.0160s | **3.9x** | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0227s | 0.0030s | 0.0124s | **7.7x** | **4.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0262s | 0.0044s | 0.0157s | **5.9x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0015s | 0.0016s | **2.2x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0009s | 0.0009s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0024s | 0.0036s | **0.7x** | **1.5x** |
| sha256sum | single 10MB text | 0.0070s | 0.0078s | 0.0266s | **0.9x** | **3.4x** |
| sha256sum | single 10MB binary | 0.0071s | 0.0084s | 0.0281s | **0.8x** | **3.3x** |
| sha256sum | single 100MB text | 0.0672s | 0.0548s | 0.2619s | **1.2x** | **4.8x** |
| sha256sum | 10 files | 0.0011s | 0.0012s | 0.0011s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0016s | 0.0018s | 0.0016s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0033s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0204s | 0.0167s | 0.0170s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0214s | 0.0178s | 0.0175s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1997s | 0.1428s | 0.1653s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0012s | 0.0011s | **0.8x** | **0.9x** |
| md5sum | 100 files | 0.0016s | 0.0018s | 0.0016s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0023s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0133s | 0.0130s | 0.0133s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0144s | 0.0140s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1346s | 0.1158s | 0.1285s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0134s | 0.0132s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0133s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0015s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0092s | 0.0030s | 0.0070s | **3.1x** | **2.3x** |
| base64 | encode 10MB binary | 0.0100s | 0.0033s | 0.0071s | **3.1x** | **2.2x** |
| base64 | decode 1MB | 0.0037s | 0.0014s | 0.0034s | **2.6x** | **2.4x** |
| base64 | decode 10MB | 0.0301s | 0.0034s | 0.0263s | **8.9x** | **7.8x** |
| base64 | encode -w 76 10MB | 0.0091s | 0.0034s | 0.0068s | **2.7x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0025s | 0.0071s | **3.0x** | **2.8x** |
| sort | lexicographic 1MB | 0.0074s | 0.0025s | 0.0041s | **3.0x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0500s | 0.0058s | 0.0268s | **8.6x** | **4.6x** |
| sort | already sorted 10MB | 0.0247s | 0.0032s | 0.0130s | **7.7x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0240s | 0.0045s | 0.0134s | **5.3x** | **3.0x** |
| sort | -n numeric 10MB | 0.0677s | 0.0037s | 0.0583s | **18.1x** | **15.6x** |
| sort | -r reverse 10MB | 0.0513s | 0.0060s | 0.0268s | **8.5x** | **4.4x** |
| sort | -u unique 10MB | 0.0526s | 0.0075s | 0.0320s | **7.1x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0688s | 0.0138s | 0.0638s | **5.0x** | **4.6x** |
| sort | repetitive 10MB | 0.0450s | 0.0100s | 0.0359s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0492s | 0.0060s | 0.0268s | **8.2x** | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0017s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0049s | 0.0069s | **1.9x** | **1.4x** |
| tr | -d digits 10MB | 0.0111s | 0.0066s | 0.0102s | **1.7x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0187s | 0.0083s | 0.0170s | **2.2x** | **2.0x** |
| tr | -s spaces 10MB | 0.0164s | 0.0046s | 0.0113s | **3.6x** | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0051s | 0.0067s | **1.8x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0063s | 0.0103s | **1.8x** | **1.6x** |
| tr | translate binary 10MB | 0.0094s | 0.0054s | 0.0076s | **1.8x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0026s | 0.0086s | **3.5x** | **3.3x** |
| uniq | default 10MB sorted (low dup) | 0.0161s | 0.0026s | 0.0096s | **6.1x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0029s | 0.0086s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0068s | 0.0113s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0026s | 0.0085s | **3.5x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0089s | 0.0027s | 0.0086s | **3.3x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0038s | 0.0094s | **4.3x** | **2.5x** |
| uniq | repetitive 10MB | 0.0481s | 0.0035s | 0.0150s | **13.9x** | **4.3x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0013s | 0.0014s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0083s | 0.0028s | 0.0049s | **3.0x** | **1.7x** |
| tac | reverse 100MB text | 0.0848s | 0.0149s | 0.0420s | **5.7x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0079s | 0.0025s | 0.0044s | **3.2x** | **1.8x** |
| tac | reverse repetitive 10MB | 0.0176s | 0.0039s | 0.0086s | **4.5x** | **2.2x** |
| tac | custom separator 1MB | 0.0042s | 0.0031s | 0.0037s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0038s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0573s | 0.0026s | 0.0298s | **22.2x** | **11.5x** |
| wc | default 100MB text | 0.4830s | 0.0092s | 0.2554s | **52.3x** | **27.6x** |
| wc | -l 10MB text | 0.0019s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0540s | 0.0086s | 0.0257s | **6.3x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0542s | 0.0025s | 0.0020s | **21.9x** | **0.8x** |
| wc | -L 10MB text | 0.0543s | 0.0092s | 0.0195s | **5.9x** | **2.1x** |
| wc | default 10MB binary | 0.3175s | 0.0265s | 0.1539s | **12.0x** | **5.8x** |
| wc | default 10MB repetitive | 0.0731s | 0.0034s | 0.0396s | **21.3x** | **11.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0233s | 0.0039s | 0.0073s | **6.0x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0039s | 0.0072s | **5.8x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0034s | 0.0085s | **4.8x** | **2.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0066s | 0.0174s | **3.3x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0047s | 0.0134s | **5.1x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0304s | 0.0052s | 0.0163s | **5.8x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0099s | 0.0084s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0099s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0762s | 0.0753s | 0.0760s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0023s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0178s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0177s | 0.0185s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1620s | 0.1533s | 0.2035s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0123s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0129s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1439s | 0.1126s | 0.1135s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0123s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0122s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0126s | 0.0041s | 0.0082s | **3.1x** | **2.0x** |
| base64 | encode 10MB binary | 0.0128s | 0.0042s | 0.0083s | **3.1x** | **2.0x** |
| base64 | decode 1MB | 0.0040s | 0.0014s | 0.0044s | **3.0x** | **3.2x** |
| base64 | decode 10MB | 0.0332s | 0.0039s | 0.0338s | **8.5x** | **8.7x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0041s | 0.0082s | **3.0x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0031s | 0.0071s | **2.8x** | **2.3x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0097s | 0.0358s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0264s | 0.0043s | 0.0175s | **6.1x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0278s | 0.0066s | 0.0181s | **4.2x** | **2.7x** |
| sort | -n numeric 10MB | 0.0746s | 0.0060s | 0.0764s | **12.3x** | **12.6x** |
| sort | -r reverse 10MB | 0.0552s | 0.0097s | 0.0359s | **5.7x** | **3.7x** |
| sort | -u unique 10MB | 0.0571s | 0.0103s | 0.0402s | **5.5x** | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0663s | 0.0188s | 0.0833s | **3.5x** | **4.4x** |
| sort | repetitive 10MB | 0.0551s | 0.0120s | 0.0372s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0538s | 0.0099s | 0.0358s | **5.4x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0062s | 0.0073s | **2.0x** | **1.2x** |
| tr | -d digits 10MB | 0.0170s | 0.0057s | 0.0145s | **3.0x** | **2.5x** |
| tr | -d lowercase 10MB | 0.0296s | 0.0072s | 0.0226s | **4.1x** | **3.1x** |
| tr | -s spaces 10MB | 0.0281s | 0.0043s | 0.0273s | **6.6x** | **6.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0057s | 0.0073s | **2.2x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0173s | 0.0057s | 0.0140s | **3.0x** | **2.4x** |
| tr | translate binary 10MB | 0.0115s | 0.0057s | 0.0079s | **2.0x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0035s | 0.0112s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0037s | 0.0135s | **3.7x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0090s | 0.0158s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0036s | 0.0112s | **3.4x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0036s | 0.0111s | **3.3x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0043s | 0.0134s | **3.2x** | **3.1x** |
| uniq | repetitive 10MB | 0.0418s | 0.0042s | 0.0159s | **10.0x** | **3.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.1x** |
| tac | reverse 10MB text | 0.0105s | 0.0034s | 0.0058s | **3.1x** | **1.7x** |
| tac | reverse 100MB text | 0.1039s | 0.0201s | 0.0521s | **5.2x** | **2.6x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0030s | 0.0057s | **3.1x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0052s | 0.0112s | **4.4x** | **2.2x** |
| tac | custom separator 1MB | 0.0059s | 0.0035s | 0.0053s | **1.7x** | **1.5x** |
