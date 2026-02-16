# fcoreutils v0.5.2 — Detailed Results

Generated: 2026-02-16 09:50:00 UTC

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
| wc | default 100KB text | 0.0011s | 0.0012s | 0.0013s | **0.9x** | **1.1x** |
| wc | default 1MB text | 0.0039s | 0.0027s | 0.0035s | **1.5x** | **1.3x** |
| wc | default 10MB text | 0.0344s | 0.0070s | 0.0259s | **4.9x** | **3.7x** |
| wc | default 100MB text | 0.3006s | 0.0477s | 0.2280s | **6.3x** | **4.8x** |
| wc | -l 10MB text | 0.0046s | 0.0022s | 0.0029s | **2.1x** | **1.3x** |
| wc | -w 10MB text | 0.0345s | 0.0064s | 0.0234s | **5.4x** | **3.7x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.7x** | **1.0x** |
| wc | -m 10MB text | 0.0344s | 0.0024s | 0.0029s | **14.4x** | **1.2x** |
| wc | -L 10MB text | 0.0345s | 0.0063s | 0.0179s | **5.5x** | **2.9x** |
| wc | default 10MB binary | 0.2351s | 0.0176s | 0.1182s | **13.4x** | **6.7x** |
| wc | default 10MB repetitive | 0.0530s | 0.0086s | 0.0381s | **6.2x** | **4.4x** |
| wc | 10 files | 0.0008s | 0.0011s | 0.0012s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0014s | 0.0015s | 0.0017s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0188s | 0.0035s | 0.0065s | **5.4x** | **1.9x** |
| cut | -c1-100 10MB CSV | 0.0188s | 0.0034s | 0.0066s | **5.5x** | **1.9x** |
| cut | -d, -f1 10MB CSV | 0.0190s | 0.0032s | 0.0074s | **5.9x** | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0215s | 0.0049s | 0.0166s | **4.4x** | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0235s | 0.0034s | 0.0131s | **6.9x** | **3.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0268s | 0.0045s | 0.0165s | **6.0x** | **3.7x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0010s | 0.0010s | **0.8x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0015s | 0.0018s | **2.4x** | **1.2x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0010s | 0.0010s | **0.8x** | **1.0x** |
| sha256sum | single 100KB text | 0.0012s | 0.0020s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | single 1MB text | 0.0018s | 0.0028s | 0.0039s | **0.6x** | **1.4x** |
| sha256sum | single 10MB text | 0.0080s | 0.0090s | 0.0276s | **0.9x** | **3.1x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0096s | 0.0292s | **0.9x** | **3.0x** |
| sha256sum | single 100MB text | 0.0700s | 0.0495s | 0.2637s | **1.4x** | **5.3x** |
| sha256sum | 10 files | 0.0012s | 0.0019s | 0.0012s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0019s | 0.0023s | 0.0018s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0032s | 0.0037s | 0.0030s | **0.9x** | **0.8x** |
| md5sum | single 10MB text | 0.0214s | 0.0179s | 0.0181s | **1.2x** | **1.0x** |
| md5sum | single 10MB binary | 0.0226s | 0.0190s | 0.0189s | **1.2x** | **1.0x** |
| md5sum | single 100MB text | 0.2017s | 0.1367s | 0.1674s | **1.5x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0019s | 0.0013s | **0.6x** | **0.7x** |
| md5sum | 100 files | 0.0018s | 0.0023s | 0.0018s | **0.8x** | **0.8x** |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0022s | 0.0023s | 0.0024s | **1.0x** | **1.1x** |
| b2sum | single 10MB text | 0.0145s | 0.0142s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | single 10MB binary | 0.0153s | 0.0149s | 0.0153s | **1.0x** | **1.0x** |
| b2sum | single 100MB text | 0.1371s | 0.1190s | 0.1302s | **1.2x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0146s | 0.0141s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0144s | 0.0144s | 0.0141s | **1.0x** | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0018s | 0.0018s | **1.0x** | **1.0x** |
| base64 | encode 100KB text | 0.0009s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0015s | 0.0017s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0103s | 0.0038s | 0.0077s | **2.7x** | **2.1x** |
| base64 | encode 10MB binary | 0.0109s | 0.0037s | 0.0082s | **2.9x** | **2.2x** |
| base64 | decode 1MB | 0.0040s | 0.0016s | 0.0036s | **2.5x** | **2.3x** |
| base64 | decode 10MB | 0.0309s | 0.0045s | 0.0271s | **6.9x** | **6.0x** |
| base64 | encode -w 76 10MB | 0.0102s | 0.0035s | 0.0077s | **2.9x** | **2.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0081s | 0.0031s | 0.0079s | **2.6x** | **2.5x** |
| sort | lexicographic 1MB | 0.0079s | 0.0034s | 0.0045s | **2.3x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0554s | 0.0110s | 0.0346s | **5.0x** | **3.1x** |
| sort | already sorted 10MB | 0.0257s | 0.0037s | 0.0145s | **6.9x** | **3.9x** |
| sort | reverse sorted 10MB | 0.0254s | 0.0051s | 0.0145s | **5.0x** | **2.9x** |
| sort | -n numeric 10MB | 0.0737s | 0.0042s | 0.0701s | **17.6x** | **16.7x** |
| sort | -r reverse 10MB | 0.0550s | 0.0103s | 0.0340s | **5.3x** | **3.3x** |
| sort | -u unique 10MB | 0.0574s | 0.0121s | 0.0412s | **4.7x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0763s | 0.0173s | 0.0766s | **4.4x** | **4.4x** |
| sort | repetitive 10MB | 0.0479s | 0.0112s | 0.0385s | **4.3x** | **3.5x** |
| sort | --parallel=4 10MB | 0.0533s | 0.0106s | 0.0335s | **5.0x** | **3.2x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0093s | 0.0078s | 0.0069s | **1.2x** | **0.9x** |
| tr | -d digits 10MB | 0.0111s | 0.0074s | 0.0102s | **1.5x** | **1.4x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0092s | 0.0173s | **2.1x** | **1.9x** |
| tr | -s spaces 10MB | 0.0166s | 0.0080s | 0.0115s | **2.1x** | **1.4x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0090s | 0.0083s | 0.0070s | **1.1x** | **0.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0110s | 0.0072s | 0.0102s | **1.5x** | **1.4x** |
| tr | translate binary 10MB | 0.0092s | 0.0086s | 0.0078s | **1.1x** | **0.9x** |
| uniq | default 10MB many duplicates | 0.0096s | 0.0021s | 0.0091s | **4.7x** | **4.4x** |
| uniq | default 10MB sorted (low dup) | 0.0170s | 0.0036s | 0.0113s | **4.7x** | **3.1x** |
| uniq | -c count 10MB many dups | 0.0095s | 0.0018s | 0.0090s | **5.3x** | **5.1x** |
| uniq | -c count 10MB sorted | 0.0299s | 0.0074s | 0.0121s | **4.1x** | **1.6x** |
| uniq | -d duplicates only 10MB | 0.0096s | 0.0021s | 0.0091s | **4.6x** | **4.4x** |
| uniq | -u unique only 10MB | 0.0096s | 0.0018s | 0.0091s | **5.4x** | **5.1x** |
| uniq | -i case insensitive 10MB | 0.0169s | 0.0041s | 0.0102s | **4.1x** | **2.5x** |
| uniq | repetitive 10MB | 0.0491s | 0.0033s | 0.0160s | **14.7x** | **4.8x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.0012s | **0.8x** | **1.1x** |
| tac | reverse 1MB text | 0.0017s | 0.0023s | 0.0016s | **0.7x** | **0.7x** |
| tac | reverse 10MB text | 0.0090s | 0.0037s | 0.0051s | **2.4x** | **1.4x** |
| tac | reverse 100MB text | 0.0863s | 0.0253s | 0.0457s | **3.4x** | **1.8x** |
| tac | reverse CSV 10MB | 0.0085s | 0.0038s | 0.0047s | **2.2x** | **1.2x** |
| tac | reverse repetitive 10MB | 0.0194s | 0.0073s | 0.0090s | **2.7x** | **1.2x** |
| tac | custom separator 1MB | 0.0044s | 0.0036s | 0.0038s | **1.2x** | **1.1x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0014s | 0.0013s | 0.0016s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0058s | 0.0030s | 0.0039s | **1.9x** | **1.3x** |
| wc | default 10MB text | 0.0549s | 0.0033s | 0.0306s | **16.7x** | **9.3x** |
| wc | default 100MB text | 0.4792s | 0.0147s | 0.2565s | **32.6x** | **17.4x** |
| wc | -l 10MB text | 0.0021s | 0.0027s | 0.0022s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0547s | 0.0110s | 0.0261s | **5.0x** | **2.4x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.0013s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0547s | 0.0031s | 0.0022s | **17.5x** | **0.7x** |
| wc | -L 10MB text | 0.0547s | 0.0106s | 0.0202s | **5.2x** | **1.9x** |
| wc | default 10MB binary | 0.3198s | 0.0283s | 0.1537s | **11.3x** | **5.4x** |
| wc | default 10MB repetitive | 0.0733s | 0.0047s | 0.0400s | **15.6x** | **8.5x** |
| wc | 10 files | 0.0010s | 0.0012s | 0.0014s | **0.8x** | **1.1x** |
| wc | 100 files | 0.0019s | 0.0018s | 0.0024s | **1.0x** | **1.3x** |
| cut | -b1-100 10MB CSV | 0.0228s | 0.0035s | 0.0074s | **6.6x** | **2.1x** |
| cut | -c1-100 10MB CSV | 0.0227s | 0.0035s | 0.0073s | **6.5x** | **2.1x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0037s | 0.0087s | **4.5x** | **2.3x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0220s | 0.0068s | 0.0176s | **3.2x** | **2.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0241s | 0.0049s | 0.0137s | **4.9x** | **2.8x** |
| cut | --complement -d, -f1 10MB CSV | 0.0307s | 0.0051s | 0.0165s | **6.0x** | **3.2x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0015s | 0.0020s | **2.2x** | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.0012s | **0.8x** | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| sha256sum | single 1MB text | 0.0020s | 0.0030s | 0.0021s | **0.7x** | **0.7x** |
| sha256sum | single 10MB text | 0.0089s | 0.0107s | 0.0090s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0094s | 0.0109s | 0.0094s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0763s | 0.0667s | 0.0757s | **1.1x** | **1.1x** |
| sha256sum | 10 files | 0.0014s | 0.0022s | 0.0014s | **0.6x** | **0.7x** |
| sha256sum | 100 files | 0.0024s | 0.0027s | 0.0023s | **0.9x** | **0.9x** |
| md5sum | single 100KB text | 0.0014s | 0.0024s | 0.0015s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0029s | 0.0037s | 0.0033s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0178s | 0.0184s | 0.0220s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0181s | 0.0188s | 0.0224s | **1.0x** | **1.2x** |
| md5sum | single 100MB text | 0.1617s | 0.1444s | 0.2039s | **1.1x** | **1.4x** |
| md5sum | 10 files | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | 100 files | 0.0024s | 0.0026s | 0.0023s | **0.9x** | **0.9x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0014s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0023s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0155s | 0.0125s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0160s | 0.0133s | 0.0132s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1436s | 0.1111s | 0.1143s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0130s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0151s | 0.0131s | 0.0130s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0022s | 0.0022s | 0.0024s | **1.0x** | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | 0.0019s | **1.5x** | **1.3x** |
| base64 | encode 10MB text | 0.0129s | 0.0046s | 0.0089s | **2.8x** | **2.0x** |
| base64 | encode 10MB binary | 0.0133s | 0.0042s | 0.0085s | **3.2x** | **2.0x** |
| base64 | decode 1MB | 0.0041s | 0.0014s | 0.0045s | **3.0x** | **3.3x** |
| base64 | decode 10MB | 0.0334s | 0.0048s | 0.0352s | **7.0x** | **7.4x** |
| base64 | encode -w 76 10MB | 0.0129s | 0.0044s | 0.0087s | **2.9x** | **2.0x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0094s | 0.0039s | 0.0076s | **2.4x** | **2.0x** |
| sort | lexicographic 1MB | 0.0087s | 0.0036s | 0.0055s | **2.4x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0572s | 0.0094s | 0.0366s | **6.1x** | **3.9x** |
| sort | already sorted 10MB | 0.0270s | 0.0048s | 0.0180s | **5.6x** | **3.8x** |
| sort | reverse sorted 10MB | 0.0282s | 0.0068s | 0.0181s | **4.1x** | **2.6x** |
| sort | -n numeric 10MB | 0.0760s | 0.0057s | 0.0774s | **13.4x** | **13.7x** |
| sort | -r reverse 10MB | 0.0557s | 0.0097s | 0.0364s | **5.7x** | **3.8x** |
| sort | -u unique 10MB | 0.0585s | 0.0097s | 0.0408s | **6.0x** | **4.2x** |
| sort | -t, -k2 CSV 10MB | 0.0674s | 0.0208s | 0.0832s | **3.2x** | **4.0x** |
| sort | repetitive 10MB | 0.0552s | 0.0126s | 0.0373s | **4.4x** | **3.0x** |
| sort | --parallel=4 10MB | 0.0564s | 0.0103s | 0.0374s | **5.5x** | **3.6x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0022s | 0.0021s | **1.1x** | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0130s | 0.0113s | 0.0077s | **1.1x** | **0.7x** |
| tr | -d digits 10MB | 0.0168s | 0.0094s | 0.0143s | **1.8x** | **1.5x** |
| tr | -d lowercase 10MB | 0.0305s | 0.0120s | 0.0230s | **2.6x** | **1.9x** |
| tr | -s spaces 10MB | 0.0259s | 0.0103s | 0.0278s | **2.5x** | **2.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0128s | 0.0109s | 0.0076s | **1.2x** | **0.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0163s | 0.0095s | 0.0149s | **1.7x** | **1.6x** |
| tr | translate binary 10MB | 0.0115s | 0.0114s | 0.0087s | **1.0x** | **0.8x** |
| uniq | default 10MB many duplicates | 0.0123s | 0.0020s | 0.0119s | **6.0x** | **5.9x** |
| uniq | default 10MB sorted (low dup) | 0.0147s | 0.0034s | 0.0138s | **4.3x** | **4.0x** |
| uniq | -c count 10MB many dups | 0.0124s | 0.0020s | 0.0117s | **6.2x** | **5.8x** |
| uniq | -c count 10MB sorted | 0.0296s | 0.0078s | 0.0162s | **3.8x** | **2.1x** |
| uniq | -d duplicates only 10MB | 0.0123s | 0.0020s | 0.0118s | **6.2x** | **5.9x** |
| uniq | -u unique only 10MB | 0.0123s | 0.0021s | 0.0116s | **5.8x** | **5.5x** |
| uniq | -i case insensitive 10MB | 0.0145s | 0.0049s | 0.0139s | **2.9x** | **2.8x** |
| uniq | repetitive 10MB | 0.0424s | 0.0037s | 0.0169s | **11.5x** | **4.6x** |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.0x** |
| tac | reverse 1MB text | 0.0020s | 0.0015s | 0.0018s | **1.3x** | **1.1x** |
| tac | reverse 10MB text | 0.0108s | 0.0045s | 0.0059s | **2.4x** | **1.3x** |
| tac | reverse 100MB text | 0.1048s | 0.0285s | 0.0533s | **3.7x** | **1.9x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0045s | 0.0058s | **2.1x** | **1.3x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0087s | 0.0114s | **2.7x** | **1.3x** |
| tac | custom separator 1MB | 0.0061s | 0.0042s | 0.0053s | **1.5x** | **1.3x** |
