FROM nginx:alpine

LABEL maintainer="Cloud DevOps Project"

COPY index.html /usr/share/nginx/html/index.html

COPY style.css /usr/share/nginx/html/style.css

EXPOSE 80

HEALTHCHECK --interval=30s \
  --timeout=5s \
  --start-period=10s \
  --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1

CMD ["nginx", "-g", "daemon off;"]