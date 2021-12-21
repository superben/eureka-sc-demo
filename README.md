# eureka-sc-demo
本应用演示通过切换spring boot应用profile，使应用运行在不同的环境
* default：用于使用本机环境开发服务，使用eureka作为注册中心
* mesh：用于没有任何注册中心的场景，运行应用
  * 适用于运行在service mesh环境
  * 适用于本机环境，通过/etc/hosts配置服务名的方式做开发测试
* k8s：用于运行在Kubernetes环境，使用其上的eureka作为注册中心

## 构建应用

```
# 构建应用
cd eureka-sc-demo
mvn clean package

# Eureka-server
cd eureka-server
docker build -t 10.200.10.1:5000/demo/eureka:v1.0 .

docker run --rm --name eureka 10.200.10.1:5000/demo/eureka:v1.0 
docker top eureka # 检查eureka-server容器进程PID
docker exec -it eureka sh # 登录到eureka-server容器

# Provider
docker build -t 10.200.10.1:5000/demo/provider:v1.0 .
docker run --rm --name provider 10.200.10.1:5000/demo/provider:v1.0

# Consumer
docker build -t 10.200.10.1:5000/demo/consumer:v1.0 .
docker run --rm --name consumer 10.200.10.1:5000/demo/consumer:v1.0

# Gateway
docker build -t 10.200.10.1:5000/demo/gateway:v1.0 .
docker run --rm --name gateway 10.200.10.1:5000/demo/gateway:v1.0
```

### 本地测试：使用default profile
使用如下命令启动各个服务的default profile。
```
mvn spring-boot:run
```
使用如下命令命令验证服务：
```
curl http://localhost:8083/echo/info

curl http://localhost:8084/echo-feign/info
curl http://localhost:8084/echo-rest/info

curl http://localhost:8082/actuator/gateway/routes | jq
curl http://localhost:8082/service-provider/echo/info
curl http://localhost:8082/service-consumer/echo-feign/info
curl http://localhost:8082/service-consumer/echo-rest/info
```

### 本地测试：使用mesh profile
在/etc/hosts中添加如下条目：
```
127.0.0.1	service-consumer
127.0.0.1	service-provider
127.0.0.1   gateway
或 （我自己的环境）
10.200.10.1	service-provider
10.200.10.1	service-consumer
10.200.10.1 gateway
```

使用如下命令启动各个服务的mesh profile。
```
mvn spring-boot:run -Dspring-boot.run.profiles=mesh
```

使用如下命令命令验证服务：
```
curl http://service-provider:8083/echo/info

curl http://service-consumer:8084/echo-feign/info
curl http://service-consumer:8084/echo-rest/info

curl http://gateway:8082/actuator/gateway/routes | jq
curl http://gateway:8082/service-provider/echo/info
curl http://gateway:8082/service-consumer/echo-feign/info
curl http://gateway:8082/service-consumer/echo-rest/info
```

## 服务的actuator特性
这里演示eureka的actuator特性，容器内和本地环境都可尝试：
```
curl http://eureka:8761

curl http://eureka:8761/actuator
curl http://eureka:8761/actuator/info
curl http://eureka:8761/actuator/health
```

## 有用的命令
```
kubectl port-forward svc/eureka 8761:8761
```