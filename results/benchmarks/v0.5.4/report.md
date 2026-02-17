# fcoreutils v0.5.4 — Detailed Results

Generated: 2026-02-17 03:06:13 UTC

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
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0342s | 0.0068s | 0.0253s | **5.0x** | **3.7x** |
| wc | default 100MB text | 0.3000s | 0.0465s | 0.2278s | **6.5x** | **4.9x** |
| wc | -l 10MB text | 0.0043s | 0.0021s | 0.0028s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0345s | 0.0061s | 0.0233s | **5.6x** | **3.8x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0343s | 0.0023s | 0.0028s | **15.2x** | **1.2x** |
| wc | -L 10MB text | 0.0343s | 0.0068s | 0.0175s | **5.1x** | **2.6x** |
| wc | default 10MB binary | 0.2352s | 0.0169s | 0.1179s | **13.9x** | **7.0x** |
| wc | default 10MB repetitive | 0.0538s | 0.0083s | 0.0377s | **6.5x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0014s | 0.0018s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0028s | 0.0062s | **6.7x** | **2.2x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0027s | 0.0063s | **6.8x** | **2.3x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0047s | 0.0069s | **4.0x** | **1.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0050s | 0.0164s | **4.2x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0042s | 0.0129s | **5.5x** | **3.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0045s | 0.0163s | **5.9x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | 0.0017s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0009s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0038s | **0.7x** | **1.5x** |
| sha256sum | single 10MB text | 0.0075s | 0.0085s | 0.0274s | **0.9x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0078s | 0.0088s | 0.0287s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0696s | 0.0495s | 0.2635s | **1.4x** | **5.3x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0012s | **0.7x** | **0.7x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0017s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0213s | 0.0177s | 0.0179s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0224s | 0.0184s | 0.0186s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2013s | 0.1367s | 0.1668s | **1.5x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.7x** | **0.7x** |
| md5sum | 100 files | 0.0017s | 0.0021s | 0.0017s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0142s | 0.0138s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0149s | 0.0144s | 0.0146s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1358s | 0.1183s | 0.1291s | **1.1x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0136s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0138s | 0.0135s | 0.0133s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0098s | 0.0037s | 0.0070s | **2.6x** | **1.9x** |
| base64 | encode 10MB binary | 0.0101s | 0.0035s | 0.0074s | **2.8x** | **2.1x** |
| base64 | decode 1MB | 0.0038s | 0.0018s | 0.0036s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0306s | 0.0040s | 0.0269s | **7.6x** | **6.7x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0034s | 0.0070s | **3.0x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0076s | 0.0033s | 0.0073s | **2.3x** | **2.2x** |
| sort | lexicographic 1MB | 0.0075s | 0.0030s | 0.0041s | **2.5x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0510s | 0.0095s | 0.0282s | **5.4x** | **3.0x** |
| sort | already sorted 10MB | 0.0252s | 0.0034s | 0.0138s | **7.3x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0250s | 0.0048s | 0.0142s | **5.3x** | **3.0x** |
| sort | -n numeric 10MB | 0.0686s | 0.0036s | 0.0617s | **18.8x** | **16.9x** |
| sort | -r reverse 10MB | 0.0514s | 0.0088s | 0.0291s | **5.9x** | **3.3x** |
| sort | -u unique 10MB | 0.0538s | 0.0105s | 0.0343s | **5.1x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0696s | 0.0142s | 0.0675s | **4.9x** | **4.8x** |
| sort | repetitive 10MB | 0.0458s | 0.0102s | 0.0370s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0501s | 0.0093s | 0.0273s | **5.4x** | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0038s | 0.0069s | **2.3x** | **1.8x** |
| tr | -d digits 10MB | 0.0111s | 0.0052s | 0.0103s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0187s | 0.0067s | 0.0171s | **2.8x** | **2.6x** |
| tr | -s spaces 10MB | 0.0166s | 0.0040s | 0.0114s | **4.1x** | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0042s | 0.0068s | **2.1x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0052s | 0.0103s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0042s | 0.0077s | **2.2x** | **1.9x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0017s | 0.0090s | **5.5x** | **5.3x** |
| uniq | default 10MB sorted (low dup) | 0.0169s | 0.0027s | 0.0100s | **6.2x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0016s | 0.0089s | **5.7x** | **5.4x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0069s | 0.0116s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0017s | 0.0087s | **5.4x** | **5.1x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0017s | 0.0089s | **5.5x** | **5.2x** |
| uniq | -i case insensitive 10MB | 0.0165s | 0.0040s | 0.0098s | **4.2x** | **2.5x** |
| uniq | repetitive 10MB | 0.0488s | 0.0031s | 0.0158s | **15.8x** | **5.1x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0086s | 0.0043s | 0.0049s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0861s | 0.0225s | 0.0429s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0042s | 0.0044s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0186s | 0.0089s | 0.0086s | **2.1x** | **1.0x** |
| tac | custom separator 1MB | 0.0043s | 0.0035s | 0.0037s | **1.2x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0028s | 0.0042s | **2.0x** | **1.5x** |
| wc | default 10MB text | 0.0549s | 0.0032s | 0.0340s | **17.1x** | **10.6x** |
| wc | default 100MB text | 0.4834s | 0.0145s | 0.2916s | **33.4x** | **20.2x** |
| wc | -l 10MB text | 0.0022s | 0.0025s | 0.0019s | **0.9x** | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0087s | 0.0346s | **6.2x** | **4.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0545s | 0.0030s | 0.0021s | **17.9x** | **0.7x** |
| wc | -L 10MB text | 0.0547s | 0.0112s | 0.0167s | **4.9x** | **1.5x** |
| wc | default 10MB binary | 0.3173s | 0.0272s | 0.1557s | **11.6x** | **5.7x** |
| wc | default 10MB repetitive | 0.0735s | 0.0048s | 0.0480s | **15.4x** | **10.1x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0023s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0036s | 0.0074s | **6.3x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0037s | 0.0073s | **6.2x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0053s | 0.0084s | **3.2x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0224s | 0.0077s | 0.0181s | **2.9x** | **2.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0054s | 0.0140s | **4.5x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0054s | 0.0171s | **5.7x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0029s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0104s | 0.0085s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0103s | 0.0090s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0760s | 0.0665s | 0.0754s | **1.1x** | **1.1x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0027s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0173s | 0.0182s | 0.0216s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0181s | 0.0188s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1615s | 0.1445s | 0.2037s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.7x** | **0.7x** |
| md5sum | 100 files | 0.0023s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0153s | 0.0129s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0159s | 0.0130s | 0.0131s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1431s | 0.1110s | 0.1136s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0130s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0126s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0018s | 0.0019s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0124s | 0.0043s | 0.0082s | **2.9x** | **1.9x** |
| base64 | encode 10MB binary | 0.0129s | 0.0044s | 0.0084s | **3.0x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0044s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0327s | 0.0048s | 0.0337s | **6.8x** | **7.0x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0046s | 0.0083s | **2.8x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0042s | 0.0076s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0035s | 0.0056s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0545s | 0.0092s | 0.0360s | **5.9x** | **3.9x** |
| sort | already sorted 10MB | 0.0264s | 0.0046s | 0.0178s | **5.7x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0307s | 0.0063s | 0.0184s | **4.8x** | **2.9x** |
| sort | -n numeric 10MB | 0.0736s | 0.0056s | 0.0756s | **13.3x** | **13.6x** |
| sort | -r reverse 10MB | 0.0548s | 0.0092s | 0.0362s | **6.0x** | **3.9x** |
| sort | -u unique 10MB | 0.0579s | 0.0093s | 0.0398s | **6.2x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0667s | 0.0203s | 0.0838s | **3.3x** | **4.1x** |
| sort | repetitive 10MB | 0.0556s | 0.0124s | 0.0373s | **4.5x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0547s | 0.0090s | 0.0363s | **6.1x** | **4.0x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0038s | 0.0075s | **3.4x** | **2.0x** |
| tr | -d digits 10MB | 0.0184s | 0.0043s | 0.0133s | **4.3x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0286s | 0.0050s | 0.0212s | **5.7x** | **4.2x** |
| tr | -s spaces 10MB | 0.0265s | 0.0036s | 0.0264s | **7.3x** | **7.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0036s | 0.0077s | **3.5x** | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0178s | 0.0044s | 0.0137s | **4.1x** | **3.1x** |
| tr | translate binary 10MB | 0.0115s | 0.0040s | 0.0081s | **2.9x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0127s | 0.0019s | 0.0112s | **6.7x** | **5.9x** |
| uniq | default 10MB sorted (low dup) | 0.0148s | 0.0031s | 0.0130s | **4.8x** | **4.2x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0019s | 0.0112s | **6.4x** | **5.9x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0078s | 0.0154s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0019s | 0.0113s | **6.4x** | **6.0x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | 0.0113s | **6.3x** | **5.9x** |
| uniq | -i case insensitive 10MB | 0.0143s | 0.0048s | 0.0131s | **3.0x** | **2.7x** |
| uniq | repetitive 10MB | 0.0425s | 0.0036s | 0.0168s | **11.9x** | **4.7x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.1x** |
| tac | reverse 10MB text | 0.0106s | 0.0046s | 0.0059s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1042s | 0.0272s | 0.0522s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0052s | 0.0060s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0101s | 0.0112s | **2.3x** | **1.1x** |
| tac | custom separator 1MB | 0.0061s | 0.0043s | 0.0054s | **1.4x** | **1.3x** |
