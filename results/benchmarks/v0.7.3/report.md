# fcoreutils v0.7.3 — Detailed Results

Generated: 2026-02-17 01:24:36 UTC

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0026s | 0.0033s | **1.4x** | **1.3x** |
| wc | default 10MB text | 0.0343s | 0.0063s | 0.0257s | **5.4x** | **4.1x** |
| wc | default 100MB text | 0.2978s | 0.0443s | 0.2259s | **6.7x** | **5.1x** |
| wc | -l 10MB text | 0.0042s | 0.0022s | 0.0027s | **1.9x** | **1.2x** |
| wc | -w 10MB text | 0.0344s | 0.0061s | 0.0235s | **5.6x** | **3.8x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0343s | 0.0022s | 0.0027s | **15.4x** | **1.2x** |
| wc | -L 10MB text | 0.0344s | 0.0062s | 0.0179s | **5.5x** | **2.9x** |
| wc | default 10MB binary | 0.2355s | 0.0174s | 0.1176s | **13.5x** | **6.8x** |
| wc | default 10MB repetitive | 0.0526s | 0.0082s | 0.0368s | **6.4x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0010s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0014s | 0.0016s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0027s | 0.0060s | **6.7x** | **2.2x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0026s | 0.0063s | **7.0x** | **2.4x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0067s | 0.0071s | **2.8x** | **1.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0048s | 0.0161s | **4.4x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0231s | 0.0042s | 0.0125s | **5.6x** | **3.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0045s | 0.0161s | **5.8x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0026s | 0.0017s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0011s | 0.0009s | **0.6x** | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0023s | 0.0013s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0029s | 0.0037s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0073s | 0.0087s | 0.0273s | **0.8x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0074s | 0.0085s | 0.0284s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0676s | 0.0661s | 0.2612s | **1.0x** | **4.0x** |
| sha256sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0017s | 0.0021s | 0.0017s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0012s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0033s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0210s | 0.0175s | 0.0175s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0218s | 0.0179s | 0.0181s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1992s | 0.1431s | 0.1647s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0011s | **0.6x** | **0.7x** |
| md5sum | 100 files | 0.0017s | 0.0023s | 0.0016s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0020s | 0.0022s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0140s | 0.0135s | 0.0135s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0143s | 0.0141s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1338s | 0.1159s | 0.1271s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0136s | 0.0134s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0141s | 0.0138s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0015s | 0.0016s | 0.0017s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0008s | 0.0011s | 0.0010s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0015s | 0.0015s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0100s | 0.0032s | 0.0073s | **3.1x** | **2.3x** |
| base64 | encode 10MB binary | 0.0099s | 0.0033s | 0.0072s | **3.0x** | **2.2x** |
| base64 | decode 1MB | 0.0037s | 0.0018s | 0.0035s | **2.1x** | **2.0x** |
| base64 | decode 10MB | 0.0305s | 0.0039s | 0.0267s | **7.9x** | **6.9x** |
| base64 | encode -w 76 10MB | 0.0098s | 0.0033s | 0.0071s | **3.0x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0034s | 0.0074s | **2.2x** | **2.2x** |
| sort | lexicographic 1MB | 0.0074s | 0.0030s | 0.0042s | **2.4x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0515s | 0.0095s | 0.0284s | **5.4x** | **3.0x** |
| sort | already sorted 10MB | 0.0249s | 0.0032s | 0.0130s | **7.8x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0248s | 0.0045s | 0.0138s | **5.5x** | **3.1x** |
| sort | -n numeric 10MB | 0.0685s | 0.0037s | 0.0600s | **18.5x** | **16.2x** |
| sort | -r reverse 10MB | 0.0513s | 0.0094s | 0.0287s | **5.4x** | **3.0x** |
| sort | -u unique 10MB | 0.0537s | 0.0105s | 0.0353s | **5.1x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0696s | 0.0138s | 0.0667s | **5.0x** | **4.8x** |
| sort | repetitive 10MB | 0.0452s | 0.0101s | 0.0366s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0504s | 0.0095s | 0.0279s | **5.3x** | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0018s | **1.3x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0042s | 0.0068s | **2.1x** | **1.6x** |
| tr | -d digits 10MB | 0.0111s | 0.0052s | 0.0102s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0191s | 0.0067s | 0.0167s | **2.9x** | **2.5x** |
| tr | -s spaces 10MB | 0.0165s | 0.0041s | 0.0113s | **4.0x** | **2.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0040s | 0.0069s | **2.2x** | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0052s | 0.0102s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0090s | 0.0040s | 0.0077s | **2.2x** | **1.9x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0017s | 0.0088s | **5.3x** | **5.0x** |
| uniq | default 10MB sorted (low dup) | 0.0166s | 0.0029s | 0.0097s | **5.6x** | **3.3x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0017s | 0.0087s | **5.6x** | **5.3x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0069s | 0.0114s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0017s | 0.0087s | **5.5x** | **5.3x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0017s | 0.0088s | **5.5x** | **5.2x** |
| uniq | -i case insensitive 10MB | 0.0166s | 0.0040s | 0.0097s | **4.2x** | **2.4x** |
| uniq | repetitive 10MB | 0.0483s | 0.0030s | 0.0152s | **15.9x** | **5.0x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0014s | 0.0015s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0084s | 0.0043s | 0.0049s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0837s | 0.0213s | 0.0424s | **3.9x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0042s | 0.0045s | **1.9x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0180s | 0.0090s | 0.0086s | **2.0x** | **1.0x** |
| tac | custom separator 1MB | 0.0043s | 0.0034s | 0.0037s | **1.3x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0014s | 0.0018s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0055s | 0.0033s | 0.0045s | **1.7x** | **1.4x** |
| wc | default 10MB text | 0.0494s | 0.0033s | 0.0363s | **15.0x** | **11.0x** |
| wc | default 100MB text | 0.4446s | 0.0151s | 0.3129s | **29.4x** | **20.7x** |
| wc | -l 10MB text | 0.0024s | 0.0025s | 0.0022s | **1.0x** | **0.9x** |
| wc | -w 10MB text | 0.0494s | 0.0099s | 0.0307s | **5.0x** | **3.1x** |
| wc | -c 10MB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0493s | 0.0030s | 0.0022s | **16.6x** | **0.8x** |
| wc | -L 10MB text | 0.0494s | 0.0101s | 0.0225s | **4.9x** | **2.2x** |
| wc | default 10MB binary | 0.3259s | 0.0308s | 0.1686s | **10.6x** | **5.5x** |
| wc | default 10MB repetitive | 0.0710s | 0.0048s | 0.0487s | **14.8x** | **10.1x** |
| wc | 10 files | 0.0011s | 0.0013s | 0.0015s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0022s | 0.0021s | 0.0027s | **1.1x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0234s | 0.0038s | 0.0084s | **6.2x** | **2.2x** |
| cut | -c1-100 10MB CSV | 0.0234s | 0.0037s | 0.0084s | **6.4x** | **2.3x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0053s | 0.0094s | **3.5x** | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0232s | 0.0070s | 0.0194s | **3.3x** | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0249s | 0.0054s | 0.0148s | **4.6x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0314s | 0.0055s | 0.0179s | **5.7x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0010s | 0.0013s | 0.0012s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0038s | 0.0031s | 0.0023s | **1.2x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0010s | 0.0013s | 0.0013s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0015s | 0.0029s | 0.0015s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0022s | 0.0038s | 0.0022s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0097s | 0.0113s | 0.0097s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0101s | 0.0116s | 0.0099s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0872s | 0.0863s | 0.0874s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0016s | 0.0024s | 0.0016s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0028s | 0.0029s | 0.0027s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0016s | 0.0026s | 0.0016s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0041s | 0.0037s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0197s | 0.0202s | 0.0245s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0204s | 0.0209s | 0.0255s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1842s | 0.1731s | 0.2318s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0016s | 0.0024s | 0.0015s | **0.7x** | **0.7x** |
| md5sum | 100 files | 0.0028s | 0.0034s | 0.0027s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0011s | 0.0012s | 0.0015s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0025s | 0.0022s | 0.0026s | **1.1x** | **1.2x** |
| b2sum | single 10MB text | 0.0164s | 0.0137s | 0.0135s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0168s | 0.0150s | 0.0140s | **1.1x** | **0.9x** |
| b2sum | single 100MB text | 0.1542s | 0.1185s | 0.1231s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0163s | 0.0135s | 0.0137s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0164s | 0.0139s | 0.0135s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0026s | 0.0022s | 0.0027s | **1.2x** | **1.2x** |
| base64 | encode 100KB text | 0.0011s | 0.0013s | 0.0013s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0023s | 0.0017s | 0.0020s | **1.3x** | **1.1x** |
| base64 | encode 10MB text | 0.0148s | 0.0047s | 0.0089s | **3.1x** | **1.9x** |
| base64 | encode 10MB binary | 0.0151s | 0.0046s | 0.0093s | **3.3x** | **2.0x** |
| base64 | decode 1MB | 0.0042s | 0.0023s | 0.0042s | **1.9x** | **1.9x** |
| base64 | decode 10MB | 0.0331s | 0.0051s | 0.0318s | **6.5x** | **6.2x** |
| base64 | encode -w 76 10MB | 0.0152s | 0.0049s | 0.0089s | **3.1x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0103s | 0.0045s | 0.0089s | **2.3x** | **2.0x** |
| sort | lexicographic 1MB | 0.0089s | 0.0037s | 0.0059s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0573s | 0.0100s | 0.0386s | **5.7x** | **3.9x** |
| sort | already sorted 10MB | 0.0256s | 0.0051s | 0.0189s | **5.0x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0268s | 0.0082s | 0.0188s | **3.3x** | **2.3x** |
| sort | -n numeric 10MB | 0.0765s | 0.0057s | 0.0822s | **13.4x** | **14.4x** |
| sort | -r reverse 10MB | 0.0574s | 0.0103s | 0.0386s | **5.6x** | **3.8x** |
| sort | -u unique 10MB | 0.0608s | 0.0107s | 0.0424s | **5.7x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0696s | 0.0200s | 0.0900s | **3.5x** | **4.5x** |
| sort | repetitive 10MB | 0.0477s | 0.0126s | 0.0365s | **3.8x** | **2.9x** |
| sort | --parallel=4 10MB | 0.0577s | 0.0114s | 0.0389s | **5.1x** | **3.4x** |
| tr | a-z to A-Z 1MB | 0.0026s | 0.0017s | 0.0022s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0127s | 0.0048s | 0.0084s | **2.7x** | **1.8x** |
| tr | -d digits 10MB | 0.0189s | 0.0051s | 0.0141s | **3.7x** | **2.8x** |
| tr | -d lowercase 10MB | 0.0334s | 0.0055s | 0.0250s | **6.1x** | **4.6x** |
| tr | -s spaces 10MB | 0.0297s | 0.0051s | 0.0300s | **5.8x** | **5.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0126s | 0.0042s | 0.0082s | **3.0x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0186s | 0.0049s | 0.0139s | **3.8x** | **2.9x** |
| tr | translate binary 10MB | 0.0130s | 0.0046s | 0.0090s | **2.8x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0116s | 0.0021s | 0.0120s | **5.5x** | **5.7x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0032s | 0.0145s | **4.4x** | **4.5x** |
| uniq | -c count 10MB many dups | 0.0115s | 0.0021s | 0.0120s | **5.4x** | **5.7x** |
| uniq | -c count 10MB sorted | 0.0259s | 0.0087s | 0.0174s | **3.0x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0115s | 0.0022s | 0.0119s | **5.2x** | **5.4x** |
| uniq | -u unique only 10MB | 0.0118s | 0.0021s | 0.0121s | **5.6x** | **5.8x** |
| uniq | -i case insensitive 10MB | 0.0144s | 0.0048s | 0.0145s | **3.0x** | **3.0x** |
| uniq | repetitive 10MB | 0.0317s | 0.0039s | 0.0179s | **8.2x** | **4.6x** |
| tac | reverse 100KB text | 0.0011s | 0.0013s | 0.0014s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0023s | 0.0017s | 0.0020s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0132s | 0.0052s | 0.0069s | **2.5x** | **1.3x** |
| tac | reverse 100MB text | 0.1266s | 0.0307s | 0.0603s | **4.1x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0115s | 0.0053s | 0.0065s | **2.2x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0250s | 0.0109s | 0.0126s | **2.3x** | **1.2x** |
| tac | custom separator 1MB | 0.0066s | 0.0046s | 0.0059s | **1.4x** | **1.3x** |
