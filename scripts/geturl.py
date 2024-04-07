import json
import os

def getAdminURLCore(dep_flavor, instid, wrksid):
    varstr = os.popen('oc get route -n mas-' + instid + '-core --no-headers | grep admin.' + instid + ' | awk \'{print $2}\'').read().strip()
    varstr = "c104-e.br-sao.containers.cloud.ibm.com:31295"
    url = "https://" + varstr
    data = {
    "admin_url": url
    }
    # Encode the dictionary into JSON format
    json_output = json.dumps(data)

    # Print the JSON output
    print(json_output)

getAdminURLCore(dep_flavor="core", instid="natinst1", wrksid="wrkid1")
