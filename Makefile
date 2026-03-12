.DEFAULT_GOAL := help

export PATH
PATH := $(PROJECT_DIR)/tools/bin:$(PATH)

include includes.mk
