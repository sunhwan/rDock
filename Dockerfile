FROM ubuntu:22.04

RUN apt-get update &&\
    apt-get install --no-install-recommends -y make libpopt0 libpopt-dev g++ && \
    # cleaning up unused files
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . /rDock
WORKDIR /rDock

RUN make -j$(nproc)

ENV PATH="/rDock/bin:${PATH}"
ENV LD_LIBRARY_PATH="/rDock/lib:${LD_LIBRARY_PATH}"
ENV RBT_ROOT="/rDock"

