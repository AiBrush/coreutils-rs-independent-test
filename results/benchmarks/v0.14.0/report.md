# fcoreutils v0.14.0 — Detailed Results

Generated: 2026-02-26 11:25:16 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|------:|-------:|-------:|----------:|
| Darwin_arm64 | 0 | 0 | 0 | N/A |
| Linux_aarch64 | 3217 | 2906 | 233 | 90.3% |
| Linux_x86_64 | 3269 | 2955 | 236 | 90.4% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

## Per-Tool Compatibility (Linux x86_64)

| Tool | Total | Passed | Failed | Rate |
|------|------:|-------:|-------:|-----:|
| arch | 6 | 5 | 1 | 83% |
| b2sum | 25 | 25 | 0 | 100% |
| base32 | 29 | 29 | 0 | 100% |
| base64 | 33 | 33 | 0 | 100% |
| basename | 26 | 26 | 0 | 100% |
| basenc | 96 | 85 | 11 | 89% |
| cat | 51 | 49 | 2 | 96% |
| chgrp | 21 | 18 | 3 | 86% |
| chown | 22 | 18 | 4 | 82% |
| chroot | 16 | 5 | 11 | 31% |
| cksum | 48 | 30 | 18 | 62% |
| comm | 30 | 30 | 0 | 100% |
| cut | 99 | 88 | 11 | 89% |
| date | 48 | 47 | 1 | 98% |
| df | 28 | 15 | 13 | 54% |
| dir | 1 | 0 | 1 | 0% |
| dircolors | 14 | 14 | 0 | 100% |
| dirname | 23 | 23 | 0 | 100% |
| du | 52 | 46 | 6 | 88% |
| echo | 53 | 49 | 4 | 92% |
| env | 51 | 38 | 13 | 75% |
| expand | 35 | 35 | 0 | 100% |
| expr | 43 | 43 | 0 | 100% |
| factor | 59 | 52 | 7 | 88% |
| false | 9 | 9 | 0 | 100% |
| fmt | 22 | 19 | 3 | 86% |
| fold | 58 | 54 | 4 | 93% |
| groups | 9 | 8 | 1 | 89% |
| head | 63 | 59 | 4 | 94% |
| hostid | 6 | 6 | 0 | 100% |
| id | 27 | 23 | 4 | 85% |
| install | 34 | 21 | 13 | 62% |
| join | 37 | 37 | 0 | 100% |
| kill | 20 | 17 | 3 | 85% |
| link | 8 | 8 | 0 | 100% |
| ln | 33 | 25 | 8 | 76% |
| logname | 3 | 3 | 0 | 100% |
| ls | 66 | 55 | 11 | 83% |
| md5sum | 30 | 30 | 0 | 100% |
| mkdir | 44 | 36 | 8 | 82% |
| mkfifo | 11 | 11 | 0 | 100% |
| mknod | 12 | 10 | 2 | 83% |
| mktemp | 17 | 15 | 2 | 88% |
| nice | 34 | 31 | 3 | 91% |
| nl | 62 | 58 | 4 | 94% |
| nohup | 11 | 10 | 1 | 91% |
| nproc | 31 | 26 | 5 | 84% |
| numfmt | 33 | 31 | 2 | 94% |
| od | 51 | 43 | 8 | 84% |
| paste | 32 | 30 | 2 | 94% |
| pathchk | 22 | 22 | 0 | 100% |
| pinky | 9 | 9 | 0 | 100% |
| pr | 20 | 19 | 1 | 95% |
| printenv | 9 | 8 | 1 | 89% |
| printf | 74 | 70 | 4 | 95% |
| ptx | 16 | 11 | 5 | 69% |
| pwd | 17 | 12 | 5 | 71% |
| readlink | 60 | 54 | 6 | 90% |
| realpath | 43 | 38 | 5 | 88% |
| rev | 32 | 32 | 0 | 100% |
| rm | 24 | 20 | 4 | 83% |
| rmdir | 21 | 20 | 1 | 95% |
| runcon | 7 | 4 | 3 | 57% |
| seq | 62 | 57 | 5 | 92% |
| sha1sum | 15 | 15 | 0 | 100% |
| sha224sum | 10 | 10 | 0 | 100% |
| sha256sum | 34 | 34 | 0 | 100% |
| sha384sum | 10 | 10 | 0 | 100% |
| sha512sum | 10 | 10 | 0 | 100% |
| shred | 29 | 28 | 1 | 97% |
| shuf | 53 | 42 | 11 | 79% |
| sleep | 15 | 15 | 0 | 100% |
| sort | 113 | 101 | 12 | 89% |
| stat | 39 | 36 | 3 | 92% |
| stdbuf | 15 | 12 | 3 | 80% |
| stty | 17 | 14 | 3 | 82% |
| sum | 23 | 23 | 0 | 100% |
| sync | 10 | 8 | 2 | 80% |
| tac | 59 | 54 | 5 | 92% |
| tail | 80 | 79 | 1 | 99% |
| tee | 27 | 27 | 0 | 100% |
| test | 116 | 110 | 6 | 95% |
| timeout | 36 | 34 | 2 | 94% |
| touch | 48 | 42 | 6 | 88% |
| tr | 59 | 53 | 6 | 90% |
| true | 8 | 8 | 0 | 100% |
| truncate | 49 | 41 | 8 | 84% |
| tsort | 19 | 19 | 0 | 100% |
| tty | 10 | 10 | 0 | 100% |
| uname | 14 | 14 | 0 | 100% |
| unexpand | 27 | 26 | 1 | 96% |
| uniq | 86 | 82 | 4 | 95% |
| unlink | 7 | 7 | 0 | 100% |
| uptime | 5 | 5 | 0 | 100% |
| users | 8 | 8 | 0 | 100% |
| vdir | 1 | 0 | 1 | 0% |
| wc | 79 | 77 | 2 | 97% |
| who | 15 | 15 | 0 | 100% |
| whoami | 4 | 4 | 0 | 100% |
| yes | 31 | 28 | 3 | 90% |

