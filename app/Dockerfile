FROM ubuntu

RUN apt-get update -y
RUN apt-get install python3-pip -y
RUN python3 -m pip install flask
RUN python3 -m pip install virtualenv

ADD . /app
WORKDIR /app

EXPOSE 5000

CMD ["python3 app.py"]