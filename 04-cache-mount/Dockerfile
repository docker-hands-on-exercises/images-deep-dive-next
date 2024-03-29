FROM node:20.11.1-slim

WORKDIR /app
COPY package.json ./
# If I change something in the dependencies, il will reload every thing
# -> "redis": "^4.6.13"
#RUN npm install
RUN --mount=type=cache,target=/root/.npm npm install

COPY index.js index.html ./

EXPOSE 8080
CMD ["node", "index.js"]


