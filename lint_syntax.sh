if find . -type f -name "*.php" -exec php -d error_reporting=32767 -l {} \; 2>&1 >&- | grep "^"; then exit 1; fi
if find . -type f -name "*.inc" -exec php -d error_reporting=32767 -l {} \; 2>&1 >&- | grep "^"; then exit 1; fi
