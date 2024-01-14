#!/user/bin/bash

#Script que borra todas las reglas y re acepta todo

# Borrar todas las reglas del cortafuegos
    iptables -F

# Borrar reglas de nat
    iptables -t nat -F

# Reiniciar contadores
    iptables -Z
    iptables -t nat -Z




# Politica por defecto
# Aceptar todo el trafico en las 3 cadenas
iptables -P INPUT   ACCEPT
iptables -P OUTPUT  ACCEPT
iptables -P FORWARD ACCEPT

# Mostrar como quedan las cadenas:
 sudo iptables -L -nv --line-numbers | cat

# Mostrar las cadenas de nat (network adress translation)
sudo iptables -t nat -L -nv --line-numbers