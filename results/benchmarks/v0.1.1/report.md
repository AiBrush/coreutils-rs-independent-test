# fcoreutils v0.1.1 — Detailed Results

Generated: 2026-02-14 17:30:02 UTC

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
| wc | default 1MB text | 0.0039s | 0.0026s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0345s | 0.0067s | 0.0254s | **5.1x** | **3.8x** |
| wc | default 100MB text | 0.2999s | 0.0463s | 0.2226s | **6.5x** | **4.8x** |
| wc | -l 10MB text | 0.0043s | 0.0022s | 0.0028s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0344s | 0.0064s | 0.0215s | **5.4x** | **3.4x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0345s | 0.0023s | 0.0029s | **14.7x** | **1.2x** |
| wc | -L 10MB text | 0.0343s | 0.0064s | 0.0174s | **5.4x** | **2.7x** |
| wc | default 10MB binary | 0.2361s | 0.0169s | 0.1141s | **14.0x** | **6.8x** |
| wc | default 10MB repetitive | 0.0540s | 0.0082s | 0.0376s | **6.6x** | **4.6x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0012s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0017s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0037s | 0.0066s | **5.1x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0036s | 0.0067s | **5.3x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0043s | 0.0073s | **4.4x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0048s | 0.0167s | **4.4x** | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0042s | 0.0130s | **5.5x** | **3.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0050s | 0.0165s | **5.3x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0022s | 0.0020s | **1.6x** | **0.9x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0028s | 0.0038s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0077s | 0.0075s | 0.0276s | **1.0x** | **3.7x** |
| sha256sum | single 10MB binary | 0.0079s | 0.0077s | 0.0286s | **1.0x** | **3.7x** |
| sha256sum | single 100MB text | 0.0698s | 0.0577s | 0.2639s | **1.2x** | **4.6x** |
| sha256sum | 10 files | 0.0012s | 0.0021s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0025s | 0.0017s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0039s | 0.0028s | **0.8x** | **0.7x** |
| md5sum | single 10MB text | 0.0213s | 0.0163s | 0.0178s | **1.3x** | **1.1x** |
| md5sum | single 10MB binary | 0.0219s | 0.0173s | 0.0184s | **1.3x** | **1.1x** |
| md5sum | single 100MB text | 0.2017s | 0.1448s | 0.1669s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0022s | 0.0012s | **0.5x** | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0026s | 0.0017s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0013s | 0.0013s | **0.7x** | **1.0x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0024s | **0.9x** | **1.0x** |
| b2sum | single 10MB text | 0.0143s | 0.0127s | 0.0141s | **1.1x** | **1.1x** |
| b2sum | single 10MB binary | 0.0146s | 0.0128s | 0.0142s | **1.1x** | **1.1x** |
| b2sum | single 100MB text | 0.1360s | 0.1172s | 0.1302s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0126s | 0.0140s | **1.1x** | **1.1x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0127s | 0.0140s | **1.1x** | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0018s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0018s | 0.0017s | 0.0017s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0102s | 0.0054s | 0.0074s | **1.9x** | **1.4x** |
| base64 | encode 10MB binary | 0.0102s | 0.0056s | 0.0073s | **1.8x** | **1.3x** |
| base64 | decode 1MB | 0.0038s | 0.0019s | 0.0035s | **2.0x** | **1.8x** |
| base64 | decode 10MB | 0.0307s | 0.0109s | 0.0262s | **2.8x** | **2.4x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0055s | 0.0072s | **1.8x** | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0045s | 0.0074s | **1.7x** | **1.6x** |
| sort | lexicographic 1MB | 0.0076s | 0.0038s | 0.0046s | **2.0x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0531s | 0.0105s | 0.0309s | **5.1x** | **2.9x** |
| sort | already sorted 10MB | 0.0256s | 0.0042s | 0.0139s | **6.2x** | **3.3x** |
| sort | reverse sorted 10MB | 0.0255s | 0.0071s | 0.0143s | **3.6x** | **2.0x** |
| sort | -n numeric 10MB | 0.0718s | 0.0041s | 0.0670s | **17.5x** | **16.3x** |
| sort | -r reverse 10MB | 0.0534s | 0.0110s | 0.0317s | **4.9x** | **2.9x** |
| sort | -u unique 10MB | 0.0559s | 0.0143s | 0.0376s | **3.9x** | **2.6x** |
| sort | -t, -k2 CSV 10MB | 0.0732s | 0.0248s | 0.0736s | **3.0x** | **3.0x** |
| sort | repetitive 10MB | 0.0481s | 0.0086s | 0.0384s | **5.6x** | **4.5x** |
| sort | --parallel=4 10MB | 0.0526s | 0.0104s | 0.0314s | **5.1x** | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0030s | 0.0018s | **0.6x** | **0.6x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0202s | 0.0069s | **0.4x** | **0.3x** |
| tr | -d digits 10MB | 0.0110s | 0.0140s | 0.0110s | **0.8x** | **0.8x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0209s | 0.0175s | **0.9x** | **0.8x** |
| tr | -s spaces 10MB | 0.0168s | 0.0076s | 0.0115s | **2.2x** | **1.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0085s | 0.0200s | 0.0068s | **0.4x** | **0.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0138s | 0.0108s | **0.8x** | **0.8x** |
| tr | translate binary 10MB | 0.0089s | 0.0170s | 0.0080s | **0.5x** | **0.5x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0028s | 0.0090s | **3.3x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0033s | 0.0098s | **4.9x** | **2.9x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0053s | 0.0090s | **1.7x** | **1.7x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0068s | 0.0117s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0048s | 0.0091s | **2.0x** | **1.9x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0047s | 0.0089s | **2.0x** | **1.9x** |
| uniq | -i case insensitive 10MB | 0.0165s | 0.0044s | 0.0101s | **3.7x** | **2.3x** |
| uniq | repetitive 10MB | 0.0490s | 0.0036s | 0.0159s | **13.6x** | **4.4x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0017s | 0.0017s | 0.0015s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0089s | 0.0045s | 0.0050s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0866s | 0.0388s | 0.0443s | **2.2x** | **1.1x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0040s | 0.0045s | **2.1x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0194s | 0.0081s | 0.0089s | **2.4x** | **1.1x** |
| tac | custom separator 1MB | 0.0044s | 0.0031s | 0.0038s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0029s | 0.0047s | **2.0x** | **1.6x** |
| wc | default 10MB text | 0.0554s | 0.0033s | 0.0372s | **16.6x** | **11.2x** |
| wc | default 100MB text | 0.4836s | 0.0149s | 0.3149s | **32.5x** | **21.2x** |
| wc | -l 10MB text | 0.0022s | 0.0026s | 0.0022s | **0.9x** | **0.8x** |
| wc | -w 10MB text | 0.0551s | 0.0089s | 0.0273s | **6.2x** | **3.1x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0551s | 0.0032s | 0.0023s | **17.3x** | **0.7x** |
| wc | -L 10MB text | 0.0549s | 0.0114s | 0.0176s | **4.8x** | **1.5x** |
| wc | default 10MB binary | 0.3180s | 0.0270s | 0.1586s | **11.8x** | **5.9x** |
| wc | default 10MB repetitive | 0.0734s | 0.0046s | 0.0530s | **15.9x** | **11.4x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0020s | 0.0024s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0234s | 0.0055s | 0.0078s | **4.2x** | **1.4x** |
| cut | -c1-100 10MB CSV | 0.0230s | 0.0054s | 0.0076s | **4.2x** | **1.4x** |
| cut | -d, -f1 10MB CSV | 0.0170s | 0.0049s | 0.0090s | **3.4x** | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0225s | 0.0075s | 0.0181s | **3.0x** | **2.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0246s | 0.0056s | 0.0137s | **4.4x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0086s | 0.0169s | **3.6x** | **2.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0027s | 0.0021s | **1.3x** | **0.8x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0025s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0021s | 0.0032s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0089s | 0.0097s | 0.0089s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0093s | 0.0101s | 0.0094s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0760s | 0.0766s | 0.0761s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0032s | 0.0024s | **0.8x** | **0.7x** |
| md5sum | single 100KB text | 0.0015s | 0.0026s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0040s | 0.0034s | **0.7x** | **0.9x** |
| md5sum | single 10MB text | 0.0177s | 0.0179s | 0.0221s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0186s | 0.0184s | 0.0229s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1615s | 0.1542s | 0.2037s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0031s | 0.0024s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | 0.0014s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0023s | 0.0024s | 0.0024s | **1.0x** | **1.0x** |
| b2sum | single 10MB text | 0.0156s | 0.0123s | 0.0127s | **1.3x** | **1.0x** |
| b2sum | single 10MB binary | 0.0160s | 0.0129s | 0.0134s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1439s | 0.1128s | 0.1137s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0159s | 0.0127s | 0.0131s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0156s | 0.0123s | 0.0130s | **1.3x** | **1.1x** |
| b2sum | 100 files | 0.0023s | 0.0020s | 0.0024s | **1.2x** | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0022s | 0.0017s | 0.0019s | **1.3x** | **1.1x** |
| base64 | encode 10MB text | 0.0128s | 0.0060s | 0.0088s | **2.1x** | **1.5x** |
| base64 | encode 10MB binary | 0.0137s | 0.0066s | 0.0093s | **2.1x** | **1.4x** |
| base64 | decode 1MB | 0.0042s | 0.0021s | 0.0045s | **2.0x** | **2.1x** |
| base64 | decode 10MB | 0.0332s | 0.0117s | 0.0341s | **2.8x** | **2.9x** |
| base64 | encode -w 76 10MB | 0.0129s | 0.0060s | 0.0088s | **2.2x** | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0094s | 0.0042s | 0.0080s | **2.2x** | **1.9x** |
| sort | lexicographic 1MB | 0.0092s | 0.0047s | 0.0059s | **1.9x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0555s | 0.0121s | 0.0366s | **4.6x** | **3.0x** |
| sort | already sorted 10MB | 0.0266s | 0.0051s | 0.0188s | **5.2x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0280s | 0.0104s | 0.0188s | **2.7x** | **1.8x** |
| sort | -n numeric 10MB | 0.0737s | 0.0058s | 0.0768s | **12.7x** | **13.2x** |
| sort | -r reverse 10MB | 0.0549s | 0.0113s | 0.0371s | **4.9x** | **3.3x** |
| sort | -u unique 10MB | 0.0595s | 0.0148s | 0.0403s | **4.0x** | **2.7x** |
| sort | -t, -k2 CSV 10MB | 0.0678s | 0.0271s | 0.0835s | **2.5x** | **3.1x** |
| sort | repetitive 10MB | 0.0558s | 0.0098s | 0.0382s | **5.7x** | **3.9x** |
| sort | --parallel=4 10MB | 0.0554s | 0.0122s | 0.0363s | **4.6x** | **3.0x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0019s | 0.0020s | **1.3x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0072s | 0.0077s | **1.8x** | **1.1x** |
| tr | -d digits 10MB | 0.0179s | 0.0134s | 0.0142s | **1.3x** | **1.1x** |
| tr | -d lowercase 10MB | 0.0342s | 0.0140s | 0.0217s | **2.4x** | **1.6x** |
| tr | -s spaces 10MB | 0.0263s | 0.0075s | 0.0287s | **3.5x** | **3.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0137s | 0.0072s | 0.0077s | **1.9x** | **1.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0165s | 0.0134s | 0.0145s | **1.2x** | **1.1x** |
| tr | translate binary 10MB | 0.0110s | 0.0075s | 0.0082s | **1.5x** | **1.1x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0036s | 0.0113s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0037s | 0.0130s | **3.8x** | **3.5x** |
| uniq | -c count 10MB many dups | 0.0123s | 0.0049s | 0.0115s | **2.5x** | **2.3x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0082s | 0.0158s | **3.6x** | **1.9x** |
| uniq | -d duplicates only 10MB | 0.0130s | 0.0049s | 0.0111s | **2.6x** | **2.2x** |
| uniq | -u unique only 10MB | 0.0121s | 0.0046s | 0.0113s | **2.6x** | **2.4x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0051s | 0.0130s | **2.7x** | **2.5x** |
| uniq | repetitive 10MB | 0.0423s | 0.0045s | 0.0170s | **9.4x** | **3.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0107s | 0.0049s | 0.0059s | **2.2x** | **1.2x** |
| tac | reverse 100MB text | 0.1046s | 0.0412s | 0.0529s | **2.5x** | **1.3x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0046s | 0.0057s | **2.1x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0236s | 0.0095s | 0.0112s | **2.5x** | **1.2x** |
| tac | custom separator 1MB | 0.0061s | 0.0036s | 0.0054s | **1.7x** | **1.5x** |
