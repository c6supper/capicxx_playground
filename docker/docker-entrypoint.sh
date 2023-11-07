#!/bin/sh

set -ex

patch_conf() {
    
    if [ ! -d "$CAPICXX_PLAYGROUND_DIR/build-commonapi.sh" ]; then
        echo $PASS | sudo -S ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime;
    fi
    export DEBIAN_FRONTEND=noninteractive;
    DEBIAN_FRONTEND=noninteractive echo $PASS | sudo -S apt install -y unzip openjdk-8-jre git \
    make libexpat1-dev cmake gcc g++ automake autoconf wget pkg-config && \
    echo $PASS | sudo -S dpkg-reconfigure --frontend noninteractive tzdata && \
    echo $PASS | sudo -S locale-gen en_US.UTF-8 && \
    cd $BUILD_DIR && cp -rf $CAPICXX_PLAYGROUND_DIR/examples ./ && \
    cp -rf $CAPICXX_PLAYGROUND_DIR/patch ./ && \
    cp -rf $CAPICXX_PLAYGROUND_DIR/build-commonapi.sh ./ && \
    # echo "export GOPATH=$HOME/go" >> ~/.bashrc && \
    # echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java" >> ~/.bashrc  && \
    # cd /tmp && wget https://cmake.org/files/v3.23/cmake-3.23.0.tar.gz --retry-connrefused -qO - | tar xz && \
    # cd cmake-3.23.0 && ./configure && make -j16 && echo $PASS | sudo -S make install && \
    # cd / && rm -rf /tmp/cmake* && \
    ./build-commonapi.sh && \
    touch $CAPICXX_PLAYGROUND_INITIALIZED_MARK && \
    echo "export PATH=$PATH:/usr/local/bin" >> ~/.bashrc
}

if [ ! -f "$CAPICXX_PLAYGROUND_INITIALIZED_MARK" ]; then
    patch_conf
    echo
    echo 'building env init process complete; ready for start up.'
    echo
else
    echo
    echo 'Skipping initialization'
    echo
    echo 'done'
    echo
    
fi

/bin/sh -c "$@"