
## Prerequisites
- `make` - contains useful command for working with the project (building images / applying terraform configuration)
- `gcloud` - google cloud SDK - communication with google cloud platform
- `docker` - for building docker images
- `kubectl` - for working with kubernetes

## How to setup infrastructure and run the code
1. Create project on GKE (or use existing)
2. Make sure Kubernetes Engine API is enabled in the project
3. Create service account and generate JSON key, which should be placed into `.secrets/service-account.json` (or in existing project generate new key for service account which has required permissions)
4. Run `make create_gke` to create GKE with Terraform. This takes ~5 minutes.
5. Run `. init_env.sh` to make your gcloud client use your service account credentials.
6. Enable Google Container registry in your project.
7. In root `Makefile` set the PROJECT_ID to your PROJECT_ID in Google Cloud Platform.
8. Run `make build-and-push-api-image`. This will build docker image, tag it and and push to our container registry.
9.  Run `cd infrastructure/k8s && make deploy-api-dev` to deploy app to dev cluster.
10. Find public IP of LoadBalancer by `make get-loadbalancer-ip-dev` (running from `infrastructure/k8s` directory).
11. App should  be accessible on `<LOAD_BALANCER_IP>:50000`


## Service account required roles
I had some problems with IAM not working as expected and this is superset of roles that service account requires:

- Kubernetes/Kubernetes Engine Admin
- Kubernetes/Kubernetes Engine Cluster Admin
- Kubernetes/Kubernetes Engine Service Agent
- IAM/Security Admin
- Storage/Storage Admin
- Storage/Storage Object Viewer
