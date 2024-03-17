varstr=$(oc get route -n mas-inst3-core --no-headers | grep 'admin.inst3' | awk '{print $2}')
varstr="https://"$varstr"/maximo"
echo -n '{"admin_url":"'"${varstr}"'"}'
