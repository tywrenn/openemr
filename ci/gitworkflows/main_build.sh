failTest=false
echo "------------------"
echo "Main OpenEMR Build"
echo "------------------"
cd $GITHUB_WORKSPACE || failTest=true
sudo composer install || failTest=true
npm install || failTest=true
npm run build || failTest=true
sudo composer global require phing/phing || failTest=true
sudo /home/runner/.composer/vendor/bin/phing vendor-clean || failTest=true
sudo /home/runner/.composer/vendor/bin/phing assets-clean || failTest=true
sudo composer global remove phing/phing || failTest=true
sudo composer dump-autoload -o || failTest=true
rm -fr node_modules || failTest=true
if $failTest; then
failJob=true
mes="FAILED"
else
mes="PASSED"
fi
echo "---------------------------"
jobTest="${mes} - Main OpenEMR Build"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "---------------------------"
