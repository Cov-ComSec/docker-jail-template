FROM ubuntu:20.04 as builder

RUN apt-get update && apt-get install --no-install-recommends -qy libc6-dev gcc && \
    useradd -m ctf

WORKDIR /home/ctf

ARG COMPILE_CHALLENGE
ENV COMPILE=${COMPILE_CHALLENGE}

COPY ./bin/ /home/ctf/
RUN $COMPILE

FROM ubuntu:20.04

RUN apt-get update && apt-get install --no-install-recommends -qy libc6-dev xinetd && \
    useradd -m ctf

WORKDIR /home/ctf

RUN cp -R /usr/lib* /home/ctf

RUN mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/*

RUN mkdir /home/ctf/bin && \
    cp /bin/sh /home/ctf/bin && \
    cp /bin/ls /home/ctf/bin && \
    cp /bin/cat /home/ctf/bin

COPY ./ctf.xinetd /etc/xinetd.d/ctf
COPY ./start.sh /start.sh

RUN echo "Blocked by ctf_xinetd" > /etc/banner_fail && \
    chmod +x /start.sh

EXPOSE 9999

COPY --from=builder /home/ctf/ /home/ctf/

RUN chmod +x challenge && \
    chown -R root:ctf /home/ctf && \
    chmod -R 750 /home/ctf && \
    chmod 740 /home/ctf/flag

CMD ["/start.sh"]
