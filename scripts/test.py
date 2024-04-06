import json
import os

def getAdminURLCore(dep_flavor, instid, wrksid):
    varstr = os.popen('oc get route -n mas-' + instid + '-core --no-headers | grep admin.' + instid + ' | awk \'{print $2}\'').read().strip()
    url = "https://" + varstr
    json_object = { 'admin_url': url }
    json_data = json.dumps(json_object)
    print(json_data)

getAdminURLCore(dep_flavor="core", instid="natinst3", wrksid="wrkid3")
