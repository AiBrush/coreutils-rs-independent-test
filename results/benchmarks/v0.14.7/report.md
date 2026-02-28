# fcoreutils v0.14.7 — Detailed Results

Generated: 2026-02-28 19:33:32 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|------:|-------:|-------:|----------:|
| Darwin_arm64 | 0 | 0 | 0 | N/A |
| Linux_aarch64 | 444 | 358 | 83 | 80.6% |
| Linux_x86_64 | 3323 | 3211 | 35 | 96.6% |
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
| basenc | 96 | 89 | 7 | 93% |
| cat | 49 | 46 | 3 | 94% |
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
| readlink | 60 | 59 | 1 | 98% |
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
| sort | 111 | 110 | 1 | 99% |
| split | 72 | 66 | 6 | 92% |
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
| touch | 48 | 44 | 4 | 92% |
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
| yes | 29 | 25 | 4 | 86% |

## Performance (Linux x86_64)

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|----------:|-----------------:|--------:|
| arch | arch (no args) | 0.0008s | 0.0009s | **0.9x** |
| base32 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base32 | encode 1MB text | 0.0023s | 0.0019s | **1.2x** |
| base32 | encode 10MB text | 0.0147s | 0.0106s | **1.4x** |
| base32 | encode 10MB binary | 0.0157s | 0.0117s | **1.3x** |
| base32 | decode 1MB | 0.0035s | 0.0026s | **1.4x** |
| base32 | decode 10MB | 0.0279s | 0.0166s | **1.7x** |
| base64 | encode 100KB text | 0.0010s | 0.0012s | **0.8x** |
| base64 | encode 1MB text | 0.0020s | 0.0016s | **1.3x** |
| base64 | encode 10MB text | 0.0121s | 0.0051s | **2.4x** |
| base64 | encode 10MB binary | 0.0128s | 0.0055s | **2.3x** |
| base64 | decode 1MB | 0.0040s | 0.0022s | **1.8x** |
| base64 | decode 10MB | 0.0326s | 0.0050s | **6.6x** |
| base64 | encode -w 76 10MB | 0.0125s | 0.0052s | **2.4x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0040s | **2.1x** |
| basename | basename simple path | 0.0008s | 0.0009s | **0.9x** |
| basename | basename with suffix (.txt) | 0.0008s | 0.0009s | **0.9x** |
| basenc | encode --base64 1MB | 0.0020s | 0.0013s | **1.6x** |
| basenc | encode --base64 10MB | 0.0120s | 0.0046s | **2.6x** |
| basenc | encode --base32 1MB | 0.0022s | 0.0021s | **1.0x** |
| basenc | encode --base16 1MB | 0.0024s | 0.0025s | **1.0x** |
| basenc | decode --base64 -d 1MB | 0.0040s | 0.0035s | **1.2x** |
| chgrp | chgrp current group on file | 0.0022s | 0.0024s | **0.9x** |
| chgrp | chgrp current group on 1MB file | 0.0032s | 0.0031s | **1.0x** |
| chmod | chmod 644 on file | 0.0021s | 0.0023s | **0.9x** |
| chmod | chmod u+x on file | 0.0021s | 0.0022s | **0.9x** |
| chown | chown current user on file | 0.0020s | 0.0029s | **0.7x** |
| chown | chown current user on 1MB file | 0.0030s | 0.0032s | **1.0x** |
| cksum | single 1MB text | 0.0014s | 0.0016s | **0.8x** |
| cksum | single 10MB text | 0.0035s | 0.0029s | **1.2x** |
| cksum | single 10MB binary | 0.0027s | 0.0030s | **0.9x** |
| cp | cp 1MB file | 0.0031s | 0.0026s | **1.2x** |
| cp | cp 10MB file | 0.0097s | 0.0096s | **1.0x** |
| cp | cp -r directory (many_files) | 0.0072s | 0.0064s | **1.1x** |
| csplit | csplit 1MB by pattern | 0.4333s | 0.0250s | **17.3x** |
| cut | -b1-100 10MB CSV | 0.0225s | 0.0038s | **5.9x** |
| cut | -c1-100 10MB CSV | 0.0223s | 0.0039s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0165s | 0.0094s | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0220s | 0.0113s | **1.9x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0103s | **2.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0309s | 0.0108s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | **0.7x** |
| cut | -d, -f1 1MB text | 0.0033s | 0.0029s | **1.1x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0012s | **0.7x** |
| dd | dd read 10MB (bs=4096) | 0.0047s | 0.0044s | **1.1x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0103s | 0.0249s | **0.4x** |
| dirname | dirname simple path | 0.0008s | 0.0009s | **0.9x** |
| dirname | dirname deep path | 0.0008s | 0.0009s | **0.9x** |
| echo | echo hello | 0.0008s | 0.0009s | **0.9x** |
| echo | echo -n hello | 0.0008s | 0.0009s | **0.8x** |
| echo | echo -e with escapes | 0.0008s | 0.0009s | **0.9x** |
| env | print all env vars | 0.0008s | 0.0010s | **0.8x** |
| env | env true (run command) | 0.0013s | 0.0014s | **0.9x** |
| env | env VAR=value true | 0.0013s | 0.0014s | **0.9x** |
| expr | expr 1 + 1 | 0.0009s | 0.0010s | **0.9x** |
| expr | expr 999999 * 999999 | 0.0009s | 0.0011s | **0.9x** |
| expr | expr length 'hello world' | 0.0009s | 0.0010s | **0.9x** |
| expr | expr 'hello' : 'hel' | 0.0009s | 0.0011s | **0.8x** |
| factor | factor 1234567890 | 0.0009s | 0.0009s | **0.9x** |
| factor | factor 999999999999999989 (large prime) | 0.0009s | 0.0009s | **1.0x** |
| factor | factor 1-100000 via stdin | 0.0165s | 0.0100s | **1.7x** |
| false | false (startup overhead) | 0.0000s | 0.0007s | **0.0x** |
| groups | groups (no args) | 0.0009s | 0.0010s | **0.9x** |
| hostid | hostid (no args) | 0.0010s | 0.0010s | **0.9x** |
| id | id (no args) | 0.0012s | 0.0012s | **1.0x** |
| id | id -u | 0.0010s | 0.0009s | **1.1x** |
| id | id -g | 0.0010s | 0.0009s | **1.1x** |
| id | id -un | 0.0011s | 0.0010s | **1.1x** |
| install | install 1MB file | 0.0029s | 0.0027s | **1.1x** |
| install | install -d create directory | 0.0023s | 0.0020s | **1.1x** |
| link | hard link a file | 0.0017s | 0.0018s | **0.9x** |
| ln | symlink single file | 0.0017s | 0.0018s | **0.9x** |
| ln | symlink force overwrite (-sf) | 0.0017s | 0.0018s | **0.9x** |
| ln | hard link single file | 0.0017s | 0.0018s | **0.9x** |
| logname | logname (no args) | 0.0008s | 0.0009s | **0.9x** |
| mkdir | mkdir single directory | 0.0019s | 0.0018s | **1.0x** |
| mkdir | mkdir -p nested directories | 0.0022s | 0.0021s | **1.0x** |
| mkfifo | mkfifo single fifo | 0.0019s | 0.0018s | **1.0x** |
| mknod | mknod named pipe | 0.0019s | 0.0018s | **1.0x** |
| mktemp | mktemp default | - | 0.0020s | - |
| mktemp | mktemp -d directory | - | 0.0020s | - |
| mv | mv 1MB file | 0.0040s | 0.0038s | **1.0x** |
| mv | mv 10MB file | 0.0111s | 0.0111s | **1.0x** |
| nice | nice true (default priority) | 0.0013s | 0.0014s | **0.9x** |
| nice | nice -n 10 true | 0.0013s | 0.0014s | **0.9x** |
| nohup | nohup true | 0.0021s | 0.0023s | **0.9x** |
| nproc | nproc (no args) | 0.0008s | 0.0010s | **0.8x** |
| nproc | nproc --all | 0.0009s | 0.0009s | **0.9x** |
| pathchk | pathchk default | 0.0008s | 0.0010s | **0.9x** |
| pathchk | pathchk -p (POSIX portable) | 0.0008s | 0.0009s | **0.9x** |
| pwd | pwd (no args) | 0.0000s | 0.0010s | **0.0x** |
| pwd | pwd -L | 0.0000s | 0.0009s | **0.0x** |
| pwd | pwd -P | 0.0000s | 0.0010s | **0.0x** |
| readlink | readlink symlink | 0.0008s | 0.0010s | **0.9x** |
| readlink | readlink -f (canonicalize) | 0.0008s | 0.0009s | **0.9x** |
| realpath | realpath . | 0.0008s | 0.0009s | **0.9x** |
| realpath | realpath /tmp | 0.0008s | 0.0009s | **0.9x** |
| realpath | realpath test data file | 0.0007s | 0.0009s | **0.9x** |
| rev | reverse 100KB text | 0.0023s | 0.0010s | **2.2x** |
| rev | reverse 1MB text | 0.0143s | 0.0017s | **8.2x** |
| rev | reverse 10MB text | 0.1331s | 0.0075s | **17.9x** |
| rev | reverse 100MB text | 1.3318s | 0.0701s | **19.0x** |
| rev | reverse CSV 10MB | 0.1017s | 0.0071s | **14.4x** |
| rev | reverse repetitive 10MB | 0.3055s | 0.0122s | **25.0x** |
| rev | reverse 10KB single line | 0.0010s | 0.0010s | **1.1x** |
| rm | rm single file | 0.0021s | 0.0022s | **0.9x** |
| rm | rm -rf directory | 0.0071s | 0.0073s | **1.0x** |
| rmdir | rmdir single empty directory | 0.0019s | 0.0019s | **1.0x** |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0104s | 0.0024s | **4.2x** |
| seq | seq 1 10000000 | 0.0960s | 0.0136s | **7.1x** |
| seq | seq 0 0.1 100000 (float) | 0.2315s | 0.0193s | **12.0x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2428s | 0.0155s | **15.7x** |
| sha1sum | single 1MB text | 0.0019s | 0.0033s | **0.6x** |
| sha1sum | single 10MB text | 0.0079s | 0.0098s | **0.8x** |
| sha1sum | single 10MB binary | 0.0084s | 0.0105s | **0.8x** |
| sha1sum | 100 files | 0.0024s | 0.0033s | **0.7x** |
| sha224sum | single 1MB text | 0.0020s | 0.0033s | **0.6x** |
| sha224sum | single 10MB text | 0.0085s | 0.0108s | **0.8x** |
| sha224sum | single 10MB binary | 0.0089s | 0.0111s | **0.8x** |
| sha384sum | single 1MB text | 0.0027s | 0.0040s | **0.7x** |
| sha384sum | single 10MB text | 0.0154s | 0.0173s | **0.9x** |
| sha384sum | single 10MB binary | 0.0162s | 0.0186s | **0.9x** |
| sha512sum | single 1MB text | 0.0027s | 0.0042s | **0.7x** |
| sha512sum | single 10MB text | 0.0158s | 0.0178s | **0.9x** |
| sha512sum | single 10MB binary | 0.0169s | 0.0191s | **0.9x** |
| shred | shred 1MB file | 0.0098s | 0.0063s | **1.5x** |
| shred | shred 1MB file with remove (-u) | 0.0171s | 0.0075s | **2.3x** |
| sleep | sleep 0 (startup overhead) | 0.0009s | 0.0009s | **1.0x** |
| sleep | sleep 0.001 (tiny sleep) | 0.0019s | 0.0020s | **1.0x** |
| sort | lexicographic 1MB | 0.0086s | 0.0037s | **2.3x** |
| sort | lexicographic 10MB random | 0.0547s | 0.0091s | **6.0x** |
| sort | already sorted 10MB | 0.0263s | 0.0051s | **5.2x** |
| sort | reverse sorted 10MB | 0.0277s | 0.0066s | **4.2x** |
| sort | -n numeric 10MB | 0.0736s | 0.0057s | **13.0x** |
| sort | -r reverse 10MB | 0.0547s | 0.0094s | **5.8x** |
| sort | -u unique 10MB | 0.0584s | 0.0096s | **6.1x** |
| sort | -t, -k2 CSV 10MB | 0.0667s | 0.0395s | **1.7x** |
| sort | repetitive 10MB | 0.0551s | 0.0127s | **4.3x** |
| sort | --parallel=4 10MB | 0.0552s | 0.0092s | **6.0x** |
| split | split 10MB into 1MB chunks (-b 1m) | - | - | - |
| split | split 10MB by 1000 lines (-l 1000) | 0.0168s | 0.0174s | **1.0x** |
| sum | single 1MB text | 0.0025s | 0.0023s | **1.1x** |
| sum | single 10MB text | 0.0172s | 0.0144s | **1.2x** |
| sum | single 10MB binary | 0.0182s | 0.0151s | **1.2x** |
| sync | sync (no args) | 0.0008s | 0.0009s | **0.9x** |
| tee | tee 1MB to /dev/null | 0.0017s | 0.0017s | **1.0x** |
| tee | tee 10MB to /dev/null | 0.0066s | 0.0051s | **1.3x** |
| test | test -f (file exists) | 0.0000s | 0.0009s | **0.0x** |
| test | test 1 -eq 1 | 0.0000s | 0.0009s | **0.0x** |
| test | test 'hello' = 'hello' | 0.0000s | 0.0009s | **0.0x** |
| test | test -d /tmp | 0.0000s | 0.0010s | **0.0x** |
| touch | create new file | 0.0017s | 0.0019s | **0.9x** |
| touch | update existing file timestamp | 0.0009s | 0.0010s | **0.9x** |
| touch | set specific timestamp (-t) | 0.0017s | 0.0018s | **0.9x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0015s | **1.5x** |
| tr | a-z to A-Z 10MB | 0.0126s | 0.0039s | **3.3x** |
| tr | -d digits 10MB | 0.0170s | 0.0042s | **4.1x** |
| tr | -d lowercase 10MB | 0.0318s | 0.0047s | **6.7x** |
| tr | -s spaces 10MB | 0.0294s | 0.0038s | **7.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0134s | 0.0037s | **3.6x** |
| tr | -d [:digit:] 10MB CSV | 0.0167s | 0.0042s | **3.9x** |
| tr | translate binary 10MB | 0.0108s | 0.0037s | **2.9x** |
| true | true (startup overhead) | 0.0000s | 0.0007s | **0.0x** |
| truncate | truncate to zero (-s 0) | 0.0030s | 0.0031s | **1.0x** |
| truncate | create 1M file (-s 1M) | 0.0017s | 0.0018s | **0.9x** |
| tsort | tsort 100K pairs | 0.0565s | 0.0072s | **7.8x** |
| tsort | tsort 1M pairs | 0.6465s | 0.0629s | **10.3x** |
| tty | tty (no args) | 0.0009s | 0.0009s | **0.9x** |
| uname | uname (no args) | 0.0008s | 0.0009s | **0.9x** |
| uname | uname -a | 0.0009s | 0.0009s | **0.9x** |
| uname | uname -r | 0.0008s | 0.0009s | **0.9x** |
| uname | uname -m | 0.0008s | 0.0009s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0118s | 0.0019s | **6.1x** |
| uniq | default 10MB sorted (low dup) | 0.0138s | 0.0030s | **4.6x** |
| uniq | -c count 10MB many dups | 0.0119s | 0.0019s | **6.4x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0077s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0019s | **6.3x** |
| uniq | -u unique only 10MB | 0.0118s | 0.0019s | **6.2x** |
| uniq | -i case insensitive 10MB | 0.0138s | 0.0043s | **3.2x** |
| uniq | repetitive 10MB | 0.0414s | 0.0035s | **11.8x** |
| unlink | unlink a file | 0.0021s | 0.0022s | **0.9x** |
| whoami | whoami (no args) | 0.0009s | 0.0010s | **0.9x** |
| yes | startup --help | 0.0009s | 0.0002s | **4.2x** |
| yes | startup --version | 0.0008s | 0.0002s | **4.1x** |
| yes | throughput 1M lines | 0.0032s | 0.0032s | **1.0x** |
| yes | throughput 10M lines | 0.0249s | 0.0253s | **1.0x** |
| yes | throughput hello 1M lines | 0.0065s | 0.0065s | **1.0x** |
| yes | throughput hello 10M lines | 0.0503s | 0.0559s | **0.9x** |
| yes | throughput 100MB | 0.0453s | 0.0454s | **1.0x** |
