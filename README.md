# epic-node-dockerisation
Steps to start the Epic Node:
"Clone the repo"
1. cd [repo directory]
2. Starting the container \
#If you have chain_data in a "PATH" \
CHAIN_DATA_SRC="PATH" docker compose up -d \
#If you have no chain_data \
CHAIN_DATA="false" docker compose up -d \
#By default chain_data folder will be created in your home directory "~./chain_data" and mapped inside the container \
3. epic server node container will be started in the host with the port mentioned in "NODE_PORT". If not mentioned it will be started in port "3413" 
