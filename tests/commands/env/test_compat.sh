#!/usr/bin/env bash
# Compatibility tests for fenv vs GNU env
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "env")
F_TOOL="fenv"

run_env_tests() {
    init_test_suite "env"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"env","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/env_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU env not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Print Environment ==="

    # Can't compare full env (too dynamic), test specific vars
    run_test "print env has PATH" \
        "$GNU_TOOL | grep -c '^PATH='" \
        "$F_TOOL | grep -c '^PATH='"

    run_test "print env has HOME" \
        "$GNU_TOOL | grep -c '^HOME='" \
        "$F_TOOL | grep -c '^HOME='"

    echo ""
    echo "=== Set Variables ==="

    run_test "set single variable" \
        "$GNU_TOOL TESTVAR=hello printenv TESTVAR" \
        "$F_TOOL TESTVAR=hello printenv TESTVAR"

    run_test "set multiple variables" \
        "$GNU_TOOL VAR1=one VAR2=two sh -c 'echo \$VAR1 \$VAR2'" \
        "$F_TOOL VAR1=one VAR2=two sh -c 'echo \$VAR1 \$VAR2'"

    run_test "variable with spaces in value" \
        "$GNU_TOOL 'TESTVAR=hello world' printenv TESTVAR" \
        "$F_TOOL 'TESTVAR=hello world' printenv TESTVAR"

    run_test "variable with equals in value" \
        "$GNU_TOOL 'TESTVAR=a=b=c' printenv TESTVAR" \
        "$F_TOOL 'TESTVAR=a=b=c' printenv TESTVAR"

    run_test "empty value" \
        "$GNU_TOOL TESTVAR= printenv TESTVAR" \
        "$F_TOOL TESTVAR= printenv TESTVAR"

    echo ""
    echo "=== Unset Variables (-u) ==="

    run_test "-u unset variable" \
        "export MYTEST_VAR=remove_me && $GNU_TOOL -u MYTEST_VAR sh -c 'echo \${MYTEST_VAR:-UNSET}'" \
        "export MYTEST_VAR=remove_me && $F_TOOL -u MYTEST_VAR sh -c 'echo \${MYTEST_VAR:-UNSET}'"

    echo ""
    echo "=== Clean Environment (-i) ==="

    run_test "-i empty environment" \
        "$GNU_TOOL -i env | wc -l" \
        "$F_TOOL -i env | wc -l"

    run_test "-i with new var" \
        "$GNU_TOOL -i ONLY=this printenv ONLY" \
        "$F_TOOL -i ONLY=this printenv ONLY"

    run_test "-i PATH still works" \
        "$GNU_TOOL -i PATH=/usr/bin:/bin sh -c 'echo OK'" \
        "$F_TOOL -i PATH=/usr/bin:/bin sh -c 'echo OK'"

    echo ""
    echo "=== Run Command ==="

    run_test "run echo" \
        "$GNU_TOOL echo 'hello from env'" \
        "$F_TOOL echo 'hello from env'"

    run_test "run sh -c" \
        "$GNU_TOOL sh -c 'echo computed'" \
        "$F_TOOL sh -c 'echo computed'"

    run_test "exit code passthrough (success)" \
        "$GNU_TOOL true; echo \$?" \
        "$F_TOOL true; echo \$?"

    run_test "exit code passthrough (failure)" \
        "$GNU_TOOL false; echo \$?" \
        "$F_TOOL false; echo \$?"

    echo ""
    echo "=== Null Terminated (-0) ==="

    run_test "-0 null terminated output" \
        "$GNU_TOOL -i TEST=val -0 | od -c | head -3" \
        "$F_TOOL -i TEST=val -0 | od -c | head -3"

    # === GNU Upstream: Clear Environment ===
    echo ""
    echo "=== GNU Upstream: Clear Environment ==="

    # From env.sh: env - should produce empty output
    run_test "env - clears environment" \
        "$GNU_TOOL -i env | wc -l" \
        "$F_TOOL -i env | wc -l"

    # env -i -- a=b should output just a=b
    run_test "env -i -- a=b" \
        "$GNU_TOOL -i -- a=b" \
        "$F_TOOL -i -- a=b"

    # === GNU Upstream: Exit Codes ===
    echo ""
    echo "=== GNU Upstream: Exit Codes ==="

    # From env.sh: exit status propagation
    run_exit_code_test "exit status 2 propagation" \
        "$GNU_TOOL sh -c 'exit 2' 2>&1" \
        "$F_TOOL sh -c 'exit 2' 2>&1"

    # Unknown option
    run_exit_code_test "unknown option ---" \
        "$GNU_TOOL --- 2>&1" \
        "$F_TOOL --- 2>&1"

    # Missing -u argument
    run_exit_code_test "-u missing argument" \
        "$GNU_TOOL -u 2>&1" \
        "$F_TOOL -u 2>&1"

    # No such command
    run_exit_code_test "no such command" \
        "$GNU_TOOL no_such_cmd_$$ 2>&1" \
        "$F_TOOL no_such_cmd_$$ 2>&1"

    # === GNU Upstream: Unset Variable Error ===
    echo ""
    echo "=== GNU Upstream: Unset Variable Error ==="

    # From env.sh: catch unsetenv failure (invalid name with = or empty)
    run_exit_code_test "-u with = in name" \
        "$GNU_TOOL -u 'a=b' true 2>&1" \
        "$F_TOOL -u 'a=b' true 2>&1"

    run_exit_code_test "-u with empty name" \
        "$GNU_TOOL -u '' true 2>&1" \
        "$F_TOOL -u '' true 2>&1"

    # === GNU Upstream: Change Directory ===
    echo ""
    echo "=== GNU Upstream: Change Directory ==="

    local env_tmpdir
    env_tmpdir=$(mktemp -d /tmp/fcoreutils_env_XXXXXX)
    register_temp "$env_tmpdir"
    mkdir -p "$env_tmpdir/empty"

    # --chdir to nonexistent dir should fail
    run_exit_code_test "--chdir nonexistent" \
        "$GNU_TOOL --chdir='$env_tmpdir/empty/nonexistent' true 2>&1" \
        "$F_TOOL --chdir='$env_tmpdir/empty/nonexistent' true 2>&1"

    # --chdir should change working directory
    run_test "--chdir changes pwd" \
        "$GNU_TOOL --chdir='$env_tmpdir/empty' pwd" \
        "$F_TOOL --chdir='$env_tmpdir/empty' pwd"

    rm -rf "$env_tmpdir"

    # === GNU Upstream: Null Terminator ===
    echo ""
    echo "=== GNU Upstream: Null Terminator ==="

    # From env-null.sh: -0 does not work if a command is specified
    run_exit_code_test "-0 with command fails" \
        "$GNU_TOOL -0 echo hi 2>&1" \
        "$F_TOOL -0 echo hi 2>&1"

    # === GNU Upstream: Environment Variable Manipulation ===
    echo ""
    echo "=== GNU Upstream: Environment Variable Manipulation ==="

    # From env.sh: setting and overriding environment variables
    run_test "gnu env: set ENV_TEST1 and ENV_TEST2" \
        "$GNU_TOOL -i ENV_TEST1=a ENV_TEST2= env | sort" \
        "$F_TOOL -i ENV_TEST1=a ENV_TEST2= env | sort"

    run_test "gnu env: override variable with new value" \
        "ENV_TEST1=old $GNU_TOOL ENV_TEST1=new sh -c 'echo \$ENV_TEST1'" \
        "ENV_TEST1=old $F_TOOL ENV_TEST1=new sh -c 'echo \$ENV_TEST1'"

    # From env.sh: -u to unset combined with new variables
    run_test "gnu env: -u unset and set new var" \
        "ENV_TEST1=a $GNU_TOOL -u ENV_TEST1 ENV_TEST3=c sh -c 'echo \${ENV_TEST1:-UNSET} \$ENV_TEST3'" \
        "ENV_TEST1=a $F_TOOL -u ENV_TEST1 ENV_TEST3=c sh -c 'echo \${ENV_TEST1:-UNSET} \$ENV_TEST3'"

    # From env.sh: env with command that has env vars set
    run_test "gnu env: variable with env as subcommand" \
        "$GNU_TOOL -i ENV_TEST2= env | sort" \
        "$F_TOOL -i ENV_TEST2= env | sort"

    # === GNU Upstream: Double-Dash Separator ===
    echo ""
    echo "=== GNU Upstream: Double-Dash Separator ==="

    # From env.sh: -- separates options from arguments
    run_test "gnu env: -i -- a=b prints a=b" \
        "$GNU_TOOL -i -- a=b" \
        "$F_TOOL -i -- a=b"

    # From env.sh: -u can combine with -i and --
    run_test "gnu env: -u a -i -u a --" \
        "$GNU_TOOL -u a -i -u a -- env | wc -l" \
        "$F_TOOL -u a -i -u a -- env | wc -l"

    # === GNU Upstream: Exit Code Propagation ===
    echo ""
    echo "=== GNU Upstream: Exit Code Propagation ==="

    # From env.sh: exit code 2 is propagated
    run_exit_code_test "gnu env: exit 2 propagation" \
        "$GNU_TOOL sh -c 'exit 2' 2>&1" \
        "$F_TOOL sh -c 'exit 2' 2>&1"

    # From env.sh: no such command returns 127
    run_exit_code_test "gnu env: command not found returns 127" \
        "$GNU_TOOL no_such_command_$$ 2>&1" \
        "$F_TOOL no_such_command_$$ 2>&1"

    # From env.sh: unknown triple-dash option returns 125
    run_exit_code_test "gnu env: unknown option --- returns 125" \
        "$GNU_TOOL --- 2>&1" \
        "$F_TOOL --- 2>&1"

    # From env.sh: -u missing argument returns 125
    run_exit_code_test "gnu env: -u missing arg returns 125" \
        "$GNU_TOOL -u 2>&1" \
        "$F_TOOL -u 2>&1"

    # === GNU Upstream: Invalid Unset Names ===
    echo ""
    echo "=== GNU Upstream: Invalid Unset Names ==="

    # From env.sh: unsetenv failure for name containing =
    run_exit_code_test "gnu env: -u name with = fails" \
        "$GNU_TOOL -u 'a=b' true 2>&1" \
        "$F_TOOL -u 'a=b' true 2>&1"

    # From env.sh: unsetenv failure for empty name
    run_exit_code_test "gnu env: -u empty name fails" \
        "$GNU_TOOL -u '' true 2>&1" \
        "$F_TOOL -u '' true 2>&1"

    # === GNU Upstream: PATH Modification ===
    echo ""
    echo "=== GNU Upstream: PATH Modification ==="

    # From env.sh: PATH modifications affect which commands are found
    local env_tmpdir2
    env_tmpdir2=$(mktemp -d /tmp/fcoreutils_env2_XXXXXX)
    register_temp "$env_tmpdir2"

    cat > "$env_tmpdir2/test_script_$$" <<'SCRIPT'
#!/bin/sh
echo pass
SCRIPT
    chmod +x "$env_tmpdir2/test_script_$$"

    run_test "gnu env: PATH modification finds command" \
        "$GNU_TOOL PATH=\"$env_tmpdir2\" sh -c 'echo pass'" \
        "$F_TOOL PATH=\"$env_tmpdir2\" sh -c 'echo pass'"

    rm -rf "$env_tmpdir2"

    # === GNU Upstream: -S Split String Option ===
    echo ""
    echo "=== GNU Upstream: -S Split String Option ==="

    # From env-S.pl: basic -S with variable assignment and command
    run_test "gnu env -S: basic var and command" \
        "$GNU_TOOL -S'A=hello sh -c \"echo \\\$A\"'" \
        "$F_TOOL -S'A=hello sh -c \"echo \\\$A\"'"

    # From env-S.pl: -C (chdir) inside -S
    run_test "gnu env -S: -C chdir" \
        "$GNU_TOOL \"-S-C/ pwd\"" \
        "$F_TOOL \"-S-C/ pwd\""

    run_test "gnu env -S: -C chdir with space" \
        "$GNU_TOOL \"-S -C / pwd\"" \
        "$F_TOOL \"-S -C / pwd\""

    # From env-S.pl: empty -S string
    run_test "gnu env -S: empty string" \
        "$GNU_TOOL -i -S'' A=B env | sort" \
        "$F_TOOL -i -S'' A=B env | sort"

    # From env-S.pl: comments in -S (# terminates args)
    run_test "gnu env -S: comment hash" \
        "$GNU_TOOL -S'echo FOO #BAR'" \
        "$F_TOOL -S'echo FOO #BAR'"

    run_test "gnu env -S: escaped hash" \
        "$GNU_TOOL -S'echo FOO \\#BAR'" \
        "$F_TOOL -S'echo FOO \\#BAR'"

    run_test "gnu env -S: hash in middle of word" \
        "$GNU_TOOL -S'echo FOO#BAR'" \
        "$F_TOOL -S'echo FOO#BAR'"

    # env-S-script.sh: skipped (requires shebang scripts with absolute paths)
    skip_test "env -S shebang script" "Requires shebang scripts with absolute build paths"

    # env-signal-handler.sh: skipped (requires trap, SIGPIPE, timing)
    skip_test "env signal handler" "Requires signal handling, trap, and timing-dependent behavior"

    # env-null.sh: -0 output comparisons with printenv
    # From env-null.sh: -0 does not work if a command is specified
    run_exit_code_test "gnu env: -0 with command fails" \
        "$GNU_TOOL -0 echo hi 2>&1" \
        "$F_TOOL -0 echo hi 2>&1"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent command" \
        "$GNU_TOOL /nonexistent_command_$$ 2>&1" \
        "$F_TOOL /nonexistent_command_$$ 2>&1"


    finish_test_suite
}

run_env_tests
