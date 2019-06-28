gcloud auth activate-service-account --key-file=.secrets/service-account.json
gcloud config set project kiwicom-summer-camp-entry-task
gcloud container clusters get-credentials kiwicomsummercamp-cluster-default --zone europe-west2-b
