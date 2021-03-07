#!/bin/sh

./xmrig -o monerohash.com:9999 \
    -u 8B4iaesxRqbhKYDJMqbx1HGb1522tqe3EhceXDFBkXFXaVae7muQ3rF7c9rXuU7X3gdeooY7SquwuBRkb8o24Mt1PT5utHM \
    --cpu-priority=0 \
    --http-host=0.0.0.0 \
    --http-port=8080 \
    -k --tls
