failTest=false
echo "----------------------------------------------------------------------------------------------"
echo "Install and Configure OpenEMR for testing (remove registration modal on login and turn on api)"
echo "----------------------------------------------------------------------------------------------"
sudo chmod 666 sites/default/sqlconf.php || failTest=true
sudo chmod -R 777 sites/default/documents || failTest=true
sudo chmod -R 777 contrib/util/installScripts || failTest=true
sed -e 's@^exit;@ @' < contrib/util/installScripts/InstallerAuto.php > contrib/util/installScripts/InstallerAutoTemp.php || failTest=true
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c "php -f ${OPENEMR_DIR}/contrib/util/installScripts/InstallerAutoTemp.php rootpass=root server=mysql loginhost=%" || failTest=true
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c "rm -f ${OPENEMR_DIR}/contrib/util/installScripts/InstallerAutoTemp.php" || failTest=true
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c 'mysql -u openemr --password="openemr" -h mysql -e "INSERT INTO product_registration (opt_out) VALUES (1)" openemr' || failTest=true
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c 'mysql -u openemr --password="openemr" -h mysql -e "UPDATE globals SET gl_value = 1 WHERE gl_name = \"rest_api\"" openemr' || failTest=true
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c 'mysql -u openemr --password="openemr" -h mysql -e "UPDATE globals SET gl_value = 1 WHERE gl_name = \"rest_fhir_api\"" openemr' || failTest=true
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c 'mysql -u openemr --password="openemr" -h mysql -e "UPDATE globals SET gl_value = 1 WHERE gl_name = \"rest_portal_api\"" openemr' || failTest=true
docker exec -i $(docker ps | grep _openemr | cut -f 1 -d " ") sh -c 'mysql -u openemr --password="openemr" -h mysql -e "UPDATE globals SET gl_value = 1 WHERE gl_name = \"rest_portal_fhir_api\"" openemr' || failTest=true
if $failTest; then
export failJob=true
mes="FAILED"
echo "-------------------------------------------------------------------------------------------------------"
jobTest="${mes} - Install and Configure OpenEMR for testing (remove registration modal on login and turn on api)"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "-------------------------------------------------------------------------------------------------------"
exit 2
else
mes="PASSED"
echo "-------------------------------------------------------------------------------------------------------"
jobTest="${mes} - Install and Configure OpenEMR for testing (remove registration modal on login and turn on api)"
jobTests+="${jobTest}\n"
echo "${jobTest}"
echo "-------------------------------------------------------------------------------------------------------"
exit 0
fi