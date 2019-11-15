FROM ubuntu:18.04

ENV WORK /demtools
RUN mkdir -p ${WORK}
WORKDIR ${WORK}
COPY . ${WORK}

ENV VENV $WORK/venv

RUN pwd
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntugis/ppa && \
    apt-get install gdal-bin python-gdal -y && \ 
    apt-get install python3-pip -y --no-install-recommends && \
    pip3 install virtualenv

RUN virtualenv -p python3 $VENV 
ENV PATH="$VENV/bin:$PATH"
RUN pip install -r requirements.txt

CMD ./entrypoint.sh