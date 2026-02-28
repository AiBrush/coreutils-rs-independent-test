# fcoreutils v0.14.8 — Detailed Results

Generated: 2026-02-28 21:16:28 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|------:|-------:|-------:|----------:|
| Darwin_arm64 | 0 | 0 | 0 | N/A |
| Linux_aarch64 | 444 | 358 | 83 | 80.6% |
| Linux_x86_64 | 3323 | 3221 | 25 | 96.9% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

## Per-Tool Compatibility (Linux x86_64)

| Tool | Total | Passed | Failed | Rate |
|------|------:|-------:|-------:|-----:|
| arch | 6 | 6 | 0 | 100% |
| b2sum | 25 | 25 | 0 | 100% |
| base32 | 29 | 29 | 0 | 100% |
| base64 | 33 | 33 | 0 | 100% |
| basename | 26 | 26 | 0 | 100% |
| basenc | 96 | 87 | 9 | 91% |
| cat | 49 | 48 | 1 | 98% |
| chgrp | 19 | 17 | 2 | 89% |
| chown | 20 | 17 | 3 | 85% |
| chroot | 14 | 3 | 11 | 21% |
| cksum | 48 | 48 | 0 | 100% |
| comm | 30 | 30 | 0 | 100% |
| cut | 99 | 96 | 3 | 97% |
| date | 46 | 46 | 0 | 100% |
| dd | 29 | 29 | 0 | 100% |
| df | 25 | 17 | 8 | 68% |
| dir | 1 | 0 | 1 | 0% |
| dircolors | 14 | 14 | 0 | 100% |
| dirname | 23 | 23 | 0 | 100% |
| du | 51 | 51 | 0 | 100% |
| echo | 53 | 53 | 0 | 100% |
| env | 51 | 49 | 2 | 96% |
| expand | 35 | 35 | 0 | 100% |
| expr | 43 | 43 | 0 | 100% |
| factor | 59 | 55 | 4 | 93% |
| false | 6 | 6 | 0 | 100% |
| fmt | 22 | 22 | 0 | 100% |
| fold | 58 | 54 | 4 | 93% |
| groups | 8 | 8 | 0 | 100% |
| head | 63 | 60 | 3 | 95% |
| hostid | 6 | 6 | 0 | 100% |
| id | 27 | 27 | 0 | 100% |
| install | 32 | 27 | 5 | 84% |
| join | 37 | 37 | 0 | 100% |
| kill | 20 | 20 | 0 | 100% |
| link | 8 | 8 | 0 | 100% |
| ln | 33 | 33 | 0 | 100% |
| logname | 3 | 3 | 0 | 100% |
| ls | 65 | 65 | 0 | 100% |
| md5sum | 30 | 30 | 0 | 100% |
| mkdir | 44 | 37 | 7 | 84% |
| mkfifo | 11 | 11 | 0 | 100% |
| mknod | 12 | 12 | 0 | 100% |
| mktemp | 17 | 15 | 2 | 88% |
| nice | 34 | 32 | 2 | 94% |
| nl | 62 | 60 | 2 | 97% |
| nohup | 11 | 11 | 0 | 100% |
| nproc | 31 | 29 | 2 | 94% |
| numfmt | 33 | 31 | 2 | 94% |
| od | 50 | 50 | 0 | 100% |
| paste | 32 | 30 | 2 | 94% |
| pathchk | 22 | 22 | 0 | 100% |
| pinky | 7 | 7 | 0 | 100% |
| pr | 19 | 18 | 1 | 95% |
| printenv | 9 | 9 | 0 | 100% |
| printf | 74 | 74 | 0 | 100% |
| ptx | 15 | 15 | 0 | 100% |
| pwd | 17 | 16 | 1 | 94% |
| readlink | 60 | 60 | 0 | 100% |
| realpath | 43 | 43 | 0 | 100% |
| rev | 32 | 32 | 0 | 100% |
| rm | 23 | 23 | 0 | 100% |
| rmdir | 21 | 21 | 0 | 100% |
| runcon | 5 | 2 | 3 | 40% |
| seq | 62 | 62 | 0 | 100% |
| sha1sum | 15 | 15 | 0 | 100% |
| sha224sum | 10 | 10 | 0 | 100% |
| sha256sum | 34 | 34 | 0 | 100% |
| sha384sum | 10 | 10 | 0 | 100% |
| sha512sum | 10 | 10 | 0 | 100% |
| shred | 27 | 27 | 0 | 100% |
| shuf | 53 | 52 | 1 | 98% |
| sleep | 15 | 15 | 0 | 100% |
| sort | 111 | 111 | 0 | 100% |
| split | 72 | 72 | 0 | 100% |
| stat | 38 | 37 | 1 | 97% |
| stdbuf | 13 | 13 | 0 | 100% |
| stty | 15 | 12 | 3 | 80% |
| sum | 23 | 23 | 0 | 100% |
| sync | 10 | 9 | 1 | 90% |
| tac | 59 | 59 | 0 | 100% |
| tail | 80 | 79 | 1 | 99% |
| tee | 27 | 27 | 0 | 100% |
| test | 116 | 116 | 0 | 100% |
| timeout | 36 | 36 | 0 | 100% |
| touch | 48 | 45 | 3 | 94% |
| tr | 59 | 59 | 0 | 100% |
| true | 7 | 7 | 0 | 100% |
| truncate | 49 | 46 | 3 | 94% |
| tsort | 19 | 19 | 0 | 100% |
| tty | 10 | 10 | 0 | 100% |
| uname | 14 | 14 | 0 | 100% |
| unexpand | 27 | 26 | 1 | 96% |
| uniq | 86 | 85 | 1 | 99% |
| unlink | 7 | 7 | 0 | 100% |
| uptime | 5 | 5 | 0 | 100% |
| users | 6 | 6 | 0 | 100% |
| vdir | 1 | 0 | 1 | 0% |
| wc | 77 | 76 | 1 | 99% |
| who | 13 | 13 | 0 | 100% |
| whoami | 4 | 4 | 0 | 100% |
| yes | 29 | 24 | 5 | 83% |

