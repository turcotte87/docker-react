#Pour image de production
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

#Les fichiers de productions vont etre dans /app/build

FROM nginx
#je veux copier quelque chose de ma phase suivante. Le premier / est pour l,image builder et le deuxieme / est pour l'image nginx. 
#Le path a coller dans nginx provient de la documentation de l'image nginx dans docker hub.
COPY --from=builder /app/build /usr/share/nginx/html
