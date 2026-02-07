# DuckMail Troubleshooting Guide

## Common Installation Issues

### Issue 1: "command not found: duckmail"

**Symptoms:**
```bash
$ duckmail -h
bash: duckmail: command not found
```

**Solutions:**

1. **Check if installed:**
   ```bash
   ls -la ~/.duckmail/bin/duckmail
   ```
   If file doesn't exist, re-run installer.

2. **Check PATH in current session:**
   ```bash
   echo $PATH | grep -o '[^:]*duckmail[^:]*'
   ```
   
3. **Reload your shell configuration:**
   ```bash
   source ~/.bashrc  # for bash
   # or
   source ~/.zshrc   # for zsh
   ```

4. **Manually add to PATH (temporary):**
   ```bash
   export PATH="$HOME/.duckmail/bin:$PATH"
   ```

5. **Run directly with full path:**
   ```bash
   ~/.duckmail/bin/duckmail -h
   ```

---

### Issue 2: "bash: /duckmail: No such file or directory"

**Symptoms:**
```bash
$ duckmail -t
bash: /duckmail: No such file or directory
```

**Cause:** Function was defined with undefined variable `$bin_dir`

**Solution:** Re-run the installer (fixed in latest version):
```bash
eval "$(curl -fsSL https://raw.githubusercontent.com/balochy/duckmail-cli/main/install/installer.sh)"
```

Or unset the broken function and use the direct path:
```bash
unset -f duckmail
export PATH="$HOME/.duckmail/bin:$PATH"
```

---

### Issue 3: "Error: No token set"

**Symptoms:**
```bash
$ duckmail -g
Error: No token set. Use 'duckmail --token <token>' to set your token.
```

**Solution:**
Set your DuckDuckGo API token first:
```bash
duckmail -t YOUR_TOKEN_HERE
```

**To get your token:**
1. Visit https://duckduckgo.com/email/
2. Sign up and install browser extension
3. Open DevTools (F12) → Network tab
4. Click "Generate Private Duck Address"
5. Find POST request → Headers → Authorization
6. Copy token after "Bearer "

---

### Issue 4: "Failed to generate alias"

**Symptoms:**
```bash
$ duckmail -g
Error: Failed to generate alias. Check your token or try again.
```

**Possible causes:**
1. Invalid or expired token
2. No internet connection
3. DuckDuckGo API is down
4. Missing `jq` command

**Solutions:**

1. **Verify token is saved:**
   ```bash
   cat ~/.duckmail_token
   ```

2. **Get a new token and update:**
   ```bash
   duckmail -t NEW_TOKEN
   ```

3. **Check internet connection:**
   ```bash
   curl -I https://quack.duckduckgo.com
   ```

4. **Install jq if missing:**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install jq
   
   # macOS
   brew install jq
   
   # Fedora
   sudo dnf install jq
   ```

5. **Test the API manually:**
   ```bash
   curl -X POST https://quack.duckduckgo.com/api/email/addresses \
     -H "Authorization: Bearer YOUR_TOKEN" | jq
   ```

---

### Issue 5: Installation fails with "Neither curl nor wget is available"

**Symptoms:**
```
Error: Neither curl nor wget is available
```

**Solution:**
Install curl or wget:

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install curl

# macOS (curl is pre-installed)
# If needed: brew install curl

# Fedora
sudo dnf install curl

# Arch
sudo pacman -S curl