#!/usr/bin/env bash
# Compatibility tests for fsort vs GNU sort
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "sort")
F_TOOL="fsort"

run_sort_tests() {
    init_test_suite "sort"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sort","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sort_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sort not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Lexicographic Sort ==="

    run_test "basic sort" \
        "$GNU_TOOL '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unsorted.txt'"

    run_test "empty file sort" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single line" \
        "echo 'hello' | $GNU_TOOL" \
        "echo 'hello' | $F_TOOL"

    run_test "already sorted" \
        "$GNU_TOOL '$TEST_DATA_DIR/sorted_10m.txt' | head -100" \
        "$F_TOOL '$TEST_DATA_DIR/sorted_10m.txt' | head -100"

    run_test "stdin sort" \
        "printf 'banana\napple\ncherry\n' | $GNU_TOOL" \
        "printf 'banana\napple\ncherry\n' | $F_TOOL"

    echo ""
    echo "=== Reverse Sort (-r) ==="

    run_test "-r basic" \
        "$GNU_TOOL -r '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL -r '$TEST_DATA_DIR/unsorted.txt'"

    run_test "-r single line" \
        "echo 'hello' | $GNU_TOOL -r" \
        "echo 'hello' | $F_TOOL -r"

    echo ""
    echo "=== Numeric Sort (-n) ==="

    run_test "-n numeric" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/numeric_unsorted.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/numeric_unsorted.txt'"

    run_test "-n with text" \
        "printf '10\n2\nabc\n1\n' | $GNU_TOOL -n" \
        "printf '10\n2\nabc\n1\n' | $F_TOOL -n"

    run_test "-n reverse" \
        "$GNU_TOOL -nr '$TEST_DATA_DIR/numeric_unsorted.txt'" \
        "$F_TOOL -nr '$TEST_DATA_DIR/numeric_unsorted.txt'"

    run_test "-n with leading spaces" \
        "printf '  10\n 2\n  30\n1\n' | $GNU_TOOL -n" \
        "printf '  10\n 2\n  30\n1\n' | $F_TOOL -n"

    run_test "-n with negatives" \
        "printf '10\n-5\n0\n-100\n50\n' | $GNU_TOOL -n" \
        "printf '10\n-5\n0\n-100\n50\n' | $F_TOOL -n"

    run_test "-n with decimals" \
        "printf '1.5\n1.10\n1.2\n0.9\n' | $GNU_TOOL -n" \
        "printf '1.5\n1.10\n1.2\n0.9\n' | $F_TOOL -n"

    echo ""
    echo "=== Human Numeric Sort (-h) ==="

    run_test "-h human sizes" \
        "$GNU_TOOL -h '$TEST_DATA_DIR/human_sizes.txt'" \
        "$F_TOOL -h '$TEST_DATA_DIR/human_sizes.txt'"

    run_test "-h reverse" \
        "$GNU_TOOL -hr '$TEST_DATA_DIR/human_sizes.txt'" \
        "$F_TOOL -hr '$TEST_DATA_DIR/human_sizes.txt'"

    echo ""
    echo "=== Version Sort (-V) ==="

    run_test "-V versions" \
        "$GNU_TOOL -V '$TEST_DATA_DIR/versions.txt'" \
        "$F_TOOL -V '$TEST_DATA_DIR/versions.txt'"

    run_test "-V reverse" \
        "$GNU_TOOL -Vr '$TEST_DATA_DIR/versions.txt'" \
        "$F_TOOL -Vr '$TEST_DATA_DIR/versions.txt'"

    echo ""
    echo "=== Month Sort (-M) ==="

    run_test "-M months" \
        "$GNU_TOOL -M '$TEST_DATA_DIR/months.txt'" \
        "$F_TOOL -M '$TEST_DATA_DIR/months.txt'"

    echo ""
    echo "=== Unique (-u) ==="

    run_test "-u unique" \
        "$GNU_TOOL -u '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL -u '$TEST_DATA_DIR/unsorted.txt'"

    run_test "-u numeric unique" \
        "$GNU_TOOL -nu '$TEST_DATA_DIR/numeric_unsorted.txt'" \
        "$F_TOOL -nu '$TEST_DATA_DIR/numeric_unsorted.txt'"

    run_test "-u all same" \
        "printf 'a\na\na\n' | $GNU_TOOL -u" \
        "printf 'a\na\na\n' | $F_TOOL -u"

    run_test "-u all unique" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -u" \
        "printf 'a\nb\nc\n' | $F_TOOL -u"

    echo ""
    echo "=== Case Insensitive (-f) ==="

    run_test "-f case insensitive" \
        "printf 'Banana\napple\nCherry\n' | $GNU_TOOL -f" \
        "printf 'Banana\napple\nCherry\n' | $F_TOOL -f"

    echo ""
    echo "=== Dictionary Order (-d) ==="

    run_test "-d dictionary order" \
        "printf 'hello world\nhello-world\nhello_world\nhelloworld\n' | $GNU_TOOL -d" \
        "printf 'hello world\nhello-world\nhello_world\nhelloworld\n' | $F_TOOL -d"

    echo ""
    echo "=== Ignore Non-Printing (-i) ==="

    run_test "-i ignore non-printing" \
        "printf 'abc\ndef\n\x01ghi\n' | $GNU_TOOL -i" \
        "printf 'abc\ndef\n\x01ghi\n' | $F_TOOL -i"

    echo ""
    echo "=== Ignore Leading Blanks (-b) ==="

    run_test "-b ignore leading blanks" \
        "printf '  banana\napple\n  cherry\n' | $GNU_TOOL -b" \
        "printf '  banana\napple\n  cherry\n' | $F_TOOL -b"

    echo ""
    echo "=== Key Sorting (-k) ==="

    run_test "-k2 (sort by field 2)" \
        "$GNU_TOOL -t, -k2 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k2 '$TEST_DATA_DIR/simple.csv'"

    run_test "-k2,2 (sort by exactly field 2)" \
        "$GNU_TOOL -t, -k2,2 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k2,2 '$TEST_DATA_DIR/simple.csv'"

    run_test "-k2n (numeric sort by field 2)" \
        "$GNU_TOOL -t, -k2n '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k2n '$TEST_DATA_DIR/simple.csv'"

    run_test "-k3 (sort by field 3)" \
        "$GNU_TOOL -t, -k3 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k3 '$TEST_DATA_DIR/simple.csv'"

    run_test "-k1,1 -k2,2n (multi-key)" \
        "$GNU_TOOL -t: -k1,1 -k3,3n '$TEST_DATA_DIR/colon_delimited.txt'" \
        "$F_TOOL -t: -k1,1 -k3,3n '$TEST_DATA_DIR/colon_delimited.txt'"

    echo ""
    echo "=== Field Separator (-t) ==="

    run_test "-t: colon separator" \
        "$GNU_TOOL -t: -k1 '$TEST_DATA_DIR/colon_delimited.txt'" \
        "$F_TOOL -t: -k1 '$TEST_DATA_DIR/colon_delimited.txt'"

    run_test "-t, comma separator" \
        "$GNU_TOOL -t, -k1 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k1 '$TEST_DATA_DIR/simple.csv'"

    echo ""
    echo "=== Stable Sort (-s) ==="

    run_test "-s stable" \
        "$GNU_TOOL -s -t, -k2,2 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -s -t, -k2,2 '$TEST_DATA_DIR/simple.csv'"

    echo ""
    echo "=== Check Sorted (-c) ==="

    run_exit_code_test "-c on sorted input" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/sorted_10m.txt' 2>&1" \
        "$F_TOOL -c '$TEST_DATA_DIR/sorted_10m.txt' 2>&1"

    run_exit_code_test "-c on unsorted input" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/unsorted.txt' 2>&1" \
        "$F_TOOL -c '$TEST_DATA_DIR/unsorted.txt' 2>&1"

    echo ""
    echo "=== Output to File (-o) ==="

    local gnu_outfile="/tmp/gnu_sort_out_$$"
    local f_outfile="/tmp/f_sort_out_$$"
    register_temp "$gnu_outfile"
    register_temp "$f_outfile"

    $GNU_TOOL -o "$gnu_outfile" "$TEST_DATA_DIR/unsorted.txt"
    $F_TOOL -o "$f_outfile" "$TEST_DATA_DIR/unsorted.txt"

    local diff_result=""
    if diff_result=$(diff "$gnu_outfile" "$f_outfile" 2>&1); then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -o output file"
        record_result "-o output file" "PASS" "" "" ""
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -o output file"
        record_result "-o output file" "FAIL" "$diff_result" "" ""
    fi

    echo ""
    echo "=== General Numeric Sort (-g) ==="

    run_test "-g general numeric" \
        "printf '1.5e2\n1.5\n100\n1e3\n' | $GNU_TOOL -g" \
        "printf '1.5e2\n1.5\n100\n1e3\n' | $F_TOOL -g"

    echo ""
    echo "=== Random Sort (-R) ==="

    # Can't compare output directly (random), but check it doesn't crash and exit code matches
    run_exit_code_test "-R (random sort runs without error)" \
        "$GNU_TOOL -R '$TEST_DATA_DIR/unsorted.txt' 2>&1" \
        "$F_TOOL -R '$TEST_DATA_DIR/unsorted.txt' 2>&1"

    echo ""
    echo "=== Null-Terminated (-z) ==="

    run_test "-z null-terminated" \
        "printf 'banana\0apple\0cherry\0' | $GNU_TOOL -z" \
        "printf 'banana\0apple\0cherry\0' | $F_TOOL -z"

    echo ""
    echo "=== Merge (-m) ==="

    local sorted1
    sorted1=$(mktemp /tmp/fcoreutils_sorted1_XXXXXX)
    register_temp "$sorted1"
    printf 'apple\ncherry\ngrape\n' > "$sorted1"

    local sorted2
    sorted2=$(mktemp /tmp/fcoreutils_sorted2_XXXXXX)
    register_temp "$sorted2"
    printf 'banana\ndate\nfig\n' > "$sorted2"

    run_test "-m merge two sorted files" \
        "$GNU_TOOL -m '$sorted1' '$sorted2'" \
        "$F_TOOL -m '$sorted1' '$sorted2'"

    echo ""
    echo "=== Empty and Edge Cases ==="

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single line no newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'"

    run_test "many duplicates" \
        "printf 'a\na\nb\nb\na\na\n' | $GNU_TOOL" \
        "printf 'a\na\nb\nb\na\na\n' | $F_TOOL"

    echo ""
    echo "=== Large Files ==="

    run_test "10MB random sort" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_lines_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/random_lines_10m.txt' | md5sum"

    run_test "10MB already sorted" \
        "$GNU_TOOL '$TEST_DATA_DIR/sorted_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/sorted_10m.txt' | md5sum"

    run_test "10MB reverse sorted" \
        "$GNU_TOOL '$TEST_DATA_DIR/reverse_sorted_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/reverse_sorted_10m.txt' | md5sum"

    echo ""
    echo "=== GNU Upstream: Float Sort ==="

    # From sort-float.sh: equal floats recognized as duplicates
    local float_eq_tmp
    float_eq_tmp=$(make_temp_printf '10\n1e1\n')
    register_temp "$float_eq_tmp"
    run_test "-gu equal floats (10 vs 1e1)" \
        "$GNU_TOOL -gu '$float_eq_tmp'" \
        "$F_TOOL -gu '$float_eq_tmp'"

    # From sort-float.sh: general numeric sort with various float formats
    local float_mix_tmp
    float_mix_tmp=$(make_temp_printf '%s\n' '-1.5e2' '-100' '-1.5' '0' '1.5' '100' '1.5e2')
    register_temp "$float_mix_tmp"
    run_test "-g mixed float formats" \
        "$GNU_TOOL -g '$float_mix_tmp'" \
        "$F_TOOL -g '$float_mix_tmp'"

    # From sort-float.sh: general numeric sort with negative exponents
    local float_negexp_tmp
    float_negexp_tmp=$(make_temp_printf '1e-3\n1e-2\n1e-1\n1\n1e1\n1e2\n')
    register_temp "$float_negexp_tmp"
    run_test "-g negative exponent floats" \
        "$GNU_TOOL -g '$float_negexp_tmp'" \
        "$F_TOOL -g '$float_negexp_tmp'"

    echo ""
    echo "=== GNU Upstream: Version Sort ==="

    # From sort-version.sh: complex version strings with package names
    local ver_pkg_tmp
    ver_pkg_tmp=$(make_temp "gcc-c++-10.fc9.tar.gz
gcc-c++-10.8.12-0.7rc2.fc9.tar.bz2
glibc-2-0.1.beta1.fc10.rpm
glibc-common-5-0.2.beta2.fc9.ebuild
glibc-common-5-0.2b.deb
glibc-common-11b.ebuild
glibc-common-11-0.6rc2.ebuild
libstdc++-0.5.8.11-0.7rc2.fc10.tar.gz
libstdc++-4a.fc8.tar.gz
libstdc++-4.10.4.20040204svn.rpm
libstdc++-devel-3.fc8.ebuild
libstdc++-devel-3a.fc9.tar.gz
libstdc++-devel-8.fc8.deb
libstdc++-devel-8.6.2-0.4b.fc8
nss_ldap-1-0.2b.fc9.tar.bz2
nss_ldap-1-0.6rc2.fc8.tar.gz
nss_ldap-1.0-0.1a.tar.gz
nss_ldap-10beta1.fc8.tar.gz
nss_ldap-10.11.8.6.20040204cvs.fc10.ebuild
")
    register_temp "$ver_pkg_tmp"
    run_test "-V package version strings" \
        "$GNU_TOOL --stable --sort=version '$ver_pkg_tmp'" \
        "$F_TOOL --stable --sort=version '$ver_pkg_tmp'"

    # From sort-version.sh: embedded version numbers in strings
    local ver_embed_tmp
    ver_embed_tmp=$(make_temp "string start 5.0.0 end of str
string start 5.1.0 end of str
string start 5.10.0 end of str
string start 5.2.0 end of str
string start 5.20.0 end of str
string start 5.3.0 end of str
string start 5.30.0 end of str
string start 5.4.0 end of str
string start 5.04.0 end of str
string start 5.5.0 end of str
string start 5.9.0 end of str
")
    register_temp "$ver_embed_tmp"
    run_test "-V embedded version in strings" \
        "$GNU_TOOL --stable --sort=version '$ver_embed_tmp'" \
        "$F_TOOL --stable --sort=version '$ver_embed_tmp'"

    echo ""
    echo "=== GNU Upstream: Unique Sort ==="

    # From sort-unique.sh: basic unique with duplicates
    local uniq_basic_tmp
    uniq_basic_tmp=$(make_temp_printf '1\n2\n1\n3\n')
    register_temp "$uniq_basic_tmp"
    run_test "-u removes duplicates preserving order" \
        "$GNU_TOOL -u '$uniq_basic_tmp'" \
        "$F_TOOL -u '$uniq_basic_tmp'"

    # From sort-unique.sh: unique with LC_ALL=C
    run_test "-u with LC_ALL=C" \
        "LC_ALL=C $GNU_TOOL -u '$uniq_basic_tmp'" \
        "LC_ALL=C $F_TOOL -u '$uniq_basic_tmp'"

    # Unique with numeric duplicates
    local uniq_num_tmp
    uniq_num_tmp=$(make_temp_printf '3\n1\n2\n1\n3\n2\n')
    register_temp "$uniq_num_tmp"
    run_test "-nu unique numeric" \
        "$GNU_TOOL -nu '$uniq_num_tmp'" \
        "$F_TOOL -nu '$uniq_num_tmp'"

    echo ""
    echo "=== GNU Upstream: Month Sort ==="

    # From sort-month.sh: basic month abbreviation ordering
    local month_basic_tmp
    month_basic_tmp=$(make_temp_printf 'MAR\nJAN\nFEB\nDEC\nJUL\nAPR\n')
    register_temp "$month_basic_tmp"
    run_test "-M basic month abbreviations" \
        "LC_ALL=C $GNU_TOOL -M '$month_basic_tmp'" \
        "LC_ALL=C $F_TOOL -M '$month_basic_tmp'"

    # All twelve months
    local month_all_tmp
    month_all_tmp=$(make_temp_printf 'DEC\nNOV\nOCT\nSEP\nAUG\nJUL\nJUN\nMAY\nAPR\nMAR\nFEB\nJAN\n')
    register_temp "$month_all_tmp"
    run_test "-M all twelve months reversed" \
        "LC_ALL=C $GNU_TOOL -M '$month_all_tmp'" \
        "LC_ALL=C $F_TOOL -M '$month_all_tmp'"

    # Month sort with non-month strings
    local month_mixed_tmp
    month_mixed_tmp=$(make_temp_printf 'FOO\nJAN\nBAR\nFEB\n')
    register_temp "$month_mixed_tmp"
    run_test "-M with non-month strings" \
        "LC_ALL=C $GNU_TOOL -M '$month_mixed_tmp'" \
        "LC_ALL=C $F_TOOL -M '$month_mixed_tmp'"

    echo ""
    echo "=== GNU Upstream: Field Limit Sort ==="

    # From sort-field-limit.sh: key with field limits
    local field_lim_tmp
    field_lim_tmp=$(make_temp_printf 'aa bb\nbb aa\n')
    register_temp "$field_lim_tmp"
    run_test "-k2,2 field-limited key" \
        "$GNU_TOOL -s -k2,2 '$field_lim_tmp'" \
        "$F_TOOL -s -k2,2 '$field_lim_tmp'"

    # Character position within field
    local field_char_tmp
    field_char_tmp=$(make_temp_printf 'a:bx\na:ay\n')
    register_temp "$field_char_tmp"
    run_test "-t: -k2.2,2.2 char position in field" \
        "$GNU_TOOL -s -t: -k2.2,2.2 '$field_char_tmp'" \
        "$F_TOOL -s -t: -k2.2,2.2 '$field_char_tmp'"

    # Multiple key specifications
    local field_multi_tmp
    field_multi_tmp=$(make_temp_printf 'b 1\na 2\nb 2\na 1\n')
    register_temp "$field_multi_tmp"
    run_test "-k1,1 -k2,2n multi-key with field limits" \
        "$GNU_TOOL -s -k1,1 -k2,2n '$field_multi_tmp'" \
        "$F_TOOL -s -k1,1 -k2,2n '$field_multi_tmp'"

    echo ""
    echo "=== GNU Upstream: Debug Keys ==="

    # From sort-debug-keys.sh: --debug with numeric key on no-match
    local debug_nomatch_tmp
    debug_nomatch_tmp=$(make_temp_printf '1\n\n44\n33\n2\n')
    register_temp "$debug_nomatch_tmp"
    run_stdout_test "--debug -k2n no match annotation" \
        "$GNU_TOOL -s -k2n --debug '$debug_nomatch_tmp'" \
        "$F_TOOL -s -k2n --debug '$debug_nomatch_tmp'"

    # --debug with simple numeric key
    local debug_num_tmp
    debug_num_tmp=$(make_temp_printf '1\n\n44\n33\n2\n')
    register_temp "$debug_num_tmp"
    run_stdout_test "--debug -k1n basic key highlighting" \
        "$GNU_TOOL -s -k1n --debug '$debug_num_tmp'" \
        "$F_TOOL -s -k1n --debug '$debug_num_tmp'"

    # --debug with month key
    local debug_month_tmp
    debug_month_tmp=$(make_temp_printf 'FEB\n\nJAN\n')
    register_temp "$debug_month_tmp"
    run_stdout_test "--debug -k1M month key annotation" \
        "LC_ALL=C $GNU_TOOL -s -k1M --debug '$debug_month_tmp'" \
        "LC_ALL=C $F_TOOL -s -k1M --debug '$debug_month_tmp'"

    echo ""
    echo "=== GNU Upstream: Discriminator Sort ==="

    # From sort-discrim.sh: lexicographic with long prefix
    local discrim_lex_tmp
    discrim_lex_tmp=$(mktemp /tmp/fcoreutils_discrim_XXXXXX)
    register_temp "$discrim_lex_tmp"
    local discrim_lex_exp
    discrim_lex_exp=$(mktemp /tmp/fcoreutils_discrim_exp_XXXXXX)
    register_temp "$discrim_lex_exp"
    seq -f 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa%5.0f' 1000 > "$discrim_lex_exp"
    $GNU_TOOL -R "$discrim_lex_exp" > "$discrim_lex_tmp"
    run_test "long prefix lexicographic sort" \
        "LC_ALL=C $GNU_TOOL '$discrim_lex_tmp'" \
        "LC_ALL=C $F_TOOL '$discrim_lex_tmp'"

    # From sort-discrim.sh: numeric range sort
    local discrim_num_tmp
    discrim_num_tmp=$(mktemp /tmp/fcoreutils_discrimn_XXXXXX)
    register_temp "$discrim_num_tmp"
    seq -- -10 .5 10 > "$discrim_num_tmp"
    run_test "-n numeric range (-10 to 10 by 0.5)" \
        "LC_ALL=C $GNU_TOOL -n '$discrim_num_tmp'" \
        "LC_ALL=C $F_TOOL -n '$discrim_num_tmp'"

    echo ""
    echo "=== GNU Upstream: Sort Continue ==="

    # From sort-continue.sh: sort produces correct output (basic correctness)
    local cont_tmp
    cont_tmp=$(make_temp_printf '3\n1\n2\n')
    register_temp "$cont_tmp"
    run_test "basic sort correctness" \
        "$GNU_TOOL '$cont_tmp'" \
        "$F_TOOL '$cont_tmp'"

    # === GNU Upstream: NaN Handling ===
    echo ""
    echo "=== GNU Upstream: NaN Handling ==="

    # From sort-NaN-infloop.sh: -g merge with NaN values should not infloop
    local nan_tmp
    nan_tmp=$(make_temp "nan
")
    register_temp "$nan_tmp"
    run_test "-g -m NaN NaN merge" \
        "timeout 10 $GNU_TOOL -g -m '$nan_tmp' '$nan_tmp'" \
        "timeout 10 $F_TOOL -g -m '$nan_tmp' '$nan_tmp'"

    # === GNU Upstream: Random Sort Permutation ===
    echo ""
    echo "=== GNU Upstream: Random Sort Permutation ==="

    # From sort-rand.sh: -R output sorted numerically should match input
    local rand_seq_tmp
    rand_seq_tmp=$(mktemp /tmp/fcoreutils_randseq_XXXXXX)
    register_temp "$rand_seq_tmp"
    seq 100 > "$rand_seq_tmp"
    run_test "-R produces permutation (sorted check)" \
        "$GNU_TOOL --random-sort '$rand_seq_tmp' | $GNU_TOOL -n | md5sum" \
        "$F_TOOL --random-sort '$rand_seq_tmp' | $F_TOOL -n | md5sum"

    # === GNU Upstream: Numeric Sort Edge Cases (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Numeric Sort Edge Cases ==="

    # From sort.pl: decimal-only numbers sort correctly
    run_test "-n decimal .01 vs 0" \
        "printf '.01\n0\n' | $GNU_TOOL -n" \
        "printf '.01\n0\n' | $F_TOOL -n"

    run_test "-n decimal .02 vs .01" \
        "printf '.02\n.01\n' | $GNU_TOOL -n" \
        "printf '.02\n.01\n' | $F_TOOL -n"

    run_test "-n decimal .02 vs .00" \
        "printf '.02\n.00\n' | $GNU_TOOL -n" \
        "printf '.02\n.00\n' | $F_TOOL -n"

    run_test "-n decimal .02 vs .000" \
        "printf '.02\n.000\n' | $GNU_TOOL -n" \
        "printf '.02\n.000\n' | $F_TOOL -n"

    run_test "-n negative numbers -1 vs -9" \
        "printf '\-1\n\-9\n' | $GNU_TOOL -n" \
        "printf '\-1\n\-9\n' | $F_TOOL -n"

    # From sort.pl: -g general numeric with exponents
    run_test "-g exponent 1e2 vs 2e1" \
        "printf '1e2\n2e1\n' | $GNU_TOOL -g" \
        "printf '1e2\n2e1\n' | $F_TOOL -g"

    # From sort.pl: -n treats exponent as text (1e2 = 1)
    run_test "-n exponent treated as text" \
        "printf '1e2\n2e1\n' | $GNU_TOOL -n" \
        "printf '1e2\n2e1\n' | $F_TOOL -n"

    run_test "-n reverse exponent order" \
        "printf '2e1\n1e2\n' | $GNU_TOOL -n" \
        "printf '2e1\n1e2\n' | $F_TOOL -n"

    # === GNU Upstream: Key Specification Edge Cases (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Key Specification Edge Cases ==="

    # From sort.pl: -k2 sorts by second field
    run_test "-k2 second field sort" \
        "printf 'ignored B\nz-ig A\n' | $GNU_TOOL -k2" \
        "printf 'ignored B\nz-ig A\n' | $F_TOOL -k2"

    # From sort.pl: -k1,2 range
    run_test "-k1,2 range sort" \
        "printf 'A B\nA A\n' | $GNU_TOOL -k1,2" \
        "printf 'A B\nA A\n' | $F_TOOL -k1,2"

    run_test "-k1 -k2 multi-key" \
        "printf 'A B A\nA A Z\n' | $GNU_TOOL -k1 -k2" \
        "printf 'A B A\nA A Z\n' | $F_TOOL -k1 -k2"

    run_test "-k2,2 exact field" \
        "printf 'A B Z\nA A A\n' | $GNU_TOOL -k2,2" \
        "printf 'A B Z\nA A A\n' | $F_TOOL -k2,2"

    # From sort.pl: field 0 should be an error
    run_exit_code_test "-k0 invalid field" \
        "$GNU_TOOL -k0 < /dev/null 2>&1" \
        "$F_TOOL -k0 < /dev/null 2>&1"

    # From sort.pl: character offset 0 should be an error
    run_exit_code_test "-k1.0 invalid char offset" \
        "$GNU_TOOL -k1.0 < /dev/null 2>&1" \
        "$F_TOOL -k1.0 < /dev/null 2>&1"

    # === GNU Upstream: Check Sorted (-c) Edge Cases (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Check Sorted (-c) Edge Cases ==="

    # From sort.pl: -c on sorted input succeeds
    run_exit_code_test "-c on sorted ABC" \
        "printf 'A\nB\nC\n' | $GNU_TOOL -c 2>&1" \
        "printf 'A\nB\nC\n' | $F_TOOL -c 2>&1"

    # From sort.pl: -c on unsorted input fails
    run_exit_code_test "-c on unsorted ACB" \
        "printf 'A\nC\nB\n' | $GNU_TOOL -c 2>&1" \
        "printf 'A\nC\nB\n' | $F_TOOL -c 2>&1"

    # From sort.pl: -C (quiet check)
    run_exit_code_test "-C on sorted ABC" \
        "printf 'A\nB\nC\n' | $GNU_TOOL -C 2>&1" \
        "printf 'A\nB\nC\n' | $F_TOOL -C 2>&1"

    run_exit_code_test "-C on unsorted ACB" \
        "printf 'A\nC\nB\n' | $GNU_TOOL -C 2>&1" \
        "printf 'A\nC\nB\n' | $F_TOOL -C 2>&1"

    # From sort.pl: -cu on duplicates fails
    run_exit_code_test "-cu on duplicate AA" \
        "printf 'A\nA\n' | $GNU_TOOL -cu 2>&1" \
        "printf 'A\nA\n' | $F_TOOL -cu 2>&1"

    # From sort.pl: -cu on unique succeeds
    run_exit_code_test "-cu on unique AB" \
        "printf 'A\nB\n' | $GNU_TOOL -cu 2>&1" \
        "printf 'A\nB\n' | $F_TOOL -cu 2>&1"

    # === GNU Upstream: Human Numeric Sort Edge Cases (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Human Numeric Sort Edge Cases ==="

    # From sort.pl: -h with SI suffixes
    run_test "-h mixed SI suffixes" \
        "printf '1M\n-2G\n-3K\n' | $GNU_TOOL -h" \
        "printf '1M\n-2G\n-3K\n' | $F_TOOL -h"

    # From sort.pl: -h with powers of 1024
    run_test "-h -k2,2h 1G vs 1023M" \
        "printf 'a 1G\nb 1023M\n' | $GNU_TOOL -k 2,2h -k 1,1" \
        "printf 'a 1G\nb 1023M\n' | $F_TOOL -k 2,2h -k 1,1"

    # From sort.pl: -hn incompatible options
    run_exit_code_test "-hn incompatible options" \
        "printf '' | $GNU_TOOL -hn 2>&1" \
        "printf '' | $F_TOOL -hn 2>&1"

    # === GNU Upstream: Incompatible Options (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Incompatible Options ==="

    # From sort.pl: -in incompatible
    run_exit_code_test "-in incompatible" \
        "printf '' | $GNU_TOOL -in 2>&1" \
        "printf '' | $F_TOOL -in 2>&1"

    # From sort.pl: -nR incompatible
    run_exit_code_test "-nR incompatible" \
        "printf '' | $GNU_TOOL -nR 2>&1" \
        "printf '' | $F_TOOL -nR 2>&1"

    # From sort.pl: -cC incompatible
    run_exit_code_test "-cC incompatible" \
        "printf '' | $GNU_TOOL -cC 2>&1" \
        "printf '' | $F_TOOL -cC 2>&1"

    # === GNU Upstream: Case Folding (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Case Folding ==="

    # From sort.pl: -f folds lowercase to uppercase for comparison
    run_test "-f A a _" \
        "printf 'A\na\n_\n' | $GNU_TOOL -f" \
        "printf 'A\na\n_\n' | $F_TOOL -f"

    run_test "-f a A _" \
        "printf 'a\nA\n_\n' | $GNU_TOOL -f" \
        "printf 'a\nA\n_\n' | $F_TOOL -f"

    # From sort.pl: default sort order of A, _, a
    run_test "default A _ a" \
        "printf 'A\na\n_\n' | $GNU_TOOL" \
        "printf 'A\na\n_\n' | $F_TOOL"

    # === GNU Upstream: Dictionary and Ignore Options (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Dictionary and Ignore ==="

    # From sort.pl: -d -u considers non-alphanumeric chars as equal
    run_test "-d -u mal vs mal-" \
        "printf 'mal\nmal-\nmala\n' | $GNU_TOOL -d -u" \
        "printf 'mal\nmal-\nmala\n' | $F_TOOL -d -u"

    # From sort.pl: -f -d -u combined
    run_test "-f -d -u combined" \
        "printf 'mal\nmal-\nmala\n' | $GNU_TOOL -f -d -u" \
        "printf 'mal\nmal-\nmala\n' | $F_TOOL -f -d -u"

    # === GNU Upstream: Zero-Terminated (-z) (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Zero-Terminated ==="

    # From sort.pl: -z null-terminated sort
    run_test "-z null-terminated 2 1" \
        "printf '2\0001\000' | $GNU_TOOL -z | od -An -tx1" \
        "printf '2\0001\000' | $F_TOOL -z | od -An -tx1"

    # From sort.pl: -z with key
    run_test "-z -k2,2 null-terminated with key" \
        "printf '1\n2\0002\n1\000' | $GNU_TOOL -z -k2,2 | od -An -tx1" \
        "printf '1\n2\0002\n1\000' | $F_TOOL -z -k2,2 | od -An -tx1"

    # === GNU Upstream: Numeric Leading Blank (-b) Interaction (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Numeric Leading Blank Interaction ==="

    # From sort.pl: POSIX says -n no longer implies -b
    run_test "-k1.1,1.2n space vs no space" \
        "printf ' 901\n100\n' | $GNU_TOOL -k1.1,1.2n" \
        "printf ' 901\n100\n' | $F_TOOL -k1.1,1.2n"

    # From sort.pl: -nb combined
    run_test "-nb -k1.1,1.2 with leading blanks" \
        "printf ' 901\n100\n' | $GNU_TOOL -nb -k1.1,1.2" \
        "printf ' 901\n100\n' | $F_TOOL -nb -k1.1,1.2"

    # === GNU Upstream: Separator Interaction with Numeric (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Separator Interaction ==="

    # From sort.pl: -n -t: with '-' and integers
    run_test "-n -t: dash vs number" \
        "printf 'a:1\nb:-\n' | $GNU_TOOL -n -t: -k2" \
        "printf 'a:1\nb:-\n' | $F_TOOL -n -t: -k2"

    # From sort.pl: colon separator with char position
    run_test "-t: -k2.2,2.2 char within field" \
        "printf ':ab\n:ba\n' | $GNU_TOOL -t : -k 2.2,2.2" \
        "printf ':ab\n:ba\n' | $F_TOOL -t : -k 2.2,2.2"

    # === GNU Upstream: Stable Sort with Separator (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Stable Sort with Separator ==="

    # From sort.pl: -s -k1,1 -t/ with special characters
    run_test "-s -k1,1 -t/ with spaces" \
        "printf 'a b/x\na-b-c/x\n' | $GNU_TOOL -s -k1,1 -t/" \
        "printf 'a b/x\na-b-c/x\n' | $F_TOOL -s -k1,1 -t/"

    # === GNU Upstream: Newline Handling (sort.pl) ===
    echo ""
    echo "=== GNU Upstream: Newline Handling ==="

    # From sort.pl: empty line should sort before tab (POSIX fix)
    run_test "empty line vs tab line" \
        "printf '\n\t\n' | $GNU_TOOL" \
        "printf '\n\t\n' | $F_TOOL"

    # From sort.pl: nul in input
    run_test "nul bytes in input" \
        "printf '\0b\n\0a\n' | $GNU_TOOL" \
        "printf '\0b\n\0a\n' | $F_TOOL"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Locale Sensitivity ==="

    run_test "LC_ALL=C sort" \
        "LC_ALL=C $GNU_TOOL '$TEST_DATA_DIR/unsorted.txt'" \
        "LC_ALL=C $F_TOOL '$TEST_DATA_DIR/unsorted.txt'"



    finish_test_suite
}

run_sort_tests
