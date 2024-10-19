# Usar una imagen base de Go para compilar la aplicación
FROM golang:1.23 AS builder

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos de módulo primero
COPY src/go.mod src/go.sum ./

# Descargar las dependencias
RUN go mod download

# Copiar el código fuente desde la carpeta src
COPY src/ ./

# Compilar la aplicación
RUN go build -o my-go-app -v

# Usar una imagen base más pequeña para la producción
FROM alpine:latest

# Establecer el directorio de trabajo
WORKDIR /root/

# Copiar el binario compilado desde la etapa anterior
COPY --from=builder /app/my-go-app .

# Comando por defecto para ejecutar la aplicación
CMD ["./my-go-app"]


