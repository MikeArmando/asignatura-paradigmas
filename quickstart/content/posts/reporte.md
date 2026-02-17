+++
date = '2026-02-13T18:06:33-08:00'
draft = false
title = 'Reporte'

[header]
  featured = true
summary = "Proyecto de la asignatura de paradigmas de la programación."
+++

# REPORTE

Link de portafolio en GitHub: [Asignatura Paradigmas](https://github.com/MikeArmando/asignatura-paradigmas)

Link de portafolio en GitHub Pages (página estática): [Asignatura Paradigmas](https://github.com/MikeArmando/asignatura-paradigmas)

# 1. ¿Qué es Git y GitHub?
Aunque suelen mencionarse juntos, cumplen funciones distintas pero complementarias:

- Git: Es un sistema de control de versiones local. Como una "máquina del tiempo" para el código. Permite guardar capturas (commits) de proyecto, permitiéndo regresar a versiones anteriores si algo sale mal.

- GitHub: Es una plataforma de alojamiento en la nube que utiliza Git. Es donde se guarda los proyectos para que otros los vean, colaboren o simplemente para tener un respaldo seguro fuera de la computadora.

# 2. Comandos Esenciales de Git
Para dominar Git, primero se debe entender el flujo de trabajo básico. Estos son los comandos mas usados:

- `git init` Inicializa un nuevo repositorio de Git en tu carpeta local.
- `git clone [URL]` Descarga un proyecto existente desde la nube a tu PC.
- `git status` Te dice qué archivos has modificado y cuáles están listos para guardarse.
- `git add [archivo]` Prepara los archivos (los pone en el Staging Area) para el siguiente paso.
- `git commit -m "mensaje"` Guarda permanentemente los cambios con un comentario descriptivo.
- `git branch -M main` Cambia el nombre de la rama principal a "main" (estándar actual).
- `git remote add origin [URL]` Conecta tu repositorio local con tu repositorio en GitHub.
- `git push -u origin main` Sube tus cambios locales a la nube (GitHub).

# 3. Cómo crear un repositorio y subirlo a la nube
**Paso A: En GitHub**
1. Inicia sesión en tu cuenta de GitHub.
2. Hazcl ic en el botón "+" (arriba a la derecha) y selecciona New repository.
3. Ponle un nombre a tu proyecto y haz clic en Create repository.
4. Copia la URL que te aparece (ejemplo: https://github.com/tu-usuario/tu-proyecto.git).

**Paso B: En computadora (Terminal o CMD)**
1. Inicializar: git init
2. Preparar archivos: git add . (El punto significa "todos los archivos").
3. Primer guardado local: git commit -m "Mi primer commit"
4. Conectar con la nube: git remote add origin https://github.com/tu-usuario/tu-proyecto.git
5. Subir la información: git push -u origin main

# 4. ¿Qué es Hugo y GitHub Actions?
Para publicar una web hoy en día, no se necesitas un servidor complejo. Solo se ocupa de estas dos herramientas:

- Hugo: Es un Generador de Sitios Estáticos (SSG). Escribes contenido en lenguaje sencillo (Markdown), y Hugo lo transforma instantáneamente en una página web profesional (HTML/CSS) extremadamente rápida.

- GitHub Actions: Es un motor de automatización. Permite ejecutar "recetas" (workflows) cada vez que subes código. En este caso, le diremos: "Oye, cada vez que suba un cambio, usa Hugo para construir mi web y publícala en internet".

# 5. Crear un sitio estático con Hugo
1. Instalar Hugo: (Depende de tu sistema, ej. brew install hugo o descargando el binario).
2. Crear el sitio: `hugo new site mi-blog` `cd mi-blog`
3. Añadir un tema: `git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke`
4. Crear primer post: `hugo new posts/mi-primer-post.md`
5. Verlo en vivo localmente: `hugo server -D` y entra a localhost:1313.

# 6. Subir la información a GitHub
1. Crea un archivo llamado `.gitignore` en la raíz y escribe dentro: `/public`.

# 7. Configurar GitHub Actions para publicar en GitHub Pages
**Paso 1: Crear el archivo de Workflow**
En tu carpeta del proyecto, crea esta ruta de carpetas: `.github/workflows/` y dentro crea un archivo llamado `hugo.yaml`.

**Paso 2: El contenido del Workflow**
Copia una plantilla oficial de Hugo para GitHub Actions. Básicamente, este archivo le dice a GitHub:
- Usa Ubuntu.
- Instala Hugo.
- Ejecuta el comando hugo.
- Toma el resultado y súbelo a GitHub Pages

**Paso 3: Configuración en el Navegador (GitHub.com)**
1. Ve a tu repositorio en GitHub.
2. Haz clic en Settings (Configuración) > Pages.
3. En la sección Build and deployment, cambia la fuente (Source) de "Deploy from a branch" a "GitHub Actions".