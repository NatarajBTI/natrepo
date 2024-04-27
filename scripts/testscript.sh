set -e

sleep 10

oc patch configmap my-config -n default -p '{"data": {"pipelineStatus": "Success"}}'
echo -n '{"PipelineRunStatus":"'"Successful"'"}' > admin-url.txt