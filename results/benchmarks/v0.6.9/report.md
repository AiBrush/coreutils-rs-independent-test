# fcoreutils v0.6.9 — Detailed Results

Generated: 2026-02-17 03:37:34 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0013s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0037s | 0.0025s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0341s | 0.0064s | 0.0257s | **5.3x** | **4.0x** |
| wc | default 100MB text | 0.2977s | 0.0444s | 0.2257s | **6.7x** | **5.1x** |
| wc | -l 10MB text | 0.0038s | 0.0020s | 0.0023s | **1.9x** | **1.1x** |
| wc | -w 10MB text | 0.0339s | 0.0065s | 0.0227s | **5.2x** | **3.5x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.7x** | **1.1x** |
| wc | -m 10MB text | 0.0341s | 0.0022s | 0.0024s | **15.7x** | **1.1x** |
| wc | -L 10MB text | 0.0339s | 0.0057s | 0.0173s | **5.9x** | **3.0x** |
| wc | default 10MB binary | 0.2347s | 0.0171s | 0.1179s | **13.7x** | **6.9x** |
| wc | default 10MB repetitive | 0.0520s | 0.0082s | 0.0372s | **6.4x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0181s | 0.0027s | 0.0059s | **6.6x** | **2.2x** |
| cut | -c1-100 10MB CSV | 0.0181s | 0.0028s | 0.0060s | **6.5x** | **2.2x** |
| cut | -d, -f1 10MB CSV | 0.0185s | 0.0043s | 0.0067s | **4.3x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0210s | 0.0048s | 0.0162s | **4.4x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0229s | 0.0042s | 0.0124s | **5.4x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0262s | 0.0045s | 0.0159s | **5.8x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0011s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | 0.0016s | **1.3x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | 0.0009s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0011s | 0.0023s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0016s | 0.0028s | 0.0036s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0069s | 0.0080s | 0.0270s | **0.9x** | **3.4x** |
| sha256sum | single 10MB binary | 0.0072s | 0.0085s | 0.0282s | **0.8x** | **3.3x** |
| sha256sum | single 100MB text | 0.0665s | 0.0662s | 0.2611s | **1.0x** | **3.9x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0010s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0020s | 0.0016s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0034s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0206s | 0.0168s | 0.0171s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0217s | 0.0179s | 0.0176s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1988s | 0.1426s | 0.1643s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0010s | 0.0017s | 0.0010s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0023s | 0.0016s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0135s | 0.0130s | 0.0133s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0143s | 0.0139s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1335s | 0.1133s | 0.1265s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0136s | 0.0133s | 0.0131s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0135s | 0.0130s | 0.0131s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0016s | 0.0016s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0091s | 0.0034s | 0.0069s | **2.7x** | **2.0x** |
| base64 | encode 10MB binary | 0.0097s | 0.0034s | 0.0071s | **2.9x** | **2.1x** |
| base64 | decode 1MB | 0.0037s | 0.0018s | 0.0035s | **2.1x** | **1.9x** |
| base64 | decode 10MB | 0.0301s | 0.0041s | 0.0262s | **7.4x** | **6.4x** |
| base64 | encode -w 76 10MB | 0.0095s | 0.0032s | 0.0072s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0072s | 0.0031s | 0.0068s | **2.3x** | **2.2x** |
| sort | lexicographic 1MB | 0.0073s | 0.0030s | 0.0041s | **2.4x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0508s | 0.0089s | 0.0282s | **5.7x** | **3.2x** |
| sort | already sorted 10MB | 0.0240s | 0.0031s | 0.0125s | **7.8x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0240s | 0.0048s | 0.0127s | **5.0x** | **2.6x** |
| sort | -n numeric 10MB | 0.0688s | 0.0037s | 0.0598s | **18.8x** | **16.3x** |
| sort | -r reverse 10MB | 0.0518s | 0.0086s | 0.0277s | **6.0x** | **3.2x** |
| sort | -u unique 10MB | 0.0536s | 0.0096s | 0.0341s | **5.6x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0700s | 0.0144s | 0.0657s | **4.9x** | **4.6x** |
| sort | repetitive 10MB | 0.0446s | 0.0101s | 0.0353s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0507s | 0.0088s | 0.0277s | **5.8x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0017s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0090s | 0.0039s | 0.0069s | **2.3x** | **1.8x** |
| tr | -d digits 10MB | 0.0111s | 0.0051s | 0.0101s | **2.2x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0187s | 0.0066s | 0.0168s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0167s | 0.0038s | 0.0115s | **4.4x** | **3.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0040s | 0.0069s | **2.2x** | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0052s | 0.0102s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0093s | 0.0040s | 0.0078s | **2.3x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0017s | 0.0085s | **5.5x** | **5.1x** |
| uniq | default 10MB sorted (low dup) | 0.0162s | 0.0024s | 0.0096s | **6.7x** | **4.0x** |
| uniq | -c count 10MB many dups | 0.0090s | 0.0016s | 0.0085s | **5.8x** | **5.5x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0068s | 0.0113s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0016s | 0.0086s | **5.6x** | **5.3x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0016s | 0.0087s | **5.6x** | **5.4x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0039s | 0.0096s | **4.2x** | **2.5x** |
| uniq | repetitive 10MB | 0.0482s | 0.0030s | 0.0147s | **16.3x** | **5.0x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0016s | 0.0013s | 0.0014s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0081s | 0.0043s | 0.0048s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0835s | 0.0216s | 0.0422s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0077s | 0.0041s | 0.0044s | **1.9x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0182s | 0.0088s | 0.0086s | **2.1x** | **1.0x** |
| tac | custom separator 1MB | 0.0042s | 0.0034s | 0.0036s | **1.3x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0015s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0029s | 0.0039s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0544s | 0.0031s | 0.0309s | **17.6x** | **10.0x** |
| wc | default 100MB text | 0.4830s | 0.0147s | 0.2645s | **32.8x** | **18.0x** |
| wc | -l 10MB text | 0.0021s | 0.0025s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0546s | 0.0107s | 0.0254s | **5.1x** | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0548s | 0.0031s | 0.0020s | **17.9x** | **0.7x** |
| wc | -L 10MB text | 0.0544s | 0.0101s | 0.0168s | **5.4x** | **1.7x** |
| wc | default 10MB binary | 0.3184s | 0.0272s | 0.1593s | **11.7x** | **5.9x** |
| wc | default 10MB repetitive | 0.0733s | 0.0047s | 0.0420s | **15.7x** | **9.0x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0035s | 0.0073s | **6.5x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0036s | 0.0075s | **6.2x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0051s | 0.0085s | **3.2x** | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0073s | 0.0182s | **3.0x** | **2.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0053s | 0.0138s | **4.7x** | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0311s | 0.0055s | 0.0170s | **5.6x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | 0.0020s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0026s | 0.0013s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0034s | 0.0020s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0084s | 0.0100s | 0.0086s | **0.8x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0102s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0752s | 0.0750s | 0.0771s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0021s | 0.0014s | **0.7x** | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0036s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0171s | 0.0180s | 0.0213s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0185s | 0.0185s | 0.0227s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1626s | 0.1533s | 0.2039s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0032s | 0.0023s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0128s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0159s | 0.0133s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1430s | 0.1121s | 0.1136s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0155s | 0.0129s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0157s | 0.0132s | 0.0125s | **1.2x** | **0.9x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0017s | 0.0018s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0123s | 0.0045s | 0.0080s | **2.8x** | **1.8x** |
| base64 | encode 10MB binary | 0.0129s | 0.0044s | 0.0088s | **2.9x** | **2.0x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | 0.0043s | **1.8x** | **2.0x** |
| base64 | decode 10MB | 0.0324s | 0.0049s | 0.0335s | **6.6x** | **6.8x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0045s | 0.0083s | **2.8x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0088s | 0.0040s | 0.0074s | **2.2x** | **1.8x** |
| sort | lexicographic 1MB | 0.0085s | 0.0035s | 0.0055s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0541s | 0.0089s | 0.0358s | **6.1x** | **4.0x** |
| sort | already sorted 10MB | 0.0268s | 0.0046s | 0.0182s | **5.8x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0275s | 0.0062s | 0.0181s | **4.4x** | **2.9x** |
| sort | -n numeric 10MB | 0.0736s | 0.0053s | 0.0749s | **13.8x** | **14.1x** |
| sort | -r reverse 10MB | 0.0557s | 0.0092s | 0.0364s | **6.0x** | **3.9x** |
| sort | -u unique 10MB | 0.0579s | 0.0093s | 0.0401s | **6.3x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0669s | 0.0199s | 0.0847s | **3.4x** | **4.3x** |
| sort | repetitive 10MB | 0.0554s | 0.0126s | 0.0371s | **4.4x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0544s | 0.0092s | 0.0361s | **5.9x** | **3.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0021s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0040s | 0.0075s | **3.2x** | **1.9x** |
| tr | -d digits 10MB | 0.0168s | 0.0043s | 0.0134s | **3.9x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0328s | 0.0052s | 0.0215s | **6.3x** | **4.2x** |
| tr | -s spaces 10MB | 0.0291s | 0.0040s | 0.0280s | **7.4x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0134s | 0.0039s | 0.0074s | **3.4x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0175s | 0.0043s | 0.0138s | **4.1x** | **3.2x** |
| tr | translate binary 10MB | 0.0109s | 0.0041s | 0.0081s | **2.7x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | 0.0121s | **6.3x** | **6.4x** |
| uniq | default 10MB sorted (low dup) | 0.0138s | 0.0030s | 0.0131s | **4.6x** | **4.4x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0019s | 0.0121s | **6.4x** | **6.4x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0077s | 0.0155s | **3.8x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0019s | 0.0121s | **6.3x** | **6.4x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0019s | 0.0121s | **6.3x** | **6.4x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0045s | 0.0131s | **3.1x** | **2.9x** |
| uniq | repetitive 10MB | 0.0419s | 0.0035s | 0.0177s | **11.8x** | **5.0x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0105s | 0.0046s | 0.0058s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1039s | 0.0267s | 0.0528s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0093s | 0.0048s | 0.0056s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0233s | 0.0108s | 0.0125s | **2.2x** | **1.2x** |
| tac | custom separator 1MB | 0.0060s | 0.0043s | 0.0053s | **1.4x** | **1.2x** |
