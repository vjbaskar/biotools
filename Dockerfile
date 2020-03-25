FROM ubuntu:18.04
RUN apt-get update && apt-get -y install make build-essential zlib1g-dev ncurses-dev libbz2-dev liblzma-dev default-jre wget
COPY ./picard.jar picard.jar
COPY ./samtools-1.9.tar.bz2 samtools-1.9.tar.bz2
RUN tar xjvf samtools-1.9.tar.bz2
WORKDIR samtools-1.9
RUN make -j 4
RUN make install
WORKDIR /

COPY ./bwa-0.7.17.tar.bz2 bwa-0.7.17.tar.bz2
RUN tar xjvf bwa-0.7.17.tar.bz2
WORKDIR bwa-0.7.17
RUN make -j 4  
RUN cp bwa /usr/local/bin/
WORKDIR /
ENV PATH="/usr/local/bin/:${PATH}"
#WORKDIR /run
#ENTRYPOINT ["samtools"]
