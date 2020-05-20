if $failJob; then
mes="FAILED"
else
mes="PASSED"
fi
jobSummary="--------------------------------------------\n"
jobSummary+="--------------------------------------------\n"
jobSummary+="${mes} - JOB SUMMARY\n"
jobSummary+="--------------------------------------------\n"
jobSummary+="${jobTests}"
jobSummary+="--------------------------------------------"
echo -e "${jobSummary}"
if $failJob; then exit 1; fi
