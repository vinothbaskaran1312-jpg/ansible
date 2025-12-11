FROM debian:stable
LABEL authors="devopst1"
#use run directive to execute commands with &&
RUN apt-get update && apt-get install -y --force-yes apache2
RUN mkdir /myapp
WORKDIR /myapp
COPY date.sh .
ADD https://raw.githubusercontent.com/vinothbaskaran1312-jpg/docker/refs/heads/master/testfile.txt ./vinoth.txt
RUN chmod 777 date.sh
ENV MYAPP=/myapp
WORKDIR /myapp
CMD [ "./date.sh" ]
ENTRYPOINT [ "date" ]
