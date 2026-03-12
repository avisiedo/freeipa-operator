//go:build tools
// +build tools

package main

import (
	_ "github.com/achiku/planter"
	_ "github.com/golangci/golangci-lint/cmd/golangci-lint"
	_ "github.com/gotesttools/gotestfmt/v2/cmd/gotestfmt"
	_ "github.com/mikefarah/yq/v4"
	_ "github.com/operator-framework/operator-registry/cmd/opm"
	_ "github.com/operator-framework/operator-sdk/cmd/operator-sdk"
	_ "github.com/t-yuki/gocover-cobertura"
	_ "github.com/vektra/mockery/v3"
	_ "sigs.k8s.io/controller-runtime/tools/setup-envtest"
	_ "sigs.k8s.io/controller-tools/cmd/controller-gen"
	_ "sigs.k8s.io/kustomize/kustomize/v5"
)
