NAME = infrastructory/base-ubuntu-14.04
VERSION = 0.0.1

.PHONY: all build test tag_latest release ssh

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm image

test:
	env NAME=$(NAME) VERSION=$(VERSION) ./test/runner.sh

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 CHANGELOG.md | grep -q 'release date'; then echo 'Please note the release date in CHANGELOG.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag infrastructory-base-ubuntu-trusty-$(VERSION) && git push origin infrastructory-base-ubuntu-trusty-$(VERSION)"

ssh:
	chmod 600 image/keys/insecure_key
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $1 }') && \
		if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
		IP=$$(docker inspect $$ID | grep IPAddr | sed 's/.*: "//; s/".*//') && \
		echo "SSH connecting to $$IP" && \
		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i image/insecure_key root@$$IP