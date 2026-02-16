# fcoreutils v0.3.2 — Detailed Results

Generated: 2026-02-16 12:55:39 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 412 | 1 | 99.8% |

**Overall: 824/826 (99.8%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0026s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0341s | 0.0062s | 0.0255s | **5.5x** | **4.1x** |
| wc | default 100MB text | 0.2989s | 0.0455s | 0.2273s | **6.6x** | **5.0x** |
| wc | -l 10MB text | 0.0040s | 0.0021s | 0.0023s | **1.9x** | **1.1x** |
| wc | -w 10MB text | 0.0340s | 0.0064s | 0.0230s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0340s | 0.0022s | 0.0024s | **15.6x** | **1.1x** |
| wc | -L 10MB text | 0.0340s | 0.0062s | 0.0173s | **5.5x** | **2.8x** |
| wc | default 10MB binary | 0.2347s | 0.0175s | 0.1176s | **13.4x** | **6.7x** |
| wc | default 10MB repetitive | 0.0525s | 0.0081s | 0.0372s | **6.5x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0039s | 0.0062s | **4.8x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0037s | 0.0063s | **5.0x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0034s | 0.0072s | **5.5x** | **2.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0047s | 0.0164s | **4.5x** | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0037s | 0.0127s | **6.2x** | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0034s | 0.0163s | **7.7x** | **4.7x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0019s | 0.0018s | **1.8x** | **0.9x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0025s | 0.0014s | **0.4x** | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | 0.0038s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0072s | 0.0083s | 0.0271s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0080s | 0.0089s | 0.0287s | **0.9x** | **3.2x** |
| sha256sum | single 100MB text | 0.0692s | 0.0569s | 0.2632s | **1.2x** | **4.6x** |
| sha256sum | 10 files | 0.0011s | 0.0013s | 0.0011s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0018s | 0.0022s | 0.0017s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0039s | 0.0030s | **0.8x** | **0.8x** |
| md5sum | single 10MB text | 0.0208s | 0.0173s | 0.0173s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0221s | 0.0183s | 0.0184s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2007s | 0.1442s | 0.1663s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0013s | 0.0011s | **0.9x** | **0.8x** |
| md5sum | 100 files | 0.0017s | 0.0021s | 0.0017s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0138s | 0.0136s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0149s | 0.0143s | 0.0144s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1353s | 0.1168s | 0.1292s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0134s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0138s | 0.0134s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0017s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0096s | 0.0033s | 0.0070s | **2.9x** | **2.1x** |
| base64 | encode 10MB binary | 0.0103s | 0.0038s | 0.0074s | **2.7x** | **2.0x** |
| base64 | decode 1MB | 0.0038s | 0.0017s | 0.0036s | **2.2x** | **2.0x** |
| base64 | decode 10MB | 0.0307s | 0.0059s | 0.0270s | **5.2x** | **4.5x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0035s | 0.0070s | **2.7x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0073s | 0.0028s | 0.0071s | **2.6x** | **2.5x** |
| sort | lexicographic 1MB | 0.0077s | 0.0026s | 0.0042s | **3.0x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0524s | 0.0066s | 0.0300s | **7.9x** | **4.5x** |
| sort | already sorted 10MB | 0.0252s | 0.0035s | 0.0139s | **7.2x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0249s | 0.0047s | 0.0139s | **5.4x** | **3.0x** |
| sort | -n numeric 10MB | 0.0700s | 0.0039s | 0.0664s | **17.7x** | **16.8x** |
| sort | -r reverse 10MB | 0.0529s | 0.0066s | 0.0308s | **8.0x** | **4.6x** |
| sort | -u unique 10MB | 0.0559s | 0.0084s | 0.0370s | **6.7x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0720s | 0.0147s | 0.0702s | **4.9x** | **4.8x** |
| sort | repetitive 10MB | 0.0464s | 0.0103s | 0.0377s | **4.5x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0520s | 0.0065s | 0.0294s | **8.1x** | **4.6x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0018s | **1.2x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0040s | 0.0068s | **2.3x** | **1.7x** |
| tr | -d digits 10MB | 0.0112s | 0.0051s | 0.0102s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0067s | 0.0171s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0167s | 0.0040s | 0.0114s | **4.2x** | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0040s | 0.0069s | **2.2x** | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0053s | 0.0103s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0093s | 0.0043s | 0.0077s | **2.2x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0028s | 0.0090s | **3.4x** | **3.3x** |
| uniq | default 10MB sorted (low dup) | 0.0167s | 0.0032s | 0.0100s | **5.2x** | **3.1x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0030s | 0.0088s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0070s | 0.0116s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0028s | 0.0088s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0086s | **3.5x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0040s | 0.0098s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0484s | 0.0038s | 0.0150s | **12.6x** | **3.9x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.0x** | **1.0x** |
| tac | reverse 10MB text | 0.0085s | 0.0053s | 0.0049s | **1.6x** | **0.9x** |
| tac | reverse 100MB text | 0.0855s | 0.0234s | 0.0438s | **3.6x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0052s | 0.0045s | **1.6x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0185s | 0.0092s | 0.0087s | **2.0x** | **0.9x** |
| tac | custom separator 1MB | 0.0044s | 0.0031s | 0.0042s | **1.4x** | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.9x** | **1.0x** |
| wc | default 1MB text | 0.0044s | 0.0032s | 0.0038s | **1.4x** | **1.2x** |
| wc | default 10MB text | 0.0434s | 0.0027s | 0.0349s | **16.0x** | **12.9x** |
| wc | default 100MB text | 0.3796s | 0.0118s | 0.2934s | **32.3x** | **24.9x** |
| wc | -l 10MB text | 0.0016s | 0.0022s | 0.0017s | **0.7x** | **0.8x** |
| wc | -w 10MB text | 0.0430s | 0.0095s | 0.0301s | **4.5x** | **3.2x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0009s | **0.7x** | **1.0x** |
| wc | -m 10MB text | 0.0433s | 0.0025s | 0.0018s | **17.2x** | **0.7x** |
| wc | -L 10MB text | 0.0431s | 0.0111s | 0.0157s | **3.9x** | **1.4x** |
| wc | default 10MB binary | 0.3219s | 0.0308s | 0.1560s | **10.4x** | **5.1x** |
| wc | default 10MB repetitive | 0.0557s | 0.0038s | 0.0388s | **14.5x** | **10.1x** |
| wc | 10 files | 0.0008s | 0.0013s | 0.0010s | **0.6x** | **0.8x** |
| wc | 100 files | 0.0011s | 0.0014s | 0.0014s | **0.8x** | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0196s | 0.0043s | 0.0056s | **4.6x** | **1.3x** |
| cut | -c1-100 10MB CSV | 0.0194s | 0.0039s | 0.0053s | **4.9x** | **1.4x** |
| cut | -d, -f1 10MB CSV | 0.0217s | 0.0034s | 0.0068s | **6.4x** | **2.0x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0246s | 0.0082s | 0.0157s | **3.0x** | **1.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0267s | 0.0052s | 0.0118s | **5.2x** | **2.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0300s | 0.0050s | 0.0152s | **6.0x** | **3.0x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0010s | 0.0010s | **0.6x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0049s | 0.0027s | 0.0019s | **1.8x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0013s | 0.0010s | **0.7x** | **0.8x** |
| sha256sum | single 100KB text | 0.0010s | 0.0020s | 0.0010s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0017s | 0.0028s | 0.0018s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0103s | 0.0123s | 0.0099s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0103s | 0.0119s | 0.0100s | **0.9x** | **0.8x** |
| sha256sum | single 100MB text | 0.0897s | 0.0853s | 0.0895s | **1.1x** | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0011s | 0.0010s | **0.8x** | **0.9x** |
| sha256sum | 100 files | 0.0015s | 0.0022s | 0.0014s | **0.7x** | **0.6x** |
| md5sum | single 100KB text | 0.0011s | 0.0020s | 0.0011s | **0.5x** | **0.6x** |
| md5sum | single 1MB text | 0.0024s | 0.0032s | 0.0028s | **0.7x** | **0.9x** |
| md5sum | single 10MB text | 0.0164s | 0.0179s | 0.0202s | **0.9x** | **1.1x** |
| md5sum | single 10MB binary | 0.0164s | 0.0178s | 0.0214s | **0.9x** | **1.2x** |
| md5sum | single 100MB text | 0.1520s | 0.1390s | 0.1940s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0010s | 0.0012s | 0.0010s | **0.8x** | **0.8x** |
| md5sum | 100 files | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| b2sum | single 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0018s | 0.0023s | **1.1x** | **1.3x** |
| b2sum | single 10MB text | 0.0146s | 0.0132s | 0.0135s | **1.1x** | **1.0x** |
| b2sum | single 10MB binary | 0.0157s | 0.0135s | 0.0117s | **1.2x** | **0.9x** |
| b2sum | single 100MB text | 0.1371s | 0.0974s | 0.1078s | **1.4x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0125s | 0.0113s | **1.1x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0127s | 0.0111s | **1.1x** | **0.9x** |
| b2sum | 100 files | 0.0013s | 0.0019s | 0.0014s | **0.7x** | **0.8x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0009s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0012s | **1.1x** | **0.8x** |
| base64 | encode 10MB text | 0.0106s | 0.0056s | 0.0045s | **1.9x** | **0.8x** |
| base64 | encode 10MB binary | 0.0112s | 0.0047s | 0.0048s | **2.4x** | **1.0x** |
| base64 | decode 1MB | 0.0035s | 0.0013s | 0.0034s | **2.7x** | **2.6x** |
| base64 | decode 10MB | 0.0304s | 0.0080s | 0.0272s | **3.8x** | **3.4x** |
| base64 | encode -w 76 10MB | 0.0106s | 0.0048s | 0.0047s | **2.2x** | **1.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0033s | 0.0049s | **2.5x** | **1.5x** |
| sort | lexicographic 1MB | 0.0078s | 0.0034s | 0.0046s | **2.3x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0523s | 0.0116s | 0.0316s | **4.5x** | **2.7x** |
| sort | already sorted 10MB | 0.0230s | 0.0051s | 0.0144s | **4.5x** | **2.8x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0077s | 0.0144s | **3.2x** | **1.9x** |
| sort | -n numeric 10MB | 0.0729s | 0.0069s | 0.0660s | **10.5x** | **9.5x** |
| sort | -r reverse 10MB | 0.0542s | 0.0133s | 0.0332s | **4.1x** | **2.5x** |
| sort | -u unique 10MB | 0.0647s | 0.0118s | 0.0389s | **5.5x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0687s | 0.0221s | 0.0785s | **3.1x** | **3.6x** |
| sort | repetitive 10MB | 0.0502s | 0.0123s | 0.0337s | **4.1x** | **2.7x** |
| sort | --parallel=4 10MB | 0.0536s | 0.0117s | 0.0323s | **4.6x** | **2.8x** |
| tr | a-z to A-Z 1MB | 0.0016s | 0.0014s | 0.0016s | **1.1x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0080s | 0.0042s | 0.0068s | **1.9x** | **1.6x** |
| tr | -d digits 10MB | 0.0163s | 0.0043s | 0.0136s | **3.8x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0283s | 0.0048s | 0.0233s | **5.9x** | **4.8x** |
| tr | -s spaces 10MB | 0.0251s | 0.0040s | 0.0284s | **6.3x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0078s | 0.0040s | 0.0067s | **2.0x** | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0161s | 0.0042s | 0.0135s | **3.9x** | **3.2x** |
| tr | translate binary 10MB | 0.0081s | 0.0041s | 0.0071s | **2.0x** | **1.7x** |
| uniq | default 10MB many duplicates | 0.0087s | 0.0027s | 0.0097s | **3.2x** | **3.6x** |
| uniq | default 10MB sorted (low dup) | 0.0187s | 0.0053s | 0.0127s | **3.6x** | **2.4x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0027s | 0.0096s | **3.5x** | **3.5x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0093s | 0.0141s | **3.2x** | **1.5x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0029s | 0.0098s | **3.3x** | **3.4x** |
| uniq | -u unique only 10MB | 0.0095s | 0.0030s | 0.0097s | **3.2x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0188s | 0.0044s | 0.0124s | **4.3x** | **2.8x** |
| uniq | repetitive 10MB | 0.0491s | 0.0040s | 0.0140s | **12.2x** | **3.5x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0009s | **0.8x** | **0.9x** |
| tac | reverse 1MB text | 0.0015s | 0.0014s | 0.0013s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0079s | 0.0058s | 0.0046s | **1.4x** | **0.8x** |
| tac | reverse 100MB text | 0.0815s | 0.0219s | 0.0437s | **3.7x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0056s | 0.0051s | **1.4x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0162s | 0.0088s | 0.0087s | **1.8x** | **1.0x** |
| tac | custom separator 1MB | 0.0053s | 0.0041s | 0.0042s | **1.3x** | **1.0x** |
