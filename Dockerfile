# Usa la imagen oficial de Go como base
FROM golang:1.20 AS builder

# Establece el directorio de trabajo
WORKDIR /app/src

# Copia el archivo go.mod y go.sum (si existen)
COPY src/go.mod src/go.sum ./

# Descarga las dependencias (si hay)
RUN go mod download

# Copia el resto de los archivos de la aplicación
COPY src/ ./

# Compila la aplicación
RUN go build -o myapp .

# Usa una imagen más pequeña para ejecutar la aplicación
FROM alpine:latest

# Copia el binario desde la imagen de builder
COPY --from=builder /app/src/myapp .

# Exponer el puerto en el que escucha la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["./myapp"]
