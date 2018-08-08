MODULES=$(filter-out vendor/ module-template/ scripts/ testutil/,$(sort $(dir $(wildcard */))))
TEST :=./...

all:
	@echo $(MODULES)

fmt:
	@for m in $(MODULES); do \
		terraform fmt $m; \
	done

lint:
	@for m in $(MODULES); do \
		terraform fmt -check $m; \
	done

docs:
	@for m in $(MODULES); do \
		pushd $$m; \
		../scripts/update-readme.sh update; \
		popd; \
	done;

check-docs:
	@for m in $(MODULES); do \
		echo $$m; \
		cd $$m; \
		../scripts/update-readme.sh check || exit $$?; \
		cd ..; \
	done;

test: fmt
	GOCACHE=off AWS_PROFILE=cztack-ci-1 go test $(TEST)