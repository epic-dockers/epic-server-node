FROM ubuntu:focal

#Update and install dependencies
RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y unzip \
    && apt-get install -y libncurses5 libncursesw5 zlib1g openssl screen

#Install librandomx library
RUN wget https://d1ftoepmu0es39.cloudfront.net/librandomx_1.0.0-3_amd64.deb \
    && dpkg -i librandomx_1.0.0-3_amd64.deb

#Install epic-node
RUN cd /root \
    && wget https://dl.epic.tech/epiccash_E3_node-server_ubuntu.zip \
    && unzip epiccash_E3_node-server_ubuntu.zip \
    && mv epiccash_E3_node-server_ubuntu epic-server \
    && chmod +x /root/epic-server/epic

#Create DB root directories
RUN mkdir -p /root/.epic/main

#Copy chain_data
RUN cd /root/epic-server \
    && wget https://epiccash.s3.sa-east-1.amazonaws.com/mainnet.zip \
    && unzip mainnet.zip \
    && rm mainnet.zip \
    && mv chain_data /root/.epic/main/

#Copy foundation.json and epic-server.toml file
RUN cp /root/epic-server/foundation.json /root/.epic/main/foundation.json
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
