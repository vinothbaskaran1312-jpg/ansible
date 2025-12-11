FROM alpine
RUN apk add vim
RUN apk add nano
RUN apk add elinks
RUN mkdir /myappdir
RUN cal 2026 > /myappdir/cal2026.txt
