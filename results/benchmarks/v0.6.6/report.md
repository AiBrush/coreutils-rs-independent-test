# fcoreutils v0.6.6 — Detailed Results

Generated: 2026-02-16 16:11:32 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 410 | 3 | 99.3% |
| Linux_x86_64 | 413 | 410 | 3 | 99.3% |

**Overall: 820/826 (99.3%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **1.0x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0027s | 0.0034s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0341s | 0.0070s | 0.0257s | **4.9x** | **3.7x** |
| wc | default 100MB text | 0.3009s | 0.0472s | 0.2284s | **6.4x** | **4.8x** |
| wc | -l 10MB text | 0.0042s | 0.0021s | 0.0027s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0340s | 0.0063s | 0.0232s | **5.4x** | **3.7x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0341s | 0.0023s | 0.0025s | **15.1x** | **1.1x** |
| wc | -L 10MB text | 0.0340s | 0.0059s | 0.0175s | **5.7x** | **3.0x** |
| wc | default 10MB binary | 0.2363s | 0.0178s | 0.1186s | **13.2x** | **6.6x** |
| wc | default 10MB repetitive | 0.0542s | 0.0084s | 0.0379s | **6.5x** | **4.5x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0012s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0013s | 0.0015s | 0.0017s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0030s | 0.0067s | **6.2x** | **2.2x** |
| cut | -c1-100 10MB CSV | 0.0189s | 0.0030s | 0.0068s | **6.3x** | **2.3x** |
| cut | -d, -f1 10MB CSV | 0.0191s | 0.0046s | 0.0076s | **4.1x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0054s | 0.0168s | **4.0x** | **3.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0234s | 0.0047s | 0.0131s | **5.0x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0267s | 0.0047s | 0.0166s | **5.7x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0036s | 0.0028s | 0.0019s | **1.3x** | **0.7x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0026s | 0.0015s | **0.5x** | **0.6x** |
| sha256sum | single 1MB text | 0.0018s | 0.0031s | 0.0039s | **0.6x** | **1.3x** |
| sha256sum | single 10MB text | 0.0079s | 0.0088s | 0.0274s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0092s | 0.0288s | **0.9x** | **3.1x** |
| sha256sum | single 100MB text | 0.0704s | 0.0702s | 0.2647s | **1.0x** | **3.8x** |
| sha256sum | 10 files | 0.0012s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0018s | 0.0022s | 0.0018s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0035s | 0.0029s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0211s | 0.0175s | 0.0176s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0222s | 0.0184s | 0.0184s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2024s | 0.1453s | 0.1678s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0018s | 0.0012s | **0.6x** | **0.7x** |
| md5sum | 100 files | 0.0017s | 0.0025s | 0.0018s | **0.7x** | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.8x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0142s | 0.0136s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0150s | 0.0144s | 0.0147s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1367s | 0.1159s | 0.1302s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0142s | 0.0135s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0142s | 0.0135s | 0.0138s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0018s | 0.0018s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0017s | 0.0017s | **1.0x** | **1.0x** |
| base64 | encode 10MB text | 0.0099s | 0.0034s | 0.0073s | **2.9x** | **2.1x** |
| base64 | encode 10MB binary | 0.0105s | 0.0036s | 0.0077s | **2.9x** | **2.1x** |
| base64 | decode 1MB | 0.0039s | 0.0019s | 0.0036s | **2.0x** | **1.9x** |
| base64 | decode 10MB | 0.0308s | 0.0042s | 0.0272s | **7.4x** | **6.6x** |
| base64 | encode -w 76 10MB | 0.0099s | 0.0034s | 0.0072s | **2.9x** | **2.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0034s | 0.0072s | **2.3x** | **2.1x** |
| sort | lexicographic 1MB | 0.0076s | 0.0032s | 0.0044s | **2.4x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0531s | 0.0107s | 0.0341s | **5.0x** | **3.2x** |
| sort | already sorted 10MB | 0.0252s | 0.0034s | 0.0141s | **7.3x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0255s | 0.0050s | 0.0148s | **5.2x** | **3.0x** |
| sort | -n numeric 10MB | 0.0713s | 0.0042s | 0.0687s | **16.9x** | **16.3x** |
| sort | -r reverse 10MB | 0.0536s | 0.0102s | 0.0333s | **5.3x** | **3.3x** |
| sort | -u unique 10MB | 0.0563s | 0.0117s | 0.0394s | **4.8x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0735s | 0.0166s | 0.0740s | **4.4x** | **4.5x** |
| sort | repetitive 10MB | 0.0470s | 0.0107s | 0.0377s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0529s | 0.0104s | 0.0327s | **5.1x** | **3.1x** |
| tr | a-z to A-Z 1MB | 0.0019s | 0.0016s | 0.0018s | **1.2x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0044s | 0.0069s | **2.0x** | **1.5x** |
| tr | -d digits 10MB | 0.0111s | 0.0053s | 0.0104s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0187s | 0.0068s | 0.0169s | **2.7x** | **2.5x** |
| tr | -s spaces 10MB | 0.0165s | 0.0042s | 0.0113s | **3.9x** | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0083s | 0.0041s | 0.0068s | **2.0x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0054s | 0.0102s | **2.1x** | **1.9x** |
| tr | translate binary 10MB | 0.0090s | 0.0044s | 0.0078s | **2.1x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0017s | 0.0090s | **5.6x** | **5.3x** |
| uniq | default 10MB sorted (low dup) | 0.0168s | 0.0027s | 0.0100s | **6.2x** | **3.7x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0018s | 0.0090s | **5.4x** | **5.0x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0068s | 0.0117s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0017s | 0.0091s | **5.4x** | **5.2x** |
| uniq | -u unique only 10MB | 0.0094s | 0.0017s | 0.0090s | **5.5x** | **5.2x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0041s | 0.0098s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0490s | 0.0031s | 0.0163s | **16.0x** | **5.3x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0016s | **1.1x** | **1.1x** |
| tac | reverse 10MB text | 0.0083s | 0.0044s | 0.0049s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0871s | 0.0240s | 0.0458s | **3.6x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0044s | 0.0045s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0193s | 0.0094s | 0.0090s | **2.1x** | **1.0x** |
| tac | custom separator 1MB | 0.0044s | 0.0037s | 0.0039s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0046s | 0.0031s | 0.0037s | **1.5x** | **1.2x** |
| wc | default 10MB text | 0.0424s | 0.0025s | 0.0320s | **16.7x** | **12.6x** |
| wc | default 100MB text | 0.3787s | 0.0112s | 0.2798s | **34.0x** | **25.1x** |
| wc | -l 10MB text | 0.0016s | 0.0020s | 0.0017s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0425s | 0.0094s | 0.0286s | **4.5x** | **3.0x** |
| wc | -c 10MB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0425s | 0.0022s | 0.0016s | **19.1x** | **0.7x** |
| wc | -L 10MB text | 0.0426s | 0.0101s | 0.0167s | **4.2x** | **1.6x** |
| wc | default 10MB binary | 0.3215s | 0.0307s | 0.1575s | **10.5x** | **5.1x** |
| wc | default 10MB repetitive | 0.0553s | 0.0034s | 0.0354s | **16.3x** | **10.4x** |
| wc | 10 files | 0.0008s | 0.0013s | 0.0010s | **0.7x** | **0.8x** |
| wc | 100 files | 0.0011s | 0.0013s | 0.0014s | **0.8x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0192s | 0.0029s | 0.0055s | **6.7x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0030s | 0.0055s | **6.4x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0208s | 0.0047s | 0.0068s | **4.5x** | **1.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0237s | 0.0072s | 0.0156s | **3.3x** | **2.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0260s | 0.0050s | 0.0118s | **5.1x** | **2.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0295s | 0.0050s | 0.0146s | **5.9x** | **2.9x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0011s | 0.0008s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0039s | 0.0027s | 0.0016s | **1.4x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0012s | 0.0008s | **0.5x** | **0.7x** |
| sha256sum | single 100KB text | 0.0010s | 0.0027s | 0.0010s | **0.4x** | **0.4x** |
| sha256sum | single 1MB text | 0.0029s | 0.0040s | 0.0018s | **0.7x** | **0.5x** |
| sha256sum | single 10MB text | 0.0095s | 0.0118s | 0.0094s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0099s | 0.0118s | 0.0099s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0893s | 0.0931s | 0.0895s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0010s | 0.0018s | 0.0010s | **0.6x** | **0.5x** |
| sha256sum | 100 files | 0.0015s | 0.0022s | 0.0015s | **0.7x** | **0.7x** |
| md5sum | single 100KB text | 0.0011s | 0.0020s | 0.0011s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0024s | 0.0033s | 0.0029s | **0.7x** | **0.9x** |
| md5sum | single 10MB text | 0.0156s | 0.0170s | 0.0200s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0165s | 0.0177s | 0.0223s | **0.9x** | **1.3x** |
| md5sum | single 100MB text | 0.1518s | 0.1390s | 0.1954s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0009s | 0.0019s | 0.0010s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0014s | 0.0024s | 0.0014s | **0.6x** | **0.6x** |
| b2sum | single 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0020s | 0.0019s | 0.0019s | **1.1x** | **1.0x** |
| b2sum | single 10MB text | 0.0139s | 0.0120s | 0.0109s | **1.2x** | **0.9x** |
| b2sum | single 10MB binary | 0.0148s | 0.0123s | 0.0115s | **1.2x** | **0.9x** |
| b2sum | single 100MB text | 0.1367s | 0.0971s | 0.1051s | **1.4x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0138s | 0.0122s | 0.0110s | **1.1x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0139s | 0.0122s | 0.0110s | **1.1x** | **0.9x** |
| b2sum | 100 files | 0.0014s | 0.0017s | 0.0014s | **0.8x** | **0.8x** |
| base64 | encode 100KB text | 0.0007s | 0.0012s | 0.0008s | **0.6x** | **0.7x** |
| base64 | encode 1MB text | 0.0017s | 0.0017s | 0.0012s | **1.0x** | **0.7x** |
| base64 | encode 10MB text | 0.0103s | 0.0041s | 0.0046s | **2.5x** | **1.1x** |
| base64 | encode 10MB binary | 0.0106s | 0.0041s | 0.0048s | **2.6x** | **1.2x** |
| base64 | decode 1MB | 0.0036s | 0.0020s | 0.0035s | **1.8x** | **1.7x** |
| base64 | decode 10MB | 0.0299s | 0.0041s | 0.0268s | **7.2x** | **6.5x** |
| base64 | encode -w 76 10MB | 0.0102s | 0.0040s | 0.0046s | **2.6x** | **1.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0079s | 0.0038s | 0.0049s | **2.1x** | **1.3x** |
| sort | lexicographic 1MB | 0.0075s | 0.0035s | 0.0044s | **2.1x** | **1.2x** |
| sort | lexicographic 10MB random | 0.0506s | 0.0095s | 0.0307s | **5.3x** | **3.2x** |
| sort | already sorted 10MB | 0.0221s | 0.0044s | 0.0138s | **5.0x** | **3.1x** |
| sort | reverse sorted 10MB | 0.0233s | 0.0058s | 0.0141s | **4.0x** | **2.5x** |
| sort | -n numeric 10MB | 0.0700s | 0.0055s | 0.0644s | **12.7x** | **11.7x** |
| sort | -r reverse 10MB | 0.0505s | 0.0093s | 0.0315s | **5.4x** | **3.4x** |
| sort | -u unique 10MB | 0.0555s | 0.0092s | 0.0374s | **6.0x** | **4.1x** |
| sort | -t, -k2 CSV 10MB | 0.0651s | 0.0206s | 0.0759s | **3.2x** | **3.7x** |
| sort | repetitive 10MB | 0.0490s | 0.0133s | 0.0316s | **3.7x** | **2.4x** |
| sort | --parallel=4 10MB | 0.0508s | 0.0094s | 0.0316s | **5.4x** | **3.4x** |
| tr | a-z to A-Z 1MB | 0.0015s | 0.0013s | 0.0016s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0077s | 0.0037s | 0.0063s | **2.1x** | **1.7x** |
| tr | -d digits 10MB | 0.0165s | 0.0041s | 0.0129s | **4.1x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0290s | 0.0048s | 0.0230s | **6.0x** | **4.8x** |
| tr | -s spaces 10MB | 0.0243s | 0.0038s | 0.0270s | **6.4x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0076s | 0.0038s | 0.0064s | **2.0x** | **1.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0154s | 0.0040s | 0.0128s | **3.8x** | **3.2x** |
| tr | translate binary 10MB | 0.0077s | 0.0039s | 0.0072s | **2.0x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0088s | 0.0015s | 0.0098s | **6.0x** | **6.7x** |
| uniq | default 10MB sorted (low dup) | 0.0184s | 0.0028s | 0.0123s | **6.7x** | **4.5x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0015s | 0.0100s | **6.3x** | **6.8x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0069s | 0.0137s | **4.3x** | **2.0x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0015s | 0.0100s | **6.1x** | **6.7x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0014s | 0.0099s | **6.5x** | **7.0x** |
| uniq | -i case insensitive 10MB | 0.0184s | 0.0044s | 0.0124s | **4.2x** | **2.9x** |
| uniq | repetitive 10MB | 0.0490s | 0.0031s | 0.0144s | **15.7x** | **4.6x** |
| tac | reverse 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0015s | 0.0013s | 0.0013s | **1.1x** | **1.0x** |
| tac | reverse 10MB text | 0.0078s | 0.0040s | 0.0045s | **2.0x** | **1.1x** |
| tac | reverse 100MB text | 0.0817s | 0.0226s | 0.0429s | **3.6x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0041s | 0.0044s | **1.8x** | **1.1x** |
| tac | reverse repetitive 10MB | 0.0148s | 0.0080s | 0.0080s | **1.8x** | **1.0x** |
| tac | custom separator 1MB | 0.0049s | 0.0038s | 0.0038s | **1.3x** | **1.0x** |
