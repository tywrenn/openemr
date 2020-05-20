failTest=false
echo "------------------"
echo "Main OpenEMR Build"
echo "------------------"
sudo composer install || failTest=true
sudo npm install || failTest=true
sudo npm run build || failTest=true
sudo composer global require phing/phing || failTest=true
sudo /home/runner/.composer/vendor/bin/phing vendor-clean || failTest=true
sudo /home/runner/.composer/vendor/bin/phing assets-clean || failTest=true
sudo composer global remove phing/phing || failTest=true
sudo composer dump-autoload -o || failTest=true
sudo rm -fr node_modules || failTest=true
if $failTest; then
export failJob=true
mes="FAILED"
echo "---------------------------"
jobTest="${mes} - Main OpenEMR Build"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "---------------------------"
exit 2
else
mes="PASSED"
echo "---------------------------"
jobTest="${mes} - Main OpenEMR Build"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "---------------------------"
exit 0
fi
