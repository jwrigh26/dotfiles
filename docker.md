# Docker on Fedora — Install & Quick Start

This tutorial covers:

- Installing Docker on Fedora (and a Podman alternative)
- Running the official hello-world container
- Building/running a tiny "Hello HTTP" Docker image (Python)
- Spinning up MongoDB in Docker and interacting with it from the host

## Prerequisites

- A Fedora machine with sudo access
- Internet access to download packages and container images

---

## 1. Install Docker on Fedora 41+

> **Note:** Fedora 41+ provides Docker CLI and containerd directly in the official repositories. Fedora still prefers Podman as the default container engine, but Docker is available without adding third-party repos.

### Install Docker CLI and containerd

```bash
sudo dnf install docker-cli containerd
```

### Install Docker Compose (as a plugin)

This provides Compose v2 features and capabilities:

```bash
sudo dnf install docker-compose
```

### Optional: Install docker-compose command-line compatibility

If you want `docker-compose` on the command line (legacy v1 syntax support):

```bash
sudo dnf install docker-compose-switch
```

### Enable and start the Docker daemon

```bash
sudo systemctl enable --now docker
```

### Add your user to the docker group

This allows you to run `docker` without `sudo` (log out and log back in after running this):

```bash
sudo usermod -aG docker $USER
```

### Alternative: Install Podman (Fedora's default)

If you prefer Podman (rootless, Fedora's default container engine):

```bash
sudo dnf -y install podman podman-docker
```

Podman supports many `docker` commands. For this guide the `docker` CLI is used, but most commands below will work with `podman` too.

---

## 2. Quick Check — Hello World

Run the official smoke-test image:

```bash
docker run --rm hello-world
```

If you see a **"Hello from Docker!"** message, Docker is working correctly.

---

## 3. Build and Run a Tiny "Hello HTTP" App (Python)

Create two files in an empty directory: `Dockerfile` and `app.py`.

### `app.py`

```python
from http.server import SimpleHTTPRequestHandler, HTTPServer

class Handler(SimpleHTTPRequestHandler):
    pass

if __name__ == '__main__':
    server = HTTPServer(('0.0.0.0', 8000), Handler)
    print('Serving on 0.0.0.0:8000')
    server.serve_forever()
```

### `Dockerfile`

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY app.py .
EXPOSE 8000
CMD ["python3", "app.py"]
```

### Build and run the image

```bash
docker build -t simple-http .
docker run --rm -p 8000:8000 simple-http
```

### Test from another terminal

```bash
curl http://localhost:8000
```

You should see a small directory listing or response from the server. Stop the container with `Ctrl+C` in the terminal where it's running.

---

## 4. MongoDB Example: Run MongoDB in Docker and Test

### Start a MongoDB container

Start MongoDB with a root user and mapped port so you can connect from your host:

```bash
docker run --name mongo-demo -d \
  -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=secret \
  mongo:6.0
```

### Check container logs while it starts

```bash
docker logs -f mongo-demo
```

### Connect using the MongoDB shell inside the container

```bash
docker exec -it mongo-demo mongosh -u admin -p secret --authenticationDatabase admin
```

Inside the shell you can run a quick test:

```javascript
use testdb
db.items.insertOne({hello: 'world'})
db.items.find().pretty()
```

### Alternative: Test with a Python script from your host

Create `mongo_test.py` in a directory:

```python
from pymongo import MongoClient

client = MongoClient("mongodb://admin:secret@localhost:27017/?authSource=admin")
db = client.testdb
res = db.items.insert_one({"hello": "from python"})
print('Inserted', res.inserted_id)
print(list(db.items.find()))
```

Run it using Docker's Python image (no Python installation required on host):

```bash
docker run --rm -v "$PWD":/app -w /app python:3.11 bash -c "pip install pymongo && python mongo_test.py"
```

---

## Notes and Troubleshooting

- **Permission errors:** If you added your user to the `docker` group and still get permission errors, log out and log back in (or reboot).
- **SELinux:** If you mount host volumes into containers and see permission-denied errors, you may need to add `:z` or `:Z` to the volume flag or adjust SELinux context.  
  Example: `-v /host/path:/container/path:Z`
- **Podman users:** `podman run` works similarly to `docker run` but there are small differences (rootless networking, host mapping). If you used `podman-docker`, the `docker` CLI will forward to podman.

---

## Cleanup

### Stop and remove the MongoDB container

```bash
docker stop mongo-demo && docker rm mongo-demo
```

### Remove the simple-http image (optional)

```bash
docker image rm simple-http
```

---

## Next Steps (Suggestions)

- Add a `docker-compose.yml` that starts both your app and MongoDB for development
- Convert the `simple-http` example into a multi-stage build or add a small unit test
- If you use Fedora Server with firewall enabled, remember to allow ports:
  ```bash
  sudo firewall-cmd --add-port=27017/tcp --permanent && sudo firewall-cmd --reload
  ```
