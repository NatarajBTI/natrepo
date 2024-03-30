set -e

function getAdminURLCore()
{
varstr=$(oc get route -n mas-${var2}-core --no-headers | grep admin.${var2} | awk '{print $2}')
varstr="https://"$varstr""
jq --arg key0   'admin_url' \
   --arg value0 $varstr \
   '. | .[$key0]=$value0' \
   <<<'{}'
}

function getAdminURLManage()
{
varstr=$(oc get route -n mas-${var2}-manage --no-headers | grep ${var3}-all.manage | awk '{print $2}')
varstr="https://"$varstr"/maximo"
echo -n '{"admin_url":"'"${varstr}"'"}'
}

var1=$1
var2=$2
var3=$3

if [[ $var1 == "core" ]]; then
getAdminURLCore
elif [[ $var1 == "manage" ]]; then
getAdminURLManage
fi
