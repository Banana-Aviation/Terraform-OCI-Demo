#!/usr/bin/env bash

set -ex
cd /actions-runner
curl -o actions-runner-linux-x64-2.329.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.329.0/actions-runner-linux-x64-2.329.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.329.0.tar.gz
TOKEN=$(curl -s -X POST -H "Authorization: token ${gh_pat}" https://api.github.com/repos/Banana-Aviation/DemoProject/actions/runners/registration-token | jq -r .token)
./config.sh --url https://github.com/Banana-Aviation/DemoProject --token "$TOKEN" --unattended --replace
rm actions-runner-linux-x64-2.321.0.tar.gz