## Performance (Linux x86_64)

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|----------:|-----------------:|--------:|
| arch | arch (no args) | 0.0009s | 0.0010s | **0.9x** |
| base32 | encode 100KB text | 0.0011s | 0.0012s | **0.9x** |
| base32 | encode 1MB text | 0.0026s | 0.0021s | **1.2x** |
| base32 | encode 10MB text | 0.0162s | 0.0117s | **1.4x** |
| base32 | encode 10MB binary | 0.0207s | 0.0130s | **1.6x** |
| base32 | decode 1MB | 0.0036s | 0.0026s | **1.3x** |
| base32 | decode 10MB | 0.0277s | 0.0169s | **1.6x** |
| base64 | encode 100KB text | 0.0011s | 0.0013s | **0.9x** |
| base64 | encode 1MB text | 0.0024s | 0.0016s | **1.5x** |
| base64 | encode 10MB text | 0.0171s | 0.0053s | **3.2x** |
| base64 | encode 10MB binary | 0.0156s | 0.0054s | **2.9x** |
| base64 | decode 1MB | 0.0042s | 0.0022s | **1.9x** |
| base64 | decode 10MB | 0.0327s | 0.0048s | **6.8x** |
| base64 | encode -w 76 10MB | 0.0144s | 0.0051s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0101s | 0.0042s | **2.4x** |
| basename | basename simple path | 0.0009s | 0.0011s | **0.9x** |
| basename | basename with suffix (.txt) | 0.0009s | 0.0011s | **0.8x** |
| basenc | encode --base64 1MB | 0.0023s | 0.0014s | **1.7x** |
| basenc | encode --base64 10MB | 0.0139s | 0.0050s | **2.8x** |
| basenc | encode --base32 1MB | 0.0026s | 0.0023s | **1.1x** |
| basenc | encode --base16 1MB | 0.0027s | 0.0021s | **1.3x** |
| basenc | decode --base64 -d 1MB | 0.0044s | 0.0033s | **1.3x** |
| chgrp | chgrp current group on file | 0.0025s | 0.0026s | **1.0x** |
| chgrp | chgrp current group on 1MB file | 0.0034s | 0.0035s | **1.0x** |
| chmod | chmod 644 on file | 0.0025s | 0.0025s | **1.0x** |
| chmod | chmod u+x on file | 0.0024s | 0.0025s | **1.0x** |
| chown | chown current user on file | 0.0025s | 0.0027s | **0.9x** |
| chown | chown current user on 1MB file | 0.0034s | 0.0035s | **1.0x** |
| cksum | single 1MB text | 0.0017s | 0.0012s | **1.4x** |
| cksum | single 10MB text | 0.0033s | 0.0028s | **1.2x** |
| cksum | single 10MB binary | 0.0034s | 0.0029s | **1.1x** |
| cp | cp 1MB file | 0.0031s | 0.0029s | **1.1x** |
| cp | cp 10MB file | 0.0110s | 0.0107s | **1.0x** |
| cp | cp -r directory (many_files) | 0.0081s | 0.0068s | **1.2x** |
| csplit | csplit 1MB by pattern | 0.4782s | 0.0250s | **19.2x** |
| cut | -b1-100 10MB CSV | 0.0233s | 0.0041s | **5.6x** |
| cut | -c1-100 10MB CSV | 0.0232s | 0.0042s | **5.5x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0097s | **1.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0232s | 0.0112s | **2.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0247s | 0.0109s | **2.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0313s | 0.0112s | **2.8x** |
| cut | -d, -f1 100KB text | 0.0010s | 0.0012s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0038s | 0.0031s | **1.2x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0012s | **0.8x** |
| dd | dd read 10MB (bs=4096) | 0.0061s | 0.0059s | **1.0x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0105s | 0.0118s | **0.9x** |
| dirname | dirname simple path | 0.0009s | 0.0010s | **0.9x** |
| dirname | dirname deep path | 0.0009s | 0.0010s | **0.9x** |
| echo | echo hello | 0.0009s | 0.0010s | **0.9x** |
| echo | echo -n hello | 0.0009s | 0.0010s | **0.9x** |
| echo | echo -e with escapes | 0.0009s | 0.0010s | **0.9x** |
| env | print all env vars | 0.0009s | 0.0011s | **0.8x** |
| env | env true (run command) | 0.0014s | 0.0015s | **1.0x** |
| env | env VAR=value true | 0.0014s | 0.0015s | **0.9x** |
| expr | expr 1 + 1 | 0.0010s | 0.0011s | **0.9x** |
| expr | expr 999999 * 999999 | 0.0010s | 0.0011s | **0.9x** |
| expr | expr length 'hello world' | 0.0010s | 0.0012s | **0.9x** |
| expr | expr 'hello' : 'hel' | 0.0010s | 0.0012s | **0.8x** |
| factor | factor 1234567890 | 0.0010s | 0.0011s | **0.9x** |
| factor | factor 999999999999999989 (large prime) | 0.0010s | 0.0011s | **0.9x** |
| factor | factor 1-100000 via stdin | 0.0176s | 0.0103s | **1.7x** |
| false | false (startup overhead) | 0.0000s | 0.0008s | **0.0x** |
| groups | groups (no args) | 0.0011s | 0.0012s | **0.9x** |
| hostid | hostid (no args) | 0.0011s | 0.0011s | **1.0x** |
| id | id (no args) | 0.0014s | 0.0013s | **1.1x** |
| id | id -u | 0.0011s | 0.0010s | **1.1x** |
| id | id -g | 0.0011s | 0.0010s | **1.1x** |
| id | id -un | 0.0012s | 0.0011s | **1.1x** |
| install | install 1MB file | 0.0031s | 0.0031s | **1.0x** |
| install | install -d create directory | 0.0025s | 0.0022s | **1.1x** |
| link | hard link a file | 0.0019s | 0.0019s | **1.0x** |
| ln | symlink single file | 0.0019s | 0.0020s | **0.9x** |
| ln | symlink force overwrite (-sf) | 0.0018s | 0.0020s | **0.9x** |
| ln | hard link single file | 0.0018s | 0.0019s | **0.9x** |
| logname | logname (no args) | 0.0009s | 0.0010s | **0.9x** |
| mkdir | mkdir single directory | 0.0021s | 0.0020s | **1.0x** |
| mkdir | mkdir -p nested directories | 0.0025s | 0.0024s | **1.0x** |
| mkfifo | mkfifo single fifo | 0.0021s | 0.0019s | **1.1x** |
| mknod | mknod named pipe | 0.0020s | 0.0020s | **1.0x** |
| mktemp | mktemp default | - | 0.0022s | - |
| mktemp | mktemp -d directory | - | 0.0022s | - |
| mv | mv 1MB file | 0.0043s | 0.0042s | **1.0x** |
| mv | mv 10MB file | 0.0116s | 0.0116s | **1.0x** |
| nice | nice true (default priority) | 0.0014s | 0.0015s | **0.9x** |
| nice | nice -n 10 true | 0.0014s | 0.0015s | **0.9x** |
| nohup | nohup true | 0.0023s | 0.0024s | **1.0x** |
| nproc | nproc (no args) | 0.0009s | 0.0011s | **0.8x** |
| nproc | nproc --all | 0.0009s | 0.0010s | **0.9x** |
| pathchk | pathchk default | 0.0009s | 0.0010s | **0.9x** |
| pathchk | pathchk -p (POSIX portable) | 0.0009s | 0.0010s | **0.9x** |
| pwd | pwd (no args) | 0.0000s | 0.0010s | **0.0x** |
| pwd | pwd -L | 0.0000s | 0.0010s | **0.0x** |
| pwd | pwd -P | 0.0000s | 0.0010s | **0.0x** |
| readlink | readlink symlink | 0.0009s | 0.0010s | **0.9x** |
| readlink | readlink -f (canonicalize) | 0.0009s | 0.0011s | **0.9x** |
| realpath | realpath . | 0.0009s | 0.0010s | **0.9x** |
| realpath | realpath /tmp | 0.0009s | 0.0010s | **0.9x** |
| realpath | realpath test data file | 0.0009s | 0.0011s | **0.9x** |
| rev | reverse 100KB text | 0.0024s | 0.0012s | **2.1x** |
| rev | reverse 1MB text | 0.0150s | 0.0019s | **8.0x** |
| rev | reverse 10MB text | 0.1389s | 0.0080s | **17.5x** |
| rev | reverse 100MB text | 1.3772s | 0.0754s | **18.3x** |
| rev | reverse CSV 10MB | 0.1029s | 0.0078s | **13.2x** |
| rev | reverse repetitive 10MB | 0.2939s | 0.0123s | **23.9x** |
| rev | reverse 10KB single line | 0.0011s | 0.0010s | **1.1x** |
| rm | rm single file | 0.0023s | 0.0025s | **1.0x** |
| rm | rm -rf directory | 0.0077s | 0.0078s | **1.0x** |
| rmdir | rmdir single empty directory | 0.0021s | 0.0022s | **0.9x** |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0100s | 0.0025s | **4.0x** |
| seq | seq 1 10000000 | 0.0928s | 0.0129s | **7.2x** |
| seq | seq 0 0.1 100000 (float) | 0.2143s | 0.0197s | **10.9x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2267s | 0.0144s | **15.7x** |
| sha1sum | single 1MB text | 0.0022s | 0.0035s | **0.6x** |
| sha1sum | single 10MB text | 0.0090s | 0.0106s | **0.8x** |
| sha1sum | single 10MB binary | 0.0095s | 0.0113s | **0.8x** |
| sha1sum | 100 files | 0.0028s | 0.0036s | **0.8x** |
| sha224sum | single 1MB text | 0.0022s | 0.0036s | **0.6x** |
| sha224sum | single 10MB text | 0.0095s | 0.0112s | **0.8x** |
| sha224sum | single 10MB binary | 0.0099s | 0.0117s | **0.8x** |
| sha384sum | single 1MB text | 0.0030s | 0.0043s | **0.7x** |
| sha384sum | single 10MB text | 0.0173s | 0.0189s | **0.9x** |
| sha384sum | single 10MB binary | 0.0182s | 0.0202s | **0.9x** |
| sha512sum | single 1MB text | 0.0030s | 0.0044s | **0.7x** |
| sha512sum | single 10MB text | 0.0172s | 0.0187s | **0.9x** |
| sha512sum | single 10MB binary | 0.0182s | 0.0198s | **0.9x** |
| shred | shred 1MB file | 0.0078s | 0.0062s | **1.3x** |
| shred | shred 1MB file with remove (-u) | 0.0130s | 0.0071s | **1.8x** |
| sleep | sleep 0 (startup overhead) | 0.0010s | 0.0010s | **1.0x** |
| sleep | sleep 0.001 (tiny sleep) | 0.0020s | 0.0021s | **0.9x** |
| sort | lexicographic 1MB | 0.0088s | 0.0038s | **2.3x** |
| sort | lexicographic 10MB random | 0.0561s | 0.0092s | **6.1x** |
| sort | already sorted 10MB | 0.0247s | 0.0046s | **5.3x** |
| sort | reverse sorted 10MB | 0.0261s | 0.0062s | **4.2x** |
| sort | -n numeric 10MB | 0.0750s | 0.0054s | **14.0x** |
| sort | -r reverse 10MB | 0.0562s | 0.0091s | **6.2x** |
| sort | -u unique 10MB | 0.0596s | 0.0095s | **6.3x** |
| sort | -t, -k2 CSV 10MB | 0.0702s | 0.0377s | **1.9x** |
| sort | repetitive 10MB | 0.0471s | 0.0122s | **3.8x** |
| sort | --parallel=4 10MB | 0.0560s | 0.0091s | **6.1x** |
| split | split 10MB into 1MB chunks (-b 1m) | - | - | - |
| split | split 10MB by 1000 lines (-l 1000) | 0.0174s | 0.0182s | **1.0x** |
| sum | single 1MB text | 0.0028s | 0.0025s | **1.1x** |
| sum | single 10MB text | 0.0196s | 0.0163s | **1.2x** |
| sum | single 10MB binary | 0.0207s | 0.0170s | **1.2x** |
| sync | sync (no args) | 0.0009s | 0.0010s | **0.9x** |
| tee | tee 1MB to /dev/null | 0.0019s | 0.0017s | **1.1x** |
| tee | tee 10MB to /dev/null | 0.0079s | 0.0053s | **1.5x** |
| test | test -f (file exists) | 0.0000s | 0.0010s | **0.0x** |
| test | test 1 -eq 1 | 0.0000s | 0.0010s | **0.0x** |
| test | test 'hello' = 'hello' | 0.0000s | 0.0010s | **0.0x** |
| test | test -d /tmp | 0.0000s | 0.0010s | **0.0x** |
| touch | create new file | 0.0019s | 0.0020s | **1.0x** |
| touch | update existing file timestamp | 0.0009s | 0.0010s | **0.9x** |
| touch | set specific timestamp (-t) | 0.0019s | 0.0020s | **0.9x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0016s | **1.5x** |
| tr | a-z to A-Z 10MB | 0.0128s | 0.0041s | **3.1x** |
| tr | -d digits 10MB | 0.0195s | 0.0046s | **4.2x** |
| tr | -d lowercase 10MB | 0.0332s | 0.0054s | **6.2x** |
| tr | -s spaces 10MB | 0.0297s | 0.0042s | **7.1x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0039s | **3.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0184s | 0.0047s | **3.9x** |
| tr | translate binary 10MB | 0.0132s | 0.0041s | **3.2x** |
| true | true (startup overhead) | 0.0000s | 0.0008s | **0.0x** |
| truncate | truncate to zero (-s 0) | 0.0033s | 0.0033s | **1.0x** |
| truncate | create 1M file (-s 1M) | 0.0019s | 0.0020s | **0.9x** |
| tsort | tsort 100K pairs | 0.0601s | 0.0071s | **8.5x** |
| tsort | tsort 1M pairs | 0.6915s | 0.0621s | **11.1x** |
| tty | tty (no args) | 0.0009s | 0.0010s | **0.9x** |
| uname | uname (no args) | 0.0009s | 0.0010s | **0.9x** |
| uname | uname -a | 0.0009s | 0.0010s | **0.9x** |
| uname | uname -r | 0.0009s | 0.0010s | **0.9x** |
| uname | uname -m | 0.0009s | 0.0010s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0114s | 0.0021s | **5.5x** |
| uniq | default 10MB sorted (low dup) | 0.0143s | 0.0031s | **4.6x** |
| uniq | -c count 10MB many dups | 0.0115s | 0.0021s | **5.5x** |
| uniq | -c count 10MB sorted | 0.0258s | 0.0085s | **3.0x** |
| uniq | -d duplicates only 10MB | 0.0114s | 0.0020s | **5.6x** |
| uniq | -u unique only 10MB | 0.0115s | 0.0021s | **5.6x** |
| uniq | -i case insensitive 10MB | 0.0142s | 0.0047s | **3.0x** |
| uniq | repetitive 10MB | 0.0307s | 0.0033s | **9.2x** |
| unlink | unlink a file | 0.0023s | 0.0024s | **1.0x** |
| whoami | whoami (no args) | 0.0010s | 0.0011s | **0.9x** |
| yes | startup --help | 0.0009s | 0.0002s | **4.3x** |
| yes | startup --version | 0.0010s | 0.0002s | **4.3x** |
| yes | throughput 1M lines | 0.0037s | 0.0038s | **1.0x** |
| yes | throughput 10M lines | 0.0274s | 0.0320s | **0.9x** |
| yes | throughput hello 1M lines | 0.0077s | 0.0079s | **1.0x** |
| yes | throughput hello 10M lines | 0.0619s | 0.0717s | **0.9x** |
| yes | throughput 100MB | 0.0572s | 0.0570s | **1.0x** |
