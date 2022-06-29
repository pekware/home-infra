.DEFAULT_GOAL := apps

.PHONY: apps

apps:
	flux reconcile kustomization apps
