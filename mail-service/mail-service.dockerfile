# base go image
FROM golang:1.18-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o mailServiceApp ./cmd/api

RUN chmod +x /app/mailServiceApp

# build a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/mailServiceApp /app
COPY --from=builder /app/templates /templates

CMD ["/app/mailServiceApp"]