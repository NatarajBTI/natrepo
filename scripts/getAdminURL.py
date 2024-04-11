import json
import subprocess
import sys


def getAdminURLCore(kube_config, instid):
    try:
        process = subprocess.Popen(['oc', 'get', 'route',
                                    '-n', f'mas-{instid}-core',
                                    '-o', 'json',
                                    '--kubeconfig', kube_config],
                                   stdout=subprocess.PIPE, universal_newlines=True)

        output, _ = process.communicate()

        if process.returncode != 0:
            print({
                "error":f"Failed to execute 'oc get route' command"
            })
            return

        data = json.loads(output)
        routes = data.get('items', [])
        varstr = ""
        for route in routes:
            if f'admin.{instid}' in route['spec']['host']:
                varstr = route['spec']['host']
                break
        else:
            print({
                "error":f"Error: No route found for 'admin.{instid}'"
            })
            return

        result = {
            "admin_url": f"https://{varstr}"
        }
        json_output = json.dumps(result)
        print(json_output)

    except json.JSONDecodeError as e:
        error = {"error":f"Error: Failed to parse JSON: {e}"}
        json_error = json.dumps(error)
        print(json_error)

    except subprocess.CalledProcessError as e:
        error = {
            "error": f"Error: Command '{e.cmd}' returned non-zero exit status {e.returncode}"
        }
        json_error = json.dumps(error)
        print(json_error)

    except OSError as e:
        error = {
            "error" : f"Error: Failed to execute command: {e}"
        }
        json_error = json.dumps(error)
        print(json_error)

def getAdminURLManage(kube_config, instid,workspaceId):
    try:
        process = subprocess.Popen(['oc', 'get', 'route',
                                    '-n', f'mas-{instid}-manage',
                                    '-o', 'json',
                                    '--kubeconfig', kube_config],
                                   stdout=subprocess.PIPE, universal_newlines=True)

        output, _ = process.communicate()

        if process.returncode != 0:
            print({
                "error":"Failed to execute 'oc get route' command"
            })
            return

        data = json.loads(output)
        routes = data.get('items', [])
        varstr = ""
        for route in routes:
            if f'{workspaceId}-all.{instid}' in route['spec']['host']:
                varstr = route['spec']['host']
                break
        else:
            print({
                "error": f"No route found for '{workspaceId}-all.{instid}'"
            })
            return

        result = {
            "admin_url": f"https://{varstr}/maximo"
        }
        json_output = json.dumps(result)
        print(json_output)

    except json.JSONDecodeError as e:
        error = {"error":f"Error: Failed to parse JSON: {e}"}
        json_error = json.dumps(error)
        print(json_error)
        

    except subprocess.CalledProcessError as e:
        error = {
            "error": f"Error: Command '{e.cmd}' returned non-zero exit status {e.returncode}"
        }
        json_error = json.dumps(error)
        print(json_error)
        
    except OSError as e:
        error = {
            "error" : f"Error: Failed to execute command: {e}"
        }
        json_error = json.dumps(error)
        print(json_error)


if __name__ == "__main__":
    # get KUBECONFIG containing path from json passed to the command as an argument
    # Read the JSON input from stdin
    input_json = json.loads(sys.stdin.read())

    # get the KUBECONFIG path from the json
    kubeconfig = input_json['KUBECONFIG']

    capability = sys.argv[1]
    instanceId = sys.argv[2]
    workspaceId = sys.argv[3]
    
    if capability == "core":
        getAdminURLCore(kube_config=kubeconfig, instid=instanceId)
    elif capability == "manage":
        getAdminURLManage(kube_config=kubeconfig, instid=instanceId,workspaceId=workspaceId)
