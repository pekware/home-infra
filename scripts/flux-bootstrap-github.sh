CONTEXT=${1:-staging}
kubectl create -f $HOME/povault/sealed-secrets/$CONTEXT
flux bootstrap github \
  --owner=kingphil \
  --repository=home-infra \
  --branch=main \
  --path=clusters/$CONTEXT \
  --private=true \
  --personal=true \
  --token-auth \
  --network-policy=false
