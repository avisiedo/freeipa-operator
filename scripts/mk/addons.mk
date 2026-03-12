# Default goal
.DEFAULT_GOAL := help

# This allow to run locally the controller without webhooks by default
# which let you debug the code directly. A more complex configuration
# is needed to debug with webhooks.
ENABLE_WEBHOOKS ?= false
export ENABLE_WEBHOOKS

# Set the workload image to be used to deploy Freeipa when a new
# IDM custom resource is created. This let you test different
# images locally without deploy into the cluster.
RELATED_IMAGE_FREEIPA ?= quay.io/freeipa/freeipa-openshift-container:latest
export RELATED_IMAGE_FREEIPA

# The namespace to be watched by the controller; by default it is set to
# the current namespace; it is set only if KUBECONFIG is defined
ifneq (,$(KUBECONFIG))
WATCH_NAMESPACE ?= $(shell oc project -q 2>/dev/null)
export WATCH_NAMESPACE
endif

export PATH
PATH:="$(PATH):$(PWD)/tools/bin"

# Include sample rules
include scripts/mk/container.mk
include scripts/mk/scorecard.mk
include scripts/mk/checks.mk
include scripts/mk/samples.mk
include scripts/mk/cert-manager.mk
include scripts/mk/miscelanea.mk
include scripts/mk/deprecated.mk
include scripts/mk/bundle.mk
include scripts/mk/tools.mk
include scripts/mk/tools-2.mk
