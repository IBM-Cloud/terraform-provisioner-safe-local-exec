BINARY_NAME=terraform-provisioner-safe-local-exec
PLUGINS_DIR=~/.terraform.d/plugins
CURRENT_DIR=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
BIN=${CURRENT_DIR}bin

.PHONY: linux-distro
linux-distro:
	mkdir -p ${BIN}/linux

.PHONY: darwin-distro
darwin-distro:
	mkdir -p ${BIN}/darwin

.PHONY: windows-distro
windows-distro:
	mkdir -p ${BIN}/windows

.PHONY: lint
lint:
	@which golint > /dev/null || go get -u golang.org/x/lint/golint
	golint

.PHONY: update-dependencies
update-dependencies:
	go get -v ./...

.PHONY: build-linux
build-linux: linux-distro
	CGO_ENABLED=0 GOOS=linux installsuffix=cgo go build -o ./${BINARY_NAME}
	mv ./${BINARY_NAME} ${BIN}/linux

.PHONY: build-darwin
build-darwin: darwin-distro
	CGO_ENABLED=0 GOOS=darwin installsuffix=cgo go build -o ./${BINARY_NAME}
	mv ./${BINARY_NAME} ${BIN}/darwin

.PHONY: build-windows
build-windows: windows-distro
	CGO_ENABLED=0 GOOS=windows installsuffix=cgo go build -o ./${BINARY_NAME}
	mv ./${BINARY_NAME} ${BIN}/windows

.PHONY: build
build: build-linux build-darwin build-windows

.PHONY: clean
clean:
	rm -rf ${BIN}/windows ${BIN}/darwin ${BIN}/linux
