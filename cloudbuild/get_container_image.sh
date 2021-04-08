#!/bin/bash

gcloud container images list-tags eu.gcr.io/gae-runtimes/buildpacks/php74/builder

TAGDATE=0

while read tag; do
  if [[ $tag -gt $TAGDATE ]]; then
    TAGDATE=$tag
  fi
done<tagfilter.txt

echo "Latest date found for builder: $TAGDATE"

PHPBUILDER=$(gcloud container images list-tags eu.gcr.io/gae-runtimes/buildpacks/php74/builder --filter php74_$TAGDATE | awk '{​​​​​​​​​​​​​​print $2}​​​​​​​​​​​​​​')

echo "Being built with builder image tag $PHPBUILDER"

rm tagfilter.txt

echo -n $PHPBUILDER>/workspace/phpbuilder
