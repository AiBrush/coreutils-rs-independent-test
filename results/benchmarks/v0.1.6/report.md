# fcoreutils v0.1.6 — Detailed Results

Generated: 2026-02-16 02:00:04 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0024s | 0.0033s | **1.5x** | **1.4x** |
| wc | default 10MB text | 0.0341s | 0.0062s | 0.0254s | **5.5x** | **4.1x** |
| wc | default 100MB text | 0.2992s | 0.0442s | 0.2271s | **6.8x** | **5.1x** |
| wc | -l 10MB text | 0.0040s | 0.0020s | 0.0025s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0346s | 0.0063s | 0.0235s | **5.5x** | **3.7x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0340s | 0.0022s | 0.0024s | **15.3x** | **1.1x** |
| wc | -L 10MB text | 0.0341s | 0.0062s | 0.0172s | **5.5x** | **2.8x** |
| wc | default 10MB binary | 0.2355s | 0.0166s | 0.1180s | **14.1x** | **7.1x** |
| wc | default 10MB repetitive | 0.0515s | 0.0078s | 0.0374s | **6.6x** | **4.8x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0034s | 0.0061s | **5.3x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0034s | 0.0063s | **5.4x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0044s | 0.0071s | **4.3x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0210s | 0.0050s | 0.0161s | **4.2x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0035s | 0.0128s | **6.7x** | **3.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0032s | 0.0163s | **8.3x** | **5.1x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0023s | 0.0018s | **1.5x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0075s | 0.0074s | 0.0273s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0081s | 0.0077s | 0.0288s | **1.0x** | **3.7x** |
| sha256sum | single 100MB text | 0.0694s | 0.0558s | 0.2633s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0021s | 0.0011s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | 0.0016s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0210s | 0.0163s | 0.0172s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0222s | 0.0170s | 0.0179s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2012s | 0.1446s | 0.1670s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0019s | 0.0011s | **0.6x** | **0.5x** |
| md5sum | 100 files | 0.0016s | 0.0025s | 0.0016s | **0.6x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0142s | 0.0124s | 0.0138s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0152s | 0.0130s | 0.0146s | **1.2x** | **1.1x** |
| b2sum | single 100MB text | 0.1361s | 0.1153s | 0.1291s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0138s | 0.0124s | 0.0136s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0141s | 0.0124s | 0.0138s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0015s | 0.0017s | **1.1x** | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0099s | 0.0051s | 0.0073s | **1.9x** | **1.4x** |
| base64 | encode 10MB binary | 0.0101s | 0.0051s | 0.0074s | **2.0x** | **1.4x** |
| base64 | decode 1MB | 0.0037s | 0.0019s | 0.0035s | **1.9x** | **1.9x** |
| base64 | decode 10MB | 0.0307s | 0.0099s | 0.0267s | **3.1x** | **2.7x** |
| base64 | encode -w 76 10MB | 0.0097s | 0.0050s | 0.0071s | **1.9x** | **1.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0076s | 0.0044s | 0.0071s | **1.7x** | **1.6x** |
| sort | lexicographic 1MB | 0.0075s | 0.0025s | 0.0041s | **3.0x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0516s | 0.0061s | 0.0284s | **8.5x** | **4.7x** |
| sort | already sorted 10MB | 0.0242s | 0.0035s | 0.0135s | **6.9x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0241s | 0.0046s | 0.0135s | **5.3x** | **3.0x** |
| sort | -n numeric 10MB | 0.0697s | 0.0039s | 0.0596s | **18.0x** | **15.4x** |
| sort | -r reverse 10MB | 0.0517s | 0.0062s | 0.0281s | **8.3x** | **4.5x** |
| sort | -u unique 10MB | 0.0547s | 0.0078s | 0.0360s | **7.0x** | **4.6x** |
| sort | -t, -k2 CSV 10MB | 0.0708s | 0.0142s | 0.0650s | **5.0x** | **4.6x** |
| sort | repetitive 10MB | 0.0445s | 0.0097s | 0.0360s | **4.6x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0509s | 0.0062s | 0.0279s | **8.2x** | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0017s | 0.0018s | **1.1x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0067s | 0.0069s | **1.3x** | **1.0x** |
| tr | -d digits 10MB | 0.0112s | 0.0082s | 0.0102s | **1.4x** | **1.2x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0107s | 0.0171s | **1.8x** | **1.6x** |
| tr | -s spaces 10MB | 0.0168s | 0.0068s | 0.0115s | **2.5x** | **1.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0068s | 0.0068s | **1.3x** | **1.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0114s | 0.0079s | 0.0103s | **1.4x** | **1.3x** |
| tr | translate binary 10MB | 0.0093s | 0.0068s | 0.0077s | **1.4x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0026s | 0.0084s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0031s | 0.0095s | **5.2x** | **3.0x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0030s | 0.0086s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0068s | 0.0114s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0026s | 0.0084s | **3.5x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0026s | 0.0085s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0162s | 0.0039s | 0.0095s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0469s | 0.0036s | 0.0134s | **13.1x** | **3.8x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0015s | 0.0014s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0081s | 0.0030s | 0.0050s | **2.7x** | **1.6x** |
| tac | reverse 100MB text | 0.0850s | 0.0199s | 0.0425s | **4.3x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0076s | 0.0029s | 0.0044s | **2.6x** | **1.5x** |
| tac | reverse repetitive 10MB | 0.0178s | 0.0054s | 0.0084s | **3.3x** | **1.6x** |
| tac | custom separator 1MB | 0.0043s | 0.0040s | 0.0037s | **1.1x** | **0.9x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0044s | **2.0x** | **1.6x** |
| wc | default 10MB text | 0.0545s | 0.0031s | 0.0362s | **17.7x** | **11.8x** |
| wc | default 100MB text | 0.4822s | 0.0139s | 0.3152s | **34.8x** | **22.7x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0107s | 0.0268s | **5.1x** | **2.5x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0539s | 0.0029s | 0.0019s | **18.3x** | **0.6x** |
| wc | -L 10MB text | 0.0541s | 0.0100s | 0.0163s | **5.4x** | **1.6x** |
| wc | default 10MB binary | 0.3169s | 0.0274s | 0.1566s | **11.6x** | **5.7x** |
| wc | default 10MB repetitive | 0.0728s | 0.0051s | 0.0522s | **14.2x** | **10.2x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0223s | 0.0051s | 0.0070s | **4.3x** | **1.4x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0052s | 0.0070s | **4.4x** | **1.4x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0051s | 0.0082s | **3.2x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0065s | 0.0178s | **3.4x** | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0056s | 0.0132s | **4.3x** | **2.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0052s | 0.0167s | **6.0x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0094s | 0.0083s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0098s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0746s | 0.0756s | 0.0749s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0030s | 0.0023s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0175s | 0.0175s | 0.0214s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0183s | 0.0184s | 0.0229s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1600s | 0.1525s | 0.2028s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0030s | 0.0024s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0126s | 0.0132s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1458s | 0.1119s | 0.1123s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0019s | 0.0023s | **1.2x** | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | 0.0018s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0121s | 0.0048s | 0.0086s | **2.5x** | **1.8x** |
| base64 | encode 10MB binary | 0.0128s | 0.0049s | 0.0084s | **2.6x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0019s | 0.0043s | **2.1x** | **2.2x** |
| base64 | decode 10MB | 0.0326s | 0.0108s | 0.0338s | **3.0x** | **3.1x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0046s | 0.0081s | **2.7x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0038s | 0.0071s | **2.3x** | **1.9x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0055s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0549s | 0.0096s | 0.0356s | **5.7x** | **3.7x** |
| sort | already sorted 10MB | 0.0259s | 0.0042s | 0.0179s | **6.1x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0066s | 0.0177s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0725s | 0.0055s | 0.0746s | **13.1x** | **13.5x** |
| sort | -r reverse 10MB | 0.0541s | 0.0096s | 0.0355s | **5.6x** | **3.7x** |
| sort | -u unique 10MB | 0.0601s | 0.0105s | 0.0416s | **5.7x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0672s | 0.0202s | 0.0819s | **3.3x** | **4.0x** |
| sort | repetitive 10MB | 0.0568s | 0.0121s | 0.0374s | **4.7x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0542s | 0.0096s | 0.0360s | **5.6x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0018s | 0.0020s | **1.3x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0131s | 0.0072s | 0.0073s | **1.8x** | **1.0x** |
| tr | -d digits 10MB | 0.0171s | 0.0096s | 0.0135s | **1.8x** | **1.4x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0120s | 0.0204s | **2.5x** | **1.7x** |
| tr | -s spaces 10MB | 0.0285s | 0.0068s | 0.0269s | **4.2x** | **3.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0124s | 0.0070s | 0.0074s | **1.8x** | **1.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0186s | 0.0102s | 0.0135s | **1.8x** | **1.3x** |
| tr | translate binary 10MB | 0.0119s | 0.0077s | 0.0082s | **1.6x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0123s | 0.0038s | 0.0117s | **3.2x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0040s | 0.0131s | **3.5x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0122s | 0.0038s | 0.0115s | **3.2x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0094s | 0.0155s | **3.1x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0036s | 0.0111s | **3.4x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0036s | 0.0113s | **3.4x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0047s | 0.0130s | **3.0x** | **2.7x** |
| uniq | repetitive 10MB | 0.0424s | 0.0043s | 0.0167s | **9.8x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0108s | 0.0046s | 0.0059s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1067s | 0.0271s | 0.0537s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0101s | 0.0044s | 0.0060s | **2.3x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0240s | 0.0075s | 0.0116s | **3.2x** | **1.5x** |
| tac | custom separator 1MB | 0.0063s | 0.0052s | 0.0057s | **1.2x** | **1.1x** |
