server_names_hash_bucket_size 64;

  server {
     listen       443 ssl;

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_session_timeout 5m;
        ssl_session_cache shared:SSL:50m;
        ssl_session_tickets off;
        ssl_certificate /certs/fullchain.pem;
        ssl_certificate_key /certs/key.pem;
        ssl_dhparam /certs/dhparam.pem;

    root /usr/share/jitsi-meet;
    index  index.html;
    access_log /www/logs/nginx/access.log specialLog;
    error_log /www/logs/nginx/error.log;
    
    location ~ ^/([a-zA-Z0-9=\?]+)$ {
        rewrite ^/(.*)$ / break;
    }

      location /config.js {
        alias /etc/jitsi/meet/<VIRTUAL_HOST>-config.js;
    }  
    
    location / {
        ssi on;
    }
    # BOSH
    location /http-bind {
        proxy_pass      http://localhost:5280/http-bind;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $http_host;
    }

    # xmpp websockets
    location /xmpp-websocket {
        proxy_pass http://localhost:5280/xmpp-websocket;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        tcp_nodelay on;
    }
}

