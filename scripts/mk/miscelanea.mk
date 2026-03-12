##@ Miscelanea

# https://www.cmcrossroads.com/article/dumping-every-makefile-variable
.PHONY: printvars
printvars: ## Print variable name and values
	@$(foreach V, $(sort $(.VARIABLES)),$(if $(filter-out environment% default automatic,$(origin $V)),$(info $V=$(value $V))))

$(PROJECT_DIR)/bin:
	[ -e bin ] || mkdir bin

.PHONY: lint
lint:  ## Run linters
	./devel/lint.sh *.go $(shell find controllers -name '*.go') $(shell find api -name '*.go')

.PHONY: tidy
tidy:  ## Update golang dependencies
	go mod tidy
	cd tools && go mod tidy

.PHONY: vendor
vendor:  ## Update vendor directory
	go mod vendor

.PHONY: .venv
.venv:
	python3 -m venv .venv
	source .venv/bin/activate; pip install --upgrade pip
	source .venv/bin/activate; pip install -r requirements-dev.txt
