SHELL := /bin/bash
MODULES=$(filter-out bin/ vendor/ module-template/ scripts/ testutil/,$(sort $(dir $(wildcard */))))
TEST :=./...
export PRIVATE_SUBNETS :=subnet-0e74698925a68c650,subnet-0f6ea862112b067c8
export VPC_ID :=vpc-0442f170b88f8eaf6
export VPC_CIDR_BLOCK :=10.72.0.0/16
export DATABASE_SUBNET_GROUP :=shared-infra-cztack-ci
export ROUTE53_ZONE_NAME := ci.cztack.com
export ROUTE53_ZONE_ID := Z2W9YC1AAOXX6B
export WILDCARD_CERT_ARN := arn:aws:acm:us-west-2:119435350371:certificate/b13e8e24-6436-488d-990d-2cedee3e36dd
export CLOUDFRONT_WILDCARD_CERT_ARN := arn:aws:acm:us-east-1:119435350371:certificate/99f1fb68-4469-4280-b452-7193c8c787ca
export ACCOUNT_ID := 119435350371
export AWS_PROFILE=cztack-ci-1
export AWS_SDK_LOAD_CONFIG=true
export GO111MODULE=on

all: clean fmt docs lint test

setup: ## setup development dependencies
	curl -L https://raw.githubusercontent.com/chanzuckerberg/bff/master/download.sh | sh
.PHONY: setup

release: ## run a release
	./bin/bff bump
	git push
	git push --tags
	@echo "Go to github.com/chanzuckerberg/cztack/ and make the tag into a release (not automated yet)."
.PHONY: release

fmt:
	@for m in $(MODULES); do \
		terraform fmt $$m; \
	done
.PHONY: fmt

lint:
	@for m in $(MODULES); do \
		terraform fmt -check $$m || exit $$?; \
	done;

	@for m in $(MODULES); do \
		ls $$m/*_test.go 2>/dev/null 1>/dev/null || (echo "no test(s) for $$m"; exit $$?); \
	done
.PHONY: lint

docs:
	@for m in $(MODULES); do \
		pushd $$m; \
		../scripts/update-readme.sh update; \
		popd; \
	done;
.PHONY: docs

check-docs:
	@for m in $(MODULES); do \
		pushd $$m; \
		../scripts/update-readme.sh check || exit $$?; \
		popd; \
	done;
.PHONY: check-docs

check-mod:
	go mod tidy
	git diff --exit-code -- go.mod go.sum
.PHONY: check-mod

clean:
	rm **/*.tfstate*; true
	rm -r **/.terraform; true
.PHONY: clean

test:
	go test -count=1 -v -parallel 10 -test.timeout 45m $(TEST)
.PHONY: test

test-ci:
	go test -count=1 -parallel 10 -test.timeout 45m $(TEST)
.PHONY: test

deps:
	go mod tidy
.PHONY: deps
