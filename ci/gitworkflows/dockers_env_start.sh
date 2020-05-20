failTest=false
echo "---------------------------------------------------------------------"
echo "Start up the appropriate testing docker system to allow testing below"
echo "---------------------------------------------------------------------"
cd ci/${DOCKER_DIR} || failTest=true
docker-compose up -d || failTest=true
cd ../../ || failTest=true
if $failTest; then
failJob=true
mes="FAILED"
echo "------------------------------------------------------------------------------"
jobTest="${mes} - Start up the appropriate testing docker system to allow testing below"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "------------------------------------------------------------------------------"
exit 2
else
mes="PASSED"
echo "------------------------------------------------------------------------------"
jobTest="${mes} - Start up the appropriate testing docker system to allow testing below"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "------------------------------------------------------------------------------"
exit 0
fi
