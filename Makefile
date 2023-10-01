.DEFAULT_GOAL := apps

.PHONY: source
source:
	flux reconcile source git flux-system

infrastructure: source
	flux reconcile kustomization infrastructure

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
	KUBECONFIG=$$HOME/.kube/k3d k3d cluster create staging --config misc/development/k3d/k3d.yaml --volume "$$(pwd)/misc/calico.yaml:/var/lib/rancher/k3s/server/manifests/calico.yaml"

.PHONY: k3d-cluster-delete
k3d-cluster-delete:
	KUBECONFIG=$$HOME/.kube/k3d k3d cluster delete staging

.PHONY: kind-create-cluster
kind-create-cluster:
	kind create cluster --name development --kubeconfig $$HOME/.kube/kind --config misc/development/kind/kind.yaml
	kubectl --kubeconfig $$HOME/.kube/kind --context kind-development create -f ./misc/development/kind/calico.yaml

.PHONY: kind-delete-cluster
kind-delete-cluster:
	kind delete cluster --name development --kubeconfig $$HOME/.kube/kind
	rm $$HOME/.kube/kind
