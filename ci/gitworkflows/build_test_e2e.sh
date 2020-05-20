failTest=false
echo "-------------"
echo "Run E2e Tests"
echo "-------------"
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c "${CHROMIUM_INSTALL}; export PANTHER_NO_SANDBOX=1; cd ${OPENEMR_DIR}; php ${OPENEMR_DIR}/vendor/bin/phpunit --testsuite e2e --testdox" || failTest=true
if $failTest; then
export failJob=true
mes="FAILED"
echo "----------------------"
jobTest="${mes} - Run E2e Tests"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "----------------------"
exit 2
else
mes="PASSED"
echo "----------------------"
jobTest="${mes} - Run E2e Tests"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "----------------------"
exit 0
fi
