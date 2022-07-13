FROM debian:buster-slim as builder
#FROM debian@sha256:5ef46429b495d4dd137f6909719b8dfe3570eda3879a6e6e8be08216a047596d as builder
#FROM ubuntu:14.04.2 as builder
RUN apt-get update && \
    #apt-get install libreadline8 && \
    #apt-get install libpthread && \
    apt-get install libc6 && \
    apt-get install -y curl wget && \
    apt-get install -y make gcc-4.9 libc6-dbg && \
    apt-get install -y netcat && \
    #apt-get install -y g++- && \
    #apt-get install -y inetutils-inetd && \
    rm -rf /var/lib/apt/lists/*
#
WORKDIR /mayhem
COPY atftp-0.7.1 atftp
#
#RUN cd / ; chown nobody.nogroup mayhem ; chmod 777 mayhem
RUN touch atftpd.log ; chown nobody.nogroup atftpd.log ; chmod 777 atftpd.log
#RUN mkdir testing ; chown nobody.nogroup testing ; chmod 777 testing ; cd testing ; echo "happy panda" >> test.file
#RUN cd /tftpboot/ ; touch fuzzing_input ; echo "i am a happy panda bear in tokyo" >> fuzzing_input ; chmod 666 fuzzing_input ; chown nobody.nogroup fuzzing_input
#
#RUN cd atftp; ./configure -build=x86_64 CFLAGS='-std=gnu89' CC='/usr/bin/gcc-4.9'
#RUN cd atftp; make
#RUN cd atftp; su -c 'make install'
#RUN atftpd --daemon --port 56789
#
#
#
#
RUN echo "deb [trusted=yes] http://dk.archive.ubuntu.com/ubuntu/ xenial main" >> /etc/apt/sources.list
RUN echo "deb [trusted=yes] http://dk.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN apt update
RUN apt install -y gcc-4.9
#RUN cd atftp ; make clean ; make distclean
RUN cd atftp ; ./configure CC='/usr/bin/gcc-4.9'
RUN cd atftp ; make
RUN cd atftp ; make install
#RUN cd atftp ; ./configure -build=x86_64 CC='/usr/bin/gcc-4.9/' ; make ; make install
