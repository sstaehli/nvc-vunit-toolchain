REGISTRY?=gitlab-registry.airhead.ch
TAG:=2026.1

.PHONY: all
all: create_image push_image
	docker system prune

.PHONY: create_image
create_image:
	docker build \
	--file ./Dockerfile \
	--tag build/nvc-vunit:$(TAG) \
	--no-cache .
	docker tag build/nvc-vunit:$(TAG) build/nvc-vunit:latest

.PHONY: push_image
push_image:
	@IMAGE_ID=$$(docker images --quiet build/nvc-vunit:latest); \
	echo "Pushing image with image ID: $$IMAGE_ID"
	docker tag  build/nvc-vunit:$(TAG) $(REGISTRY)/containers/toolchains/nvc-vunit:$(TAG)
	docker tag  build/nvc-vunit:$(TAG) $(REGISTRY)/containers/toolchains/nvc-vunit:latest
	docker login $(REGISTRY)
	docker push $(REGISTRY)/containers/toolchains/nvc-vunit:$(TAG)
	docker push $(REGISTRY)/containers/toolchains/nvc-vunit:latest

.PHONY: clean
clean:
	docker rmi  build/nvc-vunit:$(TAG)
	docker rmi  build/nvc-vunit:latest
	docker rmi $(REGISTRY)/containers/toolchains/nvc-vunit:$(TAG)
	docker rmi $(REGISTRY)/containers/toolchains/nvc-vunit:latest