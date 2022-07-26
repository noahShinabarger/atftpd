#build
FROM debian:buster-slim as builder
RUN apt-get update && \
    apt-get install -y curl wget && \
    apt-get install -y make gcc-4.9 libc6-dbg && \
    apt-get install -y netcat && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /mayhem
COPY atftp-0.7.1 atftp
RUN touch atftpd.log ; chown nobody.nogroup atftpd.log ; chmod 777 atftpd.log
RUN echo "deb [trusted=yes] http://dk.archive.ubuntu.com/ubuntu/ xenial main" >> /etc/apt/sources.list
RUN echo "deb [trusted=yes] http://dk.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN apt update
RUN apt install -y gcc-4.9
RUN cd atftp ; ./configure --enable-debug CC='/usr/bin/gcc-4.9'
RUN cd atftp ; make
RUN cd atftp ; make install

#package
FROM debian:buster-slim
COPY --from=builder /usr/local/bin/atftp /usr/local/bin/atftp
COPY --from=builder /usr/local/sbin/atftpd /usr/local/sbin/atftpd
