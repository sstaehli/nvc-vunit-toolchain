REGISTRY?=gitlab-registry.airhead.ch

.PHONY: all
all: create_image push_image
	docker system prune

.PHONY: create_image
create_image:
	docker build \
	--file ./Dockerfile \
	--tag build/nvc-vunit:latest \
	--no-cache .

.PHONY: push_image
push_image:
	@IMAGE_ID=$$(docker images --quiet build/nvc-vunit:latest); \
	echo "Pushing image with image ID: $$IMAGE_ID"
	docker tag  build/nvc-vunit:latest $(REGISTRY)/containers/toolchains/nvc-vunit:latest
	docker login $(REGISTRY)
	docker push $(REGISTRY)/containers/toolchains/nvc-vunit:latest
	docker rmi  build/nvc-vunit:latest