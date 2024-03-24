set -e

# Function to track the status of pipeline and to exit in case of failure and to wait for 50 retries (with 180 seconds delay between each retry) in case if the pipeline is still running.

sleep 300

function verifyPipelineStatusManage()
{

for (( i=0; i<=60; i++ ));
        do
                varstr3=$(oc get pr -n mas-${var2}-pipelines | awk -F' ' '{print $3}')
        varstr3=$(echo $varstr3 | cut -d ' ' -f 1)

        varstr4=$(oc get pr -n mas-${var2}-pipelines | awk -F' ' '{print $3}')
        varstr4=$(echo $varstr4 | cut -d ' ' -f 2)

        if [[ $varstr3 == "REASON" && $varstr4 == "Completed"  ]]; then
                echo "Install pipeline as completed successfully"
                break
        elif [[ $varstr3 == "REASON" && $varstr4 == "Running"  ]]; then
                echo "Install pipeline is still running"
                sleep 300
        else
                echo "Install pipeline failed"
                        exit 1
        fi
        done
}

function verifyPipelineStatusCore()
{

for (( i=0; i<=30; i++ ));
        do
                varstr3=$(oc get pr -n mas-${var2}-pipelines | awk -F' ' '{print $3}')
        varstr3=$(echo $varstr3 | cut -d ' ' -f 1)

        varstr4=$(oc get pr -n mas-${var2}-pipelines | awk -F' ' '{print $3}')
        varstr4=$(echo $varstr4 | cut -d ' ' -f 2)

        if [[ $varstr3 == "REASON" && $varstr4 == "Completed"  ]]; then
                echo "Install pipeline as completed successfully"
                break
        elif [[ $varstr3 == "REASON" && $varstr4 == "Running"  ]]; then
                echo "Install pipeline is still running"
                sleep 180
        else
                echo "Install pipeline failed"
                        exit 1
        fi
        done
}
var1=$1
var2=$2
echo "Deployment flavour is:" $1
echo "Instance Id is:" $2

if [[ $var1 == "core" ]]; then
verifyPipelineStatusCore
elif [[ $var1 == "manage" ]]; then
verifyPipelineStatusManage
else
echo "Invalid deployment flavour option is inputted"
exit 1
fi
