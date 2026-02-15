# fcoreutils v0.1.2 — Detailed Results

Generated: 2026-02-15 17:10:32 UTC

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
| wc | default 1MB text | 0.0037s | 0.0024s | 0.0032s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0069s | 0.0254s | **5.0x** | **3.7x** |
| wc | default 100MB text | 0.3013s | 0.0475s | 0.2221s | **6.3x** | **4.7x** |
| wc | -l 10MB text | 0.0043s | 0.0022s | 0.0028s | **1.9x** | **1.2x** |
| wc | -w 10MB text | 0.0344s | 0.0061s | 0.0215s | **5.6x** | **3.5x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0011s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0344s | 0.0024s | 0.0026s | **14.4x** | **1.1x** |
| wc | -L 10MB text | 0.0343s | 0.0059s | 0.0175s | **5.8x** | **3.0x** |
| wc | default 10MB binary | 0.2349s | 0.0171s | 0.1146s | **13.7x** | **6.7x** |
| wc | default 10MB repetitive | 0.0539s | 0.0082s | 0.0371s | **6.6x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0014s | 0.0015s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0034s | 0.0063s | **5.5x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0041s | 0.0066s | **4.7x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0046s | 0.0074s | **4.1x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0046s | 0.0164s | **4.6x** | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0036s | 0.0123s | **6.5x** | **3.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0033s | 0.0162s | **8.1x** | **5.0x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0020s | 0.0016s | **1.8x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0079s | 0.0074s | 0.0272s | **1.1x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0074s | 0.0284s | **1.0x** | **3.8x** |
| sha256sum | single 100MB text | 0.0693s | 0.0559s | 0.2635s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0010s | 0.0018s | 0.0010s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | 0.0016s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0034s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0211s | 0.0161s | 0.0169s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0220s | 0.0169s | 0.0182s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2011s | 0.1445s | 0.1670s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0019s | 0.0011s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0016s | 0.0024s | 0.0016s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | 0.0023s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0139s | 0.0124s | 0.0136s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0149s | 0.0132s | 0.0146s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1371s | 0.1184s | 0.1313s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0145s | 0.0128s | 0.0143s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0126s | 0.0140s | **1.2x** | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0016s | 0.0018s | **1.1x** | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0100s | 0.0053s | 0.0073s | **1.9x** | **1.4x** |
| base64 | encode 10MB binary | 0.0108s | 0.0056s | 0.0078s | **1.9x** | **1.4x** |
| base64 | decode 1MB | 0.0037s | 0.0020s | 0.0035s | **1.9x** | **1.8x** |
| base64 | decode 10MB | 0.0308s | 0.0113s | 0.0262s | **2.7x** | **2.3x** |
| base64 | encode -w 76 10MB | 0.0097s | 0.0053s | 0.0071s | **1.8x** | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0045s | 0.0072s | **1.6x** | **1.6x** |
| sort | lexicographic 1MB | 0.0075s | 0.0038s | 0.0040s | **2.0x** | **1.1x** |
| sort | lexicographic 10MB random | 0.0513s | 0.0065s | 0.0329s | **7.9x** | **5.1x** |
| sort | already sorted 10MB | 0.0256s | 0.0040s | 0.0141s | **6.4x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0250s | 0.0049s | 0.0139s | **5.1x** | **2.9x** |
| sort | -n numeric 10MB | 0.0703s | 0.0039s | 0.0647s | **18.0x** | **16.6x** |
| sort | -r reverse 10MB | 0.0525s | 0.0065s | 0.0286s | **8.1x** | **4.4x** |
| sort | -u unique 10MB | 0.0535s | 0.0093s | 0.0329s | **5.8x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0710s | 0.0434s | 0.0699s | **1.6x** | **1.6x** |
| sort | repetitive 10MB | 0.0445s | 0.0103s | 0.0358s | **4.3x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0502s | 0.0063s | 0.0281s | **8.0x** | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0028s | 0.0018s | **0.6x** | **0.6x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0192s | 0.0068s | **0.5x** | **0.4x** |
| tr | -d digits 10MB | 0.0111s | 0.0134s | 0.0105s | **0.8x** | **0.8x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0206s | 0.0170s | **0.9x** | **0.8x** |
| tr | -s spaces 10MB | 0.0167s | 0.0073s | 0.0114s | **2.3x** | **1.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0197s | 0.0068s | **0.5x** | **0.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0136s | 0.0107s | **0.8x** | **0.8x** |
| tr | translate binary 10MB | 0.0091s | 0.0177s | 0.0079s | **0.5x** | **0.4x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0028s | 0.0089s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0031s | 0.0103s | **5.5x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0027s | 0.0091s | **3.4x** | **3.3x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0050s | 0.0121s | **6.0x** | **2.4x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0028s | 0.0089s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0028s | 0.0088s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0168s | 0.0041s | 0.0100s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0474s | 0.0038s | 0.0145s | **12.6x** | **3.9x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.8x** | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | 0.0015s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0084s | 0.0044s | 0.0049s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0861s | 0.0389s | 0.0432s | **2.2x** | **1.1x** |
| tac | reverse CSV 10MB | 0.0078s | 0.0039s | 0.0044s | **2.0x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0076s | 0.0083s | **2.2x** | **1.1x** |
| tac | custom separator 1MB | 0.0043s | 0.0029s | 0.0037s | **1.5x** | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0044s | **2.0x** | **1.6x** |
| wc | default 10MB text | 0.0550s | 0.0031s | 0.0369s | **17.6x** | **11.8x** |
| wc | default 100MB text | 0.4848s | 0.0157s | 0.3155s | **30.8x** | **20.1x** |
| wc | -l 10MB text | 0.0023s | 0.0026s | 0.0020s | **0.9x** | **0.8x** |
| wc | -w 10MB text | 0.0542s | 0.0089s | 0.0273s | **6.1x** | **3.1x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0550s | 0.0032s | 0.0021s | **17.1x** | **0.6x** |
| wc | -L 10MB text | 0.0547s | 0.0113s | 0.0165s | **4.8x** | **1.5x** |
| wc | default 10MB binary | 0.3171s | 0.0270s | 0.1593s | **11.7x** | **5.9x** |
| wc | default 10MB repetitive | 0.0733s | 0.0047s | 0.0529s | **15.7x** | **11.3x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0020s | 0.0024s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0053s | 0.0073s | **4.3x** | **1.4x** |
| cut | -c1-100 10MB CSV | 0.0228s | 0.0053s | 0.0074s | **4.3x** | **1.4x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0055s | 0.0089s | **3.1x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0270s | 0.0061s | 0.0182s | **4.4x** | **3.0x** |
| cut | -d, -f2-4 10MB CSV | 0.0244s | 0.0052s | 0.0141s | **4.7x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0310s | 0.0046s | 0.0171s | **6.8x** | **3.7x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0097s | 0.0090s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0101s | 0.0090s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0759s | 0.0761s | 0.0759s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0031s | 0.0024s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0038s | 0.0033s | **0.7x** | **0.9x** |
| md5sum | single 10MB text | 0.0179s | 0.0177s | 0.0219s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0187s | 0.0183s | 0.0226s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1619s | 0.1537s | 0.2042s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0015s | 0.0025s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0011s | 0.0013s | 0.0014s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0023s | 0.0025s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0151s | 0.0124s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0159s | 0.0127s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1436s | 0.1125s | 0.1139s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0126s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0122s | 0.0131s | **1.2x** | **1.1x** |
| b2sum | 100 files | 0.0022s | 0.0018s | 0.0023s | **1.2x** | **1.3x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | 0.0020s | **1.3x** | **1.2x** |
| base64 | encode 10MB text | 0.0123s | 0.0057s | 0.0083s | **2.2x** | **1.5x** |
| base64 | encode 10MB binary | 0.0131s | 0.0064s | 0.0086s | **2.0x** | **1.3x** |
| base64 | decode 1MB | 0.0040s | 0.0020s | 0.0043s | **2.0x** | **2.1x** |
| base64 | decode 10MB | 0.0335s | 0.0112s | 0.0341s | **3.0x** | **3.0x** |
| base64 | encode -w 76 10MB | 0.0125s | 0.0059s | 0.0081s | **2.1x** | **1.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0042s | 0.0078s | **2.1x** | **1.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0046s | 0.0055s | **1.9x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0543s | 0.0098s | 0.0365s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0274s | 0.0054s | 0.0185s | **5.1x** | **3.4x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0076s | 0.0183s | **3.7x** | **2.4x** |
| sort | -n numeric 10MB | 0.0743s | 0.0058s | 0.0763s | **12.8x** | **13.2x** |
| sort | -r reverse 10MB | 0.0544s | 0.0104s | 0.0363s | **5.2x** | **3.5x** |
| sort | -u unique 10MB | 0.0581s | 0.0116s | 0.0408s | **5.0x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0678s | 0.0449s | 0.0832s | **1.5x** | **1.9x** |
| sort | repetitive 10MB | 0.0554s | 0.0123s | 0.0378s | **4.5x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0549s | 0.0095s | 0.0365s | **5.8x** | **3.8x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0018s | 0.0028s | **1.3x** | **1.6x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0071s | 0.0078s | **1.8x** | **1.1x** |
| tr | -d digits 10MB | 0.0175s | 0.0134s | 0.0140s | **1.3x** | **1.0x** |
| tr | -d lowercase 10MB | 0.0289s | 0.0131s | 0.0217s | **2.2x** | **1.6x** |
| tr | -s spaces 10MB | 0.0274s | 0.0070s | 0.0285s | **3.9x** | **4.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0140s | 0.0063s | 0.0075s | **2.2x** | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0182s | 0.0133s | 0.0138s | **1.4x** | **1.0x** |
| tr | translate binary 10MB | 0.0124s | 0.0070s | 0.0081s | **1.8x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0036s | 0.0115s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0038s | 0.0129s | **3.7x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0125s | 0.0037s | 0.0112s | **3.4x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0067s | 0.0156s | **4.4x** | **2.3x** |
| uniq | -d duplicates only 10MB | 0.0124s | 0.0036s | 0.0114s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0122s | 0.0035s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0049s | 0.0134s | **2.9x** | **2.7x** |
| uniq | repetitive 10MB | 0.0424s | 0.0044s | 0.0168s | **9.6x** | **3.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0111s | 0.0052s | 0.0059s | **2.1x** | **1.1x** |
| tac | reverse 100MB text | 0.1045s | 0.0416s | 0.0528s | **2.5x** | **1.3x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0047s | 0.0059s | **2.0x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0236s | 0.0098s | 0.0112s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0061s | 0.0033s | 0.0053s | **1.8x** | **1.6x** |
