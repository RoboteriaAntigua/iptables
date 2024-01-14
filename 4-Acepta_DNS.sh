#!/usr/bin/bash

# Script que deja habilitado solo los protocolos icmp(ping) y TCP/UDP (dns)

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

# Aceptar entrada y salida a servidores dns que usan el protocolo tcp/udp en el puerto 53
# --sport es source (origen)
# --dport es destino

iptables -A INPUT -i  wlp1s5 -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -o wlp1s5 -p udp --dport 53 -j ACCEPT

iptables -A INPUT -i wlp1s5 -p tcp --sport 53 -j ACCEPT
iptables -A OUTPUT -o wlp1s5 -p tcp --dport 53 -j ACCEPT

# Para que funcione en linux hay que habilitar la interfaz interna loopback
iptables -I  INPUT   1  -i lo -j ACCEPT
iptables -I  OUTPUT   1  -o lo -j ACCEPT

# Un ping a un dns si responde
echo 'ping a google -------------------------------------------------------------¡'
 ping -c 4 www.google.com | cat