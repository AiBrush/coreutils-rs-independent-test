# fcoreutils v0.0.6 — Detailed Results

Generated: 2026-02-17 03:18:07 UTC

## Compatibility

| Platform | Tests | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|-----------|
| Darwin_arm64 | 209 | 183 | 26 | 87.6% |
| Linux_aarch64 | 209 | 181 | 28 | 86.6% |
| Linux_x86_64 | 209 | 181 | 28 | 86.6% |
| MINGW64_NT-10.0-26100_x86_64 | 0 | 0 | 0 | N/A |

**Overall: 545/627 (86.9%)**

## Performance

### Linux_aarch64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0010s | 0.0009s | **1.1x** |
| wc | default 1MB text | 0.0036s | 0.0019s | **1.9x** |
| wc | default 10MB text | 0.0345s | 0.0125s | **2.8x** |
| wc | default 100MB text | 0.2912s | 0.1179s | **2.5x** |
| wc | -l 10MB text | 0.0044s | 0.0022s | **2.0x** |
| wc | -w 10MB text | 0.0342s | 0.0120s | **2.9x** |
| wc | -c 10MB text | 0.0007s | 0.0008s | **0.9x** |
| wc | -m 10MB text | 0.0344s | 0.0284s | **1.2x** |
| wc | -L 10MB text | 0.0345s | 0.0199s | **1.7x** |
| wc | default 10MB binary | 0.2342s | 0.0130s | **18.0x** |
| wc | default 10MB repetitive | 0.0509s | 0.0257s | **2.0x** |
| wc | 10 files | 0.0008s | 0.0009s | **0.9x** |
| wc | 100 files | 0.0012s | 0.0013s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0183s | 0.0043s | **4.3x** |
| cut | -c1-100 10MB CSV | 0.0185s | 0.0044s | **4.2x** |
| cut | -d, -f1 10MB CSV | 0.0184s | 0.0100s | **1.8x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0211s | 0.0118s | **1.8x** |
| cut | -d, -f2-4 10MB CSV | 0.0230s | 0.0109s | **2.1x** |
| cut | --complement -d, -f1 10MB CSV | 0.0264s | 0.0127s | **2.1x** |
| cut | -d, -f1 100KB text | 0.0007s | 0.0008s | **0.9x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0023s | **1.5x** |
| cut | -d: -f1 colon file | 0.0007s | 0.0007s | **0.9x** |
| sha256sum | single 100KB text | 0.0010s | 0.0010s | **1.0x** |
| sha256sum | single 1MB text | 0.0016s | 0.0034s | **0.5x** |
| sha256sum | single 10MB text | 0.0072s | 0.0273s | **0.3x** |
| sha256sum | single 10MB binary | 0.0073s | 0.0277s | **0.3x** |
| sha256sum | single 100MB text | 0.0612s | 0.2527s | **0.2x** |
| sha256sum | 10 files | 0.0010s | 0.0009s | **1.2x** |
| sha256sum | 100 files | 0.0017s | 0.0015s | **1.1x** |
| md5sum | single 100KB text | 0.0012s | 0.0010s | **1.2x** |
| md5sum | single 1MB text | 0.0030s | 0.0025s | **1.2x** |
| md5sum | single 10MB text | 0.0205s | 0.0169s | **1.2x** |
| md5sum | single 10MB binary | 0.0215s | 0.0172s | **1.2x** |
| md5sum | single 100MB text | 0.1926s | 0.1565s | **1.2x** |
| md5sum | 10 files | 0.0015s | 0.0012s | **1.2x** |
| md5sum | 100 files | 0.0022s | 0.0020s | **1.1x** |
| b2sum | single 100KB text | 0.0009s | 0.0009s | **1.0x** |
| b2sum | single 1MB text | 0.0020s | 0.0020s | **1.0x** |
| b2sum | single 10MB text | 0.0136s | 0.0134s | **1.0x** |
| b2sum | single 10MB binary | 0.0142s | 0.0133s | **1.1x** |
| b2sum | single 100MB text | 0.1274s | 0.1196s | **1.1x** |
| b2sum | -l 256 10MB | N/A | - | - |
| b2sum | -l 128 10MB | N/A | - | - |
| b2sum | 100 files | 0.0016s | 0.0017s | **0.9x** |
| base64 | - | - | - | N/A |
| sort | - | - | - | N/A |
| tr | - | - | - | N/A |
| uniq | - | - | - | N/A |
| tac | - | - | - | N/A |

