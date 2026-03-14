# fcoreutils v0.22.1 — Detailed Results

Generated: 2026-03-14 21:25:45 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|------:|-------:|-------:|----------:|
| Darwin_arm64 | 804 | 651 | 123 | 81.0% |
| Linux_aarch64 | 804 | 656 | 118 | 81.6% |
| Linux_x86_64 | 3911 | 3807 | 4 | 97.3% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

## Per-Tool Compatibility (Linux x86_64)

| Tool | Total | Passed | Failed | Rate |
|------|------:|-------:|-------:|-----:|
| arch | 17 | 17 | 0 | 100% |
| b2sum | 25 | 25 | 0 | 100% |
| base32 | 29 | 29 | 0 | 100% |
| base64 | 33 | 33 | 0 | 100% |
| basename | 26 | 26 | 0 | 100% |
| basenc | 96 | 95 | 1 | 99% |
| cat | 49 | 49 | 0 | 100% |
| chcon | 24 | 15 | 9 | 62% |
| chgrp | 19 | 17 | 2 | 89% |
| chmod | 79 | 78 | 1 | 99% |
| chown | 20 | 17 | 3 | 85% |
| chroot | 38 | 18 | 20 | 47% |
| cksum | 48 | 48 | 0 | 100% |
| comm | 30 | 30 | 0 | 100% |
| cp | 69 | 69 | 0 | 100% |
| csplit | 2 | 2 | 0 | 100% |
| cut | 99 | 96 | 3 | 97% |
| date | 46 | 46 | 0 | 100% |
| dd | 29 | 29 | 0 | 100% |
| df | 25 | 25 | 0 | 100% |
| dir | 45 | 45 | 0 | 100% |
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
| fold | 58 | 57 | 1 | 98% |
| groups | 28 | 28 | 0 | 100% |
| head | 63 | 60 | 3 | 95% |
| hostid | 6 | 6 | 0 | 100% |
| id | 27 | 27 | 0 | 100% |
| install | 32 | 27 | 5 | 84% |
| join | 37 | 37 | 0 | 100% |
| kill | 20 | 20 | 0 | 100% |
| link | 32 | 32 | 0 | 100% |
| ln | 33 | 33 | 0 | 100% |
| logname | 13 | 13 | 0 | 100% |
| ls | 65 | 65 | 0 | 100% |
| md5sum | 30 | 30 | 0 | 100% |
| mkdir | 44 | 37 | 7 | 84% |
| mkfifo | 11 | 11 | 0 | 100% |
| mknod | 12 | 12 | 0 | 100% |
| mktemp | 17 | 15 | 2 | 88% |
| mv | 3 | 3 | 0 | 100% |
| nice | 34 | 32 | 2 | 94% |
| nl | 62 | 61 | 1 | 98% |
| nohup | 11 | 11 | 0 | 100% |
| nproc | 31 | 29 | 2 | 94% |
| numfmt | 33 | 32 | 1 | 97% |
| od | 50 | 50 | 0 | 100% |
| paste | 32 | 32 | 0 | 100% |
| pathchk | 22 | 22 | 0 | 100% |
| pinky | 32 | 32 | 0 | 100% |
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
| sha1sum | 43 | 43 | 0 | 100% |
| sha224sum | 39 | 39 | 0 | 100% |
| sha256sum | 34 | 34 | 0 | 100% |
| sha384sum | 39 | 39 | 0 | 100% |
| sha512sum | 39 | 39 | 0 | 100% |
| shred | 27 | 27 | 0 | 100% |
| shuf | 53 | 52 | 1 | 98% |
| sleep | 15 | 15 | 0 | 100% |
| sort | 111 | 111 | 0 | 100% |
| split | 72 | 72 | 0 | 100% |
| stat | 38 | 38 | 0 | 100% |
| stdbuf | 13 | 13 | 0 | 100% |
| stty | 42 | 25 | 17 | 60% |
| sum | 23 | 23 | 0 | 100% |
| sync | 10 | 9 | 1 | 90% |
| tac | 59 | 59 | 0 | 100% |
| tail | 80 | 80 | 0 | 100% |
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
| unlink | 30 | 30 | 0 | 100% |
| uptime | 16 | 16 | 0 | 100% |
| users | 6 | 6 | 0 | 100% |
| vdir | 41 | 41 | 0 | 100% |
| wc | 77 | 77 | 0 | 100% |
| who | 38 | 38 | 0 | 100% |
| whoami | 16 | 16 | 0 | 100% |
| yes | 29 | 26 | 3 | 90% |

