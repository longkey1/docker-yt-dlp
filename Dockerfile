FROM debian:stable

# Fix frontend not set error
ARG DEBIAN_FRONTEND=noninteractive

# Update apt packages
RUN apt-get -y update

# Install gosu
RUN apt-get install -y --no-install-recommends gosu

# Make working directory
ENV WORK_DIR=/work
RUN mkdir ${WORK_DIR}

# Set Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Install depended packages for yt-dlp
RUN apt-get install -y --no-install-recommends curl ca-certificates  python3 ffmpeg unzip

# Install deno
# https://github.com/denoland/deno_install
ENV DENO_INSTALL=/usr/local
RUN curl -fsSL https://deno.land/x/install/install.sh | sh
RUN chmod 0755 /usr/local/bin/deno
RUN deno --version

# Install yt-dlp
# https://github.com/yt-dlp/yt-dlp#installation
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
RUN chmod 0755 /usr/local/bin/yt-dlp
RUN yt-dlp --version
