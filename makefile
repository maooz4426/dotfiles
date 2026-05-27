.PHONY: submodule-init submodule-update

submodule-init:
	git submodule update --init --recursive

submodule-update:
	git submodule update --remote --merge
