failTest=false
echo "------------------"
echo "CCDA OpenEMR Build"
echo "------------------"
cd ccdaservice || failTest=true
mdkir node_modules || failTest=true
sudo chmod 777 node_modules || failTest=true
npm install || failTest=true
cd ../ || failTest=true
if $failTest; then
export failJob=true
mes="FAILED"
echo "---------------------------"
jobTest="${mes} - CCDA OpenEMR Build"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "---------------------------"
exit 2
else
mes="PASSED"
echo "---------------------------"
jobTest="${mes} - CCDA OpenEMR Build"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "---------------------------"
exit 0
fi
