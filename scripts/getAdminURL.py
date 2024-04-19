
import json
import subprocess
import sys

def getAdminURLCore(kube_config, instid):
    RETRY_COUNT = 3
    TIME_TO_WAIT = 60
    try:
        result = {"admin_url": ""}
        for interval_count in range(RETRY_COUNT):
            process = subprocess.Popen(['oc', 'get', 'route',
                                        '-n', f'mas-{instid}-core',
                                        '-o', 'json',
                                        '--kubeconfig', kube_config],
                                        stdout=subprocess.PIPE, universal_newlines=True)
            output, _ = process.communicate()
            data = json.loads(output)
            routes = data.get('items', [])
            varstr = ""
            for route in routes:
                if route.get('spec', {}).get('host', '').startswith(f'admin.{instid}'):
                    varstr = route['spec']['host']
                    break
            result['admin_url'] = f'https://{varstr}' if varstr else ''
            json_output = json.dumps(result)
            print(json_output)

    except Exception as e:
        varstr = ""
        result['admin_url'] = varstr
        json_output = json.dumps(result)
        print(json_output)

def getAdminURLManage(kube_config, instid, workspaceId):
    try:
        result = {"admin_url": ""}
        process = subprocess.Popen(['oc', 'get', 'route',
                                    '-n', f'mas-{instid}-manage',
                                    '-o', 'json',
                                    '--kubeconfig', kube_config],
                                    stdout=subprocess.PIPE, universal_newlines=True)
        output, _ = process.communicate()
        data = json.loads(output)
        routes = data.get('items', [])
        varstr = ""
        for route in routes:
            if route.get('spec', {}).get('host', '').startswith(f'{workspaceId}-all.manage.{instid}'):
                varstr = route['spec']['host']
                break
        result['admin_url'] = f'https://{varstr}/maximo' if varstr else ''
        json_output = json.dumps(result)
        print(json_output)

    except Exception as e:
        varstr = ""
        result['admin_url'] = varstr
        json_output = json.dumps(result)
        print(json_output)

if __name__ == "__main__":
    input_json = json.loads(sys.stdin.read())
    kubeconfig = input_json['KUBECONFIG']
    capability = sys.argv[1]
    instanceId = sys.argv[2]
    workspaceId = sys.argv[3]

    if capability == "core":
        getAdminURLCore(kube_config=kubeconfig, instid=instanceId)
    elif capability == "manage":
        getAdminURLManage(kube_config=kubeconfig, instid=instanceId, workspaceId=workspaceId)
