# Images Deep Dive

- First, make temporary folder
- Navigate to this folder,
- And, then git clone this repository: https://github.com/docker-hands-on-exercises/images-deep-dive-next

```bash
git clone https://github.com/docker-hands-on-exercises/images-deep-dive-next.git
```

## 01- The order of the commands in a Dockerfile is important

### Hello 01

Navigate to the `01-hello` folder
```bash
cd 01-hello
```

This is the `Dockerfile` of the web application:

> 👋 change the path of the image after the `FROM` command if you use your own private image registry.
```Dockerfile
FROM node:20.11.1-slim

WORKDIR /app
COPY . .
RUN npm install

EXPOSE 8080
CMD ["node", "index.js"]
```

#### First Build

**Build the image**: 

```bash
docker build -t hello-01 .
```

Launch the GUI of Docker Desktop:

> Go to the **Builds** view and click on the `01-hello` build
![build-01.png](./imgs/build-01.png)

> Click on the **Logs** tab:
![build-02.png](./imgs/build-02.png)

> Then you can see the the logs of the build
![build-03.png](./imgs/build-03.png)

#### Second build

Change something or add content in the source code of the `index.html` file.

**Build again the image**: 

```bash
docker build -t hello-01 .
```

If you go back to the GUI of Docker Desktop:

> You can see a new `01-hello` build
![build-04.png](./imgs/build-04.png)

> Click on it, and go to the **Logs** tab:
![build-05.png](./imgs/build-05.png)

- The logs are pretty similar to the previous logs
- The build time is not better

**Every time you change something in your project, everything at the build will be done again**.

### 02- The order of the commands in a Dockerfile is ALWAYS important

Navigate to the `02-hello` folder
```bash
cd 02-hello
```

This is the `Dockerfile` of the web application:

> 👋 change the path of the image after the `FROM` command if you use your own private image registry.
```Dockerfile
FROM node:20.11.1-slim

WORKDIR /app
COPY package.json ./
RUN npm install

COPY index.js index.html ./

EXPOSE 8080
CMD ["node", "index.js"]
```

- ✋ **I split the previous `COPY` command into 2 `COPY` commands**
- First, I copy the `package.json` file and run a `npm install`
- Then, I copy the source code of the application

#### First Build

**Build the image**: 

```bash
docker build -t hello-02 .
```

Launch the GUI of Docker Desktop:

> You can see a new `02-hello` build
![build-06.png](./imgs/build-06.png)

> Click on it, and go to the **Logs** tab:
![build-07.png](./imgs/build-07.png)

You can see all the logs of the build

#### Update the source code and run the second build

Change something or add content in the source code of the `index.html` file.

**Build again the image**: 

```bash
docker build -t hello-02 .
```

If you go back to the GUI of Docker Desktop:

> You can see a new `02-hello` build
![build-08.png](./imgs/build-08.png)

**✋ you can see that it is a lot faster than the previous one**.

> Click on it, and go to the **Logs** tab:
![build-09.png](./imgs/build-09.png)

**✋ you can see that all the layers related to the dependencies are in the cache**.

> Go to the **Histroy** tab to get a graphical view of the progress of the builds:
![build-10.png](./imgs/build-10.png)

## 