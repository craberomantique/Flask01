FROM python:3.10.7
ADD app.py /
COPY . /app
WORKDIR /app
RUN pip3 install Flask
EXPOSE 5000
CMD [ "python3", "./app.py" ]
