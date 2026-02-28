# fcoreutils v0.14.5 — Detailed Results

Generated: 2026-02-28 14:32:02 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|------:|-------:|-------:|----------:|
| Darwin_arm64 | 0 | 0 | 0 | N/A |
| Linux_aarch64 | 444 | 358 | 83 | 80.6% |
| Linux_x86_64 | 3251 | 3101 | 73 | 95.4% |
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
| basenc | 96 | 86 | 10 | 90% |
| cat | 49 | 47 | 2 | 96% |
| chgrp | 19 | 17 | 2 | 89% |
| chown | 20 | 17 | 3 | 85% |
| chroot | 14 | 3 | 11 | 21% |
| cksum | 48 | 48 | 0 | 100% |
| comm | 30 | 30 | 0 | 100% |
| cut | 99 | 94 | 5 | 95% |
| date | 46 | 46 | 0 | 100% |
| dd | 29 | 29 | 0 | 100% |
| df | 25 | 12 | 13 | 48% |
| dir | 1 | 0 | 1 | 0% |
| dircolors | 14 | 14 | 0 | 100% |
| dirname | 23 | 23 | 0 | 100% |
| du | 51 | 50 | 1 | 98% |
| echo | 53 | 53 | 0 | 100% |
| env | 51 | 49 | 2 | 96% |
| expand | 35 | 35 | 0 | 100% |
| expr | 43 | 43 | 0 | 100% |
| factor | 59 | 55 | 4 | 93% |
| false | 6 | 6 | 0 | 100% |
| fmt | 22 | 22 | 0 | 100% |
| fold | 58 | 54 | 4 | 93% |
| groups | 8 | 8 | 0 | 100% |
| head | 63 | 59 | 4 | 94% |
| hostid | 6 | 6 | 0 | 100% |
| id | 27 | 27 | 0 | 100% |
| install | 32 | 26 | 6 | 81% |
| join | 37 | 37 | 0 | 100% |
| kill | 20 | 17 | 3 | 85% |
| link | 8 | 8 | 0 | 100% |
| ln | 33 | 30 | 3 | 91% |
| logname | 3 | 3 | 0 | 100% |
| ls | 65 | 65 | 0 | 100% |
| md5sum | 30 | 30 | 0 | 100% |
| mkdir | 44 | 37 | 7 | 84% |
| mkfifo | 11 | 11 | 0 | 100% |
| mknod | 12 | 12 | 0 | 100% |
| mktemp | 17 | 15 | 2 | 88% |
| nice | 34 | 32 | 2 | 94% |
| nl | 62 | 58 | 4 | 94% |
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
| pwd | 17 | 14 | 3 | 82% |
| readlink | 60 | 58 | 2 | 97% |
| realpath | 43 | 43 | 0 | 100% |
| rev | 32 | 32 | 0 | 100% |
| rm | 23 | 20 | 3 | 87% |
| rmdir | 21 | 17 | 4 | 81% |
| runcon | 5 | 2 | 3 | 40% |
| seq | 62 | 62 | 0 | 100% |
| sha1sum | 15 | 15 | 0 | 100% |
| sha224sum | 10 | 10 | 0 | 100% |
| sha256sum | 34 | 34 | 0 | 100% |
| sha384sum | 10 | 10 | 0 | 100% |
| sha512sum | 10 | 10 | 0 | 100% |
| shred | 27 | 27 | 0 | 100% |
| shuf | 53 | 49 | 4 | 92% |
| sleep | 15 | 15 | 0 | 100% |
| sort | 111 | 106 | 5 | 95% |
| stat | 38 | 37 | 1 | 97% |
| stdbuf | 13 | 13 | 0 | 100% |
| stty | 15 | 12 | 3 | 80% |
| sum | 23 | 23 | 0 | 100% |
| sync | 10 | 9 | 1 | 90% |
| tac | 59 | 59 | 0 | 100% |
| tail | 80 | 79 | 1 | 99% |
| tee | 27 | 27 | 0 | 100% |
| test | 116 | 114 | 2 | 98% |
| timeout | 36 | 36 | 0 | 100% |
| touch | 48 | 42 | 6 | 88% |
| tr | 59 | 53 | 6 | 90% |
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
| yes | 29 | 26 | 3 | 90% |

