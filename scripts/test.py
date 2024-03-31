import json
import os

def getAdminURLCore(dep_flavor, instid, wrksid):
    varstr = os.popen('oc get route -n mas-' + instid + '-core --no-headers | grep admin.' + instid + ' | awk \'{print $2}\'').read().strip()
    url = "https://" + varstr
    print(url)

getAdminURLCore(dep_flavor = "core", instid = "natinst2", wrksid = "wrkid2")
