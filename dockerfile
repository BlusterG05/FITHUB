# Usa una imagen base de Node.js
FROM node:22.4.1

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el package.json y el package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto de la aplicación
COPY . .

# Expone el puerto en el que corre la aplicación
EXPOSE 3000

# Ejecuta el comando para respaldar la base de datos y luego iniciar la aplicación
CMD ["sh", "-c", "npm run dev"]