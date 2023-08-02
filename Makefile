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

.PHONY: k3d-cluster-create
k3d-cluster-create:
	KUBECONFIG=$$HOME/.kube/k3d k3d cluster create staging --config misc/k3d.yaml --volume "$$(pwd)/misc/calico.yaml:/var/lib/rancher/k3s/server/manifests/calico.yaml"

.PHONY: k3d-cluster-delete
k3d-cluster-delete:
	KUBECONFIG=$$HOME/.kube/k3d k3d cluster delete staging

.PHONY: kind-create-cluster
kind-create-cluster:
	kind create cluster --kubeconfig $$HOME/.kube/kind --config misc/kind.yaml

.PHONY: kind-delete-cluster
kind-delete-cluster:
	kind delete cluster --name kind --kubeconfig $$HOME/.kube/kind
