FROM nfcore/base:1.14
LABEL authors="Barry Digby" \
    description="Docker image containing all software requirements for the nf-core/circrna pipeline"

# install main packages:
RUN apt-get update; apt-get clean all;

RUN apt-get install --yes build-essential \
                        gcc-multilib \
                        apt-utils \
                        curl \
                        zip \
                        unzip \
                        expat \
                        libexpat-dev \
                        libtbb-dev

# Install the conda environment
COPY environment.yml /
RUN conda env create --quiet -f /environment.yml && conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /opt/conda/envs/nf-core-circrna-1.0.0/bin:$PATH

# Dump the details of the installed packages to a file for posterity
RUN conda env export --name nf-core-circrna-1.0.0 > nf-core-circrna-1.0.0.yml

#find_circ
WORKDIR /usr/src/app
RUN wget --no-check-certificate http://www.circbase.org/download/find_circ.tar.gz
RUN tar -xvf find_circ.tar.gz
RUN cp *.py /opt/conda/envs/nf-core-circrna-1.0.0/bin
