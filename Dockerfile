# build stage
FROM golang:alpine AS build-env
RUN apk --no-cache add build-base git gcc
ADD . /src
RUN cd /src && go build -v -ldflags "-s -w"

# final stage
FROM quay.io/spivegin/tlmbasedebian
WORKDIR /opt
COPY --from=build-env /src/glider /opt/
ENTRYPOINT ["./glider"]
