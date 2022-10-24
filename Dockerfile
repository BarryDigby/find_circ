FROM ubuntu:18.04
LABEL authors="Barry Digby" \
    description="Docker image containing all software requirements for the nf-core/circrna pipeline"

# install main packages:
RUN apt-get update; apt-get clean all;

RUN apt-get install --yes build-essential \
                        software-properties-common \
                        gcc-multilib \
                        apt-utils \
                        zip \
                        wget \
                        unzip \
                        expat \
                        libexpat-dev \
                        libtbb-dev \
                        zlib1g-dev \
                        bowtie2 \
                        libbz2-dev \
                        liblzma-dev \
                        gcc \
                        cmake \
                        libbamtools-dev \
                        libboost-dev \
                        libboost-iostreams-dev \
                        libboost-log-dev \
                        libboost-system-dev \
                        libboost-test-dev \
                        libcurl4-openssl-dev \
                        libssl-dev \
                        libz-dev 
                        
                        
                        
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install python2.7

# Add 2.7 to the available alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

# Set python2.7 as the default python
RUN update-alternatives --set python /usr/bin/python2.7

# put /usr/bin at fron of path
ENV PATH=/usr/bin:$PATH

RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && python2.7 get-pip.py

RUN pip install pysam numpy

#find_circ
WORKDIR /usr/src/app
RUN wget --no-check-certificate http://www.circbase.org/download/find_circ.tar.gz
RUN tar -xvf find_circ.tar.gz
RUN cp *.py /usr/bin
