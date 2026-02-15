# fcoreutils v0.0.29 — Detailed Results

Generated: 2026-02-15 03:00:13 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 413 | 397 | 16 | 96.1% |
| Linux_aarch64 | 413 | 402 | 11 | 97.3% |
| Linux_x86_64 | 236 | 21 | 215 | 8.9% |

**Overall: 820/1062 (77.2%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0011s | 0.0011s | **1.0x** |
| wc | default 1MB text | 0.0039s | 0.0028s | **1.4x** |
| wc | default 10MB text | 0.0343s | 0.0171s | **2.0x** |
| wc | default 100MB text | 0.2967s | 0.0436s | **6.8x** |
| wc | -l 10MB text | 0.0045s | 0.0024s | **1.9x** |
| wc | -w 10MB text | 0.0342s | 0.0170s | **2.0x** |
| wc | -c 10MB text | 0.0008s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0343s | 0.0021s | **16.6x** |
| wc | -L 10MB text | 0.0343s | 0.0172s | **2.0x** |
| wc | default 10MB binary | 0.2353s | 0.0599s | **3.9x** |
| wc | default 10MB repetitive | 0.0512s | 0.0072s | **7.1x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0014s | 0.0015s | **1.0x** |
| cut | -b1-100 10MB CSV | 0.0187s | 0.0053s | **3.5x** |
| cut | -c1-100 10MB CSV | 0.0186s | 0.0051s | **3.7x** |
| cut | -d, -f1 10MB CSV | 0.0188s | 0.0052s | **3.6x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0213s | 0.0059s | **3.6x** |
| cut | -d, -f2-4 10MB CSV | 0.0232s | 0.0060s | **3.9x** |
| cut | --complement -d, -f1 10MB CSV | 0.0265s | 0.0067s | **3.9x** |
| cut | -d, -f1 100KB text | 0.0008s | 0.0009s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0035s | 0.0029s | **1.2x** |
| cut | -d: -f1 colon file | 0.0008s | 0.0009s | **0.9x** |
| sha256sum | single 100KB text | 0.0013s | 0.0010s | **1.2x** |
| sha256sum | single 1MB text | 0.0018s | 0.0019s | **1.0x** |
| sha256sum | single 10MB text | 0.0080s | 0.0085s | **0.9x** |
| sha256sum | single 10MB binary | 0.0083s | 0.0089s | **0.9x** |
| sha256sum | single 100MB text | 0.0662s | 0.0724s | **0.9x** |
| sha256sum | 10 files | 0.0013s | 0.0009s | **1.3x** |
| sha256sum | 100 files | 0.0019s | 0.0015s | **1.3x** |
| md5sum | single 100KB text | 0.0014s | 0.0012s | **1.2x** |
| md5sum | single 1MB text | 0.0033s | 0.0029s | **1.1x** |
| md5sum | single 10MB text | 0.0213s | 0.0176s | **1.2x** |
| md5sum | single 10MB binary | 0.0222s | 0.0183s | **1.2x** |
| md5sum | single 100MB text | 0.1979s | 0.1621s | **1.2x** |
| md5sum | 10 files | 0.0012s | 0.0010s | **1.2x** |
| md5sum | 100 files | 0.0018s | 0.0015s | **1.2x** |
| b2sum | single 100KB text | 0.0010s | 0.0011s | **0.9x** |
| b2sum | single 1MB text | 0.0022s | 0.0026s | **0.8x** |
| b2sum | single 10MB text | 0.0143s | 0.0148s | **1.0x** |
| b2sum | single 10MB binary | 0.0149s | 0.0154s | **1.0x** |
| b2sum | single 100MB text | 0.1329s | 0.1347s | **1.0x** |
| b2sum | -l 256 10MB | 0.0143s | 0.0148s | **1.0x** |
| b2sum | -l 128 10MB | 0.0143s | 0.0148s | **1.0x** |
| b2sum | 100 files | 0.0017s | 0.0015s | **1.1x** |
| base64 | encode 100KB text | 0.0010s | 0.0011s | **0.9x** |
| base64 | encode 1MB text | 0.0018s | 0.0030s | **0.6x** |
| base64 | encode 10MB text | 0.0101s | 0.0065s | **1.6x** |
| base64 | encode 10MB binary | 0.0105s | 0.0065s | **1.6x** |
| base64 | decode 1MB | 0.0039s | 0.0031s | **1.2x** |
| base64 | decode 10MB | 0.0309s | 0.0197s | **1.6x** |
| base64 | encode -w 76 10MB | 0.0100s | 0.0064s | **1.6x** |
| base64 | encode -w 0 (no wrap) 10MB | 0.0081s | 0.0049s | **1.6x** |
| sort | lexicographic 1MB | 0.0078s | 0.0051s | **1.5x** |
| sort | lexicographic 10MB random | 0.0553s | 0.0199s | **2.8x** |
| sort | already sorted 10MB | 0.0253s | 0.0066s | **3.8x** |
| sort | reverse sorted 10MB | 0.0249s | 0.0118s | **2.1x** |
| sort | -n numeric 10MB | 0.0757s | 0.0062s | **12.2x** |
| sort | -r reverse 10MB | 0.0567s | 0.0201s | **2.8x** |
| sort | -u unique 10MB | 0.0577s | 0.0209s | **2.8x** |
| sort | -t, -k2 CSV 10MB | 0.0760s | 0.0563s | **1.3x** |
| sort | repetitive 10MB | 0.0443s | 0.0142s | **3.1x** |
| sort | --parallel=4 10MB | 0.0554s | 0.0202s | **2.7x** |
| tr | a-z to A-Z 1MB | 0.0023s | 0.0017s | **1.3x** |
| tr | a-z to A-Z 10MB | 0.0089s | 0.0061s | **1.5x** |
| tr | -d digits 10MB | 0.0111s | 0.0098s | **1.1x** |
| tr | -d lowercase 10MB | 0.0189s | 0.0166s | **1.1x** |
| tr | -s spaces 10MB | 0.0166s | 0.0138s | **1.2x** |
| tr | [:lower:] to [:upper:] 10MB | 0.0088s | 0.0063s | **1.4x** |
| tr | -d [:digit:] 10MB CSV | 0.0111s | 0.0098s | **1.1x** |
| tr | translate binary 10MB | 0.0094s | 0.0065s | **1.5x** |
| uniq | default 10MB many duplicates | 0.0094s | 0.0055s | **1.7x** |
| uniq | default 10MB sorted (low dup) | 0.0163s | 0.0069s | **2.4x** |
| uniq | -c count 10MB many dups | 0.0094s | 0.0056s | **1.7x** |
| uniq | -c count 10MB sorted | 0.0293s | 0.0100s | **2.9x** |
| uniq | -d duplicates only 10MB | 0.0094s | 0.0055s | **1.7x** |
| uniq | -u unique only 10MB | 0.0093s | 0.0055s | **1.7x** |
| uniq | -i case insensitive 10MB | 0.0163s | 0.0075s | **2.2x** |
| uniq | repetitive 10MB | 0.0466s | 0.0078s | **5.9x** |
| tac | reverse 100KB text | 0.0009s | 0.0010s | **0.9x** |
| tac | reverse 1MB text | 0.0017s | 0.0020s | **0.9x** |
| tac | reverse 10MB text | 0.0090s | 0.0072s | **1.2x** |
| tac | reverse 100MB text | 0.0833s | 0.0395s | **2.1x** |
| tac | reverse CSV 10MB | 0.0082s | 0.0061s | **1.3x** |
| tac | reverse repetitive 10MB | 0.0173s | 0.0092s | **1.9x** |
| tac | custom separator 1MB | 0.0046s | 0.0034s | **1.4x** |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | N/A | - | - |
| wc | default 1MB text | N/A | - | - |
| wc | default 10MB text | N/A | - | - |
| wc | default 100MB text | N/A | - | - |
| wc | -l 10MB text | N/A | - | - |
| wc | -w 10MB text | N/A | - | - |
| wc | -c 10MB text | N/A | - | - |
| wc | -m 10MB text | N/A | - | - |
| wc | -L 10MB text | N/A | - | - |
| wc | default 10MB binary | N/A | - | - |
| wc | default 10MB repetitive | N/A | - | - |
| wc | 10 files | N/A | - | - |
| wc | 100 files | N/A | - | - |
| cut | -b1-100 10MB CSV | N/A | - | - |
| cut | -c1-100 10MB CSV | N/A | - | - |
| cut | -d, -f1 10MB CSV | N/A | - | - |
| cut | -d, -f1,3,5 10MB CSV | N/A | - | - |
| cut | -d, -f2-4 10MB CSV | N/A | - | - |
| cut | --complement -d, -f1 10MB CSV | N/A | - | - |
| cut | -d, -f1 100KB text | N/A | - | - |
| cut | -d, -f1 1MB text | N/A | - | - |
| cut | -d: -f1 colon file | N/A | - | - |
| sha256sum | single 100KB text | N/A | - | - |
| sha256sum | single 1MB text | N/A | - | - |
| sha256sum | single 10MB text | N/A | - | - |
| sha256sum | single 10MB binary | N/A | - | - |
| sha256sum | single 100MB text | N/A | - | - |
| sha256sum | 10 files | N/A | - | - |
| sha256sum | 100 files | N/A | - | - |
| md5sum | single 100KB text | N/A | - | - |
| md5sum | single 1MB text | N/A | - | - |
| md5sum | single 10MB text | N/A | - | - |
| md5sum | single 10MB binary | N/A | - | - |
| md5sum | single 100MB text | N/A | - | - |
| md5sum | 10 files | N/A | - | - |
| md5sum | 100 files | N/A | - | - |
| b2sum | single 100KB text | N/A | - | - |
| b2sum | single 1MB text | N/A | - | - |
| b2sum | single 10MB text | N/A | - | - |
| b2sum | single 10MB binary | N/A | - | - |
| b2sum | single 100MB text | N/A | - | - |
| b2sum | -l 256 10MB | N/A | - | - |
| b2sum | -l 128 10MB | N/A | - | - |
| b2sum | 100 files | N/A | - | - |
| base64 | encode 100KB text | N/A | - | - |
| base64 | encode 1MB text | N/A | - | - |
| base64 | encode 10MB text | N/A | - | - |
| base64 | encode 10MB binary | N/A | - | - |
| base64 | decode 1MB | N/A | - | - |
| base64 | decode 10MB | N/A | - | - |
| base64 | encode -w 76 10MB | N/A | - | - |
| base64 | encode -w 0 (no wrap) 10MB | N/A | - | - |
| sort | lexicographic 1MB | N/A | - | - |
| sort | lexicographic 10MB random | N/A | - | - |
| sort | already sorted 10MB | N/A | - | - |
| sort | reverse sorted 10MB | N/A | - | - |
| sort | -n numeric 10MB | N/A | - | - |
| sort | -r reverse 10MB | N/A | - | - |
| sort | -u unique 10MB | N/A | - | - |
| sort | -t, -k2 CSV 10MB | N/A | - | - |
| sort | repetitive 10MB | N/A | - | - |
| sort | --parallel=4 10MB | N/A | - | - |
| tr | a-z to A-Z 1MB | N/A | - | - |
| tr | a-z to A-Z 10MB | N/A | - | - |
| tr | -d digits 10MB | N/A | - | - |
| tr | -d lowercase 10MB | N/A | - | - |
| tr | -s spaces 10MB | N/A | - | - |
| tr | [:lower:] to [:upper:] 10MB | N/A | - | - |
| tr | -d [:digit:] 10MB CSV | N/A | - | - |
| tr | translate binary 10MB | N/A | - | - |
| uniq | default 10MB many duplicates | N/A | - | - |
| uniq | default 10MB sorted (low dup) | N/A | - | - |
| uniq | -c count 10MB many dups | N/A | - | - |
| uniq | -c count 10MB sorted | N/A | - | - |
| uniq | -d duplicates only 10MB | N/A | - | - |
| uniq | -u unique only 10MB | N/A | - | - |
| uniq | -i case insensitive 10MB | N/A | - | - |
| uniq | repetitive 10MB | N/A | - | - |
| tac | reverse 100KB text | N/A | - | - |
| tac | reverse 1MB text | N/A | - | - |
| tac | reverse 10MB text | N/A | - | - |
| tac | reverse 100MB text | N/A | - | - |
| tac | reverse CSV 10MB | N/A | - | - |
| tac | reverse repetitive 10MB | N/A | - | - |
| tac | custom separator 1MB | N/A | - | - |
