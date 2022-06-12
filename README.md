# CTF Docker Jail Template

Template file for hosting building Rev/Pwn/Any/Misc single remote binary challenge securely. Currently more suited to organisers self hosting (rather than using managed services) due to the heavy reliance on the Makefile for building. 

## Makefile Arguments

- `NAME`: Name of the challenge. Also used as the image and container name
- `VERSION`: In case you want to tag easily. Defaults to `latest`
- `EXTERNAL_PORT`: The port to be bound to the intrnal port 9999 of the container to the host infrastructure
- `BUILD_VARS`: How gcc should compile the challenge inside the container
