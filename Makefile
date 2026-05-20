TAG ?= $(shell git describe --tags --abbrev=0 2>/dev/null || echo 0.0.0)
EXACT_TAG := $(shell git describe --tags --exact-match HEAD 2>/dev/null)
COMMIT := $(shell git rev-parse --short HEAD 2>/dev/null)
ifdef EXACT_TAG
  VERSION ?= $(TAG)
else
  VERSION ?= $(TAG)+$(COMMIT)
endif

.PHONY: build clean test check cache

build:
	go build -ldflags "-X main.version=$(VERSION)" -o revmap .

clean:
	rm -f revmap
	rm -rf cache/

test:
	go test -race ./...

check:
	./checks.sh

cache:
	go run ./cmd/cache-build
