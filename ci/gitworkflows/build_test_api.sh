failTest=false
echo "-------------"
echo "Run Api Tests"
echo "-------------"
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c "cd ${OPENEMR_DIR}; php ${OPENEMR_DIR}/vendor/bin/phpunit --testsuite api --testdox" || failTest=true
if $failTest; then
  failJob=true
  mes="FAILED"
else
  mes="PASSED"
fi
echo "----------------------"
jobTest="${mes} - Run Api Tests"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "----------------------"