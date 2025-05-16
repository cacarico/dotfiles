# install: link link-x package_install ## Creates links and install packages
install: bootstrap

bootstrap: ## Starts Bootstrap
	@scripts/bootstrap.sh

link: ## Create symlinks
	@scripts/bootstrap.d/links.sh create_links

link-x: ## Create symlinks
	@scripts/bootstrap.d/links.sh link_x

asdf: ## Install asdf packages
	@scripts/bootstrap.d/packages/asdf.sh

dnf: ## Install dnf packages
	@scripts/bootstrap.d/packages/dnf.sh

pacman: ## Install asdf packages
	@scripts/bootstrap.d/pacman-install.sh

unlink: ## Delete symlinks
	@scripts/bootstrap.sh remove_links

.PHONY: help install link link-x package_install unlink

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
