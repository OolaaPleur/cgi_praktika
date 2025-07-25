FROM debian:latest AS build-env

# Install flutter dependencies
RUN apt-get update && \
    apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 && \
    apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

ENV TAR_OPTIONS="--no-same-owner"

# Run flutter doctor
RUN flutter doctor

# Enable flutter web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Copy files to container and build
WORKDIR /app
COPY . .
RUN flutter pub get
RUN flutter build web

# Stage 2 - Create the run-time image
FROM nginx:stable-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 