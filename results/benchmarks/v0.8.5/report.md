# fcoreutils v0.8.5 — Detailed Results

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0338s | 0.0062s | 0.0245s | **5.4x** | **3.9x** |
| wc | default 100MB text | 0.3000s | 0.0444s | 0.2220s | **6.8x** | **5.0x** |
| wc | -l 10MB text | 0.0040s | 0.0023s | 0.0025s | **1.8x** | **1.1x** |
| wc | -w 10MB text | 0.0341s | 0.0065s | 0.0228s | **5.3x** | **3.5x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.0x** |
| wc | -m 10MB text | 0.0341s | 0.0024s | 0.0025s | **14.1x** | **1.0x** |
| wc | -L 10MB text | 0.0341s | 0.0063s | 0.0176s | **5.5x** | **2.8x** |
| wc | default 10MB binary | 0.2362s | 0.0176s | 0.1141s | **13.4x** | **6.5x** |
| wc | default 10MB repetitive | 0.0522s | 0.0087s | 0.0374s | **6.0x** | **4.3x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0037s | 0.0065s | **5.1x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0188s | 0.0037s | 0.0063s | **5.1x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0097s | 0.0072s | **2.0x** | **0.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0117s | 0.0166s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0097s | 0.0125s | **2.4x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0099s | 0.0162s | **2.7x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | 0.0018s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0011s | 0.0024s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0029s | 0.0037s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0070s | 0.0083s | 0.0268s | **0.8x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0074s | 0.0086s | 0.0285s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0685s | 0.0677s | 0.2639s | **1.0x** | **3.9x** |
| sha256sum | 10 files | 0.0012s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0017s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0209s | 0.0173s | 0.0174s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0183s | 0.0187s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2021s | 0.1448s | 0.1672s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0024s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0137s | 0.0134s | 0.0132s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0148s | 0.0145s | 0.0145s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1365s | 0.1174s | 0.1304s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0141s | 0.0137s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0141s | 0.0137s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0019s | 0.0018s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0016s | 0.0018s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0099s | 0.0053s | 0.0075s | **1.9x** | **1.4x** |
| base64 | encode 10MB binary | 0.0108s | 0.0056s | 0.0084s | **1.9x** | **1.5x** |
| base64 | decode 1MB | 0.0039s | 0.0021s | 0.0037s | **1.8x** | **1.7x** |
| base64 | decode 10MB | 0.0310s | 0.0043s | 0.0267s | **7.2x** | **6.2x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0053s | 0.0074s | **1.9x** | **1.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0048s | 0.0075s | **1.6x** | **1.6x** |
| sort | lexicographic 1MB | 0.0078s | 0.0034s | 0.0046s | **2.3x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0556s | 0.0109s | 0.0348s | **5.1x** | **3.2x** |
| sort | already sorted 10MB | 0.0255s | 0.0035s | 0.0142s | **7.3x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0251s | 0.0047s | 0.0138s | **5.4x** | **3.0x** |
| sort | -n numeric 10MB | 0.0708s | 0.0040s | 0.0641s | **17.6x** | **15.9x** |
| sort | -r reverse 10MB | 0.0538s | 0.0100s | 0.0312s | **5.4x** | **3.1x** |
| sort | -u unique 10MB | 0.0558s | 0.0120s | 0.0386s | **4.7x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0726s | 0.0157s | 0.0718s | **4.6x** | **4.6x** |
| sort | repetitive 10MB | 0.0454s | 0.0103s | 0.0373s | **4.4x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0525s | 0.0100s | 0.0301s | **5.3x** | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0018s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0040s | 0.0070s | **2.3x** | **1.7x** |
| tr | -d digits 10MB | 0.0112s | 0.0052s | 0.0108s | **2.1x** | **2.1x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0068s | 0.0173s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0169s | 0.0039s | 0.0120s | **4.4x** | **3.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0092s | 0.0039s | 0.0070s | **2.3x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0053s | 0.0108s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0049s | 0.0079s | **1.8x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0017s | 0.0088s | **5.3x** | **5.1x** |
| uniq | default 10MB sorted (low dup) | 0.0165s | 0.0028s | 0.0102s | **5.9x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0017s | 0.0091s | **5.5x** | **5.4x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0069s | 0.0119s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0018s | 0.0090s | **5.3x** | **5.1x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0018s | 0.0089s | **5.3x** | **5.1x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0041s | 0.0101s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0481s | 0.0034s | 0.0144s | **14.0x** | **4.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0017s | 0.0015s | **0.9x** | **0.9x** |
| tac | reverse 10MB text | 0.0081s | 0.0050s | 0.0049s | **1.6x** | **1.0x** |
| tac | reverse 100MB text | 0.0851s | 0.0213s | 0.0427s | **4.0x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0048s | 0.0044s | **1.7x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0178s | 0.0094s | 0.0086s | **1.9x** | **0.9x** |
| tac | custom separator 1MB | 0.0043s | 0.0038s | 0.0039s | **1.2x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0012s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0044s | 0.0032s | 0.0042s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0432s | 0.0033s | 0.0377s | **13.3x** | **11.6x** |
| wc | default 100MB text | 0.3789s | 0.0125s | 0.3252s | **30.4x** | **26.1x** |
| wc | -l 10MB text | 0.0015s | 0.0022s | 0.0017s | **0.7x** | **0.8x** |
| wc | -w 10MB text | 0.0438s | 0.0102s | 0.0299s | **4.3x** | **2.9x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0009s | **0.7x** | **1.0x** |
| wc | -m 10MB text | 0.0433s | 0.0027s | 0.0018s | **15.8x** | **0.6x** |
| wc | -L 10MB text | 0.0431s | 0.0105s | 0.0164s | **4.1x** | **1.6x** |
| wc | default 10MB binary | 0.3246s | 0.0316s | 0.1582s | **10.3x** | **5.0x** |
| wc | default 10MB repetitive | 0.0557s | 0.0039s | 0.0505s | **14.4x** | **13.1x** |
| wc | 10 files | 0.0007s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| wc | 100 files | 0.0011s | 0.0015s | 0.0015s | **0.7x** | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0200s | 0.0036s | 0.0056s | **5.6x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0198s | 0.0037s | 0.0061s | **5.4x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0216s | 0.0099s | 0.0076s | **2.2x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0243s | 0.0117s | 0.0162s | **2.1x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0268s | 0.0107s | 0.0131s | **2.5x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0302s | 0.0120s | 0.0157s | **2.5x** | **1.3x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0011s | 0.0008s | **0.6x** | **0.7x** |
| cut | -d, -f1 1MB text | 0.0039s | 0.0029s | 0.0018s | **1.4x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0013s | 0.0009s | **0.5x** | **0.7x** |
| sha256sum | single 100KB text | 0.0011s | 0.0029s | 0.0011s | **0.4x** | **0.4x** |
| sha256sum | single 1MB text | 0.0018s | 0.0037s | 0.0019s | **0.5x** | **0.5x** |
| sha256sum | single 10MB text | 0.0101s | 0.0126s | 0.0102s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0104s | 0.0137s | 0.0109s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0894s | 0.0934s | 0.0892s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0019s | 0.0010s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0015s | 0.0023s | 0.0015s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0011s | 0.0021s | 0.0011s | **0.5x** | **0.5x** |
| md5sum | single 1MB text | 0.0024s | 0.0034s | 0.0029s | **0.7x** | **0.9x** |
| md5sum | single 10MB text | 0.0167s | 0.0181s | 0.0209s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0173s | 0.0186s | 0.0217s | **0.9x** | **1.2x** |
| md5sum | single 100MB text | 0.1513s | 0.1390s | 0.1936s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0010s | 0.0021s | 0.0010s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0015s | 0.0025s | 0.0015s | **0.6x** | **0.6x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0021s | 0.0019s | 0.0020s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0132s | 0.0115s | **1.1x** | **0.9x** |
| b2sum | single 10MB binary | 0.0155s | 0.0135s | 0.0119s | **1.1x** | **0.9x** |
| b2sum | single 100MB text | 0.1366s | 0.0972s | 0.1042s | **1.4x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0146s | 0.0126s | 0.0118s | **1.2x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0129s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0014s | 0.0018s | 0.0015s | **0.8x** | **0.8x** |
| base64 | encode 100KB text | 0.0008s | 0.0012s | 0.0009s | **0.7x** | **0.7x** |
| base64 | encode 1MB text | 0.0017s | 0.0014s | 0.0012s | **1.2x** | **0.9x** |
| base64 | encode 10MB text | 0.0111s | 0.0061s | 0.0048s | **1.8x** | **0.8x** |
| base64 | encode 10MB binary | 0.0115s | 0.0062s | 0.0048s | **1.9x** | **0.8x** |
| base64 | decode 1MB | 0.0036s | 0.0021s | 0.0032s | **1.7x** | **1.5x** |
| base64 | decode 10MB | 0.0305s | 0.0044s | 0.0254s | **6.9x** | **5.7x** |
| base64 | encode -w 76 10MB | 0.0113s | 0.0068s | 0.0057s | **1.7x** | **0.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0046s | 0.0050s | **1.9x** | **1.1x** |
| sort | lexicographic 1MB | 0.0075s | 0.0039s | 0.0046s | **1.9x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0535s | 0.0116s | 0.0318s | **4.6x** | **2.7x** |
| sort | already sorted 10MB | 0.0233s | 0.0051s | 0.0144s | **4.6x** | **2.8x** |
| sort | reverse sorted 10MB | 0.0238s | 0.0067s | 0.0148s | **3.6x** | **2.2x** |
| sort | -n numeric 10MB | 0.0735s | 0.0065s | 0.0699s | **11.3x** | **10.7x** |
| sort | -r reverse 10MB | 0.0537s | 0.0103s | 0.0323s | **5.2x** | **3.1x** |
| sort | -u unique 10MB | 0.0587s | 0.0127s | 0.0387s | **4.6x** | **3.0x** |
| sort | -t, -k2 CSV 10MB | 0.0702s | 0.0221s | 0.0801s | **3.2x** | **3.6x** |
| sort | repetitive 10MB | 0.0503s | 0.0137s | 0.0345s | **3.7x** | **2.5x** |
| sort | --parallel=4 10MB | 0.0523s | 0.0109s | 0.0323s | **4.8x** | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0016s | 0.0014s | 0.0016s | **1.1x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0080s | 0.0039s | 0.0077s | **2.1x** | **2.0x** |
| tr | -d digits 10MB | 0.0158s | 0.0042s | 0.0135s | **3.8x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0278s | 0.0049s | 0.0237s | **5.7x** | **4.9x** |
| tr | -s spaces 10MB | 0.0250s | 0.0041s | 0.0281s | **6.1x** | **6.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0078s | 0.0042s | 0.0063s | **1.9x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0162s | 0.0043s | 0.0137s | **3.8x** | **3.2x** |
| tr | translate binary 10MB | 0.0087s | 0.0039s | 0.0072s | **2.2x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0088s | 0.0015s | 0.0101s | **5.7x** | **6.5x** |
| uniq | default 10MB sorted (low dup) | 0.0189s | 0.0031s | 0.0126s | **6.2x** | **4.1x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0016s | 0.0103s | **6.0x** | **6.5x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0069s | 0.0140s | **4.3x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0101s | 0.0014s | 0.0100s | **7.0x** | **7.0x** |
| uniq | -u unique only 10MB | 0.0098s | 0.0017s | 0.0105s | **5.8x** | **6.2x** |
| uniq | -i case insensitive 10MB | 0.0200s | 0.0050s | 0.0130s | **4.0x** | **2.6x** |
| uniq | repetitive 10MB | 0.0493s | 0.0032s | 0.0153s | **15.6x** | **4.8x** |
| tac | reverse 100KB text | 0.0008s | 0.0013s | 0.0010s | **0.6x** | **0.7x** |
| tac | reverse 1MB text | 0.0015s | 0.0019s | 0.0013s | **0.8x** | **0.7x** |
| tac | reverse 10MB text | 0.0084s | 0.0063s | 0.0046s | **1.3x** | **0.7x** |
| tac | reverse 100MB text | 0.0807s | 0.0269s | 0.0432s | **3.0x** | **1.6x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0064s | 0.0044s | **1.3x** | **0.7x** |
| tac | reverse repetitive 10MB | 0.0154s | 0.0136s | 0.0088s | **1.1x** | **0.7x** |
| tac | custom separator 1MB | 0.0049s | 0.0054s | 0.0041s | **0.9x** | **0.8x** |
