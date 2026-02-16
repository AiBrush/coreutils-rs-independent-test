# fcoreutils v0.0.8 — Detailed Results

Generated: 2026-02-16 12:55:39 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 400 | 13 | 96.9% |
| Linux_aarch64 | 413 | 401 | 12 | 97.1% |
| Linux_x86_64 | 413 | 401 | 12 | 97.1% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |

**Overall: 1202/1239 (97.0%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0008s | **1.2x** |
| wc | default 1MB text | 0.0037s | 0.0011s | **3.2x** |
| wc | default 10MB text | 0.0343s | 0.0028s | **12.4x** |
| wc | default 100MB text | 0.2918s | 0.0141s | **20.7x** |
| wc | -l 10MB text | 0.0038s | 0.0020s | **1.9x** |
| wc | -w 10MB text | 0.0344s | 0.0028s | **12.4x** |
| wc | -c 10MB text | 0.0008s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0341s | 0.0032s | **10.6x** |
| wc | -L 10MB text | 0.0343s | 0.0151s | **2.3x** |
| wc | default 10MB binary | 0.2338s | 0.0026s | **90.4x** |
| wc | default 10MB repetitive | 0.0505s | 0.0043s | **11.8x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0012s | 0.0013s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0035s | **5.3x** |
| cut | -c1-100 10MB CSV | 0.0182s | 0.0033s | **5.5x** |
| cut | -d, -f1 10MB CSV | 0.0184s | 0.0027s | **6.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0210s | 0.0044s | **4.7x** |
| cut | -d, -f2-4 10MB CSV | 0.0228s | 0.0043s | **5.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0263s | 0.0060s | **4.4x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0012s | **2.8x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0008s | **0.9x** |
| sha256sum | single 100KB text | 0.0011s | 0.0011s | **1.0x** |
| sha256sum | single 1MB text | 0.0016s | 0.0038s | **0.4x** |
| sha256sum | single 10MB text | 0.0072s | 0.0299s | **0.2x** |
| sha256sum | single 10MB binary | 0.0069s | 0.0313s | **0.2x** |
| sha256sum | single 100MB text | 0.0595s | 0.2889s | **0.2x** |
| sha256sum | 10 files | 0.0011s | 0.0012s | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0018s | **1.0x** |
| md5sum | single 100KB text | 0.0013s | 0.0010s | **1.3x** |
| md5sum | single 1MB text | 0.0030s | 0.0023s | **1.3x** |
| md5sum | single 10MB text | 0.0207s | 0.0161s | **1.3x** |
| md5sum | single 10MB binary | 0.0216s | 0.0164s | **1.3x** |
| md5sum | single 100MB text | 0.1926s | 0.1498s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0012s | **1.0x** |
| md5sum | 100 files | 0.0016s | 0.0017s | **0.9x** |
| b2sum | single 100KB text | 0.0008s | 0.0009s | **0.9x** |
| b2sum | single 1MB text | 0.0020s | 0.0021s | **1.0x** |
| b2sum | single 10MB text | 0.0137s | 0.0129s | **1.1x** |
| b2sum | single 10MB binary | 0.0139s | 0.0133s | **1.0x** |
| b2sum | single 100MB text | 0.1273s | 0.1187s | **1.1x** |
| b2sum | -l 256 10MB | 0.0139s | 0.0129s | **1.1x** |
| b2sum | -l 128 10MB | 0.0136s | 0.0128s | **1.1x** |
| b2sum | 100 files | 0.0016s | 0.0017s | **0.9x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | **0.9x** |
| base64 | encode 1MB text | 0.0016s | 0.0018s | **0.9x** |
| base64 | encode 10MB text | 0.0093s | 0.0072s | **1.3x** |
| base64 | encode 10MB binary | 0.0093s | 0.0073s | **1.3x** |
| base64 | decode 1MB | 0.0036s | 0.0025s | **1.4x** |
| base64 | decode 10MB | 0.0297s | 0.0173s | **1.7x** |
| base64 | encode -w 76 10MB | 0.0092s | 0.0073s | **1.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0074s | 0.0052s | **1.4x** |
| sort | lexicographic 1MB | 0.0074s | 0.0041s | **1.8x** |
| sort | lexicographic 10MB random | 0.0499s | 0.0169s | **3.0x** |
| sort | already sorted 10MB | 0.0233s | 0.0083s | **2.8x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0082s | **3.0x** |
| sort | -n numeric 10MB | 0.0677s | 0.0315s | **2.2x** |
| sort | -r reverse 10MB | 0.0505s | 0.0170s | **3.0x** |
| sort | -u unique 10MB | 0.0525s | 0.0186s | **2.8x** |
| sort | -t, -k2 CSV 10MB | 0.0693s | 0.0308s | **2.2x** |
| sort | repetitive 10MB | 0.0411s | 0.0207s | **2.0x** |
| sort | --parallel=4 10MB | 0.0492s | 0.0168s | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0026s | **0.7x** |
| tr | a-z to A-Z 10MB | 0.0088s | 0.0111s | **0.8x** |
| tr | -d digits 10MB | 0.0111s | 0.0147s | **0.8x** |
| tr | -d lowercase 10MB | 0.0190s | 0.0220s | **0.9x** |
| tr | -s spaces 10MB | 0.0166s | 0.0263s | **0.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0112s | **0.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0149s | **0.7x** |
| tr | translate binary 10MB | 0.0091s | 0.0122s | **0.7x** |
| uniq | default 10MB many duplicates | 0.0090s | 0.0046s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0160s | 0.0041s | **3.9x** |
| uniq | -c count 10MB many dups | 0.0089s | 0.0045s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0288s | 0.0053s | **5.5x** |
| uniq | -d duplicates only 10MB | 0.0090s | 0.0045s | **2.0x** |
| uniq | -u unique only 10MB | 0.0090s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0158s | 0.0046s | **3.5x** |
| uniq | repetitive 10MB | 0.0459s | 0.0068s | **6.8x** |
| tac | reverse 100KB text | 0.0008s | 0.0009s | **0.9x** |
| tac | reverse 1MB text | 0.0016s | 0.0016s | **1.0x** |
| tac | reverse 10MB text | 0.0083s | 0.0051s | **1.6x** |
| tac | reverse 100MB text | 0.0793s | 0.0436s | **1.8x** |
| tac | reverse CSV 10MB | 0.0080s | 0.0048s | **1.7x** |
| tac | reverse repetitive 10MB | 0.0162s | 0.0092s | **1.8x** |
| tac | custom separator 1MB | 0.0042s | 0.0039s | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0009s | **1.6x** |
| wc | default 1MB text | 0.0058s | 0.0010s | **5.9x** |
| wc | default 10MB text | 0.0545s | 0.0021s | **25.6x** |
| wc | default 100MB text | 0.4831s | 0.0107s | **45.2x** |
| wc | -l 10MB text | 0.0022s | 0.0020s | **1.1x** |
| wc | -w 10MB text | 0.0544s | 0.0020s | **26.8x** |
| wc | -c 10MB text | 0.0009s | 0.0008s | **1.0x** |
| wc | -m 10MB text | 0.0546s | 0.0033s | **16.4x** |
| wc | -L 10MB text | 0.0547s | 0.0155s | **3.5x** |
| wc | default 10MB binary | 0.3175s | 0.0023s | **136.6x** |
| wc | default 10MB repetitive | 0.0733s | 0.0034s | **21.6x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0020s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0046s | **5.0x** |
| cut | -c1-100 10MB CSV | 0.0228s | 0.0048s | **4.7x** |
| cut | -d, -f1 10MB CSV | 0.0166s | 0.0033s | **5.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0223s | 0.0069s | **3.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0067s | **3.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0097s | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0009s | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0014s | **2.4x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0008s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.5x** |
| sha256sum | single 1MB text | 0.0020s | 0.0015s | **1.3x** |
| sha256sum | single 10MB text | 0.0089s | 0.0081s | **1.1x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0082s | **1.1x** |
| sha256sum | single 100MB text | 0.0749s | 0.0732s | **1.0x** |
| sha256sum | 10 files | 0.0015s | 0.0015s | **1.0x** |
| sha256sum | 100 files | 0.0025s | 0.0025s | **1.0x** |
| md5sum | single 100KB text | 0.0015s | 0.0011s | **1.4x** |
| md5sum | single 1MB text | 0.0029s | 0.0026s | **1.1x** |
| md5sum | single 10MB text | 0.0174s | 0.0185s | **0.9x** |
| md5sum | single 10MB binary | 0.0183s | 0.0192s | **0.9x** |
| md5sum | single 100MB text | 0.1609s | 0.1749s | **0.9x** |
| md5sum | 10 files | 0.0015s | 0.0014s | **1.1x** |
| md5sum | 100 files | 0.0024s | 0.0024s | **1.0x** |
| b2sum | single 100KB text | 0.0011s | 0.0010s | **1.1x** |
| b2sum | single 1MB text | 0.0024s | 0.0021s | **1.1x** |
| b2sum | single 10MB text | 0.0153s | 0.0126s | **1.2x** |
| b2sum | single 10MB binary | 0.0161s | 0.0130s | **1.2x** |
| b2sum | single 100MB text | 0.1427s | 0.1169s | **1.2x** |
| b2sum | -l 256 10MB | 0.0154s | 0.0127s | **1.2x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0126s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0024s | **0.9x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0021s | **1.0x** |
| base64 | encode 10MB text | 0.0126s | 0.0060s | **2.1x** |
| base64 | encode 10MB binary | 0.0131s | 0.0057s | **2.3x** |
| base64 | decode 1MB | 0.0041s | 0.0033s | **1.2x** |
| base64 | decode 10MB | 0.0327s | 0.0208s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0126s | 0.0056s | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0089s | 0.0042s | **2.1x** |
| sort | lexicographic 1MB | 0.0088s | 0.0046s | **1.9x** |
| sort | lexicographic 10MB random | 0.0549s | 0.0179s | **3.1x** |
| sort | already sorted 10MB | 0.0267s | 0.0107s | **2.5x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0109s | **2.5x** |
| sort | -n numeric 10MB | 0.0746s | 0.0394s | **1.9x** |
| sort | -r reverse 10MB | 0.0561s | 0.0193s | **2.9x** |
| sort | -u unique 10MB | 0.0589s | 0.0182s | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0676s | 0.0350s | **1.9x** |
| sort | repetitive 10MB | 0.0554s | 0.0191s | **2.9x** |
| sort | --parallel=4 10MB | 0.0572s | 0.0199s | **2.9x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0026s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0138s | 0.0152s | **0.9x** |
| tr | -d digits 10MB | 0.0183s | 0.0183s | **1.0x** |
| tr | -d lowercase 10MB | 0.0299s | 0.0306s | **1.0x** |
| tr | -s spaces 10MB | 0.0291s | 0.0403s | **0.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0130s | 0.0149s | **0.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0179s | **0.9x** |
| tr | translate binary 10MB | 0.0120s | 0.0161s | **0.7x** |
| uniq | default 10MB many duplicates | 0.0121s | 0.0046s | **2.6x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0052s | **2.7x** |
| uniq | -c count 10MB many dups | 0.0124s | 0.0045s | **2.8x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0071s | **4.1x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0046s | **2.6x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0045s | **2.7x** |
| uniq | -i case insensitive 10MB | 0.0146s | 0.0058s | **2.5x** |
| uniq | repetitive 10MB | 0.0425s | 0.0068s | **6.3x** |
| tac | reverse 100KB text | 0.0012s | 0.0011s | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0020s | **1.0x** |
| tac | reverse 10MB text | 0.0109s | 0.0061s | **1.8x** |
| tac | reverse 100MB text | 0.1043s | 0.0453s | **2.3x** |
| tac | reverse CSV 10MB | 0.0094s | 0.0057s | **1.6x** |
| tac | reverse repetitive 10MB | 0.0234s | 0.0108s | **2.2x** |
| tac | custom separator 1MB | 0.0060s | 0.0055s | **1.1x** |
