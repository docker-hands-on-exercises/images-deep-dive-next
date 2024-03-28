# Images Deep Dive

- First, make temporary folder
- Navigate to this folder,
- And, then git clone this repository: https://github.com/docker-hands-on-exercises/images-deep-dive-next

```bash
git clone https://github.com/docker-hands-on-exercises/images-deep-dive-next.git
```

## 01- Optimize the size of the images

We want to install Python, Pip and Flask on Ubuntu

### First build

Navigate to the `00-layers` folder
```bash
cd 00-layers
```

This is the first `Dockerfile`: `Dockerfile.one`

> 👋 change the path of the image after the `FROM` command if you use your own private image registry.
```Dockerfile
FROM ubuntu
RUN apt update
RUN apt install -y python3 python3-pip
RUN pip install flask
RUN apt autoremove --purge -y python3-pip
RUN rm -f /var/lib/lists
```

**Build the image**: 

```bash
docker build -t hello-python:one -f Dockerfile.one . 
```

> Go to the **Builds** view and click on the `00-layers/Dockerfile.one` build
![size-01.png](./imgs/size-01.png)

> There is a layer per `RUN` command
![size-02.png](./imgs/size-02.png)
> Check the size of the image in the **Images** section

The layers related to the installation are already created. So, the "purge" layer is useless.

Now, let's try with another `Dockerfile`

### Second build

This is the second `Dockerfile`: `Dockerfile.two`

> 👋 change the path of the image after the `FROM` command if you use your own private image registry.
```Dockerfile
FROM ubuntu
RUN apt update && \
    apt install -y python3 python3-pip && \
    pip install flask && \
    apt autoremove --purge -y python3-pip && \
    rm -f /var/lib/lists
```
**✋ this time we used only one `RUN` command**

**Build the image**: 

```bash
docker build -t hello-python:two -f Dockerfile.two . 
```

> Go to the **Builds** view and click on the `00-layers/Dockerfile.two` build
![size-03.png](./imgs/size-03.png)

> There is only one `RUN` layer
![size-04.png](./imgs/size-04.png)
> Check the size of the image in the **Images** section

![size-05.png](./imgs/size-05.png)

We run all the installation steps, and then the purge step, and than the layer was created. It's why we gained some space.


## 02- Accelerate the build of the images

> The order of the commands in a Dockerfile is important

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

### Hello 02

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

## 03- Multi-stage builds

