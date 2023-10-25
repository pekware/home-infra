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
flux bootstrap gitlab \
  --owner=pekware \
  --repository=home-infra \
  --branch=$BRANCH \
  --path=clusters/$CONTEXT \
  --private=true \
  --components-extra=image-reflector-controller,image-automation-controller \
  --read-write-key \
  --token-auth

#  --personal=true #? \
#  --deploy-token-auth
