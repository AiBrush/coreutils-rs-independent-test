#!/usr/bin/env bash
# Generate test data files for fcoreutils testing
set -euo pipefail

TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"
mkdir -p "$TEST_DATA_DIR"

echo "Generating test data in $TEST_DATA_DIR ..."

# ── Empty and tiny files ──────────────────────────────────────────────────────
touch "$TEST_DATA_DIR/empty.txt"
printf 'a' > "$TEST_DATA_DIR/single_byte.txt"
printf 'hello' > "$TEST_DATA_DIR/no_trailing_newline.txt"
printf 'hello\n' > "$TEST_DATA_DIR/with_trailing_newline.txt"
printf '\n' > "$TEST_DATA_DIR/single_newline.txt"
printf '\n\n\n' > "$TEST_DATA_DIR/only_newlines.txt"

# ── Whitespace-only files ─────────────────────────────────────────────────────
printf '   \t  \n  \t\t  \n    \n' > "$TEST_DATA_DIR/whitespace_only.txt"
printf '   ' > "$TEST_DATA_DIR/spaces_no_newline.txt"
printf '\t\t\t' > "$TEST_DATA_DIR/tabs_no_newline.txt"

# ── Line ending variants ─────────────────────────────────────────────────────
printf 'line1\nline2\nline3\n' > "$TEST_DATA_DIR/unix_endings.txt"
printf 'line1\r\nline2\r\nline3\r\n' > "$TEST_DATA_DIR/dos_endings.txt"
printf 'line1\rline2\rline3\r' > "$TEST_DATA_DIR/cr_endings.txt"
printf 'line1\nline2\r\nline3\rline4\n' > "$TEST_DATA_DIR/mixed_endings.txt"

# ── Unicode / multibyte ──────────────────────────────────────────────────────
printf 'Hello, 世界!\n你好世界\nこんにちは\n' > "$TEST_DATA_DIR/cjk.txt"
printf '🎉🚀🎯\n😀😃😄\n' > "$TEST_DATA_DIR/emoji.txt"
printf 'caf\xc3\xa9\n' > "$TEST_DATA_DIR/utf8_accent.txt"
printf 'I\xcc\x88\n' > "$TEST_DATA_DIR/combining_umlaut.txt"
printf '\xc3\xa9\xc3\xa8\xc3\xaa\n\xc3\xbc\xc3\xb6\xc3\xa4\n' > "$TEST_DATA_DIR/utf8_multibyte.txt"

# ── Binary data ──────────────────────────────────────────────────────────────
dd if=/dev/urandom of="$TEST_DATA_DIR/random_1k.bin" bs=1024 count=1 2>/dev/null
printf '\x00\x01\x02\x80\x81\xfe\xff' > "$TEST_DATA_DIR/null_bytes.bin"
printf 'text\x00with\x00nulls\n' > "$TEST_DATA_DIR/text_with_nulls.txt"

# ── Long lines ───────────────────────────────────────────────────────────────
python3 -c "print('A' * 10000)" > "$TEST_DATA_DIR/long_line_10k.txt"
python3 -c "print('B' * 1048576)" > "$TEST_DATA_DIR/long_line_1m.txt"

# ── Tab files (for wc -L) ────────────────────────────────────────────────────
printf 'a\tb\tc\n' > "$TEST_DATA_DIR/tabs.txt"
printf '\t\t\t\n' > "$TEST_DATA_DIR/only_tabs.txt"
printf 'abcdefg\thij\n' > "$TEST_DATA_DIR/tab_at_8.txt"

# ── CSV / delimited data ────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/simple.csv" <<'EOF'
name,age,city
Alice,30,New York
Bob,25,London
Charlie,35,Paris
EOF

cat > "$TEST_DATA_DIR/colon_delimited.txt" <<'EOF'
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
EOF

cat > "$TEST_DATA_DIR/tsv_data.txt" <<'EOF'
name	age	city	country
Alice	30	New York	USA
Bob	25	London	UK
Charlie	35	Paris	France
EOF

