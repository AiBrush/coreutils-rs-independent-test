# fcoreutils v0.1.9 — Detailed Results

Generated: 2026-02-17 00:26:42 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0027s | 0.0034s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0065s | 0.0257s | **5.3x** | **3.9x** |
| wc | default 100MB text | 0.3013s | 0.0481s | 0.2288s | **6.3x** | **4.8x** |
| wc | -l 10MB text | 0.0044s | 0.0020s | 0.0028s | **2.2x** | **1.4x** |
| wc | -w 10MB text | 0.0343s | 0.0061s | 0.0233s | **5.7x** | **3.8x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | 0.0010s | **0.9x** | **1.1x** |
| wc | -m 10MB text | 0.0343s | 0.0022s | 0.0026s | **15.6x** | **1.2x** |
| wc | -L 10MB text | 0.0344s | 0.0063s | 0.0177s | **5.5x** | **2.8x** |
| wc | default 10MB binary | 0.2351s | 0.0171s | 0.1181s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0556s | 0.0086s | 0.0379s | **6.5x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0033s | 0.0064s | **5.6x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0033s | 0.0063s | **5.7x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0043s | 0.0070s | **4.4x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0049s | 0.0163s | **4.3x** | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0035s | 0.0125s | **6.6x** | **3.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0030s | 0.0162s | **8.7x** | **5.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0021s | 0.0018s | **1.6x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.7x** | **1.5x** |
| sha256sum | single 10MB text | 0.0075s | 0.0073s | 0.0274s | **1.0x** | **3.8x** |
| sha256sum | single 10MB binary | 0.0080s | 0.0077s | 0.0290s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0695s | 0.0566s | 0.2634s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0021s | 0.0011s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | 0.0017s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0022s | 0.0013s | **0.5x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0036s | 0.0028s | **0.8x** | **0.8x** |
| md5sum | single 10MB text | 0.0212s | 0.0161s | 0.0177s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0223s | 0.0170s | 0.0187s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2013s | 0.1445s | 0.1668s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0025s | 0.0016s | **0.7x** | **0.6x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0141s | 0.0124s | 0.0139s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0150s | 0.0129s | 0.0144s | **1.2x** | **1.1x** |
| b2sum | single 100MB text | 0.1357s | 0.1154s | 0.1297s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0142s | 0.0123s | 0.0138s | **1.2x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0140s | 0.0123s | 0.0136s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0014s | 0.0016s | **1.1x** | **1.2x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.1x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0097s | 0.0030s | 0.0071s | **3.2x** | **2.4x** |
| base64 | encode 10MB binary | 0.0103s | 0.0035s | 0.0076s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0038s | 0.0019s | 0.0036s | **2.0x** | **1.9x** |
| base64 | decode 10MB | 0.0306s | 0.0084s | 0.0269s | **3.6x** | **3.2x** |
| base64 | encode -w 76 10MB | 0.0097s | 0.0032s | 0.0072s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0075s | 0.0030s | 0.0071s | **2.5x** | **2.3x** |
| sort | lexicographic 1MB | 0.0075s | 0.0027s | 0.0042s | **2.8x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0506s | 0.0063s | 0.0294s | **8.0x** | **4.7x** |
| sort | already sorted 10MB | 0.0250s | 0.0034s | 0.0137s | **7.3x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0247s | 0.0044s | 0.0135s | **5.6x** | **3.1x** |
| sort | -n numeric 10MB | 0.0687s | 0.0039s | 0.0636s | **17.5x** | **16.2x** |
| sort | -r reverse 10MB | 0.0514s | 0.0064s | 0.0296s | **8.1x** | **4.7x** |
| sort | -u unique 10MB | 0.0542s | 0.0082s | 0.0359s | **6.6x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0704s | 0.0144s | 0.0688s | **4.9x** | **4.8x** |
| sort | repetitive 10MB | 0.0458s | 0.0102s | 0.0373s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0504s | 0.0063s | 0.0305s | **8.0x** | **4.9x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0017s | 0.0018s | **1.1x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0094s | 0.0060s | 0.0068s | **1.6x** | **1.1x** |
| tr | -d digits 10MB | 0.0110s | 0.0056s | 0.0103s | **2.0x** | **1.8x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0070s | 0.0171s | **2.7x** | **2.4x** |
| tr | -s spaces 10MB | 0.0165s | 0.0060s | 0.0113s | **2.8x** | **1.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0060s | 0.0066s | **1.5x** | **1.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0055s | 0.0103s | **2.0x** | **1.9x** |
| tr | translate binary 10MB | 0.0091s | 0.0062s | 0.0076s | **1.5x** | **1.2x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0028s | 0.0090s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0169s | 0.0032s | 0.0102s | **5.3x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0031s | 0.0092s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0297s | 0.0069s | 0.0118s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0026s | 0.0088s | **3.6x** | **3.4x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0088s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0039s | 0.0099s | **4.3x** | **2.5x** |
| uniq | repetitive 10MB | 0.0487s | 0.0034s | 0.0157s | **14.4x** | **4.6x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0019s | 0.0016s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0085s | 0.0032s | 0.0050s | **2.6x** | **1.5x** |
| tac | reverse 100MB text | 0.0862s | 0.0200s | 0.0459s | **4.3x** | **2.3x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0033s | 0.0047s | **2.5x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0198s | 0.0062s | 0.0095s | **3.2x** | **1.5x** |
| tac | custom separator 1MB | 0.0045s | 0.0035s | 0.0041s | **1.3x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0038s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0547s | 0.0031s | 0.0303s | **17.5x** | **9.7x** |
| wc | default 100MB text | 0.4824s | 0.0140s | 0.2558s | **34.6x** | **18.3x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0546s | 0.0090s | 0.0258s | **6.1x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0546s | 0.0030s | 0.0020s | **17.9x** | **0.7x** |
| wc | -L 10MB text | 0.0545s | 0.0111s | 0.0199s | **4.9x** | **1.8x** |
| wc | default 10MB binary | 0.3167s | 0.0269s | 0.1551s | **11.8x** | **5.8x** |
| wc | default 10MB repetitive | 0.0732s | 0.0046s | 0.0399s | **15.9x** | **8.7x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0229s | 0.0049s | 0.0078s | **4.7x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0230s | 0.0047s | 0.0075s | **4.9x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0050s | 0.0088s | **3.4x** | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0223s | 0.0068s | 0.0179s | **3.3x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0245s | 0.0053s | 0.0139s | **4.6x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0311s | 0.0047s | 0.0166s | **6.6x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0012s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0097s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0100s | 0.0089s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0752s | 0.0756s | 0.0751s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | 0.0024s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0174s | 0.0175s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0183s | 0.0182s | 0.0229s | **1.0x** | **1.3x** |
| md5sum | single 100MB text | 0.1610s | 0.1532s | 0.2032s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0031s | 0.0024s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0013s | 0.0014s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0123s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0158s | 0.0128s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1428s | 0.1122s | 0.1129s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0122s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0122s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0019s | 0.0023s | **1.2x** | **1.3x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0124s | 0.0049s | 0.0082s | **2.6x** | **1.7x** |
| base64 | encode 10MB binary | 0.0131s | 0.0051s | 0.0086s | **2.6x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | 0.0043s | **1.9x** | **2.1x** |
| base64 | decode 10MB | 0.0329s | 0.0103s | 0.0342s | **3.2x** | **3.3x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0049s | 0.0082s | **2.5x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0041s | 0.0073s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0087s | 0.0034s | 0.0055s | **2.6x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0553s | 0.0097s | 0.0356s | **5.7x** | **3.7x** |
| sort | already sorted 10MB | 0.0264s | 0.0043s | 0.0182s | **6.2x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0069s | 0.0183s | **4.0x** | **2.7x** |
| sort | -n numeric 10MB | 0.0737s | 0.0057s | 0.0773s | **12.9x** | **13.5x** |
| sort | -r reverse 10MB | 0.0548s | 0.0096s | 0.0363s | **5.7x** | **3.8x** |
| sort | -u unique 10MB | 0.0576s | 0.0099s | 0.0396s | **5.8x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0666s | 0.0198s | 0.0823s | **3.4x** | **4.2x** |
| sort | repetitive 10MB | 0.0548s | 0.0119s | 0.0367s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0098s | 0.0357s | **5.5x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0018s | 0.0020s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0134s | 0.0052s | 0.0075s | **2.6x** | **1.4x** |
| tr | -d digits 10MB | 0.0193s | 0.0046s | 0.0142s | **4.2x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0298s | 0.0053s | 0.0232s | **5.6x** | **4.4x** |
| tr | -s spaces 10MB | 0.0257s | 0.0053s | 0.0270s | **4.9x** | **5.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0124s | 0.0050s | 0.0074s | **2.5x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0163s | 0.0047s | 0.0158s | **3.4x** | **3.3x** |
| tr | translate binary 10MB | 0.0120s | 0.0054s | 0.0080s | **2.2x** | **1.5x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0036s | 0.0112s | **3.4x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0036s | 0.0134s | **3.8x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0091s | 0.0156s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0138s | 0.0044s | 0.0135s | **3.2x** | **3.1x** |
| uniq | repetitive 10MB | 0.0417s | 0.0041s | 0.0158s | **10.1x** | **3.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0019s | 0.0022s | 0.0018s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0106s | 0.0044s | 0.0059s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1034s | 0.0254s | 0.0520s | **4.1x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0041s | 0.0057s | **2.3x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0228s | 0.0067s | 0.0112s | **3.4x** | **1.7x** |
| tac | custom separator 1MB | 0.0060s | 0.0035s | 0.0053s | **1.7x** | **1.5x** |
