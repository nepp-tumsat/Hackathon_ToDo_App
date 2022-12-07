FROM golang:1.17-alpine

ENV GOPATH=

WORKDIR /go

COPY . ./
COPY ./app/controller ./app/
COPY ./app/model ./app/



RUN apk update \
  && apk add --no-cache git \
  && go get -u github.com/labstack/echo \
  && go get gorm.io/gorm \
  && go get -u github.com/go-sql-driver/mysql \
  && go get github.com/nepp-tumsat/Hackathon_ToDo_App/Backend/app/controller

EXPOSE 8080

CMD ["go", "run", "main.go"]




