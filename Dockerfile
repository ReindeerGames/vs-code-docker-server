# Use a base Ubuntu image
FROM ubuntu:20.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    ca-certificates \
    lsb-release \
    wget \
    sudo \
    unzip \
    bash \
    software-properties-common \
    git \
    nano \
    vim \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Install PHP and necessary extensions for WordPress
RUN add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y \
    php8.1 \
    php8.1-cli \
    php8.1-curl \
    php8.1-mbstring \
    php8.1-xml \
    php8.1-zip \
    php8.1-mysql \
    php8.1-gd \
    php8.1-intl \
    php8.1-soap \
    php8.1-readline \
    php8.1-bcmath \
    && apt-get clean

# Install Composer (PHP dependency manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WP-CLI (WordPress Command Line Interface)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Install Node.js 20.x and npm for JavaScript/WordPress plugin development
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm

# Install code-server (VS Code in the browser)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install WordPress-specific tools and utilities
RUN npm install -g gulp-cli eslint prettier sass \
    && composer global require wp-cli/wp-cli-bundle

# Add Composer's global bin directory to the PATH
ENV PATH="/root/.composer/vendor/bin:$PATH"

# Create workspace directory
WORKDIR /workspace

# Expose the port for code-server (default: 8080)
EXPOSE 8080

# Run code-server as root
CMD ["/usr/bin/code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password", "/workspace"]

