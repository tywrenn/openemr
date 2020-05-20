failTest=false
echo "-------------"
echo "Run Api Tests"
echo "-------------"
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c "cd ${OPENEMR_DIR}; php ${OPENEMR_DIR}/vendor/bin/phpunit --testsuite api --testdox" || failTest=true
if $failTest; then
  export failJob=true
  mes="FAILED"
  echo "----------------------"
  jobTest="${mes} - Run Api Tests"
  jobTests+="${jobTest}\n"
  echo "${jobTest}"
  echo "----------------------"
  exit 2
else
  mes="PASSED"
  echo "----------------------"
  jobTest="${mes} - Run Api Tests"
  jobTests+="${jobTest}\n"
  echo "${jobTest}"
  echo "----------------------"
  exit 0
fi