## Performance (Linux x86_64)

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|----------:|-----------------:|--------:|
| arch | arch (no args) | 0.0008s | 0.0010s | 0.9x |
| b2sum | single 100KB text | 0.0008s | 0.0009s | 0.8x |
| b2sum | single 1MB text | 0.0020s | 0.0019s | **1.1x** |
| b2sum | single 10MB text | 0.0149s | 0.0135s | **1.1x** |
| b2sum | single 10MB binary | 0.0155s | 0.0139s | **1.1x** |
| b2sum | -l 256 10MB | 0.0152s | 0.0132s | **1.1x** |
| b2sum | -l 128 10MB | 0.0147s | 0.0132s | **1.1x** |
| b2sum | 100 files | 0.0014s | 0.0022s | 0.6x |
| base32 | encode 100KB text | 0.0011s | 0.0013s | 0.8x |
| base32 | encode 1MB text | 0.0023s | 0.0021s | **1.1x** |
| base32 | encode 10MB text | 0.0149s | 0.0090s | **1.7x** |
| base32 | encode 10MB binary | 0.0155s | 0.0094s | **1.6x** |
| base32 | decode 1MB | 0.0036s | 0.0029s | **1.2x** |
| base32 | decode 10MB | 0.0282s | 0.0162s | **1.7x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.1x** |
| base64 | encode 1MB text | 0.0021s | 0.0014s | **1.5x** |
| base64 | encode 10MB text | 0.0129s | 0.0050s | **2.6x** |
| base64 | encode 10MB binary | 0.0129s | 0.0050s | **2.6x** |
| base64 | decode 1MB | 0.0040s | 0.0020s | **2.0x** |
| base64 | decode 10MB | 0.0327s | 0.0048s | **6.8x** |
| base64 | encode -w 76 10MB | 0.0123s | 0.0049s | **2.5x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0086s | 0.0034s | **2.5x** |
| basename | basename simple path | 0.0008s | 0.0010s | 0.8x |
| basename | basename with suffix (.txt) | 0.0008s | 0.0010s | 0.9x |
| basenc | encode --base64 1MB | 0.0016s | 0.0013s | **1.3x** |
| basenc | encode --base64 10MB | 0.0107s | 0.0065s | **1.7x** |
| basenc | encode --base32 1MB | 0.0018s | 0.0020s | 0.9x |
| basenc | encode --base16 1MB | 0.0020s | 0.0022s | 0.9x |
| basenc | decode --base64 -d 1MB | 0.0038s | 0.0015s | **2.6x** |
| cat | passthrough 1MB | 0.0010s | 0.0014s | 0.7x |
| cat | passthrough 10MB | 0.0016s | 0.0020s | 0.8x |
| cat | -n 1MB | 0.0021s | 0.0022s | 0.9x |
| cat | -n 10MB | 0.0104s | 0.0062s | **1.7x** |
| cat | -b 10MB | 0.0106s | 0.0061s | **1.7x** |
| cat | -A 1MB | 0.0019s | 0.0017s | **1.1x** |
| cat | 100 small files | 0.0027s | 0.0027s | **1.0x** |
| cat | binary 10MB | 0.0015s | 0.0019s | 0.8x |
| chgrp | chgrp current group on file | 0.0022s | 0.0024s | 0.9x |
| chgrp | chgrp current group on 1MB file | 0.0031s | 0.0033s | **1.0x** |
| chown | chown current user on file | 0.0024s | 0.0025s | **1.0x** |
| chown | chown current user on 1MB file | 0.0032s | 0.0042s | 0.8x |
| cksum | single 1MB text | 0.0014s | 0.0011s | **1.3x** |
| cksum | single 10MB text | 0.0027s | 0.0024s | **1.1x** |
| cksum | single 10MB binary | 0.0027s | 0.0023s | **1.2x** |
| comm | default 10MB sorted | 0.0300s | 0.0072s | **4.1x** |
| comm | -12 (common only) 10MB | 0.0215s | 0.0047s | **4.6x** |
| comm | -23 (unique to file1) 10MB | 0.0214s | 0.0057s | **3.8x** |
| comm | -3 10MB | 0.0240s | 0.0070s | **3.4x** |
| comm | identical 10MB sorted | 0.0301s | 0.0091s | **3.3x** |
| cp | cp small file (1KB) | 0.0022s | 0.0022s | **1.0x** |
| cp | cp medium file (1MB) | 0.0030s | 0.0030s | **1.0x** |
| cp | cp large file (10MB) | 0.0109s | 0.0106s | **1.0x** |
| cp | cp -r many small files (100 files) | 0.0074s | 0.0066s | **1.1x** |
| cp | cp -r deep directory (8 levels) | 0.0032s | 0.0031s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0266s | 0.0042s | **6.4x** |
| cut | -c1-100 10MB CSV | 0.0231s | 0.0040s | **5.8x** |
| cut | -d, -f1 10MB CSV | 0.0179s | 0.0047s | **3.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0222s | 0.0078s | **2.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0242s | 0.0054s | **4.4x** |
| cut | --complement -d, -f1 10MB CSV | 0.0305s | 0.0041s | **7.5x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0016s | 0.5x |
| cut | -d, -f1 1MB text | 0.0033s | 0.0021s | **1.6x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0016s | 0.5x |
| date | date (default) | 0.0009s | 0.0010s | 0.9x |
| date | +%Y-%m-%d %H:%M:%S | 0.0008s | 0.0009s | 0.9x |
| date | +%s (epoch) | 0.0009s | 0.0010s | 0.9x |
| date | ISO 8601 format | 0.0009s | 0.0010s | 0.9x |
| date | RFC 3339 | 0.0009s | 0.0010s | 0.9x |
| date | -u (UTC) | 0.0009s | 0.0010s | 0.9x |
| dd | dd read 10MB (bs=4096) | 0.0049s | 0.0048s | **1.0x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0108s | 0.0134s | 0.8x |
| df | df (default) | 0.0013s | 0.0010s | **1.3x** |
| df | -h (human readable) | 0.0013s | 0.0010s | **1.3x** |
| df | df / | 0.0010s | 0.0011s | 0.9x |
| df | -i (inodes) | 0.0013s | 0.0010s | **1.2x** |
| dir | dir current directory | 0.0011s | 0.0015s | 0.7x |
| dir | 100 files directory | 0.0012s | 0.0018s | 0.7x |
| dir | -la 100 files | 0.0021s | 0.0018s | **1.2x** |
| dir | -R test data | 0.0013s | 0.0017s | 0.8x |
| dircolors | dircolors -b (default) | 0.0009s | 0.0010s | 0.9x |
| dircolors | dircolors -c (csh) | 0.0009s | 0.0010s | 0.9x |
| dircolors | dircolors -p (print) | 0.0009s | 0.0009s | 0.9x |
| dircolors | custom db file | 0.0009s | 0.0010s | **1.0x** |
| dirname | dirname simple path | 0.0008s | 0.0009s | 0.9x |
| dirname | dirname deep path | 0.0008s | 0.0015s | 0.6x |
| du | du test data dir | 0.0014s | 0.0016s | 0.9x |
| du | -s (summary) | 0.0014s | 0.0016s | 0.9x |
| du | -sh (human summary) | 0.0015s | 0.0016s | 0.9x |
| du | --max-depth=1 | 0.0015s | 0.0016s | 0.9x |
| du | -b (bytes) | 0.0016s | 0.0016s | **1.0x** |
| echo | echo hello | 0.0008s | 0.0010s | 0.9x |
| echo | echo -n hello | 0.0008s | 0.0010s | 0.9x |
| echo | echo -e with escapes | 0.0009s | 0.0010s | 0.9x |
| env | print all env vars | 0.0006s | 0.0008s | 0.8x |
| env | env true (run command) | 0.0009s | 0.0011s | 0.8x |
| env | env VAR=value true | 0.0009s | 0.0011s | 0.9x |
| expand | expand 10MB tabbed (default) | 0.0452s | 0.0151s | **3.0x** |
| expand | expand 1MB text | 0.0033s | 0.0011s | **3.0x** |
| expand | -t 4 10MB tabbed | 0.0417s | 0.0125s | **3.3x** |
| expand | -t 2 10MB tabbed | 0.0356s | 0.0125s | **2.9x** |
| expand | --initial 10MB tabbed | 0.0229s | 0.0065s | **3.5x** |
| expand | expand CSV 10MB | 0.0188s | 0.0016s | **11.6x** |
| expr | expr 1 + 1 | 0.0014s | 0.0010s | **1.4x** |
| expr | expr 999999 * 999999 | 0.0011s | 0.0016s | 0.7x |
| expr | expr length 'hello world' | 0.0012s | 0.0013s | 0.9x |
| expr | expr 'hello' : 'hel' | 0.0009s | 0.0014s | 0.6x |
| factor | factor 1234567890 | 0.0009s | 0.0009s | 0.9x |
| factor | factor 999999999999999989 (large prime) | 0.0010s | 0.0010s | **1.0x** |
| factor | factor 1-100000 via stdin | 0.0205s | 0.0175s | **1.2x** |
| false | false (startup overhead) | 0.0004s | 0.0006s | 0.8x |
| fmt | fmt 1MB text | 0.0169s | 0.0154s | **1.1x** |
| fmt | fmt 10MB text | 0.1442s | 0.1216s | **1.2x** |
| fmt | -w 40 10MB | 0.1232s | 0.0932s | **1.3x** |
| fmt | -w 120 10MB | 0.1747s | 0.1561s | **1.1x** |
| fmt | fmt wide lines 10MB | 0.1667s | 0.1424s | **1.2x** |
| fold | fold 10MB wide lines (default) | 0.0341s | 0.0040s | **8.6x** |
| fold | fold 1MB text | 0.0042s | 0.0015s | **2.8x** |
| fold | fold 10MB text | 0.0346s | 0.0050s | **7.0x** |
| fold | -w 40 10MB | 0.0352s | 0.0044s | **8.1x** |
| fold | -w 20 10MB | 0.0358s | 0.0057s | **6.3x** |
| fold | -s -w 60 10MB | 0.0377s | 0.0048s | **7.8x** |
| fold | -s -w 40 10MB | 0.0403s | 0.0060s | **6.7x** |
| fold | -b -w 40 10MB | 0.0330s | 0.0051s | **6.5x** |
| groups | groups (no args) | 0.0010s | 0.0011s | 0.9x |
| head | default 1MB text | 0.0008s | 0.0012s | 0.7x |
| head | default 10MB text | 0.0008s | 0.0012s | 0.7x |
| head | -n 1000 10MB | 0.0009s | 0.0011s | 0.8x |
| head | -n 100000 10MB | 0.0063s | 0.0031s | **2.1x** |
| head | -c 1000000 10MB | 0.0012s | 0.0012s | **1.0x** |
| head | -n -100 10MB (all but last 100) | 0.0039s | 0.0020s | **1.9x** |
| head | 100 small files | 0.0015s | 0.0019s | 0.8x |
| hostid | hostid (no args) | 0.0010s | 0.0011s | 0.9x |
| id | id (no args) | 0.0009s | 0.0010s | 0.9x |
| id | id -u | 0.0007s | 0.0008s | 0.9x |
| id | id -g | 0.0007s | 0.0009s | 0.9x |
| id | id -un | 0.0008s | 0.0009s | 0.9x |
| install | install 1MB file | 0.0029s | 0.0027s | **1.1x** |
| install | install -d create directory | 0.0024s | 0.0022s | **1.1x** |
| join | default join 10MB | - | - | - |
| join | outer join 10MB | - | - | - |
| join | -v 1 (unmatched from file1) 10MB | - | - | - |
| join | -o 0,1.2,2.2 10MB | - | - | - |
| join | self-join sorted 10MB | 0.0486s | 0.0389s | **1.2x** |
| kill | kill -l (list signals) | 0.0008s | 0.0009s | 0.9x |
| link | hard link a file | 0.0017s | 0.0018s | 0.9x |
| ln | symlink single file | 0.0017s | 0.0019s | 0.9x |
| ln | symlink force overwrite (-sf) | 0.0018s | 0.0019s | 0.9x |
| ln | hard link single file | 0.0017s | 0.0019s | 0.9x |
| logname | logname (no args) | 0.0009s | 0.0010s | 0.9x |
| ls | ls current directory | 0.0011s | 0.0012s | 0.8x |
| ls | 100 files | 0.0011s | 0.0015s | 0.8x |
| ls | -la 100 files | 0.0020s | 0.0018s | **1.1x** |
| ls | -la test data dir | 0.0022s | 0.0019s | **1.2x** |
| ls | -R test data | 0.0011s | 0.0014s | 0.8x |
| ls | -lt 100 files | 0.0019s | 0.0017s | **1.1x** |
| ls | -lS test data dir | 0.0022s | 0.0020s | **1.1x** |
| md5sum | single 100KB text | 0.0015s | 0.0013s | **1.1x** |
| md5sum | single 1MB text | 0.0031s | 0.0033s | **1.0x** |
| md5sum | single 10MB text | 0.0178s | 0.0192s | 0.9x |
| md5sum | single 10MB binary | 0.0186s | 0.0208s | 0.9x |
| md5sum | 10 files | 0.0017s | 0.0032s | 0.5x |
| md5sum | 100 files | 0.0032s | 0.0044s | 0.7x |
| mkdir | mkdir single directory | 0.0019s | 0.0018s | **1.1x** |
| mkdir | mkdir -p nested directories | 0.0022s | 0.0021s | **1.0x** |
| mkfifo | mkfifo single fifo | 0.0019s | 0.0019s | **1.0x** |
| mknod | mknod named pipe | 0.0019s | 0.0019s | **1.0x** |
| mktemp | mktemp default | 0.0022s | 0.0022s | **1.0x** |
| mktemp | mktemp -d directory | 0.0020s | 0.0023s | 0.9x |
| mv | mv same-fs small (1MB) | 0.0039s | 0.0037s | **1.1x** |
| mv | mv same-fs large (10MB) | 0.0115s | 0.0111s | **1.0x** |
| mv | mv many files (100 files) | - | 0.0106s | - |
| nice | nice true (default priority) | 0.0013s | 0.0015s | 0.9x |
| nice | nice -n 10 true | 0.0013s | 0.0018s | 0.7x |
| nl | default 1MB | 0.0049s | 0.0016s | **3.1x** |
| nl | default 10MB | 0.0366s | 0.0054s | **6.8x** |
| nl | -b a 10MB | 0.0361s | 0.0049s | **7.3x** |
| nl | -b a 10MB with blanks | 0.0454s | 0.0067s | **6.8x** |
| nl | -b a -n rz 10MB | 0.0359s | 0.0049s | **7.4x** |
| nl | -b a -w 8 -s ': ' 10MB | 0.0358s | 0.0052s | **6.9x** |
| nl | -b p'^the' 10MB | 0.0618s | 0.0063s | **9.9x** |
| nohup | nohup true | 0.0022s | 0.0023s | **1.0x** |
| nproc | nproc (no args) | 0.0008s | 0.0010s | 0.9x |
| nproc | nproc --all | 0.0009s | 0.0010s | 0.9x |
| numfmt | --to=iec single value | 0.0013s | 0.0014s | **1.0x** |
| numfmt | --from=iec single value | 0.0016s | 0.0018s | 0.9x |
| numfmt | --to=si from CSV column | 0.0343s | 0.0225s | **1.5x** |
| od | default 1MB text | 0.0773s | 0.0099s | **7.8x** |
| od | -A x -t x1z 1MB | 0.1179s | 0.0169s | **7.0x** |
| od | -c 1MB text | 0.1257s | 0.0131s | **9.6x** |
| od | default 10MB binary | 0.6686s | 0.0921s | **7.3x** |
| od | -N 10000 10MB | 0.0021s | 0.0011s | **1.9x** |
| paste | 2 columns 10MB | 0.0242s | 0.0090s | **2.7x** |
| paste | 3 columns 10MB | 0.0309s | 0.0160s | **1.9x** |
| paste | -d comma 10MB | 0.0240s | 0.0090s | **2.7x** |
| paste | -s 10MB single file | 0.0105s | 0.0044s | **2.4x** |
| paste | stdin split 2-way 10MB | 0.0310s | 0.0083s | **3.7x** |
| pathchk | pathchk default | 0.0006s | 0.0010s | 0.6x |
| pathchk | pathchk -p (POSIX portable) | 0.0006s | 0.0008s | 0.7x |
| pinky | pinky (default) | 0.0009s | 0.0010s | 0.9x |
| pinky | pinky -l | - | - | - |
| pr | pr 1MB text | 0.0112s | 0.0014s | **7.9x** |
| pr | -2 (two columns) 1MB | 0.0119s | 0.0017s | **6.9x** |
| pr | -3 (three columns) 1MB | 0.0087s | 0.0016s | **5.6x** |
| pr | -n 1MB text | 0.0119s | 0.0018s | **6.5x** |
| pr | -t 1MB text | 0.0101s | 0.0013s | **7.7x** |
| printenv | printenv (all) | 0.0009s | 0.0010s | 0.8x |
| printenv | printenv HOME | 0.0008s | 0.0010s | 0.8x |
| printenv | printenv PATH | 0.0009s | 0.0010s | 0.9x |
| printf | simple string | 0.0008s | 0.0010s | 0.8x |
| printf | integer formatting | 0.0009s | 0.0011s | 0.8x |
| printf | float formatting | 0.0012s | 0.0015s | 0.8x |
| printf | string padding | 0.0007s | 0.0009s | 0.7x |
| ptx | ptx 10KB text | 0.0019s | 0.0016s | **1.2x** |
| ptx | ptx 100KB text | 0.0110s | 0.0055s | **2.0x** |
| ptx | -w 60 100KB text | 0.0144s | 0.0055s | **2.6x** |
| pwd | pwd (no args) | 0.0008s | 0.0009s | 0.9x |
| pwd | pwd -L | 0.0008s | 0.0010s | 0.8x |
| pwd | pwd -P | 0.0008s | 0.0010s | 0.9x |
| readlink | readlink symlink | 0.0006s | 0.0008s | 0.7x |
| readlink | readlink -f (canonicalize) | 0.0006s | 0.0009s | 0.6x |
| realpath | realpath . | 0.0008s | 0.0010s | 0.8x |
| realpath | realpath /tmp | 0.0009s | 0.0010s | 0.9x |
| realpath | realpath test data file | 0.0009s | 0.0010s | 0.9x |
| rev | reverse 100KB text | 0.0022s | 0.0010s | **2.2x** |
| rev | reverse 1MB text | 0.0145s | 0.0018s | **8.1x** |
| rev | reverse 10MB text | 0.1344s | 0.0076s | **17.7x** |
| rev | reverse CSV 10MB | 0.1000s | 0.0071s | **14.1x** |
| rev | reverse repetitive 10MB | 0.2868s | 0.0140s | **20.6x** |
| rev | reverse 10KB single line | 0.0010s | 0.0009s | **1.1x** |
| rm | rm single file | 0.0021s | 0.0022s | 0.9x |
| rm | rm -rf directory | 0.0070s | 0.0077s | 0.9x |
| rmdir | rmdir single empty directory | 0.0019s | 0.0020s | **1.0x** |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0115s | 0.0024s | **4.8x** |
| seq | seq 1 10000000 | 0.0987s | 0.0140s | **7.1x** |
| seq | seq 0 0.1 100000 (float) | 0.2389s | 0.0204s | **11.7x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2438s | 0.0157s | **15.5x** |
| sha1sum | single 1MB text | 0.0019s | 0.0017s | **1.2x** |
| sha1sum | single 10MB text | 0.0079s | 0.0080s | **1.0x** |
| sha1sum | single 10MB binary | 0.0083s | 0.0083s | **1.0x** |
| sha1sum | 100 files | 0.0024s | 0.0031s | 0.8x |
| sha224sum | single 1MB text | 0.0020s | 0.0017s | **1.2x** |
| sha224sum | single 10MB text | 0.0084s | 0.0083s | **1.0x** |
| sha224sum | single 10MB binary | 0.0088s | 0.0086s | **1.0x** |
| sha256sum | single 100KB text | 0.0013s | 0.0011s | **1.2x** |
| sha256sum | single 1MB text | 0.0019s | 0.0017s | **1.1x** |
| sha256sum | single 10MB text | 0.0086s | 0.0086s | **1.0x** |
| sha256sum | single 10MB binary | 0.0092s | 0.0088s | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0025s | 0.5x |
| sha256sum | 100 files | 0.0024s | 0.0031s | 0.8x |
| sha384sum | single 1MB text | 0.0027s | 0.0039s | 0.7x |
| sha384sum | single 10MB text | 0.0160s | 0.0170s | 0.9x |
| sha384sum | single 10MB binary | 0.0165s | 0.0179s | 0.9x |
| sha512sum | single 1MB text | 0.0027s | 0.0041s | 0.7x |
| sha512sum | single 10MB text | 0.0162s | 0.0174s | 0.9x |
| sha512sum | single 10MB binary | 0.0164s | 0.0175s | 0.9x |
| shred | shred 1MB file | 0.0124s | 0.0067s | **1.9x** |
| shred | shred 1MB file with remove (-u) | 0.0208s | 0.0084s | **2.5x** |
| shuf | shuf 1MB text | 0.0030s | 0.0016s | **1.9x** |
| shuf | shuf 10MB text | 0.0197s | 0.0062s | **3.2x** |
| shuf | -n 100 from 10MB | 0.0215s | 0.0057s | **3.8x** |
| shuf | -n 10000 from 10MB | 0.0213s | 0.0055s | **3.9x** |
| shuf | -i 1-1000000 | 0.0706s | 0.0138s | **5.1x** |
| shuf | -i 1-1000000 -n 100 | 0.0009s | 0.0009s | 0.9x |
| sleep | sleep 0 (startup overhead) | 0.0009s | 0.0009s | **1.0x** |
| sleep | sleep 0.001 (tiny sleep) | 0.0019s | 0.0020s | **1.0x** |
| sort | lexicographic 1MB | 0.0126s | 0.0044s | **2.9x** |
| sort | lexicographic 10MB random | 0.0721s | 0.0104s | **6.9x** |
| sort | already sorted 10MB | 0.0339s | 0.0052s | **6.5x** |
| sort | reverse sorted 10MB | 0.0287s | 0.0072s | **4.0x** |
| sort | -n numeric 10MB | 0.0779s | 0.0059s | **13.1x** |
| sort | -r reverse 10MB | 0.0553s | 0.0099s | **5.6x** |
| sort | -u unique 10MB | 0.0609s | 0.0109s | **5.6x** |
| sort | -t, -k2 CSV 10MB | 0.0680s | 0.0411s | **1.7x** |
| sort | repetitive 10MB | 0.0552s | 0.0130s | **4.3x** |
| sort | --parallel=4 10MB | 0.0542s | 0.0093s | **5.8x** |
| split | split 10MB into 1MB chunks (-b 1m) | 0.0112s | 0.0083s | **1.3x** |
| split | split 10MB by 1000 lines (-l 1000) | 0.0186s | 0.0172s | **1.1x** |
| stat | stat single file | 0.0012s | 0.0011s | **1.1x** |
| stat | 100 files | 0.0043s | 0.0043s | **1.0x** |
| stat | --format=%s (size only) | 0.0010s | 0.0010s | **1.1x** |
| stat | --format='%n %s %Y' | 0.0010s | 0.0009s | **1.1x** |
| stat | -f (filesystem) | 0.0011s | 0.0009s | **1.1x** |
| stdbuf | -oL cat 1MB | 0.0018s | 0.0020s | 0.9x |
| stdbuf | -o0 cat 100KB | 0.0018s | 0.0020s | 0.9x |
| sum | single 1MB text | 0.0025s | 0.0023s | **1.1x** |
| sum | single 10MB text | 0.0175s | 0.0145s | **1.2x** |
| sum | single 10MB binary | 0.0183s | 0.0151s | **1.2x** |
| sync | sync (no args) | 0.0011s | 0.0011s | **1.0x** |
| tac | reverse 100KB text | 0.0009s | 0.0011s | 0.8x |
| tac | reverse 1MB text | 0.0020s | 0.0015s | **1.4x** |
| tac | reverse 10MB text | 0.0106s | 0.0046s | **2.3x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0049s | **2.0x** |
| tac | reverse repetitive 10MB | 0.0232s | 0.0082s | **2.8x** |
| tac | custom separator 1MB | 0.0059s | 0.0042s | **1.4x** |
| tail | default 1MB text | 0.0008s | 0.0012s | 0.7x |
| tail | default 10MB text | 0.0009s | 0.0012s | 0.7x |
| tail | -n 1000 10MB | 0.0008s | 0.0010s | 0.7x |
| tail | -n 100000 10MB | 0.0070s | 0.0037s | **1.9x** |
| tail | -n +100 10MB (from line 100) | 0.0039s | 0.0020s | **1.9x** |
| tail | -n +100000 10MB (from line 100000) | 0.0039s | 0.0036s | **1.1x** |
| tail | -c 1000000 10MB | 0.0012s | 0.0012s | **1.0x** |
| tail | 100 small files | 0.0018s | 0.0022s | 0.8x |
| tee | tee 1MB to /dev/null | 0.0017s | 0.0016s | **1.0x** |
| tee | tee 10MB to /dev/null | 0.0072s | 0.0066s | **1.1x** |
| test | test -f (file exists) | 0.0008s | 0.0010s | 0.9x |
| test | test 1 -eq 1 | 0.0009s | 0.0009s | **1.0x** |
| test | test 'hello' = 'hello' | 0.0009s | 0.0010s | 0.9x |
| test | test -d /tmp | 0.0009s | 0.0010s | 0.9x |
| timeout | timeout 10 true | 0.0015s | 0.0016s | 0.9x |
| timeout | timeout 10 echo hello | 0.0018s | 0.0020s | 0.9x |
| touch | create new file | 0.0028s | 0.0021s | **1.3x** |
| touch | update existing file timestamp | 0.0008s | 0.0009s | 0.9x |
| touch | set specific timestamp (-t) | 0.0018s | 0.0020s | 0.9x |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | **1.4x** |
| tr | a-z to A-Z 10MB | 0.0168s | 0.0049s | **3.4x** |
| tr | -d digits 10MB | 0.0217s | 0.0051s | **4.3x** |
| tr | -d lowercase 10MB | 0.0294s | 0.0062s | **4.7x** |
| tr | -s spaces 10MB | 0.0277s | 0.0039s | **7.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0135s | 0.0040s | **3.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0173s | 0.0049s | **3.5x** |
| tr | translate binary 10MB | 0.0123s | 0.0041s | **3.0x** |
| true | true (startup overhead) | 0.0005s | 0.0007s | 0.7x |
| truncate | truncate to zero (-s 0) | 0.0031s | 0.0031s | **1.0x** |
| truncate | create 1M file (-s 1M) | 0.0017s | 0.0019s | 0.9x |
| tsort | tsort 100K pairs | 0.0592s | 0.0084s | **7.1x** |
| tsort | tsort 1M pairs | 0.6498s | 0.0643s | **10.1x** |
| tty | tty (no args) | 0.0009s | 0.0009s | 0.9x |
| uname | uname (no args) | 0.0006s | 0.0008s | 0.7x |
| uname | uname -a | 0.0006s | 0.0007s | 0.8x |
| uname | uname -r | 0.0006s | 0.0008s | 0.8x |
| uname | uname -m | 0.0006s | 0.0008s | 0.7x |
| unexpand | unexpand 1MB text | 0.0031s | 0.0012s | **2.6x** |
| unexpand | unexpand 10MB text | 0.0228s | 0.0025s | **9.3x** |
| unexpand | -a 1MB text | 0.0093s | 0.0013s | **7.2x** |
| unexpand | -a 10MB text | 0.0833s | 0.0021s | **40.3x** |
| unexpand | -t 4 10MB text | 0.0836s | 0.0026s | **32.6x** |
| unexpand | expand|unexpand pipeline 10MB | 0.1120s | 0.0763s | **1.5x** |
| uniq | default 10MB many duplicates | 0.0129s | 0.0019s | **6.7x** |
| uniq | default 10MB sorted (low dup) | 0.0140s | 0.0031s | **4.5x** |
| uniq | -c count 10MB many dups | 0.0122s | 0.0020s | **6.1x** |
| uniq | -c count 10MB sorted | 0.0297s | 0.0076s | **3.9x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0019s | **6.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | **6.5x** |
| uniq | -i case insensitive 10MB | 0.0140s | 0.0044s | **3.2x** |
| uniq | repetitive 10MB | 0.0426s | 0.0035s | **12.3x** |
| unlink | unlink a file | 0.0021s | 0.0027s | 0.8x |
| uptime | uptime (default) | 0.0024s | 0.0012s | **2.0x** |
| uptime | uptime -s (since) | 0.0021s | 0.0008s | **2.7x** |
| users | users (default) | 0.0009s | 0.0010s | 0.9x |
| vdir | vdir current directory | 0.0014s | 0.0015s | 0.9x |
| vdir | 100 files directory | 0.0019s | 0.0019s | **1.0x** |
| vdir | -R test data | 0.0021s | 0.0019s | **1.1x** |
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0084s | 0.0058s | **1.5x** |
| wc | default 10MB text | 0.0570s | 0.0031s | **18.3x** |
| wc | -l 10MB text | 0.0019s | 0.0019s | **1.0x** |
| wc | -w 10MB text | 0.0544s | 0.0135s | **4.0x** |
| wc | -c 10MB text | 0.0009s | 0.0009s | 0.9x |
| wc | -m 10MB text | 0.0554s | 0.0025s | **21.9x** |
| wc | -L 10MB text | 0.0543s | 0.0094s | **5.8x** |
| wc | default 10MB binary | 0.3176s | 0.0303s | **10.5x** |
| wc | default 10MB repetitive | 0.0750s | 0.0038s | **19.8x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0018s | **1.1x** |
| who | who (default) | 0.0009s | 0.0010s | 0.9x |
| who | who -a (all) | 0.0009s | 0.0011s | 0.9x |
| who | who -b (boot) | 0.0009s | 0.0011s | 0.8x |
| whoami | whoami (no args) | 0.0009s | 0.0010s | 0.9x |
| yes | throughput 1M lines | 0.0035s | 0.0032s | **1.1x** |
| yes | throughput 10M lines | 0.0273s | 0.0324s | 0.8x |
| yes | throughput hello 1M lines | 0.0064s | 0.0071s | 0.9x |
| yes | throughput hello 10M lines | 0.0570s | 0.0535s | **1.1x** |
| yes | throughput 100MB | 0.0465s | 0.0463s | **1.0x** |

