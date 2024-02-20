#!/bin/sh

set -ue

RepositoryName="${INPUT_REPOSITORY_NAME}"
AwsRegion="${INPUT_AWS_REGION}"

AwsDomain="amazonaws.com"
if [[ $AwsRegion == "cn-north-1" || $AwsRegion == "cn-northwest-1" ]]; then
  AwsDomain="amazonaws.com.cn"
fi

CodeCommitUrl="https://git-codecommit.${AwsRegion}.${AwsDomain}/v1/repos/${RepositoryName}"

git config --global --add safe.directory /github/workspace
git config --global credential."https://git-codecommit.${AwsRegion}.${AwsDomain}".helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git remote add sync ${CodeCommitUrl}
git fetch --all
git push sync --mirror
