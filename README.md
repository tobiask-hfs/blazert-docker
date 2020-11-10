# blazert-docker
## Step 1 - Install Docker for your System
## Step 2 - Pull Image
## Step 3 - Run Image
Need to set the correct Ports.
## Step 4 - Add Remote Host to Clion
## How to write Dockerfile ? 
## List of useful Docker commands

| Command       | Description   | 
| ------------- |:-------------:| 
| `docker images`     | List images  | 
| `docker ps -a`      | List containers      | 


`docker run -p 2222:22 <IMAGE-ID>`: Startet Container mit unter localhost mit port 2222 

docker images - zeigt alle vorhandenen images an
docker login - login in docker -> danach eingabe von DockerID und Passwort
docker pull <image-name> - Downloadet jeweiliges docker image
docker run -it -d <REPOSITORY> - Startet das jeweilige image/container
docker ps -a -> lists containers
docker exec -it <CONTAINER-ID> bash -> startet powershell des jeweilgen containers
docker commit <CONTAINER-ID> <new-name:Tag> -> erzeugt neues image vom jeweiligen container unter einem neuen namen, praktisch wenn änderungen im container durchgeführt wurden (erzeugung con cmake-debug etc.), tag nicht unbedingt nötig
docker push <REPOSITORY:TAG> -> pusht das jeweilige image nach dockerhub