# fcoreutils v0.0.18 — Detailed Results

Generated: 2026-02-15 03:00:13 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 407 | 6 | 98.5% |
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 413 | 413 | 0 | 100.0% |

**Overall: 1233/1239 (99.5%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0039s | 0.0028s | **1.4x** |
| wc | default 10MB text | 0.0336s | 0.0221s | **1.5x** |
| wc | default 100MB text | 0.2928s | 0.1824s | **1.6x** |
| wc | -l 10MB text | 0.0039s | 0.0022s | **1.8x** |
| wc | -w 10MB text | 0.0337s | 0.0204s | **1.6x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | **0.9x** |
| wc | -m 10MB text | 0.0336s | 0.0036s | **9.3x** |
| wc | -L 10MB text | 0.0336s | 0.0145s | **2.3x** |
| wc | default 10MB binary | 0.2352s | 0.0564s | **4.2x** |
| wc | default 10MB repetitive | 0.0509s | 0.0238s | **2.1x** |
| wc | 10 files | 0.0009s | 0.0010s | **0.8x** |
| wc | 100 files | 0.0014s | 0.0020s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0189s | 0.0057s | **3.3x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0053s | **3.6x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0034s | **5.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0064s | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0057s | **4.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0070s | **3.8x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0017s | **2.1x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0009s | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0010s | **1.2x** |
| sha256sum | single 1MB text | 0.0019s | 0.0016s | **1.2x** |
| sha256sum | single 10MB text | 0.0072s | 0.0070s | **1.0x** |
| sha256sum | single 10MB binary | 0.0085s | 0.0074s | **1.1x** |
| sha256sum | single 100MB text | 0.0618s | 0.0600s | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0010s | **1.3x** |
| sha256sum | 100 files | 0.0018s | 0.0014s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0032s | 0.0025s | **1.3x** |
| md5sum | single 10MB text | 0.0205s | 0.0160s | **1.3x** |
| md5sum | single 10MB binary | 0.0224s | 0.0171s | **1.3x** |
| md5sum | single 100MB text | 0.1937s | 0.1494s | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0010s | **1.2x** |
| md5sum | 100 files | 0.0018s | 0.0015s | **1.2x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0022s | **1.0x** |
| b2sum | single 10MB text | 0.0136s | 0.0129s | **1.1x** |
| b2sum | single 10MB binary | 0.0152s | 0.0137s | **1.1x** |
| b2sum | single 100MB text | 0.1284s | 0.1183s | **1.1x** |
| b2sum | -l 256 10MB | 0.0136s | 0.0129s | **1.1x** |
| b2sum | -l 128 10MB | 0.0135s | 0.0129s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0018s | 0.0021s | **0.9x** |
| base64 | encode 10MB text | 0.0095s | 0.0069s | **1.4x** |
| base64 | encode 10MB binary | 0.0107s | 0.0069s | **1.5x** |
| base64 | decode 1MB | 0.0039s | 0.0027s | **1.4x** |
| base64 | decode 10MB | 0.0309s | 0.0191s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0065s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0046s | **1.6x** |
| sort | lexicographic 1MB | 0.0079s | 0.0041s | **1.9x** |
| sort | lexicographic 10MB random | 0.0538s | 0.0229s | **2.4x** |
| sort | already sorted 10MB | 0.0248s | 0.0102s | **2.4x** |
| sort | reverse sorted 10MB | 0.0246s | 0.0104s | **2.4x** |
| sort | -n numeric 10MB | 0.0726s | 0.0427s | **1.7x** |
| sort | -r reverse 10MB | 0.0548s | 0.0232s | **2.4x** |
| sort | -u unique 10MB | 0.0581s | 0.0276s | **2.1x** |
| sort | -t, -k2 CSV 10MB | 0.0778s | 0.0440s | **1.8x** |
| sort | repetitive 10MB | 0.0435s | 0.0240s | **1.8x** |
| sort | --parallel=4 10MB | 0.0542s | 0.0261s | **2.1x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0018s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0093s | 0.0062s | **1.5x** |
| tr | -d digits 10MB | 0.0112s | 0.0109s | **1.0x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0184s | **1.1x** |
| tr | -s spaces 10MB | 0.0169s | 0.0209s | **0.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0093s | 0.0061s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0112s | **1.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0066s | **1.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0056s | **2.9x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0049s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0073s | **4.0x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0048s | **2.0x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0048s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0062s | **2.6x** |
| uniq | repetitive 10MB | 0.0464s | 0.0070s | **6.6x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | **0.9x** |
| tac | reverse 1MB text | 0.0018s | 0.0017s | **1.1x** |
| tac | reverse 10MB text | 0.0084s | 0.0064s | **1.3x** |
| tac | reverse 100MB text | 0.0789s | 0.0367s | **2.2x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0060s | **1.4x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0099s | **1.7x** |
| tac | custom separator 1MB | 0.0044s | 0.0036s | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0031s | **1.8x** |
| wc | default 10MB text | 0.0553s | 0.0263s | **2.1x** |
| wc | default 100MB text | 0.4827s | 0.2222s | **2.2x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0224s | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.1x** |
| wc | -m 10MB text | 0.0544s | 0.0037s | **14.7x** |
| wc | -L 10MB text | 0.0546s | 0.0137s | **4.0x** |
| wc | default 10MB binary | 0.3172s | 0.0842s | **3.8x** |
| wc | default 10MB repetitive | 0.0732s | 0.0297s | **2.5x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0026s | **0.7x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0056s | **4.1x** |
| cut | -c1-100 10MB CSV | 0.0228s | 0.0055s | **4.2x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0040s | **4.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0229s | 0.0079s | **2.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0073s | **3.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0308s | 0.0106s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0017s | **1.9x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.3x** |
| sha256sum | single 1MB text | 0.0020s | 0.0016s | **1.3x** |
| sha256sum | single 10MB text | 0.0085s | 0.0081s | **1.1x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0084s | **1.0x** |
| sha256sum | single 100MB text | 0.0757s | 0.0739s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0010s | **1.5x** |
| sha256sum | 100 files | 0.0025s | 0.0018s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0028s | **1.0x** |
| md5sum | single 10MB text | 0.0174s | 0.0203s | **0.9x** |
| md5sum | single 10MB binary | 0.0181s | 0.0212s | **0.9x** |
| md5sum | single 100MB text | 0.1609s | 0.1934s | **0.8x** |
| md5sum | 10 files | 0.0014s | 0.0010s | **1.4x** |
| md5sum | 100 files | 0.0023s | 0.0018s | **1.3x** |
| b2sum | single 100KB text | 0.0010s | 0.0010s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0020s | **1.2x** |
| b2sum | single 10MB text | 0.0153s | 0.0120s | **1.3x** |
| b2sum | single 10MB binary | 0.0155s | 0.0125s | **1.2x** |
| b2sum | single 100MB text | 0.1432s | 0.1115s | **1.3x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0120s | **1.3x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0120s | **1.3x** |
| b2sum | 100 files | 0.0023s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0021s | **1.0x** |
| base64 | encode 10MB text | 0.0124s | 0.0083s | **1.5x** |
| base64 | encode 10MB binary | 0.0132s | 0.0084s | **1.6x** |
| base64 | decode 1MB | 0.0040s | 0.0029s | **1.4x** |
| base64 | decode 10MB | 0.0327s | 0.0164s | **2.0x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0085s | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0056s | **1.6x** |
| sort | lexicographic 1MB | 0.0089s | 0.0043s | **2.1x** |
| sort | lexicographic 10MB random | 0.0558s | 0.0216s | **2.6x** |
| sort | already sorted 10MB | 0.0268s | 0.0128s | **2.1x** |
| sort | reverse sorted 10MB | 0.0281s | 0.0130s | **2.2x** |
| sort | -n numeric 10MB | 0.0752s | 0.0389s | **1.9x** |
| sort | -r reverse 10MB | 0.0546s | 0.0182s | **3.0x** |
| sort | -u unique 10MB | 0.0578s | 0.0189s | **3.1x** |
| sort | -t, -k2 CSV 10MB | 0.0668s | 0.0357s | **1.9x** |
| sort | repetitive 10MB | 0.0548s | 0.0220s | **2.5x** |
| sort | --parallel=4 10MB | 0.0545s | 0.0176s | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0086s | **1.5x** |
| tr | -d digits 10MB | 0.0160s | 0.0147s | **1.1x** |
| tr | -d lowercase 10MB | 0.0293s | 0.0265s | **1.1x** |
| tr | -s spaces 10MB | 0.0268s | 0.0308s | **0.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0083s | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0178s | 0.0148s | **1.2x** |
| tr | translate binary 10MB | 0.0120s | 0.0104s | **1.2x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0044s | **2.7x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0043s | **3.2x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0045s | **2.7x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0069s | **4.2x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0045s | **2.6x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0045s | **2.6x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0054s | **2.6x** |
| uniq | repetitive 10MB | 0.0421s | 0.0068s | **6.2x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | **0.9x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | **1.3x** |
| tac | reverse 10MB text | 0.0105s | 0.0045s | **2.4x** |
| tac | reverse 100MB text | 0.1047s | 0.0362s | **2.9x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0044s | **2.1x** |
| tac | reverse repetitive 10MB | 0.0231s | 0.0084s | **2.8x** |
| tac | custom separator 1MB | 0.0059s | 0.0043s | **1.4x** |
