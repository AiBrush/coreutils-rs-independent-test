# fcoreutils v0.1.5 — Detailed Results

Generated: 2026-02-17 02:54:04 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0038s | 0.0025s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0339s | 0.0068s | 0.0252s | **5.0x** | **3.7x** |
| wc | default 100MB text | 0.2975s | 0.0443s | 0.2260s | **6.7x** | **5.1x** |
| wc | -l 10MB text | 0.0039s | 0.0021s | 0.0024s | **1.8x** | **1.1x** |
| wc | -w 10MB text | 0.0339s | 0.0066s | 0.0227s | **5.2x** | **3.5x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0338s | 0.0021s | 0.0022s | **15.9x** | **1.0x** |
| wc | -L 10MB text | 0.0337s | 0.0060s | 0.0171s | **5.6x** | **2.8x** |
| wc | default 10MB binary | 0.2366s | 0.0171s | 0.1181s | **13.9x** | **6.9x** |
| wc | default 10MB repetitive | 0.0526s | 0.0081s | 0.0380s | **6.5x** | **4.7x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0011s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0017s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0036s | 0.0063s | **5.2x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0033s | 0.0063s | **5.6x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0046s | 0.0071s | **4.0x** | **1.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0048s | 0.0165s | **4.4x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0036s | 0.0126s | **6.5x** | **3.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0031s | 0.0162s | **8.5x** | **5.2x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0023s | 0.0018s | **1.5x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0022s | 0.0014s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | 0.0038s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0074s | 0.0073s | 0.0272s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0081s | 0.0077s | 0.0289s | **1.0x** | **3.7x** |
| sha256sum | single 100MB text | 0.0679s | 0.0551s | 0.2614s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0020s | 0.0011s | **0.6x** | **0.5x** |
| sha256sum | 100 files | 0.0018s | 0.0024s | 0.0017s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | 0.0030s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0209s | 0.0161s | 0.0172s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0222s | 0.0169s | 0.0182s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.1994s | 0.1431s | 0.1649s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0020s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0024s | 0.0016s | **0.7x** | **0.6x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | 0.0022s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0137s | 0.0124s | 0.0132s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0148s | 0.0130s | 0.0142s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1340s | 0.1154s | 0.1278s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0138s | 0.0124s | 0.0130s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0136s | 0.0124s | 0.0133s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0014s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0095s | 0.0050s | 0.0069s | **1.9x** | **1.4x** |
| base64 | encode 10MB binary | 0.0101s | 0.0053s | 0.0073s | **1.9x** | **1.4x** |
| base64 | decode 1MB | 0.0038s | 0.0020s | 0.0035s | **1.8x** | **1.7x** |
| base64 | decode 10MB | 0.0303s | 0.0102s | 0.0264s | **3.0x** | **2.6x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0050s | 0.0070s | **1.9x** | **1.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0073s | 0.0044s | 0.0069s | **1.7x** | **1.6x** |
| sort | lexicographic 1MB | 0.0074s | 0.0028s | 0.0045s | **2.7x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0521s | 0.0090s | 0.0291s | **5.8x** | **3.2x** |
| sort | already sorted 10MB | 0.0249s | 0.0038s | 0.0138s | **6.6x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0246s | 0.0056s | 0.0141s | **4.4x** | **2.5x** |
| sort | -n numeric 10MB | 0.0705s | 0.0039s | 0.0619s | **18.3x** | **16.1x** |
| sort | -r reverse 10MB | 0.0525s | 0.0087s | 0.0292s | **6.1x** | **3.4x** |
| sort | -u unique 10MB | 0.0552s | 0.0091s | 0.0345s | **6.0x** | **3.8x** |
| sort | -t, -k2 CSV 10MB | 0.0710s | 0.0189s | 0.0694s | **3.8x** | **3.7x** |
| sort | repetitive 10MB | 0.0463s | 0.0101s | 0.0357s | **4.6x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0515s | 0.0089s | 0.0295s | **5.8x** | **3.3x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0019s | 0.0018s | **0.9x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0086s | 0.0064s | 0.0069s | **1.3x** | **1.1x** |
| tr | -d digits 10MB | 0.0113s | 0.0083s | 0.0103s | **1.4x** | **1.2x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0108s | 0.0169s | **1.8x** | **1.6x** |
| tr | -s spaces 10MB | 0.0169s | 0.0067s | 0.0117s | **2.5x** | **1.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0086s | 0.0065s | 0.0070s | **1.3x** | **1.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0085s | 0.0104s | **1.3x** | **1.2x** |
| tr | translate binary 10MB | 0.0089s | 0.0073s | 0.0079s | **1.2x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0028s | 0.0088s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0033s | 0.0099s | **5.0x** | **3.0x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0030s | 0.0088s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0070s | 0.0114s | **4.2x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0028s | 0.0088s | **3.3x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0089s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0165s | 0.0041s | 0.0096s | **4.0x** | **2.4x** |
| uniq | repetitive 10MB | 0.0484s | 0.0040s | 0.0145s | **12.2x** | **3.7x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0082s | 0.0044s | 0.0048s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0833s | 0.0386s | 0.0426s | **2.2x** | **1.1x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0047s | 0.0045s | **1.7x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0184s | 0.0094s | 0.0088s | **2.0x** | **0.9x** |
| tac | custom separator 1MB | 0.0045s | 0.0043s | 0.0042s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0045s | **2.0x** | **1.6x** |
| wc | default 10MB text | 0.0539s | 0.0031s | 0.0363s | **17.6x** | **11.8x** |
| wc | default 100MB text | 0.4840s | 0.0142s | 0.3153s | **34.1x** | **22.2x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0546s | 0.0087s | 0.0266s | **6.3x** | **3.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0542s | 0.0029s | 0.0020s | **18.4x** | **0.7x** |
| wc | -L 10MB text | 0.0548s | 0.0112s | 0.0167s | **4.9x** | **1.5x** |
| wc | default 10MB binary | 0.3305s | 0.0273s | 0.1569s | **12.1x** | **5.7x** |
| wc | default 10MB repetitive | 0.0729s | 0.0045s | 0.0524s | **16.3x** | **11.7x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0021s | 0.0024s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0052s | 0.0071s | **4.4x** | **1.4x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0052s | 0.0070s | **4.3x** | **1.3x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0051s | 0.0082s | **3.2x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0066s | 0.0179s | **3.3x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0056s | 0.0132s | **4.3x** | **2.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0047s | 0.0168s | **6.5x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0015s | 0.0023s | 0.0014s | **0.7x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0087s | 0.0096s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0099s | 0.0089s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0753s | 0.0757s | 0.0754s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0030s | 0.0023s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0038s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0172s | 0.0173s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0180s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1613s | 0.1539s | 0.2035s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0031s | 0.0024s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | 0.0014s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0122s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0127s | 0.0128s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1431s | 0.1122s | 0.1131s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0121s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0122s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0018s | 0.0024s | **1.2x** | **1.3x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0020s | 0.0014s | 0.0018s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0124s | 0.0050s | 0.0082s | **2.5x** | **1.6x** |
| base64 | encode 10MB binary | 0.0129s | 0.0050s | 0.0084s | **2.6x** | **1.7x** |
| base64 | decode 1MB | 0.0040s | 0.0019s | 0.0043s | **2.1x** | **2.2x** |
| base64 | decode 10MB | 0.0326s | 0.0108s | 0.0333s | **3.0x** | **3.1x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0048s | 0.0080s | **2.6x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0037s | 0.0073s | **2.3x** | **2.0x** |
| sort | lexicographic 1MB | 0.0085s | 0.0033s | 0.0055s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0111s | 0.0357s | **4.9x** | **3.2x** |
| sort | already sorted 10MB | 0.0261s | 0.0049s | 0.0176s | **5.4x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0081s | 0.0177s | **3.4x** | **2.2x** |
| sort | -n numeric 10MB | 0.0735s | 0.0057s | 0.0749s | **12.9x** | **13.1x** |
| sort | -r reverse 10MB | 0.0567s | 0.0113s | 0.0357s | **5.0x** | **3.2x** |
| sort | -u unique 10MB | 0.0576s | 0.0117s | 0.0392s | **4.9x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0659s | 0.0224s | 0.0842s | **2.9x** | **3.8x** |
| sort | repetitive 10MB | 0.0549s | 0.0117s | 0.0375s | **4.7x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0114s | 0.0360s | **4.8x** | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0018s | 0.0020s | **1.3x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0071s | 0.0078s | **1.7x** | **1.1x** |
| tr | -d digits 10MB | 0.0167s | 0.0094s | 0.0138s | **1.8x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0287s | 0.0125s | 0.0211s | **2.3x** | **1.7x** |
| tr | -s spaces 10MB | 0.0263s | 0.0070s | 0.0264s | **3.8x** | **3.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0066s | 0.0073s | **1.9x** | **1.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0097s | 0.0132s | **1.6x** | **1.4x** |
| tr | translate binary 10MB | 0.0117s | 0.0067s | 0.0086s | **1.7x** | **1.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0037s | 0.0112s | **3.2x** | **3.0x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0037s | 0.0128s | **3.8x** | **3.5x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0111s | **3.5x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0092s | 0.0152s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0035s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0034s | 0.0110s | **3.5x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0138s | 0.0044s | 0.0128s | **3.1x** | **2.9x** |
| uniq | repetitive 10MB | 0.0418s | 0.0041s | 0.0161s | **10.1x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | 0.0019s | **0.7x** | **1.5x** |
| tac | reverse 1MB text | 0.0019s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0104s | 0.0046s | 0.0058s | **2.2x** | **1.2x** |
| tac | reverse 100MB text | 0.1035s | 0.0397s | 0.0515s | **2.6x** | **1.3x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0051s | 0.0056s | **1.8x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0233s | 0.0098s | 0.0108s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0060s | 0.0043s | 0.0053s | **1.4x** | **1.2x** |
