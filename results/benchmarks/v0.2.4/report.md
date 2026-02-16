# fcoreutils v0.2.4 — Detailed Results

Generated: 2026-02-16 14:33:04 UTC

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
| wc | default 1MB text | 0.0039s | 0.0028s | 0.0034s | **1.4x** | **1.2x** |
| wc | default 10MB text | 0.0342s | 0.0063s | 0.0257s | **5.4x** | **4.1x** |
| wc | default 100MB text | 0.2962s | 0.0443s | 0.2242s | **6.7x** | **5.1x** |
| wc | -l 10MB text | 0.0044s | 0.0022s | 0.0030s | **2.0x** | **1.4x** |
| wc | -w 10MB text | 0.0343s | 0.0066s | 0.0233s | **5.2x** | **3.5x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0342s | 0.0023s | 0.0028s | **14.9x** | **1.2x** |
| wc | -L 10MB text | 0.0343s | 0.0062s | 0.0175s | **5.5x** | **2.8x** |
| wc | default 10MB binary | 0.2347s | 0.0170s | 0.1177s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0527s | 0.0081s | 0.0375s | **6.5x** | **4.7x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0015s | 0.0016s | **0.8x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0039s | 0.0066s | **4.8x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0188s | 0.0037s | 0.0062s | **5.0x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0043s | 0.0071s | **4.4x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0050s | 0.0168s | **4.3x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0034s | 0.0127s | **6.8x** | **3.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0032s | 0.0163s | **8.2x** | **5.0x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0022s | 0.0017s | **1.6x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0011s | 0.0020s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0074s | 0.0073s | 0.0273s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0079s | 0.0074s | 0.0286s | **1.1x** | **3.9x** |
| sha256sum | single 100MB text | 0.0660s | 0.0552s | 0.2599s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0018s | 0.0012s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0017s | 0.0021s | 0.0017s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0023s | 0.0015s | **0.6x** | **0.7x** |
| md5sum | single 1MB text | 0.0031s | 0.0036s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0212s | 0.0163s | 0.0177s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0221s | 0.0169s | 0.0184s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.1976s | 0.1426s | 0.1631s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0011s | 0.0019s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0017s | 0.0021s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0142s | 0.0123s | 0.0139s | **1.2x** | **1.1x** |
| b2sum | single 10MB binary | 0.0149s | 0.0129s | 0.0145s | **1.2x** | **1.1x** |
| b2sum | single 100MB text | 0.1321s | 0.1131s | 0.1259s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0141s | 0.0123s | 0.0140s | **1.2x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0123s | 0.0136s | **1.2x** | **1.1x** |
| b2sum | 100 files | 0.0015s | 0.0017s | 0.0016s | **0.9x** | **0.9x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0097s | 0.0034s | 0.0072s | **2.8x** | **2.1x** |
| base64 | encode 10MB binary | 0.0101s | 0.0034s | 0.0076s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0037s | 0.0017s | 0.0035s | **2.2x** | **2.1x** |
| base64 | decode 10MB | 0.0307s | 0.0057s | 0.0270s | **5.4x** | **4.7x** |
| base64 | encode -w 76 10MB | 0.0097s | 0.0033s | 0.0072s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0075s | 0.0032s | 0.0072s | **2.3x** | **2.3x** |
| sort | lexicographic 1MB | 0.0075s | 0.0026s | 0.0042s | **2.9x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0513s | 0.0065s | 0.0292s | **7.9x** | **4.5x** |
| sort | already sorted 10MB | 0.0253s | 0.0035s | 0.0138s | **7.1x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0045s | 0.0137s | **5.5x** | **3.0x** |
| sort | -n numeric 10MB | 0.0688s | 0.0039s | 0.0639s | **17.6x** | **16.3x** |
| sort | -r reverse 10MB | 0.0514s | 0.0063s | 0.0307s | **8.2x** | **4.9x** |
| sort | -u unique 10MB | 0.0539s | 0.0085s | 0.0355s | **6.4x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0697s | 0.0149s | 0.0683s | **4.7x** | **4.6x** |
| sort | repetitive 10MB | 0.0459s | 0.0104s | 0.0378s | **4.4x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0503s | 0.0063s | 0.0289s | **8.0x** | **4.6x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0015s | 0.0018s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0046s | 0.0067s | **2.0x** | **1.5x** |
| tr | -d digits 10MB | 0.0109s | 0.0052s | 0.0102s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0069s | 0.0169s | **2.7x** | **2.4x** |
| tr | -s spaces 10MB | 0.0164s | 0.0042s | 0.0113s | **3.9x** | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0041s | 0.0066s | **2.2x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0052s | 0.0102s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0091s | 0.0044s | 0.0075s | **2.0x** | **1.7x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0028s | 0.0087s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0166s | 0.0031s | 0.0099s | **5.3x** | **3.2x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0031s | 0.0089s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0070s | 0.0118s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0026s | 0.0089s | **3.5x** | **3.4x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0088s | **3.4x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0041s | 0.0097s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0486s | 0.0036s | 0.0152s | **13.6x** | **4.3x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0020s | 0.0015s | **0.8x** | **0.7x** |
| tac | reverse 10MB text | 0.0085s | 0.0037s | 0.0049s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.0817s | 0.0224s | 0.0426s | **3.6x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0038s | 0.0045s | **2.1x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0190s | 0.0068s | 0.0086s | **2.8x** | **1.3x** |
| tac | custom separator 1MB | 0.0043s | 0.0032s | 0.0038s | **1.3x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0544s | 0.0031s | 0.0298s | **17.8x** | **9.7x** |
| wc | default 100MB text | 0.4831s | 0.0139s | 0.2560s | **34.8x** | **18.4x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0547s | 0.0107s | 0.0255s | **5.1x** | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0542s | 0.0030s | 0.0020s | **18.1x** | **0.7x** |
| wc | -L 10MB text | 0.0542s | 0.0100s | 0.0195s | **5.4x** | **1.9x** |
| wc | default 10MB binary | 0.3151s | 0.0272s | 0.1548s | **11.6x** | **5.7x** |
| wc | default 10MB repetitive | 0.0731s | 0.0045s | 0.0397s | **16.3x** | **8.9x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0040s | 0.0073s | **5.6x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0041s | 0.0072s | **5.5x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0050s | 0.0085s | **3.3x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0066s | 0.0175s | **3.3x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0052s | 0.0133s | **4.6x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0303s | 0.0046s | 0.0164s | **6.6x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0026s | 0.0020s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0095s | 0.0083s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0099s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0747s | 0.0752s | 0.0747s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0169s | 0.0173s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0180s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1608s | 0.1532s | 0.2030s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0121s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0155s | 0.0126s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1430s | 0.1131s | 0.1119s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0147s | 0.0122s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0122s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0015s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0122s | 0.0048s | 0.0081s | **2.5x** | **1.7x** |
| base64 | encode 10MB binary | 0.0127s | 0.0051s | 0.0083s | **2.5x** | **1.6x** |
| base64 | decode 1MB | 0.0040s | 0.0015s | 0.0043s | **2.7x** | **3.0x** |
| base64 | decode 10MB | 0.0323s | 0.0058s | 0.0336s | **5.6x** | **5.8x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0047s | 0.0081s | **2.6x** | **1.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0039s | 0.0071s | **2.2x** | **1.8x** |
| sort | lexicographic 1MB | 0.0086s | 0.0032s | 0.0054s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0540s | 0.0093s | 0.0353s | **5.8x** | **3.8x** |
| sort | already sorted 10MB | 0.0259s | 0.0042s | 0.0173s | **6.2x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0271s | 0.0066s | 0.0177s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0729s | 0.0057s | 0.0753s | **12.9x** | **13.3x** |
| sort | -r reverse 10MB | 0.0542s | 0.0095s | 0.0355s | **5.7x** | **3.7x** |
| sort | -u unique 10MB | 0.0570s | 0.0096s | 0.0394s | **5.9x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0669s | 0.0190s | 0.0814s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0550s | 0.0116s | 0.0365s | **4.8x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0538s | 0.0095s | 0.0355s | **5.7x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0022s | 0.0015s | 0.0019s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0123s | 0.0038s | 0.0073s | **3.3x** | **1.9x** |
| tr | -d digits 10MB | 0.0159s | 0.0044s | 0.0143s | **3.7x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0311s | 0.0050s | 0.0227s | **6.2x** | **4.6x** |
| tr | -s spaces 10MB | 0.0267s | 0.0037s | 0.0271s | **7.2x** | **7.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0123s | 0.0038s | 0.0072s | **3.3x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0164s | 0.0044s | 0.0139s | **3.8x** | **3.2x** |
| tr | translate binary 10MB | 0.0119s | 0.0038s | 0.0081s | **3.2x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0035s | 0.0112s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0138s | 0.0036s | 0.0134s | **3.8x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0035s | 0.0116s | **3.4x** | **3.3x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0095s | 0.0161s | **3.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0040s | 0.0116s | **3.1x** | **2.9x** |
| uniq | -u unique only 10MB | 0.0122s | 0.0038s | 0.0117s | **3.2x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0049s | 0.0138s | **2.9x** | **2.8x** |
| uniq | repetitive 10MB | 0.0425s | 0.0042s | 0.0168s | **10.2x** | **4.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0025s | 0.0018s | **0.8x** | **0.7x** |
| tac | reverse 10MB text | 0.0110s | 0.0046s | 0.0061s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1057s | 0.0285s | 0.0520s | **3.7x** | **1.8x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0047s | 0.0057s | **2.0x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0230s | 0.0085s | 0.0113s | **2.7x** | **1.3x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | 0.0054s | **1.4x** | **1.3x** |
