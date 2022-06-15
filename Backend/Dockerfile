FROM golang:latest

ENV GOPATH=
ENV GO111MODULE=on

COPY ./app/main.go /go
COPY ./go.mod ./go.sum /go/

RUN go get github.com/labstack/echo
RUN go get github.com/jinzhu/gorm
RUN go get github.com/go-sql-driver/mysql
RUN go mod tidy

WORKDIR /go

CMD ["go","run", "/go/app/main.go"]


