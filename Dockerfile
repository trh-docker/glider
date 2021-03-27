# build stage
FROM quay.io/spivegin/golang:v1.16.2 AS build-env
ADD . /src
RUN cd /src && go build -v -ldflags "-s -w"
# RUN cd /src && go mod vendor && go build
# final stage
FROM quay.io/spivegin/tlmbasedebian
WORKDIR /opt
COPY --from=build-env /src/glider /opt/
#ENTRYPOINT ["./glider"]
