#!/bin/bash

set -e

tags=()
source=$1
target=$2
cloudfront=$3
export commit=$GITHUB_SHA
export branch=${GITHUB_REF##*/}

echo [Debug] Push files to AWS S3 $target
(set -x; aws s3 sync $source $target --delete)

echo [Debug] Regenerate $cloudfront
echo SECRET AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY_ID
echo SECRET AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY
(set -x; aws cloudfront create-invalidation --distribution-id $cloudfront --paths '/*')

echo '[Info] Done.'
