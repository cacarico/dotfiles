install: link link-x package_install ## Creates links and install packages

link: ## Create symlinks
	@scripts/bootstrap.sh create_links

link-x: ## Create symlinks
	@scripts/bootstrap.sh link_x

package_install: ## Install Arch Linux Packages
	@scripts/bootstrap.sh arch_install

unlink: ## Delete symlinks
	@scripts/bootstrap.sh remove_links

.PHONY: help install link link-x package_install unlink

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
