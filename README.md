# FITHUB

## Estructura del Proyecto

Descripción de la estructura de archivos y carpetas del proyecto.

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

### Scripts y Configuraciones

Archivo de configuración: `.github/workflows/ci.yml`


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
