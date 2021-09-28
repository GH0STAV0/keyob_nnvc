FROM ubuntu:20.04


RUN apt-get update && apt-get install -y python3.9 python3.9-dev

RUN \
    --mount=type=cache,target=/var/cache/apt,from=stage_cache,source=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt,from=stage_cache,source=/var/lib/apt \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        jq \
        nano \
        psmisc \
        sudo \
        tini \
        wget

#COPY requirements.txt .
#RUN --mount=type=cache,mode=0755,target=/root/.cache pip3 install -r requirements.txt 111
#COPY . .
CMD ["python"]
