FROM openjdk:8u312-jre-slim

LABEL description="your description"
ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    APP_SLEEP=0 \
    JAVA_OPTS="" \
    RUN_ARGS="" \
    APP_NAME_ID="" \
    TZ="Asia/Shanghai"

RUN apt update; apt install -y curl; ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /root/app/

COPY entrypoint.sh \
     target/app.jar \
     /root/app/

CMD ["./entrypoint.sh"]
EXPOSE 8084
