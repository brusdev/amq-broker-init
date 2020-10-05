#!/bin/sh

if [ -z "$1" ]
  then
    echo "No activemq-artemis-broker-init-image tag supplied"
fi

if [ -d src ]
  then
    git -C src fetch --all
    git -C src diff $1
  else
    mkdir src
    git clone https://github.com/artemiscloud/activemq-artemis-broker-init-image.git src
fi
git -C src checkout $1

# export REMOTE_SOURCE_REP=$(sed -n 's#ARG REMOTE_SOURCE_REP=##p' src/Dockerfile)
# sed -i "s/repo:.*/repo: $REMOTE_SOURCE_REP/" container.yaml

export REMOTE_SOURCE_REF=$(sed -n 's#ARG REMOTE_SOURCE_REF=##p' src/Dockerfile)
sed -i "s/ref:.*/ref: $REMOTE_SOURCE_REF/" container.yaml

sed "/^### BEGIN REMOTE SOURCE$/,/^### END REMOTE SOURCE$/c\COPY \$REMOTE_SOURCE \$REMOTE_SOURCE_DIR" src/Dockerfile > Dockerfile