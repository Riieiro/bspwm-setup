#!/bin/bash

# Función para obtener la IP pública de la máquina
get_public_ip() {
    # Intentamos obtener la IP usando proxychains
    proxy_ip=$(proxychains curl -s http://api.ipify.org 2>/dev/null)
    
    # Si proxychains no está activado o no funciona, obtenemos la IP directa
    if [ -z "$proxy_ip" ]; then
        public_ip=$(curl -s http://api.ipify.org)
    else
        public_ip=$proxy_ip
    fi
}

# Función para obtener la geolocalización de la IP pública
get_location() {
    ip=$1
    # Hacemos la consulta a IP-API (en este caso usamos la URL pública sin autenticación)
    response=$(curl -s "http://ip-api.com/json/$ip")
    
    # Extraemos la ciudad y el país con jq
    city=$(echo $response | jq -r ".city")
    country=$(echo $response | jq -r ".country")
    
    # Verificamos si la respuesta contiene los datos
    if [ "$city" != "null" ] && [ "$country" != "null" ]; then
        echo " $ip/$city-$country"
    else
        echo " $ip"
    fi
}

# Ejecutamos la función para obtener la IP pública
get_public_ip

# Ejecutamos el script para la IP pública obtenida
get_location $public_ip
