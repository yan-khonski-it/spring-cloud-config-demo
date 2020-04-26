#!/bin/bash

set -x

exec java -XX:+UseContainerSupport $JAVA_OPTIONS -jar /config-service.jar