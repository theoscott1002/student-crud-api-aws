# Makefile for Student API

# Variables
IMAGE_NAME = student-api-aws
IMAGE_VERSION = latest
DOCKER_USER = $(DOCKER_USERNAME)

.PHONY: build test lint docker-build docker-push

# Build API
build:
	@echo Building API...
	python -m py_compile $(shell powershell -Command "Get-ChildItem -Recurse -Filter *.py | ForEach-Object { $$_.FullName }")

# Run tests
test:
	@echo Running tests...
	pytest tests/

# Lint code
lint:
	@echo Running lint...
	flake8 .

# Build Docker image
.PHONY: docker-build
docker-build:
	@echo "Building Docker image..."
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

# Push Docker image to DockerHub
.PHONY: docker-push
docker-push:
	@echo "Pushing Docker image..."
ifndef DOCKER_USERNAME
	$(error DOCKER_USERNAME is not set)
endif
	docker push $(DOCKER_USER)/$(IMAGE_NAME):$(IMAGE_VERSION)
