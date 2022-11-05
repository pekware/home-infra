.DEFAULT_GOAL := apps

.PHONY: source
source:
	flux reconcile source git flux-system

.PHONY: apps
apps: source
	flux reconcile kustomization apps

.PHONY: suspend
suspend:
	flux suspend source git flux-system

.PHONY: resume
resume:
	flux resume source git flux-system
