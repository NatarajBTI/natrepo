set -e

function getAdminURLCore()
{
varstr=$(oc get route -n mas-${var2}-core --no-headers | grep admin.${var2} | awk '{print $2}')
varstr="https://"$varstr""
python test.py
}

var1=$1
var2=$2

if [[ $var1 == "core" ]]; then
getAdminURLCore
elif [[ $var1 == "manage" ]]; then
getAdminURLManage
fi
