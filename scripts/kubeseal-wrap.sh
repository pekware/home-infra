#!/bin/sh
CONTEXT=${1:-staging}
FULLNAME=$2
DIR=$(dirname $FULLNAME)
BASE=$(basename $FULLNAME)
kubeseal --format=yaml --cert=misc/$CONTEXT/pub-sealed-secrets.pem < $DIR/$BASE > $DIR/sealed.$BASE
