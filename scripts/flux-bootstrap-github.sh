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

kubectl create -f $HOME/povault/sealed-secrets/$CONTEXT
flux bootstrap github \
  --owner=kingphil \
  --repository=home-infra \
  --branch=$BRANCH \
  --path=clusters/$CONTEXT \
  --private=true \
  --personal=true \
  --token-auth \
  --network-policy=false
