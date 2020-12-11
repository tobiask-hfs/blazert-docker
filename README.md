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

## Step 6 - Add Deployment in Clion

The part that comes now refers specifically to Clion. How a container integration works with other IDEs must be looked
up independently. Now that we have created the container we want to finally include it for use in Clion.

Before a real remote host can be included, a deployment must first be set up. For this open `Settings..`, there search
for **Deployment**. Usually it can be found under ``Build, Execution, Deployment``. When you have found it press
**Add** and select **SFTP**, the name of the server does not matter.

![alt text](https://github.com/tobiask-hfs/blazert-docker/blob/master/readme_images/SFTPPNG.PNG)

To include the container, press the button with the three dots next to SSH configuration, a new window should open. The
following data should be adopted.

![alt text](https://github.com/tobiask-hfs/blazert-docker/blob/master/readme_images/ssh_config.PNG)

Then the connection can be tested. Usually there is a request for security, this can be ignored and bypassed with **
YES**. The request comes because in some way the SSH process inside the Dockerfile is bypassed and since the container
should not take over any security related tasks, this can be done. If such a demand does not come, then good for you. It
should also indicate that the connection was successfully established. If this is not the case, you should check again
if the container is really running.

You should also remember to enter the previously set host port in the port field if it differs from this manual.

## Step 7 - Add and setup remote host

Now comes the part where the remote host is added. For this purpose, **Toolchains** is called under `Settings...`. Here
you can select a **Remote Host** from the list when adding. Under credentials, the previously set up "Server" is
selected. For gcc and clang, separate remote hosts must be set.

Setup for gcc: 

![alt text](https://github.com/tobiask-hfs/blazert-docker/blob/master/readme_images/remote_gcc.PNG)

Setup for clang:

![alt text](https://github.com/tobiask-hfs/blazert-docker/blob/master/readme_images/remote_clang.PNG)

## Step 8 - CMake
A CMake profile must be set up for the project to run. This should basically look like the following:

![alt text](https://github.com/tobiask-hfs/blazert-docker/blob/master/readme_images/example_debug_gcc.PNG)

It must be noted that this still refers to the blazeRT framework.