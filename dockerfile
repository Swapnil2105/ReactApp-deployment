#node block

FROM node:alpine as nodework
WORKDIR /app
COPY package.json .
RUN npm install -g npm@latest
COPY . .
RUN npm run build


#nginx block
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=nodework /app/build .
ENTRYPOINT ["nginx","-g","daemon off;"]
