# Docker Commands Reference

A comprehensive guide to the most common Docker commands and their flags.

---

## Table of Contents

- [Container Management](#container-management)
- [Image Management](#image-management)
- [Build Commands](#build-commands)
- [Network Commands](#network-commands)
- [Volume Commands](#volume-commands)
- [Docker Compose](#docker-compose)
- [System & Cleanup](#system--cleanup)
- [Logs & Debugging](#logs--debugging)

---

## Container Management

### `docker run` — Create and start a container

```bash
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `--rm` | Automatically remove the container when it exits |
| `-d, --detach` | Run container in background and print container ID |
| `-it` | Interactive terminal (`-i` keeps STDIN open, `-t` allocates a pseudo-TTY) |
| `-p, --publish` | Publish container port to host: `-p 8080:80` (host:container) |
| `-e, --env` | Set environment variables: `-e VAR=value` |
| `--name` | Assign a name to the container |
| `-v, --volume` | Bind mount a volume: `-v /host/path:/container/path` |
| `-w, --workdir` | Working directory inside the container |
| `--network` | Connect container to a network |
| `--restart` | Restart policy: `no`, `on-failure`, `always`, `unless-stopped` |
| `--entrypoint` | Override the default entrypoint |
| `--user` | Username or UID (format: `<name|uid>[:<group|gid>]`) |
| `--privileged` | Give extended privileges to this container |
| `--read-only` | Mount the container's root filesystem as read only |
| `--memory` | Memory limit (e.g., `--memory=512m`) |
| `--cpus` | Number of CPUs (e.g., `--cpus=2`) |

**Examples:**

```bash
# Run nginx in background, map port 8080 to 80
docker run -d -p 8080:80 --name my-nginx nginx

# Run interactive Ubuntu shell
docker run -it --rm ubuntu:22.04 /bin/bash

# Run with environment variables
docker run -e DATABASE_URL=postgres://localhost:5432 myapp

# Run with volume mount (SELinux systems add :Z)
docker run -v /home/user/data:/data:Z myapp

# Run with restart policy
docker run -d --restart=unless-stopped redis
```

---

### `docker ps` — List containers

```bash
docker ps [OPTIONS]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-a, --all` | Show all containers (default shows just running) |
| `-q, --quiet` | Only display container IDs |
| `-s, --size` | Display total file sizes |
| `--filter` | Filter output based on conditions (e.g., `--filter "status=exited"`) |
| `--format` | Pretty-print containers using a Go template |

**Examples:**

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# List only container IDs
docker ps -q

# Filter by status
docker ps --filter "status=exited"
```

---

### `docker stop` — Stop running container(s)

```bash
docker stop [OPTIONS] CONTAINER [CONTAINER...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-t, --time` | Seconds to wait before killing the container (default 10) |

**Examples:**

```bash
# Stop a container
docker stop my-nginx

# Stop multiple containers
docker stop container1 container2

# Stop all running containers
docker stop $(docker ps -q)
```

---

### `docker start` — Start stopped container(s)

```bash
docker start [OPTIONS] CONTAINER [CONTAINER...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-a, --attach` | Attach STDOUT/STDERR and forward signals |
| `-i, --interactive` | Attach container's STDIN |

**Examples:**

```bash
# Start a stopped container
docker start my-nginx

# Start and attach to container
docker start -a my-nginx
```

---

### `docker restart` — Restart container(s)

```bash
docker restart [OPTIONS] CONTAINER [CONTAINER...]
```

**Examples:**

```bash
docker restart my-nginx
```

---

### `docker rm` — Remove container(s)

```bash
docker rm [OPTIONS] CONTAINER [CONTAINER...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-f, --force` | Force removal of running container |
| `-v, --volumes` | Remove anonymous volumes associated with the container |

**Examples:**

```bash
# Remove a stopped container
docker rm my-nginx

# Force remove a running container
docker rm -f my-nginx

# Remove all stopped containers
docker rm $(docker ps -aq --filter "status=exited")
```

---

### `docker exec` — Execute command in running container

```bash
docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-d, --detach` | Run command in background |
| `-i, --interactive` | Keep STDIN open |
| `-t, --tty` | Allocate a pseudo-TTY |
| `-e, --env` | Set environment variables |
| `-w, --workdir` | Working directory inside the container |
| `-u, --user` | Username or UID |

**Examples:**

```bash
# Get a shell in a running container
docker exec -it my-nginx /bin/bash

# Run a command and see output
docker exec my-app ls -la /app

# Run as a specific user
docker exec -u postgres my-db psql -U postgres
```

---

### `docker logs` — Fetch container logs

```bash
docker logs [OPTIONS] CONTAINER
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-f, --follow` | Follow log output (like `tail -f`) |
| `--tail` | Number of lines to show from the end (e.g., `--tail 100`) |
| `-t, --timestamps` | Show timestamps |
| `--since` | Show logs since timestamp (e.g., `--since 2023-01-01` or `--since 10m`) |
| `--until` | Show logs before a timestamp |

**Examples:**

```bash
# View logs
docker logs my-nginx

# Follow logs in real-time
docker logs -f my-nginx

# Show last 50 lines with timestamps
docker logs --tail 50 -t my-nginx

# Show logs from last 5 minutes
docker logs --since 5m my-nginx
```

---

### `docker inspect` — Display detailed container/image info

```bash
docker inspect [OPTIONS] NAME|ID [NAME|ID...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-f, --format` | Format output using a Go template |

**Examples:**

```bash
# Inspect container
docker inspect my-nginx

# Get IP address
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-nginx

# Get all environment variables
docker inspect -f '{{.Config.Env}}' my-nginx
```

---

## Image Management

### `docker images` — List images

```bash
docker images [OPTIONS] [REPOSITORY[:TAG]]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-a, --all` | Show all images (including intermediate) |
| `-q, --quiet` | Only show image IDs |
| `--filter` | Filter output (e.g., `--filter "dangling=true"`) |
| `--format` | Pretty-print using a Go template |

**Examples:**

```bash
# List all images
docker images

# List only image IDs
docker images -q

# List dangling images (untagged)
docker images --filter "dangling=true"
```

---

### `docker pull` — Pull image from registry

```bash
docker pull [OPTIONS] NAME[:TAG|@DIGEST]
```

**Examples:**

```bash
# Pull latest version
docker pull nginx

# Pull specific version
docker pull nginx:1.25

# Pull from specific registry
docker pull ghcr.io/user/repo:tag
```

---

### `docker push` — Push image to registry

```bash
docker push [OPTIONS] NAME[:TAG]
```

**Examples:**

```bash
# Push to Docker Hub
docker push myusername/myapp:latest

# Push to private registry
docker push registry.example.com/myapp:v1.0
```

---

### `docker rmi` — Remove image(s)

```bash
docker rmi [OPTIONS] IMAGE [IMAGE...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-f, --force` | Force removal of the image |
| `--no-prune` | Do not delete untagged parents |

**Examples:**

```bash
# Remove an image
docker rmi nginx:1.25

# Force remove
docker rmi -f myapp:latest

# Remove all dangling images
docker rmi $(docker images -qf "dangling=true")
```

---

### `docker tag` — Create a tag for an image

```bash
docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
```

**Examples:**

```bash
# Tag for Docker Hub
docker tag myapp:latest myusername/myapp:v1.0

# Tag for private registry
docker tag myapp:latest registry.example.com/myapp:latest
```

---

## Build Commands

### `docker build` — Build image from Dockerfile

```bash
docker build [OPTIONS] PATH | URL | -
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-t, --tag` | Name and optionally tag: `name:tag` |
| `-f, --file` | Name of the Dockerfile (default: `PATH/Dockerfile`) |
| `--build-arg` | Set build-time variables |
| `--no-cache` | Do not use cache when building |
| `--target` | Set the target build stage |
| `--platform` | Set platform if server is multi-platform capable |
| `--progress` | Set type of progress output: `auto`, `plain`, `tty` |
| `--pull` | Always attempt to pull a newer version of the image |

**Examples:**

```bash
# Build with tag
docker build -t myapp:latest .

# Build with custom Dockerfile
docker build -f Dockerfile.prod -t myapp:prod .

# Build with build arguments
docker build --build-arg VERSION=1.0 -t myapp:1.0 .

# Build without cache
docker build --no-cache -t myapp:latest .

# Multi-stage build targeting specific stage
docker build --target production -t myapp:prod .
```

---

### `docker commit` — Create image from container

```bash
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
```

**Examples:**

```bash
# Create image from running container
docker commit my-nginx my-custom-nginx:v1
```

---

## Network Commands

### `docker network ls` — List networks

```bash
docker network ls [OPTIONS]
```

**Examples:**

```bash
docker network ls
```

---

### `docker network create` — Create a network

```bash
docker network create [OPTIONS] NETWORK
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-d, --driver` | Driver to manage the network (default: `bridge`) |
| `--subnet` | Subnet in CIDR format |
| `--gateway` | IPv4 or IPv6 Gateway |

**Examples:**

```bash
# Create bridge network
docker network create my-network

# Create with custom subnet
docker network create --subnet=172.18.0.0/16 my-network
```

---

### `docker network connect` — Connect container to network

```bash
docker network connect [OPTIONS] NETWORK CONTAINER
```

**Examples:**

```bash
docker network connect my-network my-nginx
```

---

### `docker network disconnect` — Disconnect container from network

```bash
docker network disconnect [OPTIONS] NETWORK CONTAINER
```

**Examples:**

```bash
docker network disconnect my-network my-nginx
```

---

### `docker network rm` — Remove network(s)

```bash
docker network rm NETWORK [NETWORK...]
```

**Examples:**

```bash
docker network rm my-network
```

---

## Volume Commands

### `docker volume ls` — List volumes

```bash
docker volume ls [OPTIONS]
```

**Examples:**

```bash
docker volume ls
```

---

### `docker volume create` — Create a volume

```bash
docker volume create [OPTIONS] [VOLUME]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-d, --driver` | Specify volume driver name (default: `local`) |
| `--label` | Set metadata on a volume |

**Examples:**

```bash
# Create named volume
docker volume create my-data

# Create with label
docker volume create --label env=prod my-data
```

---

### `docker volume inspect` — Display volume info

```bash
docker volume inspect [OPTIONS] VOLUME [VOLUME...]
```

**Examples:**

```bash
docker volume inspect my-data
```

---

### `docker volume rm` — Remove volume(s)

```bash
docker volume rm [OPTIONS] VOLUME [VOLUME...]
```

**Examples:**

```bash
docker volume rm my-data
```

---

### `docker volume prune` — Remove all unused volumes

```bash
docker volume prune [OPTIONS]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-f, --force` | Do not prompt for confirmation |

**Examples:**

```bash
docker volume prune
```

---

## Docker Compose

### `docker compose up` — Create and start containers

```bash
docker compose up [OPTIONS] [SERVICE...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-d, --detach` | Run in background |
| `--build` | Build images before starting containers |
| `--force-recreate` | Recreate containers even if config hasn't changed |
| `--no-deps` | Don't start linked services |
| `--scale` | Scale SERVICE to NUM instances (e.g., `--scale web=3`) |

**Examples:**

```bash
# Start all services
docker compose up

# Start in background
docker compose up -d

# Build and start
docker compose up --build

# Scale a service
docker compose up --scale web=3
```

---

### `docker compose down` — Stop and remove containers

```bash
docker compose down [OPTIONS]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-v, --volumes` | Remove named volumes declared in `volumes` section |
| `--remove-orphans` | Remove containers for services not defined in Compose file |

**Examples:**

```bash
# Stop and remove containers
docker compose down

# Also remove volumes
docker compose down -v
```

---

### `docker compose ps` — List containers

```bash
docker compose ps [OPTIONS]
```

**Examples:**

```bash
docker compose ps
```

---

### `docker compose logs` — View output from containers

```bash
docker compose logs [OPTIONS] [SERVICE...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-f, --follow` | Follow log output |
| `--tail` | Number of lines to show from the end |

**Examples:**

```bash
# View all logs
docker compose logs

# Follow logs for specific service
docker compose logs -f web
```

---

### `docker compose exec` — Execute command in running service

```bash
docker compose exec [OPTIONS] SERVICE COMMAND [ARGS...]
```

**Examples:**

```bash
# Get shell in web service
docker compose exec web /bin/bash

# Run database command
docker compose exec db psql -U postgres
```

---

### `docker compose build` — Build or rebuild services

```bash
docker compose build [OPTIONS] [SERVICE...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `--no-cache` | Do not use cache when building |
| `--pull` | Always attempt to pull newer version of the image |

**Examples:**

```bash
# Build all services
docker compose build

# Build specific service without cache
docker compose build --no-cache web
```

---

## System & Cleanup

### `docker system df` — Show Docker disk usage

```bash
docker system df [OPTIONS]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-v, --verbose` | Show detailed information |

**Examples:**

```bash
docker system df
docker system df -v
```

---

### `docker system prune` — Remove unused data

```bash
docker system prune [OPTIONS]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-a, --all` | Remove all unused images, not just dangling ones |
| `-f, --force` | Do not prompt for confirmation |
| `--volumes` | Prune volumes |

**Examples:**

```bash
# Remove stopped containers, unused networks, dangling images
docker system prune

# Remove everything unused (aggressive cleanup)
docker system prune -a --volumes
```

---

### `docker container prune` — Remove stopped containers

```bash
docker container prune [OPTIONS]
```

**Examples:**

```bash
docker container prune
```

---

### `docker image prune` — Remove unused images

```bash
docker image prune [OPTIONS]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-a, --all` | Remove all unused images |

**Examples:**

```bash
# Remove dangling images
docker image prune

# Remove all unused images
docker image prune -a
```

---

## Logs & Debugging

### `docker stats` — Display live resource usage statistics

```bash
docker stats [OPTIONS] [CONTAINER...]
```

**Common flags:**

| Flag | Description |
|------|-------------|
| `-a, --all` | Show all containers (default shows just running) |
| `--no-stream` | Disable streaming stats and only pull the first result |

**Examples:**

```bash
# Monitor all running containers
docker stats

# Monitor specific container
docker stats my-nginx
```

---

### `docker top` — Display running processes in container

```bash
docker top CONTAINER [ps OPTIONS]
```

**Examples:**

```bash
docker top my-nginx
```

---

### `docker cp` — Copy files between container and host

```bash
docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH
docker cp [OPTIONS] SRC_PATH CONTAINER:DEST_PATH
```

**Examples:**

```bash
# Copy from container to host
docker cp my-nginx:/etc/nginx/nginx.conf ./nginx.conf

# Copy from host to container
docker cp ./app.conf my-nginx:/etc/nginx/conf.d/
```

---

### `docker diff` — Inspect changes to files in container

```bash
docker diff CONTAINER
```

**Examples:**

```bash
docker diff my-nginx
```

---

### `docker events` — Get real-time events from server

```bash
docker events [OPTIONS]
```

**Examples:**

```bash
# Stream all events
docker events

# Filter events
docker events --filter event=start
```

---

### `docker port` — List port mappings

```bash
docker port CONTAINER [PRIVATE_PORT[/PROTO]]
```

**Examples:**

```bash
docker port my-nginx
```

---

## Quick Tips

### Combining Commands

```bash
# Stop and remove all containers
docker stop $(docker ps -q) && docker rm $(docker ps -aq)

# Remove all images
docker rmi $(docker images -q)

# Stop containers matching a pattern
docker ps --filter "name=test-" -q | xargs docker stop

# Follow logs of multiple containers
docker logs -f container1 & docker logs -f container2
```

---

### SELinux Volume Mounting (Fedora/RHEL)

When mounting volumes on SELinux systems, add `:z` or `:Z`:

- `:z` — Shared volume (multiple containers can use it)
- `:Z` — Private volume (only this container can use it)

```bash
docker run -v /host/path:/container/path:Z myapp
```

---

### Health Checks

Add health checks in Dockerfile:

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

---

### Resource Limits

```bash
# Limit memory and CPU
docker run --memory=512m --cpus=1.5 myapp

# Set memory reservation (soft limit)
docker run --memory=512m --memory-reservation=256m myapp
```

---

**End of reference.**