### Linux_x86_64

| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |
|------|------|-----------|-------------------|---------|
| wc | default 100KB text | 0.0014s | 0.0011s | **1.2x** |
| wc | default 1MB text | 0.0059s | 0.0028s | **2.1x** |
| wc | default 10MB text | 0.0547s | 0.0192s | **2.9x** |
| wc | default 100MB text | 0.4827s | 0.1537s | **3.1x** |
| wc | -l 10MB text | 0.0023s | 0.0022s | **1.1x** |
| wc | -w 10MB text | 0.0545s | 0.0189s | **2.9x** |
| wc | -c 10MB text | 0.0009s | 0.0009s | **1.0x** |
| wc | -m 10MB text | 0.0547s | 0.0048s | **11.3x** |
| wc | -L 10MB text | 0.0545s | 0.0252s | **2.2x** |
| wc | default 10MB binary | 0.3175s | 0.0109s | **29.2x** |
| wc | default 10MB repetitive | 0.0728s | 0.0182s | **4.0x** |
| wc | 10 files | 0.0010s | 0.0010s | **1.0x** |
| wc | 100 files | 0.0019s | 0.0021s | **0.9x** |
| cut | -b1-100 10MB CSV | 0.0229s | 0.0056s | **4.1x** |
| cut | -c1-100 10MB CSV | 0.0229s | 0.0056s | **4.1x** |
| cut | -d, -f1 10MB CSV | 0.0168s | 0.0148s | **1.1x** |
| cut | -d, -f1,3,5 10MB CSV | 0.0227s | 0.0188s | **1.2x** |
| cut | -d, -f2-4 10MB CSV | 0.0246s | 0.0188s | **1.3x** |
| cut | --complement -d, -f1 10MB CSV | 0.0311s | 0.0234s | **1.3x** |
| cut | -d, -f1 100KB text | 0.0009s | 0.0008s | **1.1x** |
| cut | -d, -f1 1MB text | 0.0034s | 0.0031s | **1.1x** |
| cut | -d: -f1 colon file | 0.0009s | 0.0009s | **1.1x** |
| sha256sum | single 100KB text | 0.0014s | 0.0010s | **1.4x** |
| sha256sum | single 1MB text | 0.0021s | 0.0020s | **1.0x** |
| sha256sum | single 10MB text | 0.0088s | 0.0125s | **0.7x** |
| sha256sum | single 10MB binary | 0.0091s | 0.0118s | **0.8x** |
| sha256sum | single 100MB text | 0.0751s | 0.1039s | **0.7x** |
| sha256sum | 10 files | 0.0014s | 0.0011s | **1.3x** |
| sha256sum | 100 files | 0.0026s | 0.0022s | **1.2x** |
| md5sum | single 100KB text | 0.0015s | 0.0012s | **1.3x** |
| md5sum | single 1MB text | 0.0029s | 0.0033s | **0.9x** |
| md5sum | single 10MB text | 0.0176s | 0.0247s | **0.7x** |
| md5sum | single 10MB binary | 0.0182s | 0.0257s | **0.7x** |
| md5sum | single 100MB text | 0.1611s | 0.2320s | **0.7x** |
| md5sum | 10 files | 0.0014s | 0.0011s | **1.3x** |
| md5sum | 100 files | 0.0024s | 0.0022s | **1.1x** |
| b2sum | single 100KB text | 0.0010s | 0.0010s | **1.0x** |
| b2sum | single 1MB text | 0.0023s | 0.0024s | **1.0x** |
| b2sum | single 10MB text | 0.0153s | 0.0151s | **1.0x** |
| b2sum | single 10MB binary | 0.0160s | 0.0161s | **1.0x** |
| b2sum | single 100MB text | 0.1429s | 0.1413s | **1.0x** |
| b2sum | -l 256 10MB | N/A | - | - |
| b2sum | -l 128 10MB | N/A | - | - |
| b2sum | 100 files | 0.0022s | 0.0024s | **0.9x** |
| base64 | - | - | - | N/A |
| sort | - | - | - | N/A |
| tr | - | - | - | N/A |
| uniq | - | - | - | N/A |
| tac | - | - | - | N/A |