# ── Sort test data ───────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/unsorted.txt" <<'EOF'
banana
apple
cherry
date
elderberry
fig
grape
apple
banana
EOF

cat > "$TEST_DATA_DIR/numeric_unsorted.txt" <<'EOF'
10
2
30
1
20
100
5
50
EOF

cat > "$TEST_DATA_DIR/human_sizes.txt" <<'EOF'
1G
500M
2K
1T
100
10M
5G
200K
EOF

cat > "$TEST_DATA_DIR/versions.txt" <<'EOF'
1.2.3
1.10.1
1.2.10
1.1.0
2.0.0
1.2.3-alpha
1.2.3-beta
0.9.9
EOF

cat > "$TEST_DATA_DIR/months.txt" <<'EOF'
March
January
December
June
April
February
EOF

# ── Duplicate data (for uniq) ────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/duplicates.txt" <<'EOF'
apple
apple
banana
banana
banana
cherry
apple
apple
date
EOF

cat > "$TEST_DATA_DIR/case_duplicates.txt" <<'EOF'
Hello
hello
HELLO
World
world
WORLD
EOF

cat > "$TEST_DATA_DIR/adjacent_unique.txt" <<'EOF'
one
two
three
four
five
EOF

# ── tr test data ─────────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/lowercase.txt" <<'EOF'
hello world
foo bar baz
the quick brown fox
EOF

cat > "$TEST_DATA_DIR/mixed_case.txt" <<'EOF'
Hello World
FOO BAR BAZ
The Quick Brown Fox
EOF

cat > "$TEST_DATA_DIR/digits_and_letters.txt" <<'EOF'
abc123def456
Hello World 2024
foo42bar99baz0
EOF

cat > "$TEST_DATA_DIR/squeeze_input.txt" <<'EOF'
hello    world
foo		bar
multiple      spaces     here
EOF

# ── base64 test data ────────────────────────────────────────────────────────
printf 'Hello, World!\n' > "$TEST_DATA_DIR/base64_input.txt"
printf 'SGVsbG8sIFdvcmxkIQo=' > "$TEST_DATA_DIR/base64_encoded.txt"
printf 'SGVsbG8sIFdvcmxkIQo=\n' > "$TEST_DATA_DIR/base64_encoded_newline.txt"
printf 'This is invalid base64 !!!@@@' > "$TEST_DATA_DIR/base64_garbage.txt"
printf 'SGVs!!!bG8s@@@IFdv%%%cmxk###IQo=\n' > "$TEST_DATA_DIR/base64_with_garbage.txt"

# ── Checksum test data ──────────────────────────────────────────────────────
printf '' > "$TEST_DATA_DIR/checksum_empty.txt"
printf 'abc' > "$TEST_DATA_DIR/checksum_abc.txt"
printf 'The quick brown fox jumps over the lazy dog' > "$TEST_DATA_DIR/checksum_fox.txt"

# ── tac test data ────────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/tac_simple.txt" <<'EOF'
line 1
line 2
line 3
line 4
line 5
EOF

printf 'line 1\nline 2\nline 3' > "$TEST_DATA_DIR/tac_no_trailing_newline.txt"
printf 'one line\n' > "$TEST_DATA_DIR/tac_single_line.txt"

cat > "$TEST_DATA_DIR/tac_separator.txt" <<'EOF'
part1---part2---part3---part4
EOF

# ── Null-separated data ─────────────────────────────────────────────────────
printf 'file1.txt\0file2.txt\0file3.txt\0' > "$TEST_DATA_DIR/null_separated.txt"
printf 'line1\0line2\0line3\0' > "$TEST_DATA_DIR/null_terminated.txt"

# ── Medium-sized files (for benchmarks) ─────────────────────────────────────

# 100KB text
if [[ ! -f "$TEST_DATA_DIR/text_100k.txt" ]]; then
    python3 -c "
import random, string
random.seed(42)
words = ['the','quick','brown','fox','jumps','over','lazy','dog','lorem','ipsum','dolor','sit','amet']
lines = []
size = 0
while size < 100000:
    line = ' '.join(random.choices(words, k=random.randint(5,15)))
    lines.append(line)
    size += len(line) + 1
