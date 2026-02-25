# fcoreutils v0.9.2 — Detailed Results

Generated: 2026-02-25 17:21:44 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 329 | 225 | 104 | 68.4% |
| Linux_aarch64 | 440 | 417 | 23 | 94.8% |
| Linux_x86_64 | 440 | 417 | 23 | 94.8% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

**Overall: 1059/1209 (87.6%)**

## Performance

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |
|------|------|-----------|-------------------|---------------|----------:|-------------:|
| arch | arch (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.2x** |
| b2sum | single 1MB text | 0.0022s | 0.0021s | 0.0022s | **1.1x** | **1.1x** |
| b2sum | single 10MB text | 0.0154s | 0.0138s | 0.0130s | **1.1x** | **0.9x** |
| b2sum | single 10MB binary | 0.0162s | 0.0139s | 0.0132s | **1.2x** | **0.9x** |
| b2sum | single 100MB text | 0.1415s | 0.1123s | 0.1117s | **1.3x** | **1.0x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0134s | 0.0126s | **1.1x** | **0.9x** |
| b2sum | -l 128 10MB | 0.0154s | 0.0132s | 0.0126s | **1.2x** | **1.0x** |
| b2sum | 100 files | 0.0019s | 0.0022s | 0.0021s | **0.9x** | **0.9x** |
| base32 | encode 100KB text | 0.0010s | 0.0011s | N/A | **0.9x** | N/A |
| base32 | encode 1MB text | 0.0021s | 0.0022s | N/A | **0.9x** | N/A |
| base32 | encode 10MB text | 0.0135s | 0.0138s | N/A | **1.0x** | N/A |
| base32 | encode 10MB binary | 0.0143s | 0.0142s | N/A | **1.0x** | N/A |
| base32 | decode 1MB | 0.0034s | 0.0028s | N/A | **1.2x** | N/A |
| base32 | decode 10MB | 0.0276s | 0.0190s | N/A | **1.5x** | N/A |
| base64 | encode 100KB text | 0.0008s | 0.0016s | 0.0014s | **0.5x** | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0015s | 0.0016s | **1.2x** | **1.1x** |
| base64 | encode 10MB text | 0.0117s | 0.0063s | 0.0070s | **1.9x** | **1.1x** |
| base64 | encode 10MB binary | 0.0124s | 0.0065s | 0.0072s | **1.9x** | **1.1x** |
| base64 | decode 1MB | 0.0037s | 0.0025s | 0.0040s | **1.5x** | **1.6x** |
| base64 | decode 10MB | 0.0312s | 0.0058s | 0.0316s | **5.4x** | **5.5x** |
| base64 | encode -w 76 10MB | 0.0117s | 0.0063s | 0.0070s | **1.9x** | **1.1x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0082s | 0.0048s | 0.0060s | **1.7x** | **1.3x** |
| basename | basename simple path | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| basename | basename with suffix (.txt) | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| basenc | encode --base64 1MB | 0.0019s | 0.0020s | N/A | **0.9x** | N/A |
| basenc | encode --base64 10MB | 0.0114s | 0.0112s | N/A | **1.0x** | N/A |
| basenc | encode --base32 1MB | 0.0021s | 0.0021s | N/A | **1.0x** | N/A |
| basenc | encode --base16 1MB | 0.0022s | 0.0025s | N/A | **0.9x** | N/A |
| basenc | decode --base64 -d 1MB | 0.0038s | 0.0038s | N/A | **1.0x** | N/A |
| cat | passthrough 1MB | 0.0009s | 0.0010s | 0.0011s | **0.9x** | **1.0x** |
| cat | passthrough 10MB | 0.0015s | 0.0013s | 0.0014s | **1.2x** | **1.1x** |
| cat | passthrough 100MB | 0.0090s | 0.0035s | 0.0047s | **2.5x** | **1.3x** |
| cat | -n 1MB | 0.0020s | 0.0020s | 0.0018s | **1.0x** | **0.9x** |
| cat | -n 10MB | 0.0106s | 0.0071s | 0.0073s | **1.5x** | **1.0x** |
| cat | -b 10MB | 0.0105s | 0.0068s | 0.0073s | **1.5x** | **1.1x** |
| cat | -A 1MB | 0.0018s | 0.0020s | 0.0032s | **0.9x** | **1.6x** |
| cat | 100 small files | 0.0025s | 0.0019s | 0.0026s | **1.3x** | **1.4x** |
| cat | binary 10MB | 0.0016s | 0.0013s | 0.0015s | **1.2x** | **1.1x** |
| chgrp | chgrp current group on file | 0.0022s | 0.0024s | N/A | **0.9x** | N/A |
| chgrp | chgrp current group on 1MB file | 0.0029s | 0.0031s | N/A | **0.9x** | N/A |
| chmod | chmod 644 on file | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| chmod | chmod u+x on file | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| chown | chown current user on file | 0.0021s | 0.0023s | N/A | **0.9x** | N/A |
| chown | chown current user on 1MB file | 0.0030s | 0.0036s | N/A | **0.8x** | N/A |
| cksum | single 1MB text | 0.0014s | 0.0012s | N/A | **1.2x** | N/A |
| cksum | single 10MB text | 0.0029s | 0.0029s | N/A | **1.0x** | N/A |
| cksum | single 10MB binary | 0.0029s | 0.0028s | N/A | **1.0x** | N/A |
| comm | default 10MB sorted | 0.0231s | 0.0076s | 0.0200s | **3.0x** | **2.6x** |
| comm | -12 (common only) 10MB | 0.0201s | 0.0067s | 0.0197s | **3.0x** | **3.0x** |
| comm | -23 (unique to file1) 10MB | 0.0204s | 0.0062s | 0.0192s | **3.3x** | **3.1x** |
| comm | -3 10MB | 0.0220s | 0.0073s | 0.0205s | **3.0x** | **2.8x** |
| comm | identical 10MB sorted | 0.0284s | 0.0128s | 0.0191s | **2.2x** | **1.5x** |
| cp | cp 1MB file | 0.0027s | 0.0028s | N/A | **0.9x** | N/A |
| cp | cp 10MB file | 0.0099s | 0.0123s | N/A | **0.8x** | N/A |
| cp | cp -r directory (many_files) | 0.0070s | 0.0113s | N/A | **0.6x** | N/A |
| csplit | csplit 1MB by pattern | 0.4418s | 0.0262s | N/A | **16.9x** | N/A |
| cut | -b1-100 10MB CSV | 0.0220s | 0.0040s | 0.0066s | **5.5x** | **1.6x** |
| cut | -c1-100 10MB CSV | 0.0217s | 0.0041s | 0.0065s | **5.3x** | **1.6x** |
| cut | -d, -f1 10MB CSV | 0.0163s | 0.0097s | 0.0081s | **1.7x** | **0.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0212s | 0.0121s | 0.0178s | **1.7x** | **1.5x** |
| cut | -d, -f2-4 10MB CSV | 0.0238s | 0.0107s | 0.0133s | **2.2x** | **1.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0297s | 0.0111s | 0.0160s | **2.7x** | **1.4x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0013s | 0.0011s | **0.6x** | **0.8x** |
| cut | -d, -f1 1MB text | 0.0032s | 0.0029s | 0.0019s | **1.1x** | **0.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | 0.0011s | **0.6x** | **0.9x** |
| dd | dd read 10MB (bs=4096) | 0.0037s | 0.0040s | N/A | **0.9x** | N/A |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0112s | 0.0128s | N/A | **0.9x** | N/A |
| dirname | dirname simple path | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| dirname | dirname deep path | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| echo | echo hello | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| echo | echo -n hello | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| echo | echo -e with escapes | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| env | print all env vars | 0.0008s | 0.0011s | N/A | **0.7x** | N/A |
| env | env true (run command) | 0.0012s | 0.0013s | N/A | **0.9x** | N/A |
| env | env VAR=value true | 0.0012s | 0.0014s | N/A | **0.9x** | N/A |
| expand | expand 10MB tabbed (default) | 0.0427s | 0.0398s | 0.0935s | **1.1x** | **2.4x** |
| expand | expand 1MB text | 0.0031s | 0.0011s | 0.0014s | **2.7x** | **1.2x** |
| expand | -t 4 10MB tabbed | 0.0402s | 0.0405s | 0.0940s | **1.0x** | **2.3x** |
| expand | -t 2 10MB tabbed | 0.0345s | 0.0401s | 0.0932s | **0.9x** | **2.3x** |
| expand | --initial 10MB tabbed | 0.0222s | 0.0316s | 0.0862s | **0.7x** | **2.7x** |
| expand | expand CSV 10MB | 0.0185s | 0.0019s | 0.0040s | **9.7x** | **2.1x** |
| expr | expr 1 + 1 | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| expr | expr 999999 * 999999 | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| expr | expr length 'hello world' | 0.0008s | 0.0011s | N/A | **0.8x** | N/A |
| expr | expr 'hello' : 'hel' | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| factor | factor 1234567890 | 0.0008s | 0.0010s | N/A | **0.9x** | N/A |
| factor | factor 999999999999999989 (large prime) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| factor | factor 1-100000 via stdin | N/A | - | N/A | - | N/A |
| false | false (startup overhead) | 0.0000s | 0.0007s | N/A | - | N/A |
| fold | fold 10MB wide lines (default) | 0.0328s | 0.0219s | 0.0167s | **1.5x** | **0.8x** |
| fold | fold 1MB text | 0.0040s | 0.0018s | 0.0029s | **2.2x** | **1.6x** |
| fold | fold 10MB text | 0.0338s | 0.0168s | 0.0191s | **2.0x** | **1.1x** |
| fold | -w 40 10MB | 0.0332s | 0.0228s | 0.0189s | **1.5x** | **0.8x** |
| fold | -w 20 10MB | 0.0362s | 0.0220s | 0.0226s | **1.6x** | **1.0x** |
| fold | -s -w 60 10MB | 0.0377s | 0.0338s | 0.0203s | **1.1x** | **0.6x** |
| fold | -s -w 40 10MB | 0.0399s | 0.0359s | 0.0233s | **1.1x** | **0.6x** |
| fold | -b -w 40 10MB | 0.0318s | 0.0070s | 0.0096s | **4.5x** | **1.4x** |
| groups | groups (no args) | 0.0009s | 0.0011s | N/A | **0.8x** | N/A |
| head | default 1MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| head | default 10MB text | 0.0008s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| head | default 100MB text | 0.0008s | 0.0011s | 0.0011s | **0.7x** | **1.0x** |
| head | -n 1000 10MB | 0.0009s | 0.0010s | 0.0011s | **0.8x** | **1.1x** |
| head | -n 100000 10MB | 0.0063s | 0.0040s | 0.0036s | **1.6x** | **0.9x** |
| head | -c 1000000 10MB | 0.0010s | 0.0010s | 0.0011s | **0.9x** | **1.1x** |
| head | -n -100 10MB (all but last 100) | 0.0029s | 0.0044s | 0.0013s | **0.7x** | **0.3x** |
| head | 100 small files | 0.0014s | 0.0017s | 0.0019s | **0.8x** | **1.2x** |
| hostid | hostid (no args) | 0.0009s | 0.0011s | N/A | **0.9x** | N/A |
| id | id (no args) | 0.0011s | 0.0011s | N/A | **1.0x** | N/A |
| id | id -u | 0.0007s | 0.0007s | N/A | **1.0x** | N/A |
| id | id -g | 0.0009s | 0.0010s | N/A | **1.0x** | N/A |
| id | id -un | 0.0010s | 0.0010s | N/A | **1.0x** | N/A |
| install | install 1MB file | 0.0029s | 0.0029s | N/A | **1.0x** | N/A |
| install | install -d create directory | 0.0021s | 0.0020s | N/A | **1.0x** | N/A |
| join | default join 10MB | N/A | - | N/A | - | N/A |
| join | outer join 10MB | N/A | - | N/A | - | N/A |
| join | -v 1 (unmatched from file1) 10MB | N/A | - | N/A | - | N/A |
| join | -o 0,1.2,2.2 10MB | N/A | - | N/A | - | N/A |
| join | self-join sorted 10MB | 0.0451s | 0.0650s | 0.0499s | **0.7x** | **0.8x** |
| link | hard link a file | 0.0016s | 0.0017s | N/A | **0.9x** | N/A |
| ln | symlink single file | 0.0016s | 0.0017s | N/A | **0.9x** | N/A |
| ln | symlink force overwrite (-sf) | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| ln | hard link single file | 0.0015s | 0.0018s | N/A | **0.9x** | N/A |
| logname | logname (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| md5sum | single 100KB text | 0.0013s | 0.0022s | 0.0013s | **0.6x** | **0.6x** |
| md5sum | single 1MB text | 0.0027s | 0.0036s | 0.0032s | **0.8x** | **0.9x** |
| md5sum | single 10MB text | 0.0178s | 0.0190s | 0.0221s | **0.9x** | **1.2x** |
| md5sum | single 10MB binary | 0.0184s | 0.0197s | 0.0230s | **0.9x** | **1.2x** |
| md5sum | single 100MB text | 0.1609s | 0.1535s | 0.2019s | **1.0x** | **1.3x** |
| md5sum | 10 files | 0.0013s | 0.0026s | 0.0013s | **0.5x** | **0.5x** |
| md5sum | 100 files | 0.0020s | 0.0035s | 0.0021s | **0.6x** | **0.6x** |
| mkdir | mkdir single directory | 0.0018s | 0.0018s | N/A | **1.0x** | N/A |
| mkdir | mkdir -p nested directories | 0.0021s | 0.0022s | N/A | **1.0x** | N/A |
| mkfifo | mkfifo single fifo | 0.0017s | 0.0018s | N/A | **1.0x** | N/A |
| mknod | mknod named pipe | 0.0017s | 0.0018s | N/A | **1.0x** | N/A |
| mktemp | mktemp default | N/A | 0.0020s | N/A | - | N/A |
| mktemp | mktemp -d directory | N/A | 0.0020s | N/A | - | N/A |
| mv | mv 1MB file | 0.0038s | 0.0037s | N/A | **1.0x** | N/A |
| mv | mv 10MB file | 0.0117s | 0.0117s | N/A | **1.0x** | N/A |
| nice | nice true (default priority) | 0.0011s | 0.0013s | N/A | **0.8x** | N/A |
| nice | nice -n 10 true | 0.0012s | 0.0014s | N/A | **0.9x** | N/A |
| nl | default 1MB | 0.0047s | 0.0021s | 0.0026s | **2.3x** | **1.2x** |
| nl | default 10MB | 0.0346s | 0.0078s | 0.0116s | **4.4x** | **1.5x** |
| nl | -b a 10MB | 0.0346s | 0.0078s | 0.0117s | **4.4x** | **1.5x** |
| nl | -b a 10MB with blanks | 0.0445s | 0.0106s | 0.0168s | **4.2x** | **1.6x** |
| nl | -b a -n rz 10MB | 0.0344s | 0.0080s | 0.0118s | **4.3x** | **1.5x** |
| nl | -b a -w 8 -s ': ' 10MB | 0.0347s | 0.0084s | 0.0123s | **4.1x** | **1.5x** |
| nl | -b p'^the' 10MB | 0.0586s | 0.0135s | 0.0166s | **4.3x** | **1.2x** |
| nohup | nohup true | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| nproc | nproc (no args) | 0.0008s | 0.0011s | N/A | **0.8x** | N/A |
| nproc | nproc --all | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| paste | 2 columns 10MB | 0.0231s | 0.0132s | 0.1839s | **1.8x** | **13.9x** |
| paste | 3 columns 10MB | 0.0295s | 0.0194s | 0.1964s | **1.5x** | **10.1x** |
| paste | -d comma 10MB | 0.0230s | 0.0133s | 0.1836s | **1.7x** | **13.8x** |
| paste | -s 10MB single file | 0.0100s | 0.0060s | 0.0139s | **1.7x** | **2.3x** |
| paste | stdin split 2-way 10MB | 0.0304s | 0.0207s | 0.0367s | **1.5x** | **1.8x** |
| pathchk | pathchk default | 0.0007s | 0.0010s | N/A | **0.8x** | N/A |
| pathchk | pathchk -p (POSIX portable) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| pwd | pwd (no args) | 0.0000s | 0.0009s | N/A | - | N/A |
| pwd | pwd -L | 0.0000s | 0.0010s | N/A | - | N/A |
| pwd | pwd -P | 0.0000s | 0.0009s | N/A | - | N/A |
| readlink | readlink symlink | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| readlink | readlink -f (canonicalize) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| realpath | realpath . | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| realpath | realpath /tmp | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| realpath | realpath test data file | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| rev | reverse 100KB text | 0.0022s | 0.0011s | N/A | **2.0x** | N/A |
| rev | reverse 1MB text | 0.0143s | 0.0019s | N/A | **7.4x** | N/A |
| rev | reverse 10MB text | 0.1414s | 0.0082s | N/A | **17.2x** | N/A |
| rev | reverse 100MB text | 1.3163s | 0.0763s | N/A | **17.3x** | N/A |
| rev | reverse CSV 10MB | 0.0994s | 0.0078s | N/A | **12.8x** | N/A |
| rev | reverse repetitive 10MB | 0.2845s | 0.0132s | N/A | **21.6x** | N/A |
| rev | reverse 10KB single line | 0.0010s | 0.0010s | N/A | **1.0x** | N/A |
| rm | rm single file | 0.0020s | 0.0021s | N/A | **0.9x** | N/A |
| rm | rm -rf directory | 0.0069s | 0.0077s | N/A | **0.9x** | N/A |
| rmdir | rmdir single empty directory | 0.0018s | 0.0020s | N/A | **0.9x** | N/A |
| rmdir | rmdir -p nested directories | N/A | - | N/A | - | N/A |
| seq | seq 1000000 | 0.0097s | 0.0098s | N/A | **1.0x** | N/A |
| seq | seq 1 10000000 | 0.0898s | 0.0866s | N/A | **1.0x** | N/A |
| seq | seq 0 0.1 100000 (float) | 0.2278s | 0.1675s | N/A | **1.4x** | N/A |
| seq | seq -w 1 1000000 (zero-padded) | 0.2424s | 0.0145s | N/A | **16.7x** | N/A |
| sha1sum | single 1MB text | 0.0018s | 0.0034s | N/A | **0.5x** | N/A |
| sha1sum | single 10MB text | 0.0080s | 0.0099s | N/A | **0.8x** | N/A |
| sha1sum | single 10MB binary | 0.0085s | 0.0104s | N/A | **0.8x** | N/A |
| sha1sum | 100 files | 0.0021s | 0.0028s | N/A | **0.7x** | N/A |
| sha224sum | single 1MB text | 0.0019s | 0.0037s | N/A | **0.5x** | N/A |
| sha224sum | single 10MB text | 0.0087s | 0.0107s | N/A | **0.8x** | N/A |
| sha224sum | single 10MB binary | 0.0092s | 0.0107s | N/A | **0.9x** | N/A |
| sha256sum | single 100KB text | 0.0013s | 0.0031s | 0.0013s | **0.4x** | **0.4x** |
| sha256sum | single 1MB text | 0.0019s | 0.0035s | 0.0019s | **0.5x** | **0.5x** |
| sha256sum | single 10MB text | 0.0088s | 0.0105s | 0.0086s | **0.8x** | **0.8x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0112s | 0.0088s | **0.8x** | **0.8x** |
| sha256sum | single 100MB text | 0.0740s | 0.0744s | 0.0740s | **1.0x** | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0024s | 0.0012s | **0.5x** | **0.5x** |
| sha256sum | 100 files | 0.0022s | 0.0029s | 0.0021s | **0.7x** | **0.7x** |
| sha384sum | single 1MB text | 0.0026s | 0.0042s | N/A | **0.6x** | N/A |
| sha384sum | single 10MB text | 0.0160s | 0.0179s | N/A | **0.9x** | N/A |
| sha384sum | single 10MB binary | 0.0166s | 0.0186s | N/A | **0.9x** | N/A |
| sha512sum | single 1MB text | 0.0026s | 0.0045s | N/A | **0.6x** | N/A |
| sha512sum | single 10MB text | 0.0161s | 0.0184s | N/A | **0.9x** | N/A |
| sha512sum | single 10MB binary | 0.0167s | 0.0190s | N/A | **0.9x** | N/A |
| shred | shred 1MB file | 0.0097s | 0.0068s | N/A | **1.4x** | N/A |
| shred | shred 1MB file with remove (-u) | 0.0159s | 0.0079s | N/A | **2.0x** | N/A |
| sleep | sleep 0 (startup overhead) | 0.0008s | 0.0010s | N/A | **0.9x** | N/A |
| sleep | sleep 0.001 (tiny sleep) | 0.0018s | 0.0020s | N/A | **0.9x** | N/A |
| sort | lexicographic 1MB | 0.0088s | 0.0041s | 0.0054s | **2.1x** | **1.3x** |
| sort | lexicographic 10MB random | 0.0573s | 0.0125s | 0.0358s | **4.6x** | **2.9x** |
| sort | already sorted 10MB | 0.0271s | 0.0058s | 0.0156s | **4.7x** | **2.7x** |
| sort | reverse sorted 10MB | 0.0283s | 0.0072s | 0.0159s | **3.9x** | **2.2x** |
| sort | -n numeric 10MB | 0.0752s | 0.0064s | 0.0849s | **11.7x** | **13.2x** |
| sort | -r reverse 10MB | 0.0576s | 0.0125s | 0.0361s | **4.6x** | **2.9x** |
| sort | -u unique 10MB | 0.0613s | 0.0126s | 0.0397s | **4.9x** | **3.1x** |
| sort | -t, -k2 CSV 10MB | 0.0709s | 0.1504s | 0.0845s | **0.5x** | **0.6x** |
| sort | repetitive 10MB | 0.0560s | 0.0141s | 0.0343s | **4.0x** | **2.4x** |
| sort | --parallel=4 10MB | 0.0555s | 0.0106s | 0.0339s | **5.3x** | **3.2x** |
| split | split 10MB into 1MB chunks (-b 1m) | N/A | - | N/A | - | N/A |
| split | split 10MB by 1000 lines (-l 1000) | 0.0180s | 0.0192s | N/A | **0.9x** | N/A |
| sum | single 1MB text | 0.0025s | 0.0020s | N/A | **1.2x** | N/A |
| sum | single 10MB text | 0.0180s | 0.0128s | N/A | **1.4x** | N/A |
| sum | single 10MB binary | 0.0186s | 0.0136s | N/A | **1.4x** | N/A |
| sync | sync (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| tac | reverse 100KB text | 0.0009s | 0.0014s | 0.0012s | **0.6x** | **0.8x** |
| tac | reverse 1MB text | 0.0017s | 0.0019s | 0.0016s | **0.9x** | **0.9x** |
| tac | reverse 10MB text | 0.0093s | 0.0059s | 0.0054s | **1.6x** | **0.9x** |
| tac | reverse 100MB text | 0.0898s | 0.0286s | 0.0486s | **3.1x** | **1.7x** |
| tac | reverse CSV 10MB | 0.0086s | 0.0057s | 0.0055s | **1.5x** | **1.0x** |
| tac | reverse repetitive 10MB | 0.0205s | 0.0107s | 0.0105s | **1.9x** | **1.0x** |
| tac | custom separator 1MB | 0.0056s | 0.0043s | 0.0052s | **1.3x** | **1.2x** |
| tail | default 1MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.2x** |
| tail | default 10MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.1x** |
| tail | default 100MB text | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.1x** |
| tail | -n 1000 10MB | 0.0008s | 0.0011s | 0.0013s | **0.7x** | **1.2x** |
| tail | -n 100000 10MB | 0.0045s | 0.0032s | 0.0064s | **1.4x** | **2.0x** |
| tail | -n +100 10MB (from line 100) | 0.0030s | 0.0024s | 0.0015s | **1.2x** | **0.6x** |
| tail | -n +100000 10MB (from line 100000) | 0.0037s | 0.0039s | 0.0035s | **1.0x** | **0.9x** |
| tail | -c 1000000 10MB | 0.0010s | 0.0011s | 0.0013s | **0.9x** | **1.1x** |
| tail | 100 small files | 0.0015s | 0.0024s | 0.0029s | **0.6x** | **1.2x** |
| tee | tee 1MB to /dev/null | N/A | - | N/A | - | N/A |
| tee | tee 10MB to /dev/null | N/A | - | N/A | - | N/A |
| test | test -f (file exists) | 0.0000s | 0.0010s | N/A | - | N/A |
| test | test 1 -eq 1 | 0.0000s | 0.0009s | N/A | - | N/A |
| test | test 'hello' = 'hello' | 0.0000s | 0.0010s | N/A | - | N/A |
| test | test -d /tmp | 0.0000s | 0.0010s | N/A | - | N/A |
| touch | create new file | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| touch | update existing file timestamp | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| touch | set specific timestamp (-t) | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| tr | a-z to A-Z 1MB | 0.0021s | 0.0016s | 0.0019s | **1.3x** | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0116s | 0.0043s | 0.0074s | **2.7x** | **1.7x** |
| tr | -d digits 10MB | 0.0168s | 0.0045s | 0.0140s | **3.7x** | **3.1x** |
| tr | -d lowercase 10MB | 0.0314s | 0.0052s | 0.0222s | **6.0x** | **4.3x** |
| tr | -s spaces 10MB | 0.0258s | 0.0040s | 0.0277s | **6.5x** | **7.0x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0040s | 0.0073s | **3.1x** | **1.8x** |
| tr | -d [:digit:] 10MB CSV | 0.0167s | 0.0045s | 0.0140s | **3.7x** | **3.1x** |
| tr | translate binary 10MB | 0.0101s | 0.0044s | 0.0086s | **2.3x** | **1.9x** |
| true | true (startup overhead) | 0.0000s | 0.0007s | N/A | - | N/A |
| truncate | truncate to zero (-s 0) | 0.0029s | 0.0031s | N/A | **0.9x** | N/A |
| truncate | create 1M file (-s 1M) | 0.0016s | 0.0018s | N/A | **0.9x** | N/A |
| tsort | tsort 100K pairs | N/A | - | N/A | - | N/A |
| tsort | tsort 1M pairs | N/A | - | N/A | - | N/A |
| tty | tty (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| uname | uname (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| uname | uname -a | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| uname | uname -r | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| uname | uname -m | 0.0008s | 0.0009s | N/A | **0.8x** | N/A |
| unexpand | unexpand 1MB text | 0.0029s | 0.0015s | 0.0021s | **1.9x** | **1.4x** |
| unexpand | unexpand 10MB text | 0.0212s | 0.0051s | 0.0112s | **4.1x** | **2.2x** |
| unexpand | -a 1MB text | 0.0088s | 0.0058s | 0.0112s | **1.5x** | **1.9x** |
| unexpand | -a 10MB text | 0.0826s | 0.0424s | 0.1058s | **1.9x** | **2.5x** |
| unexpand | -t 4 10MB text | 0.0824s | 0.0444s | 0.1062s | **1.9x** | **2.4x** |
| unexpand | expand|unexpand pipeline 10MB | 0.1119s | 0.1153s | 0.1559s | **1.0x** | **1.4x** |
| uniq | default 10MB many duplicates | 0.0115s | 0.0019s | 0.0110s | **6.2x** | **5.9x** |
| uniq | default 10MB sorted (low dup) | 0.0132s | 0.0032s | 0.0128s | **4.2x** | **4.0x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0019s | 0.0112s | **6.3x** | **6.0x** |
| uniq | -c count 10MB sorted | 0.0282s | 0.0072s | 0.0152s | **3.9x** | **2.1x** |
| uniq | -d duplicates only 10MB | 0.0118s | 0.0019s | 0.0111s | **6.1x** | **5.8x** |
| uniq | -u unique only 10MB | 0.0118s | 0.0019s | 0.0108s | **6.4x** | **5.8x** |
| uniq | -i case insensitive 10MB | 0.0131s | 0.0046s | 0.0128s | **2.9x** | **2.8x** |
| uniq | repetitive 10MB | 0.0408s | 0.0039s | 0.0152s | **10.6x** | **3.9x** |
| unlink | unlink a file | 0.0020s | 0.0022s | N/A | **0.9x** | N/A |
| wc | default 100KB text | 0.0013s | 0.0011s | 0.0014s | **1.2x** | **1.3x** |
| wc | default 1MB text | 0.0057s | 0.0023s | 0.0038s | **2.4x** | **1.6x** |
| wc | default 10MB text | 0.0547s | 0.0033s | 0.0313s | **16.5x** | **9.5x** |
| wc | default 100MB text | 0.4815s | 0.0153s | 0.2616s | **31.5x** | **17.1x** |
| wc | -l 10MB text | 0.0019s | 0.0026s | 0.0021s | **0.7x** | **0.8x** |
| wc | -w 10MB text | 0.0547s | 0.0083s | 0.0258s | **6.6x** | **3.1x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.0012s | **0.8x** | **1.1x** |
| wc | -m 10MB text | 0.0548s | 0.0032s | 0.0019s | **17.2x** | **0.6x** |
| wc | -L 10MB text | 0.0542s | 0.0102s | 0.0170s | **5.3x** | **1.7x** |
| wc | default 10MB binary | 0.3160s | 0.0245s | 0.1554s | **12.9x** | **6.3x** |
| wc | default 10MB repetitive | 0.0735s | 0.0048s | 0.0423s | **15.3x** | **8.8x** |
| wc | 10 files | 0.0009s | 0.0012s | 0.0013s | **0.7x** | **1.0x** |
| wc | 100 files | 0.0016s | 0.0017s | 0.0021s | **0.9x** | **1.2x** |
| whoami | whoami (no args) | 0.0008s | 0.0010s | N/A | **0.8x** | N/A |
| yes | startup --help | 0.0008s | 0.0002s | N/A | **4.1x** | N/A |
| yes | startup --version | 0.0008s | 0.0002s | N/A | **3.3x** | N/A |
| yes | throughput 1M lines | 0.0035s | 0.0029s | N/A | **1.2x** | N/A |
| yes | throughput 10M lines | 0.0246s | 0.0239s | N/A | **1.0x** | N/A |
| yes | throughput hello 1M lines | 0.0057s | 0.0059s | N/A | **1.0x** | N/A |
| yes | throughput hello 10M lines | 0.0554s | 0.0504s | N/A | **1.1x** | N/A |
| yes | throughput 100MB | 0.0237s | 0.0334s | N/A | **0.7x** | N/A |
