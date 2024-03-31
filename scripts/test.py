import json

str1 = "https://admin.natinst2.masda302-workload-cluster-6f1620198115433da1cac8216c06779b-0000.eu-gb.containers.appdomain.cloud"

print(json.dumps({ 'admin_url': str1 }, ensure_ascii=False))
