FROM ubuntu:focal
#Set Args for ENVs
ARG CHAIN_DATA="true"
ARG ARCH="x86_64"
# Set an environment variable for the volume path and Epic Node Arch
ENV CHAIN_DATA=${CHAIN_DATA}
ENV ARCH=${ARCH}
# Create the specified directory
RUN mkdir -p /root/.epic/main/chain_data

#Update and install dependencies
RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y unzip \
    && apt-get install -y libncurses5 libncursesw5 zlib1g openssl screen

#Install librandomx library
RUN wget https://d1ftoepmu0es39.cloudfront.net/librandomx_1.0.0-3_amd64.deb \
    && dpkg -i librandomx_1.0.0-3_amd64.deb

#Copy Epic Node file
RUN mkdir /root/epic-server
ADD epic-node-${ARCH} /root/epic-server/epic
RUN chmod +x /root/epic-server/epic

#Download and Copy chain_data if voume not mounted
RUN if [ ${CHAIN_DATA} = "false" ]; then cd /root/epic-server \
    && wget https://epiccash.s3.sa-east-1.amazonaws.com/mainnet.zip \
    && unzip mainnet.zip \
    && rm mainnet.zip \
    && mv -f chain_data /root/.epic/main/ ; fi

#Copy foundation.json and epic-server.toml file
ADD foundation.json /root/.epic/main/foundation.json
ADD epic-server.toml /root/.epic/main/epic-server.toml

#Add docker entrypoint
ADD docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh

#Add Epic to executable path
RUN ln -s /root/epic-server/epic /usr/bin/epic

#Link epic node log to docker container log
RUN ln -sf /dev/stdout /root/.epic/main/epic-server.log

#Entrypoint
ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
