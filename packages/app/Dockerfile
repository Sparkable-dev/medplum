FROM node:22 AS builder
 
WORKDIR /app
COPY . .
 
ENV VITE_MEDPLUM_BASE_URL=https://medplum-production-4101.up.railway.app
 
RUN npm install --legacy-peer-deps
RUN npm install -g turbo rimraf
 
RUN npx turbo run build --filter=@medplum/app
 
 
FROM nginxinc/nginx-unprivileged:alpine
 
USER root
 
COPY <<EOF /etc/nginx/conf.d/default.conf
server {
    listen 3000;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;
 
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
 
    location / {
        try_files \$uri \$uri/ /index.html;
    }
 
    location /assets/ {
        expires 1y;
        add_header Cache-Control "public, no-transform";
    }
}
EOF
 
COPY --from=builder /app/packages/app/dist /usr/share/nginx/html
 
RUN chown -R 101:101 /usr/share/nginx/html
 
EXPOSE 3000
 
USER 101
 
CMD ["nginx","-g","daemon off;"]
