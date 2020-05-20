failTest=false
echo "------------------"
echo "CCDA OpenEMR Build"
echo "------------------"
cd ccdaservice || failTest=true
echo "Running node in sudo -- This is normal for CI as it doesn't like directory perms too much here"
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
