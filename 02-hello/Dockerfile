FROM node:20.11.1-slim

WORKDIR /app
COPY package.json ./
RUN npm install

COPY index.js index.html ./

EXPOSE 8080
CMD ["node", "index.js"]


