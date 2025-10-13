# Variables
IMAGE_NAME = student-crud-api
VERSION = 1.0.0
CONTAINER_NAME = student-api

# Build docker image
build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

# Run docker container
run:
	docker run -d -p 5000:5000 --env-file .env --name $(CONTAINER_NAME) $(IMAGE_NAME):$(VERSION)

# Stop container
stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

# View logs
logs:
	docker logs -f $(CONTAINER_NAME)

# Clean up dangling images
clean:
	docker system prune -f

