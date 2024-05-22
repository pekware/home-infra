.DEFAULT_GOAL := apps

.PHONY: source
source:
	flux reconcile source git flux-system

.PHONY: infrastructure
infrastructure:
	flux reconcile kustomization infrastructure --with-source

.PHONY: apps
apps:
	flux reconcile kustomization apps --with-source

.PHONY: suspend
suspend:
	flux suspend source git flux-system

.PHONY: resume
resume:
	flux resume source git flux-system

.PHONY: k3d-cluster-create
k3d-cluster-create:
	KUBECONFIG=$$HOME/.kube/k3d k3d cluster create lab --config misc/development/k3d/k3d.yaml
	kubectl --kubeconfig $$HOME/.kube/k3d create -f ./misc/development/k3d/calico.yaml

.PHONY: k3d-cluster-create-by-version
k3d-cluster-create-by-version:
	# https://hub.docker.com/r/rancher/k3s/tags
	KUBECONFIG=$$HOME/.kube/k3d k3d cluster create lab --config misc/development/k3d/k3d.yaml --image=rancher/k3s:${K8S_VERSION}

.PHONY: k3d-cluster-delete
k3d-cluster-delete:
	KUBECONFIG=$$HOME/.kube/k3d k3d cluster delete lab
	rm -f $$HOME/.kube/k3d

.PHONY: kind-create-cluster
kind-create-cluster:
	kind create cluster --name lab --kubeconfig $$HOME/.kube/kind --config misc/development/kind/kind.yaml
	#kubectl --kubeconfig $$HOME/.kube/kind create -f ./misc/development/kind/calico.yaml

.PHONY: kind-create-cluster-by-version
kind-create-cluster-by-version:
	# https://hub.docker.com/r/kindest/node/tags
	kind create cluster --name lab --kubeconfig $$HOME/.kube/kind --config misc/development/kind/kind.yaml --image kindest/node:${K8S_VERSION}

.PHONY: kind-delete-cluster
kind-delete-cluster:
	KUBECONFIG=$$HOME/.kube/kind kind delete cluster --name lab
	rm -f $$HOME/.kube/kind
