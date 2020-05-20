      failTest=false
      echo "---------------"
      echo "Run Unit Tests"
      echo "---------------"
      docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c "cd ${OPENEMR_DIR}; php ${OPENEMR_DIR}/vendor/bin/phpunit --testsuite unit --testdox" || failTest=true
      if $failTest; then
        failJob=true
        mes="FAILED"
      else
        mes="PASSED"
      fi
      echo "-----------------------"
      jobTest="${mes} - Run Unit Tests"
      jobTests+="${jobTest}\n"
      echo "${jobTest}"
      echo "-----------------------"