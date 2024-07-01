# FITHUB

## Estructura del Proyecto

La estructura del proyecto está organizada de la siguiente manera:

```bash
src
    ├───controllers
    │   ├───exercises
    │   ├───machines
    │   ├───memberships
    │   ├───trainers
    │   └───users
    ├───db
    │   └───config.js
    ├───middlewares
    │   └───authenticateUser.js
    ├───models
    │   ├───exercises
    │   ├───machines
    │   ├───memberships
    │   ├───trainers
    │   └───users
    ├───routes
    │   ├───exercises.js
    │   ├───machines.js
    │   ├───memberships.js
    │   ├───trainers.js
    │   └───users.js
    └───services
        ├───exercises
        ├───machines
        ├───memberships
        ├───trainers
        └───users
```
# Descripción de Carpetas y Archivos

## controllers
Contiene los controladores para manejar la lógica de negocio de las diferentes entidades como ejercicios, máquinas, membresías, entrenadores y usuarios.

## db
Incluye la configuración de la base de datos.

## config.js
Archivo de configuración para la conexión a la base de datos.

## middlewares
Contiene los middleware utilizados en la aplicación.

- **authenticateUser.js**: Middleware para autenticar usuarios.

## models
Contiene los modelos de datos para las diferentes entidades como ejercicios, máquinas, membresías, entrenadores y usuarios.

## routes
Define las rutas de la API y asocia cada ruta con su controlador correspondiente.

## services
Contiene los servicios que encapsulan la lógica de negocio y se comunican con los modelos de datos.


## Configuración y Ejecución Local

### Prerrequisitos
- Node.js
- npm

### Instalación
```bash
npm install
```
### Ejecución
```bash
npm run dev
```

## Configuración de CI/CD

El proyecto está configurado para usar GitHub Actions para CI/CD. La configuración incluye:

- **Compilación:** Instala dependencias y construye el proyecto.
- **Pruebas Unitarias:** Ejecuta pruebas usando jest.
- **Análisis de Código:** Realiza análisis de código estático con SonarCloud.
- **Despliegue en Producción:** Despliega automáticamente a GitHub Pages.

## Scripts y Configuraciones
Archivo de configuración: `.github/workflows/ci.yml`

## Contribución

### Clonar el Repositorio

```bash
git clone https://github.com/tu_usuario/tu_repositorio.git
```
### Crear una Rama
``` bash
git checkout -b feature/nueva-feature
```

### Realizar Cambios y Confirmar
```bash
git add .
git commit -m "Descripción de los cambios"
```
### Enviar Cambios
```bash
git push origin feature/nueva-feature
```
### Crear un Pull Request
Ve a la página de Pull Requests en GitHub y crea una nueva pull request.
