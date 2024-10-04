kubectl create secret generic pre-defined-secret --namespace=arc-runners --from-file=.reference/secrets/ --dry-run=client --output=yaml | tee .reference/secret.yaml
