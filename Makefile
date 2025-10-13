# Makefile

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

