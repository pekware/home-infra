CONTEXT=staging
BRANCH=main

while getopts c:b: name
do
  case $name in
  c) CONTEXT="$OPTARG";;
  b) BRANCH="$OPTARG";;
  ?) printf "Usage: %s: [-c value] [-b value]\n" $0
     exit 2;;
  esac
done

kubectl create -f $HOME/povault/k8s-secrets/$CONTEXT
/usr/local/bin/flux bootstrap github \
  --owner=pekware \
  --repository=home-infra \
  --branch=$BRANCH \
  --path=clusters/$CONTEXT \
  --components "source-controller,kustomize-controller,helm-controller" \
  --private=true \
  --personal=true \
  --token-auth \
  --network-policy=false
