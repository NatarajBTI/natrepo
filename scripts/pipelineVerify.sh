var1=$1
 do
        varstr3=$(oc get pr -n mas-${var1}-pipelines | awk -F' ' '{print $3}')
        varstr3=$(echo $varstr3 | cut -d ' ' -f 1)

        varstr4=$(oc get pr -n mas-${var1}-pipelines | awk -F' ' '{print $3}')
        varstr4=$(echo $varstr4 | cut -d ' ' -f 2)

        if [[ $varstr3 == "REASON" && $varstr4 == "Completed"  ]]; then                
                break
        elif [[ $varstr3 == "REASON" && $varstr4 == "Running"  ]]; then
                exit
        elif [[ $varstr3 == "REASON" && $varstr4 == "Failed"  ]]; then
        	      exit
        fi
        done
