
## Demo API
Accessible on http://35.230.140.226:50000/ .

## Prerequisites
- `make` - contains useful command for working with the project (building images / applying terraform configuration)
- `gcloud` - google cloud SDK - communication with google cloud platform
- `docker` - for building docker images
- `kubectl` - for working with kubernetes
- `terraform 0.12.2` - for creating GKE in Google Cloud

## How to setup infrastructure and run the code
1. Create project on GKE (or use existing)
2. Make sure Kubernetes Engine API is enabled in the project
3. Create service account and generate JSON key, which should be placed into `.secrets/service-account.json` (or in existing project generate new key for service account with name `infrastructure-service-account` which has required permissions).
4. If using new project, create new bucket in Google Storage (with some new unique name). Needed for terraform state.
5. If using new project, update bucket name and project id in `infrastructure/terraform/gke/provider.tf` in `provider` configuration.
6. Run `make create_gke` to create GKE with Terraform. This takes ~5 minutes.
7. Run `. init_env.sh` to make your gcloud client use your service account credentials and generate kubeconfig (for kubectl).
8. Enable Google Container registry in your project.
9. If using new project, in root `Makefile` set the PROJECT_ID to your PROJECT_ID in Google Cloud Platform.
10. Run `make build-and-push-api-image` version=0.0.1. This will build docker image, tag it and and push to our container registry. Make sure that your images in container registry are publicly available.
12. Run `cd infrastructure/k8s && make deploy-api-dev` to deploy app to dev cluster.
13. Find public IP of LoadBalancer by `make get-loadbalancer-ip-dev` (running from `infrastructure/k8s` directory).
14. App should  be accessible on `<LOAD_BALANCER_IP>:50000`


## Service account required roles
I had some problems with IAM not working as expected and this is superset of roles that service account requires:

- Kubernetes/Kubernetes Engine Admin
- Kubernetes/Kubernetes Engine Cluster Admin
- Kubernetes/Kubernetes Engine Service Agent
- IAM/Security Admin
- Storage/Storage Admin
- Storage/Storage Object Viewer
- Service Account/Service Account User

## Few notes
I have used `kustomize` for separating `dev` / `prod` / `stagin` environments. I am aware that in practice it is better to have separate clusters for `prod` and `dev`.
Also, initially I used terraform workpaces, but decided  to drop it as it seemed unnecessary for this project.

## API
I have used and modified small template that I have for quickly building API-s which contain just few endpoints. I am well aware that for API with more functionality, it would require to structure it a bit more (into folders etc...).
