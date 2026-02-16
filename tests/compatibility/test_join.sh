#!/usr/bin/env bash
# Compatibility tests for fjoin vs GNU join
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="join"
F_TOOL="fjoin"

run_join_tests() {
    init_test_suite "join"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"join","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/join_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU join not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Join (default: field 1, space separator) ==="

    run_test "basic join" \
        "$GNU_TOOL '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "join by name" \
        "$GNU_TOOL '$TEST_DATA_DIR/join_byname1.txt' '$TEST_DATA_DIR/join_byname2.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/join_byname1.txt' '$TEST_DATA_DIR/join_byname2.txt'"

    run_test "identical key sets" \
        "$GNU_TOOL <(printf '1 a\n2 b\n3 c\n') <(printf '1 x\n2 y\n3 z\n')" \
        "$F_TOOL <(printf '1 a\n2 b\n3 c\n') <(printf '1 x\n2 y\n3 z\n')"

    run_test "no matching keys" \
        "$GNU_TOOL <(printf '1 a\n2 b\n') <(printf '3 x\n4 y\n')" \
        "$F_TOOL <(printf '1 a\n2 b\n') <(printf '3 x\n4 y\n')"

    run_test "first file empty" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "second file empty" \
        "$GNU_TOOL '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/empty.txt'"

    echo ""
    echo "=== Custom Delimiter (-t) ==="

    run_test "-t comma" \
        "$GNU_TOOL -t, '$TEST_DATA_DIR/join_csv1.txt' '$TEST_DATA_DIR/join_csv2.txt'" \
        "$F_TOOL -t, '$TEST_DATA_DIR/join_csv1.txt' '$TEST_DATA_DIR/join_csv2.txt'"

    run_test "-t colon" \
        "$GNU_TOOL -t: <(printf '1:a:b\n2:c:d\n') <(printf '1:x\n2:y\n')" \
        "$F_TOOL -t: <(printf '1:a:b\n2:c:d\n') <(printf '1:x\n2:y\n')"

    run_test "-t pipe" \
        "$GNU_TOOL -t'|' <(printf '1|a\n2|b\n') <(printf '1|x\n2|y\n')" \
        "$F_TOOL -t'|' <(printf '1|a\n2|b\n') <(printf '1|x\n2|y\n')"

    echo ""
    echo "=== Join Field (-1 N, -2 N) ==="

    run_test "-1 2 (join on field 2 of file1)" \
        "$GNU_TOOL -1 2 <(printf 'a 1\nb 2\nc 3\n') <(printf '1 x\n2 y\n3 z\n')" \
        "$F_TOOL -1 2 <(printf 'a 1\nb 2\nc 3\n') <(printf '1 x\n2 y\n3 z\n')"

    run_test "-2 2 (join on field 2 of file2)" \
        "$GNU_TOOL -2 2 <(printf '1 a\n2 b\n3 c\n') <(printf 'x 1\ny 2\nz 3\n')" \
        "$F_TOOL -2 2 <(printf '1 a\n2 b\n3 c\n') <(printf 'x 1\ny 2\nz 3\n')"

    run_test "-1 2 -2 2 (both on field 2)" \
        "$GNU_TOOL -1 2 -2 2 <(printf 'a KEY1\nb KEY2\n') <(printf 'x KEY1\ny KEY2\n')" \
        "$F_TOOL -1 2 -2 2 <(printf 'a KEY1\nb KEY2\n') <(printf 'x KEY1\ny KEY2\n')"

    echo ""
    echo "=== Unpaired Lines (-a) ==="

    run_test "-a 1 (print unpairable from file1)" \
        "$GNU_TOOL -a 1 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -a 1 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "-a 2 (print unpairable from file2)" \
        "$GNU_TOOL -a 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -a 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "-a 1 -a 2 (full outer join)" \
        "$GNU_TOOL -a 1 -a 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -a 1 -a 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    echo ""
    echo "=== Only Unpaired (-v) ==="

    run_test "-v 1 (only unpairable from file1)" \
        "$GNU_TOOL -v 1 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -v 1 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "-v 2 (only unpairable from file2)" \
        "$GNU_TOOL -v 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -v 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "-v 1 -v 2 (symmetric difference)" \
        "$GNU_TOOL -v 1 -v 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -v 1 -v 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    echo ""
    echo "=== Empty Replacement (-e) ==="

    run_test "-e EMPTY -a 1 -a 2" \
        "$GNU_TOOL -e 'EMPTY' -a 1 -a 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -e 'EMPTY' -a 1 -a 2 '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "-e N/A -a 1 -a 2 -o auto" \
        "$GNU_TOOL -e 'N/A' -a 1 -a 2 -o auto '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -e 'N/A' -a 1 -a 2 -o auto '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    echo ""
    echo "=== Output Format (-o) ==="

    run_test "-o 1.1,2.2 (specific fields)" \
        "$GNU_TOOL -o '1.1,2.2' '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -o '1.1,2.2' '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "-o 0,1.2,2.2 (join field + specific)" \
        "$GNU_TOOL -o '0,1.2,2.2' '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -o '0,1.2,2.2' '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "-o 0,1.2,1.3,2.2 (multi-field)" \
        "$GNU_TOOL -o '0,1.2,1.3,2.2' '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -o '0,1.2,1.3,2.2' '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    run_test "-o auto" \
        "$GNU_TOOL -o auto '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'" \
        "$F_TOOL -o auto '$TEST_DATA_DIR/join_file1.txt' '$TEST_DATA_DIR/join_file2.txt'"

    echo ""
    echo "=== CSV Join ==="

    run_test "CSV join -t," \
        "$GNU_TOOL -t, '$TEST_DATA_DIR/join_csv1.txt' '$TEST_DATA_DIR/join_csv2.txt'" \
        "$F_TOOL -t, '$TEST_DATA_DIR/join_csv1.txt' '$TEST_DATA_DIR/join_csv2.txt'"

    run_test "CSV join -t, -a 1 -a 2" \
        "$GNU_TOOL -t, -a 1 -a 2 '$TEST_DATA_DIR/join_csv1.txt' '$TEST_DATA_DIR/join_csv2.txt'" \
        "$F_TOOL -t, -a 1 -a 2 '$TEST_DATA_DIR/join_csv1.txt' '$TEST_DATA_DIR/join_csv2.txt'"

    run_test "CSV join -t, -e N/A -a 1 -a 2 -o auto" \
        "$GNU_TOOL -t, -e 'N/A' -a 1 -a 2 -o auto '$TEST_DATA_DIR/join_csv1.txt' '$TEST_DATA_DIR/join_csv2.txt'" \
        "$F_TOOL -t, -e 'N/A' -a 1 -a 2 -o auto '$TEST_DATA_DIR/join_csv1.txt' '$TEST_DATA_DIR/join_csv2.txt'"

    echo ""
    echo "=== Single Line Files ==="

    run_test "single matching line" \
        "$GNU_TOOL <(printf '1 a\n') <(printf '1 b\n')" \
        "$F_TOOL <(printf '1 a\n') <(printf '1 b\n')"

    run_test "single non-matching line" \
        "$GNU_TOOL <(printf '1 a\n') <(printf '2 b\n')" \
        "$F_TOOL <(printf '1 a\n') <(printf '2 b\n')"

    echo ""
    echo "=== Stdin ==="

    run_test "stdin as file1" \
        "printf '1 hello\n2 world\n3 foo\n' | $GNU_TOOL - '$TEST_DATA_DIR/join_file2.txt'" \
        "printf '1 hello\n2 world\n3 foo\n' | $F_TOOL - '$TEST_DATA_DIR/join_file2.txt'"

    run_test "stdin as file2" \
        "printf '1 100\n3 200\n5 300\n' | $GNU_TOOL '$TEST_DATA_DIR/join_file1.txt' -" \
        "printf '1 100\n3 200\n5 300\n' | $F_TOOL '$TEST_DATA_DIR/join_file1.txt' -"

    echo ""
    echo "=== Ignore Case (-i) ==="

    run_test "-i case insensitive" \
        "$GNU_TOOL -i <(printf 'ALPHA x\nBETA y\n') <(printf 'alpha a\nbeta b\n')" \
        "$F_TOOL -i <(printf 'ALPHA x\nBETA y\n') <(printf 'alpha a\nbeta b\n')"

    echo ""
    echo "=== Large Files ==="

    if [[ -f "$TEST_DATA_DIR/join_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/join_bench_file2_10m.txt" ]]; then
        run_test "10MB join" \
            "$GNU_TOOL '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt' | md5sum" \
            "$F_TOOL '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt' | md5sum"

        run_test "10MB join -a 1 -a 2" \
            "$GNU_TOOL -a 1 -a 2 '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt' | md5sum" \
            "$F_TOOL -a 1 -a 2 '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt' | md5sum"
    fi

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ '$TEST_DATA_DIR/join_file2.txt' 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ '$TEST_DATA_DIR/join_file2.txt' 2>&1"

    finish_test_suite
}

run_join_tests
