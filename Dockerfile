FROM python:2.7
LABEL authors="Barry Digby" \
    description="Docker image containing all software requirements for the nf-core/circrna pipeline"

# install main packages:
RUN apt-get update; apt-get clean all;

RUN apt-get install --yes build-essential \
                        software-properties-common \
                        gcc-multilib \
                        apt-utils \
                        zip \
                        unzip \
                        expat \
                        libexpat-dev \
                        libtbb-dev \
                        bowtie2

#find_circ
WORKDIR /usr/src/app
RUN wget --no-check-certificate http://www.circbase.org/download/find_circ.tar.gz
RUN tar -xvf find_circ.tar.gz
RUN cp *.py /usr/bin
