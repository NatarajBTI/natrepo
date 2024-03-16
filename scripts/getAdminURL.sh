varstr=$(oc get route -n mas-inst1-manage --no-headers | grep 'wrkid1-all.manage' | awk '{print $2}')
varstr="https://"$varstr"/maximo"
echo -n '{"admin_url":"'"${varstr}"'"}'
