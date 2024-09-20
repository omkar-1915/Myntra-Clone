#stage 1
FROM node:alpine AS node

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

#stage 2
FROM node:alpine

WORKDIR /app

COPY --from=node /app .

RUN  npm run build

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
