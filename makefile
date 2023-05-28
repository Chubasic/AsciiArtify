APP_NAME=$(shell basename $(shell git remote get-url origin) | tr 'A-Z' 'a-z')
# Registry name
REGISTRY=chubasic
# Get git tag and current commit hash as registry tag name
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)


build-local:
	cargo install --path $$PWD/ --tag ${VERSION}

build:
	cargo install --path .

image: 
	docker build . -t ${REGISTRY}/${APP_NAME}:${VERSION}

push:
	docker push ${REGISTRY}/${APP_NAME}:${VERSION}

clean-local:
	rm -rf target

clean:
	docker rmi ${REGISTRY}/${APP_NAME}:${VERSION}
