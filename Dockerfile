FROM golang:1.12-alpine as builder
RUN apk add --no-cache git
WORKDIR /go/croc
# TODO any change in the repo will invalidate docker build cache
COPY . .
RUN go build -v

FROM alpine:latest 
EXPOSE 9009 9010 9011 9012 9013
COPY --from=builder /go/croc/croc /go/croc/croc-entrypoint.sh /
ENTRYPOINT ["/croc-entrypoint.sh"]
CMD ["relay"]
