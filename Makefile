MODULES=$(filter-out module-template/ scripts/,$(sort $(dir $(wildcard */))))

all:
	@echo $(MODULES)

fmt:
	terraform fmt

lint:
	terraform fmt -check

docs:
	@for m in $(MODULES); do \
		pushd $$m; \
		../scripts/update-readme.sh update; \
		popd; \
	done;

check-docs:
	@for m in $(MODULES); do \
		pushd $$m; \
		../scripts/update-readme.sh check || exit $$?; \
		popd; \
	done;