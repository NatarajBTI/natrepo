set -e

# Get the unique string in the pipeline name which got triggered for this install
varstr1=$(oc get pr -n mas-inst1-pipelines | awk -F' ' '{print $1}')
varstr2=$(echo $varstr1 | cut -d '-' -f 3)

# Function to track the status of each task run in the install pipeline and to exit in case of failure and to wait for 50 retries (with 180 seconds delay between each retry) in case if the task is still running.

function verifyPipelineTaskStatus()
{

for (( i=0; i<=50; i++ ));
	do
		varstr3=$(oc get taskrun $1 -n mas-inst1-pipelines | awk -F' ' '{print $3}')
        varstr3=$(echo $varstr3 | cut -d ' ' -f 1)

        varstr4=$(oc get taskrun $1 -n mas-inst1-pipelines | awk -F' ' '{print $3}')
        varstr4=$(echo $varstr4 | cut -d ' ' -f 2)

        if [[ $varstr3 == "REASON" && $varstr4 == "Succeeded"  ]]; then
                echo "$1 Task run successful"
                break
        elif [[ $varstr3 == "REASON" && $varstr4 == "Running"  ]]; then
             	echo "$1 Task run is still running"
                sleep 180
        else
                echo "$1 Task run failed"
           		exit 1
    	fi
        done
}

sleep 60
verifyPipelineTaskStatus inst1-install-$varstr2-gencfg-workspace
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-pre-install-check
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-ibm-catalogs
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-cluster-monitoring
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-common-services
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-uds
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-cert-manager
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-mongodb
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-db2-manage
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-suite-dns
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-sls
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-suite-install
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-suite-config
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-suite-verify
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-suite-config-db2
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-suite-db2-setup-manage
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-app-install-manage
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-app-cfg-manage
sleep 20
verifyPipelineTaskStatus inst1-install-$varstr2-post-install-verify
