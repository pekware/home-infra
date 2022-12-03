CONTEXT=${1:-staging}
flux bootstrap github \
  --owner=kingphil \
  --repository=home-infra \
  --branch=main \
  --path=clusters/$CONTEXT \
  --private=true \
  --personal=true \
  --token-auth \
  --network-policy=false
