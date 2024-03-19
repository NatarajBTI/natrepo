set -e

function getAdminURLCore()
{
varstr=$(oc get route -n mas-${var2}-core --no-headers | grep 'admin.${var2}' | awk '{print $2}')
varstr="https://"$varstr""
echo -n '{"admin_url":"'"${varstr}"'"}'
}

function getAdminURLManage()
{
varstr=$(oc get route -n mas-${var2}-manage --no-headers | grep 'wrkid2-all.manage' | awk '{print $2}')
varstr="https://"$varstr"/maximo"
echo -n '{"admin_url":"'"${varstr}"'"}'
}

var1=$1
var2=$2
echo "Deployment flavour is:" $1
echo "Instance Id is:" $2

if [[ $var1=="core" ]]; then
getAdminURLCore
else [[ $var1=="manage" ]]; then
getAdminURLManage
fi

