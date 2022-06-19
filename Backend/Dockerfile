FROM golang:latest

ENV GOPATH=
ENV GO111MODULE=on

COPY ./app/main.go /go
COPY ./go.mod ./go.sum /go/

RUN go get github.com/labstack/echo
RUN go get gorm.io/gorm
RUN go get github.com/go-sql-driver/mysql

WORKDIR /go

CMD ["go","run", "/go/app/main.go"]


