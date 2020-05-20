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
jobSummary+="--------------------------------------------\n"
jobSummary+="Job Failed: ${failJob}"
echo -e "${jobSummary}"
