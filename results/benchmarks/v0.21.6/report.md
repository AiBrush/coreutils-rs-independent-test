# fcoreutils v0.21.6 — Detailed Results

Generated: 2026-03-14 10:30:54 UTC

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
| arch | arch (no args) | 0.0008s | 0.0009s | 0.9x |
| b2sum | single 100KB text | 0.0010s | 0.0012s | 0.9x |
| b2sum | single 1MB text | 0.0023s | 0.0021s | **1.1x** |
| b2sum | single 10MB text | 0.0152s | 0.0123s | **1.2x** |
| b2sum | single 10MB binary | 0.0168s | 0.0133s | **1.3x** |
| b2sum | -l 256 10MB | 0.0151s | 0.0126s | **1.2x** |
| b2sum | -l 128 10MB | 0.0150s | 0.0124s | **1.2x** |
| b2sum | 100 files | 0.0022s | 0.0021s | **1.1x** |
| base32 | encode 100KB text | 0.0010s | 0.0013s | 0.8x |
| base32 | encode 1MB text | 0.0036s | 0.0016s | **2.3x** |
| base32 | encode 10MB text | 0.0150s | 0.0093s | **1.6x** |
| base32 | encode 10MB binary | 0.0221s | 0.0100s | **2.2x** |
| base32 | decode 1MB | 0.0035s | 0.0025s | **1.4x** |
| base32 | decode 10MB | 0.0281s | 0.0160s | **1.8x** |
| base64 | encode 100KB text | 0.0010s | 0.0010s | **1.0x** |
| base64 | encode 1MB text | 0.0020s | 0.0013s | **1.6x** |
| base64 | encode 10MB text | 0.0122s | 0.0047s | **2.6x** |
| base64 | encode 10MB binary | 0.0133s | 0.0050s | **2.7x** |
| base64 | decode 1MB | 0.0040s | 0.0021s | **1.9x** |
| base64 | decode 10MB | 0.0325s | 0.0048s | **6.8x** |
| base64 | encode -w 76 10MB | 0.0122s | 0.0048s | **2.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0085s | 0.0034s | **2.5x** |
| basename | basename simple path | 0.0008s | 0.0009s | 0.9x |
| basename | basename with suffix (.txt) | 0.0009s | 0.0010s | 0.9x |
| basenc | encode --base64 1MB | 0.0021s | 0.0013s | **1.6x** |
| basenc | encode --base64 10MB | 0.0123s | 0.0063s | **1.9x** |
| basenc | encode --base32 1MB | 0.0035s | 0.0029s | **1.2x** |
| basenc | encode --base16 1MB | 0.0024s | 0.0026s | 0.9x |
| basenc | decode --base64 -d 1MB | 0.0040s | 0.0020s | **2.0x** |
| cat | passthrough 1MB | 0.0010s | 0.0014s | 0.7x |
| cat | passthrough 10MB | 0.0015s | 0.0019s | 0.8x |
| cat | -n 1MB | 0.0020s | 0.0021s | **1.0x** |
| cat | -n 10MB | 0.0105s | 0.0063s | **1.7x** |
| cat | -b 10MB | 0.0102s | 0.0056s | **1.8x** |
| cat | -A 1MB | 0.0019s | 0.0018s | **1.1x** |
| cat | 100 small files | 0.0027s | 0.0027s | **1.0x** |
| cat | binary 10MB | 0.0015s | 0.0021s | 0.7x |
| chgrp | chgrp current group on file | 0.0023s | 0.0031s | 0.7x |
| chgrp | chgrp current group on 1MB file | 0.0031s | 0.0033s | **1.0x** |
| chown | chown current user on file | 0.0023s | 0.0024s | **1.0x** |
| chown | chown current user on 1MB file | 0.0031s | 0.0032s | **1.0x** |
| cksum | single 1MB text | 0.0015s | 0.0011s | **1.3x** |
| cksum | single 10MB text | 0.0030s | 0.0025s | **1.2x** |
| cksum | single 10MB binary | 0.0028s | 0.0036s | 0.8x |
| comm | default 10MB sorted | 0.0250s | 0.0055s | **4.6x** |
| comm | -12 (common only) 10MB | 0.0220s | 0.0038s | **5.9x** |
| comm | -23 (unique to file1) 10MB | 0.0222s | 0.0044s | **5.1x** |
| comm | -3 10MB | 0.0242s | 0.0052s | **4.6x** |
| comm | identical 10MB sorted | 0.0367s | 0.0070s | **5.2x** |
| cp | cp small file (1KB) | 0.0020s | 0.0018s | **1.1x** |
| cp | cp medium file (1MB) | 0.0028s | 0.0026s | **1.1x** |
| cp | cp large file (10MB) | 0.0104s | 0.0102s | **1.0x** |
| cp | cp -r many small files (100 files) | 0.0071s | 0.0062s | **1.1x** |
| cp | cp -r deep directory (8 levels) | 0.0032s | 0.0030s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0198s | 0.0039s | **5.1x** |
| cut | -c1-100 10MB CSV | 0.0198s | 0.0037s | **5.3x** |
| cut | -d, -f1 10MB CSV | 0.0213s | 0.0034s | **6.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0242s | 0.0071s | **3.4x** |
| cut | -d, -f2-4 10MB CSV | 0.0268s | 0.0052s | **5.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0303s | 0.0039s | **7.7x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0016s | 0.4x |
| cut | -d, -f1 1MB text | 0.0039s | 0.0021s | **1.8x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0017s | 0.4x |
| date | date (default) | 0.0007s | 0.0010s | 0.7x |
| date | +%Y-%m-%d %H:%M:%S | 0.0006s | 0.0009s | 0.7x |
| date | +%s (epoch) | 0.0007s | 0.0008s | 0.8x |
| date | ISO 8601 format | 0.0006s | 0.0010s | 0.6x |
| date | RFC 3339 | 0.0007s | 0.0009s | 0.7x |
| date | -u (UTC) | 0.0006s | 0.0009s | 0.7x |
| dd | dd read 10MB (bs=4096) | 0.0048s | 0.0045s | **1.1x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0104s | 0.0135s | 0.8x |
| df | df (default) | 0.0014s | 0.0010s | **1.4x** |
| df | -h (human readable) | 0.0013s | 0.0010s | **1.3x** |
| df | df / | 0.0009s | 0.0010s | 0.9x |
| df | -i (inodes) | 0.0013s | 0.0011s | **1.2x** |
| dir | dir current directory | 0.0011s | 0.0013s | 0.8x |
| dir | 100 files directory | 0.0012s | 0.0017s | 0.7x |
| dir | -la 100 files | 0.0021s | 0.0019s | **1.1x** |
| dir | -R test data | 0.0012s | 0.0016s | 0.7x |
| dircolors | dircolors -b (default) | 0.0009s | 0.0010s | 0.9x |
| dircolors | dircolors -c (csh) | 0.0009s | 0.0011s | 0.9x |
| dircolors | dircolors -p (print) | 0.0010s | 0.0011s | 0.9x |
| dircolors | custom db file | 0.0009s | 0.0010s | 0.9x |
| dirname | dirname simple path | 0.0008s | 0.0009s | 0.9x |
| dirname | dirname deep path | 0.0009s | 0.0010s | 0.9x |
| du | du test data dir | 0.0009s | 0.0011s | 0.9x |
| du | -s (summary) | 0.0009s | 0.0011s | 0.8x |
| du | -sh (human summary) | 0.0009s | 0.0011s | 0.8x |
| du | --max-depth=1 | 0.0009s | 0.0012s | 0.8x |
| du | -b (bytes) | 0.0009s | 0.0011s | 0.8x |
| echo | echo hello | 0.0008s | 0.0010s | 0.8x |
| echo | echo -n hello | 0.0008s | 0.0010s | 0.8x |
| echo | echo -e with escapes | 0.0008s | 0.0009s | 0.9x |
| env | print all env vars | 0.0009s | 0.0010s | 0.8x |
| env | env true (run command) | 0.0013s | 0.0014s | 0.9x |
| env | env VAR=value true | 0.0013s | 0.0014s | 0.9x |
| expand | expand 10MB tabbed (default) | 0.0457s | 0.0163s | **2.8x** |
| expand | expand 1MB text | 0.0033s | 0.0011s | **2.9x** |
| expand | -t 4 10MB tabbed | 0.0429s | 0.0129s | **3.3x** |
| expand | -t 2 10MB tabbed | 0.0359s | 0.0124s | **2.9x** |
| expand | --initial 10MB tabbed | 0.0235s | 0.0066s | **3.6x** |
| expand | expand CSV 10MB | 0.0194s | 0.0016s | **12.1x** |
| expr | expr 1 + 1 | 0.0009s | 0.0010s | **1.0x** |
| expr | expr 999999 * 999999 | 0.0009s | 0.0010s | 0.9x |
| expr | expr length 'hello world' | 0.0009s | 0.0010s | 0.9x |
| expr | expr 'hello' : 'hel' | 0.0011s | 0.0011s | **1.0x** |
| factor | factor 1234567890 | 0.0009s | 0.0010s | 0.9x |
| factor | factor 999999999999999989 (large prime) | 0.0010s | 0.0009s | **1.0x** |
| factor | factor 1-100000 via stdin | 0.0183s | 0.0104s | **1.8x** |
| false | false (startup overhead) | 0.0005s | 0.0007s | 0.7x |
| fmt | fmt 1MB text | 0.0180s | 0.0162s | **1.1x** |
| fmt | fmt 10MB text | 0.1443s | 0.1211s | **1.2x** |
| fmt | -w 40 10MB | 0.1238s | 0.0932s | **1.3x** |
| fmt | -w 120 10MB | 0.1747s | 0.1568s | **1.1x** |
| fmt | fmt wide lines 10MB | 0.1667s | 0.1421s | **1.2x** |
| fold | fold 10MB wide lines (default) | 0.0342s | 0.0040s | **8.6x** |
| fold | fold 1MB text | 0.0043s | 0.0016s | **2.8x** |
| fold | fold 10MB text | 0.0346s | 0.0050s | **6.9x** |
| fold | -w 40 10MB | 0.0351s | 0.0045s | **7.9x** |
| fold | -w 20 10MB | 0.0359s | 0.0057s | **6.3x** |
| fold | -s -w 60 10MB | 0.0377s | 0.0050s | **7.6x** |
| fold | -s -w 40 10MB | 0.0407s | 0.0061s | **6.7x** |
| fold | -b -w 40 10MB | 0.0332s | 0.0053s | **6.3x** |
| groups | groups (no args) | 0.0010s | 0.0011s | 0.9x |
| head | default 1MB text | 0.0008s | 0.0012s | 0.7x |
| head | default 10MB text | 0.0009s | 0.0012s | 0.7x |
| head | -n 1000 10MB | 0.0009s | 0.0011s | 0.8x |
| head | -n 100000 10MB | 0.0062s | 0.0028s | **2.2x** |
| head | -c 1000000 10MB | 0.0012s | 0.0013s | 0.9x |
| head | -n -100 10MB (all but last 100) | 0.0039s | 0.0020s | **1.9x** |
| head | 100 small files | 0.0016s | 0.0018s | 0.8x |
| hostid | hostid (no args) | 0.0010s | 0.0011s | 0.9x |
| id | id (no args) | 0.0012s | 0.0011s | **1.0x** |
| id | id -u | 0.0010s | 0.0009s | **1.1x** |
| id | id -g | 0.0010s | 0.0011s | 0.9x |
| id | id -un | 0.0011s | 0.0010s | **1.0x** |
| install | install 1MB file | 0.0028s | 0.0027s | **1.1x** |
| install | install -d create directory | 0.0023s | 0.0021s | **1.1x** |
| join | default join 10MB | - | - | - |
| join | outer join 10MB | - | - | - |
| join | -v 1 (unmatched from file1) 10MB | - | - | - |
| join | -o 0,1.2,2.2 10MB | - | - | - |
| join | self-join sorted 10MB | 0.0461s | 0.0387s | **1.2x** |
| kill | kill -l (list signals) | 0.0008s | 0.0010s | 0.8x |
| link | hard link a file | 0.0016s | 0.0018s | 0.9x |
| ln | symlink single file | 0.0017s | 0.0018s | 0.9x |
| ln | symlink force overwrite (-sf) | 0.0017s | 0.0019s | 0.9x |
| ln | hard link single file | 0.0018s | 0.0017s | **1.0x** |
| logname | logname (no args) | 0.0008s | 0.0009s | 0.9x |
| ls | ls current directory | 0.0010s | 0.0012s | 0.8x |
| ls | 100 files | 0.0010s | 0.0013s | 0.7x |
| ls | -la 100 files | 0.0019s | 0.0019s | **1.0x** |
| ls | -la test data dir | 0.0025s | 0.0020s | **1.2x** |
| ls | -R test data | 0.0011s | 0.0014s | 0.8x |
| ls | -lt 100 files | 0.0019s | 0.0018s | **1.1x** |
| ls | -lS test data dir | 0.0022s | 0.0019s | **1.2x** |
| md5sum | single 100KB text | 0.0015s | 0.0012s | **1.3x** |
| md5sum | single 1MB text | 0.0028s | 0.0029s | 0.9x |
| md5sum | single 10MB text | 0.0175s | 0.0189s | 0.9x |
| md5sum | single 10MB binary | 0.0182s | 0.0193s | 0.9x |
| md5sum | 10 files | 0.0013s | 0.0025s | 0.5x |
| md5sum | 100 files | 0.0023s | 0.0031s | 0.7x |
| mkdir | mkdir single directory | 0.0015s | 0.0015s | **1.0x** |
| mkdir | mkdir -p nested directories | 0.0020s | 0.0016s | **1.2x** |
| mkfifo | mkfifo single fifo | 0.0019s | 0.0018s | **1.0x** |
| mknod | mknod named pipe | 0.0019s | 0.0018s | **1.1x** |
| mktemp | mktemp default | 0.0019s | 0.0020s | 0.9x |
| mktemp | mktemp -d directory | 0.0019s | 0.0020s | 0.9x |
| mv | mv same-fs small (1MB) | 0.0039s | 0.0038s | **1.0x** |
| mv | mv same-fs large (10MB) | 0.0117s | 0.0112s | **1.0x** |
| mv | mv many files (100 files) | - | 0.0109s | - |
| nice | nice true (default priority) | 0.0013s | 0.0014s | 0.9x |
| nice | nice -n 10 true | 0.0013s | 0.0014s | 0.9x |
| nl | default 1MB | 0.0043s | 0.0015s | **2.8x** |
| nl | default 10MB | 0.0329s | 0.0048s | **6.8x** |
| nl | -b a 10MB | 0.0332s | 0.0047s | **7.0x** |
| nl | -b a 10MB with blanks | 0.0428s | 0.0060s | **7.1x** |
| nl | -b a -n rz 10MB | 0.0337s | 0.0045s | **7.6x** |
| nl | -b a -w 8 -s ': ' 10MB | 0.0333s | 0.0043s | **7.7x** |
| nl | -b p'^the' 10MB | 0.0581s | 0.0048s | **12.1x** |
| nohup | nohup true | 0.0015s | 0.0016s | 0.9x |
| nproc | nproc (no args) | 0.0009s | 0.0010s | 0.9x |
| nproc | nproc --all | 0.0008s | 0.0009s | 0.9x |
| numfmt | --to=iec single value | 0.0008s | 0.0011s | 0.7x |
| numfmt | --from=iec single value | 0.0008s | 0.0010s | 0.8x |
| numfmt | --to=si from CSV column | 0.0198s | 0.0206s | **1.0x** |
| od | default 1MB text | 0.0647s | 0.0097s | **6.7x** |
| od | -A x -t x1z 1MB | 0.1177s | 0.0166s | **7.1x** |
| od | -c 1MB text | 0.1201s | 0.0112s | **10.8x** |
| od | default 10MB binary | 0.6655s | 0.0912s | **7.3x** |
| od | -N 10000 10MB | 0.0021s | 0.0011s | **2.0x** |
| paste | 2 columns 10MB | 0.0175s | 0.0074s | **2.3x** |
| paste | 3 columns 10MB | 0.0228s | 0.0137s | **1.7x** |
| paste | -d comma 10MB | 0.0174s | 0.0075s | **2.3x** |
| paste | -s 10MB single file | 0.0086s | 0.0040s | **2.1x** |
| paste | stdin split 2-way 10MB | 0.0329s | 0.0087s | **3.8x** |
| pathchk | pathchk default | 0.0008s | 0.0010s | 0.9x |
| pathchk | pathchk -p (POSIX portable) | 0.0009s | 0.0009s | 0.9x |
| pinky | pinky (default) | 0.0009s | 0.0010s | 0.9x |
| pinky | pinky -l | - | - | - |
| pr | pr 1MB text | 0.0104s | 0.0014s | **7.3x** |
| pr | -2 (two columns) 1MB | 0.0116s | 0.0016s | **7.5x** |
| pr | -3 (three columns) 1MB | 0.0086s | 0.0015s | **5.6x** |
| pr | -n 1MB text | 0.0117s | 0.0018s | **6.5x** |
| pr | -t 1MB text | 0.0108s | 0.0013s | **8.3x** |
| printenv | printenv (all) | 0.0008s | 0.0011s | 0.7x |
| printenv | printenv HOME | 0.0008s | 0.0010s | 0.8x |
| printenv | printenv PATH | 0.0008s | 0.0010s | 0.8x |
| printf | simple string | 0.0008s | 0.0011s | 0.7x |
| printf | integer formatting | 0.0008s | 0.0014s | 0.6x |
| printf | float formatting | 0.0011s | 0.0013s | 0.8x |
| printf | string padding | 0.0008s | 0.0014s | 0.6x |
| ptx | ptx 10KB text | 0.0019s | 0.0016s | **1.2x** |
| ptx | ptx 100KB text | 0.0113s | 0.0059s | **1.9x** |
| ptx | -w 60 100KB text | 0.0100s | 0.0053s | **1.9x** |
| pwd | pwd (no args) | 0.0008s | 0.0009s | 0.9x |
| pwd | pwd -L | 0.0008s | 0.0009s | 0.9x |
| pwd | pwd -P | 0.0008s | 0.0010s | 0.8x |
| readlink | readlink symlink | 0.0006s | 0.0010s | 0.7x |
| readlink | readlink -f (canonicalize) | 0.0006s | 0.0008s | 0.7x |
| realpath | realpath . | 0.0008s | 0.0010s | 0.9x |
| realpath | realpath /tmp | 0.0008s | 0.0012s | 0.7x |
| realpath | realpath test data file | 0.0008s | 0.0009s | 0.9x |
| rev | reverse 100KB text | 0.0022s | 0.0010s | **2.2x** |
| rev | reverse 1MB text | 0.0150s | 0.0018s | **8.4x** |
| rev | reverse 10MB text | 0.1332s | 0.0075s | **17.8x** |
| rev | reverse CSV 10MB | 0.0993s | 0.0071s | **14.1x** |
| rev | reverse repetitive 10MB | 0.2862s | 0.0120s | **23.9x** |
| rev | reverse 10KB single line | 0.0010s | 0.0009s | **1.1x** |
| rm | rm single file | 0.0015s | 0.0017s | 0.9x |
| rm | rm -rf directory | 0.0036s | 0.0045s | 0.8x |
| rmdir | rmdir single empty directory | 0.0019s | 0.0020s | 0.9x |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0104s | 0.0025s | **4.2x** |
| seq | seq 1 10000000 | 0.0962s | 0.0137s | **7.0x** |
| seq | seq 0 0.1 100000 (float) | 0.2345s | 0.0204s | **11.5x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2422s | 0.0162s | **14.9x** |
| sha1sum | single 1MB text | 0.0021s | 0.0019s | **1.1x** |
| sha1sum | single 10MB text | 0.0093s | 0.0094s | **1.0x** |
| sha1sum | single 10MB binary | 0.0092s | 0.0092s | **1.0x** |
| sha1sum | 100 files | 0.0026s | 0.0034s | 0.8x |
| sha224sum | single 1MB text | 0.0020s | 0.0017s | **1.2x** |
| sha224sum | single 10MB text | 0.0084s | 0.0084s | **1.0x** |
| sha224sum | single 10MB binary | 0.0088s | 0.0086s | **1.0x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.3x** |
| sha256sum | single 1MB text | 0.0019s | 0.0017s | **1.1x** |
| sha256sum | single 10MB text | 0.0084s | 0.0084s | **1.0x** |
| sha256sum | single 10MB binary | 0.0087s | 0.0085s | **1.0x** |
| sha256sum | 10 files | 0.0013s | 0.0025s | 0.5x |
| sha256sum | 100 files | 0.0024s | 0.0032s | 0.8x |
| sha384sum | single 1MB text | 0.0027s | 0.0038s | 0.7x |
| sha384sum | single 10MB text | 0.0155s | 0.0173s | 0.9x |
| sha384sum | single 10MB binary | 0.0159s | 0.0173s | 0.9x |
| sha512sum | single 1MB text | 0.0026s | 0.0038s | 0.7x |
| sha512sum | single 10MB text | 0.0154s | 0.0170s | 0.9x |
| sha512sum | single 10MB binary | 0.0159s | 0.0173s | 0.9x |
| shred | shred 1MB file | 0.0092s | 0.0061s | **1.5x** |
| shred | shred 1MB file with remove (-u) | 0.0172s | 0.0073s | **2.4x** |
| shuf | shuf 1MB text | 0.0030s | 0.0016s | **1.9x** |
| shuf | shuf 10MB text | 0.0187s | 0.0061s | **3.1x** |
| shuf | -n 100 from 10MB | 0.0182s | 0.0041s | **4.4x** |
| shuf | -n 10000 from 10MB | 0.0205s | 0.0053s | **3.9x** |
| shuf | -i 1-1000000 | 0.0713s | 0.0135s | **5.3x** |
| shuf | -i 1-1000000 -n 100 | 0.0009s | 0.0010s | 0.9x |
| sleep | sleep 0 (startup overhead) | 0.0009s | 0.0009s | 0.9x |
| sleep | sleep 0.001 (tiny sleep) | 0.0019s | 0.0020s | 0.9x |
| sort | lexicographic 1MB | 0.0078s | 0.0037s | **2.1x** |
| sort | lexicographic 10MB random | 0.0605s | 0.0108s | **5.6x** |
| sort | already sorted 10MB | 0.0237s | 0.0054s | **4.4x** |
| sort | reverse sorted 10MB | 0.0245s | 0.0069s | **3.6x** |
| sort | -n numeric 10MB | 0.0735s | 0.0062s | **11.9x** |
| sort | -r reverse 10MB | 0.0542s | 0.0108s | **5.0x** |
| sort | -u unique 10MB | 0.0589s | 0.0105s | **5.6x** |
| sort | -t, -k2 CSV 10MB | 0.0690s | 0.0376s | **1.8x** |
| sort | repetitive 10MB | 0.0505s | 0.0137s | **3.7x** |
| sort | --parallel=4 10MB | 0.0530s | 0.0116s | **4.6x** |
| split | split 10MB into 1MB chunks (-b 1m) | 0.0104s | 0.0071s | **1.5x** |
| split | split 10MB by 1000 lines (-l 1000) | 0.0172s | 0.0173s | **1.0x** |
| stat | stat single file | 0.0013s | 0.0013s | **1.0x** |
| stat | 100 files | 0.0043s | 0.0050s | 0.9x |
| stat | --format=%s (size only) | 0.0010s | 0.0009s | **1.1x** |
| stat | --format='%n %s %Y' | 0.0010s | 0.0009s | **1.1x** |
| stat | -f (filesystem) | 0.0010s | 0.0010s | **1.1x** |
| stdbuf | -oL cat 1MB | 0.0012s | 0.0015s | 0.8x |
| stdbuf | -o0 cat 100KB | 0.0012s | 0.0014s | 0.8x |
| sum | single 1MB text | 0.0025s | 0.0023s | **1.1x** |
| sum | single 10MB text | 0.0178s | 0.0148s | **1.2x** |
| sum | single 10MB binary | 0.0184s | 0.0152s | **1.2x** |
| sync | sync (no args) | 0.0008s | 0.0010s | 0.8x |
| tac | reverse 100KB text | 0.0010s | 0.0012s | 0.8x |
| tac | reverse 1MB text | 0.0020s | 0.0016s | **1.3x** |
| tac | reverse 10MB text | 0.0111s | 0.0050s | **2.2x** |
| tac | reverse CSV 10MB | 0.0096s | 0.0052s | **1.9x** |
| tac | reverse repetitive 10MB | 0.0239s | 0.0083s | **2.9x** |
| tac | custom separator 1MB | 0.0062s | 0.0045s | **1.4x** |
| tail | default 1MB text | 0.0009s | 0.0012s | 0.8x |
| tail | default 10MB text | 0.0009s | 0.0012s | 0.8x |
| tail | -n 1000 10MB | 0.0009s | 0.0012s | 0.8x |
| tail | -n 100000 10MB | 0.0060s | 0.0031s | **1.9x** |
| tail | -n +100 10MB (from line 100) | 0.0040s | 0.0021s | **1.9x** |
| tail | -n +100000 10MB (from line 100000) | 0.0039s | 0.0034s | **1.1x** |
| tail | -c 1000000 10MB | 0.0012s | 0.0012s | **1.0x** |
| tail | 100 small files | 0.0018s | 0.0021s | 0.9x |
| tee | tee 1MB to /dev/null | 0.0022s | 0.0020s | **1.1x** |
| tee | tee 10MB to /dev/null | 0.0092s | 0.0073s | **1.3x** |
| test | test -f (file exists) | 0.0008s | 0.0009s | 0.9x |
| test | test 1 -eq 1 | 0.0008s | 0.0009s | 0.9x |
| test | test 'hello' = 'hello' | 0.0008s | 0.0009s | 0.9x |
| test | test -d /tmp | 0.0008s | 0.0010s | 0.9x |
| timeout | timeout 10 true | 0.0015s | 0.0017s | 0.9x |
| timeout | timeout 10 echo hello | 0.0018s | 0.0019s | 0.9x |
| touch | create new file | 0.0012s | 0.0014s | 0.8x |
| touch | update existing file timestamp | 0.0009s | 0.0008s | **1.1x** |
| touch | set specific timestamp (-t) | 0.0012s | 0.0015s | 0.8x |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0016s | **1.5x** |
| tr | a-z to A-Z 10MB | 0.0189s | 0.0040s | **4.7x** |
| tr | -d digits 10MB | 0.0187s | 0.0051s | **3.7x** |
| tr | -d lowercase 10MB | 0.0343s | 0.0059s | **5.8x** |
| tr | -s spaces 10MB | 0.0278s | 0.0037s | **7.5x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0132s | 0.0040s | **3.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0194s | 0.0051s | **3.8x** |
| tr | translate binary 10MB | 0.0156s | 0.0041s | **3.8x** |
| true | true (startup overhead) | 0.0005s | 0.0007s | 0.7x |
| truncate | truncate to zero (-s 0) | 0.0030s | 0.0031s | **1.0x** |
| truncate | create 1M file (-s 1M) | 0.0018s | 0.0019s | 0.9x |
| tsort | tsort 100K pairs | 0.0571s | 0.0076s | **7.5x** |
| tsort | tsort 1M pairs | 0.6559s | 0.0640s | **10.2x** |
| tty | tty (no args) | 0.0008s | 0.0009s | 0.9x |
| uname | uname (no args) | 0.0008s | 0.0009s | 0.9x |
| uname | uname -a | 0.0008s | 0.0009s | 0.8x |
| uname | uname -r | 0.0008s | 0.0010s | 0.8x |
| uname | uname -m | 0.0008s | 0.0010s | 0.8x |
| unexpand | unexpand 1MB text | 0.0030s | 0.0011s | **2.8x** |
| unexpand | unexpand 10MB text | 0.0240s | 0.0020s | **12.1x** |
| unexpand | -a 1MB text | 0.0074s | 0.0010s | **7.1x** |
| unexpand | -a 10MB text | 0.0701s | 0.0030s | **23.7x** |
| unexpand | -t 4 10MB text | 0.0703s | 0.0031s | **22.5x** |
| unexpand | expand|unexpand pipeline 10MB | 0.0942s | 0.0639s | **1.5x** |
| uniq | default 10MB many duplicates | 0.0117s | 0.0018s | **6.4x** |
| uniq | default 10MB sorted (low dup) | 0.0146s | 0.0030s | **4.8x** |
| uniq | -c count 10MB many dups | 0.0126s | 0.0025s | **5.0x** |
| uniq | -c count 10MB sorted | 0.0292s | 0.0075s | **3.9x** |
| uniq | -d duplicates only 10MB | 0.0121s | 0.0018s | **6.6x** |
| uniq | -u unique only 10MB | 0.0119s | 0.0018s | **6.5x** |
| uniq | -i case insensitive 10MB | 0.0138s | 0.0043s | **3.2x** |
| uniq | repetitive 10MB | 0.0416s | 0.0034s | **12.1x** |
| unlink | unlink a file | 0.0021s | 0.0022s | **1.0x** |
| uptime | uptime (default) | 0.0015s | 0.0010s | **1.5x** |
| uptime | uptime -s (since) | 0.0015s | 0.0010s | **1.5x** |
| users | users (default) | 0.0007s | 0.0008s | 0.8x |
| vdir | vdir current directory | 0.0009s | 0.0011s | 0.9x |
| vdir | 100 files directory | 0.0013s | 0.0016s | 0.8x |
| vdir | -R test data | 0.0013s | 0.0016s | 0.8x |
| wc | default 100KB text | 0.0014s | 0.0012s | **1.1x** |
| wc | default 1MB text | 0.0057s | 0.0035s | **1.6x** |
| wc | default 10MB text | 0.0544s | 0.0026s | **20.7x** |
| wc | -l 10MB text | 0.0020s | 0.0021s | **1.0x** |
| wc | -w 10MB text | 0.0545s | 0.0135s | **4.0x** |
| wc | -c 10MB text | 0.0009s | 0.0010s | 0.9x |
| wc | -m 10MB text | 0.0548s | 0.0025s | **21.6x** |
| wc | -L 10MB text | 0.0545s | 0.0094s | **5.8x** |
| wc | default 10MB binary | 0.3229s | 0.0259s | **12.5x** |
| wc | default 10MB repetitive | 0.0729s | 0.0035s | **20.9x** |
| wc | 10 files | 0.0010s | 0.0010s | 0.9x |
| wc | 100 files | 0.0020s | 0.0017s | **1.1x** |
| who | who (default) | 0.0009s | 0.0011s | 0.8x |
| who | who -a (all) | 0.0010s | 0.0011s | 0.9x |
| who | who -b (boot) | 0.0009s | 0.0010s | 0.9x |
| whoami | whoami (no args) | 0.0009s | 0.0010s | 0.9x |
| yes | throughput 1M lines | 0.0032s | 0.0038s | 0.8x |
| yes | throughput 10M lines | 0.0292s | 0.0215s | **1.4x** |
| yes | throughput hello 1M lines | 0.0069s | 0.0081s | 0.9x |
| yes | throughput hello 10M lines | 0.0609s | 0.0691s | 0.9x |
| yes | throughput 100MB | 0.0509s | 0.0435s | **1.2x** |

