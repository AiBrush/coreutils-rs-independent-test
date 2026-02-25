# fcoreutils v0.12.5 — Detailed Results

Generated: 2026-02-25 09:40:36 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 231 | 189 | 35 | 81.8% |
| Linux_aarch64 | 2224 | 2203 | 10 | 99.1% |
| Linux_x86_64 | 2224 | 2203 | 10 | 99.1% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

**Overall: 4595/4679 (98.2%)**

## Performance

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| arch | arch (no args) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| b2sum | single 100KB text | 0.0009s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0020s | 0.0022s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0148s | 0.0126s | 0.0122s | **1.2x** | **1.0x** |
| b2sum | single 10MB binary | 0.0154s | 0.0131s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | single 100MB text | 0.1420s | 0.1124s | 0.1123s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0153s | 0.0131s | 0.0121s | **1.2x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0148s | 0.0127s | 0.0119s | **1.2x** | **0.9x** |
| b2sum | 100 files | 0.0019s | 0.0021s | 0.0020s | **0.9x** | **1.0x** |
| base32 | encode 100KB text | 0.0009s | 0.0011s | N/A | **0.9x** | N/A |
| base32 | encode 1MB text | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| base32 | encode 10MB text | 0.0130s | 0.0134s | N/A | **1.0x** | N/A |
| base32 | encode 10MB binary | 0.0136s | 0.0135s | N/A | **1.0x** | N/A |
| base32 | decode 1MB | 0.0033s | 0.0027s | N/A | **1.2x** | N/A |
| base32 | decode 10MB | 0.0267s | 0.0184s | N/A | **1.4x** | N/A |
| base64 | encode 100KB text | 0.0010s | 0.0013s | 0.0011s | **0.7x** | **0.8x** |
| base64 | encode 1MB text | 0.0019s | 0.0015s | 0.0016s | **1.2x** | **1.0x** |
| base64 | encode 10MB text | 0.0111s | 0.0059s | 0.0067s | **1.9x** | **1.1x** |
| base64 | encode 10MB binary | 0.0116s | 0.0062s | 0.0071s | **1.9x** | **1.1x** |
| base64 | decode 1MB | 0.0037s | 0.0023s | 0.0041s | **1.6x** | **1.8x** |
| base64 | decode 10MB | 0.0306s | 0.0054s | 0.0312s | **5.6x** | **5.7x** |
| base64 | encode -w 76 10MB | 0.0112s | 0.0059s | 0.0068s | **1.9x** | **1.2x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0083s | 0.0048s | 0.0058s | **1.7x** | **1.2x** |
| basename | basename simple path | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| basename | basename with suffix (.txt) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| basenc | encode --base64 1MB | 0.0018s | 0.0020s | N/A | **0.9x** | N/A |
| basenc | encode --base64 10MB | 0.0114s | 0.0110s | N/A | **1.0x** | N/A |
| basenc | encode --base32 1MB | 0.0021s | 0.0021s | N/A | **1.0x** | N/A |
| basenc | encode --base16 1MB | 0.0023s | 0.0026s | N/A | **0.9x** | N/A |
| basenc | decode --base64 -d 1MB | 0.0038s | 0.0034s | N/A | **1.1x** | N/A |
| cat | passthrough 1MB | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| cat | passthrough 10MB | 0.0015s | 0.0013s | 0.0014s | **1.2x** | **1.1x** |
| cat | passthrough 100MB | 0.0094s | 0.0036s | 0.0048s | **2.6x** | **1.3x** |
| cat | -n 1MB | 0.0019s | 0.0019s | 0.0018s | **1.1x** | **1.0x** |
| cat | -n 10MB | 0.0101s | 0.0062s | 0.0070s | **1.6x** | **1.1x** |
| cat | -b 10MB | 0.0102s | 0.0062s | 0.0070s | **1.7x** | **1.1x** |
| cat | -A 1MB | 0.0018s | 0.0017s | 0.0031s | **1.0x** | **1.8x** |
| cat | 100 small files | 0.0025s | 0.0020s | 0.0025s | **1.3x** | **1.3x** |
| cat | binary 10MB | 0.0015s | 0.0013s | 0.0015s | **1.2x** | **1.1x** |
| chgrp | chgrp current group on file | 0.0021s | 0.0023s | N/A | **0.9x** | N/A |
| chgrp | chgrp current group on 1MB file | 0.0029s | 0.0031s | N/A | **1.0x** | N/A |
| chmod | chmod 644 on file | 0.0021s | 0.0022s | N/A | **1.0x** | N/A |
| chmod | chmod u+x on file | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| chown | chown current user on file | 0.0021s | 0.0023s | N/A | **0.9x** | N/A |
| chown | chown current user on 1MB file | 0.0029s | 0.0031s | N/A | **0.9x** | N/A |
| cksum | single 1MB text | 0.0013s | 0.0011s | N/A | **1.2x** | N/A |
| cksum | single 10MB text | 0.0027s | 0.0023s | N/A | **1.1x** | N/A |
| cksum | single 10MB binary | 0.0030s | 0.0025s | N/A | **1.2x** | N/A |
| comm | default 10MB sorted | 0.0230s | 0.0073s | 0.0200s | **3.2x** | **2.7x** |
| comm | -12 (common only) 10MB | 0.0197s | 0.0056s | 0.0190s | **3.5x** | **3.4x** |
| comm | -23 (unique to file1) 10MB | 0.0202s | 0.0059s | 0.0192s | **3.4x** | **3.3x** |
| comm | -3 10MB | 0.0219s | 0.0067s | 0.0202s | **3.3x** | **3.0x** |
| comm | identical 10MB sorted | 0.0285s | 0.0123s | 0.0193s | **2.3x** | **1.6x** |
| cp | cp 1MB file | 0.0028s | 0.0029s | N/A | **1.0x** | N/A |
| cp | cp 10MB file | 0.0106s | 0.0123s | N/A | **0.9x** | N/A |
| cp | cp -r directory (many_files) | 0.0069s | 0.0068s | N/A | **1.0x** | N/A |
| csplit | csplit 1MB by pattern | 0.4378s | 0.0249s | N/A | **17.6x** | N/A |
| cut | -b1-100 10MB CSV | 0.0215s | 0.0040s | 0.0066s | **5.4x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0214s | 0.0040s | 0.0065s | **5.4x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0156s | 0.0094s | 0.0080s | **1.7x** | **0.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0209s | 0.0117s | 0.0175s | **1.8x** | **1.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0233s | 0.0104s | 0.0133s | **2.2x** | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0296s | 0.0111s | 0.0158s | **2.7x** | **1.4x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | 0.0011s | **0.7x** | **0.9x** |
| cut | -d, -f1 1MB text | 0.0031s | 0.0030s | 0.0019s | **1.0x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0010s | **0.7x** | **0.9x** |
| dd | dd read 10MB (bs=4096) | 0.0034s | 0.0036s | N/A | **0.9x** | N/A |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0108s | 0.0131s | N/A | **0.8x** | N/A |
| dirname | dirname simple path | 0.0007s | 0.0010s | N/A | **0.8x** | N/A |
| dirname | dirname deep path | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| echo | echo hello | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| echo | echo -n hello | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| echo | echo -e with escapes | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| env | print all env vars | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| env | env true (run command) | 0.0012s | 0.0013s | N/A | **0.9x** | N/A |
| env | env VAR=value true | 0.0012s | 0.0014s | N/A | **0.9x** | N/A |
| expand | expand 10MB tabbed (default) | 0.0424s | 0.0355s | 0.0932s | **1.2x** | **2.6x** |
| expand | expand 1MB text | 0.0031s | 0.0011s | 0.0013s | **2.9x** | **1.3x** |
| expand | -t 4 10MB tabbed | 0.0397s | 0.0352s | 0.0937s | **1.1x** | **2.7x** |
| expand | -t 2 10MB tabbed | 0.0340s | 0.0351s | 0.0932s | **1.0x** | **2.7x** |
| expand | --initial 10MB tabbed | 0.0216s | 0.0067s | 0.0859s | **3.2x** | **12.9x** |
| expand | expand CSV 10MB | 0.0192s | 0.0018s | 0.0037s | **10.4x** | **2.0x** |
| expr | expr 1 + 1 | 0.0008s | 0.0011s | N/A | **0.8x** | N/A |
| expr | expr 999999 * 999999 | 0.0009s | 0.0010s | N/A | **0.8x** | N/A |
| expr | expr length 'hello world' | 0.0009s | 0.0010s | N/A | **0.9x** | N/A |
| expr | expr 'hello' : 'hel' | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| factor | factor 1234567890 | 0.0008s | 0.0010s | N/A | **0.9x** | N/A |
| factor | factor 999999999999999989 (large prime) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| factor | factor 1-100000 via stdin | N/A | - | N/A | - | N/A |
| false | false (startup overhead) | 0.0000s | 0.0007s | N/A | - | N/A |
| fold | fold 10MB wide lines (default) | 0.0328s | 0.0274s | 0.0166s | **1.2x** | **0.6x** |
| fold | fold 1MB text | 0.0040s | 0.0020s | 0.0028s | **2.0x** | **1.4x** |
| fold | fold 10MB text | 0.0337s | 0.0210s | 0.0187s | **1.6x** | **0.9x** |
| fold | -w 40 10MB | 0.0333s | 0.0290s | 0.0189s | **1.1x** | **0.7x** |
| fold | -w 20 10MB | 0.0351s | 0.0286s | 0.0231s | **1.2x** | **0.8x** |
| fold | -s -w 60 10MB | 0.0380s | 0.0423s | 0.0207s | **0.9x** | **0.5x** |
| fold | -s -w 40 10MB | 0.0410s | 0.0440s | 0.0240s | **0.9x** | **0.5x** |
| fold | -b -w 40 10MB | 0.0326s | 0.0068s | 0.0101s | **4.8x** | **1.5x** |
| groups | groups (no args) | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| head | default 1MB text | 0.0007s | 0.0009s | 0.0010s | **0.7x** | **1.1x** |
| head | default 10MB text | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| head | default 100MB text | 0.0009s | 0.0011s | 0.0011s | **0.8x** | **1.0x** |
| head | -n 1000 10MB | 0.0008s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| head | -n 100000 10MB | 0.0058s | 0.0035s | 0.0035s | **1.7x** | **1.0x** |
| head | -c 1000000 10MB | 0.0010s | 0.0011s | 0.0011s | **0.9x** | **1.0x** |
| head | -n -100 10MB (all but last 100) | 0.0042s | 0.0020s | 0.0014s | **2.1x** | **0.7x** |
| head | 100 small files | 0.0014s | 0.0017s | 0.0019s | **0.8x** | **1.1x** |
| hostid | hostid (no args) | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| id | id (no args) | 0.0012s | 0.0012s | N/A | **1.0x** | N/A |
| id | id -u | 0.0010s | 0.0009s | N/A | **1.1x** | N/A |
| id | id -g | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| id | id -un | 0.0011s | 0.0011s | N/A | **1.0x** | N/A |
| install | install 1MB file | 0.0028s | 0.0029s | N/A | **1.0x** | N/A |
| install | install -d create directory | 0.0020s | 0.0019s | N/A | **1.1x** | N/A |
| join | default join 10MB | N/A | - | N/A | - | N/A |
| join | outer join 10MB | N/A | - | N/A | - | N/A |
| join | -v 1 (unmatched from file1) 10MB | N/A | - | N/A | - | N/A |
| join | -o 0,1.2,2.2 10MB | N/A | - | N/A | - | N/A |
| join | self-join sorted 10MB | 0.0450s | 0.0437s | 0.0498s | **1.0x** | **1.1x** |
| link | hard link a file | 0.0015s | 0.0017s | N/A | **0.9x** | N/A |
| ln | symlink single file | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| ln | symlink force overwrite (-sf) | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| ln | hard link single file | 0.0017s | 0.0019s | N/A | **0.9x** | N/A |
| logname | logname (no args) | 0.0017s | 0.0010s | N/A | **1.8x** | N/A |
| md5sum | single 100KB text | 0.0014s | 0.0031s | 0.0014s | **0.5x** | **0.5x** |
| md5sum | single 1MB text | 0.0027s | 0.0041s | 0.0032s | **0.7x** | **0.8x** |
| md5sum | single 10MB text | 0.0176s | 0.0196s | 0.0221s | **0.9x** | **1.1x** |
| md5sum | single 10MB binary | 0.0186s | 0.0210s | 0.0226s | **0.9x** | **1.1x** |
| md5sum | single 100MB text | 0.1612s | 0.1620s | 0.2023s | **1.0x** | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0025s | 0.0013s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0020s | 0.0031s | 0.0021s | **0.6x** | **0.7x** |
| mkdir | mkdir single directory | 0.0018s | 0.0018s | N/A | **1.0x** | N/A |
| mkdir | mkdir -p nested directories | 0.0021s | 0.0021s | N/A | **1.0x** | N/A |
| mkfifo | mkfifo single fifo | 0.0018s | 0.0018s | N/A | **1.0x** | N/A |
| mknod | mknod named pipe | 0.0017s | 0.0018s | N/A | **1.0x** | N/A |
| mktemp | mktemp default | N/A | 0.0019s | N/A | - | N/A |
| mktemp | mktemp -d directory | N/A | 0.0020s | N/A | - | N/A |
| mv | mv 1MB file | 0.0038s | 0.0040s | N/A | **1.0x** | N/A |
| mv | mv 10MB file | 0.0125s | 0.0125s | N/A | **1.0x** | N/A |
| nice | nice true (default priority) | 0.0012s | 0.0014s | N/A | **0.9x** | N/A |
| nice | nice -n 10 true | 0.0012s | 0.0013s | N/A | **0.9x** | N/A |
| nl | default 1MB | 0.0047s | 0.0019s | 0.0025s | **2.5x** | **1.3x** |
| nl | default 10MB | 0.0349s | 0.0080s | 0.0120s | **4.4x** | **1.5x** |
| nl | -b a 10MB | 0.0346s | 0.0079s | 0.0121s | **4.4x** | **1.5x** |
| nl | -b a 10MB with blanks | 0.0449s | 0.0106s | 0.0172s | **4.2x** | **1.6x** |
| nl | -b a -n rz 10MB | 0.0346s | 0.0085s | 0.0120s | **4.1x** | **1.4x** |
| nl | -b a -w 8 -s ': ' 10MB | 0.0350s | 0.0081s | 0.0123s | **4.3x** | **1.5x** |
| nl | -b p'^the' 10MB | 0.0584s | 0.0134s | 0.0182s | **4.4x** | **1.4x** |
| nohup | nohup true | 0.0020s | 0.0023s | N/A | **0.9x** | N/A |
| nproc | nproc (no args) | 0.0008s | 0.0011s | N/A | **0.7x** | N/A |
| nproc | nproc --all | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| paste | 2 columns 10MB | 0.0234s | 0.0099s | 0.1846s | **2.4x** | **18.6x** |
| paste | 3 columns 10MB | 0.0298s | 0.0147s | 0.1961s | **2.0x** | **13.3x** |
| paste | -d comma 10MB | 0.0234s | 0.0100s | 0.1845s | **2.3x** | **18.5x** |
| paste | -s 10MB single file | 0.0101s | 0.0055s | 0.0141s | **1.8x** | **2.5x** |
| paste | stdin split 2-way 10MB | 0.0299s | 0.0210s | 0.0360s | **1.4x** | **1.7x** |
| pathchk | pathchk default | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| pathchk | pathchk -p (POSIX portable) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| pwd | pwd (no args) | 0.0001s | 0.0010s | N/A | **0.1x** | N/A |
| pwd | pwd -L | 0.0000s | 0.0010s | N/A | - | N/A |
| pwd | pwd -P | 0.0000s | 0.0010s | N/A | - | N/A |
| readlink | readlink symlink | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| readlink | readlink -f (canonicalize) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| realpath | realpath . | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| realpath | realpath /tmp | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| realpath | realpath test data file | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| rev | reverse 100KB text | 0.0022s | 0.0011s | N/A | **2.0x** | N/A |
| rev | reverse 1MB text | 0.0144s | 0.0018s | N/A | **7.9x** | N/A |
| rev | reverse 10MB text | 0.1327s | 0.0075s | N/A | **17.7x** | N/A |
| rev | reverse 100MB text | 1.3197s | 0.0715s | N/A | **18.5x** | N/A |
| rev | reverse CSV 10MB | 0.0992s | 0.0072s | N/A | **13.7x** | N/A |
| rev | reverse repetitive 10MB | 0.2846s | 0.0135s | N/A | **21.2x** | N/A |
| rev | reverse 10KB single line | 0.0010s | 0.0011s | N/A | **0.9x** | N/A |
| rm | rm single file | 0.0021s | 0.0025s | N/A | **0.9x** | N/A |
| rm | rm -rf directory | 0.0073s | 0.0080s | N/A | **0.9x** | N/A |
| rmdir | rmdir single empty directory | 0.0018s | 0.0025s | N/A | **0.7x** | N/A |
| rmdir | rmdir -p nested directories | N/A | - | N/A | - | N/A |
| seq | seq 1000000 | 0.0101s | 0.0110s | N/A | **0.9x** | N/A |
| seq | seq 1 10000000 | 0.0900s | 0.0868s | N/A | **1.0x** | N/A |
| seq | seq 0 0.1 100000 (float) | 0.2283s | 0.1685s | N/A | **1.4x** | N/A |
| seq | seq -w 1 1000000 (zero-padded) | 0.2420s | 0.0152s | N/A | **15.9x** | N/A |
| sha1sum | single 1MB text | 0.0018s | 0.0032s | N/A | **0.6x** | N/A |
| sha1sum | single 10MB text | 0.0080s | 0.0095s | N/A | **0.8x** | N/A |
| sha1sum | single 10MB binary | 0.0085s | 0.0101s | N/A | **0.8x** | N/A |
| sha1sum | 100 files | 0.0020s | 0.0032s | N/A | **0.6x** | N/A |
| sha224sum | single 1MB text | 0.0018s | 0.0032s | N/A | **0.6x** | N/A |
| sha224sum | single 10MB text | 0.0089s | 0.0104s | N/A | **0.9x** | N/A |
| sha224sum | single 10MB binary | 0.0093s | 0.0105s | N/A | **0.9x** | N/A |
| sha256sum | single 100KB text | 0.0012s | 0.0026s | 0.0013s | **0.5x** | **0.5x** |
| sha256sum | single 1MB text | 0.0019s | 0.0034s | 0.0019s | **0.6x** | **0.6x** |
| sha256sum | single 10MB text | 0.0093s | 0.0108s | 0.0093s | **0.9x** | **0.9x** |
| sha256sum | single 10MB binary | 0.0096s | 0.0113s | 0.0096s | **0.9x** | **0.9x** |
| sha256sum | single 100MB text | 0.0751s | 0.0761s | 0.0748s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0012s | 0.0025s | 0.0013s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0021s | 0.0031s | 0.0021s | **0.7x** | **0.7x** |
| sha384sum | single 1MB text | 0.0026s | 0.0040s | N/A | **0.7x** | N/A |
| sha384sum | single 10MB text | 0.0162s | 0.0175s | N/A | **0.9x** | N/A |
| sha384sum | single 10MB binary | 0.0168s | 0.0187s | N/A | **0.9x** | N/A |
| sha512sum | single 1MB text | 0.0029s | 0.0044s | N/A | **0.6x** | N/A |
| sha512sum | single 10MB text | 0.0164s | 0.0183s | N/A | **0.9x** | N/A |
| sha512sum | single 10MB binary | 0.0172s | 0.0187s | N/A | **0.9x** | N/A |
| shred | shred 1MB file | 0.0096s | 0.0064s | N/A | **1.5x** | N/A |
| shred | shred 1MB file with remove (-u) | 0.0146s | 0.0073s | N/A | **2.0x** | N/A |
| sleep | sleep 0 (startup overhead) | 0.0009s | 0.0010s | N/A | **0.9x** | N/A |
| sleep | sleep 0.001 (tiny sleep) | 0.0019s | 0.0021s | N/A | **0.9x** | N/A |
| sort | lexicographic 1MB | 0.0089s | 0.0041s | 0.0054s | **2.2x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0583s | 0.0117s | 0.0347s | **5.0x** | **3.0x** |
| sort | already sorted 10MB | 0.0280s | 0.0056s | 0.0159s | **5.0x** | **2.8x** |
| sort | reverse sorted 10MB | 0.0279s | 0.0070s | 0.0161s | **4.0x** | **2.3x** |
| sort | -n numeric 10MB | 0.0785s | 0.0065s | 0.0782s | **12.1x** | **12.1x** |
| sort | -r reverse 10MB | 0.0604s | 0.0111s | 0.0346s | **5.5x** | **3.1x** |
| sort | -u unique 10MB | 0.0616s | 0.0125s | 0.0408s | **4.9x** | **3.3x** |
| sort | -t, -k2 CSV 10MB | 0.0707s | 0.0440s | 0.0847s | **1.6x** | **1.9x** |
| sort | repetitive 10MB | 0.0574s | 0.0141s | 0.0355s | **4.1x** | **2.5x** |
| sort | --parallel=4 10MB | 0.0599s | 0.0127s | 0.0377s | **4.7x** | **3.0x** |
| split | split 10MB into 1MB chunks (-b 1m) | N/A | - | N/A | - | N/A |
| split | split 10MB by 1000 lines (-l 1000) | 0.0192s | 0.0194s | N/A | **1.0x** | N/A |
| sum | single 1MB text | 0.0025s | 0.0022s | N/A | **1.1x** | N/A |
| sum | single 10MB text | 0.0182s | 0.0137s | N/A | **1.3x** | N/A |
| sum | single 10MB binary | 0.0194s | 0.0147s | N/A | **1.3x** | N/A |
| sync | sync (no args) | 0.0009s | 0.0010s | N/A | **0.9x** | N/A |
| tac | reverse 100KB text | 0.0009s | 0.0016s | 0.0012s | **0.6x** | **0.8x** |
| tac | reverse 1MB text | 0.0018s | 0.0020s | 0.0019s | **0.9x** | **0.9x** |
| tac | reverse 10MB text | 0.0101s | 0.0072s | 0.0060s | **1.4x** | **0.8x** |
| tac | reverse 100MB text | 0.0920s | 0.0292s | 0.0498s | **3.1x** | **1.7x** |
| tac | reverse CSV 10MB | 0.0085s | 0.0058s | 0.0058s | **1.5x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0211s | 0.0110s | 0.0116s | **1.9x** | **1.1x** |
| tac | custom separator 1MB | 0.0057s | 0.0044s | 0.0052s | **1.3x** | **1.2x** |
| tail | default 1MB text | 0.0008s | 0.0017s | 0.0013s | **0.5x** | **0.8x** |
| tail | default 10MB text | 0.0011s | 0.0012s | 0.0015s | **0.9x** | **1.2x** |
| tail | default 100MB text | 0.0009s | 0.0014s | 0.0014s | **0.6x** | **1.0x** |
| tail | -n 1000 10MB | 0.0008s | 0.0014s | 0.0016s | **0.6x** | **1.2x** |
| tail | -n 100000 10MB | 0.0048s | 0.0032s | 0.0070s | **1.5x** | **2.2x** |
| tail | -n +100 10MB (from line 100) | 0.0034s | 0.0028s | 0.0017s | **1.2x** | **0.6x** |
| tail | -n +100000 10MB (from line 100000) | 0.0044s | 0.0044s | 0.0046s | **1.0x** | **1.0x** |
| tail | -c 1000000 10MB | 0.0011s | 0.0013s | 0.0013s | **0.9x** | **1.0x** |
| tail | 100 small files | 0.0018s | 0.0029s | 0.0033s | **0.6x** | **1.2x** |
| tee | tee 1MB to /dev/null | N/A | - | N/A | - | N/A |
| tee | tee 10MB to /dev/null | N/A | - | N/A | - | N/A |
| test | test -f (file exists) | 0.0000s | 0.0011s | N/A | - | N/A |
| test | test 1 -eq 1 | 0.0000s | 0.0009s | N/A | - | N/A |
| test | test 'hello' = 'hello' | 0.0000s | 0.0010s | N/A | - | N/A |
| test | test -d /tmp | 0.0000s | 0.0010s | N/A | - | N/A |
| touch | create new file | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| touch | update existing file timestamp | 0.0010s | 0.0012s | N/A | **0.8x** | N/A |
| touch | set specific timestamp (-t) | 0.0018s | 0.0019s | N/A | **1.0x** | N/A |
| tr | a-z to A-Z 1MB | 0.0025s | 0.0020s | 0.0019s | **1.3x** | **0.9x** |
| tr | a-z to A-Z 10MB | 0.0125s | 0.0047s | 0.0080s | **2.6x** | **1.7x** |
| tr | -d digits 10MB | 0.0161s | 0.0048s | 0.0149s | **3.3x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0284s | 0.0053s | 0.0235s | **5.3x** | **4.4x** |
| tr | -s spaces 10MB | 0.0261s | 0.0048s | 0.0289s | **5.5x** | **6.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0050s | 0.0077s | **2.6x** | **1.5x** |
| tr | -d [:digit:] 10MB CSV | 0.0169s | 0.0054s | 0.0151s | **3.1x** | **2.8x** |
| tr | translate binary 10MB | 0.0101s | 0.0050s | 0.0086s | **2.0x** | **1.7x** |
| true | true (startup overhead) | 0.0000s | 0.0009s | N/A | - | N/A |
| truncate | truncate to zero (-s 0) | 0.0034s | 0.0034s | N/A | **1.0x** | N/A |
| truncate | create 1M file (-s 1M) | 0.0019s | 0.0021s | N/A | **0.9x** | N/A |
| tsort | tsort 100K pairs | N/A | - | N/A | - | N/A |
| tsort | tsort 1M pairs | N/A | - | N/A | - | N/A |
| tty | tty (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| uname | uname (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| uname | uname -a | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname -r | 0.0008s | 0.0010s | N/A | **0.7x** | N/A |
| uname | uname -m | 0.0008s | 0.0012s | N/A | **0.7x** | N/A |
| unexpand | unexpand 1MB text | 0.0030s | 0.0015s | 0.0022s | **2.0x** | **1.4x** |
| unexpand | unexpand 10MB text | 0.0220s | 0.0054s | 0.0126s | **4.0x** | **2.3x** |
| unexpand | -a 1MB text | 0.0094s | 0.0057s | 0.0118s | **1.7x** | **2.1x** |
| unexpand | -a 10MB text | 0.0832s | 0.0372s | 0.1060s | **2.2x** | **2.9x** |
| unexpand | -t 4 10MB text | 0.0828s | 0.0387s | 0.1060s | **2.1x** | **2.7x** |
| unexpand | expand|unexpand pipeline 10MB | 0.1158s | 0.1194s | 0.1540s | **1.0x** | **1.3x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | 0.0111s | **6.1x** | **5.7x** |
| uniq | default 10MB sorted (low dup) | 0.0131s | 0.0031s | 0.0127s | **4.2x** | **4.1x** |
| uniq | -c count 10MB many dups | 0.0117s | 0.0018s | 0.0108s | **6.4x** | **5.9x** |
| uniq | -c count 10MB sorted | 0.0283s | 0.0071s | 0.0150s | **4.0x** | **2.1x** |
| uniq | -d duplicates only 10MB | 0.0117s | 0.0020s | 0.0109s | **5.9x** | **5.5x** |
| uniq | -u unique only 10MB | 0.0116s | 0.0018s | 0.0109s | **6.4x** | **6.0x** |
| uniq | -i case insensitive 10MB | 0.0130s | 0.0047s | 0.0126s | **2.8x** | **2.7x** |
| uniq | repetitive 10MB | 0.0409s | 0.0040s | 0.0152s | **10.3x** | **3.8x** |
| unlink | unlink a file | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| wc | default 100KB text | 0.0021s | 0.0013s | 0.0014s | **1.6x** | **1.1x** |
| wc | default 1MB text | 0.0056s | 0.0037s | 0.0039s | **1.5x** | **1.0x** |
| wc | default 10MB text | 0.0544s | 0.0032s | 0.0309s | **17.0x** | **9.6x** |
| wc | default 100MB text | 0.4823s | 0.0144s | 0.2623s | **33.5x** | **18.2x** |
| wc | -l 10MB text | 0.0021s | 0.0026s | 0.0021s | **0.8x** | **0.8x** |
| wc | -w 10MB text | 0.0546s | 0.0142s | 0.0251s | **3.8x** | **1.8x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.2x** |
| wc | -m 10MB text | 0.0558s | 0.0033s | 0.0020s | **17.1x** | **0.6x** |
| wc | -L 10MB text | 0.0544s | 0.0103s | 0.0166s | **5.3x** | **1.6x** |
| wc | default 10MB binary | 0.3180s | 0.0276s | 0.1554s | **11.5x** | **5.6x** |
| wc | default 10MB repetitive | 0.0739s | 0.0049s | 0.0424s | **15.1x** | **8.6x** |
| wc | 10 files | 0.0009s | 0.0013s | 0.0013s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0017s | 0.0018s | 0.0021s | **0.9x** | **1.2x** |
| whoami | whoami (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| yes | startup --help | 0.0008s | 0.0002s | N/A | **4.1x** | N/A |
| yes | startup --version | 0.0008s | 0.0002s | N/A | **4.0x** | N/A |
| yes | throughput 1M lines | 0.0028s | 0.0028s | N/A | **1.0x** | N/A |
| yes | throughput 10M lines | 0.0238s | 0.0284s | N/A | **0.8x** | N/A |
| yes | throughput hello 1M lines | 0.0063s | 0.0062s | N/A | **1.0x** | N/A |
| yes | throughput hello 10M lines | 0.0549s | 0.0546s | N/A | **1.0x** | N/A |
| yes | throughput 100MB | 0.0268s | 0.0350s | N/A | **0.8x** | N/A |
