flux bootstrap gitlab \
  --hostname=gitlab.pekware.xyz \
  --ssh-hostname=gitlab.pekware.xyz \
  --owner=maestro \
  --repository=home-infra \
  --branch=main \
  --path=clusters/k3s-home \
  --token-auth \
  --network-policy=false