## Performance (Linux x86_64)

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|----------:|-----------------:|--------:|
| arch | arch (no args) | 0.0009s | 0.0008s | **1.1x** |
| base32 | encode 100KB text | 0.0007s | 0.0010s | **0.8x** |
| base32 | encode 1MB text | 0.0018s | 0.0018s | **1.0x** |
| base32 | encode 10MB text | 0.0119s | 0.0107s | **1.1x** |
| base32 | encode 10MB binary | 0.0127s | 0.0112s | **1.1x** |
| base32 | decode 1MB | 0.0034s | 0.0023s | **1.5x** |
| base32 | decode 10MB | 0.0294s | 0.0177s | **1.7x** |
| base64 | encode 100KB text | 0.0007s | 0.0012s | **0.6x** |
| base64 | encode 1MB text | 0.0015s | 0.0012s | **1.3x** |
| base64 | encode 10MB text | 0.0100s | 0.0053s | **1.9x** |
| base64 | encode 10MB binary | 0.0106s | 0.0056s | **1.9x** |
| base64 | decode 1MB | 0.0035s | 0.0020s | **1.7x** |
| base64 | decode 10MB | 0.0298s | 0.0043s | **7.0x** |
| base64 | encode -w 76 10MB | 0.0102s | 0.0057s | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0078s | 0.0041s | **1.9x** |
| basename | basename simple path | 0.0006s | 0.0007s | **0.8x** |
| basename | basename with suffix (.txt) | 0.0006s | 0.0008s | **0.7x** |
| basenc | encode --base64 1MB | 0.0015s | 0.0012s | **1.3x** |
| basenc | encode --base64 10MB | 0.0099s | 0.0048s | **2.0x** |
| basenc | encode --base32 1MB | 0.0018s | 0.0019s | **0.9x** |
| basenc | encode --base16 1MB | 0.0019s | 0.0021s | **0.9x** |
| basenc | decode --base64 -d 1MB | 0.0036s | 0.0035s | **1.0x** |
| chgrp | chgrp current group on file | 0.0016s | 0.0018s | **0.9x** |
| chgrp | chgrp current group on 1MB file | 0.0020s | 0.0022s | **0.9x** |
| chmod | chmod 644 on file | 0.0015s | 0.0018s | **0.9x** |
| chmod | chmod u+x on file | 0.0015s | 0.0017s | **0.9x** |
| chown | chown current user on file | 0.0017s | 0.0019s | **0.9x** |
| chown | chown current user on 1MB file | 0.0020s | 0.0022s | **0.9x** |
| cksum | single 1MB text | 0.0010s | 0.0015s | **0.7x** |
| cksum | single 10MB text | 0.0019s | 0.0022s | **0.8x** |
| cksum | single 10MB binary | 0.0020s | 0.0023s | **0.9x** |
| cp | cp 1MB file | 0.0019s | 0.0019s | **1.0x** |
| cp | cp 10MB file | 0.0060s | 0.0060s | **1.0x** |
| cp | cp -r directory (many_files) | 0.0037s | 0.0041s | **0.9x** |
| csplit | csplit 1MB by pattern | 0.2074s | 0.0222s | **9.3x** |
| cut | -b1-100 10MB CSV | 0.0193s | 0.0033s | **5.9x** |
| cut | -c1-100 10MB CSV | 0.0194s | 0.0034s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0211s | 0.0095s | **2.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0239s | 0.0109s | **2.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0267s | 0.0102s | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0299s | 0.0112s | **2.7x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0011s | **0.6x** |
| cut | -d, -f1 1MB text | 0.0038s | 0.0028s | **1.4x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0011s | **0.6x** |
| dd | dd read 10MB (bs=4096) | 0.0022s | 0.0023s | **0.9x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0065s | 0.0090s | **0.7x** |
| dirname | dirname simple path | 0.0006s | 0.0008s | **0.8x** |
| dirname | dirname deep path | 0.0006s | 0.0008s | **0.8x** |
| echo | echo hello | 0.0006s | 0.0008s | **0.7x** |
| echo | echo -n hello | 0.0006s | 0.0008s | **0.8x** |
| echo | echo -e with escapes | 0.0006s | 0.0008s | **0.7x** |
| env | print all env vars | 0.0006s | 0.0009s | **0.7x** |
| env | env true (run command) | 0.0009s | 0.0011s | **0.8x** |
| env | env VAR=value true | 0.0010s | 0.0012s | **0.8x** |
| expr | expr 1 + 1 | 0.0007s | 0.0009s | **0.8x** |
| expr | expr 999999 * 999999 | 0.0007s | 0.0009s | **0.8x** |
| expr | expr length 'hello world' | 0.0007s | 0.0009s | **0.8x** |
| expr | expr 'hello' : 'hel' | 0.0007s | 0.0009s | **0.7x** |
| factor | factor 1234567890 | 0.0006s | 0.0008s | **0.8x** |
| factor | factor 999999999999999989 (large prime) | 0.0007s | 0.0008s | **0.8x** |
| factor | factor 1-100000 via stdin | 0.0142s | 0.0102s | **1.4x** |
| false | false (startup overhead) | 0.0000s | 0.0006s | **0.0x** |
| groups | groups (no args) | 0.0007s | 0.0009s | **0.8x** |
| hostid | hostid (no args) | 0.0007s | 0.0008s | **0.8x** |
| id | id (no args) | 0.0008s | 0.0009s | **0.9x** |
| id | id -u | 0.0007s | 0.0008s | **0.9x** |
| id | id -g | 0.0007s | 0.0007s | **0.9x** |
| id | id -un | 0.0008s | 0.0009s | **0.9x** |
| install | install 1MB file | 0.0019s | 0.0019s | **1.0x** |
| install | install -d create directory | 0.0015s | 0.0015s | **1.0x** |
| link | hard link a file | 0.0012s | 0.0014s | **0.8x** |
| ln | symlink single file | 0.0012s | 0.0014s | **0.8x** |
| ln | symlink force overwrite (-sf) | 0.0012s | 0.0014s | **0.9x** |
| ln | hard link single file | 0.0012s | 0.0015s | **0.8x** |
| logname | logname (no args) | 0.0006s | 0.0008s | **0.8x** |
| mkdir | mkdir single directory | 0.0014s | 0.0015s | **0.9x** |
| mkdir | mkdir -p nested directories | 0.0015s | 0.0015s | **1.0x** |
| mkfifo | mkfifo single fifo | 0.0013s | 0.0014s | **0.9x** |
| mknod | mknod named pipe | 0.0013s | 0.0014s | **0.9x** |
| mktemp | mktemp default | - | 0.0015s | - |
| mktemp | mktemp -d directory | - | 0.0016s | - |
| mv | mv 1MB file | 0.0027s | 0.0026s | **1.0x** |
| mv | mv 10MB file | 0.0073s | 0.0071s | **1.0x** |
| nice | nice true (default priority) | 0.0009s | 0.0011s | **0.8x** |
| nice | nice -n 10 true | 0.0009s | 0.0011s | **0.8x** |
| nohup | nohup true | 0.0015s | 0.0017s | **0.9x** |
| nproc | nproc (no args) | 0.0006s | 0.0009s | **0.7x** |
| nproc | nproc --all | 0.0007s | 0.0008s | **0.8x** |
| pathchk | pathchk default | 0.0006s | 0.0008s | **0.8x** |
| pathchk | pathchk -p (POSIX portable) | 0.0006s | 0.0008s | **0.8x** |
| pwd | pwd (no args) | 0.0000s | 0.0008s | **0.0x** |
| pwd | pwd -L | 0.0000s | 0.0008s | **0.0x** |
| pwd | pwd -P | 0.0000s | 0.0008s | **0.0x** |
| readlink | readlink symlink | 0.0006s | 0.0008s | **0.7x** |
| readlink | readlink -f (canonicalize) | 0.0006s | 0.0008s | **0.7x** |
| realpath | realpath . | 0.0006s | 0.0008s | **0.8x** |
| realpath | realpath /tmp | 0.0006s | 0.0008s | **0.7x** |
| realpath | realpath test data file | 0.0006s | 0.0008s | **0.8x** |
| rev | reverse 100KB text | 0.0018s | 0.0009s | **1.9x** |
| rev | reverse 1MB text | 0.0120s | 0.0018s | **6.8x** |
| rev | reverse 10MB text | 0.1113s | 0.0077s | **14.5x** |
| rev | reverse 100MB text | 1.1186s | 0.0735s | **15.2x** |
| rev | reverse CSV 10MB | 0.0851s | 0.0069s | **12.3x** |
| rev | reverse repetitive 10MB | 0.2458s | 0.0104s | **23.7x** |
| rev | reverse 10KB single line | 0.0007s | 0.0008s | **0.9x** |
| rm | rm single file | 0.0015s | 0.0018s | **0.8x** |
| rm | rm -rf directory | 0.0038s | 0.0047s | **0.8x** |
| rmdir | rmdir single empty directory | 0.0013s | 0.0015s | **0.9x** |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0068s | 0.0020s | **3.3x** |
| seq | seq 1 10000000 | 0.0627s | 0.0105s | **6.0x** |
| seq | seq 0 0.1 100000 (float) | 0.2188s | 0.0154s | **14.2x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2286s | 0.0116s | **19.6x** |
| sha1sum | single 1MB text | 0.0018s | 0.0034s | **0.5x** |
| sha1sum | single 10MB text | 0.0075s | 0.0103s | **0.7x** |
| sha1sum | single 10MB binary | 0.0082s | 0.0107s | **0.8x** |
| sha1sum | 100 files | 0.0014s | 0.0026s | **0.6x** |
| sha224sum | single 1MB text | 0.0018s | 0.0031s | **0.6x** |
| sha224sum | single 10MB text | 0.0094s | 0.0121s | **0.8x** |
| sha224sum | single 10MB binary | 0.0103s | 0.0128s | **0.8x** |
| sha384sum | single 1MB text | 0.0026s | 0.0040s | **0.6x** |
| sha384sum | single 10MB text | 0.0178s | 0.0207s | **0.9x** |
| sha384sum | single 10MB binary | 0.0188s | 0.0213s | **0.9x** |
| sha512sum | single 1MB text | 0.0025s | 0.0040s | **0.6x** |
| sha512sum | single 10MB text | 0.0174s | 0.0197s | **0.9x** |
| sha512sum | single 10MB binary | 0.0182s | 0.0215s | **0.8x** |
| shred | shred 1MB file | 0.0069s | 0.0045s | **1.5x** |
| shred | shred 1MB file with remove (-u) | 0.0123s | 0.0054s | **2.3x** |
| sleep | sleep 0 (startup overhead) | 0.0007s | 0.0008s | **0.8x** |
| sleep | sleep 0.001 (tiny sleep) | 0.0018s | 0.0020s | **0.9x** |
| sort | lexicographic 1MB | 0.0072s | 0.0035s | **2.1x** |
| sort | lexicographic 10MB random | 0.0512s | 0.0099s | **5.2x** |
| sort | already sorted 10MB | 0.0221s | 0.0050s | **4.4x** |
| sort | reverse sorted 10MB | 0.0240s | 0.0068s | **3.5x** |
| sort | -n numeric 10MB | 0.0710s | 0.0061s | **11.6x** |
| sort | -r reverse 10MB | 0.0514s | 0.0098s | **5.2x** |
| sort | -u unique 10MB | 0.0550s | 0.0098s | **5.6x** |
| sort | -t, -k2 CSV 10MB | 0.0660s | 0.0361s | **1.8x** |
| sort | repetitive 10MB | 0.0502s | 0.0142s | **3.5x** |
| sort | --parallel=4 10MB | 0.0521s | 0.0102s | **5.1x** |
| split | split 10MB into 1MB chunks (-b 1m) | - | - | - |
| split | split 10MB by 1000 lines (-l 1000) | 0.0101s | 0.0124s | **0.8x** |
| sum | single 1MB text | 0.0024s | 0.0022s | **1.1x** |
| sum | single 10MB text | 0.0177s | 0.0142s | **1.3x** |
| sum | single 10MB binary | 0.0187s | 0.0149s | **1.3x** |
| sync | sync (no args) | 0.0006s | 0.0008s | **0.8x** |
| tee | tee 1MB to /dev/null | 0.0012s | 0.0015s | **0.8x** |
| tee | tee 10MB to /dev/null | 0.0049s | 0.0052s | **1.0x** |
| test | test -f (file exists) | 0.0000s | 0.0008s | **0.0x** |
| test | test 1 -eq 1 | 0.0000s | 0.0008s | **0.0x** |
| test | test 'hello' = 'hello' | 0.0000s | 0.0007s | **0.0x** |
| test | test -d /tmp | 0.0000s | 0.0007s | **0.0x** |
| touch | create new file | 0.0012s | 0.0014s | **0.9x** |
| touch | update existing file timestamp | 0.0006s | 0.0008s | **0.8x** |
| touch | set specific timestamp (-t) | 0.0012s | 0.0015s | **0.8x** |
| tr | a-z to A-Z 1MB | 0.0016s | 0.0014s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0083s | 0.0040s | **2.1x** |
| tr | -d digits 10MB | 0.0160s | 0.0040s | **4.0x** |
| tr | -d lowercase 10MB | 0.0274s | 0.0049s | **5.6x** |
| tr | -s spaces 10MB | 0.0251s | 0.0038s | **6.6x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0078s | 0.0038s | **2.1x** |
| tr | -d [:digit:] 10MB CSV | 0.0163s | 0.0042s | **3.9x** |
| tr | translate binary 10MB | 0.0080s | 0.0038s | **2.1x** |
| true | true (startup overhead) | 0.0000s | 0.0006s | **0.0x** |
| truncate | truncate to zero (-s 0) | 0.0020s | 0.0023s | **0.9x** |
| truncate | create 1M file (-s 1M) | 0.0012s | 0.0014s | **0.9x** |
| tsort | tsort 100K pairs | 0.0559s | 0.0075s | **7.5x** |
| tsort | tsort 1M pairs | 0.6440s | 0.0772s | **8.3x** |
| tty | tty (no args) | 0.0006s | 0.0008s | **0.8x** |
| uname | uname (no args) | 0.0006s | 0.0009s | **0.8x** |
| uname | uname -a | 0.0006s | 0.0008s | **0.8x** |
| uname | uname -r | 0.0006s | 0.0008s | **0.8x** |
| uname | uname -m | 0.0006s | 0.0008s | **0.8x** |
| uniq | default 10MB many duplicates | 0.0089s | 0.0014s | **6.2x** |
| uniq | default 10MB sorted (low dup) | 0.0186s | 0.0028s | **6.6x** |
| uniq | -c count 10MB many dups | 0.0093s | 0.0014s | **6.5x** |
| uniq | -c count 10MB sorted | 0.0297s | 0.0068s | **4.3x** |
| uniq | -d duplicates only 10MB | 0.0091s | 0.0014s | **6.5x** |
| uniq | -u unique only 10MB | 0.0091s | 0.0014s | **6.5x** |
| uniq | -i case insensitive 10MB | 0.0184s | 0.0042s | **4.4x** |
| uniq | repetitive 10MB | 0.0491s | 0.0029s | **16.7x** |
| unlink | unlink a file | 0.0015s | 0.0017s | **0.9x** |
| whoami | whoami (no args) | 0.0006s | 0.0009s | **0.8x** |
| yes | startup --help | 0.0007s | 0.0002s | **3.6x** |
| yes | startup --version | 0.0006s | 0.0002s | **3.9x** |
| yes | throughput 1M lines | 0.0025s | 0.0024s | **1.0x** |
| yes | throughput 10M lines | 0.0173s | 0.0171s | **1.0x** |
| yes | throughput hello 1M lines | 0.0059s | 0.0061s | **1.0x** |
| yes | throughput hello 10M lines | 0.0551s | 0.0540s | **1.0x** |
| yes | throughput 100MB | 0.0278s | 0.0322s | **0.9x** |
