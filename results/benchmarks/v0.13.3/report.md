# fcoreutils v0.13.3 — Detailed Results

Generated: 2026-02-26 04:00:36 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|------:|-------:|-------:|----------:|
| Darwin_arm64 | 388 | 276 | 76 | 71.1% |
| aarch64-pc-windows-msvc | 0 | 0 | 0 | N/A |

## Performance (Linux x86_64)

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|----------:|-----------------:|--------:|
| arch | arch (no args) | 0.0009s | 0.0010s | **0.9x** |
| base32 | encode 100KB text | 0.0011s | 0.0012s | **0.9x** |
| base32 | encode 1MB text | 0.0025s | 0.0035s | **0.7x** |
| base32 | encode 10MB text | 0.0159s | 0.0254s | **0.6x** |
| base32 | encode 10MB binary | 0.0168s | 0.0266s | **0.6x** |
| base32 | decode 1MB | 0.0035s | 0.0026s | **1.3x** |
| base32 | decode 10MB | 0.0270s | 0.0173s | **1.6x** |
| base64 | encode 100KB text | 0.0011s | 0.0013s | **0.9x** |
| base64 | encode 1MB text | 0.0023s | 0.0016s | **1.5x** |
| base64 | encode 10MB text | 0.0142s | 0.0051s | **2.8x** |
| base64 | encode 10MB binary | 0.0153s | 0.0053s | **2.9x** |
| base64 | decode 1MB | 0.0044s | 0.0021s | **2.1x** |
| base64 | decode 10MB | 0.0328s | 0.0049s | **6.8x** |
| base64 | encode -w 76 10MB | 0.0142s | 0.0051s | **2.8x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0100s | 0.0041s | **2.4x** |
| basename | basename simple path | 0.0009s | 0.0010s | **0.9x** |
| basename | basename with suffix (.txt) | 0.0009s | 0.0010s | **0.9x** |
| basenc | encode --base64 1MB | 0.0022s | 0.0020s | **1.1x** |
| basenc | encode --base64 10MB | 0.0136s | 0.0107s | **1.3x** |
| basenc | encode --base32 1MB | 0.0025s | 0.0022s | **1.2x** |
| basenc | encode --base16 1MB | 0.0027s | 0.0020s | **1.4x** |
| basenc | decode --base64 -d 1MB | 0.0041s | 0.0032s | **1.3x** |
| chgrp | chgrp current group on file | 0.0025s | 0.0026s | **1.0x** |
| chgrp | chgrp current group on 1MB file | 0.0033s | 0.0034s | **1.0x** |
| chmod | chmod 644 on file | 0.0024s | 0.0025s | **1.0x** |
| chmod | chmod u+x on file | 0.0024s | 0.0025s | **1.0x** |
| chown | chown current user on file | 0.0025s | 0.0026s | **1.0x** |
| chown | chown current user on 1MB file | 0.0033s | 0.0035s | **0.9x** |
| cksum | single 1MB text | 0.0016s | 0.0012s | **1.3x** |
| cksum | single 10MB text | 0.0034s | 0.0026s | **1.3x** |
| cksum | single 10MB binary | 0.0032s | 0.0028s | **1.1x** |
| cp | cp 1MB file | 0.0030s | 0.0028s | **1.1x** |
| cp | cp 10MB file | 0.0104s | 0.0102s | **1.0x** |
| cp | cp -r directory (many_files) | 0.0078s | 0.0065s | **1.2x** |
| csplit | csplit 1MB by pattern | 0.4761s | 0.0248s | **19.2x** |
| cut | -b1-100 10MB CSV | 0.0232s | 0.0041s | **5.7x** |
| cut | -c1-100 10MB CSV | 0.0232s | 0.0041s | **5.6x** |
| cut | -d, -f1 10MB CSV | 0.0186s | 0.0097s | **1.9x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0230s | 0.0111s | **2.1x** |
| cut | -d, -f2-4 10MB CSV | 0.0248s | 0.0112s | **2.2x** |
| cut | --complement -d, -f1 10MB CSV | 0.0321s | 0.0112s | **2.9x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0012s | **0.8x** |
| cut | -d, -f1 1MB text | 0.0037s | 0.0030s | **1.2x** |
| cut | -d: -f1 colon file | 0.0010s | 0.0012s | **0.8x** |
| dd | dd read 10MB (bs=4096) | 0.0061s | 0.0058s | **1.0x** |
| dd | dd write 10MB from /dev/zero (bs=1M count=10) | 0.0105s | 0.0118s | **0.9x** |
| dirname | dirname simple path | 0.0009s | 0.0010s | **0.9x** |
| dirname | dirname deep path | 0.0009s | 0.0010s | **0.9x** |
| echo | echo hello | 0.0009s | 0.0010s | **0.9x** |
| echo | echo -n hello | 0.0009s | 0.0010s | **0.9x** |
| echo | echo -e with escapes | 0.0009s | 0.0010s | **0.9x** |
| env | print all env vars | 0.0009s | 0.0011s | **0.8x** |
| env | env true (run command) | 0.0014s | 0.0015s | **0.9x** |
| env | env VAR=value true | 0.0014s | 0.0015s | **0.9x** |
| expr | expr 1 + 1 | 0.0010s | 0.0011s | **0.9x** |
| expr | expr 999999 * 999999 | 0.0010s | 0.0011s | **0.9x** |
| expr | expr length 'hello world' | 0.0010s | 0.0011s | **0.9x** |
| expr | expr 'hello' : 'hel' | 0.0010s | 0.0012s | **0.8x** |
| factor | factor 1234567890 | 0.0010s | 0.0010s | **1.0x** |
| factor | factor 999999999999999989 (large prime) | 0.0010s | 0.0010s | **1.0x** |
| factor | factor 1-100000 via stdin | 0.0176s | 0.1173s | **0.1x** |
| false | false (startup overhead) | 0.0000s | 0.0008s | **0.0x** |
| groups | groups (no args) | 0.0010s | 0.0011s | **0.9x** |
| hostid | hostid (no args) | 0.0010s | 0.0011s | **0.9x** |
| id | id (no args) | 0.0013s | 0.0012s | **1.1x** |
| id | id -u | 0.0011s | 0.0010s | **1.1x** |
| id | id -g | 0.0011s | 0.0010s | **1.1x** |
| id | id -un | 0.0012s | 0.0011s | **1.1x** |
| install | install 1MB file | 0.0030s | 0.0028s | **1.1x** |
| install | install -d create directory | 0.0025s | 0.0022s | **1.1x** |
| link | hard link a file | 0.0018s | 0.0019s | **0.9x** |
| ln | symlink single file | 0.0018s | 0.0020s | **0.9x** |
| ln | symlink force overwrite (-sf) | 0.0019s | 0.0020s | **0.9x** |
| ln | hard link single file | 0.0018s | 0.0020s | **0.9x** |
| logname | logname (no args) | 0.0009s | 0.0010s | **0.9x** |
| mkdir | mkdir single directory | 0.0021s | 0.0020s | **1.0x** |
| mkdir | mkdir -p nested directories | 0.0024s | 0.0024s | **1.0x** |
| mkfifo | mkfifo single fifo | 0.0020s | 0.0020s | **1.0x** |
| mknod | mknod named pipe | 0.0020s | 0.0019s | **1.1x** |
| mktemp | mktemp default | - | 0.0022s | - |
| mktemp | mktemp -d directory | - | 0.0022s | - |
| mv | mv 1MB file | 0.0043s | 0.0041s | **1.0x** |
| mv | mv 10MB file | 0.0116s | 0.0113s | **1.0x** |
| nice | nice true (default priority) | 0.0014s | 0.0015s | **1.0x** |
| nice | nice -n 10 true | 0.0014s | 0.0015s | **1.0x** |
| nohup | nohup true | 0.0023s | 0.0024s | **1.0x** |
| nproc | nproc (no args) | 0.0009s | 0.0011s | **0.9x** |
| nproc | nproc --all | 0.0009s | 0.0010s | **0.9x** |
| pathchk | pathchk default | 0.0009s | 0.0010s | **0.9x** |
| pathchk | pathchk -p (POSIX portable) | 0.0009s | 0.0010s | **0.9x** |
| pwd | pwd (no args) | 0.0000s | 0.0010s | **0.0x** |
| pwd | pwd -L | 0.0000s | 0.0010s | **0.0x** |
| pwd | pwd -P | 0.0001s | 0.0010s | **0.1x** |
| readlink | readlink symlink | 0.0009s | 0.0010s | **0.9x** |
| readlink | readlink -f (canonicalize) | 0.0009s | 0.0010s | **0.9x** |
| realpath | realpath . | 0.0009s | 0.0010s | **0.9x** |
| realpath | realpath /tmp | 0.0009s | 0.0010s | **0.9x** |
| realpath | realpath test data file | 0.0009s | 0.0010s | **0.9x** |
| rev | reverse 100KB text | 0.0024s | 0.0011s | **2.1x** |
| rev | reverse 1MB text | 0.0149s | 0.0019s | **7.9x** |
| rev | reverse 10MB text | 0.1390s | 0.0079s | **17.6x** |
| rev | reverse 100MB text | 1.3798s | 0.0753s | **18.3x** |
| rev | reverse CSV 10MB | 0.1022s | 0.0078s | **13.1x** |
| rev | reverse repetitive 10MB | 0.2934s | 0.0125s | **23.5x** |
| rev | reverse 10KB single line | 0.0011s | 0.0010s | **1.1x** |
| rm | rm single file | 0.0023s | 0.0024s | **0.9x** |
| rm | rm -rf directory | 0.0078s | 0.0079s | **1.0x** |
| rmdir | rmdir single empty directory | 0.0020s | 0.0022s | **0.9x** |
| rmdir | rmdir -p nested directories | - | - | - |
| seq | seq 1000000 | 0.0099s | 0.0084s | **1.2x** |
| seq | seq 1 10000000 | 0.0930s | 0.0728s | **1.3x** |
| seq | seq 0 0.1 100000 (float) | 0.2151s | 0.1697s | **1.3x** |
| seq | seq -w 1 1000000 (zero-padded) | 0.2289s | 0.0148s | **15.5x** |
| sha1sum | single 1MB text | 0.0022s | 0.0036s | **0.6x** |
| sha1sum | single 10MB text | 0.0090s | 0.0115s | **0.8x** |
| sha1sum | single 10MB binary | 0.0096s | 0.0113s | **0.9x** |
| sha1sum | 100 files | 0.0027s | 0.0036s | **0.8x** |
| sha224sum | single 1MB text | 0.0022s | 0.0036s | **0.6x** |
| sha224sum | single 10MB text | 0.0095s | 0.0107s | **0.9x** |
| sha224sum | single 10MB binary | 0.0100s | 0.0114s | **0.9x** |
| sha384sum | single 1MB text | 0.0030s | 0.0044s | **0.7x** |
| sha384sum | single 10MB text | 0.0173s | 0.0185s | **0.9x** |
| sha384sum | single 10MB binary | 0.0185s | 0.0195s | **0.9x** |
| sha512sum | single 1MB text | 0.0030s | 0.0044s | **0.7x** |
| sha512sum | single 10MB text | 0.0172s | 0.0184s | **0.9x** |
| sha512sum | single 10MB binary | 0.0182s | 0.0195s | **0.9x** |
| shred | shred 1MB file | 0.0079s | 0.0062s | **1.3x** |
| shred | shred 1MB file with remove (-u) | 0.0137s | 0.0073s | **1.9x** |
| sleep | sleep 0 (startup overhead) | 0.0010s | 0.0010s | **0.9x** |
| sleep | sleep 0.001 (tiny sleep) | 0.0020s | 0.0021s | **1.0x** |
| sort | lexicographic 1MB | 0.0089s | 0.0039s | **2.3x** |
| sort | lexicographic 10MB random | 0.0565s | 0.0098s | **5.8x** |
| sort | already sorted 10MB | 0.0253s | 0.0050s | **5.1x** |
| sort | reverse sorted 10MB | 0.0276s | 0.0066s | **4.2x** |
| sort | -n numeric 10MB | 0.0760s | 0.0056s | **13.6x** |
| sort | -r reverse 10MB | 0.0573s | 0.0093s | **6.2x** |
| sort | -u unique 10MB | 0.0609s | 0.0107s | **5.7x** |
| sort | -t, -k2 CSV 10MB | 0.0708s | 0.0402s | **1.8x** |
| sort | repetitive 10MB | 0.0473s | 0.0127s | **3.7x** |
| sort | --parallel=4 10MB | 0.0561s | 0.0092s | **6.1x** |
| split | split 10MB into 1MB chunks (-b 1m) | - | - | - |
| split | split 10MB by 1000 lines (-l 1000) | 0.0181s | 0.0181s | **1.0x** |
| sum | single 1MB text | 0.0028s | 0.0025s | **1.1x** |
| sum | single 10MB text | 0.0197s | 0.0163s | **1.2x** |
| sum | single 10MB binary | 0.0210s | 0.0171s | **1.2x** |
| sync | sync (no args) | 0.0009s | 0.0010s | **0.9x** |
| tee | tee 1MB to /dev/null | 0.0019s | 0.0018s | **1.0x** |
| tee | tee 10MB to /dev/null | 0.0081s | 0.0056s | **1.5x** |
| test | test -f (file exists) | 0.0000s | 0.0010s | **0.0x** |
| test | test 1 -eq 1 | 0.0000s | 0.0010s | **0.0x** |
| test | test 'hello' = 'hello' | 0.0000s | 0.0010s | **0.0x** |
| test | test -d /tmp | 0.0000s | 0.0010s | **0.0x** |
| touch | create new file | 0.0019s | 0.0020s | **0.9x** |
| touch | update existing file timestamp | 0.0009s | 0.0010s | **0.9x** |
| touch | set specific timestamp (-t) | 0.0019s | 0.0020s | **0.9x** |
| tr | a-z to A-Z 1MB | 0.0024s | 0.0016s | **1.4x** |
| tr | a-z to A-Z 10MB | 0.0129s | 0.0041s | **3.1x** |
| tr | -d digits 10MB | 0.0192s | 0.0046s | **4.2x** |
| tr | -d lowercase 10MB | 0.0336s | 0.0055s | **6.2x** |
| tr | -s spaces 10MB | 0.0291s | 0.0041s | **7.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0133s | 0.0041s | **3.3x** |
| tr | -d [:digit:] 10MB CSV | 0.0185s | 0.0048s | **3.8x** |
| tr | translate binary 10MB | 0.0128s | 0.0044s | **2.9x** |
| true | true (startup overhead) | 0.0000s | 0.0008s | **0.0x** |
| truncate | truncate to zero (-s 0) | 0.0032s | 0.0034s | **0.9x** |
| truncate | create 1M file (-s 1M) | 0.0018s | 0.0020s | **0.9x** |
| tsort | tsort 100K pairs | 0.0624s | 0.0250s | **2.5x** |
| tsort | tsort 1M pairs | 0.6984s | 0.5647s | **1.2x** |
| tty | tty (no args) | 0.0009s | 0.0010s | **0.9x** |
| uname | uname (no args) | 0.0009s | 0.0010s | **0.9x** |
| uname | uname -a | 0.0009s | 0.0010s | **0.9x** |
| uname | uname -r | 0.0009s | 0.0010s | **0.9x** |
| uname | uname -m | 0.0009s | 0.0010s | **0.9x** |
| uniq | default 10MB many duplicates | 0.0115s | 0.0021s | **5.5x** |
| uniq | default 10MB sorted (low dup) | 0.0142s | 0.0030s | **4.7x** |
| uniq | -c count 10MB many dups | 0.0117s | 0.0021s | **5.6x** |
| uniq | -c count 10MB sorted | 0.0259s | 0.0087s | **3.0x** |
| uniq | -d duplicates only 10MB | 0.0117s | 0.0021s | **5.6x** |
| uniq | -u unique only 10MB | 0.0118s | 0.0022s | **5.4x** |
| uniq | -i case insensitive 10MB | 0.0145s | 0.0048s | **3.0x** |
| uniq | repetitive 10MB | 0.0312s | 0.0037s | **8.5x** |
| unlink | unlink a file | 0.0023s | 0.0024s | **1.0x** |
| whoami | whoami (no args) | 0.0010s | 0.0011s | **0.9x** |
| yes | startup --help | 0.0009s | 0.0002s | **3.9x** |
| yes | startup --version | 0.0010s | 0.0002s | **4.2x** |
| yes | throughput 1M lines | 0.0036s | 0.0038s | **1.0x** |
| yes | throughput 10M lines | 0.0276s | 0.0271s | **1.0x** |
| yes | throughput hello 1M lines | 0.0082s | 0.0082s | **1.0x** |
| yes | throughput hello 10M lines | 0.0666s | 0.0628s | **1.1x** |
| yes | throughput 100MB | 0.0584s | 0.0592s | **1.0x** |
