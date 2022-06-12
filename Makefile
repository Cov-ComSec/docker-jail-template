NAME=example
VERSION=latest
EXTERNAL_PORT=1337

challenge:
	cp challenge.c ./bin/challenge.c
	cp flag.txt ./bin/flag
	docker build -t $(NAME):$(VERSION) .
	docker run --rm -it --name $(NAME) -p "0.0.0.0:$(EXTERNAL_PORT):9999" $(NAME):$(VERSION)
