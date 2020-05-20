failTest=false
echo "------------------------------"
echo "Checking for PHP syntax errors"
echo "------------------------------"
failSyntax=false
if find . -type f -name "*.php" -exec php -d error_reporting=32767 -l {} \; 2>&1 >&- | grep "^"; then failSyntax=true; fi
if find . -type f -name "*.inc" -exec php -d error_reporting=32767 -l {} \; 2>&1 >&- | grep "^"; then failSyntax=true; fi
if $failSyntax; then
failTest=true
fi
if $failTest; then
export failJob=true
mes="FAILED"
echo "---------------------------------------"
jobTest="${mes} - Checking for PHP syntax errors"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "---------------------------------------"
exit 2
else
mes="PASSED"
echo "---------------------------------------"
jobTest="${mes} - Checking for PHP syntax errors"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "---------------------------------------"
exit 0
fi
