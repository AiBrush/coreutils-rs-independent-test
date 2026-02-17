# fcoreutils v0.6.7 — Detailed Results

Generated: 2026-02-17 06:44:37 UTC

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
| wc | default 100KB text | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0040s | 0.0027s | 0.0037s | **1.5x** | **1.4x** |
| wc | default 10MB text | 0.0341s | 0.0067s | 0.0254s | **5.1x** | **3.8x** |
| wc | default 100MB text | 0.3022s | 0.0473s | 0.2291s | **6.4x** | **4.8x** |
| wc | -l 10MB text | 0.0045s | 0.0026s | 0.0034s | **1.7x** | **1.3x** |
| wc | -w 10MB text | 0.0341s | 0.0064s | 0.0231s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0342s | 0.0026s | 0.0032s | **13.0x** | **1.2x** |
| wc | -L 10MB text | 0.0343s | 0.0065s | 0.0176s | **5.3x** | **2.7x** |
| wc | default 10MB binary | 0.2363s | 0.0179s | 0.1184s | **13.2x** | **6.6x** |
| wc | default 10MB repetitive | 0.0554s | 0.0092s | 0.0382s | **6.0x** | **4.2x** |
| wc | 10 files | 0.0009s | 0.0012s | 0.0013s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0015s | 0.0017s | 0.0019s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0192s | 0.0034s | 0.0072s | **5.7x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0191s | 0.0034s | 0.0071s | **5.7x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0193s | 0.0050s | 0.0080s | **3.8x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0052s | 0.0170s | **4.2x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0237s | 0.0050s | 0.0134s | **4.8x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0271s | 0.0050s | 0.0168s | **5.4x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0013s | 0.0012s | **0.6x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0038s | 0.0029s | 0.0021s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0014s | 0.0011s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0026s | 0.0015s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0021s | 0.0034s | 0.0041s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0081s | 0.0090s | 0.0275s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0099s | 0.0293s | **0.9x** | **2.9x** |
| sha256sum | single 100MB text | 0.0720s | 0.0708s | 0.2653s | **1.0x** | **3.7x** |
| sha256sum | 10 files | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0021s | 0.0026s | 0.0020s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0034s | 0.0039s | 0.0031s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0212s | 0.0176s | 0.0176s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0227s | 0.0189s | 0.0190s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2028s | 0.1455s | 0.1680s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0020s | 0.0028s | 0.0020s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0024s | 0.0027s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0143s | 0.0138s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0153s | 0.0149s | 0.0151s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1377s | 0.1187s | 0.1307s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0142s | 0.0138s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0136s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0018s | 0.0019s | 0.0020s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| base64 | encode 10MB text | 0.0099s | 0.0034s | 0.0074s | **3.0x** | **2.2x** |
| base64 | encode 10MB binary | 0.0110s | 0.0039s | 0.0084s | **2.8x** | **2.2x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0039s | **1.8x** | **1.8x** |
| base64 | decode 10MB | 0.0311s | 0.0046s | 0.0274s | **6.7x** | **5.9x** |
| base64 | encode -w 76 10MB | 0.0099s | 0.0036s | 0.0075s | **2.7x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0036s | 0.0076s | **2.2x** | **2.1x** |
| sort | lexicographic 1MB | 0.0079s | 0.0036s | 0.0050s | **2.2x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0594s | 0.0125s | 0.0382s | **4.8x** | **3.1x** |
| sort | already sorted 10MB | 0.0262s | 0.0042s | 0.0151s | **6.3x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0260s | 0.0052s | 0.0149s | **5.0x** | **2.9x** |
| sort | -n numeric 10MB | 0.0775s | 0.0043s | 0.0753s | **18.2x** | **17.7x** |
| sort | -r reverse 10MB | 0.0587s | 0.0117s | 0.0369s | **5.0x** | **3.2x** |
| sort | -u unique 10MB | 0.0621s | 0.0135s | 0.0437s | **4.6x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0799s | 0.0186s | 0.0803s | **4.3x** | **4.3x** |
| sort | repetitive 10MB | 0.0481s | 0.0112s | 0.0394s | **4.3x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0570s | 0.0118s | 0.0354s | **4.8x** | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0016s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0091s | 0.0045s | 0.0068s | **2.0x** | **1.5x** |
| tr | -d digits 10MB | 0.0110s | 0.0054s | 0.0104s | **2.0x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0070s | 0.0174s | **2.7x** | **2.5x** |
| tr | -s spaces 10MB | 0.0168s | 0.0048s | 0.0115s | **3.5x** | **2.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0091s | 0.0047s | 0.0071s | **1.9x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0055s | 0.0103s | **2.0x** | **1.9x** |
| tr | translate binary 10MB | 0.0095s | 0.0054s | 0.0077s | **1.8x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0097s | 0.0020s | 0.0092s | **5.0x** | **4.7x** |
| uniq | default 10MB sorted (low dup) | 0.0170s | 0.0028s | 0.0104s | **6.1x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0018s | 0.0092s | **5.2x** | **5.0x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0076s | 0.0121s | **3.9x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0097s | 0.0019s | 0.0092s | **5.0x** | **4.8x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0019s | 0.0092s | **4.9x** | **4.7x** |
| uniq | -i case insensitive 10MB | 0.0170s | 0.0043s | 0.0103s | **4.0x** | **2.4x** |
| uniq | repetitive 10MB | 0.0491s | 0.0034s | 0.0164s | **14.3x** | **4.8x** |
| tac | reverse 100KB text | 0.0009s | 0.0013s | 0.0012s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0018s | 0.0016s | 0.0017s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0086s | 0.0046s | 0.0050s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0869s | 0.0252s | 0.0461s | **3.4x** | **1.8x** |
| tac | reverse CSV 10MB | 0.0089s | 0.0046s | 0.0047s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0198s | 0.0101s | 0.0095s | **2.0x** | **0.9x** |
| tac | custom separator 1MB | 0.0046s | 0.0038s | 0.0041s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0031s | 0.0041s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0547s | 0.0033s | 0.0314s | **16.8x** | **9.6x** |
| wc | default 100MB text | 0.4830s | 0.0144s | 0.2652s | **33.6x** | **18.4x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0546s | 0.0107s | 0.0260s | **5.1x** | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0547s | 0.0031s | 0.0020s | **17.7x** | **0.7x** |
| wc | -L 10MB text | 0.0547s | 0.0102s | 0.0169s | **5.4x** | **1.7x** |
| wc | default 10MB binary | 0.3173s | 0.0276s | 0.1566s | **11.5x** | **5.7x** |
| wc | default 10MB repetitive | 0.0730s | 0.0047s | 0.0420s | **15.5x** | **8.9x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0036s | 0.0074s | **6.3x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0035s | 0.0074s | **6.5x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0050s | 0.0086s | **3.3x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0071s | 0.0184s | **3.1x** | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0053s | 0.0137s | **4.6x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0310s | 0.0054s | 0.0165s | **5.7x** | **3.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.1x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0027s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0035s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0085s | 0.0101s | 0.0085s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0104s | 0.0089s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0755s | 0.0748s | 0.0751s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0027s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0175s | 0.0180s | 0.0217s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0182s | 0.0190s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1612s | 0.1532s | 0.2032s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0034s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0129s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0157s | 0.0133s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1429s | 0.1122s | 0.1133s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0126s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0128s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0021s | 0.0018s | 0.0018s | **1.2x** | **1.0x** |
| base64 | encode 10MB text | 0.0123s | 0.0044s | 0.0082s | **2.8x** | **1.9x** |
| base64 | encode 10MB binary | 0.0129s | 0.0045s | 0.0086s | **2.8x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0043s | **1.8x** | **1.9x** |
| base64 | decode 10MB | 0.0326s | 0.0049s | 0.0337s | **6.7x** | **7.0x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0046s | 0.0086s | **2.7x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0043s | 0.0076s | **2.0x** | **1.8x** |
| sort | lexicographic 1MB | 0.0086s | 0.0035s | 0.0055s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0546s | 0.0091s | 0.0366s | **6.0x** | **4.0x** |
| sort | already sorted 10MB | 0.0265s | 0.0049s | 0.0188s | **5.4x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0064s | 0.0180s | **4.3x** | **2.8x** |
| sort | -n numeric 10MB | 0.0739s | 0.0056s | 0.0760s | **13.2x** | **13.6x** |
| sort | -r reverse 10MB | 0.0553s | 0.0096s | 0.0362s | **5.7x** | **3.8x** |
| sort | -u unique 10MB | 0.0581s | 0.0093s | 0.0405s | **6.3x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0669s | 0.0200s | 0.0836s | **3.3x** | **4.2x** |
| sort | repetitive 10MB | 0.0551s | 0.0128s | 0.0370s | **4.3x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0546s | 0.0095s | 0.0363s | **5.8x** | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0039s | 0.0078s | **3.2x** | **2.0x** |
| tr | -d digits 10MB | 0.0174s | 0.0044s | 0.0133s | **4.0x** | **3.0x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0050s | 0.0210s | **6.0x** | **4.2x** |
| tr | -s spaces 10MB | 0.0268s | 0.0039s | 0.0283s | **6.8x** | **7.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0124s | 0.0036s | 0.0073s | **3.4x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0159s | 0.0043s | 0.0138s | **3.7x** | **3.2x** |
| tr | translate binary 10MB | 0.0116s | 0.0038s | 0.0081s | **3.0x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0019s | 0.0122s | **6.3x** | **6.4x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0030s | 0.0133s | **4.7x** | **4.4x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | 0.0122s | **6.5x** | **6.6x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0079s | 0.0156s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0019s | 0.0121s | **6.4x** | **6.4x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0019s | 0.0122s | **6.3x** | **6.3x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0047s | 0.0133s | **3.0x** | **2.9x** |
| uniq | repetitive 10MB | 0.0422s | 0.0036s | 0.0178s | **11.7x** | **4.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0106s | 0.0046s | 0.0058s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1048s | 0.0273s | 0.0523s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0048s | 0.0056s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0099s | 0.0110s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0060s | 0.0043s | 0.0053s | **1.4x** | **1.2x** |
