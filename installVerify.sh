varstr1=$(oc get pr -n mas-inst7-pipelines | awk -F' ' '{print $1}')
echo $varstr1
varstr2=$(echo $varstr1 | cut -d '-' -f 3)
echo $varstr2

set -e

function getResult()
{

for (( i=0; i<=50; i++ ));
do
varstr3=$(oc get taskrun $1 -n mas-inst7-pipelines | awk -F' ' '{print $3}')
        varstr3=$(echo $varstr3 | cut -d ' ' -f 1)

                varstr4=$(oc get taskrun $1 -n mas-inst7-pipelines | awk -F' ' '{print $3}')
        varstr4=$(echo $varstr4 | cut -d ' ' -f 2)

                echo " varstr3 : $varstr3"
        echo " varstr4 : $varstr4"

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
        echo "This code won't be reached"
        done
}


getResult inst7-install-$varstr2-pre-install-check
getResult inst7-install-$varstr2-gencfg-workspace
getResult inst7-install-$varstr2-ibm-catalogs
getResult inst7-install-$varstr2-cluster-monitoring
getResult inst7-install-$varstr2-common-services
getResult inst7-install-$varstr2-uds
getResult inst7-install-$varstr2-cert-manager
getResult inst7-install-$varstr2-mongodb
getResult inst7-install-$varstr2-db2-manage
getResult inst7-install-$varstr2-suite-dns
getResult inst7-install-$varstr2-sls
getResult inst7-install-$varstr2-suite-install
getResult inst7-install-$varstr2-suite-config
getResult inst7-install-$varstr2-suite-verify
getResult inst7-install-$varstr2-suite-config-db2
getResult inst7-install-$varstr2-suite-db2-setup-manage
getResult inst7-install-$varstr2-app-install-manage
getResult inst7-install-$varstr2-app-cfg-manage
getResult inst7-install-$varstr2-post-install-verify