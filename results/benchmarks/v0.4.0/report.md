# fcoreutils v0.4.0 — Detailed Results

Generated: 2026-02-17 00:12:25 UTC

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
| wc | default 100KB text | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0038s | 0.0028s | 0.0035s | **1.4x** | **1.2x** |
| wc | default 10MB text | 0.0346s | 0.0064s | 0.0261s | **5.4x** | **4.1x** |
| wc | default 100MB text | 0.2965s | 0.0442s | 0.2249s | **6.7x** | **5.1x** |
| wc | -l 10MB text | 0.0046s | 0.0023s | 0.0032s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0348s | 0.0065s | 0.0237s | **5.4x** | **3.7x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0346s | 0.0025s | 0.0028s | **13.6x** | **1.1x** |
| wc | -L 10MB text | 0.0347s | 0.0064s | 0.0182s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2357s | 0.0174s | 0.1183s | **13.6x** | **6.8x** |
| wc | default 10MB repetitive | 0.0524s | 0.0085s | 0.0371s | **6.1x** | **4.3x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0018s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0034s | 0.0066s | **5.5x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0187s | 0.0034s | 0.0064s | **5.5x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0189s | 0.0031s | 0.0075s | **6.2x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0214s | 0.0051s | 0.0166s | **4.2x** | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0035s | 0.0130s | **6.7x** | **3.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0266s | 0.0046s | 0.0164s | **5.8x** | **3.6x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0016s | 0.0018s | **2.1x** | **1.1x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0012s | 0.0021s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0018s | 0.0028s | 0.0039s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0083s | 0.0092s | 0.0280s | **0.9x** | **3.0x** |
| sha256sum | single 10MB binary | 0.0084s | 0.0095s | 0.0292s | **0.9x** | **3.1x** |
| sha256sum | single 100MB text | 0.0669s | 0.0559s | 0.2603s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0013s | 0.0013s | 0.0011s | **1.0x** | **0.9x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0018s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | 0.0028s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0217s | 0.0181s | 0.0181s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0225s | 0.0188s | 0.0189s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1985s | 0.1431s | 0.1639s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0012s | 0.0013s | 0.0012s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0017s | 0.0021s | 0.0018s | **0.8x** | **0.9x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0146s | 0.0144s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0153s | 0.0149s | 0.0149s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1330s | 0.1156s | 0.1268s | **1.1x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0142s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0146s | 0.0143s | 0.0143s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0017s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0017s | 0.0015s | 0.0017s | **1.1x** | **1.1x** |
| base64 | encode 10MB text | 0.0106s | 0.0038s | 0.0076s | **2.8x** | **2.0x** |
| base64 | encode 10MB binary | 0.0107s | 0.0039s | 0.0079s | **2.8x** | **2.0x** |
| base64 | decode 1MB | 0.0039s | 0.0016s | 0.0036s | **2.4x** | **2.3x** |
| base64 | decode 10MB | 0.0309s | 0.0040s | 0.0272s | **7.6x** | **6.7x** |
| base64 | encode -w 76 10MB | 0.0104s | 0.0038s | 0.0076s | **2.7x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0081s | 0.0032s | 0.0079s | **2.5x** | **2.4x** |
| sort | lexicographic 1MB | 0.0078s | 0.0027s | 0.0045s | **2.9x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0539s | 0.0066s | 0.0326s | **8.2x** | **5.0x** |
| sort | already sorted 10MB | 0.0259s | 0.0037s | 0.0142s | **7.0x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0257s | 0.0050s | 0.0147s | **5.2x** | **3.0x** |
| sort | -n numeric 10MB | 0.0723s | 0.0041s | 0.0687s | **17.8x** | **16.9x** |
| sort | -r reverse 10MB | 0.0543s | 0.0067s | 0.0334s | **8.1x** | **4.9x** |
| sort | -u unique 10MB | 0.0574s | 0.0091s | 0.0398s | **6.3x** | **4.4x** |
| sort | -t, -k2 CSV 10MB | 0.0745s | 0.0163s | 0.0747s | **4.6x** | **4.6x** |
| sort | repetitive 10MB | 0.0475s | 0.0104s | 0.0380s | **4.6x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0532s | 0.0068s | 0.0340s | **7.8x** | **5.0x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | 0.0019s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0046s | 0.0067s | **1.9x** | **1.5x** |
| tr | -d digits 10MB | 0.0113s | 0.0054s | 0.0103s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0069s | 0.0170s | **2.8x** | **2.5x** |
| tr | -s spaces 10MB | 0.0167s | 0.0046s | 0.0116s | **3.6x** | **2.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0089s | 0.0050s | 0.0068s | **1.8x** | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0113s | 0.0053s | 0.0104s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0093s | 0.0050s | 0.0077s | **1.9x** | **1.6x** |
| uniq | default 10MB many duplicates | 0.0095s | 0.0028s | 0.0090s | **3.4x** | **3.2x** |
| uniq | default 10MB sorted (low dup) | 0.0169s | 0.0034s | 0.0102s | **5.0x** | **3.0x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0031s | 0.0090s | **3.1x** | **2.9x** |
| uniq | -c count 10MB sorted | 0.0298s | 0.0072s | 0.0120s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0095s | 0.0028s | 0.0089s | **3.5x** | **3.2x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0027s | 0.0091s | **3.4x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0040s | 0.0102s | **4.2x** | **2.5x** |
| uniq | repetitive 10MB | 0.0485s | 0.0038s | 0.0156s | **12.6x** | **4.1x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0016s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0094s | 0.0035s | 0.0051s | **2.7x** | **1.5x** |
| tac | reverse 100MB text | 0.0834s | 0.0211s | 0.0437s | **4.0x** | **2.1x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0037s | 0.0046s | **2.3x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0187s | 0.0068s | 0.0089s | **2.8x** | **1.3x** |
| tac | custom separator 1MB | 0.0046s | 0.0034s | 0.0040s | **1.4x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0058s | 0.0029s | 0.0038s | **2.0x** | **1.3x** |
| wc | default 10MB text | 0.0544s | 0.0032s | 0.0300s | **17.1x** | **9.4x** |
| wc | default 100MB text | 0.4839s | 0.0140s | 0.2543s | **34.6x** | **18.2x** |
| wc | -l 10MB text | 0.0020s | 0.0026s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0546s | 0.0114s | 0.0257s | **4.8x** | **2.3x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0545s | 0.0030s | 0.0020s | **18.1x** | **0.7x** |
| wc | -L 10MB text | 0.0543s | 0.0100s | 0.0196s | **5.4x** | **2.0x** |
| wc | default 10MB binary | 0.3240s | 0.0273s | 0.1539s | **11.8x** | **5.6x** |
| wc | default 10MB repetitive | 0.0731s | 0.0046s | 0.0396s | **16.1x** | **8.7x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0226s | 0.0035s | 0.0073s | **6.5x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0035s | 0.0073s | **6.4x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0035s | 0.0086s | **4.7x** | **2.4x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0075s | 0.0174s | **2.9x** | **2.3x** |
| cut | -d, -f2-4 10MB CSV | 0.0248s | 0.0046s | 0.0134s | **5.4x** | **2.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0303s | 0.0049s | 0.0164s | **6.2x** | **3.3x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0016s | 0.0020s | **2.1x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0085s | 0.0100s | 0.0084s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0090s | 0.0102s | 0.0088s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0764s | 0.0759s | 0.0756s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **0.9x** |
| sha256sum | 100 files | 0.0025s | 0.0025s | 0.0023s | **1.0x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0028s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0172s | 0.0180s | 0.0215s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0179s | 0.0187s | 0.0225s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1621s | 0.1540s | 0.2046s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0015s | 0.0014s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0126s | 0.0123s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0130s | 0.0129s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1439s | 0.1116s | 0.1137s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0124s | 0.0124s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0127s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | 0.0019s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0124s | 0.0041s | 0.0081s | **3.0x** | **2.0x** |
| base64 | encode 10MB binary | 0.0128s | 0.0041s | 0.0084s | **3.1x** | **2.0x** |
| base64 | decode 1MB | 0.0039s | 0.0014s | 0.0044s | **2.9x** | **3.2x** |
| base64 | decode 10MB | 0.0325s | 0.0047s | 0.0339s | **7.0x** | **7.2x** |
| base64 | encode -w 76 10MB | 0.0124s | 0.0042s | 0.0081s | **3.0x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0037s | 0.0073s | **2.3x** | **2.0x** |
| sort | lexicographic 1MB | 0.0085s | 0.0032s | 0.0055s | **2.7x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0542s | 0.0098s | 0.0357s | **5.5x** | **3.6x** |
| sort | already sorted 10MB | 0.0263s | 0.0042s | 0.0177s | **6.3x** | **4.2x** |
| sort | reverse sorted 10MB | 0.0274s | 0.0066s | 0.0178s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0735s | 0.0058s | 0.0761s | **12.6x** | **13.1x** |
| sort | -r reverse 10MB | 0.0544s | 0.0096s | 0.0359s | **5.6x** | **3.7x** |
| sort | -u unique 10MB | 0.0578s | 0.0099s | 0.0397s | **5.9x** | **4.0x** |
| sort | -t, -k2 CSV 10MB | 0.0663s | 0.0189s | 0.0810s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0550s | 0.0119s | 0.0376s | **4.6x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0542s | 0.0098s | 0.0359s | **5.5x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0037s | 0.0073s | **3.5x** | **2.0x** |
| tr | -d digits 10MB | 0.0170s | 0.0043s | 0.0141s | **4.0x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0048s | 0.0231s | **6.2x** | **4.8x** |
| tr | -s spaces 10MB | 0.0275s | 0.0038s | 0.0273s | **7.2x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0124s | 0.0038s | 0.0077s | **3.3x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0172s | 0.0043s | 0.0145s | **4.0x** | **3.4x** |
| tr | translate binary 10MB | 0.0125s | 0.0038s | 0.0080s | **3.3x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0036s | 0.0133s | **3.8x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0035s | 0.0112s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0091s | 0.0156s | **3.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0036s | 0.0112s | **3.3x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0035s | 0.0111s | **3.3x** | **3.1x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0044s | 0.0134s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0419s | 0.0041s | 0.0162s | **10.2x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| tac | reverse 1MB text | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0105s | 0.0038s | 0.0059s | **2.8x** | **1.5x** |
| tac | reverse 100MB text | 0.1039s | 0.0223s | 0.0521s | **4.7x** | **2.3x** |
| tac | reverse CSV 10MB | 0.0092s | 0.0041s | 0.0057s | **2.3x** | **1.4x** |
| tac | reverse repetitive 10MB | 0.0226s | 0.0075s | 0.0113s | **3.0x** | **1.5x** |
| tac | custom separator 1MB | 0.0059s | 0.0036s | 0.0053s | **1.6x** | **1.5x** |
