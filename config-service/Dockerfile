FROM openjdk:11-jre-slim

ENV TZ=Etc/UTC

COPY ./target/config-service.jar config-service.jar
COPY ./entry-point.sh entry-point.sh

ENTRYPOINT ["./entry-point.sh"]
