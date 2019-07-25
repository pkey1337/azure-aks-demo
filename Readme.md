# Azure AKS Demo
[![Build Status](https://dev.azure.com/TOWEAKSDemo/AzureAKSDemo/_apis/build/status/AzureAKSDemo?branchName=master)](https://dev.azure.com/TOWEAKSDemo/AzureAKSDemo/_build/latest?definitionId=1&branchName=master)

## Repository structure
```
- app
  - azure-aks-demo (Main Spring Boot application)
- infra
  - azure-aks-demo (Docker build artifacts)
  - charts (Helm Charts for Kubernetes Deployments)
  - terraform-aks-k8s (Terraform templates for AKS and ACR)
- workflow
  - azure-pipelines.yml (Azure DevOps pipeline definitions)
```

## Preparation
### Kubernetes deployment
For tiller is a ServiceAccount needed:
```bash
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
kubectl create namespace azuredemo
kubectl create clusterrolebinding default-view --clusterrole=view --serviceaccount=azuredemo:default
```
### Ingress controller
```bash
helm install stable/nginx-ingress \
    --namespace azuredemo \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
```
### DevOps project
Build variables:
```yaml
registryName: Short name of ACR
registryUsername: ACR Username
registryPassword: ACR Password (Secret)
```
Release variables:
```yaml
projectName: azure-aks-demo
registryName: Short name of ACR
registryUsername: ACR Username
registryPassword: ACR Password (Secret)
```