# Usar una imagen base de Go
FROM golang:1.20 AS builder  # Cambia 1.20 a la versión de Go que necesitas

WORKDIR /app

# Copia los archivos go.mod y go.sum
COPY go.mod go.sum ./

# Descarga las dependencias
RUN go mod download

# Copia el resto de tu código fuente
COPY . .

# Compila la aplicación
RUN go build -o hello-world .

# Usa una imagen más ligera para ejecutar la aplicación
FROM alpine:latest

WORKDIR /root/

# Copia el binario desde la etapa de construcción
COPY --from=builder /app/hello-world .

# Expone el puerto en el que escucha tu aplicación
EXPOSE 8080

# Comando para ejecutar tu aplicación
CMD ["./hello-world"]
