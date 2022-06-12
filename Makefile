.PHONY: all challenge

NAME=example
VERSION=latest
EXTERNAL_PORT=1337
BUILD_VARS=COMPILE_CHALLENGE="gcc challenge.c -o challenge"

challenge:
	cp challenge.c ./bin/challenge.c
	cp flag.txt ./bin/flag
	docker build --build-arg $(BUILD_VARS) -t $(NAME):$(VERSION) .
	docker run --rm -d --name $(NAME) -p "0.0.0.0:$(EXTERNAL_PORT):9999" $(NAME):$(VERSION)
