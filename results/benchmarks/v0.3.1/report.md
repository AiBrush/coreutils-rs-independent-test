# fcoreutils v0.3.1 — Detailed Results

Generated: 2026-02-17 06:44:37 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **0.9x** | **1.0x** |
| wc | default 1MB text | 0.0039s | 0.0026s | 0.0035s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0347s | 0.0067s | 0.0261s | **5.2x** | **3.9x** |
| wc | default 100MB text | 0.3000s | 0.0460s | 0.2275s | **6.5x** | **4.9x** |
| wc | -l 10MB text | 0.0044s | 0.0022s | 0.0029s | **2.0x** | **1.3x** |
| wc | -w 10MB text | 0.0346s | 0.0065s | 0.0234s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0346s | 0.0026s | 0.0030s | **13.3x** | **1.1x** |
| wc | -L 10MB text | 0.0346s | 0.0064s | 0.0180s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2347s | 0.0173s | 0.1175s | **13.6x** | **6.8x** |
| wc | default 10MB repetitive | 0.0533s | 0.0086s | 0.0376s | **6.2x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0013s | 0.0014s | 0.0017s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0186s | 0.0038s | 0.0063s | **4.8x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0038s | 0.0062s | **4.9x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0187s | 0.0033s | 0.0072s | **5.7x** | **2.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0047s | 0.0163s | **4.5x** | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0035s | 0.0128s | **6.6x** | **3.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0032s | 0.0162s | **8.4x** | **5.1x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0018s | 0.0018s | **1.9x** | **1.0x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0010s | 0.0009s | **0.7x** | **0.9x** |
| sha256sum | single 100KB text | 0.0012s | 0.0020s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0018s | 0.0027s | 0.0037s | **0.7x** | **1.4x** |
| sha256sum | single 10MB text | 0.0076s | 0.0087s | 0.0277s | **0.9x** | **3.2x** |
| sha256sum | single 10MB binary | 0.0077s | 0.0086s | 0.0285s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0691s | 0.0571s | 0.2629s | **1.2x** | **4.6x** |
| sha256sum | 10 files | 0.0011s | 0.0013s | 0.0012s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0018s | 0.0021s | 0.0017s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0021s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0031s | 0.0035s | 0.0027s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0214s | 0.0178s | 0.0180s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0219s | 0.0181s | 0.0182s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2007s | 0.1446s | 0.1666s | **1.4x** | **1.2x** |
| md5sum | 10 files | 0.0011s | 0.0013s | 0.0011s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0017s | 0.0020s | 0.0017s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0010s | 0.0012s | **0.9x** | **1.1x** |
| b2sum | single 1MB text | 0.0021s | 0.0023s | 0.0024s | **0.9x** | **1.1x** |
| b2sum | single 10MB text | 0.0144s | 0.0141s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0147s | 0.0143s | 0.0142s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1354s | 0.1167s | 0.1296s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0145s | 0.0139s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0140s | 0.0140s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0018s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0009s | 0.0010s | 0.0010s | **0.9x** | **1.0x** |
| base64 | encode 1MB text | 0.0017s | 0.0016s | 0.0016s | **1.1x** | **1.0x** |
| base64 | encode 10MB text | 0.0100s | 0.0037s | 0.0073s | **2.7x** | **2.0x** |
| base64 | encode 10MB binary | 0.0103s | 0.0036s | 0.0072s | **2.9x** | **2.0x** |
| base64 | decode 1MB | 0.0038s | 0.0016s | 0.0036s | **2.3x** | **2.2x** |
| base64 | decode 10MB | 0.0308s | 0.0060s | 0.0268s | **5.1x** | **4.5x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0040s | 0.0075s | **2.5x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0029s | 0.0074s | **2.7x** | **2.5x** |
| sort | lexicographic 1MB | 0.0077s | 0.0027s | 0.0045s | **2.8x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0528s | 0.0064s | 0.0304s | **8.2x** | **4.7x** |
| sort | already sorted 10MB | 0.0257s | 0.0037s | 0.0137s | **6.9x** | **3.7x** |
| sort | reverse sorted 10MB | 0.0252s | 0.0046s | 0.0141s | **5.5x** | **3.1x** |
| sort | -n numeric 10MB | 0.0700s | 0.0040s | 0.0650s | **17.7x** | **16.4x** |
| sort | -r reverse 10MB | 0.0533s | 0.0064s | 0.0314s | **8.3x** | **4.9x** |
| sort | -u unique 10MB | 0.0556s | 0.0085s | 0.0370s | **6.5x** | **4.3x** |
| sort | -t, -k2 CSV 10MB | 0.0718s | 0.0147s | 0.0712s | **4.9x** | **4.9x** |
| sort | repetitive 10MB | 0.0461s | 0.0104s | 0.0370s | **4.4x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0517s | 0.0066s | 0.0316s | **7.9x** | **4.8x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0018s | 0.0018s | **1.0x** | **1.0x** |
| tr | a-z to A-Z 10MB | 0.0092s | 0.0044s | 0.0068s | **2.1x** | **1.5x** |
| tr | -d digits 10MB | 0.0113s | 0.0053s | 0.0102s | **2.1x** | **1.9x** |
| tr | -d lowercase 10MB | 0.0192s | 0.0067s | 0.0169s | **2.9x** | **2.5x** |
| tr | -s spaces 10MB | 0.0167s | 0.0044s | 0.0115s | **3.8x** | **2.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0044s | 0.0068s | **1.9x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0052s | 0.0103s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0040s | 0.0079s | **2.3x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0093s | 0.0028s | 0.0088s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0169s | 0.0032s | 0.0100s | **5.3x** | **3.1x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0030s | 0.0089s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0070s | 0.0118s | **4.2x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0027s | 0.0089s | **3.4x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0027s | 0.0087s | **3.4x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0041s | 0.0099s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0490s | 0.0035s | 0.0153s | **14.0x** | **4.4x** |
| tac | reverse 100KB text | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| tac | reverse 1MB text | 0.0017s | 0.0015s | 0.0016s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0089s | 0.0035s | 0.0051s | **2.5x** | **1.5x** |
| tac | reverse 100MB text | 0.0861s | 0.0202s | 0.0434s | **4.3x** | **2.2x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0035s | 0.0046s | **2.3x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0194s | 0.0068s | 0.0089s | **2.8x** | **1.3x** |
| tac | custom separator 1MB | 0.0044s | 0.0033s | 0.0039s | **1.3x** | **1.2x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0012s | 0.0016s | **1.1x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0030s | 0.0038s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0541s | 0.0031s | 0.0298s | **17.7x** | **9.8x** |
| wc | default 100MB text | 0.4795s | 0.0141s | 0.2546s | **34.0x** | **18.1x** |
| wc | -l 10MB text | 0.0020s | 0.0025s | 0.0020s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0543s | 0.0089s | 0.0254s | **6.1x** | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0542s | 0.0029s | 0.0019s | **18.6x** | **0.7x** |
| wc | -L 10MB text | 0.0542s | 0.0098s | 0.0195s | **5.6x** | **2.0x** |
| wc | default 10MB binary | 0.3178s | 0.0275s | 0.1544s | **11.6x** | **5.6x** |
| wc | default 10MB repetitive | 0.0729s | 0.0046s | 0.0394s | **16.0x** | **8.7x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.9x** | **1.2x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0041s | 0.0073s | **5.6x** | **1.8x** |
| cut | -c1-100 10MB CSV | 0.0226s | 0.0042s | 0.0074s | **5.4x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0037s | 0.0087s | **4.4x** | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0216s | 0.0068s | 0.0177s | **3.2x** | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0239s | 0.0049s | 0.0134s | **4.8x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0306s | 0.0043s | 0.0162s | **7.1x** | **3.7x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0021s | 0.0020s | **1.6x** | **1.0x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0083s | 0.0101s | 0.0083s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0088s | 0.0101s | 0.0087s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0759s | 0.0753s | 0.0753s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| sha256sum | 100 files | 0.0024s | 0.0026s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0170s | 0.0176s | 0.0212s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0178s | 0.0185s | 0.0222s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1611s | 0.1529s | 0.2033s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0014s | 0.0014s | **1.0x** | **1.0x** |
| md5sum | 100 files | 0.0023s | 0.0025s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0011s | 0.0011s | 0.0014s | **1.0x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0124s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0156s | 0.0129s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1425s | 0.1115s | 0.1131s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0148s | 0.0122s | 0.0121s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0123s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0021s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0014s | 0.0018s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0122s | 0.0045s | 0.0081s | **2.7x** | **1.8x** |
| base64 | encode 10MB binary | 0.0127s | 0.0046s | 0.0084s | **2.7x** | **1.8x** |
| base64 | decode 1MB | 0.0040s | 0.0014s | 0.0043s | **2.9x** | **3.2x** |
| base64 | decode 10MB | 0.0322s | 0.0058s | 0.0337s | **5.6x** | **5.8x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0045s | 0.0081s | **2.7x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0035s | 0.0072s | **2.4x** | **2.0x** |
| sort | lexicographic 1MB | 0.0086s | 0.0033s | 0.0054s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0538s | 0.0097s | 0.0353s | **5.6x** | **3.7x** |
| sort | already sorted 10MB | 0.0261s | 0.0043s | 0.0177s | **6.1x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0272s | 0.0066s | 0.0179s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0733s | 0.0058s | 0.0744s | **12.7x** | **12.9x** |
| sort | -r reverse 10MB | 0.0546s | 0.0095s | 0.0357s | **5.7x** | **3.7x** |
| sort | -u unique 10MB | 0.0573s | 0.0100s | 0.0396s | **5.7x** | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0663s | 0.0190s | 0.0823s | **3.5x** | **4.3x** |
| sort | repetitive 10MB | 0.0563s | 0.0122s | 0.0380s | **4.6x** | **3.1x** |
| sort | --parallel=4 10MB | 0.0541s | 0.0100s | 0.0363s | **5.4x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0040s | 0.0074s | **3.2x** | **1.9x** |
| tr | -d digits 10MB | 0.0167s | 0.0043s | 0.0145s | **3.9x** | **3.4x** |
| tr | -d lowercase 10MB | 0.0290s | 0.0051s | 0.0225s | **5.7x** | **4.4x** |
| tr | -s spaces 10MB | 0.0260s | 0.0039s | 0.0276s | **6.7x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0037s | 0.0075s | **3.3x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0166s | 0.0043s | 0.0143s | **3.9x** | **3.3x** |
| tr | translate binary 10MB | 0.0118s | 0.0040s | 0.0084s | **3.0x** | **2.1x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0036s | 0.0113s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0139s | 0.0035s | 0.0133s | **3.9x** | **3.8x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0035s | 0.0111s | **3.4x** | **3.2x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0093s | 0.0158s | **3.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0034s | 0.0112s | **3.5x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0035s | 0.0112s | **3.5x** | **3.2x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0044s | 0.0133s | **3.2x** | **3.0x** |
| uniq | repetitive 10MB | 0.0418s | 0.0041s | 0.0160s | **10.1x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0019s | 0.0015s | 0.0018s | **1.3x** | **1.2x** |
| tac | reverse 10MB text | 0.0105s | 0.0038s | 0.0059s | **2.7x** | **1.5x** |
| tac | reverse 100MB text | 0.1038s | 0.0223s | 0.0521s | **4.7x** | **2.3x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0043s | 0.0057s | **2.2x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0235s | 0.0074s | 0.0113s | **3.2x** | **1.5x** |
| tac | custom separator 1MB | 0.0060s | 0.0036s | 0.0053s | **1.7x** | **1.5x** |
