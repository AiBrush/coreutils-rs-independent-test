# fcoreutils v0.4.6 — Detailed Results

Generated: 2026-02-16 09:40:30 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 411 | 2 | 99.5% |
| Linux_x86_64 | 413 | 411 | 2 | 99.5% |

**Overall: 822/826 (99.5%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0012s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0039s | 0.0025s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0063s | 0.0256s | **5.5x** | **4.1x** |
| wc | default 100MB text | 0.2998s | 0.0425s | 0.2271s | **7.0x** | **5.3x** |
| wc | -l 10MB text | 0.0044s | 0.0023s | 0.0026s | **1.9x** | **1.1x** |
| wc | -w 10MB text | 0.0346s | 0.0062s | 0.0233s | **5.6x** | **3.8x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| wc | -m 10MB text | 0.0345s | 0.0020s | 0.0026s | **17.1x** | **1.3x** |
| wc | -L 10MB text | 0.0343s | 0.0057s | 0.0178s | **6.1x** | **3.1x** |
| wc | default 10MB binary | 0.2353s | 0.0171s | 0.1182s | **13.8x** | **6.9x** |
| wc | default 10MB repetitive | 0.0538s | 0.0084s | 0.0366s | **6.4x** | **4.3x** |
| wc | 10 files | 0.0007s | 0.0010s | 0.0011s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0015s | **1.0x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0038s | 0.0063s | **4.9x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0037s | 0.0062s | **5.0x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0029s | 0.0071s | **6.3x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0051s | 0.0164s | **4.2x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0031s | 0.0126s | **7.4x** | **4.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0046s | 0.0162s | **5.7x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0015s | 0.0017s | **2.3x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0010s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0026s | 0.0037s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0073s | 0.0083s | 0.0275s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0079s | 0.0086s | 0.0290s | **0.9x** | **3.4x** |
| sha256sum | single 100MB text | 0.0688s | 0.0560s | 0.2631s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0018s | 0.0011s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0019s | 0.0016s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0212s | 0.0176s | 0.0174s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0183s | 0.0183s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2008s | 0.1440s | 0.1665s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0018s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0016s | 0.0020s | 0.0016s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0022s | 0.0023s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0140s | 0.0137s | 0.0135s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0146s | 0.0144s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1353s | 0.1167s | 0.1291s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0139s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0139s | 0.0136s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| base64 | encode 1MB text | 0.0017s | 0.0014s | 0.0016s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0098s | 0.0032s | 0.0073s | **3.0x** | **2.3x** |
| base64 | encode 10MB binary | 0.0104s | 0.0033s | 0.0075s | **3.2x** | **2.3x** |
| base64 | decode 1MB | 0.0037s | 0.0015s | 0.0034s | **2.5x** | **2.3x** |
| base64 | decode 10MB | 0.0307s | 0.0034s | 0.0268s | **9.0x** | **7.8x** |
| base64 | encode -w 76 10MB | 0.0099s | 0.0035s | 0.0073s | **2.8x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0076s | 0.0026s | 0.0076s | **3.0x** | **2.9x** |
| sort | lexicographic 1MB | 0.0075s | 0.0033s | 0.0042s | **2.3x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0508s | 0.0070s | 0.0288s | **7.3x** | **4.1x** |
| sort | already sorted 10MB | 0.0249s | 0.0031s | 0.0136s | **7.9x** | **4.3x** |
| sort | reverse sorted 10MB | 0.0250s | 0.0046s | 0.0145s | **5.5x** | **3.2x** |
| sort | -n numeric 10MB | 0.0691s | 0.0038s | 0.0612s | **18.2x** | **16.1x** |
| sort | -r reverse 10MB | 0.0515s | 0.0074s | 0.0280s | **7.0x** | **3.8x** |
| sort | -u unique 10MB | 0.0537s | 0.0088s | 0.0346s | **6.1x** | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0693s | 0.0145s | 0.0682s | **4.8x** | **4.7x** |
| sort | repetitive 10MB | 0.0454s | 0.0100s | 0.0366s | **4.6x** | **3.7x** |
| sort | --parallel=4 10MB | 0.0510s | 0.0076s | 0.0313s | **6.7x** | **4.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0015s | 0.0018s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0045s | 0.0067s | **2.0x** | **1.5x** |
| tr | -d digits 10MB | 0.0110s | 0.0053s | 0.0102s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0067s | 0.0172s | **2.8x** | **2.6x** |
| tr | -s spaces 10MB | 0.0166s | 0.0045s | 0.0114s | **3.7x** | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0044s | 0.0066s | **2.0x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0053s | 0.0102s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0093s | 0.0047s | 0.0078s | **2.0x** | **1.7x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0027s | 0.0089s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0030s | 0.0102s | **5.6x** | **3.4x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0030s | 0.0089s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0065s | 0.0119s | **4.6x** | **1.8x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0028s | 0.0089s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0089s | **3.4x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0039s | 0.0100s | **4.3x** | **2.5x** |
| uniq | repetitive 10MB | 0.0480s | 0.0038s | 0.0145s | **12.6x** | **3.8x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0014s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0090s | 0.0028s | 0.0049s | **3.2x** | **1.8x** |
| tac | reverse 100MB text | 0.0858s | 0.0157s | 0.0446s | **5.5x** | **2.8x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0028s | 0.0045s | **3.0x** | **1.6x** |
| tac | reverse repetitive 10MB | 0.0182s | 0.0041s | 0.0087s | **4.4x** | **2.1x** |
| tac | custom separator 1MB | 0.0044s | 0.0032s | 0.0038s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0038s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0543s | 0.0027s | 0.0304s | **20.4x** | **11.4x** |
| wc | default 100MB text | 0.4829s | 0.0090s | 0.2534s | **53.7x** | **28.2x** |
| wc | -l 10MB text | 0.0020s | 0.0024s | 0.0019s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0542s | 0.0086s | 0.0254s | **6.3x** | **3.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0542s | 0.0024s | 0.0019s | **22.2x** | **0.8x** |
| wc | -L 10MB text | 0.0542s | 0.0094s | 0.0196s | **5.8x** | **2.1x** |
| wc | default 10MB binary | 0.3172s | 0.0268s | 0.1536s | **11.8x** | **5.7x** |
| wc | default 10MB repetitive | 0.0730s | 0.0035s | 0.0396s | **21.1x** | **11.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0023s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0038s | 0.0074s | **5.9x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0039s | 0.0072s | **5.8x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0033s | 0.0086s | **5.1x** | **2.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0064s | 0.0175s | **3.4x** | **2.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0048s | 0.0134s | **5.0x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0304s | 0.0052s | 0.0164s | **5.8x** | **3.1x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0013s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0084s | 0.0098s | 0.0084s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0089s | 0.0103s | 0.0089s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0750s | 0.0755s | 0.0750s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0024s | 0.0025s | 0.0023s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0179s | 0.0216s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0185s | 0.0223s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1607s | 0.1533s | 0.2030s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0123s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0128s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1432s | 0.1122s | 0.1129s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0126s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0124s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0013s | 0.0018s | **1.6x** | **1.4x** |
| base64 | encode 10MB text | 0.0123s | 0.0037s | 0.0081s | **3.4x** | **2.2x** |
| base64 | encode 10MB binary | 0.0130s | 0.0039s | 0.0086s | **3.3x** | **2.2x** |
| base64 | decode 1MB | 0.0040s | 0.0013s | 0.0044s | **3.0x** | **3.2x** |
| base64 | decode 10MB | 0.0329s | 0.0040s | 0.0341s | **8.1x** | **8.4x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0039s | 0.0083s | **3.2x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0031s | 0.0074s | **2.8x** | **2.4x** |
| sort | lexicographic 1MB | 0.0086s | 0.0037s | 0.0055s | **2.3x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0538s | 0.0096s | 0.0355s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0271s | 0.0042s | 0.0176s | **6.4x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0065s | 0.0176s | **4.2x** | **2.7x** |
| sort | -n numeric 10MB | 0.0733s | 0.0056s | 0.0746s | **13.1x** | **13.3x** |
| sort | -r reverse 10MB | 0.0546s | 0.0095s | 0.0358s | **5.7x** | **3.8x** |
| sort | -u unique 10MB | 0.0575s | 0.0096s | 0.0397s | **6.0x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0662s | 0.0189s | 0.0816s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0553s | 0.0115s | 0.0371s | **4.8x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0540s | 0.0096s | 0.0356s | **5.6x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0038s | 0.0074s | **3.4x** | **2.0x** |
| tr | -d digits 10MB | 0.0167s | 0.0044s | 0.0144s | **3.8x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0295s | 0.0049s | 0.0231s | **6.0x** | **4.7x** |
| tr | -s spaces 10MB | 0.0302s | 0.0037s | 0.0275s | **8.1x** | **7.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0037s | 0.0073s | **3.4x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0161s | 0.0042s | 0.0141s | **3.9x** | **3.4x** |
| tr | translate binary 10MB | 0.0111s | 0.0039s | 0.0081s | **2.9x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0036s | 0.0133s | **3.9x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0035s | 0.0113s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0087s | 0.0157s | **3.4x** | **1.8x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0034s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0044s | 0.0134s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0421s | 0.0041s | 0.0161s | **10.2x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0105s | 0.0035s | 0.0058s | **3.0x** | **1.7x** |
| tac | reverse 100MB text | 0.1034s | 0.0192s | 0.0513s | **5.4x** | **2.7x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0030s | 0.0056s | **3.2x** | **1.9x** |
| tac | reverse repetitive 10MB | 0.0231s | 0.0050s | 0.0109s | **4.6x** | **2.2x** |
| tac | custom separator 1MB | 0.0060s | 0.0036s | 0.0053s | **1.6x** | **1.5x** |
