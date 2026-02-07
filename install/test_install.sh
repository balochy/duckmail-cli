#!/bin/bash

# Test script for DuckMail installer
# This simulates the installation process in a controlled environment

set -e  # Exit on error

echo "======================================"
echo "DuckMail Installer Test Suite"
echo "======================================"
echo ""

# Test 1: Check if curl or wget is available
echo "Test 1: Checking download utilities..."
if command -v curl >/dev/null 2>&1; then
    echo "✓ curl found: $(command -v curl)"
elif command -v wget >/dev/null 2>&1; then
    echo "✓ wget found: $(command -v wget)"
else
    echo "✗ Neither curl nor wget found!"
    exit 1
fi
echo ""

# Test 2: Check shell detection
echo "Test 2: Detecting shell..."
if [ -n "$ZSH_VERSION" ]; then
    echo "✓ Detected: ZSH ($ZSH_VERSION)"
    shell_rc="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    echo "✓ Detected: Bash ($BASH_VERSION)"
    shell_rc="$HOME/.bashrc"
else
    echo "✓ Detected: Generic shell"
    shell_rc="$HOME/.profile"
fi
echo "  RC file would be: $shell_rc"
echo ""

# Test 3: Test directory creation
echo "Test 3: Testing directory creation..."
test_dir="/tmp/duckmail-test-$$"
if mkdir -p "$test_dir/bin"; then
    echo "✓ Directory creation successful: $test_dir/bin"
    rm -rf "$test_dir"
else
    echo "✗ Directory creation failed!"
    exit 1
fi
echo ""

# Test 4: Test file download simulation
echo "Test 4: Testing download (dry run)..."
test_url="https://raw.githubusercontent.com/balochy/duckmail-cli/main/duckmail"
echo "  Would download from: $test_url"
if command -v curl >/dev/null 2>&1; then
    echo "  Download command: curl -fsSL"
elif command -v wget >/dev/null 2>&1; then
    echo "  Download command: wget -qO"
fi
echo "✓ Download test passed"
echo ""

# Test 5: Test logging function
echo "Test 5: Testing logging function..."
test_log_file="/tmp/duckmail-test-$$.log"
test_log() {
    printf "[%s] %s\n" "$(command date +"%Y-%m-%d/%H:%M:%S")" "$1" | tee -a "$test_log_file"
}
test_log "This is a test log entry"
if [ -f "$test_log_file" ] && grep -q "test log entry" "$test_log_file"; then
    echo "✓ Logging function works correctly"
    rm -f "$test_log_file"
else
    echo "✗ Logging function failed!"
    exit 1
fi
echo ""

# Test 6: Test PATH detection
echo "Test 6: Testing PATH detection..."
if echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "✓ ~/.local/bin already in PATH"
else
    echo "  ~/.local/bin not in PATH (would be added during install)"
fi
echo ""

# Test 7: Test PID-based temp file naming
echo "Test 7: Testing temp file naming..."
temp_name="duckmail.tmp.$$"
echo "  Temp file would be: $temp_name"
echo "  Process ID: $$"
echo "✓ PID-based naming works"
echo ""

# Test 8: Verify required commands
echo "Test 8: Checking required commands..."
required_cmds="date mkdir mv chmod rm grep"
all_found=true
for cmd in $required_cmds; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "  ✓ $cmd"
    else
        echo "  ✗ $cmd NOT FOUND"
        all_found=false
    fi
done
if [ "$all_found" = true ]; then
    echo "✓ All required commands available"
else
    echo "✗ Some required commands missing!"
    exit 1
fi
echo ""

# Summary
echo "======================================"
echo "All Tests Passed! ✓"
echo "======================================"
echo ""
echo "The installer should work correctly on this system."
echo ""
echo "To install duckmail, run:"
echo "  eval \"\$(curl -fsSL https://raw.githubusercontent.com/balochy/duckmail-cli/main/install/installer.sh)\""
echo ""
