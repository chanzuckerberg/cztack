run:
	go run .
	$(MAKE) -C ../.. docs
.PHONY: run

update-deps:
	go get -u ./...
	go mod tidy
.PHONY: update-deps
