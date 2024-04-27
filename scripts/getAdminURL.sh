set -e

function getAdminURL()
{
varstr=$(oc get route -n mas-${var2}-core --no-headers | grep admin.${var2} | awk '{print $2}')
varstr="https://"$varstr""
echo -n '{"admin_url":"'"${varstr}"'"}' > url.txt
chmod +x url.txt
}

var1=$1
var2=$2

getAdminURL


