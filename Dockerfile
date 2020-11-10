FROM archlinux


RUN pacman -Syu --needed --noconfirm \
  base-devel \
  git \
  sudo \
  cmake \
  openssh \
  rsync \
  gcc \
  clang \
  gdb \
  imagemagick \
  benchmark


# makepkg user and workdir
ARG user=makepkg
RUN useradd -m $user \
  && echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
USER $user
WORKDIR /home/$user

# Install yay
RUN git clone https://aur.archlinux.org/yay.git \
  && cd yay \
  && makepkg -sri --needed --noconfirm \
  && cd \
  # Clean up
  && rm -rf .cache yay


RUN yay -S --noconfirm blaze \
    doctest \
    embree

EXPOSE 22

USER root
ARG userssh=blazert
RUN useradd -ms /bin/bash $userssh
RUN echo $userssh:blazert2020 | chpasswd


CMD [ ! -f /etc/ssh/ssh_host_rsa_key ] && ssh-keygen -A; /bin/sshd -D

# docker build --tag testcontainer .