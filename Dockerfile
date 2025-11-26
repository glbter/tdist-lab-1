FROM --platform=${BUILDPLATFORM} nginx:latest
COPY src /usr/share/nginx/html