## Assembly (x86-64 nasm)

### Assembly GNU Compatibility

| Tool | Binary | Total | Passed | Failed | Rate |
|------|--------|------:|-------:|-------:|-----:|
| arch | farch | 12 | 12 | 0 | 100% |
| base64 | fbase64 | 17 | 17 | 0 | 100% |
| cat | fcat | 65 | 65 | 0 | 100% |
| cut | fcut | 24 | 24 | 0 | 100% |
| echo | fecho | 57 | 57 | 0 | 100% |
| expand | fexpand | 60 | 60 | 0 | 100% |
| false | ffalse | 20 | 20 | 0 | 100% |
| fold | ffold | 58 | 58 | 0 | 100% |
| head | fhead | 19 | 19 | 0 | 100% |
| hostid | fhostid | 6 | 6 | 0 | 100% |
| logname | flogname | 9 | 9 | 0 | 100% |
| md5sum | fmd5sum | 16 | 16 | 0 | 100% |
| nl | fnl | 69 | 69 | 0 | 100% |
| od | fod | 58 | 58 | 0 | 100% |
| pwd | fpwd | 14 | 14 | 0 | 100% |
| rev | frev | 15 | 15 | 0 | 100% |
| seq | fseq | 50 | 50 | 0 | 100% |
| sleep | fsleep | 17 | 17 | 0 | 100% |
| sort | fsort | 46 | 46 | 0 | 100% |
| sync | fsync | 16 | 16 | 0 | 100% |
| tac | ftac | 13 | 13 | 0 | 100% |
| tail | ftail | 18 | 18 | 0 | 100% |
| tr | ftr | 20 | 20 | 0 | 100% |
| true | ftrue | 9 | 9 | 0 | 100% |
| tty | ftty | 16 | 16 | 0 | 100% |
| unexpand | funexpand | 57 | 57 | 0 | 100% |
| uniq | funiq | 72 | 72 | 0 | 100% |
| wc | fwc | 23 | 23 | 0 | 100% |
| whoami | fwhoami | 4 | 4 | 0 | 100% |

