# Makefile

.PHONY: build test lint docker-build docker-push

# Build the API
build:
	@echo "Building API..."
	@python3 -m py_compile $(shell find . -name "*.py")

# Run tests
test:
	@echo "Running tests..."
	@pytest tests/

# Lint code
lint:
	@echo "Running lint..."
	@flake8 .

# Build Docker image
docker-build:
	@echo "Building Docker image..."
	docker build -t student-api .

# Push Docker image
docker-push:
	@echo "Pushing Docker image to DockerHub..."
	docker push $(DOCKERHUB_USERNAME)/student-api:latest
