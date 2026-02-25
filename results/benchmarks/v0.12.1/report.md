# fcoreutils v0.12.1 — Detailed Results

Generated: 2026-02-25 07:03:39 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 231 | 189 | 35 | 81.8% |
| Linux_aarch64 | 2224 | 2188 | 25 | 98.4% |
| Linux_x86_64 | 2224 | 2189 | 24 | 98.4% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

**Overall: 4566/4679 (97.6%)**

## Performance

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| arch | arch (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0021s | 0.0023s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0125s | 0.0120s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0132s | 0.0127s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1419s | 0.1122s | 0.1119s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0149s | 0.0126s | 0.0119s | **1.2x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0130s | 0.0121s | **1.1x** | **0.9x** |
| b2sum | 100 files | 0.0019s | 0.0022s | 0.0021s | **0.9x** | **0.9x** |
| base32 | encode 100KB text | 0.0009s | 0.0011s | N/A | **0.9x** | N/A |
| base32 | encode 1MB text | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| base32 | encode 10MB text | 0.0146s | 0.0130s | N/A | **1.1x** | N/A |
| base32 | encode 10MB binary | 0.0140s | 0.0149s | N/A | **0.9x** | N/A |
| base32 | decode 1MB | 0.0033s | 0.0026s | N/A | **1.3x** | N/A |
| base32 | decode 10MB | 0.0269s | 0.0182s | N/A | **1.5x** | N/A |
| base64 | encode 100KB text | 0.0009s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0015s | 0.0016s | **1.2x** | **1.0x** |
| base64 | encode 10MB text | 0.0109s | 0.0058s | 0.0065s | **1.9x** | **1.1x** |
| base64 | encode 10MB binary | 0.0117s | 0.0059s | 0.0069s | **2.0x** | **1.2x** |
| base64 | decode 1MB | 0.0037s | 0.0023s | 0.0040s | **1.6x** | **1.7x** |
| base64 | decode 10MB | 0.0312s | 0.0055s | 0.0326s | **5.7x** | **5.9x** |
| base64 | encode -w 76 10MB | 0.0110s | 0.0059s | 0.0065s | **1.9x** | **1.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0083s | 0.0047s | 0.0057s | **1.8x** | **1.2x** |
| basename | basename simple path | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| basename | basename with suffix (.txt) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| basenc | encode --base64 1MB | 0.0018s | 0.0020s | N/A | **0.9x** | N/A |
| basenc | encode --base64 10MB | 0.0110s | 0.0109s | N/A | **1.0x** | N/A |
| basenc | encode --base32 1MB | 0.0020s | 0.0021s | N/A | **1.0x** | N/A |
| basenc | encode --base16 1MB | 0.0022s | 0.0025s | N/A | **0.9x** | N/A |
| basenc | decode --base64 -d 1MB | 0.0037s | 0.0035s | N/A | **1.1x** | N/A |
| cat | passthrough 1MB | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cat | passthrough 10MB | 0.0014s | 0.0013s | 0.0014s | **1.1x** | **1.1x** |
| cat | passthrough 100MB | 0.0092s | 0.0036s | 0.0048s | **2.5x** | **1.3x** |
| cat | -n 1MB | 0.0020s | 0.0019s | 0.0018s | **1.0x** | **0.9x** |
| cat | -n 10MB | 0.0104s | 0.0063s | 0.0068s | **1.6x** | **1.1x** |
| cat | -b 10MB | 0.0102s | 0.0063s | 0.0069s | **1.6x** | **1.1x** |
| cat | -A 1MB | 0.0019s | 0.0018s | 0.0032s | **1.0x** | **1.8x** |
| cat | 100 small files | 0.0025s | 0.0019s | 0.0025s | **1.3x** | **1.3x** |
| cat | binary 10MB | 0.0015s | 0.0013s | 0.0015s | **1.2x** | **1.1x** |
| chgrp | chgrp current group on file | 0.0021s | 0.0023s | N/A | **0.9x** | N/A |
| chgrp | chgrp current group on 1MB file | 0.0029s | 0.0031s | N/A | **0.9x** | N/A |
| chmod | chmod 644 on file | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| chmod | chmod u+x on file | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| chown | chown current user on file | 0.0021s | 0.0024s | N/A | **0.9x** | N/A |
| chown | chown current user on 1MB file | 0.0029s | 0.0030s | N/A | **0.9x** | N/A |
| cksum | single 1MB text | 0.0013s | 0.0011s | N/A | **1.2x** | N/A |
| cksum | single 10MB text | 0.0025s | 0.0023s | N/A | **1.1x** | N/A |
| cksum | single 10MB binary | 0.0027s | 0.0024s | N/A | **1.1x** | N/A |
| comm | default 10MB sorted | 0.0227s | 0.0071s | 0.0198s | **3.2x** | **2.8x** |
| comm | -12 (common only) 10MB | 0.0196s | 0.0055s | 0.0190s | **3.5x** | **3.4x** |
| comm | -23 (unique to file1) 10MB | 0.0202s | 0.0058s | 0.0193s | **3.5x** | **3.3x** |
| comm | -3 10MB | 0.0218s | 0.0067s | 0.0203s | **3.2x** | **3.0x** |
| comm | identical 10MB sorted | 0.0280s | 0.0115s | 0.0190s | **2.4x** | **1.6x** |
| cp | cp 1MB file | 0.0027s | 0.0028s | N/A | **1.0x** | N/A |
| cp | cp 10MB file | 0.0101s | 0.0118s | N/A | **0.9x** | N/A |
| cp | cp -r directory (many_files) | 0.0068s | 0.0086s | N/A | **0.8x** | N/A |
| csplit | csplit 1MB by pattern | 0.4364s | 0.0245s | N/A | **17.8x** | N/A |
| cut | -b1-100 10MB CSV | 0.0212s | 0.0039s | 0.0066s | **5.4x** | **1.7x** |
| cut | -c1-100 10MB CSV | 0.0213s | 0.0039s | 0.0066s | **5.4x** | **1.7x** |
| cut | -d, -f1 10MB CSV | 0.0158s | 0.0094s | 0.0080s | **1.7x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0209s | 0.0117s | 0.0173s | **1.8x** | **1.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0105s | 0.0130s | **2.2x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0293s | 0.0110s | 0.0157s | **2.7x** | **1.4x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0031s | 0.0029s | 0.0018s | **1.1x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.6x** | **0.9x** |
| dd | dd read 10MB (bs=4096) | 0.0032s | 0.0036s | N/A | **0.9x** | N/A |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0102s | 0.0121s | N/A | **0.8x** | N/A |
| dirname | dirname simple path | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| dirname | dirname deep path | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| echo | echo hello | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| echo | echo -n hello | 0.0007s | 0.0009s | N/A | **0.8x** | N/A |
| echo | echo -e with escapes | 0.0007s | 0.0009s | N/A | **0.8x** | N/A |
| env | print all env vars | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| env | env true (run command) | 0.0012s | 0.0014s | N/A | **0.9x** | N/A |
| env | env VAR=value true | 0.0012s | 0.0014s | N/A | **0.9x** | N/A |
| expand | expand 10MB tabbed (default) | 0.0429s | 0.0356s | 0.0937s | **1.2x** | **2.6x** |
| expand | expand 1MB text | 0.0031s | 0.0010s | 0.0013s | **3.0x** | **1.3x** |
| expand | -t 4 10MB tabbed | 0.0401s | 0.0358s | 0.0940s | **1.1x** | **2.6x** |
| expand | -t 2 10MB tabbed | 0.0345s | 0.0353s | 0.0934s | **1.0x** | **2.6x** |
| expand | --initial 10MB tabbed | 0.0220s | 0.0066s | 0.0861s | **3.3x** | **13.0x** |
| expand | expand CSV 10MB | 0.0179s | 0.0018s | 0.0036s | **10.1x** | **2.0x** |
| expr | expr 1 + 1 | 0.0009s | 0.0010s | N/A | **0.8x** | N/A |
| expr | expr 999999 * 999999 | 0.0009s | 0.0010s | N/A | **0.8x** | N/A |
| expr | expr length 'hello world' | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| expr | expr 'hello' : 'hel' | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| factor | factor 1234567890 | 0.0008s | 0.0010s | N/A | **0.9x** | N/A |
| factor | factor 999999999999999989 (large prime) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| factor | factor 1-100000 via stdin | N/A | - | N/A | - | N/A |
| false | false (startup overhead) | 0.0000s | 0.0007s | N/A | - | N/A |
| fold | fold 10MB wide lines (default) | 0.0329s | 0.0238s | 0.0165s | **1.4x** | **0.7x** |
| fold | fold 1MB text | 0.0040s | 0.0017s | 0.0028s | **2.4x** | **1.6x** |
| fold | fold 10MB text | 0.0332s | 0.0174s | 0.0184s | **1.9x** | **1.1x** |
| fold | -w 40 10MB | 0.0332s | 0.0248s | 0.0184s | **1.3x** | **0.7x** |
| fold | -w 20 10MB | 0.0354s | 0.0237s | 0.0222s | **1.5x** | **0.9x** |
| fold | -s -w 60 10MB | 0.0376s | 0.0353s | 0.0204s | **1.1x** | **0.6x** |
| fold | -s -w 40 10MB | 0.0398s | 0.0370s | 0.0232s | **1.1x** | **0.6x** |
| fold | -b -w 40 10MB | 0.0314s | 0.0060s | 0.0092s | **5.2x** | **1.5x** |
| groups | groups (no args) | 0.0009s | 0.0010s | N/A | **0.8x** | N/A |
| head | default 1MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| head | default 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| head | default 100MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| head | -n 1000 10MB | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| head | -n 100000 10MB | 0.0055s | 0.0031s | 0.0031s | **1.8x** | **1.0x** |
| head | -c 1000000 10MB | 0.0010s | 0.0010s | 0.0011s | **1.0x** | **1.1x** |
| head | -n -100 10MB (all but last 100) | 0.0027s | 0.0042s | 0.0014s | **0.6x** | **0.3x** |
| head | 100 small files | 0.0014s | 0.0016s | 0.0019s | **0.8x** | **1.2x** |
| hostid | hostid (no args) | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| id | id (no args) | 0.0011s | 0.0011s | N/A | **1.0x** | N/A |
| id | id -u | 0.0009s | 0.0009s | N/A | **1.0x** | N/A |
| id | id -g | 0.0009s | 0.0009s | N/A | **1.0x** | N/A |
| id | id -un | 0.0010s | 0.0010s | N/A | **1.0x** | N/A |
| install | install 1MB file | 0.0027s | 0.0026s | N/A | **1.1x** | N/A |
| install | install -d create directory | 0.0021s | 0.0020s | N/A | **1.0x** | N/A |
| join | default join 10MB | N/A | - | N/A | - | N/A |
| join | outer join 10MB | N/A | - | N/A | - | N/A |
| join | -v 1 (unmatched from file1) 10MB | N/A | - | N/A | - | N/A |
| join | -o 0,1.2,2.2 10MB | N/A | - | N/A | - | N/A |
| join | self-join sorted 10MB | 0.0450s | 0.0433s | 0.0497s | **1.0x** | **1.1x** |
| link | hard link a file | 0.0015s | 0.0017s | N/A | **0.9x** | N/A |
| ln | symlink single file | 0.0015s | 0.0017s | N/A | **0.9x** | N/A |
| ln | symlink force overwrite (-sf) | 0.0016s | 0.0017s | N/A | **0.9x** | N/A |
| ln | hard link single file | 0.0016s | 0.0017s | N/A | **0.9x** | N/A |
| logname | logname (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| md5sum | single 100KB text | 0.0013s | 0.0026s | 0.0014s | **0.5x** | **0.5x** |
| md5sum | single 1MB text | 0.0027s | 0.0040s | 0.0031s | **0.7x** | **0.8x** |
| md5sum | single 10MB text | 0.0169s | 0.0193s | 0.0212s | **0.9x** | **1.1x** |
| md5sum | single 10MB binary | 0.0178s | 0.0202s | 0.0221s | **0.9x** | **1.1x** |
| md5sum | single 100MB text | 0.1598s | 0.1616s | 0.2018s | **1.0x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0039s | 0.0012s | **0.3x** | **0.3x** |
| md5sum | 100 files | 0.0020s | 0.0062s | 0.0021s | **0.3x** | **0.3x** |
| mkdir | mkdir single directory | 0.0018s | 0.0018s | N/A | **1.0x** | N/A |
| mkdir | mkdir -p nested directories | 0.0020s | 0.0021s | N/A | **1.0x** | N/A |
| mkfifo | mkfifo single fifo | 0.0017s | 0.0017s | N/A | **1.0x** | N/A |
| mknod | mknod named pipe | 0.0017s | 0.0017s | N/A | **1.0x** | N/A |
| mktemp | mktemp default | N/A | 0.0019s | N/A | - | N/A |
| mktemp | mktemp -d directory | N/A | 0.0020s | N/A | - | N/A |
| mv | mv 1MB file | 0.0037s | 0.0037s | N/A | **1.0x** | N/A |
| mv | mv 10MB file | 0.0110s | 0.0113s | N/A | **1.0x** | N/A |
| nice | nice true (default priority) | 0.0012s | 0.0014s | N/A | **0.9x** | N/A |
| nice | nice -n 10 true | 0.0012s | 0.0013s | N/A | **0.9x** | N/A |
| nl | default 1MB | 0.0046s | 0.0018s | 0.0025s | **2.5x** | **1.3x** |
| nl | default 10MB | 0.0340s | 0.0070s | 0.0113s | **4.9x** | **1.6x** |
| nl | -b a 10MB | 0.0340s | 0.0073s | 0.0110s | **4.7x** | **1.5x** |
| nl | -b a 10MB with blanks | 0.0436s | 0.0093s | 0.0162s | **4.7x** | **1.7x** |
| nl | -b a -n rz 10MB | 0.0340s | 0.0071s | 0.0112s | **4.8x** | **1.6x** |
| nl | -b a -w 8 -s ': ' 10MB | 0.0340s | 0.0079s | 0.0114s | **4.3x** | **1.4x** |
| nl | -b p'^the' 10MB | 0.0579s | 0.0122s | 0.0158s | **4.8x** | **1.3x** |
| nohup | nohup true | 0.0020s | 0.0021s | N/A | **0.9x** | N/A |
| nproc | nproc (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| nproc | nproc --all | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| paste | 2 columns 10MB | 0.0226s | 0.0091s | 0.1820s | **2.5x** | **20.0x** |
| paste | 3 columns 10MB | 0.0291s | 0.0145s | 0.1959s | **2.0x** | **13.5x** |
| paste | -d comma 10MB | 0.0226s | 0.0088s | 0.1830s | **2.6x** | **20.8x** |
| paste | -s 10MB single file | 0.0099s | 0.0054s | 0.0137s | **1.8x** | **2.6x** |
| paste | stdin split 2-way 10MB | 0.0299s | 0.0193s | 0.0364s | **1.5x** | **1.9x** |
| pathchk | pathchk default | 0.0008s | 0.0009s | N/A | **0.9x** | N/A |
| pathchk | pathchk -p (POSIX portable) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| pwd | pwd (no args) | 0.0000s | 0.0010s | N/A | - | N/A |
| pwd | pwd -L | 0.0000s | 0.0010s | N/A | - | N/A |
| pwd | pwd -P | 0.0000s | 0.0010s | N/A | - | N/A |
| readlink | readlink symlink | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| readlink | readlink -f (canonicalize) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| realpath | realpath . | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| realpath | realpath /tmp | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| realpath | realpath test data file | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| rev | reverse 100KB text | 0.0021s | 0.0010s | N/A | **2.1x** | N/A |
| rev | reverse 1MB text | 0.0141s | 0.0018s | N/A | **7.8x** | N/A |
| rev | reverse 10MB text | 0.1321s | 0.0075s | N/A | **17.7x** | N/A |
| rev | reverse 100MB text | 1.3137s | 0.0713s | N/A | **18.4x** | N/A |
| rev | reverse CSV 10MB | 0.0988s | 0.0071s | N/A | **14.0x** | N/A |
| rev | reverse repetitive 10MB | 0.2847s | 0.0122s | N/A | **23.4x** | N/A |
| rev | reverse 10KB single line | 0.0010s | 0.0010s | N/A | **1.0x** | N/A |
| rm | rm single file | 0.0020s | 0.0021s | N/A | **0.9x** | N/A |
| rm | rm -rf directory | 0.0068s | 0.0074s | N/A | **0.9x** | N/A |
| rmdir | rmdir single empty directory | 0.0017s | 0.0019s | N/A | **0.9x** | N/A |
| rmdir | rmdir -p nested directories | N/A | - | N/A | - | N/A |
| seq | seq 1000000 | 0.0097s | 0.0099s | N/A | **1.0x** | N/A |
| seq | seq 1 10000000 | 0.0897s | 0.0866s | N/A | **1.0x** | N/A |
| seq | seq 0 0.1 100000 (float) | 0.2267s | 0.1673s | N/A | **1.4x** | N/A |
| seq | seq -w 1 1000000 (zero-padded) | 0.2397s | 0.0150s | N/A | **16.0x** | N/A |
| sha1sum | single 1MB text | 0.0018s | 0.0031s | N/A | **0.6x** | N/A |
| sha1sum | single 10MB text | 0.0079s | 0.0093s | N/A | **0.9x** | N/A |
| sha1sum | single 10MB binary | 0.0086s | 0.0099s | N/A | **0.9x** | N/A |
| sha1sum | 100 files | 0.0020s | 0.0052s | N/A | **0.4x** | N/A |
| sha224sum | single 1MB text | 0.0019s | 0.0032s | N/A | **0.6x** | N/A |
| sha224sum | single 10MB text | 0.0083s | 0.0097s | N/A | **0.9x** | N/A |
| sha224sum | single 10MB binary | 0.0087s | 0.0101s | N/A | **0.9x** | N/A |
| sha256sum | single 100KB text | 0.0013s | 0.0026s | 0.0012s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0019s | 0.0032s | 0.0019s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0082s | 0.0097s | 0.0082s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0102s | 0.0086s | **0.9x** | **0.8x** |
| sha256sum | single 100MB text | 0.0743s | 0.0747s | 0.0739s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0039s | 0.0013s | **0.3x** | **0.3x** |
| sha256sum | 100 files | 0.0021s | 0.0050s | 0.0021s | **0.4x** | **0.4x** |
| sha384sum | single 1MB text | 0.0025s | 0.0038s | N/A | **0.7x** | N/A |
| sha384sum | single 10MB text | 0.0153s | 0.0167s | N/A | **0.9x** | N/A |
| sha384sum | single 10MB binary | 0.0162s | 0.0181s | N/A | **0.9x** | N/A |
| sha512sum | single 1MB text | 0.0026s | 0.0039s | N/A | **0.7x** | N/A |
| sha512sum | single 10MB text | 0.0152s | 0.0170s | N/A | **0.9x** | N/A |
| sha512sum | single 10MB binary | 0.0164s | 0.0174s | N/A | **0.9x** | N/A |
| shred | shred 1MB file | 0.0088s | 0.0058s | N/A | **1.5x** | N/A |
| shred | shred 1MB file with remove (-u) | 0.0147s | 0.0065s | N/A | **2.2x** | N/A |
| sleep | sleep 0 (startup overhead) | 0.0008s | 0.0009s | N/A | **0.9x** | N/A |
| sleep | sleep 0.001 (tiny sleep) | 0.0018s | 0.0020s | N/A | **0.9x** | N/A |
| sort | lexicographic 1MB | 0.0084s | 0.0038s | 0.0052s | **2.2x** | **1.4x** |
| sort | lexicographic 10MB random | 0.0548s | 0.0101s | 0.0335s | **5.4x** | **3.3x** |
| sort | already sorted 10MB | 0.0263s | 0.0051s | 0.0152s | **5.1x** | **3.0x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0067s | 0.0160s | **4.1x** | **2.4x** |
| sort | -n numeric 10MB | 0.0740s | 0.0061s | 0.0733s | **12.1x** | **12.0x** |
| sort | -r reverse 10MB | 0.0549s | 0.0101s | 0.0337s | **5.4x** | **3.3x** |
| sort | -u unique 10MB | 0.0580s | 0.0108s | 0.0371s | **5.4x** | **3.4x** |
| sort | -t, -k2 CSV 10MB | 0.0669s | 0.0397s | 0.0813s | **1.7x** | **2.1x** |
| sort | repetitive 10MB | 0.0543s | 0.0129s | 0.0333s | **4.2x** | **2.6x** |
| sort | --parallel=4 10MB | 0.0543s | 0.0098s | 0.0338s | **5.5x** | **3.4x** |
| split | split 10MB into 1MB chunks (-b 1m) | N/A | - | N/A | - | N/A |
| split | split 10MB by 1000 lines (-l 1000) | 0.0170s | 0.0171s | N/A | **1.0x** | N/A |
| sum | single 1MB text | 0.0024s | 0.0020s | N/A | **1.2x** | N/A |
| sum | single 10MB text | 0.0171s | 0.0127s | N/A | **1.3x** | N/A |
| sum | single 10MB binary | 0.0181s | 0.0134s | N/A | **1.4x** | N/A |
| sync | sync (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| tac | reverse 100KB text | 0.0009s | 0.0013s | 0.0011s | **0.7x** | **0.9x** |
| tac | reverse 1MB text | 0.0017s | 0.0020s | 0.0016s | **0.9x** | **0.8x** |
| tac | reverse 10MB text | 0.0089s | 0.0056s | 0.0054s | **1.6x** | **1.0x** |
| tac | reverse 100MB text | 0.0902s | 0.0283s | 0.0491s | **3.2x** | **1.7x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0056s | 0.0054s | **1.5x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0200s | 0.0102s | 0.0106s | **2.0x** | **1.0x** |
| tac | custom separator 1MB | 0.0056s | 0.0043s | 0.0051s | **1.3x** | **1.2x** |
| tail | default 1MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.2x** |
| tail | default 10MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.2x** |
| tail | default 100MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.2x** |
| tail | -n 1000 10MB | 0.0008s | 0.0012s | 0.0014s | **0.7x** | **1.2x** |
| tail | -n 100000 10MB | 0.0046s | 0.0030s | 0.0064s | **1.5x** | **2.1x** |
| tail | -n +100 10MB (from line 100) | 0.0026s | 0.0023s | 0.0015s | **1.1x** | **0.6x** |
| tail | -n +100000 10MB (from line 100000) | 0.0034s | 0.0034s | 0.0034s | **1.0x** | **1.0x** |
| tail | -c 1000000 10MB | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| tail | 100 small files | 0.0015s | 0.0024s | 0.0029s | **0.6x** | **1.2x** |
| tee | tee 1MB to /dev/null | N/A | - | N/A | - | N/A |
| tee | tee 10MB to /dev/null | N/A | - | N/A | - | N/A |
| test | test -f (file exists) | 0.0000s | 0.0009s | N/A | - | N/A |
| test | test 1 -eq 1 | 0.0000s | 0.0009s | N/A | - | N/A |
| test | test 'hello' = 'hello' | 0.0000s | 0.0009s | N/A | - | N/A |
| test | test -d /tmp | 0.0000s | 0.0010s | N/A | - | N/A |
| touch | create new file | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| touch | update existing file timestamp | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| touch | set specific timestamp (-t) | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| tr | a-z to A-Z 1MB | 0.0021s | 0.0016s | 0.0019s | **1.4x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0116s | 0.0041s | 0.0076s | **2.8x** | **1.9x** |
| tr | -d digits 10MB | 0.0152s | 0.0044s | 0.0140s | **3.4x** | **3.2x** |
| tr | -d lowercase 10MB | 0.0285s | 0.0052s | 0.0224s | **5.4x** | **4.3x** |
| tr | -s spaces 10MB | 0.0245s | 0.0041s | 0.0276s | **6.0x** | **6.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0112s | 0.0040s | 0.0078s | **2.8x** | **2.0x** |
| tr | -d [:digit:] 10MB CSV | 0.0155s | 0.0045s | 0.0141s | **3.4x** | **3.1x** |
| tr | translate binary 10MB | 0.0096s | 0.0041s | 0.0084s | **2.3x** | **2.0x** |
| true | true (startup overhead) | 0.0000s | 0.0007s | N/A | - | N/A |
| truncate | truncate to zero (-s 0) | 0.0029s | 0.0031s | N/A | **0.9x** | N/A |
| truncate | create 1M file (-s 1M) | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| tsort | tsort 100K pairs | N/A | - | N/A | - | N/A |
| tsort | tsort 1M pairs | N/A | - | N/A | - | N/A |
| tty | tty (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname -a | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname -r | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname -m | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| unexpand | unexpand 1MB text | 0.0028s | 0.0014s | 0.0021s | **2.0x** | **1.5x** |
| unexpand | unexpand 10MB text | 0.0205s | 0.0045s | 0.0107s | **4.6x** | **2.4x** |
| unexpand | -a 1MB text | 0.0087s | 0.0052s | 0.0112s | **1.7x** | **2.1x** |
| unexpand | -a 10MB text | 0.0818s | 0.0360s | 0.1052s | **2.3x** | **2.9x** |
| unexpand | -t 4 10MB text | 0.0821s | 0.0375s | 0.1056s | **2.2x** | **2.8x** |
| unexpand | expand|unexpand pipeline 10MB | 0.1132s | 0.1137s | 0.1499s | **1.0x** | **1.3x** |
| uniq | default 10MB many duplicates | 0.0115s | 0.0018s | 0.0110s | **6.3x** | **6.0x** |
| uniq | default 10MB sorted (low dup) | 0.0129s | 0.0032s | 0.0127s | **4.0x** | **3.9x** |
| uniq | -c count 10MB many dups | 0.0118s | 0.0019s | 0.0109s | **6.4x** | **5.9x** |
| uniq | -c count 10MB sorted | 0.0278s | 0.0070s | 0.0150s | **3.9x** | **2.1x** |
| uniq | -d duplicates only 10MB | 0.0117s | 0.0019s | 0.0108s | **6.3x** | **5.8x** |
| uniq | -u unique only 10MB | 0.0116s | 0.0018s | 0.0109s | **6.3x** | **5.9x** |
| uniq | -i case insensitive 10MB | 0.0131s | 0.0045s | 0.0125s | **2.9x** | **2.8x** |
| uniq | repetitive 10MB | 0.0404s | 0.0037s | 0.0149s | **11.0x** | **4.0x** |
| unlink | unlink a file | 0.0020s | 0.0021s | N/A | **0.9x** | N/A |
| wc | default 100KB text | 0.0013s | 0.0012s | 0.0014s | **1.1x** | **1.2x** |
| wc | default 1MB text | 0.0057s | 0.0028s | 0.0038s | **2.0x** | **1.4x** |
| wc | default 10MB text | 0.0542s | 0.0033s | 0.0307s | **16.3x** | **9.2x** |
| wc | default 100MB text | 0.4805s | 0.0139s | 0.2614s | **34.5x** | **18.8x** |
| wc | -l 10MB text | 0.0016s | 0.0026s | 0.0018s | **0.6x** | **0.7x** |
| wc | -w 10MB text | 0.0540s | 0.0075s | 0.0249s | **7.2x** | **3.3x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0540s | 0.0032s | 0.0019s | **16.9x** | **0.6x** |
| wc | -L 10MB text | 0.0541s | 0.0101s | 0.0166s | **5.4x** | **1.7x** |
| wc | default 10MB binary | 0.3179s | 0.0253s | 0.1554s | **12.6x** | **6.1x** |
| wc | default 10MB repetitive | 0.0724s | 0.0046s | 0.0415s | **15.9x** | **9.1x** |
| wc | 10 files | 0.0009s | 0.0012s | 0.0013s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0017s | 0.0017s | 0.0021s | **1.0x** | **1.2x** |
| whoami | whoami (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| yes | startup --help | 0.0008s | 0.0002s | N/A | **3.8x** | N/A |
| yes | startup --version | 0.0008s | 0.0002s | N/A | **4.1x** | N/A |
| yes | throughput 1M lines | 0.0030s | 0.0028s | N/A | **1.1x** | N/A |
| yes | throughput 10M lines | 0.0240s | 0.0189s | N/A | **1.3x** | N/A |
| yes | throughput hello 1M lines | 0.0063s | 0.0059s | N/A | **1.1x** | N/A |
| yes | throughput hello 10M lines | 0.0464s | 0.0574s | N/A | **0.8x** | N/A |
| yes | throughput 100MB | 0.0243s | 0.0353s | N/A | **0.7x** | N/A |
