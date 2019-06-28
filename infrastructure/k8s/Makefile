
ns ?= dev

# Ensuring that namespace is created
_namespace:
	kubectl apply -f ./namespaces/$(ns).yaml

# Applying workload in given environment and workspace with kustomize
_apply:
	kubectl apply --namespace=$(ns) -k ./$(workload)/overlays/$(env)

# Removing workload in given environment and workspace with kustomize
_delete:
	kubectl delete --namespace=$(ns) -k ./$(workload)/overlays/$(env)


## Deploying API
_deploy-api:
	@make _namespace ns=$(env) && \
	make _apply workload=api ns=$(ns) env=$(env)

deploy-api-dev:
	@make _deploy-api ns=dev env=dev

deploy-api-prod:
	@make _deploy-api ns=prod env=prod


## Deleting API
_delete-api:
	@make _delete workload=api ns=$(env) env=$(env)

delete-api-dev:
	@make _delete-api ns=dev env=dev

delete-api-prod:
	@make _delete-api ns=prod env=dev


## Listing pods
_ls-pods:
	kubectl get pod --namespace=$(ns)

ls-pods-dev:
	@make _ls-pods ns=dev

ls-pods-prod:
	@make _ls-pods ns=prod

## Listing services
_ls-service:
	kubectl get service --namespace=$(ns)

ls-services-dev:
	@make _ls-service ns=dev

ls-services-prod:
	@make _ls-service ns=prod

## Getting IP of LoadBalancer
_get-loadbalancer-ip:
	kubectl describe service dev-kiwicom-summercamp-entry-task-service --namespace=$(ns) | grep "LoadBalancer Ingress:"

get-loadbalancer-ip-dev:
	@make _get-loadbalancer-ip ns=dev

get-loadbalancer-ip-prod:
	@make _get-loadbalancer-ip ns=prod
