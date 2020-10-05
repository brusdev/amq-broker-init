FROM registry.access.redhat.com/ubi8/ubi-minimal:8.2-349

COPY $REMOTE_SOURCE $REMOTE_SOURCE_DIR
WORKDIR $REMOTE_SOURCE_DIR/app

RUN microdnf install python3

RUN mkdir -p $(python3 -c 'import site; print(site.getsitepackages()[0])' | sed "s/lib64/lib/")
RUN sed -i 's/python/python3/g' ./setup.py

RUN ./setup.py install
