FROM ghcr.io/nickg/nvc:latest

RUN apt-get update && apt-get autoremove -y --purge && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    gosu \
    && apt-get clean

RUN python3 -m venv /opt/venv \
    && . /opt/venv/bin/activate \
    && pip3 install --upgrade pip \
    && pip install vunit_hdl

# Entry point setup
COPY entrypoint.sh /
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/local/bin/tini
RUN chmod +x /usr/local/bin/tini
ENTRYPOINT ["/usr/local/bin/tini", "--", "/entrypoint.sh"]
CMD ["bash"]