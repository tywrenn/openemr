failTest=false
jobTests=""
echo "---------------------------------------------------------------------"
echo "Start up the appropriate testing docker system to allow testing below"
echo "---------------------------------------------------------------------"
cd ci/${DOCKER_DIR} || failTest=true
docker-compose up -d || failTest=true
cd ../../ || failTest=true
if $failTest; then
failJob=true
mes="FAILED"
else
mes="PASSED"
fi
echo "------------------------------------------------------------------------------"
jobTest="${mes} - Start up the appropriate testing docker system to allow testing below"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "------------------------------------------------------------------------------"
