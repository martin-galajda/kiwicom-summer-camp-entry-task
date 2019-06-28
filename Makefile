SHELL := sh

PATH_TO_SERVICE_ACCOUNT_FILE := `pwd`/.secrets/service-account.json

PROJECT_ID := kiwicom-summer-camp-entry-task
IMAGE_NAME := kiwicomsummercamp-entry-task-api
IMAGE_REGION := eu.gcr.io
GCR_IMAGE_URL := $(IMAGE_REGION)/$(PROJECT_ID)/$(IMAGE_NAME)

version ?= latest

init_prod_gke_cluster_credentials:
	gcloud container clusters get-credentials kiwicomsummercamp-cluster-default --zone europe-west2-b

plan_gke: .secrets/service-account.json
	export GOOGLE_APPLICATION_CREDENTIALS=$(PATH_TO_SERVICE_ACCOUNT_FILE) && \
	cd infrastructure/terraform/gke && \
	terraform plan

destroy_gke: .secrets/service-account.json
	export GOOGLE_APPLICATION_CREDENTIALS=$(PATH_TO_SERVICE_ACCOUNT_FILE) && \
	cd infrastructure/terraform/gke && \
	terraform destroy

create_gke: .secrets/service-account.json
	export GOOGLE_APPLICATION_CREDENTIALS=$(PATH_TO_SERVICE_ACCOUNT_FILE) && \
	cd infrastructure/terraform/gke && \
	terraform workspace create prod && \
	terraform init && \
	terraform apply

build_api_image:
	docker build ./src -t $(IMAGE_NAME)

tag_and_push_api_image:
	gcloud auth configure-docker && \
	docker tag $(IMAGE_NAME):latest $(GCR_IMAGE_URL):$(version) && \
	docker push $(GCR_IMAGE_URL):$(version)

build-and-push-api-image:
	@make build_api_image && \
	make tag_and_push_api_image version=$(version)
