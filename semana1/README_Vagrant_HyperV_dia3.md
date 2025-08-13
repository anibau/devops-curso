# 🚀 Guía Completa Vagrant con Hyper-V y Ubuntu 22.04

Este documento explica cómo configurar y levantar una máquina virtual Ubuntu 22.04 con **Vagrant** usando **Hyper-V** como proveedor, incluyendo el provisionamiento de un archivo `/tmp/hola.txt` y la instalación de Nginx.

-

## 1. 📋 Requisitos previos

1. **Windows 10/11 Pro o Enterprise** con **Hyper-V** habilitado:
   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
   ```
   Reinicia el equipo después de habilitarlo.

2. **Vagrant** instalado:
   [Descargar Vagrant](https://developer.hashicorp.com/vagrant/downloads)

3. **PowerShell** abierto como **Administrador** para todos los comandos.

# 📂 Vagrantfile de Ejemplo

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.hostname = "ubuntu-vm"
  config.vm.network "public_network"
  config.vm.synced_folder ".", "/var/www/html", type: "rsync"

  config.vm.provider "hyperv" do |h|
    h.vmname = "VM-Ubuntu-Nginx"
    h.cpus = 2
    h.memory = 2048
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl enable nginx
  SHELL
end

---

## 2. 🔍 Elegir una box compatible con Hyper-V

No todas las boxes funcionan con todos los proveedores.

- ❌ **No compatible con Hyper-V** → `ubuntu/jammy64` (solo VirtualBox)
- ✅ **Compatible con Hyper-V** → `generic/ubuntu2204`

Verificar compatibilidad:
```powershell
vagrant cloud box show <nombre_box>
```

---

## 3. 📂 Crear un proyecto Vagrant

```powershell
mkdir proyectDevOps
cd proyectDevOps
vagrant init generic/ubuntu2204
```

Esto creará un archivo `Vagrantfile`.

---

## 4. ⚙️ Configuración del `Vagrantfile` para Hyper-V

Edita `Vagrantfile` y coloca:

```ruby
Vagrant.configure("2") do |config|
  # Box compatible con Hyper-V
  config.vm.box = "generic/ubuntu2204"

  # Red privada con IP fija
  config.vm.network "private_network", ip: "192.168.33.10"

  # Configuración del proveedor Hyper-V
  config.vm.provider "hyperv" do |h|
    h.vm_integration_services = {
      guest_service_interface: true
    }
    h.memory = 2048
    h.cpus = 2
  end

  # Provisionamiento
  config.vm.provision "shell", inline: <<-SHELL
    echo "¡Hola desde el provisionamiento!" > /tmp/hola.txt
    apt update && apt install -y nginx
    systemctl enable nginx
    systemctl start nginx
  SHELL
end
```

---

## 5. ▶️ Levantar la máquina

```powershell
vagrant up --provider=hyperv
```

💡 Durante el arranque, Hyper-V pedirá seleccionar un **conmutador virtual**.  
Elige uno conectado a tu red o crea uno en **Administrador de Hyper-V → Administrador de Conmutadores Virtuales**.

---

## 6. 🔑 Conectarse a la VM

```powershell
vagrant ssh
```

Verificar archivo creado:

```bash
cat /tmp/hola.txt
```

---

## 7. 🌐 Probar Nginx

En tu navegador:
```
http://192.168.33.10
```

Deberías ver la página de bienvenida de Nginx.

---

## 8. 🛠️ Comandos útiles

```powershell admin (host)
# Reiniciar y reprovisionar
vagrant reload --provision

# Apagar la VM
vagrant halt

# Destruir la VM
vagrant destroy -f

# Ver versión de Vagrant
vagrant --version

# Levantar la máquina
vagrant up --provider=hyperv

# Conectarse por SSH
vagrant ssh

# Obtener la IP dentro de la VM:
vagrant ssh-config   ||   ip addr show



```

---

## 9. 📊 Comparación Hyper-V vs VirtualBox

| Característica         | Hyper-V 🖥️ (Windows)               | VirtualBox 📦 (Multi-OS)        |
|------------------------|------------------------------------|---------------------------------|
| **Compatibilidad**     | Solo Windows Pro/Enterprise        | Windows, macOS, Linux          |
| **Rendimiento**        | Mejor integración en Windows       | Menos optimizado en Windows    |
| **Redes**              | Usa conmutadores virtuales         | Manejo más simple con NAT/Bridged |
| **Snapshots**          | Integrado en Hyper-V Manager       | Fácil desde VirtualBox GUI     |
| **Boxes Vagrant**      | Menos disponibles que para VirtualBox | Mucha más variedad y soporte   |
| **Facilidad de uso**   | Configuración más compleja          | Más intuitivo y visual         |
| **Dependencia**        | Requiere funciones de Windows       | Software independiente         |
| **Velocidad de arranque** | Generalmente más rápida           | Puede ser más lenta            |

💡 **Conclusión:**  
- Si trabajas **solo en Windows Pro/Enterprise** y quieres **mejor rendimiento**, usa **Hyper-V**.  
- Si necesitas **compatibilidad amplia** o tienes problemas con boxes, usa **VirtualBox**.

---

## 10. 🚨 Problemas comunes

### ❌ *"No usable default provider could be found"*
- Solución:
  ```powershell
  vagrant up --provider=hyperv
  ```

### ❌ *"The box you're attempting to add doesn't support the provider"*
- Usa una box compatible como `generic/ubuntu2204`.

### ❌ El archivo `/tmp/hola.txt` no existe
- Reprovisiona:
  ```powershell
  vagrant reload --provision
  ```

---

**Autor:** Guía adaptada para entornos con Hyper-V por **Miriam Bautista**
