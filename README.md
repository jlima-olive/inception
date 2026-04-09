*This project has been created as part of the 42 curriculum by jlima-so.*

# Inception

## Description

Inception is a System Administration project focused on containerization using Docker.

In this project we use Docker to run isolate services, this aproach streamlines deployment and facilitates development.
All services are built from custom Dockerfiles, without using pre-built images as required by the subject.

Services used:
- NGINX (with TLS)
- WordPress (with PHP-FPM)
- MariaDB (database)

All services communicate through a Docker network and use volumes for data persistence.

---

## Instructions

### Requirements
- Linux (Ubunto is recommended)
- Docker
- Docker Compose
- Make

### Setup

```bash
git clone <repo>
cd inception
make
```

### Access

- Website: https://`<login>`.42.fr
- WordPress Admin: https://`<login>`.42.fr/wp-admin

---

Each service runs in its own container and is built from a custom Dockerfile, as required by the project subject.

### Services

- **NGINX:**
  - Handles HTTPS requests (TLSv1.2 TLSv1.3)
  - Acts as a reverse proxy
  - Only exposed service (port 443)

- **WordPress:**
  - Runs with PHP-FPM (fast process manager)
  - Connects to MariaDB
  - Listens for HTTP requests via NGINX (listens via port 9000 inside docker network)
 
- **MariaDB:**
  - Stores WordPress database (listens via port 3306 inside docker network)
  - Internal service (not exposed)

---

### Networking

- All containers are connected through a custom Docker network, allowing secure internal communication.
- Only NGINX is exposed to the outside world (via port 443).

---

### Volumes

Volumes are used to store data that is persistent Data handled by the Docker engine: 

```bash
/home/<login>/data/
```

- mariadb > database files  
- wordpress > website files  

---

## Design Choices

### Virtual Machines vs Docker

- Virtual machine virtualize hardware and run full operating systems which makes them them a lot hevier and slower to start.

- Docker doesnt virtualize hardware, it simply runs the operating system of choosing using the hosts kernal making them a lot more lightweight and portable.

### Docker Network vs Host Network

- A Docker network works in a isolated environment between containers making them a lot more secure then using an external network. 

- The host network on the other hand exposes every service to the outside word making them more prone to security breeches

---

## Resources

- Docker Documentation — https://docs.docker.com/
- Docker Compose — https://docs.docker.com/compose/
- NGINX Documentation — https://nginx.org/en/docs/
- WordPress Documentation — https://wordpress.org/documentation/
- MariaDB Documentation — https://mariadb.org/documentation/

