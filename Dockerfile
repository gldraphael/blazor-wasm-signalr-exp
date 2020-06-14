# ############################################
# Install .NET Core Runtime Dependencies
# See: https://github.com/dotnet/dotnet-docker/blob/f670f29d19a60de82afc486ee5ea2d813371fa39/5.0/runtime-deps/alpine3.12/amd64/Dockerfile
# ############################################
FROM caddy:2.0.0-alpine AS server-base
RUN apk add --no-cache \
    ca-certificates \
    \
# .NET Core dependencies
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    zlib

# Configure web servers to bind to port 80 when present
ENV ASPNETCORE_URLS=http://+:80
# Enable detection of running in a container
ENV DOTNET_RUNNING_IN_CONTAINER=true
# Set the invariant mode since icu_libs isn't included (see https://github.com/dotnet/announcements/issues/20)
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true


# ############################################
# Build the WASM App
# ############################################
FROM mcr.microsoft.com/dotnet/core/sdk:3.1.300 AS wasm-build-env

WORKDIR /wasmapp
COPY ./Shared ..
COPY ./WasmApp ./
RUN dotnet publish -c Release -o out

# ############################################
# Build the Web App
# ############################################
FROM mcr.microsoft.com/dotnet/nightly/sdk:5.0.100-preview.5-alpine3.11 AS api-build-env

WORKDIR /webapp
COPY ./Shared ..
COPY ./WebApp ./
RUN dotnet publish -r linux-musl-x64 --self-contained true -c Release -o out

# ############################################
# Build CSS
# ############################################
FROM node:lts-alpine3.12 AS css-build-env

WORKDIR /src
COPY ./WasmApp/package.json ./package.json
COPY ./WasmApp/package-lock.json ./package-lock.json
RUN npm install
COPY ./WasmApp .
RUN npm run build-css


# ############################################
# Copy publish files over
# And start the server app
# ############################################
FROM server-base AS FINAL
ENV ENV ASPNETCORE_URLS=http://+:8080

COPY Caddyfile /etc/caddy
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

WORKDIR /www/wasmapp
COPY --from=wasm-build-env /wasmapp/out/wwwroot .
COPY --from=css-build-env /src/wwwroot/dist ./dist

WORKDIR /www/webapp
COPY --from=api-build-env /webapp/out .

CMD ["sh", "/app/run.sh"]
