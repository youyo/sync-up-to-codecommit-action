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
git branch -a | sed -n "/\/HEAD /d; /\/master$/d; /remotes/p;" | xargs -L1 git checkout -t
git remote add sync ${CodeCommitUrl}
git push sync --mirror
