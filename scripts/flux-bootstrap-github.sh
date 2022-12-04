CONTEXT=${1:-staging}
kubectl create -f $HOME/_scratch/_flux_bootstrap/$CONTEXT
flux bootstrap github \
  --owner=kingphil \
  --repository=home-infra \
  --branch=main \
  --path=clusters/$CONTEXT \
  --private=true \
  --personal=true \
  --token-auth \
  --network-policy=false
