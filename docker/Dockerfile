ARG UBUNTU_VER=18.04

FROM ubuntu:${UBUNTU_VER} AS prepare-builder
ARG DEBIAN_FRONTEND=noninteractive
ARG APP_USER=c6supper
ARG PASS="none"
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install locales xz-utils tzdata sudo; \
    locale-gen en_US.UTF-8 && echo "dash dash/sh boolean false" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    addgroup --gid 998 vboxsf && \
    useradd --groups vboxsf --groups sudo -m -s /bin/bash $APP_USER && echo "$APP_USER:$PASS" | chpasswd && \
    usermod -aG vboxsf $APP_USER && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

ARG LIVENESS_PROBE

USER $APP_USER

ENV BUILD_DIR /code/
ENV CAPICXX_PLAYGROUND_DIR /capicxx_playground
ENV CAPICXX_PLAYGROUND_INITIALIZED_MARK $CAPICXX_PLAYGROUND_DIR/patched
COPY --chown=$APP_USER docker/version $CAPICXX_PLAYGROUND_DIR/version
COPY --chown=$APP_USER docker/docker-entrypoint.sh $CAPICXX_PLAYGROUND_DIR/docker-entrypoint.sh
COPY --chown=$APP_USER docker/examples $CAPICXX_PLAYGROUND_DIR/examples
COPY --chown=$APP_USER docker/patch $CAPICXX_PLAYGROUND_DIR/patch
COPY --chown=$APP_USER docker/build-commonapi.sh $CAPICXX_PLAYGROUND_DIR/build-commonapi.sh

# initilization for the first time
ENTRYPOINT ["/capicxx_playground/docker-entrypoint.sh"]

CMD ["/usr/bin/bash"]