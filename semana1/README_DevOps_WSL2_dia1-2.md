# Guía de Instalación y Configuración para Entorno DevOps en Windows con Linux (WSL2)

Este documento recopila los pasos, configuraciones y solución de errores vistos durante la instalación y uso de herramientas DevOps en Windows, utilizando **WSL2**, **Ubuntu**, **Apache**, **Vagrant**, y configuraciones de virtualización.

---

## 1. Activar Virtualización en BIOS
- Entrar al **BIOS/UEFI** de tu laptop (tecla F2, F1 o Supr al encender).
- Buscar y habilitar:
  - `Intel(R) Virtualization Technology`
  - `VT-x` o `SVM` (según procesador Intel/AMD)
- Guardar y reiniciar.

---

## 2. Instalar y Configurar WSL2 + Ubuntu

### Verificar si la virtualización está activa
En **PowerShell**:
```powershell
systeminfo | find "Virtualization"
```

### Habilitar características necesarias
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

### Instalar Ubuntu desde Microsoft Store
1. Abrir Microsoft Store.
2. Buscar `Ubuntu` (versión 22.04 LTS recomendada).
3. Instalar y abrir.

> **Error común**: Al pedir `username`, no acepta mayúsculas ni caracteres especiales.  
> **Solución**: usar solo minúsculas, números y guiones bajos.
> Ejemplo válido:  
> ```
> miriam_bt
> ```

---

## 3. Comandos básicos de permisos en Linux
- Dar permisos completos al usuario:
```bash
chmod u=rwx,g=rx,o= archivo.txt
```
Significado:
- **u** → usuario
- **g** → grupo
- **o** → otros
- **r** lectura, **w** escritura, **x** ejecución

---

## 4. Instalar y Configurar Apache en Ubuntu (WSL2)
```bash
sudo apt update
sudo apt install apache2 -y
```

Verificar estado:
```bash
sudo systemctl status apache2
```

Archivos por defecto:
```
/var/www/html/index.html
```

Reemplazar por tu propio HTML:
```bash
sudo nano /var/www/html/index.html
```

---

## 5. Acceso desde otros dispositivos en la misma red
### Ver IP local de tu PC:
```powershell
ipconfig
```
Ejemplo:
```
Dirección IPv4: 192.168.7.53
```
Luego desde otro dispositivo:
```
http://192.168.7.53/
```

---

## 6. Habilitar firewall y puertos
Instalar y configurar UFW en Ubuntu:
```bash
sudo apt install ufw -y
sudo ufw allow 80/tcp
sudo ufw allow 22/tcp
sudo ufw enable
```

---

## 7. Instalación de Vagrant

### Opción A: Usar Hyper-V (Windows Pro/Enterprise)
En **PowerShell (Administrador)**:
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

### Opción B: Usar VirtualBox
Descargar desde:
- [https://www.virtualbox.org](https://www.virtualbox.org)

### Descargar Vagrant (Windows 64-bit)
- Ir a: [https://developer.hashicorp.com/vagrant/downloads](https://developer.hashicorp.com/vagrant/downloads)
- Elegir: **Windows (64-bit, AMD64)**

Verificar:
```powershell
vagrant --version
```

---

### Comandos esenciales de Vagrant
vagrant up	: Inicia la máquina virtual
vagrant ssh	: Conectarse via SSH (necesita cliente como Git Bash)
vagrant halt	: Apagar la VM
vagrant destroy	: Eliminar la VM completamente
vagrant reload --provision	: Reiniciar y re-ejecutar provisionamiento

## 8. Solución a errores comunes

| Error | Causa | Solución |
|-------|-------|----------|
| `Package 'vagrant' has no installation candidate` | El paquete no está en los repos de Ubuntu | Descargar `.deb` oficial desde la web de Vagrant |
| `Please enter a username matching the regular expression` | Nombre de usuario no válido en Ubuntu | Usar minúsculas y guiones bajos (`miriam_bt`) |
| `curl ifconfig.me` no carga HTML | Apache no tiene tu archivo en `/var/www/html` o el firewall bloquea el puerto | Reemplazar `index.html` y abrir el puerto 80 |
| `sudo: ufw: command not found` | Firewall no instalado | `sudo apt install ufw -y` |

---

## 9. Comando útil para ver IP pública
```bash
curl ifconfig.me
```

---

## 10. Grabación de pantalla en Linux
Instalar `OBS Studio`:
```bash
sudo apt install obs-studio -y
```

O grabar con `simplescreenrecorder`:
```bash
sudo apt install simplescreenrecorder -y
```

---

## Referencias
- [Documentación WSL2](https://learn.microsoft.com/windows/wsl/)
- [Apache HTTP Server](https://httpd.apache.org/)
- [Vagrant Docs](https://developer.hashicorp.com/vagrant/docs)
