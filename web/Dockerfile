FROM python:3.7
ENV PYTHONUNBUFFERED 1
RUN mkdir /usr/src/app

WORKDIR /usr/src/app

ADD requirements.txt /usr/src/app/

RUN pip install -r requirements.txt
RUN pip install uwsgi

ADD . /usr/src/app/

CMD ["uwsgi", "--ini", "uwsgi.ini"]