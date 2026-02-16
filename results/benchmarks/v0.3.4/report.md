# fcoreutils v0.3.4 — Detailed Results

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0070s | 0.0258s | **4.9x** | **3.7x** |
| wc | default 100MB text | 0.3010s | 0.0437s | 0.2287s | **6.9x** | **5.2x** |
| wc | -l 10MB text | 0.0044s | 0.0021s | 0.0028s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0346s | 0.0061s | 0.0236s | **5.7x** | **3.9x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0344s | 0.0021s | 0.0028s | **16.1x** | **1.3x** |
| wc | -L 10MB text | 0.0344s | 0.0064s | 0.0178s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2341s | 0.0173s | 0.1177s | **13.5x** | **6.8x** |
| wc | default 10MB repetitive | 0.0537s | 0.0078s | 0.0379s | **6.9x** | **4.9x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0015s | 0.0014s | 0.0020s | **1.1x** | **1.4x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0037s | 0.0061s | **5.0x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0039s | 0.0063s | **4.9x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0052s | 0.0073s | **3.6x** | **1.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0119s | 0.0166s | **1.8x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0062s | 0.0129s | **3.8x** | **2.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0047s | 0.0163s | **5.6x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | 0.0012s | **0.8x** | **1.3x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0015s | 0.0017s | **2.2x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0005s | 0.0008s | 0.0007s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0020s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0026s | 0.0038s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0082s | 0.0086s | 0.0274s | **0.9x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0079s | 0.0087s | 0.0288s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0707s | 0.0582s | 0.2642s | **1.2x** | **4.5x** |
| sha256sum | 10 files | 0.0012s | 0.0013s | 0.0012s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0018s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0035s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0212s | 0.0176s | 0.0176s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0220s | 0.0182s | 0.0183s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2021s | 0.1450s | 0.1676s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0013s | 0.0011s | **0.9x** | **0.8x** |
| md5sum | 100 files | 0.0017s | 0.0021s | 0.0018s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0143s | 0.0139s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0146s | 0.0143s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1365s | 0.1176s | 0.1308s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0144s | 0.0138s | 0.0137s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0137s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0017s | 0.0018s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0100s | 0.0035s | 0.0072s | **2.8x** | **2.0x** |
| base64 | encode 10MB binary | 0.0102s | 0.0036s | 0.0075s | **2.8x** | **2.1x** |
| base64 | decode 1MB | 0.0038s | 0.0017s | 0.0036s | **2.2x** | **2.1x** |
| base64 | decode 10MB | 0.0308s | 0.0061s | 0.0270s | **5.1x** | **4.4x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0035s | 0.0073s | **2.9x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0079s | 0.0027s | 0.0076s | **2.9x** | **2.8x** |
| sort | lexicographic 1MB | 0.0077s | 0.0028s | 0.0043s | **2.7x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0529s | 0.0067s | 0.0305s | **7.9x** | **4.6x** |
| sort | already sorted 10MB | 0.0254s | 0.0035s | 0.0139s | **7.2x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0254s | 0.0045s | 0.0142s | **5.6x** | **3.2x** |
| sort | -n numeric 10MB | 0.0705s | 0.0040s | 0.0647s | **17.7x** | **16.3x** |
| sort | -r reverse 10MB | 0.0534s | 0.0065s | 0.0313s | **8.2x** | **4.8x** |
| sort | -u unique 10MB | 0.0555s | 0.0090s | 0.0389s | **6.2x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0734s | 0.0156s | 0.0736s | **4.7x** | **4.7x** |
| sort | repetitive 10MB | 0.0478s | 0.0107s | 0.0386s | **4.4x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0528s | 0.0066s | 0.0327s | **7.9x** | **4.9x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0019s | 0.0019s | **1.0x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0076s | 0.0069s | **1.2x** | **0.9x** |
| tr | -d digits 10MB | 0.0111s | 0.0069s | 0.0102s | **1.6x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0088s | 0.0173s | **2.2x** | **2.0x** |
| tr | -s spaces 10MB | 0.0167s | 0.0074s | 0.0115s | **2.3x** | **1.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0075s | 0.0067s | **1.2x** | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0071s | 0.0102s | **1.6x** | **1.4x** |
| tr | translate binary 10MB | 0.0093s | 0.0077s | 0.0078s | **1.2x** | **1.0x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0028s | 0.0089s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0030s | 0.0101s | **5.6x** | **3.3x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0030s | 0.0090s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0297s | 0.0070s | 0.0119s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0027s | 0.0090s | **3.5x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0028s | 0.0089s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0042s | 0.0102s | **4.0x** | **2.4x** |
| uniq | repetitive 10MB | 0.0490s | 0.0035s | 0.0158s | **13.8x** | **4.5x** |
| tac | reverse 100KB text | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| tac | reverse 10MB text | 0.0086s | 0.0044s | 0.0050s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0871s | 0.0398s | 0.0453s | **2.2x** | **1.1x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0044s | 0.0045s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0193s | 0.0093s | 0.0090s | **2.1x** | **1.0x** |
| tac | custom separator 1MB | 0.0044s | 0.0031s | 0.0040s | **1.4x** | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0016s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0060s | 0.0031s | 0.0042s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0555s | 0.0028s | 0.0307s | **19.5x** | **10.8x** |
| wc | default 100MB text | 0.4837s | 0.0104s | 0.2561s | **46.6x** | **24.7x** |
| wc | -l 10MB text | 0.0023s | 0.0027s | 0.0022s | **0.9x** | **0.8x** |
| wc | -w 10MB text | 0.0561s | 0.0086s | 0.0264s | **6.5x** | **3.1x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0550s | 0.0027s | 0.0023s | **20.3x** | **0.9x** |
| wc | -L 10MB text | 0.0548s | 0.0112s | 0.0206s | **4.9x** | **1.8x** |
| wc | default 10MB binary | 0.3241s | 0.0270s | 0.1547s | **12.0x** | **5.7x** |
| wc | default 10MB repetitive | 0.0733s | 0.0036s | 0.0402s | **20.2x** | **11.1x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0020s | 0.0024s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0233s | 0.0044s | 0.0079s | **5.3x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0232s | 0.0044s | 0.0078s | **5.2x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0172s | 0.0056s | 0.0092s | **3.1x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0226s | 0.0117s | 0.0181s | **1.9x** | **1.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0246s | 0.0089s | 0.0140s | **2.8x** | **1.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0066s | 0.0172s | **4.8x** | **2.6x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0017s | 0.0021s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0012s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0021s | 0.0033s | 0.0021s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0091s | 0.0108s | 0.0091s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0094s | 0.0111s | 0.0094s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0763s | 0.0764s | 0.0762s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0015s | 0.0014s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0026s | 0.0027s | 0.0024s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0040s | 0.0034s | **0.7x** | **0.9x** |
| md5sum | single 10MB text | 0.0180s | 0.0189s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0187s | 0.0194s | 0.0231s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1621s | 0.1540s | 0.2042s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0015s | 0.0014s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0025s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0024s | 0.0022s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0156s | 0.0133s | 0.0131s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0162s | 0.0138s | 0.0135s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1439s | 0.1128s | 0.1141s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0157s | 0.0133s | 0.0131s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0158s | 0.0133s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0023s | 0.0023s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0016s | 0.0019s | **1.3x** | **1.2x** |
| base64 | encode 10MB text | 0.0130s | 0.0044s | 0.0086s | **3.0x** | **2.0x** |
| base64 | encode 10MB binary | 0.0135s | 0.0045s | 0.0090s | **3.0x** | **2.0x** |
| base64 | decode 1MB | 0.0041s | 0.0015s | 0.0046s | **2.7x** | **3.0x** |
| base64 | decode 10MB | 0.0331s | 0.0061s | 0.0344s | **5.5x** | **5.7x** |
| base64 | encode -w 76 10MB | 0.0130s | 0.0045s | 0.0087s | **2.9x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0093s | 0.0034s | 0.0078s | **2.8x** | **2.3x** |
| sort | lexicographic 1MB | 0.0093s | 0.0036s | 0.0059s | **2.6x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0566s | 0.0101s | 0.0372s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0269s | 0.0046s | 0.0190s | **5.8x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0281s | 0.0072s | 0.0192s | **3.9x** | **2.7x** |
| sort | -n numeric 10MB | 0.0767s | 0.0060s | 0.0835s | **12.7x** | **13.9x** |
| sort | -r reverse 10MB | 0.0591s | 0.0108s | 0.0374s | **5.5x** | **3.5x** |
| sort | -u unique 10MB | 0.0622s | 0.0122s | 0.0430s | **5.1x** | **3.5x** |
| sort | -t, -k2 CSV 10MB | 0.0699s | 0.0215s | 0.0882s | **3.2x** | **4.1x** |
| sort | repetitive 10MB | 0.0553s | 0.0122s | 0.0376s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0557s | 0.0102s | 0.0368s | **5.5x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0022s | 0.0021s | **1.1x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0129s | 0.0104s | 0.0076s | **1.2x** | **0.7x** |
| tr | -d digits 10MB | 0.0168s | 0.0096s | 0.0146s | **1.8x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0307s | 0.0118s | 0.0227s | **2.6x** | **1.9x** |
| tr | -s spaces 10MB | 0.0260s | 0.0101s | 0.0277s | **2.6x** | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0141s | 0.0107s | 0.0088s | **1.3x** | **0.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0187s | 0.0096s | 0.0150s | **2.0x** | **1.6x** |
| tr | translate binary 10MB | 0.0125s | 0.0110s | 0.0088s | **1.1x** | **0.8x** |
| uniq | default 10MB many duplicates | 0.0127s | 0.0039s | 0.0121s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0146s | 0.0041s | 0.0140s | **3.6x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0125s | 0.0037s | 0.0116s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0301s | 0.0098s | 0.0162s | **3.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0126s | 0.0039s | 0.0118s | **3.3x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0126s | 0.0038s | 0.0121s | **3.3x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0145s | 0.0050s | 0.0140s | **2.9x** | **2.8x** |
| uniq | repetitive 10MB | 0.0426s | 0.0045s | 0.0169s | **9.5x** | **3.8x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0115s | 0.0047s | 0.0062s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1050s | 0.0391s | 0.0540s | **2.7x** | **1.4x** |
| tac | reverse CSV 10MB | 0.0099s | 0.0050s | 0.0060s | **2.0x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0244s | 0.0101s | 0.0119s | **2.4x** | **1.2x** |
| tac | custom separator 1MB | 0.0061s | 0.0038s | 0.0055s | **1.6x** | **1.5x** |
