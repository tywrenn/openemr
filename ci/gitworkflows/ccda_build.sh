failTest=false
echo "------------------"
echo "CCDA OpenEMR Build"
echo "------------------"
sudo chmod -R 777 ccdaservice || failTest=true
cd ccdaservice || failTest=true
sudo npm install || failTest=true
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