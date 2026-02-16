# fcoreutils v0.2.6 — Detailed Results

Generated: 2026-02-16 22:08:23 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0338s | 0.0062s | 0.0251s | **5.5x** | **4.1x** |
| wc | default 100MB text | 0.2983s | 0.0450s | 0.2258s | **6.6x** | **5.0x** |
| wc | -l 10MB text | 0.0037s | 0.0021s | 0.0024s | **1.8x** | **1.2x** |
| wc | -w 10MB text | 0.0337s | 0.0064s | 0.0228s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0340s | 0.0022s | 0.0022s | **15.2x** | **1.0x** |
| wc | -L 10MB text | 0.0336s | 0.0063s | 0.0173s | **5.3x** | **2.7x** |
| wc | default 10MB binary | 0.2353s | 0.0170s | 0.1181s | **13.9x** | **7.0x** |
| wc | default 10MB repetitive | 0.0523s | 0.0078s | 0.0363s | **6.7x** | **4.7x** |
| wc | 10 files | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0038s | 0.0060s | **4.9x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0038s | 0.0060s | **4.8x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0183s | 0.0040s | 0.0069s | **4.5x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0209s | 0.0052s | 0.0158s | **4.0x** | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0231s | 0.0035s | 0.0124s | **6.7x** | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0261s | 0.0031s | 0.0158s | **8.3x** | **5.0x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0021s | 0.0018s | **1.6x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0009s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0025s | 0.0037s | **0.6x** | **1.5x** |
| sha256sum | single 10MB text | 0.0068s | 0.0072s | 0.0264s | **0.9x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0074s | 0.0075s | 0.0283s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0678s | 0.0555s | 0.2619s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0020s | 0.0017s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0206s | 0.0162s | 0.0173s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0220s | 0.0167s | 0.0183s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2003s | 0.1435s | 0.1649s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0011s | 0.0018s | 0.0011s | **0.7x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0019s | 0.0017s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0134s | 0.0123s | 0.0132s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0142s | 0.0130s | 0.0140s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1342s | 0.1158s | 0.1283s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0137s | 0.0123s | 0.0131s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0134s | 0.0123s | 0.0131s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0009s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0093s | 0.0032s | 0.0068s | **2.9x** | **2.1x** |
| base64 | encode 10MB binary | 0.0102s | 0.0033s | 0.0077s | **3.1x** | **2.3x** |
| base64 | decode 1MB | 0.0037s | 0.0017s | 0.0036s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0304s | 0.0055s | 0.0269s | **5.5x** | **4.9x** |
| base64 | encode -w 76 10MB | 0.0094s | 0.0034s | 0.0068s | **2.8x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0071s | 0.0027s | 0.0070s | **2.6x** | **2.6x** |
| sort | lexicographic 1MB | 0.0075s | 0.0027s | 0.0042s | **2.8x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0518s | 0.0065s | 0.0288s | **8.0x** | **4.5x** |
| sort | already sorted 10MB | 0.0252s | 0.0033s | 0.0137s | **7.5x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0247s | 0.0046s | 0.0143s | **5.4x** | **3.1x** |
| sort | -n numeric 10MB | 0.0693s | 0.0038s | 0.0594s | **18.1x** | **15.5x** |
| sort | -r reverse 10MB | 0.0518s | 0.0062s | 0.0291s | **8.3x** | **4.7x** |
| sort | -u unique 10MB | 0.0546s | 0.0078s | 0.0347s | **7.0x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0704s | 0.0146s | 0.0682s | **4.8x** | **4.7x** |
| sort | repetitive 10MB | 0.0451s | 0.0100s | 0.0357s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0507s | 0.0063s | 0.0294s | **8.0x** | **4.7x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | 0.0017s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0040s | 0.0070s | **2.2x** | **1.7x** |
| tr | -d digits 10MB | 0.0113s | 0.0053s | 0.0102s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0194s | 0.0068s | 0.0173s | **2.9x** | **2.5x** |
| tr | -s spaces 10MB | 0.0168s | 0.0039s | 0.0116s | **4.3x** | **3.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0040s | 0.0071s | **2.2x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0052s | 0.0103s | **2.2x** | **2.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0043s | 0.0077s | **2.1x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0027s | 0.0087s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0030s | 0.0098s | **5.4x** | **3.3x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0029s | 0.0086s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0069s | 0.0117s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0027s | 0.0087s | **3.3x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0039s | 0.0098s | **4.2x** | **2.5x** |
| uniq | repetitive 10MB | 0.0481s | 0.0042s | 0.0146s | **11.5x** | **3.5x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0083s | 0.0037s | 0.0049s | **2.2x** | **1.3x** |
| tac | reverse 100MB text | 0.0842s | 0.0226s | 0.0428s | **3.7x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0034s | 0.0045s | **2.4x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0182s | 0.0057s | 0.0088s | **3.2x** | **1.5x** |
| tac | custom separator 1MB | 0.0044s | 0.0035s | 0.0038s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0534s | 0.0031s | 0.0295s | **17.2x** | **9.5x** |
| wc | default 100MB text | 0.4737s | 0.0139s | 0.2533s | **34.2x** | **18.3x** |
| wc | -l 10MB text | 0.0019s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0538s | 0.0102s | 0.0254s | **5.3x** | **2.5x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0540s | 0.0029s | 0.0019s | **18.6x** | **0.6x** |
| wc | -L 10MB text | 0.0543s | 0.0099s | 0.0193s | **5.5x** | **1.9x** |
| wc | default 10MB binary | 0.3126s | 0.0275s | 0.1516s | **11.4x** | **5.5x** |
| wc | default 10MB repetitive | 0.0713s | 0.0042s | 0.0400s | **17.1x** | **9.6x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0223s | 0.0040s | 0.0072s | **5.6x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0220s | 0.0038s | 0.0071s | **5.8x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0162s | 0.0049s | 0.0085s | **3.3x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0059s | 0.0171s | **3.6x** | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0237s | 0.0048s | 0.0126s | **4.9x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0302s | 0.0043s | 0.0162s | **7.0x** | **3.7x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0024s | 0.0020s | **1.4x** | **0.9x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0031s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0083s | 0.0094s | 0.0083s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0084s | 0.0095s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0742s | 0.0744s | 0.0741s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0023s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0169s | 0.0171s | 0.0211s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0177s | 0.0178s | 0.0221s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1565s | 0.1570s | 0.2008s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0022s | 0.0023s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0146s | 0.0120s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0124s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1376s | 0.1085s | 0.1115s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0142s | 0.0120s | 0.0120s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0113s | 0.0115s | **1.3x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0022s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0020s | 0.0014s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0118s | 0.0047s | 0.0080s | **2.5x** | **1.7x** |
| base64 | encode 10MB binary | 0.0120s | 0.0045s | 0.0081s | **2.6x** | **1.8x** |
| base64 | decode 1MB | 0.0037s | 0.0019s | 0.0042s | **2.0x** | **2.2x** |
| base64 | decode 10MB | 0.0324s | 0.0053s | 0.0336s | **6.1x** | **6.3x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0046s | 0.0081s | **2.6x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0037s | 0.0071s | **2.3x** | **1.9x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0532s | 0.0093s | 0.0337s | **5.7x** | **3.6x** |
| sort | already sorted 10MB | 0.0254s | 0.0041s | 0.0172s | **6.2x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0261s | 0.0065s | 0.0178s | **4.0x** | **2.7x** |
| sort | -n numeric 10MB | 0.0726s | 0.0056s | 0.0732s | **13.0x** | **13.1x** |
| sort | -r reverse 10MB | 0.0532s | 0.0092s | 0.0342s | **5.8x** | **3.7x** |
| sort | -u unique 10MB | 0.0544s | 0.0090s | 0.0392s | **6.0x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0658s | 0.0183s | 0.0788s | **3.6x** | **4.3x** |
| sort | repetitive 10MB | 0.0542s | 0.0113s | 0.0359s | **4.8x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0525s | 0.0095s | 0.0351s | **5.5x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0019s | **1.5x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0123s | 0.0037s | 0.0073s | **3.3x** | **2.0x** |
| tr | -d digits 10MB | 0.0181s | 0.0042s | 0.0142s | **4.3x** | **3.4x** |
| tr | -d lowercase 10MB | 0.0333s | 0.0048s | 0.0217s | **6.9x** | **4.5x** |
| tr | -s spaces 10MB | 0.0263s | 0.0035s | 0.0265s | **7.5x** | **7.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0037s | 0.0073s | **3.6x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0157s | 0.0040s | 0.0139s | **3.9x** | **3.4x** |
| tr | translate binary 10MB | 0.0122s | 0.0039s | 0.0082s | **3.1x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0035s | 0.0111s | **3.4x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0137s | 0.0035s | 0.0132s | **3.9x** | **3.8x** |
| uniq | -c count 10MB many dups | 0.0118s | 0.0033s | 0.0109s | **3.6x** | **3.3x** |
| uniq | -c count 10MB sorted | 0.0285s | 0.0083s | 0.0148s | **3.4x** | **1.8x** |
| uniq | -d duplicates only 10MB | 0.0116s | 0.0034s | 0.0107s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0115s | 0.0034s | 0.0105s | **3.4x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0135s | 0.0042s | 0.0133s | **3.2x** | **3.2x** |
| uniq | repetitive 10MB | 0.0407s | 0.0040s | 0.0159s | **10.0x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0019s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0102s | 0.0049s | 0.0058s | **2.1x** | **1.2x** |
| tac | reverse 100MB text | 0.1021s | 0.0314s | 0.0501s | **3.3x** | **1.6x** |
| tac | reverse CSV 10MB | 0.0090s | 0.0040s | 0.0053s | **2.3x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0220s | 0.0077s | 0.0108s | **2.9x** | **1.4x** |
| tac | custom separator 1MB | 0.0059s | 0.0037s | 0.0051s | **1.6x** | **1.4x** |
