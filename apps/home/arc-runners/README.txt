Because the private key is multi-line, and also I prefer not to have
secrets buried in my .bash_history, I created the secret via
"--from-file" on a directory of appropriately named files.

Ensure the ID secrets do not have a newline. Using their example:
https://github.com/actions/actions-runner-controller/blob/master/charts/gha-runner-scale-set/values.yaml

echo -n 123456 > .reference/secrets/github_app_id
echo -n 654321 > .reference/secrets/github_app_installation_id