## Assembly (x86-64 nasm)

### Assembly GNU Compatibility

| Tool | Binary | Total | Passed | Failed | Rate |
|------|--------|------:|-------:|-------:|-----:|
| arch | farch | 12 | 12 | 0 | 100% |
| base64 | fbase64 | 0 | 0 | 0 | - |
| cat | fcat | 0 | 0 | 0 | - |
| cut | fcut | 0 | 0 | 0 | - |
| echo | fecho | 0 | 0 | 0 | - |
| expand | fexpand | 0 | 0 | 0 | - |
| false | ffalse | 0 | 0 | 0 | - |
| fold | ffold | 0 | 0 | 0 | - |
| head | fhead | 0 | 0 | 0 | - |
| hostid | fhostid | 0 | 0 | 0 | - |
| logname | flogname | 0 | 0 | 0 | - |
| md5sum | fmd5sum | 0 | 0 | 0 | - |
| nl | fnl | 0 | 0 | 0 | - |
| od | fod | 0 | 0 | 0 | - |
| pwd | fpwd | 0 | 0 | 0 | - |
| rev | frev | 0 | 0 | 0 | - |
| seq | fseq | 0 | 0 | 0 | - |
| sleep | fsleep | 0 | 0 | 0 | - |
| sort | fsort | 0 | 0 | 0 | - |
| sync | fsync | 0 | 0 | 0 | - |
| tac | ftac | 0 | 0 | 0 | - |
| tail | ftail | 0 | 0 | 0 | - |
| tr | ftr | 0 | 0 | 0 | - |
| true | ftrue | 0 | 0 | 0 | - |
| tty | ftty | 0 | 0 | 0 | - |
| unexpand | funexpand | 0 | 0 | 0 | - |
| uniq | funiq | 0 | 0 | 0 | - |
| wc | fwc | 0 | 0 | 0 | - |
| whoami | fwhoami | 0 | 0 | 0 | - |
| yes | fyes | 0 | 0 | 0 | - |