## Performance (Linux x86_64)

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|----------:|-----------------:|--------:|
| arch | arch (no args) | 0.0008s | 0.0010s | **0.9x** |
| base32 | encode 100KB text | 0.0010s | 0.0012s | **0.9x** |
| base32 | encode 1MB text | 0.0023s | 0.0021s | **1.1x** |
| base32 | encode 10MB text | 0.0149s | 0.0114s | **1.3x** |
| base32 | encode 10MB binary | 0.0158s | 0.0121s | **1.3x** |
| base32 | decode 1MB | 0.0036s | 0.0027s | **1.3x** |
| base32 | decode 10MB | 0.0278s | 0.0169s | **1.6x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0020s | 0.0015s | **1.3x** |
| base64 | encode 10MB text | 0.0124s | 0.0053s | **2.3x** |
| base64 | encode 10MB binary | 0.0130s | 0.0055s | **2.4x** |
| base64 | decode 1MB | 0.0039s | 0.0022s | **1.8x** |
| base64 | decode 10MB | 0.0336s | 0.0048s | **7.0x** |
| base64 | encode -w 76 10MB | 0.0125s | 0.0053s | **2.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0087s | 0.0044s | **2.0x** |
| basename | basename simple path | 0.0008s | 0.0009s | **0.9x** |
| basename | basename with suffix (.txt) | 0.0008s | 0.0009s | **0.9x** |
| basenc | encode --base64 1MB | 0.0020s | 0.0013s | **1.5x** |
| basenc | encode --base64 10MB | 0.0123s | 0.0052s | **2.4x** |
| basenc | encode --base32 1MB | 0.0022s | 0.0022s | **1.0x** |
| basenc | encode --base16 1MB | 0.0024s | 0.0026s | **0.9x** |
| basenc | decode --base64 -d 1MB | 0.0040s | 0.0034s | **1.2x** |
| chgrp | chgrp current group on file | 0.0022s | 0.0023s | **1.0x** |
| chgrp | chgrp current group on 1MB file | 0.0030s | 0.0032s | **1.0x** |
| chmod | chmod 644 on file | 0.0022s | 0.0023s | **1.0x** |
| chmod | chmod u+x on file | 0.0021s | 0.0023s | **0.9x** |
| chown | chown current user on file | 0.0022s | 0.0023s | **1.0x** |
| chown | chown current user on 1MB file | 0.0030s | 0.0031s | **1.0x** |
| cksum | single 1MB text | 0.0014s | 0.0016s | **0.8x** |
| cksum | single 10MB text | 0.0027s | 0.0031s | **0.9x** |
| cksum | single 10MB binary | 0.0029s | 0.0031s | **0.9x** |
| cp | cp 1MB file | 0.0028s | 0.0027s | **1.0x** |
| cp | cp 10MB file | 0.0099s | 0.0100s | **1.0x** |
| cp | cp -r directory (many_files) | 0.0073s | 0.0064s | **1.1x** |
| csplit | csplit 1MB by pattern | 0.4497s | 0.0251s | **17.9x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0039s | **5.8x** |
| cut | -c1-100 10MB CSV | 0.0225s | 0.0039s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0164s | 0.0094s | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0218s | 0.0114s | **1.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0104s | **2.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0108s | **2.8x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0012s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.7x** |
| dd | dd read 10MB (bs=4096) | 0.0047s | 0.0047s | **1.0x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0106s | 0.0135s | **0.8x** |
| dirname | dirname simple path | 0.0008s | 0.0009s | **0.9x** |
| dirname | dirname deep path | 0.0008s | 0.0009s | **0.9x** |
| echo | echo hello | 0.0008s | 0.0010s | **0.8x** |
| echo | echo -n hello | 0.0008s | 0.0009s | **0.9x** |
| echo | echo -e with escapes | 0.0008s | 0.0010s | **0.9x** |
| env | print all env vars | 0.0008s | 0.0011s | **0.8x** |
| env | env true (run command) | 0.0013s | 0.0014s | **0.9x** |
| env | env VAR=value true | 0.0013s | 0.0014s | **0.9x** |
| expr | expr 1 + 1 | 0.0009s | 0.0010s | **0.9x** |
| expr | expr 999999 * 999999 | 0.0009s | 0.0011s | **0.9x** |
| expr | expr length 'hello world' | 0.0009s | 0.0011s | **0.8x** |
| expr | expr 'hello' : 'hel' | 0.0009s | 0.0011s | **0.8x** |
| factor | factor 1234567890 | 0.0009s | 0.0010s | **0.9x** |
| factor | factor 999999999999999989 (large prime) | 0.0009s | 0.0009s | **1.0x** |
| factor | factor 1-100000 via stdin | 0.0167s | 0.0100s | **1.7x** |
| false | false (startup overhead) | 0.0000s | 0.0007s | **0.0x** |
| groups | groups (no args) | 0.0009s | 0.0011s | **0.9x** |
| hostid | hostid (no args) | 0.0010s | 0.0011s | **0.9x** |
| id | id (no args) | 0.0012s | 0.0011s | **1.1x** |
| id | id -u | 0.0010s | 0.0010s | **1.1x** |
| id | id -g | 0.0010s | 0.0009s | **1.1x** |
| id | id -un | 0.0011s | 0.0010s | **1.1x** |
| install | install 1MB file | 0.0029s | 0.0027s | **1.1x** |
| install | install -d create directory | 0.0023s | 0.0021s | **1.1x** |
| link | hard link a file | 0.0017s | 0.0018s | **0.9x** |
| ln | symlink single file | 0.0017s | 0.0019s | **0.9x** |
| ln | symlink force overwrite (-sf) | 0.0017s | 0.0019s | **0.9x** |
| ln | hard link single file | 0.0017s | 0.0018s | **0.9x** |
| logname | logname (no args) | 0.0009s | 0.0010s | **0.9x** |
| mkdir | mkdir single directory | 0.0019s | 0.0019s | **1.0x** |
| mkdir | mkdir -p nested directories | 0.0022s | 0.0022s | **1.0x** |
| mkfifo | mkfifo single fifo | 0.0019s | 0.0018s | **1.0x** |
| mknod | mknod named pipe | 0.0018s | 0.0018s | **1.0x** |
| mktemp | mktemp default | - | 0.0020s | - |
| mktemp | mktemp -d directory | - | 0.0020s | - |
| mv | mv 1MB file | 0.0039s | 0.0038s | **1.0x** |
| mv | mv 10MB file | 0.0117s | 0.0118s | **1.0x** |
| nice | nice true (default priority) | 0.0013s | 0.0014s | **0.9x** |
| nice | nice -n 10 true | 0.0013s | 0.0014s | **0.9x** |
| nohup | nohup true | 0.0021s | 0.0023s | **0.9x** |
| nproc | nproc (no args) | 0.0008s | 0.0010s | **0.8x** |
| nproc | nproc --all | 0.0008s | 0.0010s | **0.9x** |
| pathchk | pathchk default | 0.0008s | 0.0010s | **0.8x** |
| pathchk | pathchk -p (POSIX portable) | 0.0008s | 0.0009s | **0.9x** |
| pwd | pwd (no args) | 0.0000s | 0.0010s | **0.0x** |
| pwd | pwd -L | 0.0000s | 0.0009s | **0.0x** |
| pwd | pwd -P | 0.0000s | 0.0009s | **0.0x** |
| readlink | readlink symlink | 0.0008s | 0.0009s | **0.9x** |
| readlink | readlink -f (canonicalize) | 0.0008s | 0.0010s | **0.9x** |
| realpath | realpath . | 0.0008s | 0.0010s | **0.8x** |
| realpath | realpath /tmp | 0.0009s | 0.0010s | **0.9x** |
| realpath | realpath test data file | 0.0008s | 0.0010s | **0.9x** |
| rev | reverse 100KB text | 0.0022s | 0.0010s | **2.1x** |
| rev | reverse 1MB text | 0.0144s | 0.0018s | **8.2x** |
| rev | reverse 10MB text | 0.1336s | 0.0075s | **17.8x** |
| rev | reverse 100MB text | 1.3284s | 0.0700s | **19.0x** |
| rev | reverse CSV 10MB | 0.1001s | 0.0071s | **14.1x** |
| rev | reverse repetitive 10MB | 0.2868s | 0.0123s | **23.3x** |
| rev | reverse 10KB single line | 0.0010s | 0.0010s | **1.1x** |
| rm | rm single file | 0.0021s | 0.0023s | **0.9x** |
| rm | rm -rf directory | 0.0072s | 0.0076s | **1.0x** |
| rmdir | rmdir single empty directory | 0.0019s | 0.0020s | **0.9x** |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0104s | 0.0024s | **4.3x** |
| seq | seq 1 10000000 | 0.0960s | 0.0135s | **7.1x** |
| seq | seq 0 0.1 100000 (float) | 0.2307s | 0.0189s | **12.2x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2440s | 0.0156s | **15.6x** |
| sha1sum | single 1MB text | 0.0019s | 0.0034s | **0.6x** |
| sha1sum | single 10MB text | 0.0083s | 0.0100s | **0.8x** |
| sha1sum | single 10MB binary | 0.0086s | 0.0110s | **0.8x** |
| sha1sum | 100 files | 0.0024s | 0.0033s | **0.7x** |
| sha224sum | single 1MB text | 0.0020s | 0.0033s | **0.6x** |
| sha224sum | single 10MB text | 0.0085s | 0.0105s | **0.8x** |
| sha224sum | single 10MB binary | 0.0089s | 0.0107s | **0.8x** |
| sha384sum | single 1MB text | 0.0027s | 0.0040s | **0.7x** |
| sha384sum | single 10MB text | 0.0154s | 0.0171s | **0.9x** |
| sha384sum | single 10MB binary | 0.0162s | 0.0184s | **0.9x** |
| sha512sum | single 1MB text | 0.0027s | 0.0040s | **0.7x** |
| sha512sum | single 10MB text | 0.0154s | 0.0171s | **0.9x** |
| sha512sum | single 10MB binary | 0.0165s | 0.0181s | **0.9x** |
| shred | shred 1MB file | 0.0134s | 0.0068s | **2.0x** |
| shred | shred 1MB file with remove (-u) | 0.0230s | 0.0080s | **2.9x** |
| sleep | sleep 0 (startup overhead) | 0.0009s | 0.0009s | **1.0x** |
| sleep | sleep 0.001 (tiny sleep) | 0.0019s | 0.0020s | **0.9x** |
| sort | lexicographic 1MB | 0.0087s | 0.0038s | **2.3x** |
| sort | lexicographic 10MB random | 0.0558s | 0.0110s | **5.1x** |
| sort | already sorted 10MB | 0.0266s | 0.0051s | **5.2x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0065s | **4.2x** |
| sort | -n numeric 10MB | 0.0747s | 0.0060s | **12.4x** |
| sort | -r reverse 10MB | 0.0553s | 0.0094s | **5.9x** |
| sort | -u unique 10MB | 0.0603s | 0.0111s | **5.4x** |
| sort | -t, -k2 CSV 10MB | 0.0670s | 0.0413s | **1.6x** |
| sort | repetitive 10MB | 0.0552s | 0.0129s | **4.3x** |
| sort | --parallel=4 10MB | 0.0547s | 0.0097s | **5.7x** |
| split | split 10MB into 1MB chunks (-b 1m) | - | - | - |
| split | split 10MB by 1000 lines (-l 1000) | 0.0167s | 0.0183s | **0.9x** |
| sum | single 1MB text | 0.0025s | 0.0023s | **1.1x** |
| sum | single 10MB text | 0.0174s | 0.0145s | **1.2x** |
| sum | single 10MB binary | 0.0183s | 0.0153s | **1.2x** |
| sync | sync (no args) | 0.0009s | 0.0011s | **0.8x** |
| tee | tee 1MB to /dev/null | 0.0017s | 0.0017s | **1.0x** |
| tee | tee 10MB to /dev/null | 0.0069s | 0.0051s | **1.4x** |
| test | test -f (file exists) | 0.0000s | 0.0009s | **0.0x** |
| test | test 1 -eq 1 | 0.0000s | 0.0009s | **0.0x** |
| test | test 'hello' = 'hello' | 0.0000s | 0.0009s | **0.0x** |
| test | test -d /tmp | 0.0000s | 0.0009s | **0.0x** |
| touch | create new file | 0.0017s | 0.0018s | **0.9x** |
| touch | update existing file timestamp | 0.0009s | 0.0009s | **0.9x** |
| touch | set specific timestamp (-t) | 0.0017s | 0.0018s | **0.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | **1.5x** |
| tr | a-z to A-Z 10MB | 0.0124s | 0.0039s | **3.2x** |
| tr | -d digits 10MB | 0.0164s | 0.0043s | **3.8x** |
| tr | -d lowercase 10MB | 0.0293s | 0.0051s | **5.8x** |
| tr | -s spaces 10MB | 0.0267s | 0.0039s | **6.8x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0125s | 0.0038s | **3.2x** |
| tr | -d [:digit:] 10MB CSV | 0.0186s | 0.0044s | **4.3x** |
| tr | translate binary 10MB | 0.0117s | 0.0040s | **3.0x** |
| true | true (startup overhead) | 0.0000s | 0.0007s | **0.0x** |
| truncate | truncate to zero (-s 0) | 0.0031s | 0.0031s | **1.0x** |
| truncate | create 1M file (-s 1M) | 0.0017s | 0.0018s | **0.9x** |
| tsort | tsort 100K pairs | 0.0571s | 0.0079s | **7.2x** |
| tsort | tsort 1M pairs | 0.6499s | 0.0636s | **10.2x** |
| tty | tty (no args) | 0.0008s | 0.0010s | **0.9x** |
| uname | uname (no args) | 0.0008s | 0.0009s | **0.9x** |
| uname | uname -a | 0.0008s | 0.0009s | **0.9x** |
| uname | uname -r | 0.0008s | 0.0010s | **0.9x** |
| uname | uname -m | 0.0008s | 0.0009s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0019s | **6.2x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0031s | **4.5x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0019s | **6.3x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0077s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0120s | 0.0019s | **6.3x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0019s | **6.2x** |
| uniq | -i case insensitive 10MB | 0.0141s | 0.0046s | **3.0x** |
| uniq | repetitive 10MB | 0.0424s | 0.0037s | **11.4x** |
| unlink | unlink a file | 0.0021s | 0.0023s | **0.9x** |
| whoami | whoami (no args) | 0.0009s | 0.0011s | **0.9x** |
| yes | startup --help | 0.0009s | 0.0002s | **4.2x** |
| yes | startup --version | 0.0008s | 0.0002s | **4.1x** |
| yes | throughput 1M lines | 0.0031s | 0.0031s | **1.0x** |
| yes | throughput 10M lines | 0.0214s | 0.0257s | **0.8x** |
| yes | throughput hello 1M lines | 0.0065s | 0.0066s | **1.0x** |
| yes | throughput hello 10M lines | 0.0633s | 0.0527s | **1.2x** |
| yes | throughput 100MB | 0.0464s | 0.0461s | **1.0x** |
