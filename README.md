# blazert-docker

## Step 1 - Install Docker for your System

Go to official [Docker website](https://docs.docker.com/get-docker/), select your OS and follow the instructions for
installation.

## Step 2 - Clone Repo

Clone the repository to a folder that you can find again.

## Step 3 - Open folder in CMD/PowerShell/Bash

Now open the repo folder in the command line. From here on we will work with docker's own commands. Each following
command should be executed OS independent in the command line. In addition, it should be ensured that docker is running
in the background.

## Step 4 - Create image

Before we can create a container, we need to create an image. From this we can then create a container afterwards. To
create the image the following command must be used:

````
$ docker build -t Name_of_Image:Tag .
````

When everything has been created successfully, it is possible to check if the image is really there.

````
$ docker image ls
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
Name_of_Image        Tag                 3b91e56bbdfa        42 seconds ago      1.72GB
````

Everything was successful if the image with the desired name and tag appears in this list.

## Step 5 - Create container from image

Now that we have a suitable image, we can create our container. Here the container is created so that it does not delete
itself after exit. This is relevant for the use of the container. To create the container use following command:

````
$ docker run -p 2222:22 --name Name_of_Container Name_of_Image:Tag
````

The `-p 2222:22` part of the command is needed so that the container can be mounted remotely in the IDE afterwards. Now
the host port `0.0.0.0:2222` is mapped to the container port `22/tcp`. Thus there is a connection between host and
container, which is necessary for the integration. After `--name` follows the desired name of the container and after
that must come the name/id of the image. Now there is a running docker container.

Just as with the image, it is possible to check whether the container is really running.

````
$ docker container ls
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
fee4fc85b63d        Name_of_Image:Tag   "/bin/sh -c '[ ! -f …"   42 seconds ago      Up 42 seconds       0.0.0.0:2222->22/tcp   Name_of_Container
````

Don't be surprised, under command it only says what is executed in the command line when the container is created. If
everything has worked up to this point, congratulations. Now you have a running docker container

## Step 6 - Add Remote Host to Clion

The part that comes now refers specifically to Clion. How a container integration works with other IDEs must be looked
up independently. Now that we have created the container we want to finally include it for use in Clion.

First open the `Settings`, in the settings search for **Deployment**. Usually these can be found
under ``Build, Execution, Deployment``. When you have found it press **Add** and select **SFTP**, the name of the server
does not matter. 

![alt text](https://github.com/tobiask-hfs/blazert-docker/blob/master/readme_images/SFTPPNG.PNG)
## Step 3 - Run Image

If you use the image for the first time, a container must be created first. Usually these can be found under **Build,
Execution, Deployment**.

```
$ docker image ls
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
tobiaskhfs/blazert   1                   70419blaze21        1 hours ago         1.92GB
```

The command ``docker image ls`` shows every docker repository on the host os. Next you select the repository to start
from, using the IMAGE ID. You must also specify a port for the localhost.

```
$ docker run -p 2222:22 --name BlazeRT_Container tobiaskhfs/blazert:1
```

- ``docker run`` specifies that you want to run an image
- ``-p 2222:22`` connects the tcp 22 port of the container with the localhost port 2222
- ``--name BlazeRT_Container`` name of the container (optional)
- ``tobiaskhfs/blazert:1`` chooses the repository and tag
    - alternatively the IMAGE ID can be used: ``70419blaze21``

You can check now if the container is running.

```
$ docker ps -a
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS                  NAMES
9809683ec69c        tobiaskhfs/blazert:1   "/bin/sh -c '[ ! -f …"   1 minutes ago      Up 1 minutes       0.0.0.0:2222->22/tcp   BlazeRT_Container
```

There you should now see the container you just created.

![alt text](https://cdn.dumpaday.com/wp-content/uploads/2018/09/photos-21-3.jpg)

## Step 4 - Add Remote Host to Clion

Once the container is running you could start to set up a remote host for clion.

## How to write Dockerfile ?

## List of useful Docker commands

| Command       | Description   | 
| ------------- |:-------------:| 
| `docker images`     | List images  | 
| `docker ps -a`      | List containers      | 

`docker run -p 2222:22 <IMAGE-ID>`: Startet Container mit unter localhost mit port 2222

docker images - zeigt alle vorhandenen images an docker login - login in docker -> danach eingabe von DockerID und
Passwort docker pull <image-name> - Downloadet jeweiliges docker image docker run -it -d <REPOSITORY> - Startet das
jeweilige image/container docker ps -a -> lists containers docker exec -it <CONTAINER-ID> bash -> startet powershell des
jeweilgen containers docker commit <CONTAINER-ID> <new-name:Tag> -> erzeugt neues image vom jeweiligen container unter
einem neuen namen, praktisch wenn änderungen im container durchgeführt wurden (erzeugung con cmake-debug etc.), tag
nicht unbedingt nötig docker push <REPOSITORY:TAG> -> pusht das jeweilige image nach dockerhub