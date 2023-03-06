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

## Building docker images with custom options:
## Clone the repo:
Clone the code from the git repo. [Epic Node docker](https://gitlab.com/epic-cash1/epic-node-dockerisation)

```
git clone https://gitlab.com/epic-cash1/epic-node-dockerisation.git
```

### ENVs while building image: <br>
  Default ENVs:

    - CHAIN_DATA="true"
    - CHAIN_DATA_DEST="/root/.epic/main/chain_data"
    - CHAIN_DATA_SRC="~/.chain_data" 
    - NODE_PORT="3413" 
    - ARCH="x86_64"

you can edit the env's in the `.env` file or you can override the values at runtime.

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
  
  you have two other options

  -  If you have chain_data already downloaded, you can mount the chain_data into the `/root/.epic/main/chain_data` inside the container.It can be done by

  ```sh
  ❯ CHAIN_DATA_SRC="path_to_chaindata" docker compose up -d 
  ```
  with the above command the download chain_data is in the path "path_to_chaindata" which will be mapped to the chain_data directory inside the container.

  - If you not having chain_data in your host you have another option to make the docker compose download and map it for you.

  ```sh
  ❯  CHAIN_DATA="false" docker compose up -d
  ```
  In this command the chain_data will be download while building the image and then mapped to ~/.chain_data in your host.you can also provide custom chain_data directory to map

  ```sh
  ❯  CHAIN_DATA="false" CHAIN_DATA_SRC="path_to_chaindata"  docker compose up -d
  ```

## Exposing ports:
By default `3413` port from host will be mapped to the epic server port listening inside the conatiner which is `3413`. <br>
if you have the port 3413 busy in host we can change the port number to listen in someother port on our host,eg.port 3414.

```sh
❯  NODE_PORT="3414"  docker compose up -d
```