### Assembly Security Tests

| Tool | Total | Passed | Failed | Skipped | Rate |
|------|------:|-------:|-------:|--------:|-----:|
| arch | 97 | 97 | 0 | 0 | 100% |
| base64 | 123 | 123 | 0 | 0 | 100% |
| cat | 130 | 130 | 0 | 0 | 100% |
| cut | 102 | 102 | 0 | 0 | 100% |
| echo | 182 | 182 | 0 | 0 | 100% |
| expand | 124 | 124 | 0 | 0 | 100% |
| false | 117 | 117 | 0 | 0 | 100% |
| fold | 116 | 116 | 0 | 0 | 100% |
| head | 116 | 115 | 0 | 1 | 99% |
| hostid | 88 | 88 | 0 | 0 | 100% |
| logname | 77 | 77 | 0 | 0 | 100% |
| md5sum | 133 | 133 | 0 | 0 | 100% |
| nl | 122 | 122 | 0 | 0 | 100% |
| od | 124 | 124 | 0 | 0 | 100% |
| pwd | 93 | 93 | 0 | 0 | 100% |
| rev | 109 | 109 | 0 | 0 | 100% |
| seq | 131 | 131 | 0 | 0 | 100% |
| sleep | 103 | 103 | 0 | 0 | 100% |
| sort | 122 | 122 | 0 | 0 | 100% |
| sync | 89 | 89 | 0 | 0 | 100% |
| tac | 105 | 105 | 0 | 0 | 100% |
| tail | 111 | 111 | 0 | 0 | 100% |
| tr | 102 | 102 | 0 | 0 | 100% |
| true | 110 | 110 | 0 | 0 | 100% |
| tty | 88 | 88 | 0 | 0 | 100% |
| unexpand | 123 | 123 | 0 | 0 | 100% |
| uniq | 116 | 116 | 0 | 0 | 100% |
| wc | 109 | 109 | 0 | 0 | 100% |
| whoami | 86 | 86 | 0 | 0 | 100% |

