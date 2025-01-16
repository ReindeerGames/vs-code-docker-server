# VS Code Docker Server

## Overview
The VS Code Docker Server provides a lightweight, containerized development environment. It can be used to easily manage files for applications like WordPress (plugin development) or Minecraft servers (config management). The server runs a VS Code instance, enabling you to edit files within the container directly through your browser.

## Features
- Preinstalled with:
  - PHP 8.1 and necessary extensions for WordPress development
  - Composer (PHP dependency manager)
  - WP-CLI (WordPress Command Line Interface)
  - Node.js 20.x and npm for JavaScript/plugin development
  - Common utilities like git, nano, vim, curl, and unzip
- Lightweight Ubuntu 20.04 base image
- Ready for integration with Docker Compose and other stacks

## Installation

### Prerequisites
- Docker and Docker Compose installed on your host machine.

### Steps
1. Clone this repository:
   ```bash
   git clone https://github.com/ReindeerGames/vs-code-docker-server.git
   cd vs-code-docker-server
   ```

2. Build the Docker image:
   ```bash
   docker build -t vs-code-server .
   ```

3. Run the container:
   ```bash
   docker run -d \
     --name code-server \
     -p 8080:8080 \
     -v /path/to/your/project:/workspace \
     vs-code-server
   ```

4. Access the VS Code server in your browser at `http://localhost:8080`.

## Usage with Docker Compose

Create a `docker-compose.yml` file:

```yaml
services:
  code-server:
    build: .
    container_name: code-server
    ports:
      - "8080:8080"
    volumes:
      - ./workspace:/workspace
    stdin_open: true
    tty: true
```

Start the stack:
```bash
docker compose up -d
```

## Example Use Cases

### WordPress Plugin Development
- Bind the WordPress plugins folder to the container's workspace.
- Use preinstalled PHP tools, Composer, and WP-CLI to develop and test plugins efficiently.

### Minecraft Server Configuration
- Bind the Minecraft server configuration files to the container.
- Edit and manage files directly via the VS Code server.

## Environment Variables
- `DEBIAN_FRONTEND=noninteractive` - For non-interactive installations during the build.

## Contributing
Feel free to fork this repository, submit issues, or create pull requests. Contributions are always welcome!

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.
# vs-code-docker-server
