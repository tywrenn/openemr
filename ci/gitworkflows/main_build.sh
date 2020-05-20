failTest=false
echo "------------------"
echo "Main OpenEMR Build"
echo "------------------"
mkdir vendor || failTest=true
mkdir node_modules || failTest=true
sudo chmod -R 777 vendor || failTest=true
sudo chmod -R 777 node_modules || failTest=true
sudo chmod -R 777 public || failTest=true
composer install || failTest=true
npm install || failTest=true
npm run build || failTest=true
composer global require phing/phing || failTest=true
/home/runner/.composer/vendor/bin/phing vendor-clean || failTest=true
/home/runner/.composer/vendor/bin/phing assets-clean || failTest=true
composer global remove phing/phing || failTest=true
composer dump-autoload -o || failTest=true
rm -fr node_modules || failTest=true
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