print('\n'.join(lines))
" > "$TEST_DATA_DIR/text_100k.txt"
fi

# 1MB text
if [[ ! -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
    python3 -c "
import random, string
random.seed(42)
words = ['the','quick','brown','fox','jumps','over','lazy','dog','lorem','ipsum','dolor','sit','amet']
lines = []
size = 0
while size < 1000000:
    line = ' '.join(random.choices(words, k=random.randint(5,15)))
    lines.append(line)
    size += len(line) + 1
print('\n'.join(lines))
" > "$TEST_DATA_DIR/text_1m.txt"
fi

# 10MB text
if [[ ! -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
    python3 -c "
import random, string
random.seed(42)
words = ['the','quick','brown','fox','jumps','over','lazy','dog','lorem','ipsum','dolor','sit','amet',
         'consectetur','adipiscing','elit','sed','do','eiusmod','tempor','incididunt','ut','labore']
lines = []
size = 0
while size < 10000000:
    line = ' '.join(random.choices(words, k=random.randint(5,20)))
    lines.append(line)
    size += len(line) + 1
print('\n'.join(lines))
" > "$TEST_DATA_DIR/text_10m.txt"
fi

# CSV 10MB
if [[ ! -f "$TEST_DATA_DIR/csv_10m.csv" ]]; then
    python3 -c "
import random
random.seed(42)
names = ['Alice','Bob','Charlie','Diana','Eve','Frank','Grace','Heidi','Ivan','Judy']
cities = ['New York','London','Paris','Tokyo','Sydney','Berlin','Toronto','Mumbai','Beijing','Cairo']
print('id,name,age,city,salary,department')
for i in range(200000):
    print(f'{i},{random.choice(names)},{random.randint(20,65)},{random.choice(cities)},{random.randint(30000,150000)},{random.choice([\"Engineering\",\"Sales\",\"Marketing\",\"HR\",\"Finance\"])}')
" > "$TEST_DATA_DIR/csv_10m.csv"
fi

# 100MB text (for large benchmarks)
if [[ ! -f "$TEST_DATA_DIR/text_100m.txt" ]] && [[ "${GENERATE_LARGE:-false}" == "true" ]]; then
    echo "Generating 100MB text file (this takes a moment)..."
    python3 -c "
import random
random.seed(42)
words = ['the','quick','brown','fox','jumps','over','lazy','dog','lorem','ipsum','dolor','sit','amet']
size = 0
while size < 100000000:
    line = ' '.join(random.choices(words, k=random.randint(5,20)))
    print(line)
    size += len(line) + 1
" > "$TEST_DATA_DIR/text_100m.txt"
fi

# 1GB text (for huge benchmarks)
if [[ ! -f "$TEST_DATA_DIR/text_1g.txt" ]] && [[ "${GENERATE_HUGE:-false}" == "true" ]]; then
    echo "Generating 1GB text file (this takes a while)..."
    python3 -c "
import random
random.seed(42)
words = ['the','quick','brown','fox','jumps','over','lazy','dog','lorem','ipsum','dolor','sit','amet']
size = 0
while size < 1000000000:
    line = ' '.join(random.choices(words, k=random.randint(5,20)))
    print(line)
    size += len(line) + 1
" > "$TEST_DATA_DIR/text_1g.txt"
fi

# Random binary (10MB)
if [[ ! -f "$TEST_DATA_DIR/random_10m.bin" ]]; then
    dd if=/dev/urandom of="$TEST_DATA_DIR/random_10m.bin" bs=1M count=10 2>/dev/null
fi

# Repetitive content
if [[ ! -f "$TEST_DATA_DIR/repetitive_10m.txt" ]]; then
    python3 -c "
for i in range(500000):
    print('All work and no play makes Jack a dull boy')
" > "$TEST_DATA_DIR/repetitive_10m.txt"
fi

# Sorted data (10MB)
if [[ ! -f "$TEST_DATA_DIR/sorted_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
lines = [''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=random.randint(5,50))) for _ in range(200000)]
for line in sorted(lines):
    print(line)
" > "$TEST_DATA_DIR/sorted_10m.txt"
fi

# Reverse sorted data (10MB)
if [[ ! -f "$TEST_DATA_DIR/reverse_sorted_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
lines = [''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=random.randint(5,50))) for _ in range(200000)]
for line in sorted(lines, reverse=True):
    print(line)
" > "$TEST_DATA_DIR/reverse_sorted_10m.txt"
fi

# Random lines (10MB) for sort benchmarks
if [[ ! -f "$TEST_DATA_DIR/random_lines_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
for _ in range(200000):
    print(''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=random.randint(5,50))))
" > "$TEST_DATA_DIR/random_lines_10m.txt"
fi

# Many-duplicates data for uniq benchmarks
if [[ ! -f "$TEST_DATA_DIR/many_duplicates_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
values = ['apple','banana','cherry','date','elderberry','fig','grape','honeydew','kiwi','lemon']
for _ in range(500000):
    print(random.choice(values))
" | sort > "$TEST_DATA_DIR/many_duplicates_10m.txt"
fi

# ── Special filename tests ──────────────────────────────────────────────────
mkdir -p "$TEST_DATA_DIR/special_names"
echo "content" > "$TEST_DATA_DIR/special_names/file with spaces.txt"
echo "content" > "$TEST_DATA_DIR/special_names/file'with'quotes.txt"
echo "content" > "$TEST_DATA_DIR/special_names/file\"with\"doublequotes.txt"
echo "content" > "$TEST_DATA_DIR/special_names/-dashfile.txt"

# ── Symlinks ─────────────────────────────────────────────────────────────────
ln -sf "$TEST_DATA_DIR/simple.csv" "$TEST_DATA_DIR/symlink_to_csv" 2>/dev/null || true
ln -sf "$TEST_DATA_DIR/unsorted.txt" "$TEST_DATA_DIR/symlink_to_unsorted" 2>/dev/null || true

# ── Multiple small files for batch tests ────────────────────────────────────
mkdir -p "$TEST_DATA_DIR/many_files"
for i in $(seq 1 100); do
    echo "File number $i with some content to make it non-trivial" > "$TEST_DATA_DIR/many_files/file_$(printf '%04d' $i).txt"
done

# ── Permission test files ───────────────────────────────────────────────────
echo "readable" > "$TEST_DATA_DIR/readable.txt"
echo "unreadable" > "$TEST_DATA_DIR/unreadable.txt"
chmod 000 "$TEST_DATA_DIR/unreadable.txt" 2>/dev/null || true

# ── head / tail test data ──────────────────────────────────────────────────
python3 -c "
for i in range(1, 101):
    print(f'Line {i}: The quick brown fox jumps over the lazy dog')
" > "$TEST_DATA_DIR/numbered_100.txt"

python3 -c "
for i in range(1, 10001):
    print(f'Line {i}')
" > "$TEST_DATA_DIR/numbered_10k.txt"

# Single line no newline for head/tail edge cases
printf 'single line no newline' > "$TEST_DATA_DIR/single_line_no_nl.txt"

# ── cat test data ─────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/cat_special_chars.txt" <<'CATEOF'
Line with tab	here
Line with trailing spaces
   Leading spaces line

Blank line above and below

Last line
CATEOF

# File with non-printing chars for cat -v
printf 'visible\x01\x02\x03hidden\x7f\n' > "$TEST_DATA_DIR/cat_nonprinting.txt"
# File with consecutive blank lines for cat -s
printf 'line1\n\n\n\nline2\n\n\nline3\n' > "$TEST_DATA_DIR/cat_squeeze.txt"

# ── rev test data ─────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/rev_simple.txt" <<'EOF'
hello
world
12345
abcdef
EOF

printf 'no newline at end' > "$TEST_DATA_DIR/rev_no_newline.txt"
printf '\n\n\n' > "$TEST_DATA_DIR/rev_blank_lines.txt"

# ── expand / unexpand test data ───────────────────────────────────────────
printf 'no\ttabs\there\n' > "$TEST_DATA_DIR/expand_simple.txt"
printf '\ttab at start\n' > "$TEST_DATA_DIR/expand_leading.txt"
printf 'a\tb\tc\td\te\n' > "$TEST_DATA_DIR/expand_multi.txt"
printf '\t\t\tdouble\t\ttabs\n' > "$TEST_DATA_DIR/expand_consecutive.txt"
printf '12345678\tnext\n1234567\tnext\n123456\tnext\n1\tnext\n' > "$TEST_DATA_DIR/expand_alignment.txt"
# Mixed tabs and spaces
printf '  \tspaces then tab\n\t  tab then spaces\n' > "$TEST_DATA_DIR/expand_mixed.txt"
# File with only tabs
printf '\t\t\t\t\n' > "$TEST_DATA_DIR/expand_only_tabs.txt"
# Spaces for unexpand
printf '        eight spaces\n    four spaces\n            twelve spaces\n' > "$TEST_DATA_DIR/unexpand_spaces.txt"
printf '        word1        word2        word3\n' > "$TEST_DATA_DIR/unexpand_multi_stops.txt"

# ── fold test data ────────────────────────────────────────────────────────
python3 -c "print('A' * 200)" > "$TEST_DATA_DIR/fold_long_line.txt"
python3 -c "print('word ' * 40)" > "$TEST_DATA_DIR/fold_words.txt"
printf 'short\n' > "$TEST_DATA_DIR/fold_short.txt"
printf 'a b c d e f g h i j k l m n o p q r s t u v w x y z\n' > "$TEST_DATA_DIR/fold_alphabet.txt"
# Line with tabs for fold -b vs fold
printf 'abc\tdef\tghi\tjkl\tmno\tpqr\tstu\tvwx\n' > "$TEST_DATA_DIR/fold_tabs.txt"

# ── paste test data ───────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/paste_file1.txt" <<'EOF'
alpha
bravo
charlie
delta
echo
EOF

cat > "$TEST_DATA_DIR/paste_file2.txt" <<'EOF'
1
2
3
4
5
EOF

cat > "$TEST_DATA_DIR/paste_file3.txt" <<'EOF'
red
green
blue
EOF

# Unequal length files
printf 'A\nB\n' > "$TEST_DATA_DIR/paste_short.txt"
printf 'X\nY\nZ\nW\n' > "$TEST_DATA_DIR/paste_long.txt"

# ── nl test data ──────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/nl_simple.txt" <<'EOF'
First line
Second line
Third line
Fourth line
Fifth line
EOF

cat > "$TEST_DATA_DIR/nl_blank_lines.txt" <<'EOF'
Line one

Line three


Line six
EOF

# nl section delimiters
cat > "$TEST_DATA_DIR/nl_sections.txt" <<'NLEOF'
\:\:\:
Header line 1
Header line 2
\:\:
Body line 1
Body line 2
Body line 3
\:
Footer line 1
Footer line 2
\:\:\:
Header 2 line 1
\:\:
Body 2 line 1
Body 2 line 2
\:
Footer 2 line 1
NLEOF

# ── comm test data ────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/comm_file1.txt" <<'EOF'
apple
banana
cherry
date
fig
grape
EOF

cat > "$TEST_DATA_DIR/comm_file2.txt" <<'EOF'
banana
cherry
elderberry
fig
honeydew
EOF

# Files with no overlap
cat > "$TEST_DATA_DIR/comm_disjoint1.txt" <<'EOF'
alpha
bravo
charlie
EOF

cat > "$TEST_DATA_DIR/comm_disjoint2.txt" <<'EOF'
delta
echo
foxtrot
EOF

# Identical files
cat > "$TEST_DATA_DIR/comm_identical.txt" <<'EOF'
one
two
three
EOF

# ── join test data ────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/join_file1.txt" <<'EOF'
1 Alice Engineering
2 Bob Sales
3 Charlie Marketing
4 Diana HR
5 Eve Finance
EOF

cat > "$TEST_DATA_DIR/join_file2.txt" <<'EOF'
1 50000
2 60000
3 55000
5 70000
6 45000
EOF

# Join with custom delimiter
cat > "$TEST_DATA_DIR/join_csv1.txt" <<'EOF'
1,Alice,Engineering
2,Bob,Sales
3,Charlie,Marketing
4,Diana,HR
EOF

cat > "$TEST_DATA_DIR/join_csv2.txt" <<'EOF'
1,50000,New York
2,60000,London
3,55000,Paris
5,70000,Tokyo
EOF

# Join on different fields
cat > "$TEST_DATA_DIR/join_byname1.txt" <<'EOF'
Alice Engineering
Bob Sales
Charlie Marketing
Diana HR
EOF

cat > "$TEST_DATA_DIR/join_byname2.txt" <<'EOF'
Alice 50000
Bob 60000
Charlie 55000
Eve 70000
EOF

# ── Large files for new tools benchmarks ──────────────────────────────────

# Tabbed text 10MB (for expand/unexpand benchmarks)
if [[ ! -f "$TEST_DATA_DIR/tabbed_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
words = ['the','quick','brown','fox','jumps','over','lazy','dog','lorem','ipsum']
size = 0
while size < 10000000:
    line = '\t'.join(random.choices(words, k=random.randint(3,8)))
    print(line)
    size += len(line) + 1
" > "$TEST_DATA_DIR/tabbed_10m.txt"
fi

# Wide lines 10MB (for fold benchmarks)
if [[ ! -f "$TEST_DATA_DIR/wide_lines_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
words = ['the','quick','brown','fox','jumps','over','lazy','dog']
size = 0
while size < 10000000:
    line = ' '.join(random.choices(words, k=random.randint(20,60)))
    print(line)
    size += len(line) + 1
" > "$TEST_DATA_DIR/wide_lines_10m.txt"
fi

# Numbered lines 10MB (for nl benchmarks)
if [[ ! -f "$TEST_DATA_DIR/nl_bench_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
words = ['the','quick','brown','fox','jumps','over','lazy','dog','lorem','ipsum']
size = 0
i = 0
while size < 10000000:
    if i % 5 == 0:
        print('')  # blank line every 5 lines
    else:
        line = ' '.join(random.choices(words, k=random.randint(5,15)))
        print(line)
        size += len(line) + 1
    i += 1
" > "$TEST_DATA_DIR/nl_bench_10m.txt"
fi

# Sorted pair files 10MB each (for comm/join benchmarks)
if [[ ! -f "$TEST_DATA_DIR/comm_bench_file1_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
lines = set()
while len(lines) < 200000:
    lines.add(''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=random.randint(8,30))))
lines = sorted(lines)
# First file: every other line + some unique
for i, line in enumerate(lines):
    if i % 2 == 0 or i % 7 == 0:
        print(line)
" > "$TEST_DATA_DIR/comm_bench_file1_10m.txt"
fi

if [[ ! -f "$TEST_DATA_DIR/comm_bench_file2_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
lines = set()
while len(lines) < 200000:
    lines.add(''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=random.randint(8,30))))
lines = sorted(lines)
# Second file: odd lines + some unique
for i, line in enumerate(lines):
    if i % 2 == 1 or i % 5 == 0:
        print(line)
" > "$TEST_DATA_DIR/comm_bench_file2_10m.txt"
fi

# Join benchmark files (sorted, keyed)
if [[ ! -f "$TEST_DATA_DIR/join_bench_file1_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
for i in range(1, 400001, 2):
    name = ''.join(random.choices('abcdefghijklmnopqrstuvwxyz', k=random.randint(5,15)))
    print(f'{i} {name} {random.randint(20,65)}')
" > "$TEST_DATA_DIR/join_bench_file1_10m.txt"
fi

if [[ ! -f "$TEST_DATA_DIR/join_bench_file2_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
for i in range(1, 400001, 3):
    dept = random.choice(['Engineering','Sales','Marketing','HR','Finance'])
    print(f'{i} {dept} {random.randint(30000,150000)}')
" > "$TEST_DATA_DIR/join_bench_file2_10m.txt"
fi

# Paste benchmark files (many columns)
if [[ ! -f "$TEST_DATA_DIR/paste_bench_col1_10m.txt" ]]; then
    python3 -c "
import random
random.seed(42)
words = ['alpha','bravo','charlie','delta','echo','foxtrot','golf','hotel']
for _ in range(500000):
    print(random.choice(words))
" > "$TEST_DATA_DIR/paste_bench_col1_10m.txt"
fi

if [[ ! -f "$TEST_DATA_DIR/paste_bench_col2_10m.txt" ]]; then
    python3 -c "
import random
random.seed(43)
for _ in range(500000):
    print(random.randint(1, 99999))
" > "$TEST_DATA_DIR/paste_bench_col2_10m.txt"
fi

if [[ ! -f "$TEST_DATA_DIR/paste_bench_col3_10m.txt" ]]; then
    python3 -c "
import random
random.seed(44)
cities = ['NYC','LON','PAR','TKY','SYD','BER','TOR','MUM']
for _ in range(500000):
    print(random.choice(cities))
" > "$TEST_DATA_DIR/paste_bench_col3_10m.txt"
fi

# ── basenc / base32 test data ────────────────────────────────────────────────
printf 'Hello, World!\n' > "$TEST_DATA_DIR/basenc_input.txt"
printf 'Short' > "$TEST_DATA_DIR/basenc_short.txt"
dd if=/dev/urandom of="$TEST_DATA_DIR/basenc_binary.bin" bs=256 count=1 2>/dev/null
printf '' > "$TEST_DATA_DIR/basenc_empty.txt"
printf 'JBSWY3DPEB3W64TMMQ======\n' > "$TEST_DATA_DIR/base32_encoded.txt"
printf 'Line one\nLine two\nLine three\n' > "$TEST_DATA_DIR/basenc_multiline.txt"

# ── seq test data ────────────────────────────────────────────────────────────
# (seq generates its own data, but we need reference files for some tests)

# ── tsort test data ──────────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/tsort_simple.txt" <<'EOF'
a b
b c
c d
EOF

cat > "$TEST_DATA_DIR/tsort_diamond.txt" <<'EOF'
a b
a c
b d
c d
EOF

cat > "$TEST_DATA_DIR/tsort_single.txt" <<'EOF'
a a
EOF

cat > "$TEST_DATA_DIR/tsort_multi_roots.txt" <<'EOF'
a c
b c
c d
d e
EOF

cat > "$TEST_DATA_DIR/tsort_cycle.txt" <<'EOF'
a b
b c
c a
EOF

# ── dircolors test data ─────────────────────────────────────────────────────
cat > "$TEST_DATA_DIR/dircolors_custom.txt" <<'EOF'
# Custom dircolors configuration
TERM xterm
TERM xterm-256color
NORMAL 0
FILE 0
DIR 01;34
LINK 01;36
EXEC 01;32
.tar 01;31
.gz 01;31
.zip 01;31
.jpg 01;35
.png 01;35
.mp3 00;36
EOF

# ── Symlink targets for readlink/realpath tests ──────────────────────────────
mkdir -p "$TEST_DATA_DIR/symlink_tests"
echo "target content" > "$TEST_DATA_DIR/symlink_tests/target.txt"
ln -sf "$TEST_DATA_DIR/symlink_tests/target.txt" "$TEST_DATA_DIR/symlink_tests/link1" 2>/dev/null || true
ln -sf "$TEST_DATA_DIR/symlink_tests/link1" "$TEST_DATA_DIR/symlink_tests/link2" 2>/dev/null || true
ln -sf "/nonexistent/path" "$TEST_DATA_DIR/symlink_tests/broken_link" 2>/dev/null || true
ln -sf "relative_target.txt" "$TEST_DATA_DIR/symlink_tests/relative_link" 2>/dev/null || true
echo "relative target" > "$TEST_DATA_DIR/symlink_tests/relative_target.txt"

echo "Test data generation complete: $TEST_DATA_DIR"
ls -la "$TEST_DATA_DIR/" | head -30
echo "..."
du -sh "$TEST_DATA_DIR"
