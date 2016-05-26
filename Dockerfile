FROM debian:jessie
MAINTAINER Marc Fournier <marc.fournier@camptocamp.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y --no-install-suggests --no-install-recommends install \
    bash-completion \
    bzip2 \
    ca-certificates \
    curl \
    diffutils \
    file \
    git \
    jq \
    ldap-utils \
    less \
    lsof \
    mysql-client \
    netcat-openbsd \
    ngrep \
    openssh-server \
    openssl \
    patch \
    postgresql-client \
    psmisc \
    rsync \
    screen \
    tcpdump \
    tmux \
    tshark \
    vim-tiny \
    wget \
    xz-utils \
    zip unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/ssh/ssh_host*

RUN mkdir -p /var/run/sshd

EXPOSE 22

COPY /docker-entrypoint.sh /
COPY /docker-entrypoint.d/* /docker-entrypoint.d/
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]
