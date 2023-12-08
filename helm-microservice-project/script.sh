#!/bin/sh
CWD=$(pwd)
cd "apps/helloworld"
echo "BUILDING HELLO APP"
echo "**********************************\n"
docker build -t helloapp:v3 .
cd $CWD
cd "apps/reversehello"
echo "BUILDING REVERSE APP"
docker build -t reversehello:v3 .
cd $CWD
#assuming cluster is running in minikube, need to load the images
echo "\nLOADING IMAGE TO MINIKUBE"
echo "**********************************\n"
minikube image load helloapp:v3
minikube image load reversehello:v3

#create k8 namespace
echo "CREATING NAMESPACE and SETTING CONTEXT"
echo "**********************************\n"
kubectl create namespace sap
kubectl config set-context --current --namespace sap

#helmdeployment
echo "HELM DEPLOYMENT"
echo "**********************************\n"
cd "helmcharts"
echo $(pwd)
helm install hellorelease sap --values sap/values-hello.yaml
helm install reversehello  sap --values sap/values-reverse.yaml

#TODO Better logic with pods' status
echo "WAITING FOR PODS TO COME UP"
echo "**********************************\n"
sleep 20s

echo "HTTP RESPONSE OF THE APPLICATIONS"
echo "**********************************\n"   
for i in `kubectl get pods -o=jsonpath="{range.items[*]}{.status.podIP}:{.spec.containers..containerPort}{'\n'}{end}"`; do minikube ssh "curl '$i'" ; done





