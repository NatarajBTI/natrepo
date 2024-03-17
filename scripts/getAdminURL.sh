varstr=$(oc get route -n mas-inst4-core --no-headers | grep 'admin.inst4' | awk '{print $2}')
varstr="https://"$varstr"/maximo"
echo -n '{"admin_url":"'"${varstr}"'"}'
