FROM python:3
MAINTAINER rocky
USER 751
RUN useradd --user-group --create-home --no-log-init --shell /bin/bash pursoul
#RUN rm /etc/apt/sources.list
#COPY sources.list /etc/apt/sources.list
# Configure environment
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update -y
# Install dependencies to fix `curl https support error` and `elaying package configuration warning`
RUN apt-get install -y apt-transport-https apt-utils

# Install superset dependencies
# https://superset.incubator.apache.org/installation.html#os-dependencies
RUN apt-get install -y build-essential libssl-dev \
    libffi-dev python3-dev libsasl2-dev libldap2-dev libxi-dev

#RUN apt-get install -y apt-transport-https vim iproute2 net-tools ca-certificates curl wget software-properties-common
#RUN apt-get -y install zlib*
#RUN apt-get install libffi-devel -y
COPY app /pursoul/app
COPY _config.yml /pursoul
COPY start.sh /pursoul
COPY config.py /pursoul
COPY manage.py /pursoul
COPY requirements.txt /pursoul
# Make port 80 available to the world outside this container

WORKDIR /pursoul
#RUN sudo -H pip install -r requirements.txt -i https://pypi.douban.com/simple
RUN pip install --upgrade setuptools pip \
    && pip install -r requirements.txt -r requirements-dev.txt \
    && rm -rf /root/.cache/pip
COPY --chown=pursoul:pursoul pursoul pursoul
USER pursoul

RUN python manage.py db init
RUN python manage.py db migrate
RUN python manage.py db upgrade
CMD ["/bin/bash","/pursoul/start.sh"]
EXPOSE 5000