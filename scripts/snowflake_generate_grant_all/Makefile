run:
	go run .
	$(MAKE) -C ../.. docs
	$(MAKE) -C ../.. fmt
.PHONY: run

update-deps:
	go get -u ./...
	go mod tidy
.PHONY: update-deps
