FROM java:8

COPY target/springmvc.jar /usr/src/springmvc.jar
WORKDIR /usr/src/
EXPOSE 9090
CMD ["java", "-jar","springmvc.jar"]
