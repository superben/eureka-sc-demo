
# Service-provider

## APIs样例
```
curl http://localhost:8083/echo/info

# 通过GW访问
curl http://localhost:8082/SERVICE-PROVIDER/echo/info

# 存活探针
curl http://localhost:8083/actuator/info

# 就绪探针
curl http://localhost:8083/actuator/health
```