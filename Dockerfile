FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/HarishAddala/sele-kube-firefox.git
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/sele-kub/sele-kub /app
RUN mvn clean install
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/ /app
ENTRYPOINT ["java","-jar", "/app/sele-kub-0.0.1-SNAPSHOT-jar-with-dependencies.jar"]
