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
    less \
    lsof \
    netcat-openbsd \
    ngrep \
    openssh-server \
    openssl \
    patch \
    psmisc \
    screen \
    tcpdump \
    tmux \
    tshark \
    vim-tiny \
    xz-utils \
    zip unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/ssh/ssh_host*

RUN mkdir /root/.ssh/
RUN touch /root/.ssh/authorized_keys && chmod 0600 /root/.ssh/authorized_keys

RUN for user in \
      bquartier \
      cjeanneret \
      ckaenzig \
      dabelenda \
      illambias \
      mbornoz \
      mcanevet \
      mfournier \
      raphink \
      saimonn \
      ; do curl -s https://github.com/${user}.keys >> /root/.ssh/authorized_keys; done

RUN mkdir -p /var/run/sshd

EXPOSE 22

COPY /docker-entrypoint.sh /
COPY /docker-entrypoint.d/* /docker-entrypoint.d/
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]
