failTest=false
echo "------------------"
echo "CCDA OpenEMR Build"
echo "------------------"
cd ccdaservice || failTest=true
npm install || failTest=true
cd ../ || failTest=true
if $failTest; then
failJob=true
mes="FAILED"
else
mes="PASSED"
fi
echo "---------------------------"
jobTest="${mes} - CCDA OpenEMR Build"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "---------------------------"
