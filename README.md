# sysadminblaze/epic-node

Epic Server docker image.


## What is Epic server?

The epic server is a node in the network that validates, propagates and sometimes produces new blocks (for the latter, you need a miner), which is a basically a collection of processed transactions. Learn about binary installations [Epic Server](https://github.com/EpicCash/epic).

## Usage

### How to use this image

This image contains the whole binaries from the Epic server package to run and start the node. we can add chain_data as volumes for the epic node and port number to listen on while starting the container.

```sh
❯ docker run -d -p 3413:3413 -v /path-to-chain_data:/root/.epic/main/chain_data sysadminblaze/epic-node
```

The epic node will now start running in  `http://localhost:3413`. you can get the status by calling the url  `http://localhost:3413/v1/status`.

### Building docker images with custom options:

Clone the code from the git repo. [Epic Node docker](https://gitlab.com/epic-cash1/epic-node-dockerisation)

ENVs while building image: <br>
  Default ENVs: <br>
    1. CHAIN_DATA="true" <br>
    2. CHAIN_DATA_DEST="/root/.epic/main/chain_data" <br>
    3. CHAIN_DATA_SRC="~/.chain_data" 
    4. NODE_PORT="3413" 
    5. ARCH="x86_64"<br>

Steps to build the image:

```sh
❯ docker build -t 'Image name' . 
```

By default the image will not have chain_data, once the epic node is started it will will fetch the chain_data from live mainnet which will take time!.
"we will have the volume mounted with default ENV"

  ```sh
  ❯ docker compose up -d 
  ```
  with this above command a docker container will be created without chain_data and the volume path mapped will be `~/.chain_data:/root/.epic/main/chain_data`

  i) you have two other options, If you have chain_data already downloaded, you can mount the directory in the `/root/.epic/main/chain_data` in case you want to access it on the host.

  ```sh
  ❯ CHAIN_DATA_SRC="path_to_chaindata" docker compose up -d 
  ```
  with the above command the download chain_data is in the path "path_to_chaindata" which will be mapped to the chain_data directory inside the container.

  ii) If you no need to download the chain_data in your host you have another option to make the docker compose do it for you.

  ```sh
❯  CHAIN_DATA="false" docker compose up -d
```
  In this command the chain_data will be download while building the image and then mapped to ~/.chain_data in your host.you can also provide custom chain_data directory to map

