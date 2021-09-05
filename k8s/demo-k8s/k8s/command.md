### install dashboard and metrics-server
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml
    kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

### delete dashboard and metrics-server
    kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml
    kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

### patch dashboard to prevent from login
    kubectl patch deployment kubernetes-dashboard -n kubernetes-dashboard --type 'json' -p '[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--enable-skip-login"}]'

### patch metrics-server to deactivate tls
    kubectl patch deployment metrics-server -n kube-system --type 'json' -p '[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'

### access
    kubectl proxy
    http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

    kubectl proxy -p 8002
    http://localhost:8002/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

### context
    kubectl config get-contexts
    kubectl config use-context docker-desktop

### create context with kind
    kind create cluster --name wslkind
    kubectl cluster-info --context kind-wslkind
    kubectl config use-context kind-wslkind


### other
    kubectl cluster-info --context kind-wslkindmultinodes
    kubectl get all --all-namespaces

    kind get clusters
    kind delete cluster --name wslkind
    kind delete cluster --name wslkindmultinodes

    kubectl delete namespace kubernetes-dashboard
    kubectl delete namespace istio-system
    kubectl label namespace default istio-injection

    kubectl delete namespace dev


    Get the application URL by running these commands:

helm create springboot
helm template springboot
helm install springboot --debug --dry-run springboot
helm install myfirstspringboot springboot
helm list -a
helm upgrade myfirstspringboot .
helm rollback myfirstspringboot 1
helm list -a
helm delete myfirstspringboot

    export POD_NAME=$(kubectl get pods --namespace dev -l "app.kubernetes.io/name=springboot,app.kubernetes.io/instance=myfirstspringboot" -o jsonpath="{.items[0].metadata.name}")
    export CONTAINER_PORT=$(kubectl get pod --namespace dev $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
    echo "Visit http://127.0.0.1:8080 to use your application"
    kubectl --namespace dev port-forward $POD_NAME 8080:$CONTAINER_PORT

helm install -f charts/values.yaml mysecondspringboot ./charts
helm delete mysecondspringboot

    export POD_NAME=$(kubectl get pods --namespace dev -l "app.kubernetes.io/name=springboot,app.kubernetes.io/instance=mysecondspringboot" -o jsonpath="{.items[0].metadata.name}")
    export CONTAINER_PORT=$(kubectl get pod --namespace dev $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
    echo "Visit http://127.0.0.1:8080 to use your application"
    kubectl --namespace dev port-forward $POD_NAME 8080:$CONTAINER_PORT

helm upgrade --install mythirdspringboot ./charts --values charts/values.yaml

    export POD_NAME=$(kubectl get pods --namespace dev -l "app.kubernetes.io/name=springboot,app.kubernetes.io/instance=mythirdspringboot" -o jsonpath="{.items[0].metadata.name}")
    export CONTAINER_PORT=$(kubectl get pod --namespace dev $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
    echo "Visit http://127.0.0.1:8080 to use your application"
    kubectl --namespace dev port-forward $POD_NAME 8080:$CONTAINER_PORT

    export POD_NAME=$(kubectl get pods --namespace dev -l "app.kubernetes.io/name=springboot,app.kubernetes.io/instance=skaffold-helm" -o jsonpath="{.items[0].metadata.name}")
    export CONTAINER_PORT=$(kubectl get pod --namespace dev $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
    echo "Visit http://127.0.0.1:8080 to use your application"
    kubectl --namespace dev port-forward $POD_NAME 8080:$CONTAINER_PORT

