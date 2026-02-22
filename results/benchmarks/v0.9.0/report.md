# fcoreutils v0.9.0 — Detailed Results

Generated: 2026-02-22 17:54:45 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 325 | 220 | 105 | 67.7% |
| Linux_aarch64 | 436 | 417 | 19 | 95.6% |
| Linux_x86_64 | 436 | 417 | 19 | 95.6% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

**Overall: 1054/1197 (88.1%)**

## Performance

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| wc | default 100KB text | 0.0013s | 0.0012s | 0.0014s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0056s | 0.0036s | 0.0038s | **1.6x** | **1.0x** |
| wc | default 10MB text | 0.0544s | 0.0033s | 0.0310s | **16.4x** | **9.3x** |
| wc | default 100MB text | 0.4807s | 0.0146s | 0.2603s | **32.9x** | **17.8x** |
| wc | -l 10MB text | 0.0022s | 0.0025s | 0.0019s | **0.9x** | **0.7x** |
| wc | -w 10MB text | 0.0546s | 0.0093s | 0.0251s | **5.9x** | **2.7x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0544s | 0.0033s | 0.0019s | **16.6x** | **0.6x** |
| wc | -L 10MB text | 0.0542s | 0.0099s | 0.0163s | **5.5x** | **1.7x** |
| wc | default 10MB binary | 0.3154s | 0.0272s | 0.1581s | **11.6x** | **5.8x** |
| wc | default 10MB repetitive | 0.0745s | 0.0047s | 0.0423s | **15.8x** | **9.0x** |
| wc | 10 files | 0.0009s | 0.0013s | 0.0014s | **0.7x** | **1.1x** |
| wc | 100 files | 0.0016s | 0.0017s | 0.0021s | **0.9x** | **1.2x** |
| cut | -b1-100 10MB CSV | 0.0217s | 0.0040s | 0.0068s | **5.5x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0217s | 0.0040s | 0.0065s | **5.4x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0156s | 0.0096s | 0.0078s | **1.6x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0209s | 0.0117s | 0.0172s | **1.8x** | **1.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0104s | 0.0130s | **2.2x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0294s | 0.0110s | 0.0161s | **2.7x** | **1.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0031s | 0.0029s | 0.0018s | **1.1x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.8x** |
| sha256sum | single 100KB text | 0.0012s | 0.0028s | 0.0012s | **0.4x** | **0.4x** |
| sha256sum | single 1MB text | 0.0019s | 0.0038s | 0.0019s | **0.5x** | **0.5x** |
| sha256sum | single 10MB text | 0.0088s | 0.0104s | 0.0086s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0109s | 0.0086s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0745s | 0.0752s | 0.0743s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0023s | 0.0012s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0021s | 0.0027s | 0.0021s | **0.8x** | **0.8x** |
| md5sum | single 100KB text | 0.0014s | 0.0023s | 0.0014s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0027s | 0.0036s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0175s | 0.0183s | 0.0216s | **1.0x** | **1.2x** |
| md5sum | single 10MB binary | 0.0181s | 0.0191s | 0.0225s | **0.9x** | **1.2x** |
| md5sum | single 100MB text | 0.1602s | 0.1537s | 0.2024s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0012s | 0.0024s | 0.0012s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0021s | 0.0033s | 0.0021s | **0.6x** | **0.6x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0022s | 0.0020s | 0.0022s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0155s | 0.0133s | 0.0125s | **1.2x** | **0.9x** |
| b2sum | single 10MB binary | 0.0157s | 0.0134s | 0.0131s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1422s | 0.1128s | 0.1123s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0156s | 0.0132s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0130s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0019s | 0.0022s | 0.0021s | **0.9x** | **0.9x** |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0010s | **0.8x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0015s | 0.0016s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0111s | 0.0060s | 0.0069s | **1.9x** | **1.1x** |
| base64 | encode 10MB binary | 0.0116s | 0.0064s | 0.0069s | **1.8x** | **1.1x** |
| base64 | decode 1MB | 0.0037s | 0.0023s | 0.0040s | **1.6x** | **1.7x** |
| base64 | decode 10MB | 0.0310s | 0.0053s | 0.0313s | **5.8x** | **5.9x** |
| base64 | encode -w 76 10MB | 0.0113s | 0.0061s | 0.0067s | **1.9x** | **1.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0083s | 0.0047s | 0.0058s | **1.8x** | **1.2x** |
| sort | lexicographic 1MB | 0.0085s | 0.0036s | 0.0053s | **2.4x** | **1.5x** |
| sort | lexicographic 10MB random | 0.0556s | 0.0101s | 0.0334s | **5.5x** | **3.3x** |
| sort | already sorted 10MB | 0.0264s | 0.0053s | 0.0157s | **5.0x** | **3.0x** |
| sort | reverse sorted 10MB | 0.0279s | 0.0066s | 0.0164s | **4.2x** | **2.5x** |
| sort | -n numeric 10MB | 0.0733s | 0.0059s | 0.0746s | **12.4x** | **12.7x** |
| sort | -r reverse 10MB | 0.0550s | 0.0104s | 0.0338s | **5.3x** | **3.2x** |
| sort | -u unique 10MB | 0.0578s | 0.0113s | 0.0377s | **5.1x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0676s | 0.0218s | 0.0825s | **3.1x** | **3.8x** |
| sort | repetitive 10MB | 0.0558s | 0.0134s | 0.0348s | **4.1x** | **2.6x** |
| sort | --parallel=4 10MB | 0.0546s | 0.0096s | 0.0338s | **5.7x** | **3.5x** |
| tr | a-z to A-Z 1MB | 0.0020s | 0.0015s | 0.0020s | **1.4x** | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0116s | 0.0045s | 0.0071s | **2.6x** | **1.6x** |
| tr | -d digits 10MB | 0.0153s | 0.0044s | 0.0131s | **3.5x** | **3.0x** |
| tr | -d lowercase 10MB | 0.0290s | 0.0053s | 0.0207s | **5.5x** | **3.9x** |
| tr | -s spaces 10MB | 0.0246s | 0.0040s | 0.0267s | **6.1x** | **6.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0118s | 0.0040s | 0.0072s | **2.9x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0164s | 0.0043s | 0.0133s | **3.8x** | **3.1x** |
| tr | translate binary 10MB | 0.0099s | 0.0045s | 0.0081s | **2.2x** | **1.8x** |
| uniq | default 10MB many duplicates | 0.0115s | 0.0019s | 0.0121s | **6.2x** | **6.5x** |
| uniq | default 10MB sorted (low dup) | 0.0132s | 0.0032s | 0.0131s | **4.2x** | **4.1x** |
| uniq | -c count 10MB many dups | 0.0117s | 0.0019s | 0.0120s | **6.1x** | **6.2x** |
| uniq | -c count 10MB sorted | 0.0280s | 0.0070s | 0.0163s | **4.0x** | **2.3x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0019s | 0.0122s | **6.4x** | **6.5x** |
| uniq | -u unique only 10MB | 0.0118s | 0.0018s | 0.0123s | **6.4x** | **6.7x** |
| uniq | -i case insensitive 10MB | 0.0133s | 0.0047s | 0.0131s | **2.8x** | **2.8x** |
| uniq | repetitive 10MB | 0.0413s | 0.0039s | 0.0178s | **10.5x** | **4.5x** |
| tac | reverse 100KB text | 0.0009s | 0.0014s | 0.0012s | **0.6x** | **0.8x** |
| tac | reverse 1MB text | 0.0018s | 0.0020s | 0.0016s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0093s | 0.0065s | 0.0054s | **1.4x** | **0.8x** |
| tac | reverse 100MB text | 0.0909s | 0.0292s | 0.0485s | **3.1x** | **1.7x** |
| tac | reverse CSV 10MB | 0.0084s | 0.0063s | 0.0053s | **1.3x** | **0.8x** |
| tac | reverse repetitive 10MB | 0.0211s | 0.0118s | 0.0107s | **1.8x** | **0.9x** |
| tac | custom separator 1MB | 0.0058s | 0.0053s | 0.0050s | **1.1x** | **0.9x** |
| head | default 1MB text | 0.0008s | 0.0012s | 0.0011s | **0.6x** | **0.9x** |
| head | default 10MB text | 0.0008s | 0.0011s | 0.0010s | **0.7x** | **0.9x** |
| head | default 100MB text | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| head | -n 1000 10MB | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| head | -n 100000 10MB | 0.0055s | 0.0039s | 0.0031s | **1.4x** | **0.8x** |
| head | -c 1000000 10MB | 0.0010s | 0.0011s | 0.0011s | **0.9x** | **1.0x** |
| head | -n -100 10MB (all but last 100) | 0.0027s | 0.0046s | 0.0014s | **0.6x** | **0.3x** |
| head | 100 small files | 0.0014s | 0.0022s | 0.0019s | **0.6x** | **0.9x** |
| tail | default 1MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.2x** |
| tail | default 10MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.2x** |
| tail | default 100MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.2x** |
| tail | -n 1000 10MB | 0.0008s | 0.0011s | 0.0014s | **0.7x** | **1.2x** |
| tail | -n 100000 10MB | 0.0045s | 0.0031s | 0.0067s | **1.4x** | **2.1x** |
| tail | -n +100 10MB (from line 100) | 0.0027s | 0.0024s | 0.0015s | **1.1x** | **0.6x** |
| tail | -n +100000 10MB (from line 100000) | 0.0034s | 0.0044s | 0.0033s | **0.8x** | **0.7x** |
| tail | -c 1000000 10MB | 0.0010s | 0.0012s | 0.0013s | **0.8x** | **1.1x** |
| tail | 100 small files | 0.0015s | 0.0024s | 0.0029s | **0.6x** | **1.2x** |
| cat | passthrough 1MB | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| cat | passthrough 10MB | 0.0014s | 0.0013s | 0.0014s | **1.1x** | **1.1x** |
| cat | passthrough 100MB | 0.0101s | 0.0036s | 0.0048s | **2.8x** | **1.3x** |
| cat | -n 1MB | 0.0020s | 0.0019s | 0.0018s | **1.0x** | **0.9x** |
| cat | -n 10MB | 0.0102s | 0.0067s | 0.0070s | **1.5x** | **1.1x** |
| cat | -b 10MB | 0.0106s | 0.0068s | 0.0070s | **1.6x** | **1.0x** |
| cat | -A 1MB | 0.0018s | 0.0044s | 0.0031s | **0.4x** | **0.7x** |
| cat | 100 small files | 0.0025s | 0.0018s | 0.0025s | **1.3x** | **1.4x** |
| cat | binary 10MB | 0.0014s | 0.0013s | 0.0015s | **1.1x** | **1.2x** |
| rev | reverse 100KB text | 0.0021s | 0.0010s | N/A | **2.1x** | N/A |
| rev | reverse 1MB text | 0.0141s | 0.0018s | N/A | **7.8x** | N/A |
| rev | reverse 10MB text | 0.1326s | 0.0080s | N/A | **16.6x** | N/A |
| rev | reverse 100MB text | 1.3525s | 0.0764s | N/A | **17.7x** | N/A |
| rev | reverse CSV 10MB | 0.0995s | 0.0079s | N/A | **12.6x** | N/A |
| rev | reverse repetitive 10MB | 0.2849s | 0.0134s | N/A | **21.2x** | N/A |
| rev | reverse 10KB single line | 0.0009s | 0.0009s | N/A | **1.0x** | N/A |
| expand | expand 10MB tabbed (default) | 0.0425s | 0.0403s | 0.0899s | **1.1x** | **2.2x** |
| expand | expand 1MB text | 0.0031s | 0.0010s | 0.0014s | **3.0x** | **1.3x** |
| expand | -t 4 10MB tabbed | 0.0400s | 0.0408s | 0.0906s | **1.0x** | **2.2x** |
| expand | -t 2 10MB tabbed | 0.0341s | 0.0404s | 0.0895s | **0.8x** | **2.2x** |
| expand | --initial 10MB tabbed | 0.0219s | 0.0333s | 0.0824s | **0.7x** | **2.5x** |
| expand | expand CSV 10MB | 0.0181s | 0.0018s | 0.0038s | **10.1x** | **2.1x** |
| unexpand | unexpand 1MB text | 0.0028s | 0.0044s | 0.0020s | **0.6x** | **0.5x** |
| unexpand | unexpand 10MB text | 0.0206s | 0.0397s | 0.0108s | **0.5x** | **0.3x** |
| unexpand | -a 1MB text | 0.0087s | 0.0049s | 0.0114s | **1.8x** | **2.3x** |
| unexpand | -a 10MB text | 0.0822s | 0.0445s | 0.1061s | **1.8x** | **2.4x** |
| unexpand | -t 4 10MB text | 0.0822s | 0.0444s | 0.1060s | **1.9x** | **2.4x** |
| unexpand | expand|unexpand pipeline 10MB | 0.1193s | 0.1122s | 0.1539s | **1.1x** | **1.4x** |
| fold | fold 10MB wide lines (default) | 0.0327s | 0.0233s | 0.0163s | **1.4x** | **0.7x** |
| fold | fold 1MB text | 0.0040s | 0.0032s | 0.0028s | **1.2x** | **0.8x** |
| fold | fold 10MB text | 0.0333s | 0.0235s | 0.0188s | **1.4x** | **0.8x** |
| fold | -w 40 10MB | 0.0328s | 0.0244s | 0.0183s | **1.3x** | **0.8x** |
| fold | -w 20 10MB | 0.0345s | 0.0229s | 0.0220s | **1.5x** | **1.0x** |
| fold | -s -w 60 10MB | 0.0374s | 0.0379s | 0.0197s | **1.0x** | **0.5x** |
| fold | -s -w 40 10MB | 0.0396s | 0.0400s | 0.0227s | **1.0x** | **0.6x** |
| fold | -b -w 40 10MB | 0.0320s | 0.0073s | 0.0092s | **4.4x** | **1.3x** |
| paste | 2 columns 10MB | 0.0229s | 0.0153s | 0.1835s | **1.5x** | **12.0x** |
| paste | 3 columns 10MB | 0.0293s | 0.0214s | 0.1967s | **1.4x** | **9.2x** |
| paste | -d comma 10MB | 0.0228s | 0.0152s | 0.1838s | **1.5x** | **12.1x** |
| paste | -s 10MB single file | 0.0103s | 0.0072s | 0.0138s | **1.4x** | **1.9x** |
| paste | stdin split 2-way 10MB | 0.0281s | 0.0185s | 0.0363s | **1.5x** | **2.0x** |
| nl | default 1MB | 0.0046s | 0.0019s | 0.0024s | **2.5x** | **1.3x** |
| nl | default 10MB | 0.0345s | 0.0073s | 0.0109s | **4.7x** | **1.5x** |
| nl | -b a 10MB | 0.0343s | 0.0081s | 0.0111s | **4.3x** | **1.4x** |
| nl | -b a 10MB with blanks | 0.0437s | 0.0101s | 0.0161s | **4.3x** | **1.6x** |
| nl | -b a -n rz 10MB | 0.0344s | 0.0081s | 0.0116s | **4.3x** | **1.4x** |
| nl | -b a -w 8 -s ': ' 10MB | 0.0343s | 0.0084s | 0.0117s | **4.1x** | **1.4x** |
| nl | -b p'^the' 10MB | 0.0584s | 0.0128s | 0.0158s | **4.6x** | **1.2x** |
| comm | default 10MB sorted | 0.0227s | 0.0077s | 0.0195s | **2.9x** | **2.5x** |
| comm | -12 (common only) 10MB | 0.0195s | 0.0060s | 0.0187s | **3.3x** | **3.1x** |
| comm | -23 (unique to file1) 10MB | 0.0205s | 0.0062s | 0.0187s | **3.3x** | **3.0x** |
| comm | -3 10MB | 0.0215s | 0.0070s | 0.0200s | **3.1x** | **2.9x** |
| comm | identical 10MB sorted | 0.0282s | 0.0128s | 0.0189s | **2.2x** | **1.5x** |
| join | default join 10MB | N/A | - | N/A | - | N/A |
| join | outer join 10MB | N/A | - | N/A | - | N/A |
| join | -v 1 (unmatched from file1) 10MB | N/A | - | N/A | - | N/A |
| join | -o 0,1.2,2.2 10MB | N/A | - | N/A | - | N/A |
| join | self-join sorted 10MB | 0.0446s | 0.0618s | 0.0509s | **0.7x** | **0.8x** |
| basenc | encode --base64 1MB | 0.0018s | 0.0031s | N/A | **0.6x** | N/A |
| basenc | encode --base64 10MB | 0.0117s | 0.0239s | N/A | **0.5x** | N/A |
| basenc | encode --base32 1MB | 0.0020s | 0.0037s | N/A | **0.5x** | N/A |
| basenc | encode --base16 1MB | 0.0023s | 0.0042s | N/A | **0.5x** | N/A |
| basenc | decode --base64 -d 1MB | 0.0037s | 0.0051s | N/A | **0.7x** | N/A |
| base32 | encode 100KB text | 0.0009s | 0.0012s | N/A | **0.8x** | N/A |
| base32 | encode 1MB text | 0.0020s | 0.0038s | N/A | **0.5x** | N/A |
| base32 | encode 10MB text | 0.0141s | 0.0313s | N/A | **0.4x** | N/A |
| base32 | encode 10MB binary | 0.0145s | 0.0329s | N/A | **0.4x** | N/A |
| base32 | decode 1MB | 0.0033s | 0.0062s | N/A | **0.5x** | N/A |
| base32 | decode 10MB | 0.0271s | 0.0520s | N/A | **0.5x** | N/A |
| ln | symlink single file | 0.0015s | 0.0018s | N/A | **0.9x** | N/A |
| ln | symlink force overwrite (-sf) | 0.0015s | 0.0017s | N/A | **0.9x** | N/A |
| ln | hard link single file | 0.0015s | 0.0017s | N/A | **0.9x** | N/A |
| touch | create new file | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| touch | update existing file timestamp | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| touch | set specific timestamp (-t) | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| truncate | truncate to zero (-s 0) | 0.0028s | 0.0044s | N/A | **0.6x** | N/A |
| truncate | create 1M file (-s 1M) | 0.0015s | 0.0018s | N/A | **0.9x** | N/A |
| mkdir | mkdir single directory | 0.0018s | 0.0018s | N/A | **1.0x** | N/A |
| mkdir | mkdir -p nested directories | 0.0021s | 0.0022s | N/A | **1.0x** | N/A |
| rmdir | rmdir single empty directory | 0.0018s | 0.0019s | N/A | **0.9x** | N/A |
| rmdir | rmdir -p nested directories | N/A | - | N/A | - | N/A |
| mknod | mknod named pipe | 0.0018s | 0.0018s | N/A | **1.0x** | N/A |
| mkfifo | mkfifo single fifo | 0.0017s | 0.0018s | N/A | **1.0x** | N/A |
| mktemp | mktemp default | N/A | 0.0019s | N/A | - | N/A |
| mktemp | mktemp -d directory | N/A | 0.0019s | N/A | - | N/A |
| seq | seq 1000000 | 0.0097s | 0.0108s | N/A | **0.9x** | N/A |
| seq | seq 1 10000000 | 0.0898s | 0.0828s | N/A | **1.1x** | N/A |
| seq | seq 0 0.1 100000 (float) | 0.2292s | 0.1687s | N/A | **1.4x** | N/A |
| seq | seq -w 1 1000000 (zero-padded) | 0.2404s | 0.0163s | N/A | **14.7x** | N/A |
| tsort | tsort 100K pairs | N/A | - | N/A | - | N/A |
| tsort | tsort 1M pairs | N/A | - | N/A | - | N/A |
| tee | tee 1MB to /dev/null | N/A | - | N/A | - | N/A |
| tee | tee 10MB to /dev/null | N/A | - | N/A | - | N/A |
| sum | single 1MB text | 0.0024s | 0.0020s | N/A | **1.2x** | N/A |
| sum | single 10MB text | 0.0174s | 0.0128s | N/A | **1.4x** | N/A |
| sum | single 10MB binary | 0.0186s | 0.0130s | N/A | **1.4x** | N/A |
| cksum | single 1MB text | 0.0013s | 0.0020s | N/A | **0.7x** | N/A |
| cksum | single 10MB text | 0.0026s | 0.0113s | N/A | **0.2x** | N/A |
| cksum | single 10MB binary | 0.0027s | 0.0122s | N/A | **0.2x** | N/A |
| sha1sum | single 1MB text | 0.0019s | 0.0039s | N/A | **0.5x** | N/A |
| sha1sum | single 10MB text | 0.0078s | 0.0099s | N/A | **0.8x** | N/A |
| sha1sum | single 10MB binary | 0.0082s | 0.0102s | N/A | **0.8x** | N/A |
| sha1sum | 100 files | 0.0020s | 0.0027s | N/A | **0.7x** | N/A |
| sha224sum | single 1MB text | 0.0018s | 0.0035s | N/A | **0.5x** | N/A |
| sha224sum | single 10MB text | 0.0083s | 0.0099s | N/A | **0.8x** | N/A |
| sha224sum | single 10MB binary | 0.0088s | 0.0105s | N/A | **0.8x** | N/A |
| sha384sum | single 1MB text | 0.0025s | 0.0040s | N/A | **0.6x** | N/A |
| sha384sum | single 10MB text | 0.0157s | 0.0176s | N/A | **0.9x** | N/A |
| sha384sum | single 10MB binary | 0.0163s | 0.0176s | N/A | **0.9x** | N/A |
| sha512sum | single 1MB text | 0.0026s | 0.0042s | N/A | **0.6x** | N/A |
| sha512sum | single 10MB text | 0.0155s | 0.0176s | N/A | **0.9x** | N/A |
| sha512sum | single 10MB binary | 0.0162s | 0.0178s | N/A | **0.9x** | N/A |
| id | id (no args) | 0.0011s | 0.0011s | N/A | **1.0x** | N/A |
| id | id -u | 0.0009s | 0.0009s | N/A | **1.0x** | N/A |
| id | id -g | 0.0009s | 0.0009s | N/A | **1.0x** | N/A |
| id | id -un | 0.0010s | 0.0010s | N/A | **1.0x** | N/A |
| groups | groups (no args) | 0.0009s | 0.0010s | N/A | **0.9x** | N/A |
| whoami | whoami (no args) | 0.0009s | 0.0010s | N/A | **0.9x** | N/A |
| logname | logname (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname (no args) | 0.0007s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname -a | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname -r | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname -m | 0.0008s | 0.0009s | N/A | **0.9x** | N/A |
| arch | arch (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| hostid | hostid (no args) | 0.0009s | 0.0010s | N/A | **0.8x** | N/A |
| tty | tty (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| nproc | nproc (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| nproc | nproc --all | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| pwd | pwd (no args) | 0.0000s | 0.0010s | N/A | - | N/A |
| pwd | pwd -L | 0.0000s | 0.0009s | N/A | - | N/A |
| pwd | pwd -P | 0.0000s | 0.0009s | N/A | - | N/A |
| env | print all env vars | 0.0008s | 0.0011s | N/A | **0.7x** | N/A |
| env | env true (run command) | 0.0012s | 0.0014s | N/A | **0.9x** | N/A |
| env | env VAR=value true | 0.0012s | 0.0013s | N/A | **0.9x** | N/A |
| nice | nice true (default priority) | 0.0012s | 0.0015s | N/A | **0.8x** | N/A |
| nice | nice -n 10 true | 0.0012s | 0.0013s | N/A | **0.9x** | N/A |
| nohup | nohup true | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| sleep | sleep 0 (startup overhead) | 0.0008s | 0.0009s | N/A | **0.9x** | N/A |
| sleep | sleep 0.001 (tiny sleep) | 0.0018s | 0.0020s | N/A | **0.9x** | N/A |
| sync | sync (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| true | true (startup overhead) | 0.0000s | 0.0007s | N/A | - | N/A |
| false | false (startup overhead) | 0.0000s | 0.0007s | N/A | - | N/A |
| link | hard link a file | 0.0015s | 0.0017s | N/A | **0.9x** | N/A |
| unlink | unlink a file | 0.0019s | 0.0021s | N/A | **0.9x** | N/A |
| basename | basename simple path | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| basename | basename with suffix (.txt) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| dirname | dirname simple path | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| dirname | dirname deep path | 0.0007s | 0.0009s | N/A | **0.8x** | N/A |
| pathchk | pathchk default | 0.0008s | 0.0010s | N/A | **0.7x** | N/A |
| pathchk | pathchk -p (POSIX portable) | 0.0007s | 0.0009s | N/A | **0.8x** | N/A |
| realpath | realpath . | 0.0008s | 0.0011s | N/A | **0.8x** | N/A |
| realpath | realpath /tmp | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| realpath | realpath test data file | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| readlink | readlink symlink | 0.0007s | 0.0009s | N/A | **0.8x** | N/A |
| readlink | readlink -f (canonicalize) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| echo | echo hello | 0.0007s | 0.0009s | N/A | **0.8x** | N/A |
| echo | echo -n hello | 0.0008s | 0.0011s | N/A | **0.7x** | N/A |
| echo | echo -e with escapes | 0.0007s | 0.0010s | N/A | **0.8x** | N/A |
| factor | factor 1234567890 | 0.0009s | 0.0010s | N/A | **0.9x** | N/A |
| factor | factor 999999999999999989 (large prime) | 0.0008s | 0.0009s | N/A | **0.9x** | N/A |
| factor | factor 1-100000 via stdin | N/A | - | N/A | - | N/A |
| expr | expr 1 + 1 | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| expr | expr 999999 * 999999 | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| expr | expr length 'hello world' | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| expr | expr 'hello' : 'hel' | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| test | test -f (file exists) | 0.0000s | 0.0009s | N/A | - | N/A |
| test | test 1 -eq 1 | 0.0000s | 0.0009s | N/A | - | N/A |
| test | test 'hello' = 'hello' | 0.0000s | 0.0009s | N/A | - | N/A |
| test | test -d /tmp | 0.0000s | 0.0010s | N/A | - | N/A |
| cp | cp 1MB file | 0.0026s | 0.0028s | N/A | **1.0x** | N/A |
| cp | cp 10MB file | 0.0103s | 0.0122s | N/A | **0.8x** | N/A |
| cp | cp -r directory (many_files) | 0.0069s | 0.0109s | N/A | **0.6x** | N/A |
| mv | mv 1MB file | 0.0037s | 0.0036s | N/A | **1.0x** | N/A |
| mv | mv 10MB file | 0.0117s | 0.0118s | N/A | **1.0x** | N/A |
| rm | rm single file | 0.0019s | 0.0021s | N/A | **0.9x** | N/A |
| rm | rm -rf directory | 0.0069s | 0.0073s | N/A | **0.9x** | N/A |
| dd | dd read 10MB (bs=4096) | 0.0032s | 0.0041s | N/A | **0.8x** | N/A |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0108s | 0.0128s | N/A | **0.8x** | N/A |
| split | split 10MB into 1MB chunks (-b 1m) | N/A | - | N/A | - | N/A |
| split | split 10MB by 1000 lines (-l 1000) | 0.0183s | 0.0229s | N/A | **0.8x** | N/A |
| csplit | csplit 1MB by pattern | 0.4399s | 0.0267s | N/A | **16.5x** | N/A |
| install | install 1MB file | 0.0027s | 0.0027s | N/A | **1.0x** | N/A |
| install | install -d create directory | 0.0021s | 0.0020s | N/A | **1.0x** | N/A |
| shred | shred 1MB file | 0.0099s | 0.0141s | N/A | **0.7x** | N/A |
| shred | shred 1MB file with remove (-u) | 0.0166s | 0.0154s | N/A | **1.1x** | N/A |
| chmod | chmod 644 on file | 0.0020s | 0.0021s | N/A | **0.9x** | N/A |
| chmod | chmod u+x on file | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| chown | chown current user on file | 0.0021s | 0.0023s | N/A | **0.9x** | N/A |
| chown | chown current user on 1MB file | 0.0029s | 0.0046s | N/A | **0.6x** | N/A |
| chgrp | chgrp current group on file | 0.0022s | 0.0023s | N/A | **0.9x** | N/A |
| chgrp | chgrp current group on 1MB file | 0.0028s | 0.0031s | N/A | **0.9x** | N/A |
| yes | startup --help | 0.0008s | 0.0002s | N/A | **4.2x** | N/A |
| yes | startup --version | 0.0008s | 0.0002s | N/A | **3.9x** | N/A |
| yes | throughput 1M lines | 0.0029s | 0.0029s | N/A | **1.0x** | N/A |
| yes | throughput 10M lines | 0.0190s | 0.0198s | N/A | **1.0x** | N/A |
| yes | throughput hello 1M lines | 0.0060s | 0.0060s | N/A | **1.0x** | N/A |
| yes | throughput hello 10M lines | 0.0479s | 0.0482s | N/A | **1.0x** | N/A |
| yes | throughput 100MB | 0.0268s | 0.0343s | N/A | **0.8x** | N/A |
