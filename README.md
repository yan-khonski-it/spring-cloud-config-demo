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