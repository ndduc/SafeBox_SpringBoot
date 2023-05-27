# Use an OpenJDK base image
FROM amazoncorretto:17 as builder

# Copy Project Config
COPY gradle /usr/src/safebox/gradle
COPY gradlew /usr/src/safebox/gradlew
COPY build.gradle /usr/src/safebox/build.gradle
COPY settings.gradle /usr/src/safebox/settings.gradle

# COPY src /usr/src/safebox/src
COPY . /usr/src/safebox

# Set the working directory inside the container
WORKDIR /usr/src/safebox

RUN chmod +x gradlew

RUN ./gradlew build

FROM amazoncorretto:17
COPY --from=builder /usr/src/safebox/build/libs/safebox*.jar safebox.jar

ENTRYPOINT ["java", "-jar", "safebox.jar"]
CMD ["java", "-jar", "safebox.jar"]