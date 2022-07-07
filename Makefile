.DEFAULT_GOAL := apps

.PHONY: source
source:
	flux reconcile source git flux-system

.PHONY: apps
apps:
	flux reconcile kustomization apps
