# Usa la imagen base de Go
FROM golang:1.20 AS builder

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos de dependencias al contenedor
COPY src/go.mod ./
COPY src/go.sum ./

# Descargar las dependencias
RUN go mod hello-world 

# Copiar el código fuente desde la carpeta src
COPY src/ ./

# Compilar la aplicación
RUN go build -o my-go-app

# Usar una imagen base más pequeña para la producción
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/my-go-app ./

# Exponer el puerto
EXPOSE 8080

# Comando por defecto para ejecutar la aplicación
CMD ["./my-go-app"]