### Assembly Security Tests

| Tool | Total | Passed | Failed | Skipped | Rate |
|------|------:|-------:|-------:|--------:|-----:|
| arch | 77 | 75 | 0 | 2 | 97% |
| base64 | 0 | 0 | 0 | 0 | - |
| cat | 0 | 0 | 0 | 0 | - |
| cut | 0 | 0 | 0 | 0 | - |
| echo | 0 | 0 | 0 | 0 | - |
| expand | 0 | 0 | 0 | 0 | - |
| false | 0 | 0 | 0 | 0 | - |
| fold | 0 | 0 | 0 | 0 | - |
| head | 0 | 0 | 0 | 0 | - |
| hostid | 0 | 0 | 0 | 0 | - |
| logname | 0 | 0 | 0 | 0 | - |
| md5sum | 0 | 0 | 0 | 0 | - |
| nl | 0 | 0 | 0 | 0 | - |
| od | 0 | 0 | 0 | 0 | - |
| pwd | 0 | 0 | 0 | 0 | - |
| rev | 0 | 0 | 0 | 0 | - |
| seq | 0 | 0 | 0 | 0 | - |
| sleep | 0 | 0 | 0 | 0 | - |
| sort | 0 | 0 | 0 | 0 | - |
| sync | 0 | 0 | 0 | 0 | - |
| tac | 0 | 0 | 0 | 0 | - |
| tail | 0 | 0 | 0 | 0 | - |
| tr | 0 | 0 | 0 | 0 | - |
| true | 0 | 0 | 0 | 0 | - |
| tty | 0 | 0 | 0 | 0 | - |
| unexpand | 0 | 0 | 0 | 0 | - |
| uniq | 0 | 0 | 0 | 0 | - |
| wc | 0 | 0 | 0 | 0 | - |
| whoami | 0 | 0 | 0 | 0 | - |
| yes | 0 | 0 | 0 | 0 | - |

### Assembly Performance (3-way: GNU vs Rust vs ASM)

| Tool | Test | GNU (mean) | Rust (mean) | ASM (mean) | ASM vs GNU | ASM vs Rust |
|------|------|----------:|-----------:|-----------:|-----------:|------------:|
| yes | 1M lines | 0.0031s | 0.0031s | 0.0032s | **1.0x** | **1.0x** |

### Assembly Binary Sizes

| Tool | ASM Binary | GNU Binary | Size Ratio |
|------|----------:|-----------:|-----------:|
| arch | 13.5 KB | 34.5 KB | 0.391x |
| yes | 1.8 KB | 34.4 KB | 0.051x |
