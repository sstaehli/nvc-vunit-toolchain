FROM ghcr.io/vunit/dev/nvc:latest

RUN pip3 install --upgrade pip && pip install vunit_hdl

ENTRYPOINT ["/bin/bash"]