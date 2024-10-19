# Usa la imagen oficial de Golang como base
FROM golang:1.20 AS builder

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de tu aplicación al contenedor
COPY . .

# Compila la aplicación
RUN go build -o hello-world .

# Usa una imagen más ligera para ejecutar la aplicación
FROM alpine:latest

WORKDIR /root/

# Copia el binario compilado desde la etapa de construcción
COPY --from=builder /app/hello-world .

# Comando por defecto para ejecutar la aplicación
CMD ["./hello-world"]
