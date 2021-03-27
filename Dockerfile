# build stage
FROM quay.io/spivegin/golang:v1.15.2 AS build-env
RUN apt update && apt install build-essential gcc -y
ADD . /src
#RUN cd /src && go build -v -ldflags "-s -w"
RUN cd /src && go mod vendor && go build
# final stage
FROM quay.io/spivegin/tlmbasedebian
WORKDIR /opt
COPY --from=build-env /src/glider /opt/
#ENTRYPOINT ["./glider"]
