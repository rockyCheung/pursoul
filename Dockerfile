FROM python:3
MAINTAINER rocky
USER 751
#RUN rm /etc/apt/sources.list
#COPY sources.list /etc/apt/sources.list
#RUN su - root
#RUN apt-get update
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
EXPOSE 5000
WORKDIR /pursoul
#RUN sudo -H pip install -r requirements.txt -i https://pypi.douban.com/simple
RUN pip install --trusted-host pypi.python.org  -r requirements.txt
RUN python manage.py db init
RUN python manage.py db migrate
RUN python manage.py db upgrade
CMD ["/bin/bash","/pursoul/start.sh"]