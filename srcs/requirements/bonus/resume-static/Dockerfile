FROM debian:12-slim
# i use the slim version bcause it is lighter and faster to build

ARG DB_NAME

RUN apt update
RUN apt upgrade
RUN apt install -y pandoc nodejs npm
# -y : yes to all questions

WORKDIR /app

COPY resume/ ./

RUN npm install && npm install -g http-server && npm run build-sass && npm run build-html

RUN cat > index.html << 'EOF' 
<html><a href="public/">Access to documents</a></html>
EOF

CMD ["http-server", ".", "-p", "8080"]