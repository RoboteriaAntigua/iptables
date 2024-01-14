#!/usr/bin/bash

#Hay dos aplicaciones basadas en ICMP que se usan ampliamente: 
#Ping y Traceroute. Ping usa los mensajes ICMP Echo y Echo Reply 
#para determinar si un host se puede alcanzar. 
#Traceroute envía datagramas IP con valores bajos de TTL así que se 
#descartan en las rutas hacia el destino.



# Borrar todas las reglas del cortafuegos
    iptables -F

# Borrar reglas de nat
    iptables -t nat -F

# Reiniciar contadores
    iptables -Z
    iptables -t nat -Z

# Politica por defecto
# Denegar todo el trafico en las 3 cadenas
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Saber que interfaz es: (en esta pc usa wifi o sea wlp1s5)
# ip ad 

# Aceptar entrada y salida en una interfaz dada y protocolo icmp:
    # entrada:
        iptables -A INPUT -i wlp1s5 -p icmp -j ACCEPT
    # Salida:
        iptables -A OUTPUT -o wlp1s5 -p icmp -j ACCEPT

# Mostrar como quedan las cadenas:
 #sudo iptables -L -nv --line-numbers | cat

 # Podemos comprobar que los ping, si salen
  ping -c 4 8.8.8.8 | cat

# Un ping a un dns no responde
echo 'ping a google -------------------------------------------------------------¡'
 ping -c 4 www.google.com | cat