### Assembly Performance (3-way: GNU vs Rust vs ASM)

| Tool | Test | GNU (mean) | Rust (mean) | ASM (mean) | ASM vs GNU | ASM vs Rust |
|------|------|----------:|-----------:|-----------:|-----------:|------------:|
| base64 | encode 1MB | 0.0023s | 0.0016s | 0.0012s | **1.9x** | **1.3x** |
| cat | passthrough 1MB | 0.0010s | 0.0014s | 0.0002s | **4.0x** | **5.7x** |
| cat | passthrough 10MB | 0.0015s | 0.0020s | 0.0006s | **2.7x** | **3.5x** |
| cat | -n 10MB | 0.0101s | 0.0059s | 0.0111s | 0.9x | 0.5x |
| cut | 10MB -c1-20 | 0.0189s | 0.0033s | 0.0045s | **4.2x** | 0.7x |
| echo | short string | 0.0001s | 0.0007s | 0.0002s | 0.4x | **4.7x** |
| expand | 10MB text | 0.0265s | 0.0019s | 0.0059s | **4.5x** | 0.3x |
| fold | 10MB default width | 0.0357s | 0.0050s | 0.0049s | **7.2x** | **1.0x** |
| fold | 10MB -w 40 | 0.0364s | 0.0056s | 0.0051s | **7.1x** | **1.1x** |
| head | first 1000 lines 10MB | 0.0009s | 0.0012s | 0.0003s | **3.0x** | **3.7x** |
| md5sum | 10MB file | 0.0173s | 0.0186s | 0.0240s | 0.7x | 0.8x |
| nl | 10MB text | 0.0357s | 0.0049s | 0.0041s | **8.7x** | **1.2x** |
| od | 1MB text | 0.0630s | 0.0089s | 0.0060s | **10.5x** | **1.5x** |
| rev | 10MB text | 0.1338s | 0.0079s | 0.0141s | **9.5x** | 0.6x |
| seq | 1 to 1M | 0.0104s | 0.0025s | 0.0011s | **9.4x** | **2.2x** |
| seq | 1 to 10M | 0.0959s | 0.0135s | 0.0047s | **20.4x** | **2.9x** |
| sort | 1MB text | 0.0086s | 0.0040s | 0.0061s | **1.4x** | 0.7x |
| tac | reverse 1MB | 0.0019s | 0.0015s | 0.0009s | **2.1x** | **1.6x** |
| tail | last 1000 lines 10MB | 0.0011s | 0.0014s | 0.0003s | **3.2x** | **4.2x** |
| tr | 10MB lowercase | 0.0056s | 0.0033s | 0.0056s | **1.0x** | 0.6x |
| unexpand | 10MB text | 0.0225s | 0.0023s | 0.0072s | **3.1x** | 0.3x |
| uniq | 10MB sorted | 0.0206s | 0.0031s | 0.0034s | **6.1x** | 0.9x |
| wc | 10MB text | 0.0545s | 0.0025s | 0.0380s | **1.4x** | 0.1x |
| wc | 10MB -l only | 0.0019s | 0.0018s | 0.0013s | **1.5x** | **1.4x** |
| yes | 1M lines | 0.0051s | 0.0053s | 0.0056s | 0.9x | **1.0x** |

