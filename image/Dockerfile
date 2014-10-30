FROM phusion/baseimage:0.9.15
MAINTAINER Infrastructory Main Engineering <main.engineering@infrastructory.com>

ENV HOME /root
RUN mkdir /build
ADD . /build

RUN /build/build_script/prepare.sh && \
	/build/build_script/system_services.sh && \
	/build/build_script/utilities.sh && \
	/build/build_script/cleanup.sh

CMD ["/sbin/my_init"]
