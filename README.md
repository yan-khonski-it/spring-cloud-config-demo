# spring-cloud-config-demo
Reproducing issue

https://github.com/spring-cloud/spring-cloud-config/issues/1599


## Start the project
1) Build `config-service` project with maven. Use JDK 11, which is LTS.
`mvn clean install`

2) Run config-service `docker-compose up`.

3) Use POSTMAN, curl or another HTTP client. Note, Postman can sent default headers, including Accept.
Please, make sure, you overwrite it then.

## Results:

#### 1) Works service1, which has field value empty.

`HTTP GET http://localhost:8888/service1/dev`

#### 2) Works with Accept header

`Accept:application/vnd.spring-cloud.config-server.v2+json`
`HTTP GET http://localhost:8888/service1/dev`

#### 3) Works with service2; field has value empty array.

`HTTP GET http://localhost:8888/service2/dev`

#### 4) Fails with service 2, with Accept header

`Accept:application/vnd.spring-cloud.config-server.v2+json`
`HTTP GET http://localhost:8888/service2/dev`
Response
```
{
    "timestamp": "2020-04-26T17:27:11.755+0000",
    "status": 500,
    "error": "Internal Server Error",
    "message": "Could not construct context for config=service2 profile=dev label=null includeOrigin=true; nested exception is java.lang.NullPointerException",
    "path": "/service2/dev"
}
```

## How to debug

#### 1) Create remote debug configuration in your IDE.

#### 2) Add `JAVA_OPTIONS` to the service you want to debug.
```
- "JAVA_OPTIONS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
```

#### 3) Open ports.
```.env
ports:
  - 5005:5005
```

#### 4) Total example.
```.yaml
  config-service:
    build:
      context: "./config-service"
      dockerfile: Dockerfile
    container_name: config-service
    volumes:
      - "./configuration:/configuration:ro"
    environment:
      - "SPRING_PROFILE=native"
      - "SPRING_CLOUD_CONFIG_PROFILE=dev"
      - "GIT_REPOSITORY_URI=https://github.com/yan-khonski-it/spring-cloud-config-demo"
      
      # Debug the service
      - "JAVA_OPTIONS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"

      # Label
      - "GIT_BRANCH=dev"
    networks:
      - scc-demo-network
    ports:
      - 8888:8888

    # Open debug port
      - 5005:5005
```