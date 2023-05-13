# Golang version
.DEFAULT_GOAL := build
GO := go
OUTPUT := main
INFRA := infrastructure

ci: build tests-unit

.PHONY: fmt
fmt:
	${GO} fmt ./...

vet: fmt
	${GO} vet ./...
.PHONY: vet

build: vet
	GOOS=linux GOARCH=amd64 ${GO} build -o ${OUTPUT} cmd/main.go
.PHONY: build

.PHONY: build-docker
build-docker:
	GOOS=linux ${GO} build -o ${OUTPUT} cmd/main.go
	docker build -t lambda ./build

.PHONY: clean
clean:
	rm ${OUTPUT};rm ${INFRA}/${OUTPUT}.zip;

.PHONY: tidy
tidy:
	go mod tidy

.PHONY: destroy
destroy: 
	cd ${INFRA}; \
	terraform destroy -auto-approve

.PHONY: apply
apply: ci
	cd ${INFRA}; \
	terraform apply -auto-approve

.PHONY: validate
validate:
	cd ${INFRA}; \
	terraform fmt; terraform validate

tests-unit:
	@go test -v -tags=unit -bench=. -benchmem -cover ./...
