FROM ubuntu:18.04

VOLUME /root/notebooks
EXPOSE 8888

WORKDIR /root
COPY requirements.txt /root/

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python python-dev python-httplib2 libssl1.0.0 vim mc less wget gnupg2 && \
    # Couchbase
    wget https://packages.couchbase.com/releases/6.0.1/couchbase-server-enterprise_6.0.1-ubuntu18.04_amd64.deb && \
    dpkg -i couchbase-server-enterprise_6.0.1-ubuntu18.04_amd64.deb && \
    rm couchbase-server-enterprise_6.0.1-ubuntu18.04_amd64.deb && \
    # Couchbase libs
    wget -O - http://packages.couchbase.com/ubuntu/couchbase.key | apt-key add - && \
    echo "deb http://packages.couchbase.com/ubuntu bionic bionic/main" | tee /etc/apt/sources.list.d/couchbase.list && \
    apt-get update && \
    apt-get install -y libcouchbase-dev libcouchbase2-bin build-essential && \
    # Python 3.7.2
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get install -y python3.7 python3.7-dev python3-pip && \
    # Python modules
    python3.7 -m pip install -r requirements.txt && \
    rm requirements.txt && \
    # Jupyter Lab
    python3.7 -m pip install jupyterlab ipywidgets && \
    apt-get install -y nodejs npm && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter lab build --name='Platform Lab'

ENTRYPOINT ["jupyter-lab"]
CMD ["--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.token=''"]
