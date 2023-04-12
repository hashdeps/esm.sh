FROM --platform=linux/x86-64 golang:1.18 AS build

RUN apt-get update -y && apt-get install -y xz-utils
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - &&\
    apt-get install -y nodejs
RUN mkdir /esm
COPY . /esm

WORKDIR /esm
RUN go build -o bin/esmd main.go

CMD ["/esm/bin/esmd", "--config", "config.json"]
