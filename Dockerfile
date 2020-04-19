FROM ubuntu:18.04

# VARS
ENV deeptools_pref="deeptools-3.4.1"


RUN apt-get update && apt-get -y install make build-essential zlib1g-dev ncurses-dev libbz2-dev liblzma-dev default-jre wget
# Picard
COPY ./picard.jar picard.jar
# Samtools
COPY ./samtools-1.9.tar.bz2 samtools-1.9.tar.bz2
RUN tar xjvf samtools-1.9.tar.bz2
WORKDIR samtools-1.9
RUN make -j 4
RUN make install
WORKDIR /

# BWA
COPY ./bwa-0.7.17.tar.bz2 bwa-0.7.17.tar.bz2
RUN tar xjvf bwa-0.7.17.tar.bz2
WORKDIR bwa-0.7.17
RUN make -j 4  
RUN cp bwa /usr/local/bin/
WORKDIR /
ENV PATH="/usr/local/bin/:${PATH}"
#WORKDIR /run
#ENTRYPOINT ["samtools"]

# DEEPTOOLS
RUN apt install -y python3-pip
WORKDIR /soft
COPY ./${deeptools_pref}.tar.gz ${deeptools_pref}.tar.gz
RUN pip3 install cython
RUN pip3 install ./${deeptools_pref}.tar.gz

# Bedtools2
COPY ./bedtools.static.binary /usr/local/bin/bedtools
RUN chmod 755 /usr/local/bin/bedtools