### Assembly Binary Sizes

| Tool | ASM Binary | GNU Binary | Size Ratio |
|------|----------:|-----------:|-----------:|
| arch | 13.5 KB | 34.5 KB | 0.391x |
| base64 | 5.7 KB | 38.5 KB | 0.148x |
| cat | 18.0 KB | 38.5 KB | 0.468x |
| cut | 9.3 KB | 38.5 KB | 0.242x |
| echo | 8.2 KB | 34.4 KB | 0.239x |
| expand | 29.5 KB | 34.5 KB | 0.855x |
| false | 4.8 KB | 26.3 KB | 0.181x |
| fold | 9.8 KB | 34.5 KB | 0.284x |
| head | 7.2 KB | 42.5 KB | 0.169x |
| hostid | 13.1 KB | 34.5 KB | 0.381x |
| logname | 13.4 KB | 34.5 KB | 0.388x |
| md5sum | 9.6 KB | 38.4 KB | 0.250x |
| nl | 38.2 KB | 38.6 KB | 0.990x |
| od | 37.7 KB | 70.5 KB | 0.535x |
| pwd | 12.8 KB | 34.5 KB | 0.370x |
| rev | 2.6 KB | 14.4 KB | 0.181x |
| seq | 36.2 KB | 50.5 KB | 0.717x |
| sleep | 13.4 KB | 34.5 KB | 0.387x |
| sort | 39.7 KB | 102.8 KB | 0.386x |
| sync | 14.6 KB | 34.4 KB | 0.425x |
| tac | 4.6 KB | 38.4 KB | 0.119x |
| tail | 7.5 KB | 62.5 KB | 0.121x |
| tr | 9.8 KB | 46.5 KB | 0.210x |
| true | 9.9 KB | 26.3 KB | 0.377x |
| tty | 12.0 KB | 34.5 KB | 0.348x |
| unexpand | 22.1 KB | 38.5 KB | 0.573x |
| uniq | 39.3 KB | 38.5 KB | 1.020x |
| wc | 30.4 KB | 54.5 KB | 0.558x |
| whoami | 12.4 KB | 34.5 KB | 0.360x |
| yes | 1.8 KB | 34.4 KB | 0.051x |
