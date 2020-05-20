failTest=false
echo "--------------------------------------"
echo "Checking for PHP styling (PSR-12) issues"
echo "--------------------------------------"
composer global require "squizlabs/php_codesniffer=3.*" || failTest=true
/home/runner/.composer/vendor/bin/phpcs -p -n --extensions=php,inc --report-width=120 --standard=ci/phpcs.xml --report=full $GITHUB_WORKSPACE || failTest=true
# todo clean up method visibility and other refactors in src/
# $HOME/.config/composer/vendor/bin/phpcs -p -n --extensions=php,inc --report-width=120 --standard=ci/phpcs_src.xml --report=full src/ || failTest=true

if $failTest; then
failJob=true
mes="FAILED"
else
mes="PASSED"
fi
echo "-----------------------------------------------"
jobTest="${mes} - Checking for PHP styling (PSR-12) issues"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "-----------------------------------------------"
