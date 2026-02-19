# fcoreutils v0.8.7 — Detailed Results

Generated: 2026-02-19 02:02:07 UTC

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
| wc | default 100KB text | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0041s | 0.0029s | 0.0036s | **1.4x** | **1.2x** |
| wc | default 10MB text | 0.0349s | 0.0070s | 0.0258s | **5.0x** | **3.7x** |
| wc | default 100MB text | 0.2998s | 0.0469s | 0.2218s | **6.4x** | **4.7x** |
| wc | -l 10MB text | 0.0053s | 0.0026s | 0.0041s | **2.0x** | **1.5x** |
| wc | -w 10MB text | 0.0351s | 0.0068s | 0.0237s | **5.2x** | **3.5x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| wc | -m 10MB text | 0.0350s | 0.0028s | 0.0040s | **12.6x** | **1.4x** |
| wc | -L 10MB text | 0.0351s | 0.0071s | 0.0185s | **4.9x** | **2.6x** |
| wc | default 10MB binary | 0.2359s | 0.0174s | 0.1138s | **13.6x** | **6.6x** |
| wc | default 10MB repetitive | 0.0534s | 0.0089s | 0.0375s | **6.0x** | **4.2x** |
| wc | 10 files | 0.0009s | 0.0012s | 0.0012s | **0.7x** | **0.9x** |
| wc | 100 files | 0.0014s | 0.0017s | 0.0019s | **0.8x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0190s | 0.0038s | 0.0071s | **4.9x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0039s | 0.0069s | **4.8x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0098s | 0.0076s | **1.9x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0217s | 0.0122s | 0.0170s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0236s | 0.0100s | 0.0132s | **2.4x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0269s | 0.0104s | 0.0167s | **2.6x** | **1.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0013s | 0.0011s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | 0.0019s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0013s | 0.0011s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0013s | 0.0026s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0019s | 0.0033s | 0.0040s | **0.6x** | **1.2x** |
| sha256sum | single 10MB text | 0.0086s | 0.0096s | 0.0282s | **0.9x** | **2.9x** |
| sha256sum | single 10MB binary | 0.0085s | 0.0097s | 0.0289s | **0.9x** | **3.0x** |
| sha256sum | single 100MB text | 0.0690s | 0.0677s | 0.2629s | **1.0x** | **3.9x** |
| sha256sum | 10 files | 0.0012s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0020s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0024s | 0.0013s | **0.6x** | **0.5x** |
| md5sum | single 1MB text | 0.0033s | 0.0038s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0218s | 0.0184s | 0.0183s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0224s | 0.0186s | 0.0188s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2006s | 0.1433s | 0.1660s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0019s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0024s | 0.0026s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0151s | 0.0145s | 0.0146s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0151s | 0.0146s | 0.0149s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1357s | 0.1144s | 0.1289s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0144s | 0.0147s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0149s | 0.0143s | 0.0146s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0018s | 0.0021s | 0.0019s | **0.9x** | **0.9x** |
| base64 | encode 100KB text | 0.0010s | 0.0013s | 0.0012s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0017s | 0.0018s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0106s | 0.0056s | 0.0080s | **1.9x** | **1.4x** |
| base64 | encode 10MB binary | 0.0107s | 0.0057s | 0.0081s | **1.9x** | **1.4x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0038s | **1.8x** | **1.7x** |
| base64 | decode 10MB | 0.0312s | 0.0048s | 0.0268s | **6.5x** | **5.6x** |
| base64 | encode -w 76 10MB | 0.0107s | 0.0058s | 0.0082s | **1.9x** | **1.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0052s | 0.0083s | **1.7x** | **1.6x** |
| sort | lexicographic 1MB | 0.0079s | 0.0033s | 0.0050s | **2.4x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0576s | 0.0113s | 0.0382s | **5.1x** | **3.4x** |
| sort | already sorted 10MB | 0.0259s | 0.0038s | 0.0143s | **6.9x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0257s | 0.0053s | 0.0150s | **4.9x** | **2.9x** |
| sort | -n numeric 10MB | 0.0822s | 0.0044s | 0.0792s | **18.5x** | **17.8x** |
| sort | -r reverse 10MB | 0.0631s | 0.0122s | 0.0401s | **5.2x** | **3.3x** |
| sort | -u unique 10MB | 0.0666s | 0.0150s | 0.0449s | **4.4x** | **3.0x** |
| sort | -t, -k2 CSV 10MB | 0.0876s | 0.0201s | 0.0885s | **4.4x** | **4.4x** |
| sort | repetitive 10MB | 0.0498s | 0.0114s | 0.0396s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0608s | 0.0129s | 0.0402s | **4.7x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0021s | 0.0020s | 0.0024s | **1.1x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0056s | 0.0076s | **1.6x** | **1.4x** |
| tr | -d digits 10MB | 0.0113s | 0.0057s | 0.0106s | **2.0x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0073s | 0.0170s | **2.6x** | **2.3x** |
| tr | -s spaces 10MB | 0.0169s | 0.0059s | 0.0120s | **2.9x** | **2.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0057s | 0.0075s | **1.6x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0056s | 0.0107s | **2.0x** | **1.9x** |
| tr | translate binary 10MB | 0.0094s | 0.0057s | 0.0081s | **1.6x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0098s | 0.0021s | 0.0094s | **4.7x** | **4.5x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0030s | 0.0106s | **5.6x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0097s | 0.0020s | 0.0094s | **5.0x** | **4.8x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0075s | 0.0124s | **4.0x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0098s | 0.0019s | 0.0093s | **5.1x** | **4.8x** |
| uniq | -u unique only 10MB | 0.0097s | 0.0020s | 0.0093s | **4.8x** | **4.7x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0042s | 0.0106s | **4.0x** | **2.5x** |
| uniq | repetitive 10MB | 0.0493s | 0.0037s | 0.0168s | **13.3x** | **4.5x** |
| tac | reverse 100KB text | 0.0012s | 0.0019s | 0.0014s | **0.6x** | **0.8x** |
| tac | reverse 1MB text | 0.0019s | 0.0020s | 0.0017s | **0.9x** | **0.9x** |
| tac | reverse 10MB text | 0.0098s | 0.0061s | 0.0055s | **1.6x** | **0.9x** |
| tac | reverse 100MB text | 0.0848s | 0.0211s | 0.0443s | **4.0x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0088s | 0.0053s | 0.0049s | **1.7x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0197s | 0.0107s | 0.0094s | **1.8x** | **0.9x** |
| tac | custom separator 1MB | 0.0047s | 0.0044s | 0.0043s | **1.1x** | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0044s | **2.1x** | **1.6x** |
| wc | default 10MB text | 0.0535s | 0.0031s | 0.0357s | **17.4x** | **11.6x** |
| wc | default 100MB text | 0.4811s | 0.0138s | 0.3134s | **34.8x** | **22.6x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0538s | 0.0088s | 0.0264s | **6.1x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0534s | 0.0029s | 0.0019s | **18.2x** | **0.7x** |
| wc | -L 10MB text | 0.0538s | 0.0109s | 0.0167s | **5.0x** | **1.5x** |
| wc | default 10MB binary | 0.3169s | 0.0269s | 0.1560s | **11.8x** | **5.8x** |
| wc | default 10MB repetitive | 0.0725s | 0.0045s | 0.0520s | **16.3x** | **11.7x** |
| wc | 10 files | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0023s | **1.1x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0222s | 0.0039s | 0.0071s | **5.6x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0224s | 0.0039s | 0.0071s | **5.7x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0093s | 0.0084s | **1.8x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0112s | 0.0171s | **1.9x** | **1.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0102s | 0.0132s | **2.3x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0105s | 0.0161s | **2.9x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0026s | 0.0014s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0033s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0083s | 0.0098s | 0.0083s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0086s | 0.0101s | 0.0086s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0745s | 0.0740s | 0.0744s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.7x** | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0175s | 0.0212s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0177s | 0.0182s | 0.0221s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1596s | 0.1524s | 0.2020s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0032s | 0.0024s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0120s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0127s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1427s | 0.1113s | 0.1121s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0122s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0122s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.3x** | **1.1x** |
| base64 | encode 10MB text | 0.0121s | 0.0053s | 0.0080s | **2.3x** | **1.5x** |
| base64 | encode 10MB binary | 0.0127s | 0.0054s | 0.0084s | **2.4x** | **1.6x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0043s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0322s | 0.0048s | 0.0331s | **6.8x** | **7.0x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0052s | 0.0080s | **2.3x** | **1.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0042s | 0.0071s | **2.0x** | **1.7x** |
| sort | lexicographic 1MB | 0.0086s | 0.0035s | 0.0055s | **2.5x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0536s | 0.0087s | 0.0352s | **6.1x** | **4.0x** |
| sort | already sorted 10MB | 0.0260s | 0.0048s | 0.0174s | **5.4x** | **3.6x** |
| sort | reverse sorted 10MB | 0.0273s | 0.0063s | 0.0179s | **4.3x** | **2.8x** |
| sort | -n numeric 10MB | 0.0726s | 0.0051s | 0.0730s | **14.3x** | **14.4x** |
| sort | -r reverse 10MB | 0.0540s | 0.0086s | 0.0352s | **6.3x** | **4.1x** |
| sort | -u unique 10MB | 0.0568s | 0.0088s | 0.0392s | **6.5x** | **4.5x** |
| sort | -t, -k2 CSV 10MB | 0.0665s | 0.0188s | 0.0812s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0553s | 0.0123s | 0.0366s | **4.5x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0089s | 0.0357s | **6.1x** | **4.0x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0038s | 0.0074s | **3.4x** | **1.9x** |
| tr | -d digits 10MB | 0.0167s | 0.0043s | 0.0146s | **3.9x** | **3.4x** |
| tr | -d lowercase 10MB | 0.0303s | 0.0048s | 0.0230s | **6.3x** | **4.8x** |
| tr | -s spaces 10MB | 0.0278s | 0.0037s | 0.0271s | **7.6x** | **7.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0037s | 0.0076s | **3.6x** | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0158s | 0.0042s | 0.0144s | **3.8x** | **3.4x** |
| tr | translate binary 10MB | 0.0110s | 0.0038s | 0.0081s | **2.9x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0019s | 0.0122s | **6.2x** | **6.5x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0030s | 0.0131s | **4.6x** | **4.3x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0019s | 0.0122s | **6.3x** | **6.5x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0077s | 0.0156s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0018s | 0.0121s | **6.7x** | **6.8x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | 0.0122s | **6.4x** | **6.5x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0043s | 0.0131s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0414s | 0.0036s | 0.0174s | **11.5x** | **4.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0013s | 0.0013s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0019s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| tac | reverse 10MB text | 0.0104s | 0.0058s | 0.0058s | **1.8x** | **1.0x** |
| tac | reverse 100MB text | 0.1026s | 0.0271s | 0.0513s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0055s | 0.0057s | **1.7x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0225s | 0.0107s | 0.0109s | **2.1x** | **1.0x** |
| tac | custom separator 1MB | 0.0059s | 0.0048s | 0.0053s | **1.2x** | **1.1x** |
