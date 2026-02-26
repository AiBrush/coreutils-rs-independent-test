# fcoreutils v0.13.6 — Detailed Results

Generated: 2026-02-26 07:16:02 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|------:|-------:|-------:|----------:|
| Darwin_arm64 | 388 | 276 | 76 | 71.1% |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

## Performance (Linux x86_64)

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|----------:|-----------------:|--------:|
| arch | arch (no args) | 0.0006s | 0.0008s | **0.7x** |
| base32 | encode 100KB text | 0.0007s | 0.0011s | **0.7x** |
| base32 | encode 1MB text | 0.0018s | 0.0017s | **1.0x** |
| base32 | encode 10MB text | 0.0122s | 0.0104s | **1.2x** |
| base32 | encode 10MB binary | 0.0130s | 0.0105s | **1.2x** |
| base32 | decode 1MB | 0.0035s | 0.0023s | **1.5x** |
| base32 | decode 10MB | 0.0295s | 0.0177s | **1.7x** |
| base64 | encode 100KB text | 0.0008s | 0.0011s | **0.7x** |
| base64 | encode 1MB text | 0.0016s | 0.0012s | **1.3x** |
| base64 | encode 10MB text | 0.0103s | 0.0058s | **1.8x** |
| base64 | encode 10MB binary | 0.0108s | 0.0059s | **1.8x** |
| base64 | decode 1MB | 0.0036s | 0.0020s | **1.8x** |
| base64 | decode 10MB | 0.0302s | 0.0044s | **6.9x** |
| base64 | encode -w 76 10MB | 0.0105s | 0.0057s | **1.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0083s | 0.0043s | **1.9x** |
| basename | basename simple path | 0.0006s | 0.0008s | **0.7x** |
| basename | basename with suffix (.txt) | 0.0006s | 0.0008s | **0.7x** |
| basenc | encode --base64 1MB | 0.0016s | 0.0012s | **1.4x** |
| basenc | encode --base64 10MB | 0.0097s | 0.0049s | **2.0x** |
| basenc | encode --base32 1MB | 0.0018s | 0.0020s | **0.9x** |
| basenc | encode --base16 1MB | 0.0019s | 0.0021s | **0.9x** |
| basenc | decode --base64 -d 1MB | 0.0036s | 0.0035s | **1.0x** |
| chgrp | chgrp current group on file | 0.0015s | 0.0018s | **0.9x** |
| chgrp | chgrp current group on 1MB file | 0.0020s | 0.0022s | **0.9x** |
| chmod | chmod 644 on file | 0.0015s | 0.0017s | **0.9x** |
| chmod | chmod u+x on file | 0.0015s | 0.0017s | **0.9x** |
| chown | chown current user on file | 0.0016s | 0.0017s | **0.9x** |
| chown | chown current user on 1MB file | 0.0020s | 0.0022s | **0.9x** |
| cksum | single 1MB text | 0.0010s | 0.0009s | **1.1x** |
| cksum | single 10MB text | 0.0020s | 0.0018s | **1.1x** |
| cksum | single 10MB binary | 0.0021s | 0.0019s | **1.1x** |
| cp | cp 1MB file | 0.0018s | 0.0019s | **1.0x** |
| cp | cp 10MB file | 0.0059s | 0.0059s | **1.0x** |
| cp | cp -r directory (many_files) | 0.0037s | 0.0040s | **0.9x** |
| csplit | csplit 1MB by pattern | 0.2075s | 0.0222s | **9.4x** |
| cut | -b1-100 10MB CSV | 0.0195s | 0.0042s | **4.7x** |
| cut | -c1-100 10MB CSV | 0.0194s | 0.0033s | **5.9x** |
| cut | -d, -f1 10MB CSV | 0.0211s | 0.0095s | **2.2x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0239s | 0.0109s | **2.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0263s | 0.0101s | **2.6x** |
| cut | --complement -d, -f1 10MB CSV | 0.0297s | 0.0110s | **2.7x** |
| cut | -d, -f1 100KB text | 0.0006s | 0.0011s | **0.6x** |
| cut | -d, -f1 1MB text | 0.0038s | 0.0027s | **1.4x** |
| cut | -d: -f1 colon file | 0.0006s | 0.0011s | **0.5x** |
| dd | dd read 10MB (bs=4096) | 0.0021s | 0.0021s | **1.0x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0062s | 0.0093s | **0.7x** |
| dirname | dirname simple path | 0.0006s | 0.0008s | **0.7x** |
| dirname | dirname deep path | 0.0006s | 0.0009s | **0.7x** |
| echo | echo hello | 0.0006s | 0.0008s | **0.7x** |
| echo | echo -n hello | 0.0006s | 0.0008s | **0.8x** |
| echo | echo -e with escapes | 0.0006s | 0.0007s | **0.8x** |
| env | print all env vars | 0.0006s | 0.0008s | **0.7x** |
| env | env true (run command) | 0.0009s | 0.0011s | **0.8x** |
| env | env VAR=value true | 0.0009s | 0.0012s | **0.8x** |
| expr | expr 1 + 1 | 0.0007s | 0.0009s | **0.8x** |
| expr | expr 999999 * 999999 | 0.0007s | 0.0009s | **0.8x** |
| expr | expr length 'hello world' | 0.0007s | 0.0009s | **0.8x** |
| expr | expr 'hello' : 'hel' | 0.0007s | 0.0009s | **0.7x** |
| factor | factor 1234567890 | 0.0007s | 0.0008s | **0.8x** |
| factor | factor 999999999999999989 (large prime) | 0.0006s | 0.0008s | **0.8x** |
| factor | factor 1-100000 via stdin | 0.0149s | 0.0110s | **1.4x** |
| false | false (startup overhead) | 0.0000s | 0.0005s | **0.1x** |
| groups | groups (no args) | 0.0007s | 0.0009s | **0.8x** |
| hostid | hostid (no args) | 0.0007s | 0.0008s | **0.8x** |
| id | id (no args) | 0.0008s | 0.0009s | **0.9x** |
| id | id -u | 0.0007s | 0.0008s | **0.9x** |
| id | id -g | 0.0007s | 0.0008s | **0.9x** |
| id | id -un | 0.0008s | 0.0009s | **0.9x** |
| install | install 1MB file | 0.0019s | 0.0019s | **1.0x** |
| install | install -d create directory | 0.0016s | 0.0016s | **1.0x** |
| link | hard link a file | 0.0012s | 0.0014s | **0.8x** |
| ln | symlink single file | 0.0012s | 0.0014s | **0.8x** |
| ln | symlink force overwrite (-sf) | 0.0012s | 0.0014s | **0.8x** |
| ln | hard link single file | 0.0012s | 0.0015s | **0.8x** |
| logname | logname (no args) | 0.0006s | 0.0008s | **0.8x** |
| mkdir | mkdir single directory | 0.0014s | 0.0014s | **0.9x** |
| mkdir | mkdir -p nested directories | 0.0013s | 0.0014s | **0.9x** |
| mkfifo | mkfifo single fifo | 0.0013s | 0.0014s | **0.9x** |
| mknod | mknod named pipe | 0.0013s | 0.0014s | **0.9x** |
| mktemp | mktemp default | - | 0.0016s | - |
| mktemp | mktemp -d directory | - | 0.0015s | - |
| mv | mv 1MB file | 0.0027s | 0.0026s | **1.0x** |
| mv | mv 10MB file | 0.0068s | 0.0070s | **1.0x** |
| nice | nice true (default priority) | 0.0010s | 0.0011s | **0.9x** |
| nice | nice -n 10 true | 0.0009s | 0.0011s | **0.9x** |
| nohup | nohup true | 0.0015s | 0.0016s | **0.9x** |
| nproc | nproc (no args) | 0.0006s | 0.0008s | **0.8x** |
| nproc | nproc --all | 0.0006s | 0.0008s | **0.8x** |
| pathchk | pathchk default | 0.0006s | 0.0008s | **0.8x** |
| pathchk | pathchk -p (POSIX portable) | 0.0006s | 0.0008s | **0.8x** |
| pwd | pwd (no args) | 0.0000s | 0.0008s | **0.0x** |
| pwd | pwd -L | 0.0000s | 0.0008s | **0.0x** |
| pwd | pwd -P | 0.0000s | 0.0008s | **0.0x** |
| readlink | readlink symlink | 0.0006s | 0.0008s | **0.8x** |
| readlink | readlink -f (canonicalize) | 0.0006s | 0.0008s | **0.8x** |
| realpath | realpath . | 0.0007s | 0.0008s | **0.8x** |
| realpath | realpath /tmp | 0.0006s | 0.0008s | **0.8x** |
| realpath | realpath test data file | 0.0006s | 0.0008s | **0.8x** |
| rev | reverse 100KB text | 0.0018s | 0.0009s | **1.9x** |
| rev | reverse 1MB text | 0.0120s | 0.0018s | **6.7x** |
| rev | reverse 10MB text | 0.1109s | 0.0079s | **14.0x** |
| rev | reverse 100MB text | 1.1074s | 0.0736s | **15.1x** |
| rev | reverse CSV 10MB | 0.0850s | 0.0072s | **11.8x** |
| rev | reverse repetitive 10MB | 0.2426s | 0.0105s | **23.1x** |
| rev | reverse 10KB single line | 0.0007s | 0.0008s | **0.9x** |
| rm | rm single file | 0.0015s | 0.0017s | **0.9x** |
| rm | rm -rf directory | 0.0037s | 0.0047s | **0.8x** |
| rmdir | rmdir single empty directory | 0.0014s | 0.0015s | **0.9x** |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0069s | 0.0071s | **1.0x** |
| seq | seq 1 10000000 | 0.0628s | 0.0610s | **1.0x** |
| seq | seq 0 0.1 100000 (float) | 0.2192s | 0.0174s | **12.6x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2285s | 0.0118s | **19.4x** |
| sha1sum | single 1MB text | 0.0016s | 0.0028s | **0.6x** |
| sha1sum | single 10MB text | 0.0077s | 0.0097s | **0.8x** |
| sha1sum | single 10MB binary | 0.0086s | 0.0097s | **0.9x** |
| sha1sum | 100 files | 0.0013s | 0.0029s | **0.5x** |
| sha224sum | single 1MB text | 0.0018s | 0.0032s | **0.6x** |
| sha224sum | single 10MB text | 0.0100s | 0.0116s | **0.9x** |
| sha224sum | single 10MB binary | 0.0106s | 0.0119s | **0.9x** |
| sha384sum | single 1MB text | 0.0026s | 0.0040s | **0.7x** |
| sha384sum | single 10MB text | 0.0182s | 0.0194s | **0.9x** |
| sha384sum | single 10MB binary | 0.0184s | 0.0200s | **0.9x** |
| sha512sum | single 1MB text | 0.0026s | 0.0039s | **0.7x** |
| sha512sum | single 10MB text | 0.0178s | 0.0194s | **0.9x** |
| sha512sum | single 10MB binary | 0.0188s | 0.0203s | **0.9x** |
| shred | shred 1MB file | 0.0096s | 0.0048s | **2.0x** |
| shred | shred 1MB file with remove (-u) | 0.0180s | 0.0061s | **2.9x** |
| sleep | sleep 0 (startup overhead) | 0.0007s | 0.0008s | **0.8x** |
| sleep | sleep 0.001 (tiny sleep) | 0.0017s | 0.0018s | **0.9x** |
| sort | lexicographic 1MB | 0.0075s | 0.0036s | **2.1x** |
| sort | lexicographic 10MB random | 0.0517s | 0.0104s | **5.0x** |
| sort | already sorted 10MB | 0.0229s | 0.0047s | **4.9x** |
| sort | reverse sorted 10MB | 0.0229s | 0.0057s | **4.0x** |
| sort | -n numeric 10MB | 0.0708s | 0.0058s | **12.3x** |
| sort | -r reverse 10MB | 0.0520s | 0.0098s | **5.3x** |
| sort | -u unique 10MB | 0.0561s | 0.0101s | **5.6x** |
| sort | -t, -k2 CSV 10MB | 0.0661s | 0.0364s | **1.8x** |
| sort | repetitive 10MB | 0.0501s | 0.0137s | **3.6x** |
| sort | --parallel=4 10MB | 0.0525s | 0.0107s | **4.9x** |
| split | split 10MB into 1MB chunks (-b 1m) | - | - | - |
| split | split 10MB by 1000 lines (-l 1000) | 0.0109s | 0.0114s | **1.0x** |
| sum | single 1MB text | 0.0024s | 0.0022s | **1.1x** |
| sum | single 10MB text | 0.0179s | 0.0145s | **1.2x** |
| sum | single 10MB binary | 0.0190s | 0.0151s | **1.3x** |
| sync | sync (no args) | 0.0006s | 0.0008s | **0.7x** |
| tee | tee 1MB to /dev/null | 0.0012s | 0.0015s | **0.8x** |
| tee | tee 10MB to /dev/null | 0.0050s | 0.0052s | **1.0x** |
| test | test -f (file exists) | 0.0000s | 0.0009s | **0.1x** |
| test | test 1 -eq 1 | 0.0000s | 0.0007s | **0.0x** |
| test | test 'hello' = 'hello' | 0.0000s | 0.0008s | **0.0x** |
| test | test -d /tmp | 0.0000s | 0.0008s | **0.0x** |
| touch | create new file | 0.0012s | 0.0014s | **0.8x** |
| touch | update existing file timestamp | 0.0006s | 0.0008s | **0.8x** |
| touch | set specific timestamp (-t) | 0.0012s | 0.0015s | **0.8x** |
| tr | a-z to A-Z 1MB | 0.0017s | 0.0014s | **1.2x** |
| tr | a-z to A-Z 10MB | 0.0076s | 0.0038s | **2.0x** |
| tr | -d digits 10MB | 0.0155s | 0.0041s | **3.8x** |
| tr | -d lowercase 10MB | 0.0279s | 0.0047s | **5.9x** |
| tr | -s spaces 10MB | 0.0245s | 0.0037s | **6.7x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0075s | 0.0039s | **1.9x** |
| tr | -d [:digit:] 10MB CSV | 0.0156s | 0.0040s | **3.9x** |
| tr | translate binary 10MB | 0.0080s | 0.0039s | **2.0x** |
| true | true (startup overhead) | 0.0000s | 0.0006s | **0.1x** |
| truncate | truncate to zero (-s 0) | 0.0020s | 0.0022s | **0.9x** |
| truncate | create 1M file (-s 1M) | 0.0012s | 0.0014s | **0.9x** |
| tsort | tsort 100K pairs | 0.0565s | 0.0072s | **7.8x** |
| tsort | tsort 1M pairs | 0.6388s | 0.0751s | **8.5x** |
| tty | tty (no args) | 0.0006s | 0.0007s | **0.8x** |
| uname | uname (no args) | 0.0006s | 0.0008s | **0.8x** |
| uname | uname -a | 0.0006s | 0.0008s | **0.8x** |
| uname | uname -r | 0.0006s | 0.0009s | **0.7x** |
| uname | uname -m | 0.0006s | 0.0008s | **0.8x** |
| uniq | default 10MB many duplicates | 0.0086s | 0.0014s | **6.2x** |
| uniq | default 10MB sorted (low dup) | 0.0184s | 0.0029s | **6.4x** |
| uniq | -c count 10MB many dups | 0.0092s | 0.0014s | **6.5x** |
| uniq | -c count 10MB sorted | 0.0294s | 0.0070s | **4.2x** |
| uniq | -d duplicates only 10MB | 0.0093s | 0.0014s | **6.7x** |
| uniq | -u unique only 10MB | 0.0092s | 0.0014s | **6.6x** |
| uniq | -i case insensitive 10MB | 0.0183s | 0.0042s | **4.3x** |
| uniq | repetitive 10MB | 0.0489s | 0.0028s | **17.4x** |
| unlink | unlink a file | 0.0015s | 0.0017s | **0.8x** |
| whoami | whoami (no args) | 0.0007s | 0.0009s | **0.7x** |
| yes | startup --help | 0.0006s | 0.0001s | **4.0x** |
| yes | startup --version | 0.0006s | 0.0001s | **5.0x** |
| yes | throughput 1M lines | 0.0024s | 0.0024s | **1.0x** |
| yes | throughput 10M lines | 0.0170s | 0.0174s | **1.0x** |
| yes | throughput hello 1M lines | 0.0059s | 0.0061s | **1.0x** |
| yes | throughput hello 10M lines | 0.0556s | 0.0528s | **1.1x** |
| yes | throughput 100MB | 0.0298s | 0.0323s | **0.9x** |
