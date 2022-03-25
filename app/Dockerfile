FROM python:3

RUN pip install flask
RUN pip install virtualenv

ADD . /app
WORKDIR /app

EXPOSE 5000

CMD ["python", "./app.py"]