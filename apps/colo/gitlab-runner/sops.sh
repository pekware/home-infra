export KEY_FP=2BBD3786044CFFE0260484332213C1FB5FFCB338

sops --encrypt \
--pgp=$KEY_FP \
--encrypted-regex '^runnerRegistrationToken$' \
release.plain.yaml > release.yaml
