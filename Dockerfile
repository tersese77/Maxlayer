FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta
ENV USER=ubuntu
ENV HOME=/home/ubuntu
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    dbus-x11 \
    tigervnc-standalone-server \
    tigervnc-tools \
    novnc \
    websockify \
    xterm \
    thunar \
    mousepad \
    sudo \
    curl \
    wget \
    ca-certificates \
    fonts-dejavu \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} \
    && chmod 0440 /etc/sudoers.d/${USER}

RUN mkdir -p /home/ubuntu/.vnc \
    && chown -R ubuntu:ubuntu /home/ubuntu

COPY xstartup /home/ubuntu/.vnc/xstartup
COPY start.sh /start.sh

RUN chmod +x /start.sh /home/ubuntu/.vnc/xstartup \
    && chown ubuntu:ubuntu /home/ubuntu/.vnc/xstartup

EXPOSE 80

WORKDIR /home/ubuntu

CMD ["/start.sh"]
