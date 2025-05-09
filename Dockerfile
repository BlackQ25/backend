# Usa una imagen oficial de OpenJDK
FROM openjdk:17-jdk-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el pom.xml y el wrapper (mvnw + .mvn)
COPY pom.xml ./
COPY mvnw ./
COPY .mvn .mvn

# Da permisos de ejecución al wrapper
RUN chmod +x mvnw

# Descarga dependencias
RUN ./mvnw dependency:go-offline

# Copia todo el código restante
COPY . .
RUN chmod +x mvnw
RUN ./mvnw package -DskipTests

# Compila y construye el jar
RUN ./mvnw package -DskipTests

# Exponer el puerto 8080
EXPOSE 8080

# Comando para ejecutar la app
CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar"]
