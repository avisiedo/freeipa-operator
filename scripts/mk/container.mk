ifneq (,$(shell which podman 2>/dev/null))
CONTAINER_ENGINE ?= podman
else
ifneq (,$(shell which docker 2>/dev/null))
CONTAINER_ENGINE ?= docker
else
CONTAINER_ENGINE ?= false
endif
endif

.PHONY: container-build
container-build:  ## Build container image $(IMG)
	$(CONTAINER_ENGINE) build -t "$(IMG)" .

.PHONY: container-push
container-push:  ## Push container image $(IMG)
	$(CONTAINER_ENGINE) push "$(IMG)"

