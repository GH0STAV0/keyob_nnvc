
FROM ubuntu:20.04


RUN apt-get update




################## Envrionment config ##########################################
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    SSH_PORT = 22
 

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
WORKDIR $HOME

#######################  SSH ###########################################
RUN mkdir -p ~/.ssh
RUN rm /etc/ssh/sshd_config
RUN cp $INST_SCRIPTS/sshd_config /etc/ssh/
###########################################################################


ADD ./src/ $INST_SCRIPTS/
ADD ./addon/ $INST_SCRIPTS/

RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

RUN $INST_SCRIPTS/package.sh

#RUN python --version
RUN python3.9 --version
#COPY requirements.txt .
#RUN --mount=type=cache,mode=0755,target=/root/.cache pip3 install -r requirements.txt 111
#COPY . .
EXPOSE $VNC_PORT $NO_VNC_PORT $SSH_PORT
CMD ["python", " --version"]
