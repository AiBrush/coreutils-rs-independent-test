# fcoreutils v0.2.9 — Detailed Results

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
| wc | default 100KB text | 0.0010s | 0.0011s | 0.0012s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0037s | 0.0024s | 0.0033s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0340s | 0.0063s | 0.0254s | **5.4x** | **4.1x** |
| wc | default 100MB text | 0.2974s | 0.0446s | 0.2252s | **6.7x** | **5.0x** |
| wc | -l 10MB text | 0.0038s | 0.0021s | 0.0024s | **1.8x** | **1.2x** |
| wc | -w 10MB text | 0.0339s | 0.0066s | 0.0228s | **5.1x** | **3.4x** |
| wc | -c 10MB text | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.1x** |
| wc | -m 10MB text | 0.0340s | 0.0023s | 0.0023s | **14.9x** | **1.0x** |
| wc | -L 10MB text | 0.0337s | 0.0063s | 0.0175s | **5.4x** | **2.8x** |
| wc | default 10MB binary | 0.2345s | 0.0168s | 0.1175s | **14.0x** | **7.0x** |
| wc | default 10MB repetitive | 0.0539s | 0.0085s | 0.0370s | **6.4x** | **4.4x** |
| wc | 10 files | 0.0007s | 0.0010s | 0.0010s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0012s | 0.0013s | 0.0015s | **0.9x** | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0185s | 0.0037s | 0.0058s | **4.9x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0184s | 0.0037s | 0.0058s | **5.0x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0184s | 0.0044s | 0.0069s | **4.2x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0047s | 0.0162s | **4.5x** | **3.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0229s | 0.0031s | 0.0125s | **7.3x** | **4.0x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0033s | 0.0160s | **8.1x** | **4.9x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0010s | 0.0009s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0014s | 0.0016s | **2.4x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0009s | **0.7x** | **1.0x** |
| sha256sum | single 100KB text | 0.0012s | 0.0020s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0016s | 0.0024s | 0.0037s | **0.7x** | **1.5x** |
| sha256sum | single 10MB text | 0.0070s | 0.0081s | 0.0270s | **0.9x** | **3.3x** |
| sha256sum | single 10MB binary | 0.0076s | 0.0084s | 0.0281s | **0.9x** | **3.3x** |
| sha256sum | single 100MB text | 0.0668s | 0.0550s | 0.2608s | **1.2x** | **4.7x** |
| sha256sum | 10 files | 0.0011s | 0.0011s | 0.0010s | **0.9x** | **0.9x** |
| sha256sum | 100 files | 0.0017s | 0.0018s | 0.0015s | **0.9x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0020s | 0.0012s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0030s | 0.0033s | 0.0026s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0206s | 0.0173s | 0.0170s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0214s | 0.0179s | 0.0179s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.1991s | 0.1428s | 0.1642s | **1.4x** | **1.1x** |
| md5sum | 10 files | 0.0010s | 0.0012s | 0.0010s | **0.9x** | **0.9x** |
| md5sum | 100 files | 0.0016s | 0.0019s | 0.0016s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0140s | 0.0137s | 0.0135s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0149s | 0.0143s | 0.0144s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1338s | 0.1153s | 0.1272s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0140s | 0.0137s | 0.0136s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0138s | 0.0133s | 0.0132s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0016s | 0.0017s | 0.0018s | **0.9x** | **1.0x** |
| base64 | encode 100KB text | 0.0008s | 0.0009s | 0.0010s | **0.9x** | **1.1x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0016s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0094s | 0.0037s | 0.0070s | **2.5x** | **1.9x** |
| base64 | encode 10MB binary | 0.0099s | 0.0035s | 0.0073s | **2.8x** | **2.1x** |
| base64 | decode 1MB | 0.0037s | 0.0017s | 0.0035s | **2.2x** | **2.1x** |
| base64 | decode 10MB | 0.0307s | 0.0056s | 0.0269s | **5.5x** | **4.8x** |
| base64 | encode -w 76 10MB | 0.0093s | 0.0037s | 0.0072s | **2.5x** | **1.9x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0073s | 0.0029s | 0.0071s | **2.5x** | **2.4x** |
| sort | lexicographic 1MB | 0.0075s | 0.0026s | 0.0041s | **2.9x** | **1.6x** |
| sort | lexicographic 10MB random | 0.0519s | 0.0063s | 0.0284s | **8.2x** | **4.5x** |
| sort | already sorted 10MB | 0.0248s | 0.0033s | 0.0132s | **7.5x** | **4.0x** |
| sort | reverse sorted 10MB | 0.0244s | 0.0045s | 0.0139s | **5.5x** | **3.1x** |
| sort | -n numeric 10MB | 0.0691s | 0.0041s | 0.0611s | **16.7x** | **14.7x** |
| sort | -r reverse 10MB | 0.0524s | 0.0063s | 0.0289s | **8.4x** | **4.6x** |
| sort | -u unique 10MB | 0.0539s | 0.0082s | 0.0345s | **6.5x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0700s | 0.0139s | 0.0679s | **5.1x** | **4.9x** |
| sort | repetitive 10MB | 0.0453s | 0.0100s | 0.0359s | **4.5x** | **3.6x** |
| sort | --parallel=4 10MB | 0.0500s | 0.0063s | 0.0282s | **8.0x** | **4.5x** |
| tr | a-z to A-Z 1MB | 0.0018s | 0.0014s | 0.0018s | **1.2x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0086s | 0.0039s | 0.0068s | **2.2x** | **1.8x** |
| tr | -d digits 10MB | 0.0109s | 0.0051s | 0.0102s | **2.1x** | **2.0x** |
| tr | -d lowercase 10MB | 0.0193s | 0.0066s | 0.0170s | **2.9x** | **2.6x** |
| tr | -s spaces 10MB | 0.0166s | 0.0040s | 0.0115s | **4.1x** | **2.9x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0087s | 0.0037s | 0.0068s | **2.3x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0109s | 0.0051s | 0.0103s | **2.1x** | **2.0x** |
| tr | translate binary 10MB | 0.0092s | 0.0042s | 0.0077s | **2.2x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0091s | 0.0026s | 0.0087s | **3.5x** | **3.3x** |
| uniq | default 10MB sorted (low dup) | 0.0164s | 0.0028s | 0.0097s | **5.8x** | **3.5x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0029s | 0.0087s | **3.1x** | **3.0x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0068s | 0.0114s | **4.3x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0092s | 0.0027s | 0.0087s | **3.5x** | **3.3x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0026s | 0.0087s | **3.4x** | **3.3x** |
| uniq | -i case insensitive 10MB | 0.0167s | 0.0040s | 0.0096s | **4.1x** | **2.4x** |
| uniq | repetitive 10MB | 0.0486s | 0.0034s | 0.0144s | **14.1x** | **4.2x** |
| tac | reverse 100KB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0017s | 0.0014s | 0.0015s | **1.2x** | **1.0x** |
| tac | reverse 10MB text | 0.0084s | 0.0044s | 0.0049s | **1.9x** | **1.1x** |
| tac | reverse 100MB text | 0.0828s | 0.0220s | 0.0425s | **3.8x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0081s | 0.0044s | 0.0043s | **1.9x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0189s | 0.0071s | 0.0088s | **2.7x** | **1.2x** |
| tac | custom separator 1MB | 0.0042s | 0.0035s | 0.0038s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0015s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0058s | 0.0029s | 0.0043s | **2.0x** | **1.5x** |
| wc | default 10MB text | 0.0542s | 0.0032s | 0.0307s | **16.9x** | **9.6x** |
| wc | default 100MB text | 0.4856s | 0.0156s | 0.2554s | **31.2x** | **16.4x** |
| wc | -l 10MB text | 0.0022s | 0.0026s | 0.0022s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0547s | 0.0093s | 0.0262s | **5.9x** | **2.8x** |
| wc | -c 10MB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| wc | -m 10MB text | 0.0548s | 0.0031s | 0.0022s | **17.5x** | **0.7x** |
| wc | -L 10MB text | 0.0548s | 0.0101s | 0.0203s | **5.4x** | **2.0x** |
| wc | default 10MB binary | 0.3152s | 0.0279s | 0.1551s | **11.3x** | **5.6x** |
| wc | default 10MB repetitive | 0.0737s | 0.0047s | 0.0405s | **15.6x** | **8.6x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0019s | 0.0024s | **1.0x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0232s | 0.0043s | 0.0075s | **5.3x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0231s | 0.0044s | 0.0077s | **5.3x** | **1.8x** |
| cut | -d, -f1 10MB CSV | 0.0169s | 0.0057s | 0.0089s | **3.0x** | **1.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0073s | 0.0184s | **3.1x** | **2.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0246s | 0.0052s | 0.0141s | **4.8x** | **2.7x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0048s | 0.0171s | **6.5x** | **3.5x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.0x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0017s | 0.0020s | **2.0x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | 0.0011s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0029s | 0.0020s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0088s | 0.0105s | 0.0088s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0094s | 0.0114s | 0.0096s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0763s | 0.0764s | 0.0764s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0014s | 0.0015s | 0.0014s | **1.0x** | **1.0x** |
| sha256sum | 100 files | 0.0025s | 0.0027s | 0.0024s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0015s | 0.0023s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0176s | 0.0184s | 0.0220s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0186s | 0.0192s | 0.0230s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1617s | 0.1539s | 0.2040s | **1.1x** | **1.3x** |
| md5sum | 10 files | 0.0014s | 0.0014s | 0.0014s | **1.0x** | **0.9x** |
| md5sum | 100 files | 0.0024s | 0.0026s | 0.0024s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0024s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0153s | 0.0129s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0162s | 0.0136s | 0.0136s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1436s | 0.1133s | 0.1140s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0130s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0137s | 0.0126s | **1.1x** | **0.9x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.4x** | **1.2x** |
| base64 | encode 10MB text | 0.0127s | 0.0048s | 0.0084s | **2.6x** | **1.7x** |
| base64 | encode 10MB binary | 0.0134s | 0.0049s | 0.0089s | **2.8x** | **1.8x** |
| base64 | decode 1MB | 0.0041s | 0.0014s | 0.0044s | **2.9x** | **3.1x** |
| base64 | decode 10MB | 0.0328s | 0.0061s | 0.0350s | **5.4x** | **5.8x** |
| base64 | encode -w 76 10MB | 0.0129s | 0.0047s | 0.0085s | **2.8x** | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0090s | 0.0039s | 0.0074s | **2.3x** | **1.9x** |
| sort | lexicographic 1MB | 0.0088s | 0.0033s | 0.0056s | **2.6x** | **1.7x** |
| sort | lexicographic 10MB random | 0.0555s | 0.0102s | 0.0368s | **5.5x** | **3.6x** |
| sort | already sorted 10MB | 0.0268s | 0.0046s | 0.0186s | **5.9x** | **4.1x** |
| sort | reverse sorted 10MB | 0.0279s | 0.0069s | 0.0187s | **4.1x** | **2.7x** |
| sort | -n numeric 10MB | 0.0752s | 0.0063s | 0.0787s | **12.0x** | **12.6x** |
| sort | -r reverse 10MB | 0.0558s | 0.0100s | 0.0365s | **5.6x** | **3.6x** |
| sort | -u unique 10MB | 0.0596s | 0.0103s | 0.0400s | **5.8x** | **3.9x** |
| sort | -t, -k2 CSV 10MB | 0.0686s | 0.0215s | 0.0857s | **3.2x** | **4.0x** |
| sort | repetitive 10MB | 0.0573s | 0.0122s | 0.0386s | **4.7x** | **3.2x** |
| sort | --parallel=4 10MB | 0.0574s | 0.0101s | 0.0370s | **5.7x** | **3.7x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0016s | 0.0020s | **1.5x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0143s | 0.0043s | 0.0075s | **3.3x** | **1.8x** |
| tr | -d digits 10MB | 0.0174s | 0.0044s | 0.0142s | **4.0x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0307s | 0.0052s | 0.0226s | **5.9x** | **4.4x** |
| tr | -s spaces 10MB | 0.0284s | 0.0038s | 0.0274s | **7.4x** | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0140s | 0.0040s | 0.0076s | **3.5x** | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0168s | 0.0045s | 0.0145s | **3.7x** | **3.2x** |
| tr | translate binary 10MB | 0.0115s | 0.0044s | 0.0086s | **2.6x** | **2.0x** |
| uniq | default 10MB many duplicates | 0.0120s | 0.0036s | 0.0114s | **3.3x** | **3.1x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0038s | 0.0136s | **3.8x** | **3.6x** |
| uniq | -c count 10MB many dups | 0.0121s | 0.0036s | 0.0114s | **3.4x** | **3.1x** |
| uniq | -c count 10MB sorted | 0.0295s | 0.0094s | 0.0160s | **3.1x** | **1.7x** |
| uniq | -d duplicates only 10MB | 0.0122s | 0.0037s | 0.0114s | **3.3x** | **3.1x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0037s | 0.0113s | **3.3x** | **3.0x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0046s | 0.0136s | **3.1x** | **3.0x** |
| uniq | repetitive 10MB | 0.0426s | 0.0043s | 0.0170s | **9.8x** | **3.9x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0020s | 0.0017s | 0.0018s | **1.2x** | **1.1x** |
| tac | reverse 10MB text | 0.0110s | 0.0047s | 0.0060s | **2.3x** | **1.3x** |
| tac | reverse 100MB text | 0.1055s | 0.0280s | 0.0554s | **3.8x** | **2.0x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0050s | 0.0059s | **1.9x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0241s | 0.0082s | 0.0116s | **2.9x** | **1.4x** |
| tac | custom separator 1MB | 0.0060s | 0.0042s | 0.0055s | **1.4x** | **1.3x** |
