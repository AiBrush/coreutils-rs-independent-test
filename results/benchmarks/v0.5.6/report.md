# fcoreutils v0.5.6 — Detailed Results

Generated: 2026-02-16 16:11:32 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 409 | 4 | 99.0% |
| Linux_x86_64 | 413 | 409 | 4 | 99.0% |

**Overall: 818/826 (99.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0011s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0026s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0347s | 0.0070s | 0.0261s | **5.0x** | **3.7x** |
| wc | default 100MB text | 0.2996s | 0.0457s | 0.2269s | **6.5x** | **5.0x** |
| wc | -l 10MB text | 0.0042s | 0.0021s | 0.0028s | **2.0x** | **1.4x** |
| wc | -w 10MB text | 0.0347s | 0.0062s | 0.0235s | **5.6x** | **3.8x** |
| wc | -c 10MB text | 0.0008s | 0.0009s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0347s | 0.0025s | 0.0028s | **14.1x** | **1.2x** |
| wc | -L 10MB text | 0.0347s | 0.0063s | 0.0180s | **5.5x** | **2.9x** |
| wc | default 10MB binary | 0.2358s | 0.0174s | 0.1179s | **13.6x** | **6.8x** |
| wc | default 10MB repetitive | 0.0528s | 0.0083s | 0.0369s | **6.4x** | **4.5x** |
| wc | 10 files | 0.0010s | 0.0011s | 0.0011s | **0.9x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0016s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0030s | 0.0063s | **6.2x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0031s | 0.0061s | **6.1x** | **2.0x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0031s | 0.0072s | **6.0x** | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0051s | 0.0163s | **4.2x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0046s | 0.0127s | **5.1x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0045s | 0.0163s | **5.9x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0016s | 0.0018s | **2.2x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0017s | 0.0027s | 0.0039s | **0.6x** | **1.5x** |
| sha256sum | single 10MB text | 0.0076s | 0.0086s | 0.0277s | **0.9x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0080s | 0.0090s | 0.0287s | **0.9x** | **3.2x** |
| sha256sum | single 100MB text | 0.0686s | 0.0563s | 0.2624s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | 0.0012s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0018s | 0.0022s | 0.0017s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0216s | 0.0178s | 0.0179s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0223s | 0.0184s | 0.0183s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2003s | 0.1438s | 0.1660s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0017s | 0.0012s | **0.6x** | **0.7x** |
| md5sum | 100 files | 0.0017s | 0.0021s | 0.0017s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0020s | 0.0022s | 0.0024s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0143s | 0.0140s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0150s | 0.0144s | 0.0147s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1351s | 0.1157s | 0.1283s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0140s | 0.0135s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0140s | 0.0139s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0017s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0011s | 0.0009s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0016s | 0.0018s | **1.0x** | **1.1x** |
| base64 | encode 10MB text | 0.0096s | 0.0034s | 0.0072s | **2.8x** | **2.1x** |
| base64 | encode 10MB binary | 0.0102s | 0.0036s | 0.0073s | **2.8x** | **2.0x** |
| base64 | decode 1MB | 0.0038s | 0.0023s | 0.0036s | **1.7x** | **1.6x** |
| base64 | decode 10MB | 0.0306s | 0.0119s | 0.0267s | **2.6x** | **2.2x** |
| base64 | encode -w 76 10MB | 0.0097s | 0.0035s | 0.0073s | **2.8x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0076s | 0.0032s | 0.0073s | **2.4x** | **2.3x** |
| sort | lexicographic 1MB | 0.0077s | 0.0032s | 0.0043s | **2.4x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0523s | 0.0095s | 0.0298s | **5.5x** | **3.1x** |
| sort | already sorted 10MB | 0.0251s | 0.0037s | 0.0137s | **6.8x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0251s | 0.0051s | 0.0140s | **5.0x** | **2.8x** |
| sort | -n numeric 10MB | 0.0708s | 0.0040s | 0.0649s | **17.8x** | **16.3x** |
| sort | -r reverse 10MB | 0.0533s | 0.0095s | 0.0303s | **5.6x** | **3.2x** |
| sort | -u unique 10MB | 0.0555s | 0.0112s | 0.0367s | **4.9x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0723s | 0.0150s | 0.0700s | **4.8x** | **4.7x** |
| sort | repetitive 10MB | 0.0462s | 0.0103s | 0.0368s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0516s | 0.0092s | 0.0288s | **5.6x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | 0.0018s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0051s | 0.0069s | **1.7x** | **1.4x** |
| tr | -d digits 10MB | 0.0114s | 0.0069s | 0.0103s | **1.7x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0088s | 0.0170s | **2.1x** | **1.9x** |
| tr | -s spaces 10MB | 0.0171s | 0.0049s | 0.0115s | **3.5x** | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0085s | 0.0052s | 0.0069s | **1.6x** | **1.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0070s | 0.0103s | **1.6x** | **1.5x** |
| tr | translate binary 10MB | 0.0091s | 0.0050s | 0.0078s | **1.8x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0017s | 0.0088s | **5.3x** | **5.1x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0028s | 0.0099s | **6.0x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0091s | 0.0017s | 0.0088s | **5.5x** | **5.3x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0068s | 0.0115s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0017s | 0.0088s | **5.6x** | **5.3x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0017s | 0.0087s | **5.4x** | **5.1x** |
| uniq | -i case insensitive 10MB | 0.0164s | 0.0040s | 0.0098s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0480s | 0.0027s | 0.0146s | **17.7x** | **5.4x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0014s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0084s | 0.0044s | 0.0049s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0837s | 0.0223s | 0.0430s | **3.7x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0040s | 0.0045s | **2.0x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0182s | 0.0078s | 0.0086s | **2.3x** | **1.1x** |
| tac | custom separator 1MB | 0.0043s | 0.0030s | 0.0038s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0016s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0060s | 0.0028s | 0.0042s | **2.1x** | **1.5x** |
| wc | default 10MB text | 0.0551s | 0.0036s | 0.0341s | **15.4x** | **9.5x** |
| wc | default 100MB text | 0.4842s | 0.0172s | 0.2928s | **28.2x** | **17.1x** |
| wc | -l 10MB text | 0.0022s | 0.0027s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0548s | 0.0090s | 0.0345s | **6.1x** | **3.8x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.9x** | **1.3x** |
| wc | -m 10MB text | 0.0549s | 0.0030s | 0.0022s | **18.3x** | **0.7x** |
| wc | -L 10MB text | 0.0548s | 0.0112s | 0.0169s | **4.9x** | **1.5x** |
| wc | default 10MB binary | 0.3173s | 0.0278s | 0.1562s | **11.4x** | **5.6x** |
| wc | default 10MB repetitive | 0.0735s | 0.0054s | 0.0485s | **13.5x** | **8.9x** |
| wc | 10 files | 0.0010s | 0.0013s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0232s | 0.0037s | 0.0073s | **6.3x** | **2.0x** |
| cut | -c1-100 10MB CSV | 0.0233s | 0.0039s | 0.0075s | **6.0x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0171s | 0.0044s | 0.0083s | **3.9x** | **1.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0226s | 0.0074s | 0.0180s | **3.1x** | **2.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0057s | 0.0141s | **4.3x** | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0312s | 0.0059s | 0.0172s | **5.3x** | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0013s | 0.0012s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0018s | 0.0019s | **1.9x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0012s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0087s | 0.0104s | 0.0089s | **0.8x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0107s | 0.0089s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0768s | 0.0767s | 0.0768s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | 100 files | 0.0026s | 0.0027s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0025s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0038s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0177s | 0.0188s | 0.0222s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0188s | 0.0196s | 0.0237s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1628s | 0.1540s | 0.2058s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0029s | 0.0026s | **0.8x** | **0.9x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0015s | **0.9x** | **1.3x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.2x** |
| b2sum | single 10MB text | 0.0154s | 0.0140s | 0.0128s | **1.1x** | **0.9x** |
| b2sum | single 10MB binary | 0.0163s | 0.0134s | 0.0132s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1447s | 0.1128s | 0.1149s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0130s | 0.0125s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0158s | 0.0130s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0023s | 0.0022s | 0.0024s | **1.1x** | **1.1x** |
| base64 | encode 100KB text | 0.0011s | 0.0014s | 0.0012s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0021s | 0.0021s | 0.0018s | **1.0x** | **0.9x** |
| base64 | encode 10MB text | 0.0130s | 0.0058s | 0.0084s | **2.2x** | **1.5x** |
| base64 | encode 10MB binary | 0.0137s | 0.0046s | 0.0092s | **2.9x** | **2.0x** |
| base64 | decode 1MB | 0.0040s | 0.0036s | 0.0045s | **1.1x** | **1.2x** |
| base64 | decode 10MB | 0.0329s | 0.0197s | 0.0349s | **1.7x** | **1.8x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0046s | 0.0085s | **2.7x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0097s | 0.0049s | 0.0080s | **2.0x** | **1.6x** |
| sort | lexicographic 1MB | 0.0087s | 0.0036s | 0.0055s | **2.4x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0577s | 0.0095s | 0.0366s | **6.1x** | **3.8x** |
| sort | already sorted 10MB | 0.0269s | 0.0049s | 0.0189s | **5.5x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0065s | 0.0189s | **4.2x** | **2.9x** |
| sort | -n numeric 10MB | 0.0752s | 0.0055s | 0.0859s | **13.7x** | **15.6x** |
| sort | -r reverse 10MB | 0.0588s | 0.0100s | 0.0367s | **5.9x** | **3.7x** |
| sort | -u unique 10MB | 0.0615s | 0.0098s | 0.0424s | **6.3x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0683s | 0.0244s | 0.0900s | **2.8x** | **3.7x** |
| sort | repetitive 10MB | 0.0563s | 0.0130s | 0.0387s | **4.3x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0569s | 0.0106s | 0.0372s | **5.4x** | **3.5x** |
| tr | a-z to A-Z 1MB | 0.0025s | 0.0016s | 0.0021s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0047s | 0.0076s | **2.7x** | **1.6x** |
| tr | -d digits 10MB | 0.0164s | 0.0061s | 0.0135s | **2.7x** | **2.2x** |
| tr | -d lowercase 10MB | 0.0295s | 0.0069s | 0.0212s | **4.3x** | **3.1x** |
| tr | -s spaces 10MB | 0.0280s | 0.0047s | 0.0277s | **5.9x** | **5.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0129s | 0.0049s | 0.0077s | **2.6x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0164s | 0.0057s | 0.0139s | **2.9x** | **2.4x** |
| tr | translate binary 10MB | 0.0123s | 0.0045s | 0.0080s | **2.8x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0019s | 0.0111s | **6.3x** | **5.8x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0032s | 0.0131s | **4.3x** | **4.0x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0020s | 0.0115s | **6.0x** | **5.7x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0079s | 0.0161s | **3.7x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0019s | 0.0123s | **6.3x** | **6.4x** |
| uniq | -u unique only 10MB | 0.0122s | 0.0019s | 0.0112s | **6.5x** | **6.0x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0045s | 0.0135s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0425s | 0.0037s | 0.0168s | **11.4x** | **4.5x** |
| tac | reverse 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0109s | 0.0051s | 0.0067s | **2.1x** | **1.3x** |
| tac | reverse 100MB text | 0.1058s | 0.0285s | 0.0546s | **3.7x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0095s | 0.0050s | 0.0063s | **1.9x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0241s | 0.0094s | 0.0112s | **2.6x** | **1.2x** |
| tac | custom separator 1MB | 0.0061s | 0.0044s | 0.0059s | **1.4x** | **1.3x** |
