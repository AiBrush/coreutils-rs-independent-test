# fcoreutils v0.0.61 — Detailed Results

Generated: 2026-02-15 16:21:32 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Linux_aarch64 | 413 | 413 | 0 | 100.0% |
| Linux_x86_64 | 236 | 21 | 215 | 8.9% |

**Overall: 434/649 (66.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0038s | 0.0026s | **1.4x** |
| wc | default 10MB text | 0.0348s | 0.0068s | **5.1x** |
| wc | default 100MB text | 0.2893s | 0.0421s | **6.9x** |
| wc | -l 10MB text | 0.0044s | 0.0021s | **2.1x** |
| wc | -w 10MB text | 0.0347s | 0.0065s | **5.4x** |
| wc | -c 10MB text | 0.0007s | 0.0010s | **0.7x** |
| wc | -m 10MB text | 0.0347s | 0.0024s | **14.2x** |
| wc | -L 10MB text | 0.0347s | 0.0063s | **5.5x** |
| wc | default 10MB binary | 0.2348s | 0.0173s | **13.6x** |
| wc | default 10MB repetitive | 0.0528s | 0.0081s | **6.5x** |
| wc | 10 files | 0.0008s | 0.0011s | **0.8x** |
| wc | 100 files | 0.0013s | 0.0014s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0034s | **5.5x** |
| cut | -c1-100 10MB CSV | 0.0190s | 0.0034s | **5.6x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0042s | **4.5x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0045s | **4.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0038s | **6.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0268s | 0.0051s | **5.3x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0028s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0011s | **0.7x** |
| sha256sum | single 100KB text | 0.0012s | 0.0020s | **0.6x** |
| sha256sum | single 1MB text | 0.0017s | 0.0025s | **0.7x** |
| sha256sum | single 10MB text | 0.0073s | 0.0073s | **1.0x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0077s | **1.1x** |
| sha256sum | single 100MB text | 0.0585s | 0.0535s | **1.1x** |
| sha256sum | 10 files | 0.0011s | 0.0019s | **0.6x** |
| sha256sum | 100 files | 0.0017s | 0.0024s | **0.7x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0036s | **0.9x** |
| md5sum | single 10MB text | 0.0214s | 0.0163s | **1.3x** |
| md5sum | single 10MB binary | 0.0225s | 0.0171s | **1.3x** |
| md5sum | single 100MB text | 0.1899s | 0.1411s | **1.3x** |
| md5sum | 10 files | 0.0011s | 0.0020s | **0.6x** |
| md5sum | 100 files | 0.0018s | 0.0025s | **0.7x** |
| b2sum | single 100KB text | 0.0009s | 0.0012s | **0.7x** |
| b2sum | single 1MB text | 0.0021s | 0.0023s | **0.9x** |
| b2sum | single 10MB text | 0.0146s | 0.0131s | **1.1x** |
| b2sum | single 10MB binary | 0.0145s | 0.0136s | **1.1x** |
| b2sum | single 100MB text | 0.1251s | 0.1186s | **1.1x** |
| b2sum | -l 256 10MB | 0.0145s | 0.0133s | **1.1x** |
| b2sum | -l 128 10MB | 0.0141s | 0.0131s | **1.1x** |
| b2sum | 100 files | 0.0017s | 0.0014s | **1.2x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | **0.9x** |
| base64 | encode 1MB text | 0.0017s | 0.0017s | **1.0x** |
| base64 | encode 10MB text | 0.0103s | 0.0035s | **2.9x** |
| base64 | encode 10MB binary | 0.0101s | 0.0033s | **3.0x** |
| base64 | decode 1MB | 0.0038s | 0.0024s | **1.6x** |
| base64 | decode 10MB | 0.0308s | 0.0149s | **2.1x** |
| base64 | encode -w 76 10MB | 0.0098s | 0.0036s | **2.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0081s | 0.0032s | **2.5x** |
| sort | lexicographic 1MB | 0.0075s | 0.0027s | **2.7x** |
| sort | lexicographic 10MB random | 0.0518s | 0.0061s | **8.5x** |
| sort | already sorted 10MB | 0.0244s | 0.0044s | **5.5x** |
| sort | reverse sorted 10MB | 0.0242s | 0.0053s | **4.6x** |
| sort | -n numeric 10MB | 0.0705s | 0.0544s | **1.3x** |
| sort | -r reverse 10MB | 0.0521s | 0.0066s | **7.9x** |
| sort | -u unique 10MB | 0.0550s | 0.0132s | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0717s | 0.0196s | **3.7x** |
| sort | repetitive 10MB | 0.0430s | 0.0075s | **5.7x** |
| sort | --parallel=4 10MB | 0.0509s | 0.0060s | **8.4x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0019s | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0087s | 0.0073s | **1.2x** |
| tr | -d digits 10MB | 0.0112s | 0.0075s | **1.5x** |
| tr | -d lowercase 10MB | 0.0188s | 0.0110s | **1.7x** |
| tr | -s spaces 10MB | 0.0168s | 0.0072s | **2.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0072s | **1.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0112s | 0.0076s | **1.5x** |
| tr | translate binary 10MB | 0.0090s | 0.0086s | **1.1x** |
| uniq | default 10MB many duplicates | 0.0092s | 0.0047s | **2.0x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0032s | **5.1x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0047s | **2.0x** |
| uniq | -c count 10MB sorted | 0.0291s | 0.0065s | **4.4x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0046s | **2.0x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0046s | **2.0x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0042s | **3.8x** |
| uniq | repetitive 10MB | 0.0464s | 0.0043s | **10.9x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | **0.7x** |
| tac | reverse 1MB text | 0.0017s | 0.0017s | **1.0x** |
| tac | reverse 10MB text | 0.0088s | 0.0051s | **1.7x** |
| tac | reverse 100MB text | 0.0772s | 0.0427s | **1.8x** |
| tac | reverse CSV 10MB | 0.0083s | 0.0046s | **1.8x** |
| tac | reverse repetitive 10MB | 0.0170s | 0.0094s | **1.8x** |
| tac | custom separator 1MB | 0.0044s | 0.0035s | **1.3x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | N/A | - | - |
| wc | default 1MB text | N/A | - | - |
| wc | default 10MB text | N/A | - | - |
| wc | default 100MB text | N/A | - | - |
| wc | -l 10MB text | N/A | - | - |
| wc | -w 10MB text | N/A | - | - |
| wc | -c 10MB text | N/A | - | - |
| wc | -m 10MB text | N/A | - | - |
| wc | -L 10MB text | N/A | - | - |
| wc | default 10MB binary | N/A | - | - |
| wc | default 10MB repetitive | N/A | - | - |
| wc | 10 files | N/A | - | - |
| wc | 100 files | N/A | - | - |
| cut | -b1-100 10MB CSV | N/A | - | - |
| cut | -c1-100 10MB CSV | N/A | - | - |
| cut | -d, -f1 10MB CSV | N/A | - | - |
| cut | -d, -f1,3,5 10MB CSV | N/A | - | - |
| cut | -d, -f2-4 10MB CSV | N/A | - | - |
| cut | --complement -d, -f1 10MB CSV | N/A | - | - |
| cut | -d, -f1 100KB text | N/A | - | - |
| cut | -d, -f1 1MB text | N/A | - | - |
| cut | -d: -f1 colon file | N/A | - | - |
| sha256sum | single 100KB text | N/A | - | - |
| sha256sum | single 1MB text | N/A | - | - |
| sha256sum | single 10MB text | N/A | - | - |
| sha256sum | single 10MB binary | N/A | - | - |
| sha256sum | single 100MB text | N/A | - | - |
| sha256sum | 10 files | N/A | - | - |
| sha256sum | 100 files | N/A | - | - |
| md5sum | single 100KB text | N/A | - | - |
| md5sum | single 1MB text | N/A | - | - |
| md5sum | single 10MB text | N/A | - | - |
| md5sum | single 10MB binary | N/A | - | - |
| md5sum | single 100MB text | N/A | - | - |
| md5sum | 10 files | N/A | - | - |
| md5sum | 100 files | N/A | - | - |
| b2sum | single 100KB text | N/A | - | - |
| b2sum | single 1MB text | N/A | - | - |
| b2sum | single 10MB text | N/A | - | - |
| b2sum | single 10MB binary | N/A | - | - |
| b2sum | single 100MB text | N/A | - | - |
| b2sum | -l 256 10MB | N/A | - | - |
| b2sum | -l 128 10MB | N/A | - | - |
| b2sum | 100 files | N/A | - | - |
| base64 | encode 100KB text | N/A | - | - |
| base64 | encode 1MB text | N/A | - | - |
| base64 | encode 10MB text | N/A | - | - |
| base64 | encode 10MB binary | N/A | - | - |
| base64 | decode 1MB | N/A | - | - |
| base64 | decode 10MB | N/A | - | - |
| base64 | encode -w 76 10MB | N/A | - | - |
| base64 | encode -w 0 (no wrap) 10MB | N/A | - | - |
| sort | lexicographic 1MB | N/A | - | - |
| sort | lexicographic 10MB random | N/A | - | - |
| sort | already sorted 10MB | N/A | - | - |
| sort | reverse sorted 10MB | N/A | - | - |
| sort | -n numeric 10MB | N/A | - | - |
| sort | -r reverse 10MB | N/A | - | - |
| sort | -u unique 10MB | N/A | - | - |
| sort | -t, -k2 CSV 10MB | N/A | - | - |
| sort | repetitive 10MB | N/A | - | - |
| sort | --parallel=4 10MB | N/A | - | - |
| tr | a-z to A-Z 1MB | N/A | - | - |
| tr | a-z to A-Z 10MB | N/A | - | - |
| tr | -d digits 10MB | N/A | - | - |
| tr | -d lowercase 10MB | N/A | - | - |
| tr | -s spaces 10MB | N/A | - | - |
| tr | [:lower:] to [:upper:] 10MB | N/A | - | - |
| tr | -d [:digit:] 10MB CSV | N/A | - | - |
| tr | translate binary 10MB | N/A | - | - |
| uniq | default 10MB many duplicates | N/A | - | - |
| uniq | default 10MB sorted (low dup) | N/A | - | - |
| uniq | -c count 10MB many dups | N/A | - | - |
| uniq | -c count 10MB sorted | N/A | - | - |
| uniq | -d duplicates only 10MB | N/A | - | - |
| uniq | -u unique only 10MB | N/A | - | - |
| uniq | -i case insensitive 10MB | N/A | - | - |
| uniq | repetitive 10MB | N/A | - | - |
| tac | reverse 100KB text | N/A | - | - |
| tac | reverse 1MB text | N/A | - | - |
| tac | reverse 10MB text | N/A | - | - |
| tac | reverse 100MB text | N/A | - | - |
| tac | reverse CSV 10MB | N/A | - | - |
| tac | reverse repetitive 10MB | N/A | - | - |
| tac | custom separator 1MB | N/A | - | - |
