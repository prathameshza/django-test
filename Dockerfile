
# Use the official debian image.
FROM debian:latest
ENV TZ=Asia/Culcutta
ENV DEBIAN_FRONTEND=noninteractiveR
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python3 python3-pip python3-django
# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True


# Copy local code to the container image.
ENV APP_HOME /django-test
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
RUN python3 manage.py migrate
CMD exec python3 manage.py runserver 0.0.0.0:80
