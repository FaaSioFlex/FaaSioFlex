# Usa la imagen de Go
FROM golang:alpine AS builder

WORKDIR /app

# Copiar los archivos go.mod y go.sum
COPY  src/go.mod ./
COPY src/go.sum ./

# Descargar las dependencias
RUN go mod download

# Copiar el código fuente
COPY src/main.go ./

# Compilar la aplicación
RUN go build -o my-go-app

# Usar una imagen base más pequeña para la producción
FROM alpine:latest

WORKDIR /app

# Copiar el binario desde la etapa de construcción
COPY --from=builder /app/my-go-app .

# Exponer el puerto en el que la aplicación escuchará
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["./my-go-app"]



