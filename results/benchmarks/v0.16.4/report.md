# fcoreutils v0.16.4 — Detailed Results

Generated: 2026-03-02 13:26:49 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|------:|-------:|-------:|----------:|
| Darwin_arm64 | 804 | 651 | 123 | 81.0% |
| Linux_aarch64 | 804 | 656 | 118 | 81.6% |
| Linux_x86_64 | 3911 | 3798 | 5 | 97.1% |
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
| cat | 49 | 47 | 2 | 96% |
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
| fold | 58 | 54 | 4 | 93% |
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
| nl | 62 | 60 | 2 | 97% |
| nohup | 11 | 11 | 0 | 100% |
| nproc | 31 | 29 | 2 | 94% |
| numfmt | 33 | 31 | 2 | 94% |
| od | 50 | 50 | 0 | 100% |
| paste | 32 | 30 | 2 | 94% |
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
| arch | arch (no args) | 0.0009s | 0.0010s | 0.9x |
| b2sum | single 100KB text | 0.0010s | 0.0011s | 0.9x |
| b2sum | single 1MB text | 0.0023s | 0.0021s | **1.1x** |
| b2sum | single 10MB text | 0.0150s | 0.0124s | **1.2x** |
| b2sum | single 10MB binary | 0.0158s | 0.0129s | **1.2x** |
| b2sum | -l 256 10MB | 0.0150s | 0.0126s | **1.2x** |
| b2sum | -l 128 10MB | 0.0152s | 0.0125s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0022s | **1.0x** |
| base32 | encode 100KB text | 0.0011s | 0.0012s | **1.0x** |
| base32 | encode 1MB text | 0.0022s | 0.0021s | **1.0x** |
| base32 | encode 10MB text | 0.0150s | 0.0133s | **1.1x** |
| base32 | encode 10MB binary | 0.0155s | 0.0111s | **1.4x** |
| base32 | decode 1MB | 0.0035s | 0.0027s | **1.3x** |
| base32 | decode 10MB | 0.0285s | 0.0171s | **1.7x** |
| base64 | encode 100KB text | 0.0007s | 0.0008s | 0.9x |
| base64 | encode 1MB text | 0.0016s | 0.0011s | **1.5x** |
| base64 | encode 10MB text | 0.0104s | 0.0050s | **2.1x** |
| base64 | encode 10MB binary | 0.0105s | 0.0044s | **2.4x** |
| base64 | decode 1MB | 0.0035s | 0.0019s | **1.9x** |
| base64 | decode 10MB | 0.0307s | 0.0043s | **7.2x** |
| base64 | encode -w 76 10MB | 0.0101s | 0.0044s | **2.3x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0080s | 0.0028s | **2.9x** |
| basename | basename simple path | 0.0008s | 0.0009s | 0.9x |
| basename | basename with suffix (.txt) | 0.0008s | 0.0010s | 0.8x |
| basenc | encode --base64 1MB | 0.0020s | 0.0013s | **1.5x** |
| basenc | encode --base64 10MB | 0.0127s | 0.0056s | **2.3x** |
| basenc | encode --base32 1MB | 0.0023s | 0.0022s | **1.0x** |
| basenc | encode --base16 1MB | 0.0024s | 0.0027s | 0.9x |
| basenc | decode --base64 -d 1MB | 0.0041s | 0.0035s | **1.2x** |
| cat | passthrough 1MB | 0.0009s | 0.0014s | 0.7x |
| cat | passthrough 10MB | 0.0015s | 0.0020s | 0.8x |
| cat | -n 1MB | 0.0020s | 0.0019s | **1.0x** |
| cat | -n 10MB | 0.0102s | 0.0068s | **1.5x** |
| cat | -b 10MB | 0.0114s | 0.0060s | **1.9x** |
| cat | -A 1MB | 0.0019s | 0.0018s | **1.1x** |
| cat | 100 small files | 0.0028s | 0.0031s | 0.9x |
| cat | binary 10MB | 0.0015s | 0.0018s | 0.8x |
| chgrp | chgrp current group on file | 0.0022s | 0.0024s | 0.9x |
| chgrp | chgrp current group on 1MB file | 0.0030s | 0.0031s | **1.0x** |
| chown | chown current user on file | 0.0022s | 0.0024s | 0.9x |
| chown | chown current user on 1MB file | 0.0031s | 0.0033s | **1.0x** |
| cksum | single 1MB text | 0.0015s | 0.0011s | **1.4x** |
| cksum | single 10MB text | 0.0029s | 0.0025s | **1.1x** |
| cksum | single 10MB binary | 0.0028s | 0.0024s | **1.2x** |
| comm | default 10MB sorted | 0.0244s | 0.0065s | **3.7x** |
| comm | -12 (common only) 10MB | 0.0208s | 0.0051s | **4.1x** |
| comm | -23 (unique to file1) 10MB | 0.0214s | 0.0056s | **3.8x** |
| comm | -3 10MB | 0.0232s | 0.0063s | **3.7x** |
| comm | identical 10MB sorted | 0.0301s | 0.0080s | **3.8x** |
| cp | cp small file (1KB) | 0.0020s | 0.0019s | **1.0x** |
| cp | cp medium file (1MB) | 0.0028s | 0.0027s | **1.1x** |
| cp | cp large file (10MB) | 0.0103s | 0.0107s | **1.0x** |
| cp | cp -r many small files (100 files) | 0.0072s | 0.0064s | **1.1x** |
| cp | cp -r deep directory (8 levels) | 0.0031s | 0.0029s | **1.1x** |
| cut | -b1-100 10MB CSV | 0.0244s | 0.0035s | **7.0x** |
| cut | -c1-100 10MB CSV | 0.0294s | 0.0035s | **8.4x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0098s | **1.7x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0219s | 0.0104s | **2.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0240s | 0.0096s | **2.5x** |
| cut | --complement -d, -f1 10MB CSV | 0.0303s | 0.0101s | **3.0x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0010s | 0.9x |
| cut | -d, -f1 1MB text | 0.0033s | 0.0025s | **1.3x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0010s | 0.9x |
| date | date (default) | 0.0009s | 0.0011s | 0.9x |
| date | +%Y-%m-%d %H:%M:%S | 0.0009s | 0.0011s | 0.9x |
| date | +%s (epoch) | 0.0009s | 0.0010s | 0.9x |
| date | ISO 8601 format | 0.0010s | 0.0010s | **1.0x** |
| date | RFC 3339 | 0.0009s | 0.0010s | 0.9x |
| date | -u (UTC) | 0.0009s | 0.0010s | 0.9x |
| dd | dd read 10MB (bs=4096) | 0.0023s | 0.0023s | **1.0x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0068s | 0.0088s | 0.8x |
| df | df (default) | 0.0013s | 0.0011s | **1.2x** |
| df | -h (human readable) | 0.0013s | 0.0011s | **1.1x** |
| df | df / | 0.0010s | 0.0011s | 0.9x |
| df | -i (inodes) | 0.0013s | 0.0012s | **1.1x** |
| dir | dir current directory | 0.0008s | 0.0010s | 0.8x |
| dir | 100 files directory | 0.0008s | 0.0013s | 0.6x |
| dir | -la 100 files | 0.0012s | 0.0014s | 0.9x |
| dir | -R test data | 0.0009s | 0.0013s | 0.7x |
| dircolors | dircolors -b (default) | 0.0010s | 0.0011s | 0.9x |
| dircolors | dircolors -c (csh) | 0.0009s | 0.0011s | 0.9x |
| dircolors | dircolors -p (print) | 0.0008s | 0.0011s | 0.8x |
| dircolors | custom db file | 0.0009s | 0.0010s | 0.9x |
| dirname | dirname simple path | 0.0008s | 0.0010s | 0.9x |
| dirname | dirname deep path | 0.0009s | 0.0011s | 0.8x |
| du | du test data dir | 0.0009s | 0.0010s | 0.8x |
| du | -s (summary) | 0.0009s | 0.0010s | 0.8x |
| du | -sh (human summary) | 0.0009s | 0.0011s | 0.8x |
| du | --max-depth=1 | 0.0009s | 0.0011s | 0.8x |
| du | -b (bytes) | 0.0009s | 0.0011s | 0.8x |
| echo | echo hello | 0.0009s | 0.0010s | 0.8x |
| echo | echo -n hello | 0.0009s | 0.0010s | 0.9x |
| echo | echo -e with escapes | 0.0009s | 0.0010s | 0.8x |
| env | print all env vars | 0.0010s | 0.0010s | **1.0x** |
| env | env true (run command) | 0.0014s | 0.0021s | 0.7x |
| env | env VAR=value true | 0.0013s | 0.0015s | 0.9x |
| expand | expand 10MB tabbed (default) | 0.0455s | 0.0334s | **1.4x** |
| expand | expand 1MB text | 0.0033s | 0.0011s | **3.1x** |
| expand | -t 4 10MB tabbed | 0.0420s | 0.0333s | **1.3x** |
| expand | -t 2 10MB tabbed | 0.0359s | 0.0331s | **1.1x** |
| expand | --initial 10MB tabbed | 0.0237s | 0.0068s | **3.5x** |
| expand | expand CSV 10MB | 0.0195s | 0.0019s | **10.5x** |
| expr | expr 1 + 1 | 0.0009s | 0.0010s | 0.9x |
| expr | expr 999999 * 999999 | 0.0009s | 0.0011s | 0.8x |
| expr | expr length 'hello world' | 0.0009s | 0.0011s | 0.9x |
| expr | expr 'hello' : 'hel' | 0.0009s | 0.0011s | 0.8x |
| factor | factor 1234567890 | 0.0009s | 0.0010s | 0.9x |
| factor | factor 999999999999999989 (large prime) | 0.0009s | 0.0013s | 0.7x |
| factor | factor 1-100000 via stdin | 0.0255s | 0.0153s | **1.7x** |
| false | false (startup overhead) | 0.0000s | 0.0007s | 0.0x |
| fmt | fmt 1MB text | 0.0175s | 0.0212s | 0.8x |
| fmt | fmt 10MB text | 0.1439s | 0.1519s | 0.9x |
| fmt | -w 40 10MB | 0.1227s | 0.1085s | **1.1x** |
| fmt | -w 120 10MB | 0.1750s | 0.2081s | 0.8x |
| fmt | fmt wide lines 10MB | 0.1673s | 0.1930s | 0.9x |
| fold | fold 10MB wide lines (default) | 0.0351s | 0.0061s | **5.7x** |
| fold | fold 1MB text | 0.0042s | 0.0016s | **2.7x** |
| fold | fold 10MB text | 0.0348s | 0.0068s | **5.1x** |
| fold | -w 40 10MB | 0.0353s | 0.0062s | **5.7x** |
| fold | -w 20 10MB | 0.0361s | 0.0073s | **4.9x** |
| fold | -s -w 60 10MB | 0.0378s | 0.0066s | **5.7x** |
| fold | -s -w 40 10MB | 0.0411s | 0.0074s | **5.6x** |
| fold | -b -w 40 10MB | 0.0333s | 0.0064s | **5.2x** |
| groups | groups (no args) | 0.0010s | 0.0011s | 0.9x |
| head | default 1MB text | 0.0006s | 0.0010s | 0.6x |
| head | default 10MB text | 0.0006s | 0.0009s | 0.7x |
| head | -n 1000 10MB | 0.0007s | 0.0009s | 0.8x |
| head | -n 100000 10MB | 0.0056s | 0.0028s | **2.0x** |
| head | -c 1000000 10MB | 0.0007s | 0.0009s | 0.8x |
| head | -n -100 10MB (all but last 100) | 0.0019s | 0.0013s | **1.4x** |
| head | 100 small files | 0.0009s | 0.0013s | 0.7x |
| hostid | hostid (no args) | 0.0009s | 0.0010s | 0.9x |
| id | id (no args) | 0.0008s | 0.0009s | 0.9x |
| id | id -u | 0.0008s | 0.0008s | 0.9x |
| id | id -g | 0.0007s | 0.0007s | 0.9x |
| id | id -un | 0.0008s | 0.0008s | 0.9x |
| install | install 1MB file | 0.0020s | 0.0022s | 0.9x |
| install | install -d create directory | 0.0017s | 0.0019s | 0.9x |
| join | default join 10MB | - | - | - |
| join | outer join 10MB | - | - | - |
| join | -v 1 (unmatched from file1) 10MB | - | - | - |
| join | -o 0,1.2,2.2 10MB | - | - | - |
| join | self-join sorted 10MB | 0.0470s | 0.0379s | **1.2x** |
| kill | kill -l (list signals) | 0.0000s | 0.0011s | 0.0x |
| link | hard link a file | 0.0017s | 0.0018s | 0.9x |
| ln | symlink single file | 0.0017s | 0.0019s | 0.9x |
| ln | symlink force overwrite (-sf) | 0.0017s | 0.0019s | 0.9x |
| ln | hard link single file | 0.0018s | 0.0019s | **1.0x** |
| logname | logname (no args) | 0.0009s | 0.0009s | 0.9x |
| ls | ls current directory | 0.0011s | 0.0012s | 0.9x |
| ls | 100 files | 0.0011s | 0.0015s | 0.7x |
| ls | -la 100 files | 0.0031s | 0.0029s | **1.1x** |
| ls | -la test data dir | 0.0022s | 0.0020s | **1.1x** |
| ls | -R test data | 0.0017s | 0.0022s | 0.8x |
| ls | -lt 100 files | 0.0019s | 0.0018s | **1.1x** |
| ls | -lS test data dir | 0.0032s | 0.0020s | **1.6x** |
| md5sum | single 100KB text | 0.0014s | 0.0011s | **1.2x** |
| md5sum | single 1MB text | 0.0028s | 0.0029s | **1.0x** |
| md5sum | single 10MB text | 0.0171s | 0.0205s | 0.8x |
| md5sum | single 10MB binary | 0.0179s | 0.0215s | 0.8x |
| md5sum | 10 files | 0.0013s | 0.0011s | **1.2x** |
| md5sum | 100 files | 0.0024s | 0.0017s | **1.4x** |
| mkdir | mkdir single directory | 0.0019s | 0.0018s | **1.0x** |
| mkdir | mkdir -p nested directories | 0.0023s | 0.0023s | **1.0x** |
| mkfifo | mkfifo single fifo | 0.0018s | 0.0018s | **1.0x** |
| mknod | mknod named pipe | 0.0019s | 0.0018s | **1.0x** |
| mktemp | mktemp default | 0.0019s | 0.0020s | 0.9x |
| mktemp | mktemp -d directory | 0.0019s | 0.0020s | **1.0x** |
| mv | mv same-fs small (1MB) | 0.0032s | 0.0030s | **1.1x** |
| mv | mv same-fs large (10MB) | 0.0082s | 0.0083s | **1.0x** |
| mv | mv many files (100 files) | - | 0.0066s | - |
| nice | nice true (default priority) | 0.0010s | 0.0011s | 0.9x |
| nice | nice -n 10 true | 0.0009s | 0.0011s | 0.9x |
| nl | default 1MB | 0.0044s | 0.0017s | **2.7x** |
| nl | default 10MB | 0.0331s | 0.0070s | **4.7x** |
| nl | -b a 10MB | 0.0327s | 0.0070s | **4.7x** |
| nl | -b a 10MB with blanks | 0.0425s | 0.0092s | **4.6x** |
| nl | -b a -n rz 10MB | 0.0329s | 0.0064s | **5.2x** |
| nl | -b a -w 8 -s ': ' 10MB | 0.0328s | 0.0069s | **4.7x** |
| nl | -b p'^the' 10MB | 0.0580s | 0.0120s | **4.8x** |
| nohup | nohup true | 0.0022s | 0.0022s | **1.0x** |
| nproc | nproc (no args) | 0.0008s | 0.0010s | 0.8x |
| nproc | nproc --all | 0.0009s | 0.0010s | 0.9x |
| numfmt | --to=iec single value | 0.0008s | 0.0010s | 0.8x |
| numfmt | --from=iec single value | 0.0009s | 0.0011s | 0.8x |
| numfmt | --to=si from CSV column | 0.0210s | 0.0239s | 0.9x |
| od | default 1MB text | 0.0680s | 0.0096s | **7.1x** |
| od | -A x -t x1z 1MB | 0.1186s | 0.0168s | **7.1x** |
| od | -c 1MB text | 0.1191s | 0.0112s | **10.6x** |
| od | default 10MB binary | 0.6688s | 0.0888s | **7.5x** |
| od | -N 10000 10MB | 0.0022s | 0.0020s | **1.1x** |
| paste | 2 columns 10MB | 0.0238s | 0.0140s | **1.7x** |
| paste | 3 columns 10MB | 0.0307s | 0.0192s | **1.6x** |
| paste | -d comma 10MB | 0.0236s | 0.0133s | **1.8x** |
| paste | -s 10MB single file | 0.0106s | 0.0066s | **1.6x** |
| paste | stdin split 2-way 10MB | 0.0309s | 0.0177s | **1.7x** |
| pathchk | pathchk default | 0.0008s | 0.0010s | 0.8x |
| pathchk | pathchk -p (POSIX portable) | 0.0009s | 0.0010s | 0.9x |
| pinky | pinky (default) | 0.0009s | 0.0011s | 0.8x |
| pinky | pinky -l | - | - | - |
| pr | pr 1MB text | 0.0102s | 0.0024s | **4.2x** |
| pr | -2 (two columns) 1MB | 0.0121s | 0.0026s | **4.7x** |
| pr | -3 (three columns) 1MB | 0.0085s | 0.0023s | **3.6x** |
| pr | -n 1MB text | 0.0117s | 0.0027s | **4.4x** |
| pr | -t 1MB text | 0.0100s | 0.0023s | **4.3x** |
| printenv | printenv (all) | 0.0008s | 0.0011s | 0.7x |
| printenv | printenv HOME | 0.0008s | 0.0010s | 0.8x |
| printenv | printenv PATH | 0.0009s | 0.0010s | 0.9x |
| printf | simple string | 0.0008s | 0.0011s | 0.8x |
| printf | integer formatting | 0.0009s | 0.0011s | 0.8x |
| printf | float formatting | 0.0009s | 0.0011s | 0.8x |
| printf | string padding | 0.0008s | 0.0011s | 0.7x |
| ptx | ptx 10KB text | 0.0021s | 0.0017s | **1.2x** |
| ptx | ptx 100KB text | 0.0116s | 0.0061s | **1.9x** |
| ptx | -w 60 100KB text | 0.0105s | 0.0056s | **1.9x** |
| pwd | pwd (no args) | 0.0000s | 0.0009s | 0.0x |
| pwd | pwd -L | 0.0000s | 0.0013s | 0.0x |
| pwd | pwd -P | 0.0002s | 0.0011s | 0.2x |
| readlink | readlink symlink | 0.0008s | 0.0009s | 0.9x |
| readlink | readlink -f (canonicalize) | 0.0009s | 0.0010s | 0.9x |
| realpath | realpath . | 0.0009s | 0.0010s | 0.9x |
| realpath | realpath /tmp | 0.0008s | 0.0010s | 0.8x |
| realpath | realpath test data file | 0.0009s | 0.0009s | **1.0x** |
| rev | reverse 100KB text | 0.0023s | 0.0010s | **2.3x** |
| rev | reverse 1MB text | 0.0152s | 0.0020s | **7.6x** |
| rev | reverse 10MB text | 0.1378s | 0.0075s | **18.4x** |
| rev | reverse CSV 10MB | 0.1000s | 0.0071s | **14.1x** |
| rev | reverse repetitive 10MB | 0.2867s | 0.0123s | **23.3x** |
| rev | reverse 10KB single line | 0.0010s | 0.0009s | **1.1x** |
| rm | rm single file | 0.0022s | 0.0023s | 0.9x |
| rm | rm -rf directory | 0.0096s | 0.0118s | 0.8x |
| rmdir | rmdir single empty directory | 0.0019s | 0.0020s | **1.0x** |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0105s | 0.0025s | **4.1x** |
| seq | seq 1 10000000 | 0.0963s | 0.0141s | **6.9x** |
| seq | seq 0 0.1 100000 (float) | 0.2335s | 0.0190s | **12.3x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2434s | 0.0174s | **14.0x** |
| sha1sum | single 1MB text | 0.0019s | 0.0034s | 0.6x |
| sha1sum | single 10MB text | 0.0081s | 0.0250s | 0.3x |
| sha1sum | single 10MB binary | 0.0082s | 0.0258s | 0.3x |
| sha1sum | 100 files | 0.0023s | 0.0016s | **1.4x** |
| sha224sum | single 1MB text | 0.0020s | 0.0017s | **1.1x** |
| sha224sum | single 10MB text | 0.0083s | 0.0085s | **1.0x** |
| sha224sum | single 10MB binary | 0.0089s | 0.0088s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0012s | **1.2x** |
| sha256sum | single 1MB text | 0.0020s | 0.0024s | 0.8x |
| sha256sum | single 10MB text | 0.0088s | 0.0090s | **1.0x** |
| sha256sum | single 10MB binary | 0.0093s | 0.0097s | **1.0x** |
| sha256sum | 10 files | 0.0017s | 0.0011s | **1.6x** |
| sha256sum | 100 files | 0.0026s | 0.0017s | **1.6x** |
| sha384sum | single 1MB text | 0.0027s | 0.0030s | 0.9x |
| sha384sum | single 10MB text | 0.0153s | 0.0207s | 0.7x |
| sha384sum | single 10MB binary | 0.0163s | 0.0218s | 0.7x |
| sha512sum | single 1MB text | 0.0026s | 0.0030s | 0.9x |
| sha512sum | single 10MB text | 0.0153s | 0.0209s | 0.7x |
| sha512sum | single 10MB binary | 0.0161s | 0.0228s | 0.7x |
| shred | shred 1MB file | 0.0092s | 0.0064s | **1.4x** |
| shred | shred 1MB file with remove (-u) | 0.0173s | 0.0075s | **2.3x** |
| shuf | shuf 1MB text | 0.0030s | 0.0022s | **1.3x** |
| shuf | shuf 10MB text | 0.0164s | 0.0119s | **1.4x** |
| shuf | -n 100 from 10MB | 0.0185s | 0.0089s | **2.1x** |
| shuf | -n 10000 from 10MB | 0.0210s | 0.0102s | **2.1x** |
| shuf | -i 1-1000000 | 0.0700s | 0.0221s | **3.2x** |
| shuf | -i 1-1000000 -n 100 | 0.0009s | 0.0010s | 0.9x |
| sleep | sleep 0 (startup overhead) | 0.0009s | 0.0010s | 0.9x |
| sleep | sleep 0.001 (tiny sleep) | 0.0019s | 0.0020s | 0.9x |
| sort | lexicographic 1MB | 0.0088s | 0.0041s | **2.2x** |
| sort | lexicographic 10MB random | 0.0579s | 0.0088s | **6.5x** |
| sort | already sorted 10MB | 0.0248s | 0.0046s | **5.4x** |
| sort | reverse sorted 10MB | 0.0261s | 0.0063s | **4.1x** |
| sort | -n numeric 10MB | 0.0750s | 0.0053s | **14.1x** |
| sort | -r reverse 10MB | 0.0559s | 0.0088s | **6.4x** |
| sort | -u unique 10MB | 0.0601s | 0.0090s | **6.7x** |
| sort | -t, -k2 CSV 10MB | 0.0685s | 0.0370s | **1.8x** |
| sort | repetitive 10MB | 0.0467s | 0.0124s | **3.8x** |
| sort | --parallel=4 10MB | 0.0555s | 0.0090s | **6.2x** |
| split | split 10MB into 1MB chunks (-b 1m) | - | - | - |
| split | split 10MB by 1000 lines (-l 1000) | 0.0171s | 0.0178s | **1.0x** |
| stat | stat single file | 0.0012s | 0.0011s | **1.0x** |
| stat | 100 files | 0.0042s | 0.0044s | **1.0x** |
| stat | --format=%s (size only) | 0.0010s | 0.0009s | **1.1x** |
| stat | --format='%n %s %Y' | 0.0010s | 0.0009s | **1.1x** |
| stat | -f (filesystem) | 0.0011s | 0.0010s | **1.1x** |
| stdbuf | -oL cat 1MB | 0.0019s | 0.0021s | 0.9x |
| stdbuf | -o0 cat 100KB | 0.0018s | 0.0021s | 0.8x |
| sum | single 1MB text | 0.0025s | 0.0023s | **1.1x** |
| sum | single 10MB text | 0.0176s | 0.0147s | **1.2x** |
| sum | single 10MB binary | 0.0181s | 0.0150s | **1.2x** |
| sync | sync (no args) | 0.0009s | 0.0010s | 0.9x |
| tac | reverse 100KB text | 0.0007s | 0.0009s | 0.8x |
| tac | reverse 1MB text | 0.0014s | 0.0013s | **1.1x** |
| tac | reverse 10MB text | 0.0083s | 0.0048s | **1.7x** |
| tac | reverse CSV 10MB | 0.0075s | 0.0040s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0151s | 0.0089s | **1.7x** |
| tac | custom separator 1MB | 0.0062s | 0.0035s | **1.8x** |
| tail | default 1MB text | 0.0009s | 0.0011s | 0.8x |
| tail | default 10MB text | 0.0009s | 0.0012s | 0.7x |
| tail | -n 1000 10MB | 0.0009s | 0.0012s | 0.8x |
| tail | -n 100000 10MB | 0.0059s | 0.0034s | **1.8x** |
| tail | -n +100 10MB (from line 100) | 0.0041s | 0.0020s | **2.0x** |
| tail | -n +100000 10MB (from line 100000) | 0.0038s | 0.0032s | **1.2x** |
| tail | -c 1000000 10MB | 0.0012s | 0.0011s | **1.0x** |
| tail | 100 small files | 0.0019s | 0.0025s | 0.7x |
| tee | tee 1MB to /dev/null | 0.0020s | 0.0020s | **1.0x** |
| tee | tee 10MB to /dev/null | 0.0091s | 0.0075s | **1.2x** |
| test | test -f (file exists) | 0.0000s | 0.0010s | 0.0x |
| test | test 1 -eq 1 | 0.0000s | 0.0010s | 0.0x |
| test | test 'hello' = 'hello' | 0.0000s | 0.0009s | 0.0x |
| test | test -d /tmp | 0.0000s | 0.0009s | 0.0x |
| timeout | timeout 10 true | 0.0015s | 0.0017s | 0.9x |
| timeout | timeout 10 echo hello | 0.0019s | 0.0019s | **1.0x** |
| touch | create new file | 0.0017s | 0.0018s | 0.9x |
| touch | update existing file timestamp | 0.0008s | 0.0009s | 0.9x |
| touch | set specific timestamp (-t) | 0.0019s | 0.0020s | 0.9x |
| tr | a-z to A-Z 1MB | 0.0022s | 0.0015s | **1.5x** |
| tr | a-z to A-Z 10MB | 0.0182s | 0.0044s | **4.2x** |
| tr | -d digits 10MB | 0.0171s | 0.0057s | **3.0x** |
| tr | -d lowercase 10MB | 0.0301s | 0.0051s | **5.9x** |
| tr | -s spaces 10MB | 0.0282s | 0.0039s | **7.3x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0137s | 0.0037s | **3.7x** |
| tr | -d [:digit:] 10MB CSV | 0.0177s | 0.0047s | **3.7x** |
| tr | translate binary 10MB | 0.0120s | 0.0038s | **3.2x** |
| true | true (startup overhead) | 0.0000s | 0.0006s | 0.0x |
| truncate | truncate to zero (-s 0) | 0.0052s | 0.0031s | **1.7x** |
| truncate | create 1M file (-s 1M) | 0.0017s | 0.0018s | **1.0x** |
| tsort | tsort 100K pairs | 0.0588s | 0.0079s | **7.5x** |
| tsort | tsort 1M pairs | 0.6534s | 0.0655s | **10.0x** |
| tty | tty (no args) | 0.0008s | 0.0009s | 0.9x |
| uname | uname (no args) | 0.0008s | 0.0009s | 0.9x |
| uname | uname -a | 0.0008s | 0.0010s | 0.8x |
| uname | uname -r | 0.0008s | 0.0009s | 0.9x |
| uname | uname -m | 0.0009s | 0.0009s | **1.0x** |
| unexpand | unexpand 1MB text | 0.0031s | 0.0013s | **2.4x** |
| unexpand | unexpand 10MB text | 0.0247s | 0.0043s | **5.8x** |
| unexpand | -a 1MB text | 0.0077s | 0.0014s | **5.5x** |
| unexpand | -a 10MB text | 0.0699s | 0.0043s | **16.3x** |
| unexpand | -t 4 10MB text | 0.0703s | 0.0046s | **15.3x** |
| unexpand | expand|unexpand pipeline 10MB | 0.0940s | 0.0607s | **1.5x** |
| uniq | default 10MB many duplicates | 0.0119s | 0.0019s | **6.3x** |
| uniq | default 10MB sorted (low dup) | 0.0141s | 0.0032s | **4.5x** |
| uniq | -c count 10MB many dups | 0.0120s | 0.0018s | **6.7x** |
| uniq | -c count 10MB sorted | 0.0290s | 0.0077s | **3.8x** |
| uniq | -d duplicates only 10MB | 0.0119s | 0.0018s | **6.5x** |
| uniq | -u unique only 10MB | 0.0120s | 0.0019s | **6.3x** |
| uniq | -i case insensitive 10MB | 0.0139s | 0.0044s | **3.2x** |
| uniq | repetitive 10MB | 0.0422s | 0.0035s | **12.0x** |
| unlink | unlink a file | 0.0021s | 0.0023s | 0.9x |
| uptime | uptime (default) | 0.0015s | 0.0010s | **1.5x** |
| uptime | uptime -s (since) | 0.0016s | 0.0011s | **1.5x** |
| users | users (default) | 0.0009s | 0.0010s | 0.9x |
| vdir | vdir current directory | 0.0009s | 0.0021s | 0.4x |
| vdir | 100 files directory | 0.0013s | 0.0015s | 0.8x |
| vdir | -R test data | 0.0012s | 0.0015s | 0.8x |
| wc | default 100KB text | 0.0013s | 0.0013s | **1.1x** |
| wc | default 1MB text | 0.0058s | 0.0036s | **1.6x** |
| wc | default 10MB text | 0.0543s | 0.0031s | **17.4x** |
| wc | -l 10MB text | 0.0019s | 0.0019s | **1.0x** |
| wc | -w 10MB text | 0.0541s | 0.0135s | **4.0x** |
| wc | -c 10MB text | 0.0008s | 0.0010s | 0.8x |
| wc | -m 10MB text | 0.0541s | 0.0029s | **18.6x** |
| wc | -L 10MB text | 0.0542s | 0.0101s | **5.4x** |
| wc | default 10MB binary | 0.3172s | 0.0273s | **11.6x** |
| wc | default 10MB repetitive | 0.0731s | 0.0046s | **16.0x** |
| wc | 10 files | 0.0010s | 0.0011s | 0.9x |
| wc | 100 files | 0.0019s | 0.0018s | **1.0x** |
| who | who (default) | 0.0009s | 0.0011s | 0.8x |
| who | who -a (all) | 0.0009s | 0.0012s | 0.8x |
| who | who -b (boot) | 0.0009s | 0.0012s | 0.8x |
| whoami | whoami (no args) | 0.0007s | 0.0009s | 0.7x |
| yes | throughput 1M lines | 0.0067s | 0.0063s | **1.1x** |
| yes | throughput 10M lines | 0.0398s | 0.0354s | **1.1x** |
| yes | throughput hello 1M lines | 0.0113s | 0.0114s | **1.0x** |
| yes | throughput hello 10M lines | 0.0685s | 0.0577s | **1.2x** |
| yes | throughput 100MB | 0.0468s | 0.0452s | **1.0x** |
