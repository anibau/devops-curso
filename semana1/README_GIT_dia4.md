
 ###   Instalación y Configuración

# Instalar Git en tu sistema
# Visita: https://git-scm.com/downloads

# Configurar tu nombre de usuario y email
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"


###  Crear tu Primer Repositorio

# Crear nueva carpeta e inicializar repositorio Git
mkdir git-proyecto && cd git-proyecto
git init

# Crear archivos iniciales
touch index.html style.css
git add .
git commit -m "Commit inicial"

### Realizar Cambios y Commit

# Modificar index.html y verificar cambios
git status
git diff
git add index.html
git commit -m "Actualizado index.html"


### Verificar Historial

# Verificar historial de commits
git log --oneline

### Conectar con GitHub

# Crear repositorio en GitHub, agregar remoto y push
git remote add origin https://github.com/tuusuario/git-proyecto.git
git branch -M main
git push -u origin main

### RAMAS-BRANCH

# Crear y cambiar a nueva branch
git checkout -b feature-branch

# Verificar branch activa
git branch

# Hacer cambios
echo "Nueva funcionalidad agregada!" > feature.txt
git add feature.txt
git commit -m "Agregado feature.txt con nueva funcionalidad"

# Push de la nueva branch
git push origin feature-branch

### RAMAS- MERGE

# Cambiar a main
git checkout main

# Asegurar que main esté actualizado
git pull origin main

# Fusionar feature-branch
git merge feature-branch

# Push de los cambios fusionados
git push origin main

# Eliminar branch (opcional)
git branch -d feature-branch
git push origin --delete feature-branch

### RESET

# Eliminar último commit pero mantener cambios
git reset --soft HEAD~1

# Eliminar último commit y descartar cambios
git reset --hard HEAD~1

### REVERT

# Ver historial y obtener hash del commit
git log --oneline

# Revertir commit específico
git revert <commit-hash>