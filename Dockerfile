FROM  ubuntu:22.04 as builder

USER  root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -yq update
RUN apt-get install -yq --no-install-recommends locales
RUN apt-get -y install wget
RUN apt-get -y install samtools
RUN apt-get -y install default-jre

RUN mkdir /usr/local/share/picard-2.27.5
RUN ln -s /usr/bin/java /usr/local/bin/java
RUN wget -P /usr/local/share/picard-2.27.5 https://github.com/broadinstitute/picard/releases/download/2.27.5/picard.jar
COPY picard /usr/local/share/picard-2.27.5
RUN ln -s /usr/local/share/picard-2.27.5/picard /usr/local/bin/picard

## USER CONFIGURATION
RUN adduser --disabled-password --gecos '' ubuntu && chsh -s /bin/bash && mkdir -p /home/ubuntu

USER    ubuntu
WORKDIR /home/ubuntu

CMD ["/bin/bash"]
