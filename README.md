# epic-node-dockerisation
Steps to start the Epic Node:
1. Clone the repo
2. cd {REPO DIR}
3. "docker build -t epicnode:v1 ."
4. "docker run -d --name={CONTAINER NAME} -p 3413:3413 epicnode:v1"
5. Epic node container will start running in port 3413
