CONTEXT=${1:-staging}
flux bootstrap gitlab \
  --hostname=gitlab.pekware.xyz \
  --ssh-hostname=gitlab.pekware.xyz \
  --owner=maestro \
  --repository=home-infra \
  --branch=main \
  --path=clusters/$CONTEXT \
  --token-auth \
  --network-policy=false
