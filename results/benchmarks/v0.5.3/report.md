# fcoreutils v0.5.3 — Detailed Results

Generated: 2026-02-16 09:50:00 UTC

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
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0026s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0345s | 0.0069s | 0.0259s | **5.0x** | **3.7x** |
| wc | default 100MB text | 0.3006s | 0.0465s | 0.2281s | **6.5x** | **4.9x** |
| wc | -l 10MB text | 0.0044s | 0.0023s | 0.0028s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0344s | 0.0064s | 0.0236s | **5.4x** | **3.7x** |
| wc | -c 10MB text | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | -m 10MB text | 0.0345s | 0.0024s | 0.0031s | **14.2x** | **1.3x** |
| wc | -L 10MB text | 0.0347s | 0.0067s | 0.0180s | **5.2x** | **2.7x** |
| wc | default 10MB binary | 0.2349s | 0.0175s | 0.1182s | **13.4x** | **6.8x** |
| wc | default 10MB repetitive | 0.0537s | 0.0083s | 0.0378s | **6.5x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| wc | 100 files | 0.0012s | 0.0012s | 0.0015s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0190s | 0.0034s | 0.0065s | **5.5x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0188s | 0.0034s | 0.0067s | **5.5x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0044s | 0.0080s | **4.3x** | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0046s | 0.0167s | **4.7x** | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0236s | 0.0041s | 0.0131s | **5.8x** | **3.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0268s | 0.0042s | 0.0164s | **6.4x** | **3.9x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0025s | 0.0018s | **1.4x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0007s | 0.0008s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0024s | 0.0035s | 0.0044s | **0.7x** | **1.3x** |
| sha256sum | single 10MB text | 0.0081s | 0.0091s | 0.0277s | **0.9x** | **3.0x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0096s | 0.0291s | **0.9x** | **3.0x** |
| sha256sum | single 100MB text | 0.0699s | 0.0493s | 0.2634s | **1.4x** | **5.3x** |
| sha256sum | 10 files | 0.0012s | 0.0020s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0023s | 0.0019s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0037s | 0.0029s | **0.8x** | **0.8x** |
| md5sum | single 10MB text | 0.0214s | 0.0180s | 0.0179s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0226s | 0.0190s | 0.0190s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2018s | 0.1367s | 0.1670s | **1.5x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0022s | 0.0018s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0145s | 0.0142s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0149s | 0.0150s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1363s | 0.1187s | 0.1300s | **1.1x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0145s | 0.0141s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0140s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0018s | 0.0018s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0011s | **1.0x** | **1.1x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0103s | 0.0040s | 0.0076s | **2.6x** | **1.9x** |
| base64 | encode 10MB binary | 0.0109s | 0.0041s | 0.0083s | **2.7x** | **2.0x** |
| base64 | decode 1MB | 0.0039s | 0.0016s | 0.0037s | **2.5x** | **2.3x** |
| base64 | decode 10MB | 0.0312s | 0.0043s | 0.0273s | **7.2x** | **6.3x** |
| base64 | encode -w 76 10MB | 0.0104s | 0.0038s | 0.0079s | **2.7x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0081s | 0.0032s | 0.0077s | **2.5x** | **2.4x** |
| sort | lexicographic 1MB | 0.0078s | 0.0036s | 0.0046s | **2.2x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0542s | 0.0112s | 0.0337s | **4.8x** | **3.0x** |
| sort | already sorted 10MB | 0.0257s | 0.0038s | 0.0143s | **6.8x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0254s | 0.0051s | 0.0146s | **5.0x** | **2.9x** |
| sort | -n numeric 10MB | 0.0712s | 0.0041s | 0.0681s | **17.5x** | **16.7x** |
| sort | -r reverse 10MB | 0.0538s | 0.0107s | 0.0333s | **5.0x** | **3.1x** |
| sort | -u unique 10MB | 0.0571s | 0.0125s | 0.0404s | **4.6x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0743s | 0.0170s | 0.0762s | **4.4x** | **4.5x** |
| sort | repetitive 10MB | 0.0477s | 0.0111s | 0.0387s | **4.3x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0537s | 0.0107s | 0.0336s | **5.0x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0020s | 0.0019s | **1.0x** | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0078s | 0.0071s | **1.2x** | **0.9x** |
| tr | -d digits 10MB | 0.0112s | 0.0072s | 0.0103s | **1.6x** | **1.4x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0091s | 0.0170s | **2.1x** | **1.9x** |
| tr | -s spaces 10MB | 0.0166s | 0.0075s | 0.0114s | **2.2x** | **1.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0080s | 0.0068s | **1.1x** | **0.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0071s | 0.0103s | **1.6x** | **1.5x** |
| tr | translate binary 10MB | 0.0093s | 0.0082s | 0.0077s | **1.1x** | **0.9x** |
| uniq | default 10MB many duplicates | 0.0095s | 0.0018s | 0.0090s | **5.3x** | **5.0x** |
| uniq | default 10MB sorted (low dup) | 0.0170s | 0.0028s | 0.0102s | **6.1x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0096s | 0.0019s | 0.0090s | **5.0x** | **4.7x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0072s | 0.0119s | **4.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0018s | 0.0090s | **5.5x** | **5.1x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0018s | 0.0091s | **5.4x** | **5.1x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0040s | 0.0101s | **4.2x** | **2.5x** |
| uniq | repetitive 10MB | 0.0489s | 0.0032s | 0.0161s | **15.2x** | **5.0x** |
| tac | reverse 100KB text | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0016s | **1.2x** | **1.0x** |
| tac | reverse 10MB text | 0.0092s | 0.0033s | 0.0051s | **2.8x** | **1.6x** |
| tac | reverse 100MB text | 0.0863s | 0.0181s | 0.0455s | **4.8x** | **2.5x** |
| tac | reverse CSV 10MB | 0.0086s | 0.0027s | 0.0047s | **3.2x** | **1.7x** |
| tac | reverse repetitive 10MB | 0.0196s | 0.0051s | 0.0092s | **3.8x** | **1.8x** |
| tac | custom separator 1MB | 0.0045s | 0.0036s | 0.0041s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0030s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0546s | 0.0032s | 0.0306s | **16.9x** | **9.4x** |
| wc | default 100MB text | 0.4836s | 0.0157s | 0.2574s | **30.7x** | **16.3x** |
| wc | -l 10MB text | 0.0025s | 0.0028s | 0.0023s | **0.9x** | **0.8x** |
| wc | -w 10MB text | 0.0544s | 0.0092s | 0.0262s | **5.9x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0547s | 0.0031s | 0.0026s | **17.7x** | **0.9x** |
| wc | -L 10MB text | 0.0546s | 0.0098s | 0.0198s | **5.6x** | **2.0x** |
| wc | default 10MB binary | 0.3176s | 0.0285s | 0.1538s | **11.2x** | **5.4x** |
| wc | default 10MB repetitive | 0.0733s | 0.0047s | 0.0401s | **15.6x** | **8.6x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0229s | 0.0036s | 0.0074s | **6.4x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0036s | 0.0073s | **6.4x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0167s | 0.0048s | 0.0090s | **3.5x** | **1.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0225s | 0.0072s | 0.0178s | **3.1x** | **2.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0243s | 0.0051s | 0.0137s | **4.8x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0310s | 0.0050s | 0.0165s | **6.1x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0025s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0021s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0086s | 0.0106s | 0.0090s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0104s | 0.0089s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0756s | 0.0665s | 0.0758s | **1.1x** | **1.1x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0026s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0039s | 0.0033s | **0.8x** | **0.8x** |
| md5sum | single 10MB text | 0.0175s | 0.0183s | 0.0217s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0182s | 0.0192s | 0.0227s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1617s | 0.1444s | 0.2040s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **1.0x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0125s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0159s | 0.0132s | 0.0132s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1438s | 0.1112s | 0.1143s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0125s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0153s | 0.0127s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | 0.0019s | **1.5x** | **1.4x** |
| base64 | encode 10MB text | 0.0127s | 0.0046s | 0.0084s | **2.8x** | **1.8x** |
| base64 | encode 10MB binary | 0.0127s | 0.0046s | 0.0086s | **2.7x** | **1.9x** |
| base64 | decode 1MB | 0.0040s | 0.0013s | 0.0043s | **3.0x** | **3.2x** |
| base64 | decode 10MB | 0.0328s | 0.0050s | 0.0343s | **6.5x** | **6.8x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0047s | 0.0084s | **2.6x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0038s | 0.0076s | **2.3x** | **2.0x** |
| sort | lexicographic 1MB | 0.0089s | 0.0036s | 0.0055s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0552s | 0.0104s | 0.0370s | **5.3x** | **3.5x** |
| sort | already sorted 10MB | 0.0270s | 0.0050s | 0.0188s | **5.4x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0278s | 0.0064s | 0.0184s | **4.4x** | **2.9x** |
| sort | -n numeric 10MB | 0.0745s | 0.0056s | 0.0819s | **13.2x** | **14.5x** |
| sort | -r reverse 10MB | 0.0564s | 0.0096s | 0.0369s | **5.9x** | **3.9x** |
| sort | -u unique 10MB | 0.0604s | 0.0104s | 0.0426s | **5.8x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0668s | 0.0202s | 0.0837s | **3.3x** | **4.1x** |
| sort | repetitive 10MB | 0.0557s | 0.0126s | 0.0372s | **4.4x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0553s | 0.0088s | 0.0360s | **6.3x** | **4.1x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0022s | 0.0021s | **1.1x** | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0130s | 0.0110s | 0.0075s | **1.2x** | **0.7x** |
| tr | -d digits 10MB | 0.0161s | 0.0090s | 0.0141s | **1.8x** | **1.6x** |
| tr | -d lowercase 10MB | 0.0309s | 0.0120s | 0.0232s | **2.6x** | **1.9x** |
| tr | -s spaces 10MB | 0.0267s | 0.0100s | 0.0273s | **2.7x** | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0138s | 0.0109s | 0.0077s | **1.3x** | **0.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0176s | 0.0092s | 0.0145s | **1.9x** | **1.6x** |
| tr | translate binary 10MB | 0.0119s | 0.0110s | 0.0082s | **1.1x** | **0.7x** |
| uniq | default 10MB many duplicates | 0.0124s | 0.0021s | 0.0118s | **6.0x** | **5.7x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0033s | 0.0138s | **4.3x** | **4.2x** |
| uniq | -c count 10MB many dups | 0.0122s | 0.0019s | 0.0116s | **6.3x** | **6.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0080s | 0.0158s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0019s | 0.0113s | **6.3x** | **6.0x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0020s | 0.0114s | **6.1x** | **5.6x** |
| uniq | -i case insensitive 10MB | 0.0143s | 0.0047s | 0.0138s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0423s | 0.0037s | 0.0163s | **11.4x** | **4.4x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0109s | 0.0038s | 0.0057s | **2.9x** | **1.5x** |
| tac | reverse 100MB text | 0.1045s | 0.0226s | 0.0531s | **4.6x** | **2.4x** |
| tac | reverse CSV 10MB | 0.0097s | 0.0034s | 0.0057s | **2.9x** | **1.7x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0064s | 0.0114s | **3.7x** | **1.8x** |
| tac | custom separator 1MB | 0.0062s | 0.0045s | 0.0053s | **1.4x** | **1.2x** |
