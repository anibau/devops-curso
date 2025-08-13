###  ¿Qué es un script Bash?
Es un archivo de texto con instrucciones que ejecutás en una terminal Linux, como si las escribieras vos misma.

# ejemplo minimo
#!/bin/bash
echo "Hola Roxs DevOps!"

# Guardalo, dale permisos y ejecutalo
chmod +x hola.sh
./hola.sh

### Condicionales comunes en Bash

# Estructura	Explicación
if ...; then ...	   Ejecuta si se cumple la condición
else	               Ejecuta si no se cumple
elif	               Evalúa una condición alternativa
[ "$a" == "$b" ]	   Compara cadenas
[ $a -gt 5 ]	       Mayor que (números)
[ -f archivo ]	       ¿Existe el archivo?
[ -d carpeta ]	       ¿Existe el directorio?

###  Bucles útiles
# Bucle FOR
for i in {1..5}; do
  echo "Número: $i"
done

# Bucle WHILE
contador=1
while [ $contador -le 3 ]; do
  echo "Contador: $contador"
  ((contador++))
done

### Buenas prácticas
- Usá #!/bin/bash siempre en la primera línea
- Usá set -e para salir si ocurre un error
- Comentá tu código con #
- Probá scripts en entornos controlados (como Vagrant o online)