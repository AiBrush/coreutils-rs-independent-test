# fcoreutils v0.9.7 — Detailed Results

Generated: 2026-02-25 03:19:03 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 329 | 225 | 104 | 68.4% |
| Linux_aarch64 | 440 | 436 | 4 | 99.1% |
| Linux_x86_64 | 440 | 436 | 4 | 99.1% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

**Overall: 1097/1209 (90.7%)**

## Performance

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| arch | arch (no args) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| b2sum | single 100KB text | 0.0007s | 0.0009s | 0.0011s | **0.8x** | **1.1x** |
| b2sum | single 1MB text | 0.0019s | 0.0018s | 0.0019s | **1.1x** | **1.0x** |
| b2sum | single 10MB text | 0.0138s | 0.0116s | 0.0107s | **1.2x** | **0.9x** |
| b2sum | single 10MB binary | 0.0144s | 0.0125s | 0.0114s | **1.2x** | **0.9x** |
| b2sum | single 100MB text | 0.1362s | 0.0971s | 0.1040s | **1.4x** | **1.1x** |
| b2sum | -l 256 10MB | 0.0141s | 0.0120s | 0.0111s | **1.2x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0141s | 0.0123s | 0.0114s | **1.1x** | **0.9x** |
| b2sum | 100 files | 0.0013s | 0.0019s | 0.0014s | **0.7x** | **0.7x** |
| base32 | encode 100KB text | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| base32 | encode 1MB text | 0.0017s | 0.0020s | N/A | **0.9x** | N/A |
| base32 | encode 10MB text | 0.0123s | 0.0131s | N/A | **0.9x** | N/A |
| base32 | encode 10MB binary | 0.0130s | 0.0139s | N/A | **0.9x** | N/A |
| base32 | decode 1MB | 0.0034s | 0.0025s | N/A | **1.4x** | N/A |
| base32 | decode 10MB | 0.0299s | 0.0178s | N/A | **1.7x** | N/A |
| base64 | encode 100KB text | 0.0007s | 0.0012s | 0.0008s | **0.6x** | **0.7x** |
| base64 | encode 1MB text | 0.0016s | 0.0014s | 0.0011s | **1.1x** | **0.8x** |
| base64 | encode 10MB text | 0.0102s | 0.0064s | 0.0045s | **1.6x** | **0.7x** |
| base64 | encode 10MB binary | 0.0107s | 0.0067s | 0.0047s | **1.6x** | **0.7x** |
| base64 | decode 1MB | 0.0035s | 0.0024s | 0.0032s | **1.5x** | **1.4x** |
| base64 | decode 10MB | 0.0303s | 0.0046s | 0.0253s | **6.6x** | **5.5x** |
| base64 | encode -w 76 10MB | 0.0102s | 0.0062s | 0.0045s | **1.6x** | **0.7x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0048s | 0.0044s | **1.7x** | **0.9x** |
| basename | basename simple path | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| basename | basename with suffix (.txt) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| basenc | encode --base64 1MB | 0.0015s | 0.0018s | N/A | **0.8x** | N/A |
| basenc | encode --base64 10MB | 0.0096s | 0.0110s | N/A | **0.9x** | N/A |
| basenc | encode --base32 1MB | 0.0018s | 0.0020s | N/A | **0.9x** | N/A |
| basenc | encode --base16 1MB | 0.0018s | 0.0019s | N/A | **0.9x** | N/A |
| basenc | decode --base64 -d 1MB | 0.0036s | 0.0039s | N/A | **0.9x** | N/A |
| cat | passthrough 1MB | 0.0007s | 0.0009s | 0.0008s | **0.8x** | **0.9x** |
| cat | passthrough 10MB | 0.0012s | 0.0011s | 0.0011s | **1.1x** | **1.0x** |
| cat | passthrough 100MB | 0.0117s | 0.0030s | 0.0035s | **3.9x** | **1.2x** |
| cat | -n 1MB | 0.0016s | 0.0020s | 0.0014s | **0.8x** | **0.7x** |
| cat | -n 10MB | 0.0097s | 0.0060s | 0.0059s | **1.6x** | **1.0x** |
| cat | -b 10MB | 0.0094s | 0.0060s | 0.0059s | **1.6x** | **1.0x** |
| cat | -A 1MB | 0.0015s | 0.0018s | 0.0028s | **0.9x** | **1.5x** |
| cat | 100 small files | 0.0016s | 0.0013s | 0.0015s | **1.2x** | **1.1x** |
| cat | binary 10MB | 0.0013s | 0.0011s | 0.0011s | **1.1x** | **1.0x** |
| chgrp | chgrp current group on file | 0.0015s | 0.0017s | N/A | **0.9x** | N/A |
| chgrp | chgrp current group on 1MB file | 0.0019s | 0.0021s | N/A | **0.9x** | N/A |
| chmod | chmod 644 on file | 0.0015s | 0.0017s | N/A | **0.9x** | N/A |
| chmod | chmod u+x on file | 0.0014s | 0.0017s | N/A | **0.8x** | N/A |
| chown | chown current user on file | 0.0015s | 0.0018s | N/A | **0.8x** | N/A |
| chown | chown current user on 1MB file | 0.0019s | 0.0022s | N/A | **0.9x** | N/A |
| cksum | single 1MB text | 0.0010s | 0.0009s | N/A | **1.1x** | N/A |
| cksum | single 10MB text | 0.0019s | 0.0019s | N/A | **1.0x** | N/A |
| cksum | single 10MB binary | 0.0020s | 0.0019s | N/A | **1.1x** | N/A |
| comm | default 10MB sorted | 0.0247s | 0.0074s | 0.0179s | **3.3x** | **2.4x** |
| comm | -12 (common only) 10MB | 0.0215s | 0.0051s | 0.0167s | **4.2x** | **3.3x** |
| comm | -23 (unique to file1) 10MB | 0.0218s | 0.0059s | 0.0169s | **3.7x** | **2.9x** |
| comm | -3 10MB | 0.0234s | 0.0067s | 0.0178s | **3.5x** | **2.7x** |
| comm | identical 10MB sorted | 0.0360s | 0.0115s | 0.0168s | **3.1x** | **1.5x** |
| cp | cp 1MB file | 0.0018s | 0.0020s | N/A | **0.9x** | N/A |
| cp | cp 10MB file | 0.0055s | 0.0074s | N/A | **0.7x** | N/A |
| cp | cp -r directory (many_files) | 0.0037s | 0.0057s | N/A | **0.6x** | N/A |
| csplit | csplit 1MB by pattern | 0.2087s | 0.0224s | N/A | **9.3x** | N/A |
| cut | -b1-100 10MB CSV | 0.0190s | 0.0033s | 0.0053s | **5.8x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0191s | 0.0032s | 0.0052s | **6.0x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0206s | 0.0096s | 0.0070s | **2.2x** | **0.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0237s | 0.0111s | 0.0156s | **2.1x** | **1.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0260s | 0.0102s | 0.0118s | **2.5x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0294s | 0.0110s | 0.0149s | **2.7x** | **1.3x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0012s | 0.0008s | **0.5x** | **0.7x** |
| cut | -d, -f1 1MB text | 0.0039s | 0.0027s | 0.0016s | **1.4x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0011s | 0.0008s | **0.5x** | **0.7x** |
| dd | dd read 10MB (bs=4096) | 0.0020s | 0.0023s | N/A | **0.9x** | N/A |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0064s | 0.0115s | N/A | **0.6x** | N/A |
| dirname | dirname simple path | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| dirname | dirname deep path | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| echo | echo hello | 0.0005s | 0.0008s | N/A | **0.7x** | N/A |
| echo | echo -n hello | 0.0005s | 0.0009s | N/A | **0.6x** | N/A |
| echo | echo -e with escapes | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| env | print all env vars | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| env | env true (run command) | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| env | env VAR=value true | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| expand | expand 10MB tabbed (default) | 0.0411s | 0.0329s | 0.0833s | **1.3x** | **2.5x** |
| expand | expand 1MB text | 0.0030s | 0.0010s | 0.0011s | **3.1x** | **1.1x** |
| expand | -t 4 10MB tabbed | 0.0385s | 0.0326s | 0.0841s | **1.2x** | **2.6x** |
| expand | -t 2 10MB tabbed | 0.0365s | 0.0329s | 0.0818s | **1.1x** | **2.5x** |
| expand | --initial 10MB tabbed | 0.0262s | 0.0321s | 0.0779s | **0.8x** | **2.4x** |
| expand | expand CSV 10MB | 0.0182s | 0.0014s | 0.0030s | **12.9x** | **2.1x** |
| expr | expr 1 + 1 | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| expr | expr 999999 * 999999 | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| expr | expr length 'hello world' | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| expr | expr 'hello' : 'hel' | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| factor | factor 1234567890 | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| factor | factor 999999999999999989 (large prime) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| factor | factor 1-100000 via stdin | N/A | - | N/A | - | N/A |
| false | false (startup overhead) | 0.0000s | 0.0005s | N/A | - | N/A |
| fold | fold 10MB wide lines (default) | 0.0276s | 0.0197s | 0.0116s | **1.4x** | **0.6x** |
| fold | fold 1MB text | 0.0035s | 0.0016s | 0.0021s | **2.1x** | **1.3x** |
| fold | fold 10MB text | 0.0289s | 0.0160s | 0.0133s | **1.8x** | **0.8x** |
| fold | -w 40 10MB | 0.0280s | 0.0197s | 0.0130s | **1.4x** | **0.7x** |
| fold | -w 20 10MB | 0.0295s | 0.0194s | 0.0164s | **1.5x** | **0.8x** |
| fold | -s -w 60 10MB | 0.0307s | 0.0364s | 0.0155s | **0.8x** | **0.4x** |
| fold | -s -w 40 10MB | 0.0338s | 0.0385s | 0.0178s | **0.9x** | **0.5x** |
| fold | -b -w 40 10MB | 0.0275s | 0.0061s | 0.0088s | **4.5x** | **1.4x** |
| groups | groups (no args) | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| head | default 1MB text | 0.0006s | 0.0008s | 0.0008s | **0.7x** | **1.0x** |
| head | default 10MB text | 0.0006s | 0.0009s | 0.0008s | **0.7x** | **1.0x** |
| head | default 100MB text | 0.0006s | 0.0009s | 0.0008s | **0.7x** | **0.9x** |
| head | -n 1000 10MB | 0.0006s | 0.0009s | 0.0009s | **0.7x** | **0.9x** |
| head | -n 100000 10MB | 0.0055s | 0.0029s | 0.0027s | **1.9x** | **0.9x** |
| head | -c 1000000 10MB | 0.0007s | 0.0009s | 0.0008s | **0.8x** | **0.9x** |
| head | -n -100 10MB (all but last 100) | 0.0018s | 0.0036s | 0.0010s | **0.5x** | **0.3x** |
| head | 100 small files | 0.0009s | 0.0013s | 0.0013s | **0.7x** | **1.0x** |
| hostid | hostid (no args) | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| id | id (no args) | 0.0008s | 0.0009s | N/A | **0.9x** | N/A |
| id | id -u | 0.0007s | 0.0008s | N/A | **0.9x** | N/A |
| id | id -g | 0.0007s | 0.0009s | N/A | **0.7x** | N/A |
| id | id -un | 0.0008s | 0.0009s | N/A | **0.9x** | N/A |
| install | install 1MB file | 0.0018s | 0.0018s | N/A | **1.0x** | N/A |
| install | install -d create directory | 0.0015s | 0.0016s | N/A | **0.9x** | N/A |
| join | default join 10MB | N/A | - | N/A | - | N/A |
| join | outer join 10MB | N/A | - | N/A | - | N/A |
| join | -v 1 (unmatched from file1) 10MB | N/A | - | N/A | - | N/A |
| join | -o 0,1.2,2.2 10MB | N/A | - | N/A | - | N/A |
| join | self-join sorted 10MB | 0.0491s | 0.0642s | 0.0467s | **0.8x** | **0.7x** |
| link | hard link a file | 0.0011s | 0.0014s | N/A | **0.8x** | N/A |
| ln | symlink single file | 0.0011s | 0.0014s | N/A | **0.8x** | N/A |
| ln | symlink force overwrite (-sf) | 0.0011s | 0.0014s | N/A | **0.8x** | N/A |
| ln | hard link single file | 0.0011s | 0.0014s | N/A | **0.8x** | N/A |
| logname | logname (no args) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| md5sum | single 100KB text | 0.0010s | 0.0025s | 0.0011s | **0.4x** | **0.4x** |
| md5sum | single 1MB text | 0.0024s | 0.0037s | 0.0028s | **0.6x** | **0.8x** |
| md5sum | single 10MB text | 0.0158s | 0.0190s | 0.0201s | **0.8x** | **1.1x** |
| md5sum | single 10MB binary | 0.0164s | 0.0192s | 0.0214s | **0.9x** | **1.1x** |
| md5sum | single 100MB text | 0.1512s | 0.1464s | 0.1933s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0009s | 0.0022s | 0.0009s | **0.4x** | **0.4x** |
| md5sum | 100 files | 0.0013s | 0.0028s | 0.0014s | **0.5x** | **0.5x** |
| mkdir | mkdir single directory | 0.0013s | 0.0014s | N/A | **0.9x** | N/A |
| mkdir | mkdir -p nested directories | 0.0014s | 0.0015s | N/A | **0.9x** | N/A |
| mkfifo | mkfifo single fifo | 0.0013s | 0.0014s | N/A | **0.9x** | N/A |
| mknod | mknod named pipe | 0.0013s | 0.0014s | N/A | **0.9x** | N/A |
| mktemp | mktemp default | N/A | 0.0016s | N/A | - | N/A |
| mktemp | mktemp -d directory | N/A | 0.0016s | N/A | - | N/A |
| mv | mv 1MB file | 0.0026s | 0.0027s | N/A | **1.0x** | N/A |
| mv | mv 10MB file | 0.0066s | 0.0067s | N/A | **1.0x** | N/A |
| nice | nice true (default priority) | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| nice | nice -n 10 true | 0.0009s | 0.0012s | N/A | **0.8x** | N/A |
| nl | default 1MB | 0.0044s | 0.0018s | 0.0021s | **2.4x** | **1.1x** |
| nl | default 10MB | 0.0328s | 0.0074s | 0.0099s | **4.4x** | **1.3x** |
| nl | -b a 10MB | 0.0327s | 0.0064s | 0.0100s | **5.1x** | **1.6x** |
| nl | -b a 10MB with blanks | 0.0422s | 0.0102s | 0.0142s | **4.1x** | **1.4x** |
| nl | -b a -n rz 10MB | 0.0326s | 0.0070s | 0.0098s | **4.7x** | **1.4x** |
| nl | -b a -w 8 -s ': ' 10MB | 0.0328s | 0.0065s | 0.0102s | **5.0x** | **1.6x** |
| nl | -b p'^the' 10MB | 0.0580s | 0.0126s | 0.0139s | **4.6x** | **1.1x** |
| nohup | nohup true | 0.0014s | 0.0017s | N/A | **0.9x** | N/A |
| nproc | nproc (no args) | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| nproc | nproc --all | 0.0006s | 0.0009s | N/A | **0.7x** | N/A |
| paste | 2 columns 10MB | 0.0174s | 0.0111s | 0.1088s | **1.6x** | **9.8x** |
| paste | 3 columns 10MB | 0.0227s | 0.0162s | 0.1203s | **1.4x** | **7.4x** |
| paste | -d comma 10MB | 0.0174s | 0.0110s | 0.1091s | **1.6x** | **9.9x** |
| paste | -s 10MB single file | 0.0087s | 0.0051s | 0.0127s | **1.7x** | **2.5x** |
| paste | stdin split 2-way 10MB | 0.0316s | 0.0230s | 0.0253s | **1.4x** | **1.1x** |
| pathchk | pathchk default | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| pathchk | pathchk -p (POSIX portable) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| pwd | pwd (no args) | 0.0000s | 0.0008s | N/A | - | N/A |
| pwd | pwd -L | 0.0000s | 0.0008s | N/A | - | N/A |
| pwd | pwd -P | 0.0000s | 0.0008s | N/A | - | N/A |
| readlink | readlink symlink | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| readlink | readlink -f (canonicalize) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| realpath | realpath . | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| realpath | realpath /tmp | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| realpath | realpath test data file | 0.0006s | 0.0009s | N/A | **0.6x** | N/A |
| rev | reverse 100KB text | 0.0018s | 0.0010s | N/A | **1.9x** | N/A |
| rev | reverse 1MB text | 0.0121s | 0.0018s | N/A | **6.6x** | N/A |
| rev | reverse 10MB text | 0.1116s | 0.0077s | N/A | **14.6x** | N/A |
| rev | reverse 100MB text | 1.1124s | 0.0758s | N/A | **14.7x** | N/A |
| rev | reverse CSV 10MB | 0.0845s | 0.0073s | N/A | **11.5x** | N/A |
| rev | reverse repetitive 10MB | 0.2413s | 0.0119s | N/A | **20.3x** | N/A |
| rev | reverse 10KB single line | 0.0007s | 0.0008s | N/A | **0.9x** | N/A |
| rm | rm single file | 0.0014s | 0.0017s | N/A | **0.8x** | N/A |
| rm | rm -rf directory | 0.0037s | 0.0046s | N/A | **0.8x** | N/A |
| rmdir | rmdir single empty directory | 0.0013s | 0.0016s | N/A | **0.8x** | N/A |
| rmdir | rmdir -p nested directories | N/A | - | N/A | - | N/A |
| seq | seq 1000000 | 0.0068s | 0.0078s | N/A | **0.9x** | N/A |
| seq | seq 1 10000000 | 0.0625s | 0.0676s | N/A | **0.9x** | N/A |
| seq | seq 0 0.1 100000 (float) | 0.2185s | 0.1714s | N/A | **1.3x** | N/A |
| seq | seq -w 1 1000000 (zero-padded) | 0.2283s | 0.0106s | N/A | **21.5x** | N/A |
| sha1sum | single 1MB text | 0.0016s | 0.0038s | N/A | **0.4x** | N/A |
| sha1sum | single 10MB text | 0.0076s | 0.0107s | N/A | **0.7x** | N/A |
| sha1sum | single 10MB binary | 0.0079s | 0.0106s | N/A | **0.7x** | N/A |
| sha1sum | 100 files | 0.0014s | 0.0024s | N/A | **0.6x** | N/A |
| sha224sum | single 1MB text | 0.0018s | 0.0041s | N/A | **0.4x** | N/A |
| sha224sum | single 10MB text | 0.0093s | 0.0116s | N/A | **0.8x** | N/A |
| sha224sum | single 10MB binary | 0.0098s | 0.0135s | N/A | **0.7x** | N/A |
| sha256sum | single 100KB text | 0.0010s | 0.0032s | 0.0010s | **0.3x** | **0.3x** |
| sha256sum | single 1MB text | 0.0017s | 0.0039s | 0.0017s | **0.4x** | **0.4x** |
| sha256sum | single 10MB text | 0.0093s | 0.0117s | 0.0092s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0099s | 0.0124s | 0.0096s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0890s | 0.0929s | 0.0885s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0009s | 0.0021s | 0.0009s | **0.4x** | **0.4x** |
| sha256sum | 100 files | 0.0014s | 0.0024s | 0.0013s | **0.6x** | **0.6x** |
| sha384sum | single 1MB text | 0.0025s | 0.0050s | N/A | **0.5x** | N/A |
| sha384sum | single 10MB text | 0.0174s | 0.0207s | N/A | **0.8x** | N/A |
| sha384sum | single 10MB binary | 0.0187s | 0.0206s | N/A | **0.9x** | N/A |
| sha512sum | single 1MB text | 0.0025s | 0.0055s | N/A | **0.5x** | N/A |
| sha512sum | single 10MB text | 0.0172s | 0.0202s | N/A | **0.8x** | N/A |
| sha512sum | single 10MB binary | 0.0184s | 0.0213s | N/A | **0.9x** | N/A |
| shred | shred 1MB file | 0.0078s | 0.0044s | N/A | **1.8x** | N/A |
| shred | shred 1MB file with remove (-u) | 0.0131s | 0.0055s | N/A | **2.4x** | N/A |
| sleep | sleep 0 (startup overhead) | 0.0006s | 0.0008s | N/A | **0.8x** | N/A |
| sleep | sleep 0.001 (tiny sleep) | 0.0017s | 0.0021s | N/A | **0.8x** | N/A |
| sort | lexicographic 1MB | 0.0074s | 0.0037s | 0.0042s | **2.0x** | **1.1x** |
| sort | lexicographic 10MB random | 0.0511s | 0.0105s | 0.0288s | **4.9x** | **2.8x** |
| sort | already sorted 10MB | 0.0233s | 0.0056s | 0.0118s | **4.1x** | **2.1x** |
| sort | reverse sorted 10MB | 0.0244s | 0.0063s | 0.0126s | **3.9x** | **2.0x** |
| sort | -n numeric 10MB | 0.0717s | 0.0067s | 0.0641s | **10.6x** | **9.5x** |
| sort | -r reverse 10MB | 0.0522s | 0.0108s | 0.0293s | **4.8x** | **2.7x** |
| sort | -u unique 10MB | 0.0554s | 0.0111s | 0.0354s | **5.0x** | **3.2x** |
| sort | -t, -k2 CSV 10MB | 0.0657s | 0.1551s | 0.0754s | **0.4x** | **0.5x** |
| sort | repetitive 10MB | 0.0515s | 0.0147s | 0.0270s | **3.5x** | **1.8x** |
| sort | --parallel=4 10MB | 0.0509s | 0.0103s | 0.0299s | **5.0x** | **2.9x** |
| split | split 10MB into 1MB chunks (-b 1m) | N/A | - | N/A | - | N/A |
| split | split 10MB by 1000 lines (-l 1000) | 0.0100s | 0.0111s | N/A | **0.9x** | N/A |
| sum | single 1MB text | 0.0023s | 0.0020s | N/A | **1.2x** | N/A |
| sum | single 10MB text | 0.0173s | 0.0139s | N/A | **1.2x** | N/A |
| sum | single 10MB binary | 0.0187s | 0.0143s | N/A | **1.3x** | N/A |
| sync | sync (no args) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| tac | reverse 100KB text | 0.0007s | 0.0013s | 0.0009s | **0.5x** | **0.6x** |
| tac | reverse 1MB text | 0.0014s | 0.0017s | 0.0013s | **0.8x** | **0.7x** |
| tac | reverse 10MB text | 0.0079s | 0.0054s | 0.0044s | **1.5x** | **0.8x** |
| tac | reverse 100MB text | 0.0803s | 0.0290s | 0.0421s | **2.8x** | **1.5x** |
| tac | reverse CSV 10MB | 0.0073s | 0.0049s | 0.0043s | **1.5x** | **0.9x** |
| tac | reverse repetitive 10MB | 0.0151s | 0.0112s | 0.0081s | **1.4x** | **0.7x** |
| tac | custom separator 1MB | 0.0047s | 0.0039s | 0.0037s | **1.2x** | **0.9x** |
| tail | default 1MB text | 0.0006s | 0.0010s | 0.0010s | **0.6x** | **1.0x** |
| tail | default 10MB text | 0.0006s | 0.0009s | 0.0010s | **0.6x** | **1.1x** |
| tail | default 100MB text | 0.0006s | 0.0009s | 0.0009s | **0.6x** | **1.0x** |
| tail | -n 1000 10MB | 0.0006s | 0.0009s | 0.0010s | **0.6x** | **1.0x** |
| tail | -n 100000 10MB | 0.0035s | 0.0027s | 0.0034s | **1.3x** | **1.2x** |
| tail | -n +100 10MB (from line 100) | 0.0018s | 0.0021s | 0.0012s | **0.9x** | **0.6x** |
| tail | -n +100000 10MB (from line 100000) | 0.0028s | 0.0036s | 0.0028s | **0.8x** | **0.8x** |
| tail | -c 1000000 10MB | 0.0007s | 0.0009s | 0.0009s | **0.8x** | **1.0x** |
| tail | 100 small files | 0.0010s | 0.0016s | 0.0018s | **0.6x** | **1.1x** |
| tee | tee 1MB to /dev/null | N/A | - | N/A | - | N/A |
| tee | tee 10MB to /dev/null | N/A | - | N/A | - | N/A |
| test | test -f (file exists) | 0.0000s | 0.0008s | N/A | - | N/A |
| test | test 1 -eq 1 | 0.0000s | 0.0008s | N/A | - | N/A |
| test | test 'hello' = 'hello' | 0.0000s | 0.0008s | N/A | - | N/A |
| test | test -d /tmp | 0.0000s | 0.0009s | N/A | - | N/A |
| touch | create new file | 0.0011s | 0.0014s | N/A | **0.8x** | N/A |
| touch | update existing file timestamp | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| touch | set specific timestamp (-t) | 0.0012s | 0.0014s | N/A | **0.8x** | N/A |
| tr | a-z to A-Z 1MB | 0.0015s | 0.0014s | 0.0015s | **1.0x** | **1.1x** |
| tr | a-z to A-Z 10MB | 0.0080s | 0.0039s | 0.0062s | **2.1x** | **1.6x** |
| tr | -d digits 10MB | 0.0152s | 0.0040s | 0.0130s | **3.8x** | **3.3x** |
| tr | -d lowercase 10MB | 0.0278s | 0.0048s | 0.0228s | **5.8x** | **4.8x** |
| tr | -s spaces 10MB | 0.0249s | 0.0038s | 0.0269s | **6.5x** | **7.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0075s | 0.0040s | 0.0065s | **1.9x** | **1.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0155s | 0.0041s | 0.0134s | **3.8x** | **3.3x** |
| tr | translate binary 10MB | 0.0078s | 0.0039s | 0.0070s | **2.0x** | **1.8x** |
| true | true (startup overhead) | 0.0000s | 0.0005s | N/A | - | N/A |
| truncate | truncate to zero (-s 0) | 0.0019s | 0.0021s | N/A | **0.9x** | N/A |
| truncate | create 1M file (-s 1M) | 0.0011s | 0.0014s | N/A | **0.8x** | N/A |
| tsort | tsort 100K pairs | N/A | - | N/A | - | N/A |
| tsort | tsort 1M pairs | N/A | - | N/A | - | N/A |
| tty | tty (no args) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| uname | uname (no args) | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| uname | uname -a | 0.0005s | 0.0008s | N/A | **0.7x** | N/A |
| uname | uname -r | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| uname | uname -m | 0.0006s | 0.0008s | N/A | **0.7x** | N/A |
| unexpand | unexpand 1MB text | 0.0030s | 0.0013s | 0.0019s | **2.3x** | **1.5x** |
| unexpand | unexpand 10MB text | 0.0241s | 0.0043s | 0.0114s | **5.6x** | **2.7x** |
| unexpand | -a 1MB text | 0.0074s | 0.0056s | 0.0107s | **1.3x** | **1.9x** |
| unexpand | -a 10MB text | 0.0699s | 0.0396s | 0.1029s | **1.8x** | **2.6x** |
| unexpand | -t 4 10MB text | 0.0702s | 0.0430s | 0.1029s | **1.6x** | **2.4x** |
| unexpand | expand|unexpand pipeline 10MB | 0.0915s | 0.1046s | 0.1444s | **0.9x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0086s | 0.0014s | 0.0094s | **6.1x** | **6.6x** |
| uniq | default 10MB sorted (low dup) | 0.0182s | 0.0029s | 0.0124s | **6.3x** | **4.3x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0014s | 0.0093s | **6.4x** | **6.5x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0064s | 0.0136s | **4.6x** | **2.1x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0014s | 0.0095s | **6.5x** | **6.7x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0015s | 0.0094s | **6.1x** | **6.2x** |
| uniq | -i case insensitive 10MB | 0.0184s | 0.0046s | 0.0127s | **4.0x** | **2.8x** |
| uniq | repetitive 10MB | 0.0491s | 0.0030s | 0.0134s | **16.1x** | **4.4x** |
| unlink | unlink a file | 0.0014s | 0.0017s | N/A | **0.8x** | N/A |
| wc | default 100KB text | 0.0010s | 0.0010s | 0.0012s | **1.0x** | **1.2x** |
| wc | default 1MB text | 0.0045s | 0.0027s | 0.0037s | **1.6x** | **1.4x** |
| wc | default 10MB text | 0.0425s | 0.0028s | 0.0325s | **15.4x** | **11.8x** |
| wc | default 100MB text | 0.3793s | 0.0111s | 0.2802s | **34.2x** | **25.3x** |
| wc | -l 10MB text | 0.0014s | 0.0021s | 0.0016s | **0.7x** | **0.7x** |
| wc | -w 10MB text | 0.0426s | 0.0080s | 0.0289s | **5.3x** | **3.6x** |
| wc | -c 10MB text | 0.0006s | 0.0009s | 0.0009s | **0.7x** | **1.0x** |
| wc | -m 10MB text | 0.0428s | 0.0025s | 0.0016s | **17.2x** | **0.6x** |
| wc | -L 10MB text | 0.0426s | 0.0103s | 0.0165s | **4.1x** | **1.6x** |
| wc | default 10MB binary | 0.3206s | 0.0280s | 0.1578s | **11.4x** | **5.6x** |
| wc | default 10MB repetitive | 0.0558s | 0.0037s | 0.0360s | **14.9x** | **9.6x** |
| wc | 10 files | 0.0006s | 0.0011s | 0.0010s | **0.6x** | **0.9x** |
| wc | 100 files | 0.0010s | 0.0014s | 0.0014s | **0.7x** | **1.0x** |
| whoami | whoami (no args) | 0.0007s | 0.0009s | N/A | **0.7x** | N/A |
| yes | startup --help | 0.0006s | 0.0002s | N/A | **3.7x** | N/A |
| yes | startup --version | 0.0006s | 0.0001s | N/A | **4.1x** | N/A |
| yes | throughput 1M lines | 0.0024s | 0.0025s | N/A | **1.0x** | N/A |
| yes | throughput 10M lines | 0.0179s | 0.0164s | N/A | **1.1x** | N/A |
| yes | throughput hello 1M lines | 0.0058s | 0.0058s | N/A | **1.0x** | N/A |
| yes | throughput hello 10M lines | 0.0525s | 0.0544s | N/A | **1.0x** | N/A |
| yes | throughput 100MB | 0.0261s | 0.0305s | N/A | **0.9x** | N/A |
