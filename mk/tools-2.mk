##
# Golang rules to build the binaries, tidy dependencies,
# generate vendor directory, download dependencies and clean
# the generated binaries.
##

GOVERSION := 1.25.0
export GOVERSION

GOSUMDB := sum.golang.org
export GOSUMDB

ifeq (,$(shell ls -1d vendor 2>/dev/null))
MOD_VENDOR :=
else
MOD_VENDOR ?= -mod vendor
endif

# Tools and their dependencies
# Build dependencies
TOOLS_BIN := $(PROJECT_DIR)/tools/bin

GOLANGCI_LINT := $(TOOLS_BIN)/golangci-lint
MOCKERY := $(TOOLS_BIN)/mockery
PLANTER := $(TOOLS_BIN)/planter
YQ := $(TOOLS_BIN)/yq
GOTESTFMT := $(TOOLS_BIN)/gotestfmt
GOCOVER_COBERTURA := $(TOOLS_BIN)/gocover-cobertura
KUSTOMIZE := $(TOOLS_BIN)/kustomize

TOOLS := \
	$(GOLANGCI_LINT) \
	$(MOCKERY) \
	$(PLANTER) \
	$(YQ) \
	$(GOTESTFMT) \
	$(GOCOVER_COBERTURA) \
	$(KUSTOMIZE) \


.PHONY: install-go-tools
install-go-tools: $(TOOLS) ## Install Go tools

.PHONY: install-python-tools
install-python-tools:
	python3 -m venv .venv
	source .venv/bin/activate && python3 -m pip install -U pip
	source .venv/bin/activate && python3 -m pip install -r requirements-dev.txt

.PHONY: install-tools
install-tools: install-go-tools install-python-tools ## Install tools used to build, test and lint

TOOLS_DEPS := tools/go.mod tools/go.sum tools/tools.go tools/bin | $(TOOLS_BIN)

$(TOOLS_BIN):
	mkdir -p $@

$(TOOLS): $(TOOLS_DEPS)

$(TOOLS_BIN)/%: $(TOOLS_DEPS)
	cd tools && GOBIN="$(TOOLS_BIN)" go install $(shell grep $(notdir $@) tools/tools.go | awk '{print $$2}')

.PHONY: tidy-tools
tidy-tools:
	cd tools && go mod tidy -go=$(GOVERSION)

