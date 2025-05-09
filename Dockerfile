# Usa una imagen oficial de OpenJDK
FROM openjdk:17-jdk-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el pom.xml y descarga dependencias
COPY pom.xml ./
RUN ./mvnw dependency:go-offline

# Copia todo el código
COPY . .

# Compila y construye el jar
RUN ./mvnw package -DskipTests

# Exponer el puerto 8080
EXPOSE 8080

# Comando para ejecutar la app
CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar"]
