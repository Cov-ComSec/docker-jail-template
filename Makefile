.PHONY: all challenge

NAME=example
VERSION=latest
EXTERNAL_PORT=1337
BUILD_VARS="gcc challenge.c -no-pie -fno-stack-protector -o challenge"

challenge:
	cp challenge.c ./bin/challenge.c
	cp flag.txt ./bin/flag
	docker build --build-arg COMPILE_CHALLENGE=$(BUILD_VARS) -t $(NAME):$(VERSION) .
docker: challenge
	docker run --rm -d --name $(NAME) -p "0.0.0.0:$(EXTERNAL_PORT):9999" $(NAME):$(VERSION)
binary: docker
	docker cp $(NAME):/home/ctf/challenge .
	docker kill $(NAME)
