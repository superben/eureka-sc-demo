
#Service-consumer

## APIs样例
```
curl http://localhost:8084/echo-rest/info
curl http://localhost:8084/echo-feign/info

# 通过GW访问
curl http://localhost:8082/SERVICE-CONSUMER/echo-feign/info
curl http://localhost:8082/SERVICE-CONSUMER/echo-rest/info

# 存活探针
curl http://localhost:8084/actuator/info

# 就绪探针
curl http://localhost:8084/actuator/health

```
