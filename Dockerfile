# 阶段 1：使用 Maven 构建 JAR
# 原行：FROM maven:3.8.4-openjdk-17 AS build
# 替换为：
FROM registry.cn-hangzhou.aliyuncs.com/library/maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn package -DskipTests

# 阶段 2：运行 JAR
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8082
CMD ["java", "-jar", "app.jar"]