# fcoreutils v0.0.48 — Detailed Results

Generated: 2026-02-16 22:49:24 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 412 | 1 | 99.8% |
| Linux_x86_64 | 413 | 411 | 2 | 99.5% |

**Overall: 823/826 (99.6%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0012s | **0.9x** |
| wc | default 1MB text | 0.0039s | 0.0027s | **1.4x** |
| wc | default 10MB text | 0.0346s | 0.0062s | **5.6x** |
| wc | default 100MB text | 0.2942s | 0.0434s | **6.8x** |
| wc | -l 10MB text | 0.0047s | 0.0022s | **2.1x** |
| wc | -w 10MB text | 0.0346s | 0.0064s | **5.4x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | **0.8x** |
| wc | -m 10MB text | 0.0346s | 0.0024s | **14.5x** |
| wc | -L 10MB text | 0.0345s | 0.0067s | **5.1x** |
| wc | default 10MB binary | 0.2338s | 0.0173s | **13.6x** |
| wc | default 10MB repetitive | 0.0511s | 0.0069s | **7.4x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.7x** |
| wc | 100 files | 0.0013s | 0.0015s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0030s | **6.2x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0028s | **6.8x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0044s | **4.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0044s | **4.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0047s | **5.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0046s | **5.8x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0024s | **0.5x** |
| sha256sum | single 1MB text | 0.0019s | 0.0028s | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0076s | **1.1x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0076s | **1.0x** |
| sha256sum | single 100MB text | 0.0643s | 0.0556s | **1.2x** |
| sha256sum | 10 files | 0.0011s | 0.0021s | **0.5x** |
| sha256sum | 100 files | 0.0019s | 0.0026s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0023s | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0037s | **0.9x** |
| md5sum | single 10MB text | 0.0216s | 0.0166s | **1.3x** |
| md5sum | single 10MB binary | 0.0215s | 0.0174s | **1.2x** |
| md5sum | single 100MB text | 0.1957s | 0.1430s | **1.4x** |
| md5sum | 10 files | 0.0012s | 0.0021s | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0027s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0022s | 0.0024s | **0.9x** |
| b2sum | single 10MB text | 0.0145s | 0.0132s | **1.1x** |
| b2sum | single 10MB binary | 0.0143s | 0.0135s | **1.1x** |
| b2sum | single 100MB text | 0.1307s | 0.1193s | **1.1x** |
| b2sum | -l 256 10MB | 0.0145s | 0.0133s | **1.1x** |
| b2sum | -l 128 10MB | 0.0145s | 0.0130s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0011s | **0.8x** |
| base64 | encode 1MB text | 0.0018s | 0.0017s | **1.0x** |
| base64 | encode 10MB text | 0.0103s | 0.0040s | **2.6x** |
| base64 | encode 10MB binary | 0.0100s | 0.0036s | **2.8x** |
| base64 | decode 1MB | 0.0039s | 0.0027s | **1.5x** |
| base64 | decode 10MB | 0.0299s | 0.0140s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0104s | 0.0037s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0032s | **2.5x** |
| sort | lexicographic 1MB | 0.0078s | 0.0031s | **2.5x** |
| sort | lexicographic 10MB random | 0.0526s | 0.0065s | **8.1x** |
| sort | already sorted 10MB | 0.0241s | 0.0055s | **4.4x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0048s | **5.0x** |
| sort | -n numeric 10MB | 0.0716s | 0.0231s | **3.1x** |
| sort | -r reverse 10MB | 0.0508s | 0.0062s | **8.2x** |
| sort | -u unique 10MB | 0.0541s | 0.0136s | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0706s | 0.0193s | **3.7x** |
| sort | repetitive 10MB | 0.0414s | 0.0121s | **3.4x** |
| sort | --parallel=4 10MB | 0.0497s | 0.0056s | **8.8x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0019s | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0064s | **1.4x** |
| tr | -d digits 10MB | 0.0111s | 0.0127s | **0.9x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0194s | **1.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0135s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0067s | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0126s | **0.9x** |
| tr | translate binary 10MB | 0.0094s | 0.0097s | **1.0x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0033s | **4.9x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0048s | **1.9x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0067s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0161s | 0.0042s | **3.8x** |
| uniq | repetitive 10MB | 0.0464s | 0.0040s | **11.6x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.8x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0087s | 0.0046s | **1.9x** |
| tac | reverse 100MB text | 0.0813s | 0.0397s | **2.0x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0047s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0095s | **1.8x** |
| tac | custom separator 1MB | 0.0044s | 0.0043s | **1.0x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0058s | 0.0031s | **1.9x** |
| wc | default 10MB text | 0.0546s | 0.0032s | **17.2x** |
| wc | default 100MB text | 0.4847s | 0.0157s | **30.9x** |
| wc | -l 10MB text | 0.0022s | 0.0027s | **0.8x** |
| wc | -w 10MB text | 0.0549s | 0.0093s | **5.9x** |
| wc | -c 10MB text | 0.0009s | 0.0012s | **0.8x** |
| wc | -m 10MB text | 0.0549s | 0.0032s | **17.0x** |
| wc | -L 10MB text | 0.0553s | 0.0116s | **4.8x** |
| wc | default 10MB binary | 0.3164s | 0.0272s | **11.6x** |
| wc | default 10MB repetitive | 0.0734s | 0.0046s | **15.9x** |
| wc | 10 files | 0.0011s | 0.0013s | **0.9x** |
| wc | 100 files | 0.0019s | 0.0019s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0041s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0228s | 0.0037s | **6.1x** |
| cut | -d, -f1 10MB CSV | 0.0173s | 0.0053s | **3.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0226s | 0.0068s | **3.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0067s | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0315s | 0.0082s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.8x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | **0.6x** |
| sha256sum | single 1MB text | 0.0021s | 0.0029s | **0.7x** |
| sha256sum | single 10MB text | 0.0089s | 0.0100s | **0.9x** |
| sha256sum | single 10MB binary | 0.0093s | 0.0102s | **0.9x** |
| sha256sum | single 100MB text | 0.0775s | 0.0770s | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0025s | **0.6x** |
| sha256sum | 100 files | 0.0025s | 0.0033s | **0.8x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0039s | **0.8x** |
| md5sum | single 10MB text | 0.0176s | 0.0179s | **1.0x** |
| md5sum | single 10MB binary | 0.0181s | 0.0182s | **1.0x** |
| md5sum | single 100MB text | 0.1627s | 0.1542s | **1.1x** |
| md5sum | 10 files | 0.0014s | 0.0024s | **0.6x** |
| md5sum | 100 files | 0.0026s | 0.0033s | **0.8x** |
| b2sum | single 100KB text | 0.0010s | 0.0012s | **0.8x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | **1.1x** |
| b2sum | single 10MB text | 0.0156s | 0.0126s | **1.2x** |
| b2sum | single 10MB binary | 0.0167s | 0.0132s | **1.3x** |
| b2sum | single 100MB text | 0.1448s | 0.1119s | **1.3x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0122s | **1.2x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0122s | **1.2x** |
| b2sum | 100 files | 0.0023s | 0.0019s | **1.2x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.9x** |
| base64 | encode 1MB text | 0.0022s | 0.0016s | **1.4x** |
| base64 | encode 10MB text | 0.0129s | 0.0058s | **2.2x** |
| base64 | encode 10MB binary | 0.0139s | 0.0063s | **2.2x** |
| base64 | decode 1MB | 0.0041s | 0.0022s | **1.9x** |
| base64 | decode 10MB | 0.0338s | 0.0127s | **2.7x** |
| base64 | encode -w 76 10MB | 0.0132s | 0.0058s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0091s | 0.0045s | **2.0x** |
| sort | lexicographic 1MB | 0.0091s | 0.0041s | **2.2x** |
| sort | lexicographic 10MB random | 0.0566s | 0.0093s | **6.1x** |
| sort | already sorted 10MB | 0.0272s | 0.0073s | **3.7x** |
| sort | reverse sorted 10MB | 0.0285s | 0.0074s | **3.9x** |
| sort | -n numeric 10MB | 0.0745s | 0.0337s | **2.2x** |
| sort | -r reverse 10MB | 0.0557s | 0.0096s | **5.8x** |
| sort | -u unique 10MB | 0.0592s | 0.0136s | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0674s | 0.0259s | **2.6x** |
| sort | repetitive 10MB | 0.0569s | 0.0164s | **3.5x** |
| sort | --parallel=4 10MB | 0.0561s | 0.0091s | **6.2x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0021s | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0149s | 0.0065s | **2.3x** |
| tr | -d digits 10MB | 0.0165s | 0.0116s | **1.4x** |
| tr | -d lowercase 10MB | 0.0304s | 0.0102s | **3.0x** |
| tr | -s spaces 10MB | 0.0300s | 0.0126s | **2.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0147s | 0.0064s | **2.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0164s | 0.0108s | **1.5x** |
| tr | translate binary 10MB | 0.0118s | 0.0100s | **1.2x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0048s | **2.5x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0036s | **3.9x** |
| uniq | -c count 10MB many dups | 0.0122s | 0.0047s | **2.6x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0085s | **3.4x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0047s | **2.6x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0048s | **2.5x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0049s | **2.9x** |
| uniq | repetitive 10MB | 0.0420s | 0.0052s | **8.0x** |
| tac | reverse 100KB text | 0.0011s | 0.0013s | **0.9x** |
| tac | reverse 1MB text | 0.0021s | 0.0016s | **1.3x** |
| tac | reverse 10MB text | 0.0114s | 0.0049s | **2.3x** |
| tac | reverse 100MB text | 0.1057s | 0.0405s | **2.6x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0053s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0231s | 0.0103s | **2.2x** |
| tac | custom separator 1MB | 0.0060s | 0.0044s | **1.4x** |
