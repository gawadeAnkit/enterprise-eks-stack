# ===================================================================
# Enterprise WebApp Container (Tomcat / Java Spring 6 WAR)
# Multi-stage Docker build: compiles source -> packages WAR into Tomcat
# ===================================================================
FROM maven:3.9-amazoncorretto-21 AS build-stage

WORKDIR /build

COPY app/pom.xml ./pom.xml
COPY app/src ./src
RUN mvn clean package -DskipTests -B

# ───────────────────────────────────────────────────────────────────
FROM tomcat:10-jdk21-temurin AS runner

LABEL maintainer="gawadeAnkit"
LABEL description="Enterprise multi-tier Java application on Apache Tomcat 10"
LABEL version="2.0"

ENV CATALINA_OPTS="-Xms256m -Xmx512m"

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy compiled WAR as ROOT application
COPY --from=build-stage /build/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
