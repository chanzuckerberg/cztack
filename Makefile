SHELL := /bin/bash
MODULES=$(filter-out vendor/ module-template/ scripts/ testutil/,$(sort $(dir $(wildcard */))))
TEST :=./...

all: clean fmt docs test

fmt:
	@for m in $(MODULES); do \
		terraform fmt $m; \
	done

lint:
	@for m in $(MODULES); do \
		terraform fmt -check $$m || exit $$?; \
	done;

	@for m in $(MODULES); do \
		ls $$m/*_test.go 2>/dev/null 1>/dev/null || (echo "no test(s) for $$m"; exit $$?); \
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

clean:
		rm **/*.tfstate*

test: fmt
	GOCACHE=off AWS_PROFILE=cztack-ci-1 go test $(TEST)
