failTest=false
echo "--------------------------------------"
echo "Checking for PHP theme styling issues"
echo "--------------------------------------"
npm install || failTest=true
npx stylelint "**/*.css" || failTest=true
npx stylelint "**/*.scss" || failTest=true

if $failTest; then
	failJob=true
	mes="FAILED"
	echo "-----------------------------------------------"
	jobTest="${mes} - Checking for PHP theme styling issues"
	jobTests+="${jobTest}\n"
	echo "${jobTest}"
	echo "-----------------------------------------------"
	exit 1
else
	mes="PASSED"
	echo "-----------------------------------------------"
	jobTest="${mes} - Checking for PHP theme styling issues"
	jobTests+="${jobTest}\n"
	echo "${jobTest}"
	echo "-----------------------------------------------"
	exit 0
fi
