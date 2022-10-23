# Iniciando a base da image
FROM ubuntu:14.04.3


# installando as dependencias
RUN apt-get update
RUN apt-get install -y nginx supervisor
RUN apt-get install -y python python-dev python-pip python-virtualenv
RUN apt-get install -y python-opencv
RUN apt-get install -y python-matplotlib
RUN apt-get install -y python-scipy
RUN apt-get install -y python-skimage
RUN pip install uwsgi
RUN pip install Flask



# adicionando o workspace do flask
ADD ./app /app
ADD ./config /config

# setup config
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default

RUN ln -s /config/nginx.conf /etc/nginx/sites-enabled/
RUN ln -s /config/supervisor.conf /etc/supervisor/conf.d/

EXPOSE 80
CMD ["python", "app/camera_flask_app.py"]