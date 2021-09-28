
FROM ubuntu:20.04
RUN apt-get update



ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    SSH_PORT=22
###########################################################################
ENV HOME=/headless \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/headless/install \
    NO_VNC_HOME=/headless/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x1024 \
    VNC_PW=vncpassword \
    VNC_VIEW_ONLY=false
### Envrionment config



###########################################################################
################################## ADD FILES ##################################

ADD ./src/ $INST_SCRIPTS/
ADD ./addon/ $INST_SCRIPTS/
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +
################## Envrionment config ##########################################
WORKDIR $HOME
RUN $INST_SCRIPTS/package.sh
#######################  SSH ###########################################
RUN mkdir -p ~/.ssh
RUN rm /etc/ssh/sshd_config
RUN cp $INST_SCRIPTS/sshd_config /etc/ssh/
###########################################################################

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 

RUN  echo 'test:test' | chpasswd

RUN service ssh start

############################ ADD ROOT PASSWORD ###########################
RUN ssh-keygen -q -t rsa -N '' -f /id_rsa

RUN echo "root:1" | /usr/sbin/chpasswd
RUN addgroup uno
RUN useradd -m -s /bin/bash -g uno uno
RUN echo "uno:1" | /usr/sbin/chpasswd
RUN echo "uno    ALL=(ALL) ALL" >> /etc/sudoers

#########################################################################

EXPOSE $VNC_PORT $NO_VNC_PORT $SSH_PORT

CMD ["/usr/sbin/sshd","-D"]
#RUN python --version
#RUN python3.9 --version
#COPY requirements.txt .
#RUN --mount=type=cache,mode=0755,target=/root/.cache pip3 install -r requirements.txt 111
#COPY . .

#CMD ["python3", " --version"]
#CMD ["--wait"]

